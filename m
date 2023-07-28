Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8BB76703A
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 17:10:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPOhD-0001KK-F7; Fri, 28 Jul 2023 10:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qPOh6-0001Cv-6h
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:43:53 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qPOh4-0007KL-Mq
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:43:51 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686f8614ce5so1666107b3a.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690555429; x=1691160229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqwgwAAsupc0AHZNbOVGsdBNgg++BIsLXINymB8kESI=;
 b=QedjZrpHOkRZimlEsIPBHS133LzGDBMQAeXb8Z+ul1aq+T8QPmOACd9cEQ6rCTd8rW
 aTYSF639sVey33wlhcnZkyNEJYyWfYcNbucm+oARfGNgdjJTsCZDFWvSXlSZg2pYV114
 O8q9HHJvlz1Ce7s9JcgeR9wEymPSzF8VreVStVKzM/LktFhDkKB3OpMkcJYOeoQMfolp
 B/gCfngTo2sg5dXBnz0ZPLUjVmKGKQ9ToMWwA3zXkJ2rBIxtsoDq7v3VqYBhCh8fQuXk
 4PL9zlnq/2nNjJQ881zjsXYsL7QvpHQ3tRWQJqMeDpn4tWFWsdTHfn/dgiCSMYlday6l
 Wocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690555429; x=1691160229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqwgwAAsupc0AHZNbOVGsdBNgg++BIsLXINymB8kESI=;
 b=kjJqjgWrr8KJsy6RV0ArpbN3vYThq+HlsHQdqPzlLYqAFvV9MPnvbHisyz9ZKotS+n
 U/L5GFboWM4PxT/PayALN8PluVcTQVQHil7Qv6UzgcX9zdSDiwX8/t/uj567oDQxiFb6
 1zF4hbNsRMVYOsMh7VB9wKZ8Zy0teQQaTMRvXBCBvhoAqpWJGYMNfI0M89RhuG7aA86X
 acH34YJRBGqRkFTh2E/lnxM0F4JR9H0ImrtJYMeaSwgmTOtxsHsVv6nDHrvLI/by2oCI
 IENDujP+M3NUWc58fiDdG1yojiZndggYzw/AoGmnGEifoCw3KjtnJ2esjWTyBP9JwIUA
 7ikw==
X-Gm-Message-State: ABy/qLavS2Sti16UOZe+eX4OzaAi0TucNGYKb7AumOahCsfaxp85DCZx
 smLBJcv+iibe4xM3qIYOP0BMpcRYOvKuwg==
X-Google-Smtp-Source: APBJJlHAslXoS5DaOgVOa9X6l1OUQPLtq/Msxrd8rVydEOaalnnsRYYNkJhzKgNupjF+FQ3xDViL0Q==
X-Received: by 2002:a05:6a20:7495:b0:137:5a89:daf5 with SMTP id
 p21-20020a056a20749500b001375a89daf5mr2475129pzd.28.1690555428903; 
 Fri, 28 Jul 2023 07:43:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:4fb3:b780:7648:9253:33f7:7434])
 by smtp.googlemail.com with ESMTPSA id
 m26-20020a63711a000000b0052c22778e64sm3533372pgc.66.2023.07.28.07.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 07:43:48 -0700 (PDT)
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
 Jason Wang <jasowang@redhat.com>, Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v7 4/5] intel_iommu: allow Extended Interrupt Mode when using
 userspace APIC
Date: Fri, 28 Jul 2023 21:42:28 +0700
Message-Id: <20230728144229.49860-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728144229.49860-1-minhquangbui99@gmail.com>
References: <20230728144229.49860-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x433.google.com
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

Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/i386/intel_iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dcc334060c..f7ef4e2cfa 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4044,11 +4044,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
                                               ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
     if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
-        if (!kvm_irqchip_is_split()) {
-            error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
-            return false;
-        }
-        if (!kvm_enable_x2apic()) {
+        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
             error_setg(errp, "eim=on requires support on the KVM side"
                              "(X2APIC_API, first shipped in v4.7)");
             return false;
-- 
2.25.1


