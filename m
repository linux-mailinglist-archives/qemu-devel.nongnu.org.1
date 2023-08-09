Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5056D7762FE
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 16:50:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkV4-0006jz-3p; Wed, 09 Aug 2023 10:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTkV2-0006jo-Oo
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 10:49:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTkV0-0003Z9-8i
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 10:49:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe1d9a8ec6so5840145e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691592560; x=1692197360;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9tOZ5fZzv3iK3StlXX8nr3pSzppy/rv6tGdwfRP2Y8=;
 b=TNg2+EN4c/UI7F/89EUV1Z5VxFJTa3O/nA2+MKIvtOueijlm26pDbDTwPcOqh/mu/v
 bEoiSNzSmv8Ub6cucYSJ9P3BVotDm7MtpMPk9V1JlSFG1TaHMO1wM/qcFKoLvPLQDZFs
 dWhcKIFaIFeFp9FqpS/JGfFPFlLAp8tAKRpcdUFHMGmKZ4rcACseDULiVcuKXv6OVgzw
 9k/bvmpzQLmKI/E0OvIOLV0a+CkLL1F3PZMA7TYKzQn6epG8eue5hnfxALjoUXwfeQgb
 aq5GP1m6FXS3Gxr0eVgODgckneDVb7BHOG5GZt/KSVaHY6Q9ZqGsuaxLbMXp12VSmOam
 LluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691592560; x=1692197360;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I9tOZ5fZzv3iK3StlXX8nr3pSzppy/rv6tGdwfRP2Y8=;
 b=krhWZyOAvhQLSjNyJj+tQlHVEj/DkS/gDZAGua90Y+RzysHuNLR4ug7B6VLsBnCcSK
 N1TSJuTCNsFzba+//JAUgrQI9NvmxQHUGi1pudTkBLBOJ9CtRvyIsIlNSxYvh90SBzKQ
 j5W0rJbAynRIhtoxypBFHccvUaQuGpDNFnkBTJFlv0ot3xds12MNg/nAANIp1lb5PDMs
 0qSFxm0+KQng9ZOGbJg1SB9UquhWX8PbCHDlIgEb9HjyLWzdSWCYcnmllHivCESEHich
 uXB71+JqU3JDwWTkYjdF5vxJ6J9Wpm4UboMXH5xD562qJrg8ZRrQcaZfa6OmGzESFn91
 ax8Q==
X-Gm-Message-State: AOJu0YxBUcxDMRpXjXchYos2SiBwAhvJq7q8EI5dPx/aaskVAvoWlJCq
 7OBacFyO/xlk9v8EVcO5U3OgCQ==
X-Google-Smtp-Source: AGHT+IHY51pVVlXHwRZ9YlSSK+fIKKZ8mEAtpO9id+dskT6fzBy4Q5wPLti2Wd2/SyIpnoZ2dF+6Tw==
X-Received: by 2002:a05:600c:348d:b0:3fe:2120:eb7c with SMTP id
 a13-20020a05600c348d00b003fe2120eb7cmr11016384wmq.0.1691592560254; 
 Wed, 09 Aug 2023 07:49:20 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a05600c225800b003fc00892c13sm2228527wmm.35.2023.08.09.07.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 07:49:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5CAC01FFBB;
 Wed,  9 Aug 2023 15:49:19 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-2-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC v4 01/11] build: Implement logic for sharing
 cross-building config files
Date: Wed, 09 Aug 2023 15:42:02 +0100
In-reply-to: <20230808141739.3110740-2-fufuyqqqqqq@gmail.com>
Message-ID: <871qgc5l00.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
>  configure | 57 +++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 23 deletions(-)
>
> diff --git a/configure b/configure
> index 2b41c49c0d..a076583141 100755
> --- a/configure
> +++ b/configure
> @@ -1751,56 +1751,67 @@ if test "$ccache_cpp2" =3D "yes"; then
>    echo "export CCACHE_CPP2=3Dy" >> $config_host_mak
>  fi
>=20=20
> -# tests/tcg configuration
> -(config_host_mak=3Dtests/tcg/config-host.mak
> -mkdir -p tests/tcg
> -echo "# Automatically generated by configure - do not modify" > $config_=
host_mak
> -echo "SRC_PATH=3D$source_path" >> $config_host_mak
> -echo "HOST_CC=3D$host_cc" >> $config_host_mak
> +# Prepare the config files for cross building.
> +# This process generates 'cross-build/<target>/config-target.mak' files.
> +# These files are then symlinked to the directories that need them which
> +# including the TCG tests (tests/tcg/<target>) and the libnative library
> +# for linux-user (common/native/<target>/).
> +mkdir -p cross-build
>=20=20
> -# versioned checked in the main config_host.mak above
> -if test -n "$gdb_bin"; then
> -    echo "HAVE_GDB_BIN=3D$gdb_bin" >> $config_host_mak
> -fi
> -if test "$plugins" =3D "yes" ; then
> -    echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
> -fi

I think there is a merge conflict here because a bunch of the
config-host.mak output has been squashed. This disabled plugins and gdb
testing.

> -
> -tcg_tests_targets=3D
>  for target in $target_list; do
>    arch=3D${target%%-*}
> -
>    case $target in
>      xtensa*-linux-user)
> -      # the toolchain is not complete with headers, only build softmmu t=
ests
> +      # the toolchain for tests/tcg is not complete with headers
>        continue
>        ;;
>      *-softmmu)
> -      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || =
continue

We still want to skip linking tests/tcg/foo-softmmu/config-target.mak
when there are no softmmu tests to build (only a few targets currently
have softmmu tests). I think this is triggering failures like:

  =E2=9E=9C  make run-tcg-tests-m68k-softmmu V=3D1
  make -C tests/tcg/m68k-softmmu=20
  make[1]: Entering directory '/home/alex/lsrc/qemu.git/builds/all/tests/tc=
g/m68k-softmmu'
  make[1]: Nothing to be done for 'all'.
  make[1]: Leaving directory '/home/alex/lsrc/qemu.git/builds/all/tests/tcg=
/m68k-softmmu'
  make -C tests/tcg/m68k-softmmu  SPEED=3Dquick run
  make[1]: Entering directory '/home/alex/lsrc/qemu.git/builds/all/tests/tc=
g/m68k-softmmu'
  make[1]: *** No rule to make target 'hello', needed by 'run-plugin-hello-=
with-libbb.so'.  Stop.
  make[1]: Leaving directory '/home/alex/lsrc/qemu.git/builds/all/tests/tcg=
/m68k-softmmu'
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:56: run-tcg-te=
sts-m68k-softmmu] Erro

>        qemu=3D"qemu-system-$arch"
>        ;;
>      *-linux-user|*-bsd-user)
>        qemu=3D"qemu-$arch"
>        ;;
>    esac
> -
>    if probe_target_compiler $target || test -n "$container_image"; then
>        test -n "$container_image" && build_static=3Dy
> -      mkdir -p "tests/tcg/$target"
> -      config_target_mak=3Dtests/tcg/$target/config-target.mak
> -      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target=
/Makefile"
> +      mkdir -p "cross-build/$target"
> +      config_target_mak=3Dcross-build/$target/config-target.mak
>        echo "# Automatically generated by configure - do not modify" > "$=
config_target_mak"
>        echo "TARGET_NAME=3D$arch" >> "$config_target_mak"
>        echo "TARGET=3D$target" >> "$config_target_mak"
> -      write_target_makefile "build-tcg-tests-$target" >> "$config_target=
_mak"
> +      write_target_makefile "$target" >> "$config_target_mak"
>        echo "BUILD_STATIC=3D$build_static" >> "$config_target_mak"
>        echo "QEMU=3D$PWD/$qemu" >> "$config_target_mak"
>=20=20
> +      # get the interpreter prefix and the path of libnative required fo=
r native call tests
> +      if [ -d "/usr/$(echo "$target_cc" | sed 's/-gcc//')" ]; then
> +          echo "LD_PREFIX=3D/usr/$(echo "$target_cc" | sed 's/-gcc//')" =
>> "$config_target_mak"
> +      fi
> +

We should only emit LD_PREFIX for -user targets.

>        # will GDB work with these binaries?
>        if test "${gdb_arches#*$arch}" !=3D "$gdb_arches"; then
>            echo "HOST_GDB_SUPPORTS_ARCH=3Dy" >> "$config_target_mak"
>        fi
> +  fi
> +done
> +
> +# tests/tcg configuration
> +(mkdir -p tests/tcg
> +# create a symlink to the config-host.mak file in the tests/tcg
> +ln -srf $config_host_mak tests/tcg/config-host.mak
> +
> +tcg_tests_targets=3D
> +for target in $target_list; do
> +  case $target in
> +    *-softmmu)
> +      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || =
continue
> +      ;;
> +  esac
>=20=20
> +  if test -f cross-build/$target/config-target.mak; then
> +      mkdir -p "tests/tcg/$target"
> +      ln -srf cross-build/$target/config-target.mak tests/tcg/$target/co=
nfig-target.mak
> +      ln -sf $source_path/tests/tcg/Makefile.target tests/tcg/$target/Ma=
kefile
>        echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
>        tcg_tests_targets=3D"$tcg_tests_targets $target"
>    fi


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

