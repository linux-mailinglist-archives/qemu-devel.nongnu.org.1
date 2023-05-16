Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70925704E11
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:50:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyu6K-0004N2-H6; Tue, 16 May 2023 08:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6G-0004Jy-Iv
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:20 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6C-00062x-Q0
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:20 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MNOZO-1pnG4N1dus-00OrR4; Tue, 16
 May 2023 14:48:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 2/9] linux-user: report ENOTTY for unknown ioctls
Date: Tue, 16 May 2023 14:48:03 +0200
Message-Id: <20230516124810.90494-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516124810.90494-1-laurent@vivier.eu>
References: <20230516124810.90494-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GPXyhX+uYm5k/ooyin6TkqR/fz5Fjrc2hhq+xNjzUXatTLXI2EL
 FiwX9IipQB4sg1XvDBm8AD7uZsGmMkKci+4z1pIo6Y39oMQDr26hA+FAoNfMHshQbEl/EA5
 IoE3WOQCiSuBs6JYnWddx8Ba09ts2R8Xa98tR9hO/8wVC1Gap9wuLY1XZQG9sNep32qUi/H
 9JrSA/TiGXskfRKC3Fv8w==
UI-OutboundReport: notjunk:1;M01:P0:tgSIl66WzM4=;5Th2TV7V614P7+dYtt4i8W3a4QE
 j5/xgU71N5MKCRb7Dqte0oXuMoD43DEAHVVaOChuqZ6Cf66UKbKB4J/jN7QRlqz9ls3lVIJpB
 rAGs58JuWikFgKMJa/okoYrxgwU3z1OCTLJodKDuXB9ygPkCZKbqCDYXCRq1pT8anrqKOTW9i
 xQvr7Z+K7HkycCfgkc/ix6X5VweVdiDmvieF4F+8/iGwboJVvUiuBLSx3LdkeKg/dMF6a+Q7m
 iSN4OrlySTAF9PMuB8mdHJFH9NwdUD1hiti4uDJYz6fPDx0mDnUjK1es3mhJeOC5W0SaDJA7Z
 /DoVAfsAZVi2LuAvCDf9mfv9TvpZC1RdBUa3nW9U8ow2/K1Mo1WfdNXLBobTjQDrP8X5c2iae
 RbGIXYWZvuw3u0ZFAt7tbpOHDgVIW3Xg/Fmz8+JKOind5CA8VLpfjO1lsFURtipn+bLHKzsMT
 FpIl9MIazrORjI3VxRSk6uRMVu9aJN1o0gMzzuBybHjl9tK/drf5/kT3Vlhkm/K3lGa8FOQYM
 UbM6BylS160Y9I+AaS+tC3HoKzloremjUtGLI1skkqy2QkrmpEDgvm52fXpsWHS4TjIo32ye7
 D3FHopoz8hDNHtsxlVZZtXzh7dsL1IcrFCy1YbvDtjA7GIWTzgvzcwGjK4pRJa6/GGUpPOWVR
 qYcvATN1I5/EJqy6/mXbL/k6JVFHNiHvPOhEeHRO1w==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
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


