Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACB3754958
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 16:30:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKgGt-0008SG-5P; Sat, 15 Jul 2023 10:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qKgGr-0008Ry-6d
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 10:29:17 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qKgGp-0007My-Oc
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 10:29:16 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-262e44b8bf6so1478937a91.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689431354; x=1692023354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whtIihO8C5FjzK5ixwiGc/sebxb6lVrIRnDHt/vyCSc=;
 b=Vn/Y3es0IkcO6tGeVuCnkgaj2lSXZkNEHCwSkaZB8z7gEoooJawCyt1peUbx+iftsU
 O7dVLIkjkYwGNgoy9TdxMkAY9/xyNjbS1963CHe8dCM7Tc6mrZgxGLJL2oaIrSwzp8Xj
 EvrQNSdblPb3HTbdarn7Dyx+pJigACLXw6SfnWYu8ZqTrtkejU10cNqkfdE2n/29kMzd
 UCFS8pxe69nSKlXrbK0nDjUAWnoC6913N8Df0SADCtL8lZbdypLez7FpmcXRFMYsh5RS
 13v8DurauQg0cutHDFQ5uPuOLjqtjXpNbDTP4MGyfeeprn5ucTQ5cKk60IWSlwHBQjkA
 6I4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689431354; x=1692023354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whtIihO8C5FjzK5ixwiGc/sebxb6lVrIRnDHt/vyCSc=;
 b=Oso9UivDx9xlXfHTeZHmuj6TSretHK+pCxrGByWOmEGthFFrW89k7Hj3i7uUnT1VhE
 T40Wsa7YiuN9Ms2UHg9axzDs2hf3tYLf12QWxJBkUvIOT4NF7W6Er+4J4ZCMiNNqlFwB
 Z90tp1+y3K9KH1bacfgaThRflf89MWCkpfLcy+1jWiivVhvI5Wl4XfhPxy0wnesK2k8m
 aNF20bxOVN0+au1XGnDos6TKPiCFwVYL/eafozPgzWeXYb97SbpAnW4xHtQTQ585z7Th
 Pr1k2wFiJgX2HLLdqiOvSnMKFekXEFkCevrNW8W+ltpABbo2bvjGW9vNWo0Oo92tbGlA
 dYEQ==
X-Gm-Message-State: ABy/qLb17OqbgR2t/+f8FuU5DaumfVpd3aP4gI6AN09orbDk6B+05Wqm
 /lqnApWfU0ePxAqlrU3tWueYJG1pnOxdgA==
X-Google-Smtp-Source: APBJJlHsRtuG3vB2C1MROqkPtP422IGaDNapdIwCDDGRYkia8KfUIAnzaBgnj6HJSMNtD85a1A7h+w==
X-Received: by 2002:a17:90a:7e98:b0:25e:d303:b710 with SMTP id
 j24-20020a17090a7e9800b0025ed303b710mr5405141pjl.35.1689431353674; 
 Sat, 15 Jul 2023 07:29:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:4fb3:b780:7c3c:1099:10bd:2e8b])
 by smtp.googlemail.com with ESMTPSA id
 95-20020a17090a0fe800b00263f6687690sm2741396pjz.18.2023.07.15.07.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 07:29:13 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v5 4/5] intel_iommu: allow Extended Interrupt Mode when using
 userspace APIC
Date: Sat, 15 Jul 2023 21:28:19 +0700
Message-Id: <20230715142820.37120-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230715142820.37120-1-minhquangbui99@gmail.com>
References: <20230715142820.37120-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

As userspace APIC now supports x2APIC, intel interrupt remapping
hardware can be set to EIM mode when userspace local APIC is used.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/i386/intel_iommu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dcc334060c..5e576f6059 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4043,17 +4043,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
                       && x86_iommu_ir_supported(x86_iommu) ?
                                               ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
-    if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
-        if (!kvm_irqchip_is_split()) {
-            error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
-            return false;
-        }
-        if (!kvm_enable_x2apic()) {
-            error_setg(errp, "eim=on requires support on the KVM side"
-                             "(X2APIC_API, first shipped in v4.7)");
-            return false;
-        }
-    }
 
     /* Currently only address widths supported are 39 and 48 bits */
     if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
-- 
2.25.1


