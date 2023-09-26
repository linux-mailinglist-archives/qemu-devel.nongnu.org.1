Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FCD7AF04A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:08:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAbn-0001rS-L5; Tue, 26 Sep 2023 12:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qlAbk-0001qb-FR
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:08:20 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qlAbi-0001dN-U3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:08:20 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c44c0f9138so66088585ad.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695744497; x=1696349297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDcE3Ic3V7+yjR8w7Ts9aHqmfWi6Uk8py2zFp4NgIRA=;
 b=fNEqpkBiUh6HXYUcB8yqsVe2xUUGMQbCZpafvi6sd6JXkqHIxXB2fsq5Rw+vALytAT
 S+LHVcwXj/VdgLZsgJHJAjq2gQAW5VyJnh7G2jwny2jepFsE2jb1BhndR29o0vwhLSts
 Ycu0NFNyBt9ZXUD6mBePJy39MetJpVNU+Mqck5wjGSaHZ6pbxO7Fo9hVftkNCK9O/XsJ
 mMWiYXUEIrvJNwqjYBKy0TcnVz2nlPmZVSfke2zT8HpW3hgxKyfOwtXnci8ca0siZQb8
 XEqaVGgQsc27LEoO7J6keVM5XlhDzUb+imEMxuWq7ch2V1MOm670yTmHB4Oq9EJsgwjb
 MXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695744497; x=1696349297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDcE3Ic3V7+yjR8w7Ts9aHqmfWi6Uk8py2zFp4NgIRA=;
 b=nZjmJZtoXmX9jTnF1XxutJZQpv3KM+qZ/QTlF0te1y2biHE97bYAjlo6KvOoKfY0XX
 XxDHEEef8kBKdYO1X+ai1aIOzHTjO9oH6yEn/O2jLHCYO+oeQ8DgO7f3/A6PwBbLq6Cb
 dG9E4cpouVjpPN/rs0TPMf0dkepocW/LqxufmmEcyjTtJUO/BQtQFWY8fq8de7X+/ned
 Jmv11s5D8uym7CfrqhCYZo8qfxMvFBBN6hOmV+xqPdgpMLRsNgncd5tfrx5dA/M8DEwj
 tjBCvWkjyM9yoIzFxuI681KOvKX8JJo5lkjKL6X9fUxW8xevnsJptqevtBnJl1IY4ZAn
 yU2Q==
X-Gm-Message-State: AOJu0Yx67x8j/7mO/a0BDhj2fHJpZuo9nMz6xGXF5RuZzWzVB+fg2OUR
 K5W8fJpfXRrhLUpqsN9pAHvfsVPdXHJRzw==
X-Google-Smtp-Source: AGHT+IFurW6zfu7aEnJnzIcJ3OSyMUNr9jUPYU2uIOTRuOkGauxpVKDLTvNQ4jlDred1y+YGL5KMBA==
X-Received: by 2002:a17:90b:3e87:b0:26d:4312:17e5 with SMTP id
 rj7-20020a17090b3e8700b0026d431217e5mr7462231pjb.6.1695744497228; 
 Tue, 26 Sep 2023 09:08:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:2173:954b:298f:df36])
 by smtp.googlemail.com with ESMTPSA id
 9-20020a17090a190900b0026fa1931f66sm11158410pjg.9.2023.09.26.09.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:08:16 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v8 4/5] intel_iommu: allow Extended Interrupt Mode when using
 userspace APIC
Date: Tue, 26 Sep 2023 23:06:36 +0700
Message-Id: <20230926160637.27995-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926160637.27995-1-minhquangbui99@gmail.com>
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As userspace APIC now supports x2APIC, intel interrupt remapping
hardware can be set to EIM mode when userspace local APIC is used.

Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/i386/intel_iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c0ce896668..a3e4bf5497 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4049,11 +4049,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
                                               ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
     if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
-        if (!kvm_irqchip_is_split()) {
-            error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
-            return false;
-        }
-        if (kvm_enabled() && !kvm_enable_x2apic()) {
+        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
             error_setg(errp, "eim=on requires support on the KVM side"
                              "(X2APIC_API, first shipped in v4.7)");
             return false;
-- 
2.25.1


