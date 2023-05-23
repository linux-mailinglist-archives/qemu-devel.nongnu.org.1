Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6958E70D1AF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I28-0007JF-Dg; Mon, 22 May 2023 22:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1o-000669-0d
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:37 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1e-0004Um-4g
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:33 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5346d150972so5039901a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809924; x=1687401924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42hUpLFpyentR+DHl1F+aZnZuTEaFvKzVFAAW2jc9FM=;
 b=Om4EwKanCzYynDfQyZKeHqaYRZi+vXexnEXTYNo8RaA31CvA5uJ2evCaz8bBYlZJEX
 FqNBHgY5dEDpGazRAFW8YvILZqdCfkI/hJumeMrzpM0WZBBdvWf0Vrf+OhTxozHur2RF
 R9IUcZPOlsBRVp6D9JFlCzuPlfjGZbT/iaTcnUst7DBJUW1WQsUH6O8yuhFXUfX4QO6o
 sjXFg3gmCYEzo9IIKYDtq88MRfRk9SGXk1uuj/NJJ4lw0X0h5HP105htnS+iNG365ONL
 keCv4y7YmxNtAbjA0KBf/s7Az/ssIxyvgKuV+nvQdr+v6NpzcTa/mT1scu4zBpZ8wvDv
 3ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809924; x=1687401924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42hUpLFpyentR+DHl1F+aZnZuTEaFvKzVFAAW2jc9FM=;
 b=Mm9Ht1/D9DIEPfQgBP9Te4lWT9hP3KnsTdOTYGfbfdjHHT9/McbLutC7++c43fX3Fq
 Oo2hN07bKnFtXRGTF/Rer27vvthCy0pbSuQxbuhzhLljmO2heyfPfZRfix9iqhm35Wdt
 XD7AQor7voCYkzo5wFaroOfgILVEZ4CqGKCvqPphROud9ELPZVGieVRSGo5m9KDnnGpW
 plfyRFOu0dOGcVWWny9PXlwN3GHrfJ797P3F7OnfA18MZCPu75omfq67GB51FU1QbV6C
 8YA6TqF3aX/ICIdBeXScUkXsqEK5097RTY2ok5H//JDJiklxxTP+k0wXUfi77zseSQ9v
 /Kxw==
X-Gm-Message-State: AC+VfDylQqwdp64Ui8LbKHtHB29lfg1bw+rzOy4uBSMNFjVcgksUbgQ7
 CMSDa/nR+EOKvCFz5AlBNDmhEw==
X-Google-Smtp-Source: ACHHUZ70Fru1y1EA2qZHviLN1CXKNVZpiSb7yNKAOV4uKG6CIF9LftLOx7Nm2lUoiZpB0ZV29jSxUA==
X-Received: by 2002:a17:90b:300f:b0:253:30f9:1849 with SMTP id
 hg15-20020a17090b300f00b0025330f91849mr11183155pjb.12.1684809924768; 
 Mon, 22 May 2023 19:45:24 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 27/48] igb: Clear EICR bits for delayed MSI-X interrupts
Date: Tue, 23 May 2023 11:43:18 +0900
Message-Id: <20230523024339.50875-28-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Section 7.3.4.1 says:
> When auto-clear is enabled for an interrupt cause, the EICR bit is
> set when a cause event mapped to this vector occurs. When the EITR
> Counter reaches zero, the MSI-X message is sent on PCIe. Then the
> EICR bit is cleared and enabled to be set by a new cause event

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/igb_core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 20645c4764..edda07e564 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -97,23 +97,31 @@ igb_lower_legacy_irq(IGBCore *core)
     pci_set_irq(core->owner, 0);
 }
 
-static void igb_msix_notify(IGBCore *core, unsigned int vector)
+static void igb_msix_notify(IGBCore *core, unsigned int cause)
 {
     PCIDevice *dev = core->owner;
     uint16_t vfn;
+    uint32_t effective_eiac;
+    unsigned int vector;
 
-    vfn = 8 - (vector + 2) / IGBVF_MSIX_VEC_NUM;
+    vfn = 8 - (cause + 2) / IGBVF_MSIX_VEC_NUM;
     if (vfn < pcie_sriov_num_vfs(core->owner)) {
         dev = pcie_sriov_get_vf_at_index(core->owner, vfn);
         assert(dev);
-        vector = (vector + 2) % IGBVF_MSIX_VEC_NUM;
-    } else if (vector >= IGB_MSIX_VEC_NUM) {
+        vector = (cause + 2) % IGBVF_MSIX_VEC_NUM;
+    } else if (cause >= IGB_MSIX_VEC_NUM) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "igb: Tried to use vector unavailable for PF");
         return;
+    } else {
+        vector = cause;
     }
 
     msix_notify(dev, vector);
+
+    trace_e1000e_irq_icr_clear_eiac(core->mac[EICR], core->mac[EIAC]);
+    effective_eiac = core->mac[EIAC] & BIT(cause);
+    core->mac[EICR] &= ~effective_eiac;
 }
 
 static inline void
@@ -1834,7 +1842,6 @@ igb_eitr_should_postpone(IGBCore *core, int idx)
 static void igb_send_msix(IGBCore *core)
 {
     uint32_t causes = core->mac[EICR] & core->mac[EIMS];
-    uint32_t effective_eiac;
     int vector;
 
     for (vector = 0; vector < IGB_INTR_NUM; ++vector) {
@@ -1842,10 +1849,6 @@ static void igb_send_msix(IGBCore *core)
 
             trace_e1000e_irq_msix_notify_vec(vector);
             igb_msix_notify(core, vector);
-
-            trace_e1000e_irq_icr_clear_eiac(core->mac[EICR], core->mac[EIAC]);
-            effective_eiac = core->mac[EIAC] & BIT(vector);
-            core->mac[EICR] &= ~effective_eiac;
         }
     }
 }
-- 
2.40.1


