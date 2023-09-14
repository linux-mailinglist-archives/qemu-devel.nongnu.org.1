Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2092F7A0E94
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 21:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsOf-0006N0-Id; Thu, 14 Sep 2023 15:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgsOe-0006MZ-Ep
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:53:04 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgsOc-0006pl-1A
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:53:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so1164441f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694721180; x=1695325980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMU91LA7BSC1SezrVUaA2bGYSFbwZkyvMxsyUhJZ/iI=;
 b=FezRqLgX83XjU7AY3UAwehBVqyVGKt/1L1XDJsrKu6r84EQ3KQJvW4P6O+2UaoyMyj
 DeCSzyqYl3LEheCOEi25pBAJ/t0t2fhgTfd0ymRnGSpRtrMIrhU8aYH4DJQgklpliHx/
 52xsdvIEryJChhRMvE6G+kcgwcTyKNJiP4MBHjW3WBImeER0ULmrm0XNNNDbdEI1V7Q8
 hprlNFkIXllWZL8fHbMqkcmhBOYmbDaatmz89Ig4DLuFZ7qqJYby6GVEdtAEhTf+3MDl
 jbxfEcf1vCnZKNrn5j30k8/EXdt26HICL24IejU8Rmx/TJ5iFGJQnCqcTUtyKb3DnEGO
 932A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721180; x=1695325980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMU91LA7BSC1SezrVUaA2bGYSFbwZkyvMxsyUhJZ/iI=;
 b=u2YmjiiaIrWrXDnLhJjPAslefmghjTBvUv0eKcoiC03E74ErMddSfrrZ+WhsnN3JZl
 HivL36QUxk3VK+HIxxnQtSMujKNwEjV8OUG9WziqOu+HoyEvxsr3+n+n+o/1qslJDfq0
 8/t46t91T9NnlT04gyxyrBD3VVcD6iKCSUvf5cSpxL5Ifxu1rkHAHeGO4uNIr53X8dP8
 TWbNN4W+WbOswzrWzkHMDBs19W55pbFC4/fp4Tjxd0LQPz+FS9kW4hPBmioTV4jPHSI/
 qI5TJO0C0hKrN1WqZrxmHhIGa3dfDN7GfgzmrEjeZGktMFbNgJV/og/3IHnFbfcerUpe
 Js3w==
X-Gm-Message-State: AOJu0Yy1jykqEclDIbybfQ0pyP37dTRANH5kEXXOyyEd9vn2wtL0PmtI
 tliQz7tTIl/6TkycB8sVtjrzNj0gaPeIY2UK1AU=
X-Google-Smtp-Source: AGHT+IGj4Ouv5qBvfaJuxneNj2YWgwwDv0agb2peWcvtGj+BdDeDg6oOmuebujutYejycvmI0e+tRw==
X-Received: by 2002:adf:ebc8:0:b0:31a:e6c2:770d with SMTP id
 v8-20020adfebc8000000b0031ae6c2770dmr5628938wrn.36.1694721180203; 
 Thu, 14 Sep 2023 12:53:00 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a50fb0e000000b00521953ce6e0sm1281656edq.93.2023.09.14.12.52.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 12:52:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [RFC PATCH 4/4] accel/tcg: Keep tlb_set_dirty() internal
Date: Thu, 14 Sep 2023 21:52:29 +0200
Message-ID: <20230914195229.78244-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914195229.78244-1-philmd@linaro.org>
References: <20230914195229.78244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since commit 34d49937e4 ("accel/tcg: Handle atomic accesses
to notdirty memory correctly") tlb_set_dirty() is only used
(once) in the very same file it is defined... Make it static.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h | 1 -
 accel/tcg/cputlb.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index b2f5cd4c2a..59efa7bc28 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -695,7 +695,6 @@ static inline void mmap_unlock(void) {}
 #define WITH_MMAP_LOCK_GUARD()
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
-void tlb_set_dirty(CPUState *cpu, vaddr addr);
 
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c643d66190..fe9d702f3e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1062,7 +1062,7 @@ static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
 
 /* update the TLB corresponding to virtual page vaddr
    so that it is no longer dirty */
-void tlb_set_dirty(CPUState *cpu, vaddr addr)
+static void tlb_set_dirty(CPUState *cpu, vaddr addr)
 {
     CPUArchState *env = cpu->env_ptr;
     int mmu_idx;
-- 
2.41.0


