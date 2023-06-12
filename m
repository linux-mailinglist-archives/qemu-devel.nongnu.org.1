Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B46C172C3B9
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 14:12:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8gOE-0004uO-Gw; Mon, 12 Jun 2023 08:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q8gOC-0004u5-0P
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 08:11:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q8gO9-000646-MG
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 08:11:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f61530506aso44180915e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686571871; x=1689163871;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6kGIMczd3SC1jW2Vfxh42eZv4qDmQMioMkrhGhOXBE=;
 b=PCIrPPk7IJ7lFoj1p6K7/aFsiTjViLRngS3P/cnnqLektJldOJWy3e6uTvyznorETx
 jJLrF1gQe7Ty4RsVRWu7bbHPa2cQ43CbSEVHPsUt+rhF1N8xR6rPPlbqD0tv679E8rdL
 HtJwoychwiewkTinuiTE05Xbb0CIPmPEohAompMBu8w/qE9prY0fyc35SsmeZWbYjqhV
 ru7dXD9mwvX5tuqceFBz3FaAoixG9RTmYa3mMeD8cNKu62aNHKMRBtjHIv1jko56zwc5
 Yy9jelmQComSAgEkAV2QFLPJGnLhfmd9ORPaKCtZLxXPN4SWvvJUNZlCpVfjl9H0aBcu
 ksUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686571871; x=1689163871;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c6kGIMczd3SC1jW2Vfxh42eZv4qDmQMioMkrhGhOXBE=;
 b=YT+ynVIxUkXcLgqTOWGjc5C1FjGh51XZwsRL2EyE+w4kyvI90s8RyeM0Jb3hw6W20B
 OfZdFcDmdpME68byJOWMIfT1RrbAYcxAigL9lE8nprZVsL76SypMiTQufvTbJA6fIxC5
 9Fw081e9fni71i7/WD19R+CEUQ2lmQ1ZGGge6mXi+dZqJq2/dMFP9rRufcB1EnJ2cDvM
 ym16pDWfi1MU6ZGSfrqumzqjL82oFTEeXrEpjiS8/UKIecY48H6xIO+bvc87z0xjc5eb
 x3ewe0eJX6w06vu7YI59nHKIcjAGCEApJTU89nBcCJ4ZLWFR9br8gOYSuGe+kc+exjEF
 8pYQ==
X-Gm-Message-State: AC+VfDwz32SeQ0JvuYZKNdHs4UxR3UMRU1BnaHlRe4bKJpBzudgLQPD3
 JYuoB8f7iNYHTciUkAzmbAZJRA==
X-Google-Smtp-Source: ACHHUZ5O0eT5VV9b0cSz/0BxvQGuVwdAFdQ7dI8glZkvsCXZ+huL3XYyZcaq8snZUCzL9XK/j0oIvQ==
X-Received: by 2002:a05:600c:2312:b0:3f7:f8d7:cc72 with SMTP id
 18-20020a05600c231200b003f7f8d7cc72mr8061194wmo.27.1686571871539; 
 Mon, 12 Jun 2023 05:11:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a7bcbc6000000b003f6f6a6e769sm11153901wmi.17.2023.06.12.05.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 05:11:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7511C1FFBB;
 Mon, 12 Jun 2023 13:11:10 +0100 (BST)
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
 <20230607164750.829586-2-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Riku Voipio
 <riku.voipio@iki.fi>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC v2 1/6] build: Add configure options for native calls
Date: Mon, 12 Jun 2023 12:54:34 +0100
In-reply-to: <20230607164750.829586-2-fufuyqqqqqq@gmail.com>
Message-ID: <87mt147ue9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  Makefile                            |  4 +++
>  common-user/native/Makefile.include |  9 ++++++
>  common-user/native/Makefile.target  | 22 +++++++++++++
>  configure                           | 50 +++++++++++++++++++++++++++++
>  docs/devel/build-system.rst         |  4 +++
>  meson.build                         |  8 +++++
>  meson_options.txt                   |  2 ++
>  scripts/meson-buildoptions.sh       |  4 +++
>  8 files changed, 103 insertions(+)
>  create mode 100644 common-user/native/Makefile.include
>  create mode 100644 common-user/native/Makefile.target
>
> diff --git a/Makefile b/Makefile
> index 3c7d67142f..923da109bf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -185,6 +185,10 @@ SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory -=
-quiet)
>=20=20
>  include $(SRC_PATH)/tests/Makefile.include
>=20=20
> +ifeq ($(CONFIG_USER_NATIVE),y)
> +	include $(SRC_PATH)/common-user/native/Makefile.include
> +endif
> +
>  all: recurse-all
>=20=20
>  ROMS_RULES=3D$(foreach t, all clean distclean, $(addsuffix /$(t), $(ROMS=
)))
> diff --git a/common-user/native/Makefile.include b/common-user/native/Mak=
efile.include
> new file mode 100644
> index 0000000000..40d20bcd4c
> --- /dev/null
> +++ b/common-user/native/Makefile.include
> @@ -0,0 +1,9 @@
> +.PHONY: build-native
> +build-native: $(NATIVE_TARGETS:%=3Dbuild-native-library-%)
> +$(NATIVE_TARGETS:%=3Dbuild-native-library-%): build-native-library-%:
> +	$(call quiet-command, \
> +	    $(MAKE) -C common-user/native/$* $(SUBDIR_MAKEFLAGS), \
> +	"BUILD","$* native library")
> +# endif
> +
> +all: build-native

I think it would be better if we could add the targets via meson and let
it deal with the multiple versions. I will defer to Paolo on how to do
this though.


> diff --git a/common-user/native/Makefile.target b/common-user/native/Make=
file.target
> new file mode 100644
> index 0000000000..1038367b37
> --- /dev/null
> +++ b/common-user/native/Makefile.target
> @@ -0,0 +1,22 @@
> +# -*- Mode: makefile -*-
> +#
> +# Library for native calls=20
> +#
> +
> +all:
> +-include ../config-host.mak
> +-include config-target.mak
> +
> +CFLAGS+=3D-I$(SRC_PATH)/include -O1 -fPIC -shared -fno-stack-protector
> +LDFLAGS+=3D
> +
> +SRC =3D $(SRC_PATH)/common-user/native/libnative.c
> +TARGET =3D libnative.so
> +
> +all: $(TARGET)
> +
> +$(TARGET): $(SRC)
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> +
> +clean:
> +	rm -f $(TARGET)
> diff --git a/configure b/configure
> index 2a556d14c9..cc94d10c98 100755
> --- a/configure
> +++ b/configure
> @@ -275,6 +275,7 @@ use_containers=3D"yes"
>  gdb_bin=3D$(command -v "gdb-multiarch" || command -v "gdb")
>  gdb_arches=3D""
>  werror=3D""
> +user_native_call=3D"disabled"
>=20=20
>  # Don't accept a target_list environment variable.
>  unset target_list
> @@ -787,6 +788,10 @@ for opt do
>    ;;
>    --disable-vfio-user-server) vfio_user_server=3D"disabled"
>    ;;
> +  --enable-user-native-call) user_native_call=3D"enabled"
> +  ;;
> +  --disable-user-native-call) user_native_call=3D"disabled"
> +  ;;

I'm not sure it's worth the configuration control here. We can embed if
a given frontend has support for native calls in:

  config/targets/FOO-linux-user.mak

and simply add the symbol when each front end is enabled.

>    # everything else has the same name in configure and meson
>    --*) meson_option_parse "$opt" "$optarg"
>    ;;
> @@ -1898,6 +1903,50 @@ if test "$tcg" =3D "enabled"; then
>  fi
>  )
>=20=20
> +# common-user/native configuration
> +native_flag_i386=3D"-DTARGET_I386"
> +native_flag_x86_64=3D"-DTARGET_X86_64"
> +native_flag_mips=3D"-DTARGET_MIPS"
> +native_flag_mips64=3D"-DTARGET_MIPS64"
> +native_flag_arm=3D"-DTARGET_ARM"
> +native_flag_aarch64=3D"-DTARGET_AARCH64"

As we have target names already in the per-target configs we could use
that instead and build the cflags there.

> +
> +(config_host_mak=3Dcommon-user/native/config-host.mak
> +mkdir -p common-user/native
> +echo "# Automatically generated by configure - do not modify" > $config_=
host_mak
> +echo "SRC_PATH=3D$source_path" >> $config_host_mak
> +echo "HOST_CC=3D$host_cc" >> $config_host_mak
> +
> +native_targets=3D
> +for target in $target_list; do
> +  arch=3D${target%%-*}
> +
> +  case $target in
> +    *-linux-user|*-bsd-user)
> +    if probe_target_compiler $target || test -n "$container_image"; then
> +        mkdir -p "common-user/native/$target"
> +        config_target_mak=3Dcommon-user/native/$target/config-target.mak
> +        ln -sf "$source_path/common-user/native/Makefile.target" "common=
-user/native/$target/Makefile"
> +        echo "# Automatically generated by configure - do not modify" > =
"$config_target_mak"
> +        echo "TARGET_NAME=3D$arch" >> "$config_target_mak"
> +        echo "TARGET=3D$target" >> "$config_target_mak"
> +        eval "target_native_flag=3D\${native_flag_$target_arch}"
> +        target_cflags=3D"$target_cflags $target_native_flag"
> +        write_target_makefile "build-native-library-$target" >> "$config=
_target_mak"
> +        native_targets=3D"$native_targets $target"
> +    fi
> +  ;;
> +  esac
> +done

This is basically replicating what we already have in
tests/tcg/FOO-linux-user/config-target.mak. I would suggest moving those
into a common location ($BUILD/targets/foo/compiler.mak) and then fixing
up TCG tests to use the new location. When you add the native libs you
can use the same configs.

> +
> +# if native enabled
> +if test "$user_native_call" =3D "enabled"; then
> +    echo "CONFIG_USER_NATIVE=3Dy" >> config-host.mak
> +    echo "NATIVE_TARGETS=3D$native_targets" >> config-host.mak
> +=20=20=20=20
> +fi
> +)
> +

see above about putting CONFIG_USER_NATIVE directly into the target mak fra=
gments.

>  if test "$skip_meson" =3D no; then
>    cross=3D"config-meson.cross.new"
>    meson_quote() {
> @@ -1980,6 +2029,7 @@ if test "$skip_meson" =3D no; then
>    test "$smbd" !=3D '' && meson_option_add "-Dsmbd=3D$smbd"
>    test "$tcg" !=3D enabled && meson_option_add "-Dtcg=3D$tcg"
>    test "$vfio_user_server" !=3D auto && meson_option_add "-Dvfio_user_se=
rver=3D$vfio_user_server"
> +  test "$user_native_call" !=3D auto && meson_option_add
>    "-Duser_native_call=3D$user_native_call"

and dropping this.

>    run_meson() {
>      NINJA=3D$ninja $meson setup --prefix "$prefix" "$@" $cross_arg "$PWD=
" "$source_path"
>    }
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 551c5a5ac0..05cfa8a21a 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -494,6 +494,10 @@ Built by configure:
>    Configuration variables used to build the firmware and TCG tests,
>    including paths to cross compilation toolchains.
>=20=20
> +``common-user/native/config-host.mak``, ``common-user/native/*/config-ta=
rget.mak``
> +  Configuration variables used to build the native call libraries
> +  including paths to cross compilation toolchains.
> +

Not needed if we re-use the TCG stuff. But remember to update the
section above when moving them.

>  ``pyvenv``
>=20=20
>    A Python virtual environment that is used for all Python code running
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d..04e99a4f25 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2012,6 +2012,11 @@ have_virtfs_proxy_helper =3D get_option('virtfs_pr=
oxy_helper') \
>      .require(libcap_ng.found(), error_message: 'the virtfs proxy helper =
requires libcap-ng') \
>      .allowed()
>=20=20
> +have_user_native_call =3D get_option('user_native_call') \
> +    .require(have_user, error_message: 'user_native_call requires user')=
 \
> +    .require(targetos =3D=3D 'linux', error_message: 'user_native_call r=
equires Linux') \
> +    .allowed()
> +
>  if get_option('block_drv_ro_whitelist') =3D=3D ''
>    config_host_data.set('CONFIG_BDRV_RO_WHITELIST', '')
>  else
> @@ -2853,6 +2858,9 @@ foreach target : target_dirs
>        error('Target @0@ is only available on a Linux host'.format(target=
))
>      endif
>      config_target +=3D { 'CONFIG_LINUX_USER': 'y' }
> +    if have_user_native_call
> +      config_target +=3D { 'CONFIG_USER_NATIVE_CALL': 'y' }
> +    endif

Not needed? Isn't CONFIG_USER_NATIVE an equivalent test?

>    elif target.endswith('bsd-user')
>      if 'CONFIG_BSD' not in config_host
>        if default_targets
> diff --git a/meson_options.txt b/meson_options.txt
> index 90237389e2..57035e02f5 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -352,3 +352,5 @@ option('slirp_smbd', type : 'feature', value : 'auto',
>=20=20
>  option('hexagon_idef_parser', type : 'boolean', value : true,
>         description: 'use idef-parser to automatically generate TCG code =
for the Hexagon frontend')
> +option('user_native_call', type : 'feature', value : 'disabled',
> +       description: 'native bypass for library calls in user mode only')
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 5714fd93d9..9eda1898d6 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -173,6 +173,8 @@ meson_options_help() {
>    printf "%s\n" '  tpm             TPM support'
>    printf "%s\n" '  u2f             U2F emulation support'
>    printf "%s\n" '  usb-redir       libusbredir support'
> +  printf "%s\n" '  user-native-call'
> +  printf "%s\n" '                  native bypass for library calls in us=
er mode only'
>    printf "%s\n" '  vde             vde network backend support'
>    printf "%s\n" '  vdi             vdi image format support'
>    printf "%s\n" '  vduse-blk-export'
> @@ -472,6 +474,8 @@ _meson_option_parse() {
>      --disable-u2f) printf "%s" -Du2f=3Ddisabled ;;
>      --enable-usb-redir) printf "%s" -Dusb_redir=3Denabled ;;
>      --disable-usb-redir) printf "%s" -Dusb_redir=3Ddisabled ;;
> +    --enable-user-native-call) printf "%s" -Duser_native_call=3Denabled =
;;
> +    --disable-user-native-call) printf "%s" -Duser_native_call=3Ddisable=
d ;;
>      --enable-vde) printf "%s" -Dvde=3Denabled ;;
>      --disable-vde) printf "%s" -Dvde=3Ddisabled ;;
>      --enable-vdi) printf "%s" -Dvdi=3Denabled ;;

And then you can drop this.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

