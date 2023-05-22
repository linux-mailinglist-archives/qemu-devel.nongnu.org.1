Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1740E70C382
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 18:34:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q18TR-0008Gy-AN; Mon, 22 May 2023 12:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1q18TH-0008Cl-F9
 for qemu-devel@nongnu.org; Mon, 22 May 2023 12:33:23 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1q18TG-0007Ek-1C
 for qemu-devel@nongnu.org; Mon, 22 May 2023 12:33:19 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so5593021a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684773196; x=1687365196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6/zjOobvc7cf9qx61tYpbF7FC6It59q0VtbHveMKkw=;
 b=jRVjuCfv12XNCNxoP/1DUlR7PLfX52W25ezKf1KdTVhOzXSj+iBgExtcKq1r9tA43C
 fU9dCmaVJEhbmm5HyI9kHWeMIIxhx23qhtqEZR/YvCaskHPm8W3QjhFo4zkfGkss0RzN
 DQSdgOBlzYRbvhJeP0rqLjQRGbpGDd8+Hp5mMeDjqwZN9tXMda9SXCgI9r3J12HEmlSy
 1JAwGiB1DDaQkf1Aaup4anfGLFQtOrhirs7MUesNSEIzvW6Z/pImxR8ZGuO/gjGhnRUU
 OHJnKl2/cktwZNiKrLOp8uwlNVM0Oww9rlt5dvX6BzzyRfma6WDHfPLRlLbHW1Y3nAvj
 naXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684773196; x=1687365196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c6/zjOobvc7cf9qx61tYpbF7FC6It59q0VtbHveMKkw=;
 b=OUoGKD+hKvYtdYR7Ju0Y0HvE45l5pJ0zvt5xTPw3pZ5Ct1Q4ZlW0AJxxoDDeqcyd3S
 8vBxgBVoiP/ofh3xD3O4oBrLWy7tnkOZfYha1DwlYy6HDkMOLd9xnu6XJlhh2wxTX+O9
 tdJM7ayol5+AOkGXIvZme1n8InJfTw0J8yPIt2RVnecNXj4GpgkGzXq4RYSjIkli/+w1
 759goU6VcpKc+/k4//gDdt4waC5lC1cRSd3m92O7oRUwSZ5A/tayQ/1nmOdn2hKp1Tbe
 ZWAEDmcB0OQzAVyHfh/vXId2yV/JLsRdwa4d0blpbTQSGDfzG4Mrvs3ZDlNA3d2O0Tr+
 Eysw==
X-Gm-Message-State: AC+VfDxORe2mIhwSURcq7Ri0nptCQQAl1I9VqwdzdEBaaXPVaMpsyORQ
 lVTodN4QUfLPNq/0YwQaJX4nhFgb+kBhUA==
X-Google-Smtp-Source: ACHHUZ6zylJ1qw/UWS6NDpc0Yu51ucsJbvkbaFS4gnpCLUfmRpxREoc3NWcFz757Uy1j9Xth+ce96g==
X-Received: by 2002:a17:90a:6c06:b0:255:9f00:c48b with SMTP id
 x6-20020a17090a6c0600b002559f00c48bmr115043pjj.10.1684773196109; 
 Mon, 22 May 2023 09:33:16 -0700 (PDT)
Received: from localhost.localdomain ([113.173.119.15])
 by smtp.googlemail.com with ESMTPSA id
 s5-20020a17090a2f0500b0025393752cd5sm12293253pjd.1.2023.05.22.09.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 09:33:15 -0700 (PDT)
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
Subject: [PATCH v4 4/5] intel_iommu: allow Extended Interrupt Mode when using
 userspace APIC
Date: Mon, 22 May 2023 23:31:56 +0700
Message-Id: <20230522163157.9754-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522163157.9754-1-minhquangbui99@gmail.com>
References: <20230522163157.9754-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pg1-x530.google.com
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
index 94d52f4205..dcaa733972 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4046,17 +4046,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
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


