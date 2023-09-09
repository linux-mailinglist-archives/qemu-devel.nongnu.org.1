Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E579976D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 12:33:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qevCO-00076E-JA; Sat, 09 Sep 2023 06:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevCM-00074z-HJ; Sat, 09 Sep 2023 06:28:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevCK-0004Tw-2S; Sat, 09 Sep 2023 06:28:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 401682049E;
 Sat,  9 Sep 2023 13:28:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4758926CFC;
 Sat,  9 Sep 2023 13:27:58 +0300 (MSK)
Received: (nullmailer pid 346655 invoked by uid 1000);
 Sat, 09 Sep 2023 10:27:57 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.1 11/34] softmmu: Assert data in bounds in
 iotlb_to_section
Date: Sat,  9 Sep 2023 13:27:04 +0300
Message-Id: <20230909102747.346522-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
References: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 86e4f93d827d3c1efd00cd8a906e38a2c0f2b5bc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1..7597dc1c39 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2413,9 +2413,15 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
     CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
     AddressSpaceDispatch *d = qatomic_rcu_read(&cpuas->memory_dispatch);
-    MemoryRegionSection *sections = d->map.sections;
+    int section_index = index & ~TARGET_PAGE_MASK;
+    MemoryRegionSection *ret;
+
+    assert(section_index < d->map.sections_nb);
+    ret = d->map.sections + section_index;
+    assert(ret->mr);
+    assert(ret->mr->ops);
 
-    return &sections[index & ~TARGET_PAGE_MASK];
+    return ret;
 }
 
 static void io_mem_init(void)
-- 
2.39.2


