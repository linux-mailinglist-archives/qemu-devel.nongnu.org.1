Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 818E775FE76
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 19:49:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNzfm-00027r-MP; Mon, 24 Jul 2023 13:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qNzfk-00026g-Ti
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:48:40 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qNzfi-0005aj-QU
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690220914; x=1690825714; i=deller@gmx.de;
 bh=HpumHCLzVgzNVhx++hvH34XbHa4cwh14+xIUXetvqV8=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=jTDCb7++iQkZoPjCKmVVPlkq1eCw8b67sH6aH5M813gBzJNk0QO2ZZsy4Tvxi4Qiap0sLU5
 uODyko8Ruk/8BKnhkKUpNgKd1mXLsjDgodCCgSIumHUNC5VqvjD+sue+NPLPuuNHFlP+KD+lA
 94+g8a3v5I4ik6o2vLwmFIG7BOigEKshNRCB9SKyaugspOnkQuKsfawmXUUmv6yywXEMfSocJ
 VSOl7ykkIdScxsZhP2velibL85M21jIswQDjnwjad2ze6LES7u4NpIYIIainzEKmz/7lIV4df
 6wKkt+VuEqHIkTbWcWfnAHgEe/ocQbkGqQe4uPMOKzFnj8BhLekg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.154.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1pmRzu0u6q-00ba7D; Mon, 24
 Jul 2023 19:48:34 +0200
Date: Mon, 24 Jul 2023 19:48:31 +0200
From: Helge Deller <deller@gmx.de>
To: Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Andreas Schwab <schwab@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3] linux-user: Fix qemu-arm to run static armhf binaries
Message-ID: <ZL65b1xvYXLQtDgZ@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:3E4RRd+3oPZbj8II6RroDc56T+Ax1X1ZG3GUVk4g1P/I9P6OT28
 NLgotH7skzz33h+8cFZhoxryNuydhs4XVJSiY3y5gqHvj/IZy75v/JnqstwzF3b8klV10Oh
 Ev+RINxQmTFjn8fLcsbnC87zjpDcnuvIIYdK/800G2qZTCOZE5NdSG5j2AU6zUWOTcxKfNY
 4uyR1GBPl8h7OiYPTJUwQ==
UI-OutboundReport: notjunk:1;M01:P0:TiSq9sPGV2M=;c/Ja7A4yHcwAqf2z9dAInkbGsoE
 Q1hMWcHIPgHWI0SBAA8qnAil3xole64/4CllW07ZBzNK7qEVoiZFHuAXhX+WNvsZENZjUjXDk
 U7xzbE/tyzI8+PNG86cdecOUB6nUkE+L0wNeh2PLoA2yDWvKO3bUSvg+/o5epy75rLv+GKuvL
 9prCtnL5E0WPG/2EjuFYRy1Aod6D9+Qcsg7/euzS3UQjaCTJV4M7we1d3ixfkUzWwETb99g94
 tDhpKng/xGtlhsHQIMuSw7vZUbSFZj4Z7vpfA2j9WsBV1qxZEeH232SbpgLlOEmCB8DToq0Xy
 aqMmLYbM75w29swlClQMQT9x6WvDCFHhly/fp9ksWolfCd9qI09AGQR/lPhXIVv2NEXGRnb29
 OCz60JLyKDAJ13wH65o5GKLqM5ibyUJH3ZtjbfNIJPrqLNHDq0gSiHnVx2Vkleg08I4qPKRW3
 bvH8K4ZbMHSBsbiPaVRWBa51P9+hELHE7X8bVc3d6/C1vMwvdjEm92JLcJegjrYJ814al1cLP
 1NfdBLsG8klpVcm34a60M+SmjeChh50bvQR4EQvRBOfsSo4tSswToiBj050+uKJLuB0xYct+H
 gsw7dh+/crMcfiTNdqPfsgUb995SrFea05zk9EiCkZfcJGjEwb/l3lDQdabYVVTdj57x7UACJ
 R1Fqq+VO6r4k3N3PAMyEblqY4k6CUCEBv91QAAAbGXmBaU0KHOMKf2wvIKBX0tbfx132tHz+5
 7C2rMMhu2JO8shLl5JWxO/K44sOvG8MSwsGBF629hPy9RK3nT+ANWsASBye9eL88XQSi4ZzPF
 21A9XFpB00ST4O0VEkG1bN+2KdYdtAvcFZ2ayoZxG9oJ3O0mMvb+bwci0LedvNwOTwt+1uhcf
 sVt5R2pQwMh0xI/NE4mRNVyvPF1o8x5ot2q7Fyta9eHvviQfvMXIST7DJAcQc+7y8/iRPeORw
 Xk4C4w==
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The last attempt to fix linux-user to be able to run static armhf
binaries fixed armhf, but broke arm64, ppc64el and s390x.

This patch takes another approach to fix the issue.
Instead of pre-allocatig a 16/32 MiB memory region for heap, the loader
tracks the highest address of both executable and interpreter.

Then it compares both values and chooses the highest address from the
executable as brk starting point, if the starting address of the
interpreter leaves at least 16 MiB for the heap.

If not, qemu will choose the highest address of the interpreter
as brk start.

I've tested this patch on arm64 and hppa (both with chroot), and with a
static armhf binary.  It applies on top of git head, where the previous
patch was reverted.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 861ec07abc..710ba03862 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3107,27 +3107,6 @@ static void load_elf_image(const char *image_name, =
int image_fd,
     }

     if (pinterp_name !=3D NULL) {
-        /*
-         * This is the main executable.
-         *
-         * Reserve extra space for brk.
-         * We hold on to this space while placing the interpreter
-         * and the stack, lest they be placed immediately after
-         * the data segment and block allocation from the brk.
-         *
-         * 16MB is chosen as "large enough" without being so large as
-         * to allow the result to not fit with a 32-bit guest on a
-         * 32-bit host. However some 64 bit guests (e.g. s390x)
-         * attempt to place their heap further ahead and currently
-         * nothing stops them smashing into QEMUs address space.
-         */
-#if TARGET_LONG_BITS =3D=3D 64
-        info->reserve_brk =3D 32 * MiB;
-#else
-        info->reserve_brk =3D 16 * MiB;
-#endif
-        hiaddr +=3D info->reserve_brk;
-
         if (ehdr->e_type =3D=3D ET_EXEC) {
             /*
              * Make sure that the low address does not conflict with
@@ -3194,7 +3173,8 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
     info->end_code =3D 0;
     info->start_data =3D -1;
     info->end_data =3D 0;
-    info->brk =3D 0;
+    /* put possible start for brk behind all sections of this ELF file. *=
/
+    info->brk =3D load_bias + TARGET_PAGE_ALIGN(hiaddr);
     info->elf_flags =3D ehdr->e_flags;

     prot_exec =3D PROT_EXEC;
@@ -3288,9 +3268,6 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
                     info->end_data =3D vaddr_ef;
                 }
             }
-            if (vaddr_em > info->brk) {
-                info->brk =3D vaddr_em;
-            }
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type =3D=3D PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
@@ -3618,6 +3595,15 @@ int load_elf_binary(struct linux_binprm *bprm, stru=
ct image_info *info)

     if (elf_interpreter) {
         load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
+        /*
+         * Use brk address of interpreter if it was loaded above the
+         * executable and leaves less than 16 MB for heap.
+         * This happens e.g. with static binaries on armhf.
+         */
+        if (interp_info.brk > info->brk &&
+            info->load_bias + interp_info.load_addr - info->brk < 16 * Mi=
B)  {
+            info->brk =3D interp_info.brk;
+        }

         /* If the program interpreter is one of these two, then assume
            an iBCS2 image.  Otherwise assume a native linux image.  */
@@ -3672,17 +3658,6 @@ int load_elf_binary(struct linux_binprm *bprm, stru=
ct image_info *info)
     bprm->core_dump =3D &elf_core_dump;
 #endif

-    /*
-     * If we reserved extra space for brk, release it now.
-     * The implementation of do_brk in syscalls.c expects to be able
-     * to mmap pages in this space.
-     */
-    if (info->reserve_brk) {
-        abi_ulong start_brk =3D HOST_PAGE_ALIGN(info->brk);
-        abi_ulong end_brk =3D HOST_PAGE_ALIGN(info->brk + info->reserve_b=
rk);
-        target_munmap(start_brk, end_brk - start_brk);
-    }
-
     return 0;
 }



