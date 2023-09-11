Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF04079A393
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaUs-0003g5-JC; Mon, 11 Sep 2023 02:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1qfaUp-0003fo-L6; Mon, 11 Sep 2023 02:34:07 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1qfaUm-0002zI-9w; Mon, 11 Sep 2023 02:34:07 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0Vrm1Mxl_1694414031; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0Vrm1Mxl_1694414031) by smtp.aliyun-inc.com;
 Mon, 11 Sep 2023 14:33:52 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@atishpatra.org,
 palmer@dabbelt.com, richard.henderson@linaro.org,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2] qemu/timer: Add host ticks function for RISC-V
Date: Mon, 11 Sep 2023 14:32:23 +0800
Message-Id: <20230911063223.742-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
v2:
 1) Use rdtime instead of rdcycle for dynamic cpuclk adjustment.
 2) Read timeh twice in case of time overflow for 32-bit cpu.
---
 include/qemu/timer.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9a91cb1248..9a366e551f 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -979,6 +979,28 @@ static inline int64_t cpu_get_host_ticks(void)
     return cur - ofs;
 }
 
+#elif defined(__riscv) && __riscv_xlen == 32
+static inline int64_t cpu_get_host_ticks(void)
+{
+    uint32_t lo, hi, tmph;
+    do {
+        asm volatile("RDTIMEH %0\n\t"
+                     "RDTIME %1\n\t"
+                     "RDTIMEH %2"
+                     : "=r"(hi), "=r"(lo), "=r"(tmph));
+    } while (unlikely(tmph != hi));
+    return lo | (uint64_t)hi << 32;
+}
+
+#elif defined(__riscv) && __riscv_xlen > 32
+static inline int64_t cpu_get_host_ticks(void)
+{
+    int64_t val;
+
+    asm volatile("RDTIME %0" : "=r"(val));
+    return val;
+}
+
 #else
 /* The host CPU doesn't have an easily accessible cycle counter.
    Just return a monotonically increasing value.  This will be
-- 
2.17.1


