Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B972B4773F
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Sep 2025 23:06:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv03a-0003ot-Pz; Sat, 06 Sep 2025 17:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv03X-0003oD-6N; Sat, 06 Sep 2025 17:02:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv03N-00062E-8G; Sat, 06 Sep 2025 17:02:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 83A28150F87;
 Sun, 07 Sep 2025 00:00:55 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 46E2B278692;
 Sun,  7 Sep 2025 00:00:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 28/34] linux-user/mips: Use P5600 as default CPU to
 run NaN2008 ELF binaries
Date: Sun,  7 Sep 2025 00:00:48 +0300
Message-ID: <20250906210056.127031-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Per the release 6.06 revision history:

 5.03 August 21, 2013

 • ABS2008 and NAN2008 fields of Table 5.7 “FCSR RegisterField
   Descriptions” were optional in release 3 and could be R/W,
   but as of release 5 are required, read-only, and preset by
   hardware.

The P5600 core implements the release 5, and has the ABS2008
and NAN2008 bits set in CP1_fcr31. Therefore it is able to run
ELF binaries compiled with EF_MIPS_NAN2008, such the CIP United
Debian NaN2008 distribution:
http://repo.oss.cipunited.com/mipsel-nan2008/README.txt

In order to run such compiled binaries, select by default the
P5600 core when the ELF 'MIPS_NAN2008' flag is set.

Reported-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230327162444.388-1-philmd@linaro.org>
(cherry picked from commit 450cb7ec2c5fda51b9650ca25e59ac9deeb60d1b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index a98c9bd6ad..b965e86b2b 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -15,6 +15,9 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
         return "R5900";
     }
+    if (eflags & EF_MIPS_NAN2008) {
+        return "P5600";
+    }
     return "24Kf";
 }
 #endif
-- 
2.47.3


