Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE2830937
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:10:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7Xz-0002NQ-E7; Wed, 17 Jan 2024 10:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ7Xq-0002MB-C9
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:09:36 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ7Xo-0004pB-Qu
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:09:34 -0500
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3606e69ec67so72294075ab.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705504171; x=1706108971; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmN1pM6uMA/m5EXIVlDmDX6I/gEs7svgb/HtgHvVu+g=;
 b=Ux5UeU6HoL39ylfk3I18s2lWZ/hP5oAl/DcVXq2ubNozd6KrFDEIbM2Xq4o5xNPsRF
 nYNWijyF7lPFxA0HDgPpRi59zMq1fFEEnGjk0Puxo7WDBVR0kKJCK849RHQCORj7bBSe
 jbOWqRPBvomO18t03sILfPkIha1/leelpUYMN6VJrWDx8akHyfzeIcaZbqRY2m+5h/jF
 xjTrYdFc6jiZb3JoFnLZyzENItYzc/3SFQqK3F6aAmU+YVm5DGhDl4rdwQruCCExyQsq
 Zcb8R9JKOGcr8Igoun1mLgE4rr8jOLJ90hEvMiWMZqk8FAl3cDHBnIrrz89KTZOqikYW
 a3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504171; x=1706108971;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmN1pM6uMA/m5EXIVlDmDX6I/gEs7svgb/HtgHvVu+g=;
 b=qXS3D+LRd/fnW4P3aD3VyIwxrhcUo3H7yCpLimcZCohOlSzTJ6mSFNghosu/iW1PXY
 eTbqhSl6QTDFvaR2tcI2ybeMYLrA4dXx3RFl26ib5BXo/aQlE5PMKSSwbYcNqNt4GPWA
 +1bKGpzuimV+Klsfo0VUQdCVJrN/gAmPkopfLeXZRaBgc2ocYN2dTpB92hSW2o7USs71
 ezTaYnSFFrS3xzxSLbutDU5bJ5yw2sV9w4C5poVRt/yISCSOnt9WR1BcWO8k1HqbyWz4
 kAFLoMCo/80O9nl8629st13m8r9mP0q0gxqlQNgaRFtL2niztLghRlJ/OyDeS1GQHZ3h
 sUyQ==
X-Gm-Message-State: AOJu0YzPkT7x0TrrN/xl+7wEvhmM1IyhzkchjCOCd5S7thuvcBs8FW+9
 8FLBDN5YpobeExIQrr6acy+cWVMUAMPFl3/etEquAD/kReI=
X-Google-Smtp-Source: AGHT+IE3yRRWdjkqJqCmpcsNaqPpboIfzYgJm3K7UYzoMHXKE4AcHwdMT//CqscfIRf/LFXeEKoHhpEpzUOPs9PUI3s=
X-Received: by 2002:a05:6e02:1aa3:b0:361:9876:d825 with SMTP id
 l3-20020a056e021aa300b003619876d825mr804737ilv.51.1705504171491; Wed, 17 Jan
 2024 07:09:31 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mnrTbwiTY7+_kK5sHAwR8oQ-2j9G3wekB9+Q30GZQQgAQ@mail.gmail.com>
In-Reply-To: <CAHP40mnrTbwiTY7+_kK5sHAwR8oQ-2j9G3wekB9+Q30GZQQgAQ@mail.gmail.com>
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 16:09:26 +0100
Message-ID: <CAHP40mmb3wz1qUiR-vV7X37LiTyUhkAtEX0dg6CEX4BP2ZUW8Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] Allow tests to be disabled
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The current patch misses this bit.

diff --git a/meson_options.txt b/meson_options.txt
index 0a99a059ec..9a2acd6f83 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -305,6 +305,8 @@ option('libvduse', type: 'feature', value: 'auto',
        description: 'build VDUSE Library')
 option('vduse_blk_export', type: 'feature', value: 'auto',
        description: 'VDUSE block export support')
+option('tests', type : 'feature', value : 'auto',
+       description: 'Tests build support')

 option('capstone', type: 'feature', value: 'auto',
        description: 'Whether and how to find the capstone library')

On Wed, Jan 17, 2024 at 1:32=E2=80=AFPM Manolo de Medici
<manolodemedici@gmail.com> wrote:
>
> tests/qtest/tpm-* compilation is not disabled by disable-tpm,
> for this reason compilation fails on systems that doesn't
> support the linux/bsd TPM api. Fix this by allowing tests
> to be disabled.
>
> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> ---
>  configure | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/configure b/configure
> index 21ab9a64e9..c36ce1f7e2 100755
> --- a/configure
> +++ b/configure
> @@ -254,6 +254,7 @@ skip_meson=3Dno
>  use_containers=3D"yes"
>  gdb_bin=3D$(command -v "gdb-multiarch" || command -v "gdb")
>  gdb_arches=3D""
> +tests=3D"auto"
>
>  # Don't accept a target_list environment variable.
>  unset target_list
> @@ -741,6 +742,10 @@ for opt do
>    ;;
>    --disable-cfi) cfi=3Dfalse
>    ;;
> +  --disable-tests) tests=3D"disabled"
> +  ;;
> +  --enable-tests) tests=3D"enabled"
> +  ;;
>    --disable-download) download=3D"disabled"; git_submodules_action=3Dval=
idate;
>    ;;
>    --enable-download) download=3D"enabled"; git_submodules_action=3Dupdat=
e;
> @@ -887,6 +892,7 @@ cat << EOF
>    linux-user      all linux usermode emulation targets
>    bsd-user        all BSD usermode emulation targets
>    pie             Position Independent Executables
> +  tests           build tests
>
>  NOTE: The object files are built at the place where configure is launche=
d
>  EOF
> @@ -1792,6 +1798,7 @@ if test "$skip_meson" =3D no; then
>    # QEMU options
>    test "$cfi" !=3D false && meson_option_add "-Dcfi=3D$cfi" "-Db_lto=3D$=
cfi"
>    test "$docs" !=3D auto && meson_option_add "-Ddocs=3D$docs"
> +  test "$tests" !=3D auto && meson_option_add "-Dtests=3D$tests"
>    test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add
> "-Dfuzzing_engine=3D$LIB_FUZZING_ENGINE"
>    test "$plugins" =3D yes && meson_option_add "-Dplugins=3Dtrue"
>    test "$tcg" !=3D enabled && meson_option_add "-Dtcg=3D$tcg"
> --
> 2.43.0
>
> root@hurd:~/qemu# cat 0004-Add-the-GNU-Hurd-as-a-target-host.patch
> From 5d7bf83c00168cede72a03d87d7546a0018b82a5 Mon Sep 17 00:00:00 2001
> Message-ID: <5d7bf83c00168cede72a03d87d7546a0018b82a5.1705439227.git.mano=
lo.demedici@gmail.com>
> In-Reply-To: <cover.1705439227.git.manolo.demedici@gmail.com>
> References: <cover.1705439227.git.manolo.demedici@gmail.com>
> From: Manolo de Medici <manolo.demedici@gmail.com>
> Date: Tue, 16 Jan 2024 20:12:50 +0100
> Subject: [PATCH 4/4] Add the GNU/Hurd as a target host
>
> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configure b/configure
> index c36ce1f7e2..d4648af96a 100755
> --- a/configure
> +++ b/configure
> @@ -354,6 +354,8 @@ elif check_define __NetBSD__; then
>    host_os=3Dnetbsd
>  elif check_define __APPLE__; then
>    host_os=3Ddarwin
> +elif check_define __GNU__; then
> +  host_os=3Dhurd
>  else
>    # This is a fatal error, but don't report it yet, because we
>    # might be going to just print the --help text, or it might
> --
> 2.43.0

