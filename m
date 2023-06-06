Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6258D723709
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Pgf-0004t2-Qk; Tue, 06 Jun 2023 01:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6Pgd-0004sc-D5
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6Pgb-0004Bp-QY
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686031013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uX6P3ku7G8vYa9FjFhSZobfFV7qQ9qxxl2iJ328L79g=;
 b=i/pLR1OBP6P6e7kJwUKG13WTv8sfotHKAmv9xWi1SNpkzgbojF6mV5gLaoLpkRuJ0nccjb
 OnAgNNaQB9k14BSVqq0RPdOL3kVf9Zaw0JuhXqU3eqq3r+4a07tJpV1INtVrY1IOvdzvKe
 j6HX4Ws+Z3+xn48a2Pn3ET7IhFBgLAM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-9Sp_-ZW-N_ezEEyrekoO-g-1; Tue, 06 Jun 2023 01:56:48 -0400
X-MC-Unique: 9Sp_-ZW-N_ezEEyrekoO-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4E27299E745;
 Tue,  6 Jun 2023 05:56:47 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 304EF2166B25;
 Tue,  6 Jun 2023 05:56:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 15/18] s390x/tcg: Fix CPU address returned by STIDP
Date: Tue,  6 Jun 2023 07:56:18 +0200
Message-Id: <20230606055621.523175-16-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

In qemu-user-s390x, /proc/cpuinfo contains:

	processor 0: version = 00,  identification = 000000,  machine = 8561
	processor 1: version = 00,  identification = 400000,  machine = 8561

The highest nibble is supposed to contain the CPU address, but it's off
by 2 bits. Fix the shift value and provide a symbolic constant for it.

With the fix we get:

	processor 0: version = 00,  identification = 000000,  machine = 8561
	processor 1: version = 00,  identification = 100000,  machine = 8561

Fixes: 076d4d39b65f ("s390x/cpumodel: wire up cpu type + id for TCG")
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230605113950.1169228-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.h | 10 +++++++++-
 target/s390x/cpu_models.c |  4 ++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index fb1adc8b21..cc7305ec21 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -96,10 +96,18 @@ static inline bool s390_known_cpu_type(uint16_t type)
 {
     return s390_get_gen_for_cpu_type(type) != 0;
 }
+#define CPU_ID_SHIFT 32
+#define CPU_ID_BITS 24
+/*
+ * When cpu_id_format is 0 (basic mode), the leftmost 4 bits of cpu_id contain
+ * the rightmost 4 bits of the physical CPU address.
+ */
+#define CPU_PHYS_ADDR_BITS 4
+#define CPU_PHYS_ADDR_SHIFT (CPU_ID_SHIFT + CPU_ID_BITS - CPU_PHYS_ADDR_BITS)
 static inline uint64_t s390_cpuid_from_cpu_model(const S390CPUModel *model)
 {
     return ((uint64_t)model->cpu_ver << 56) |
-           ((uint64_t)model->cpu_id << 32) |
+           ((uint64_t)model->cpu_id << CPU_ID_SHIFT) |
            ((uint64_t)model->def->type << 16) |
            (model->def->gen == 7 ? 0 : (uint64_t)model->cpu_id_format << 15);
 }
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 457b5cb10c..ae8880e81d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -607,8 +607,8 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
 #if !defined(CONFIG_USER_ONLY)
     cpu->env.cpuid = s390_cpuid_from_cpu_model(cpu->model);
     if (tcg_enabled()) {
-        /* basic mode, write the cpu address into the first 4 bit of the ID */
-        cpu->env.cpuid = deposit64(cpu->env.cpuid, 54, 4, cpu->env.core_id);
+        cpu->env.cpuid = deposit64(cpu->env.cpuid, CPU_PHYS_ADDR_SHIFT,
+                                   CPU_PHYS_ADDR_BITS, cpu->env.core_id);
     }
 #endif
 }
-- 
2.31.1


