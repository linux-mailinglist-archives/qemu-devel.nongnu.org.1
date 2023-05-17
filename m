Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7730E706222
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:02:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6w-00038F-8u; Wed, 17 May 2023 04:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6i-0002jt-Ai
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:00 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6g-0000uD-6d
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:00 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M2fQ9-1q17Fd4BOp-0049IS; Wed, 17
 May 2023 10:01:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 2/9] linux-user: report ENOTTY for unknown ioctls
Date: Wed, 17 May 2023 10:01:45 +0200
Message-Id: <20230517080152.108660-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517080152.108660-1-laurent@vivier.eu>
References: <20230517080152.108660-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JHrf53yipW3GNGGa0qVyKTs8oj12+PKYR8ujgwXIXpD2Ly6vutP
 UrOQMsq9YPsJraVwOhNZ3Rg6vLgumZVf5rU9Q/B+nSOfjbWdQP2cYwxmd5dSr+d2YKO6t8f
 /iF1rp8in7ePPFdsmWoKhnF8m+o7jlNUoHJP/RtxnIS7ot/7lfPX3zVf+fbkh+IAkImR1f5
 kHzQy47woJJ2jENJ0deww==
UI-OutboundReport: notjunk:1;M01:P0:kt7MXMvMeyk=;n30AaN9Md5Nm90PbL6UyeWs1BsB
 fSAceAFDQBzaGDX/xdG4B15RlHIpU2Qymiy+/3+r00aTkZETpPRlcMFBJs6GNUh1ebTzUVoRN
 m+pbzHcuQzQYbdRIuoZHUEU3C875cDwr263CzYZI1rvq1SN7IVQOiux2uUlBJX04OBOuZGTTn
 g2QcVKqUurdBk7k4PK2p62QPFSiO7+Wnf5jJemDwsqI61GQbvbgqajD/HCXZ1K1tZwjjb5cZe
 XJwXUmM6TTUWHeRuWCCMzeWAmScwtTeg2E7DelRSSUi2U51Tmyul8BO95Y+DC0LIfeNAbz7iI
 3mb/iOXjomZR4DEm9ehIcyUeupf5TqClVFslT//07ShawS+DMLFNLi+D+TYNAAcbpVGETVoUF
 wBmL2u6bolbHOn8giBLONicsjbGAR738I0u7+PvCrjyl82ziwamHIaq+mq9YZtFIygQGlyHUq
 NpmYJzb3Yw40OGEI23HmxyrhiwuVf25V3PTYHD99ywmjzDxpLzTNUky4pL5lKeFXq/Uv5C5fj
 vAqUj73nrRvW8Lr0Ba72/yvTKEVkWDx+4bsUdB1s4O5SvoMU1v4NF7UzbagFO2Dwnjl/A+FzS
 ZfguFesdYk/P3x9Cs5GespGYA9l8l044dVy9OUSgcW9dMXzekLpIspkcZwxHUZQ1CkbbVRQoM
 T4mrCLHVlNatM5AoIMzLH4Og8RK3XFIx645g07RYSA==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Thomas Weißschuh <thomas@t-8ch.de>

The correct error number for unknown ioctls is ENOTTY.

ENOSYS would mean that the ioctl() syscall itself is not implemented,
which is very improbable and unexpected for userspace.

ENOTTY means "Inappropriate ioctl for device". This is what the kernel
returns on unknown ioctls, what qemu is trying to express and what
userspace is prepared to handle.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230426070659.80649-1-thomas@t-8ch.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 085ce530213e..954ed14df4c0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5747,7 +5747,7 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
         if (ie->target_cmd == 0) {
             qemu_log_mask(
                 LOG_UNIMP, "Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
-            return -TARGET_ENOSYS;
+            return -TARGET_ENOTTY;
         }
         if (ie->target_cmd == cmd)
             break;
@@ -5759,7 +5759,7 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
     } else if (!ie->host_cmd) {
         /* Some architectures define BSD ioctls in their headers
            that are not implemented in Linux.  */
-        return -TARGET_ENOSYS;
+        return -TARGET_ENOTTY;
     }
 
     switch(arg_type[0]) {
@@ -5817,7 +5817,7 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
         qemu_log_mask(LOG_UNIMP,
                       "Unsupported ioctl type: cmd=0x%04lx type=%d\n",
                       (long)cmd, arg_type[0]);
-        ret = -TARGET_ENOSYS;
+        ret = -TARGET_ENOTTY;
         break;
     }
     return ret;
-- 
2.40.1


