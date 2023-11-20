Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A87F1082
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 11:36:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r51ct-0003Zp-Pf; Mon, 20 Nov 2023 05:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r51cq-0003ZZ-B4
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 05:35:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r51co-00052z-IP
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 05:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700476528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5P8NnPmPndcXBJrSdvzpNYk/pDbkdkR/mOtUFJqvic=;
 b=ZmWGKKg0zryRuyj3Yfu/BkJf0EUMJ1ir+o2To0ZV5RFdYxnOXnW9c66XPI0tGEwVmDbQgW
 EhbhWSCQ25x9Js2cKFszCNr3CMVXHM1JpjxiG9h7aKIiit5+8YV8RvBkkGEGC9UizlZsSd
 /yVg0A3ZWHklr0RWtmKf9uab6CHXQQ0=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-m76Zg8XLMvGwv1yGVaEhkg-1; Mon, 20 Nov 2023 05:35:26 -0500
X-MC-Unique: m76Zg8XLMvGwv1yGVaEhkg-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7c410725a6cso114528241.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 02:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700476526; x=1701081326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5P8NnPmPndcXBJrSdvzpNYk/pDbkdkR/mOtUFJqvic=;
 b=KfT7RPI+WjKeDn0Cxhjxe7FZuM5lSwv15v7lOnnxLiAfomUSlZAQBCP4RD0h5Tebi2
 mcDcQyjw3MG9NUGkKzTfqLLTAcH+DZ35lzl7+q9kZH41w/HceBAv2vmLyflb0OPZ174N
 qG3D/BZrEvp4Cw94YVFzSHJDEnEFAbLv6t+4khm2rC+vK32y0oZxhjf0yPXh2p18RzzQ
 hqQqN0D7HZ/O553I/R+7Zt3BWbPDWV9Ox38YNxkOBNIO7j6YI7neJJHfbxn6hzvnhR7U
 HO1HYHZ20WjNAtDhTdy5fu8KmyQRXpx2ZmwmRMnKMiPgBp+PfxDbYoGCqPTRkNANYFsY
 EiPA==
X-Gm-Message-State: AOJu0Yx4fQNdLAVOvP5hZeQMK6YQ5JPIUiJPjKQQNlorg6fKcxXzm/Jw
 Quke/bVe6MhV39FcH7H8GR9sQHRsiazkryldFDQV8WSFXgnNmJJEEl7PGNkFNz5fAI9TSol/fmq
 HLGFH+6mCt7b/khAY32RbmjVuEEgUDNI=
X-Received: by 2002:a1f:4c81:0:b0:4ac:593b:e9f4 with SMTP id
 z123-20020a1f4c81000000b004ac593be9f4mr4972922vka.9.1700476525994; 
 Mon, 20 Nov 2023 02:35:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIS+Z+vM5Bs7Dzs2ahQukYhGV8cPRg85/YHw5vUMANJeNFNns8m5Juat47973uzS5MQDCPlxN8J7ByqRXPI5Y=
X-Received: by 2002:a1f:4c81:0:b0:4ac:593b:e9f4 with SMTP id
 z123-20020a1f4c81000000b004ac593be9f4mr4972907vka.9.1700476525682; Mon, 20
 Nov 2023 02:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20231116172820.2481604-1-alex.bennee@linaro.org>
In-Reply-To: <20231116172820.2481604-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 Nov 2023 11:35:11 +0100
Message-ID: <CABgObfZhwXrqCSY1ixjmktJJsDqbjwta0nR4cZSO_pFTQe_Www@mail.gmail.com>
Subject: Re: [RFC PATCH] configure: don't try a "native" cross for i386
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Nov 16, 2023 at 6:28=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> As 32 bit x86 become rarer we are starting to run into problems with
> search paths. Although we switched to a Debian container we still
> favour the native CC on a Bookworm host. As a result we have a broken
> cross compile setup which then fails to build with:
>
>     BUILD   i386-linux-user guest-tests
>   In file included from /usr/include/linux/stat.h:5,
>                    from /usr/include/bits/statx.h:31,
>                    from /usr/include/sys/stat.h:465,
>                    from /home/alex/lsrc/qemu.git/tests/tcg/multiarch/linu=
x/linux-test.c:28:
>   /usr/include/linux/types.h:5:10: fatal error: asm/types.h: No such file=
 or directory
>       5 | #include <asm/types.h>
>         |          ^~~~~~~~~~~~~
>   compilation terminated.
>   make[1]: *** [Makefile:119: linux-test] Error 1
>   make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:50: build-tc=
g-tests-i386-linux-user] Error 2
>
> So lets stop trying to be cute and honour cross_prefix_i386 when
> searching locally. We also need to ensure we are using the correct
> prefix if we do end up using the container version. We can also drop
> the extra CFLAGS while we are at it.

This is a good idea for linux-user, and I would extend it to all
cases, but please don't do it for softmmu because it would break
building SeaBIOS and the boot ROMs with the system compiler.

As the above error shows, the issue is caused by incompatibilities
between the 32- and 64-bit Linux headers, and it does not apply to
freestanding environments used when building the firmware blobs and
the softmmu targets in tests/tcg .

Paolo


Paolo

> Fixes: 791e6fedc5 (tests/docker: replace fedora-i386 with debian-i686)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  configure | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/configure b/configure
> index 5e7b76e3a1..2343d629ec 100755
> --- a/configure
> +++ b/configure
> @@ -1190,7 +1190,6 @@ fi
>  : ${cross_cc_cflags_armeb=3D"-mbig-endian"}
>  : ${cross_cc_hexagon=3D"hexagon-unknown-linux-musl-clang"}
>  : ${cross_cc_cflags_hexagon=3D"-mv73 -O2 -static"}
> -: ${cross_cc_cflags_i386=3D"-m32"}
>  : ${cross_cc_cflags_ppc=3D"-m32 -mbig-endian"}
>  : ${cross_cc_cflags_ppc64=3D"-m64 -mbig-endian"}
>  : ${cross_cc_ppc64le=3D"$cross_cc_ppc64"}
> @@ -1308,7 +1307,7 @@ probe_target_compiler() {
>          ;;
>        i386)
>          container_image=3Ddebian-i686-cross
> -        container_cross_prefix=3D
> +        container_cross_prefix=3Di686-linux-gnu-
>          ;;
>        loongarch64)
>          container_image=3Ddebian-loongarch-cross
> @@ -1394,7 +1393,6 @@ probe_target_compiler() {
>    case "$target_arch:$cpu" in
>      aarch64_be:aarch64 | \
>      armeb:arm | \
> -    i386:x86_64 | \
>      mips*:mips64 | \
>      ppc*:ppc64 | \
>      sparc:sparc64 | \
> --
> 2.39.2
>


