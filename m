Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09477733E
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 10:45:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU1Gt-0000cJ-VH; Thu, 10 Aug 2023 04:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU1Gs-0000c5-LD
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 04:43:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU1Gp-0000uq-Ci
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 04:43:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe5eb84d43so5800755e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691657027; x=1692261827;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYlno0Qysv06qg797PC8P7WlsTHPxqGkPdrkdW0B5gE=;
 b=rtFmKraxmHr5E4t1n9gW8/GI+JFCarHwwVuKabehUz0UdyDT8rQ6oWEG3+K0rx6PRP
 vc9SMQYQrBJ4FMdssa7XYrlsvYMykOpZZaeI+RtoVBXSOrfh/D/hzIvFN8qcBlrwPF3i
 EFvzd2A5htDydrTySJCCdLJMdRNLW2i5tU2JqmHmqxvm/gCSv1KZopdpqBNIuwvlSKpE
 Waud94J3SprKpEUg1Fym3Mw6b6qBPIJa0QZb3s9TR9H2hSvyTujjPC5lTHfXANheNcbU
 xgETgEDqjvqBcnAODhluyONiHj1t39zq2QSB4DAiH/wM68MkEi2PAUpJjD2Em0XFqcxS
 eJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691657027; x=1692261827;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lYlno0Qysv06qg797PC8P7WlsTHPxqGkPdrkdW0B5gE=;
 b=bK7PRD41byQMpg7fQmPiTqDIDc0wuxislDPWTxdmustaew3p/aUuFmyo2bzvmWW+7v
 iwQ2lzcG1P8NpUdTjNK2oxWXj0Z3lkzEppIWLeY3dLElomIudyn9evty0kS5nt+W0sew
 jeni0IDblRGxYp7TUZ77Xw+JTJUeYzZN+MkpaAjuoVpZP9Q2Yoh4aLcx7oZOmB2a1P+F
 wIWhjwdXLpeRchLv2Q4i9qIkKkGiIqJM5iW++fifrtbrwojWPqrTvSp75VcdwlrULUPK
 UgTBSOHCNlX6zjoZ38PJIeGPPTNhyGkyoZBI9XdOqVkuMpzn0Iuz/HdZFK+oUHoptRR/
 2/Cw==
X-Gm-Message-State: AOJu0YzICtSN+Ai49UNlMuG828WA6ivIVnvPQBM15o00Vry2MCbqPnvG
 5MPrUQj01qtuI7uaCbCgB6SrFA==
X-Google-Smtp-Source: AGHT+IFdJSJkNWvWUdoLy6vyUGqH6DzMouRcYs3LGMtHyZEdc9kgbHc6K0dPXJ1ju9nAgZb2DipoRg==
X-Received: by 2002:a1c:7c17:0:b0:3fb:9ef1:34ef with SMTP id
 x23-20020a1c7c17000000b003fb9ef134efmr1468509wmc.37.1691657027419; 
 Thu, 10 Aug 2023 01:43:47 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a7bc7c5000000b003fbe4cecc3bsm4277936wmk.16.2023.08.10.01.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 01:43:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 87B101FFBB;
 Thu, 10 Aug 2023 09:43:46 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-2-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC v4 01/11] build: Implement logic for sharing
 cross-building config files
Date: Thu, 10 Aug 2023 09:41:55 +0100
In-reply-to: <20230808141739.3110740-2-fufuyqqqqqq@gmail.com>
Message-ID: <87v8dn2sot.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
<snip>
>=20=20
> +      # get the interpreter prefix and the path of libnative required fo=
r native call tests
> +      if [ -d "/usr/$(echo "$target_cc" | sed 's/-gcc//')" ]; then
> +          echo "LD_PREFIX=3D/usr/$(echo "$target_cc" | sed 's/-gcc//')" =
>> "$config_target_mak"
> +      fi
> +

We need some gating and testing here because for mips on my system we
fallback to docker:

  cat tests/tcg/mips-linux-user/config-target.mak
  # Automatically generated by configure - do not modify
  TARGET_NAME=3Dmips
  TARGET=3Dmips-linux-user
  EXTRA_CFLAGS=3D
  CC=3D/home/alex/lsrc/qemu.git/builds/debug/pyvenv/bin/python3 -B /home/al=
ex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc mips-linux-=
gnu-gcc -i qemu/debian-mips-cross -s /home/alex/lsrc/qemu.git --
  CCAS=3D/home/alex/lsrc/qemu.git/builds/debug/pyvenv/bin/python3 -B /home/=
alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc mips-linu=
x-gnu-gcc -i qemu/debian-mips-cross -s /home/alex/lsrc/qemu.git --
  AR=3D/home/alex/lsrc/qemu.git/builds/debug/pyvenv/bin/python3 -B /home/al=
ex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc mips-linux-=
gnu-ar -i qemu/debian-mips-cross -s /home/alex/lsrc/qemu.git --
  AS=3D/home/alex/lsrc/qemu.git/builds/debug/pyvenv/bin/python3 -B /home/al=
ex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc mips-linux-=
gnu-as -i qemu/debian-mips-cross -s /home/alex/lsrc/qemu.git --
  LD=3D/home/alex/lsrc/qemu.git/builds/debug/pyvenv/bin/python3 -B /home/al=
ex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc mips-linux-=
gnu-ld -i qemu/debian-mips-cross -s /home/alex/lsrc/qemu.git --
  NM=3D/home/alex/lsrc/qemu.git/builds/debug/pyvenv/bin/python3 -B /home/al=
ex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc mips-linux-=
gnu-nm -i qemu/debian-mips-cross -s /home/alex/lsrc/qemu.git --
  OBJCOPY=3D/home/alex/lsrc/qemu.git/builds/debug/pyvenv/bin/python3 -B /ho=
me/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc mips-l=
inux-gnu-objcopy -i qemu/debian-mips-cross -s /home/alex/lsrc/qemu.git --
  RANLIB=3D/home/alex/lsrc/qemu.git/builds/debug/pyvenv/bin/python3 -B /hom=
e/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc mips-li=
nux-gnu-ranlib -i qemu/debian-mips-cross -s /home/alex/lsrc/qemu.git --
  STRIP=3D/home/alex/lsrc/qemu.git/builds/debug/pyvenv/bin/python3 -B /home=
/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc mips-lin=
ux-gnu-strip -i qemu/debian-mips-cross -s /home/alex/lsrc/qemu.git --
  BUILD_STATIC=3Dy
  QEMU=3D/home/alex/lsrc/qemu.git/builds/debug/qemu-mips
  LD_PREFIX=3D/usr/
  HOST_GDB_SUPPORTS_ARCH=3Dy
  LIBNATIVE=3D/home/alex/lsrc/qemu.git/builds/debug/common-user/native/mips=
-linux-user/libnative.so

but still set LD_PREFIX. We should at least check there is some sort of
ld.so in the LD_PREFIX path to indicate the loader is available.


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

