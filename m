Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D481D74B1B1
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 15:20:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHlNM-0005Sm-6v; Fri, 07 Jul 2023 09:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHlNH-0005SA-ES
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:51 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHlMz-0001Lm-Sg
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688735969; x=1689340769; i=deller@gmx.de;
 bh=3gegbpErrgWaM8LS/WzGk53g29olHqbZ9U4vgGMbxUM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TLLqhc0ykZ5f5U5Sl/3uJZJZdrl56wCDAxafQCZfNgYoblA5t9eEni5WK19I2MhvvsVWGwb
 tRXY3VLwWpGsqGnUbxLfB3SiweBCEfFhMFSkCLY0gKJrzGZIBbgMqU96pZmnBx5R0xfPWQ1ep
 YT3mSS5HWuBEb6g8ZpzRDr6fceX9Vc1lcgAnGnde8602EVCQnUDTGhwhWEMSB9z/h/KwP8HuS
 YkIxtJezZOY2rFr4IjurUTA6/pOsKmQilyrokna9s+PlxGduoA/aWo4Awvc4D3HP5ow7+vnvB
 QhLk9wpZshgSZiVgoK1U2nEViNYuWuRl7NK9wZAGXUUFGurBlSkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.153.180]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma24y-1qW9UD1zIi-00Vzcy; Fri, 07
 Jul 2023 15:19:29 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 3/4] linux-user: Fix mmap2() syscall on 32-bit targets to
 allow file mapping beyond 4GB
Date: Fri,  7 Jul 2023 15:19:27 +0200
Message-ID: <20230707131928.89500-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707131928.89500-1-deller@gmx.de>
References: <20230707131928.89500-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZAW1h6YRj62/VI73zK0JQ/vPesQQW5PKqUog3suzcwjwc239gOS
 6+poevozp01xLPtXKTP+K5HJjaBDBS79QmJuWnW/nyzcWElI3lplz60OHI+4PCeLIg6WC7X
 0749UIOQXjRXbBRLu/0XmxOrhPAPfye92OrigUoAMIx6ZWbNM0ulhGiA1Wrg+rmHcpHm6T9
 zThLnbem3Fw6x7lFuuz+A==
UI-OutboundReport: notjunk:1;M01:P0:/v1ePx1exIY=;lyXlUau7DSYU38Petpgv8MBopnj
 bbXMci6KYUHF7HRIR5wKkAeeuryotSNiyoonxZ06mHhGuqceWNtEgZgqH+Pr4emhF3vwqZJFa
 VbdFvmfvknfsvk5ysyFaU7ORDrS2jr52kGNa5C+y0iMM2MdHKP43lFevCdGcp+iEjX9yB+3mv
 vH6qvSnK8Vw6zdUAWN00F0GPqXL3OBxkD/mtoKy0V4lTadYLLui9CSlZCyFJDTro4i3Fe7f3z
 Ft4br4v/cnIbDTDXsSzHC6A+DJ8QOA5gg2MC6loxTby6N441+B5eWZvJdLxZmpVeHqgdUNQwf
 2YkJAbLeN1PbsnUmC1kP6+1xs9JminlZo2Un4N8eiZjQOV+EdUomIoT2vPdn+JPrGV81Uwc+T
 NxVuqvUDeBPiZQv+r6ZuhhDOVV/8mWgvDE3QDMy2hipfCb/gmfCEABC/DQISGje+BWlWTkoDB
 xrxf3QWJXTMnNpNqmtO9MG0+VarRgRO/MbXdxMFAUnE8RWzNy7vpNWILYWRWO+Pj4VRMDMyTa
 1kh+oadBn5gYsblju7FZgmIBaLirsYnlNUmCnG8nLdkweWsRbIDnfkmF9qMUYgjCPSFjAxcRG
 zIkxn1uK0AMAfM6FcdugOFvyikTYogbO7wbtxIca0rv6Qd0s4nui0UlVP12/bN2mxzsJt9jKb
 r/t0Jo7VjZI5WaiENKb+mhpb/hU8yL+7EQkWp55XonBtKtOnFo7aX8M4GIT9X/wtckpqzWGGS
 vHNAaQhIvj1SaoZGTPPrdSrEfkJQ/b/LebY9bLmhg6ni+BzDw1MowSvvXfeBYZdqmAVpOVDtb
 2H/Q4IKftU2+I0ohnL40xbKDnmakOUAAzEH2bkJPnPFi2qFsDON9U6RVDtJ6R0K0iMxSoeKPe
 /dtucuKE30ER+lkAYeuTmftGd6gLz9dFrl58eVHpgAKrCmGwrzPklyZSuBDNzWIoo6cOLvmN8
 fyxrK2GkudWw2zczFTVd0mu//j8=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The mmap2() syscall allows 32-bit guests to specify the offset into a
file in page units (instead of bytes, as done by mmap(2)).
On physical machines this allows 32-bit applications to map such parts
of large files which are stored beyond the 4GB limit.

Allow the same behaviour when emulating 32-bit guests with qemu.

For that switch the mmap2() function to always take an abi_ullong
(64-bit) offset parameter for target_mmap() and mmap_frag() to avoid an
arithmetical overflow when shifing a 32-bit offset parameter by
12 bits (=3DPAGE_SHIFT) and thus possibly overflow the abi_ulong (32-bit)
type.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/mmap.c      | 9 +++++----
 linux-user/syscall.c   | 2 +-
 linux-user/user-mmap.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 2692936773..2750146758 100644
=2D-- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -192,7 +192,7 @@ error:
 /* map an incomplete host page */
 static int mmap_frag(abi_ulong real_start,
                      abi_ulong start, abi_ulong end,
-                     int prot, int flags, int fd, abi_ulong offset)
+                     int prot, int flags, int fd, abi_ullong offset)
 {
     abi_ulong real_end, addr;
     void *host_start;
@@ -436,10 +436,11 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong s=
ize, abi_ulong align)

 /* NOTE: all the constants are the HOST ones */
 abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
-                     int flags, int fd, abi_ulong offset)
+                     int flags, int fd, abi_ullong offset)
 {
-    abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_=
len,
+    abi_ulong ret, end, real_start, real_end, retaddr, host_len,
               passthrough_start =3D -1, passthrough_end =3D -1;
+    abi_ullong host_offset;
     int page_flags, host_prot;

     mmap_lock();
@@ -627,7 +628,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, i=
nt target_prot,
         /* map the middle (easier) */
         if (real_start < real_end) {
             void *p;
-            unsigned long offset1;
+            off_t offset1;
             if (flags & MAP_ANONYMOUS)
                 offset1 =3D 0;
             else
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9e9317237d..5ebc502f71 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10427,7 +10427,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env,=
 int num, abi_long arg1,
 #endif
         ret =3D target_mmap(arg1, arg2, arg3,
                           target_to_host_bitmask(arg4, mmap_flags_tbl),
-                          arg5, arg6 << MMAP_SHIFT);
+                          arg5, ((abi_ullong)arg6) << MMAP_SHIFT);
         return get_errno(ret);
 #endif
     case TARGET_NR_munmap:
diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index 480ce1c114..72e99000d9 100644
=2D-- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -20,7 +20,7 @@

 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
-                     int flags, int fd, abi_ulong offset);
+                     int flags, int fd, abi_ullong offset);
 int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
=2D-
2.41.0


