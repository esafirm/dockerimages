FROM esafirm/android:latest

LABEL description="Android SDK 30 & NDK"

ARG CMAKE_VERSION="3.6.4111459"

ENV PATH=$PATH:$ANDROID_HOME/cmake/3.6.4111459/bin/
ENV NDK_HOME $ANDROID_HOME/ndk-bundle

# Install NDK & CMAKE Packages
RUN yes | sdkmanager \
	"cmake;${CMAKE_VERSION}" \
	"ndk-bundle" >/dev/null

# Delete unnecessary NDK Packages
RUN rm -rf  \
	# Delete simpleperf tool
	$NDK_HOME/simpleperf \
	# Delete STL version we don't care about
	$NDK_HOME/sources/cxx-stl/stlport \
	$NDK_HOME/sources/cxx-stl/gnu-libstdc++ \
	# Delete unused prebuild images
	$NDK_HOME/prebuilt/android-mips* \
	# Delete obsolete Android platforms
	$NDK_HOME/platforms/android-9 \
	$NDK_HOME/platforms/android-12 \
	$NDK_HOME/platforms/android-13 \
	$NDK_HOME/platforms/android-15 \
	$NDK_HOME/platforms/android-16 \
	# Delete unused platform sources
	$NDK_HOME/sources/cxx-stl/gnu-libstdc++/4.9/libs/mips* \
	$NDK_HOME/sources/cxx-stl/llvm-libc++/libs/mips* \
	# Delete LLVM STL tests
	$NDK_HOME/sources/cxx-stl/llvm-libc++/test \
	# Delete unused toolchains
	$NDK_HOME/toolchains/mips \
	$NDK_HOME/build/core/toolchains/mips* \
	&& sdkmanager --list | sed -e '/Available Packages/q'