Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A97E6D52
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:24:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16sf-0007hZ-P6; Thu, 09 Nov 2023 10:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r16sc-0007at-6n
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:23:38 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r16sa-0001d9-MZ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:23:37 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so824818a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699543414; x=1700148214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asPbK5RsxzV7D2i8+TJweFfezDNcRjnY/Rk2pVdzoJs=;
 b=QoY6coLAlhR8Iei7d9xMrBJpS1SXGdti7+bDXvAYVz4IMcpcBTXk+5+hJXwi+4YBJ2
 F5mID0mgWnufv9/+M4bRJBFxybcL9eaggbmBNRTmPy+pO7XqOtDei7Q4tHXeuan2s4Ak
 4nD0fT3MBP/y/ttuCqRx6OXWzMh2iJXlwerkaIYLGrQL4cVgqDSFsN3w9h0siMVzC69Y
 zsG8gbq+B0wm+VKXlDxSI/ElXdVnEE/DbhF9xCaLGGH4vxgXf07EQTuHUISKFMh/TFBp
 DJdWyBUDgBDhIwGYErSfdRmAf1TL/qznpmVmFhR0LBEN+j86Bm2iUy3XTYn9dI1FeIaY
 UORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699543414; x=1700148214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asPbK5RsxzV7D2i8+TJweFfezDNcRjnY/Rk2pVdzoJs=;
 b=eEH0zXRyy4MOlVRNIU/1ZIobYOWLXjplRgNMKJa6hCE1dXoUNdtkDNrPYzyjMN+wgQ
 KwrdyUNAthCGemtJm7w9a40vtVoP1vVB7HxhVptI2xh+hQcRSXtQAkZBnzb2jjpM6dko
 oYIehG0quXbhpTUUsqytHfDpzx6LPQoPZisFtyZZNAkbqL7iwa+gjKSQSjO1V7Yafv6P
 URGPGLE6vrEvCAbuxbqUK1n0zncJN8DoqmAwoEm2ht6VDkUizU1xfke2kyDkk7+q6y45
 XtHa/56SpmEQjhvuMIZf2lbcX2ERygV/mq90DDqt5qA99QHgohJvi9QhnfV+NdmMXqTD
 LKrQ==
X-Gm-Message-State: AOJu0Yxo83ncT6peNy42IhjSpNQSe/XS0rp/mi4WdQuf75475tV7Jq7x
 LnffxdzTIUxtRTc+1PaXvjxcmQpaQsa2uw==
X-Google-Smtp-Source: AGHT+IEtRee4GFSDi/c3SZ8mZm7Bn89MC85KLqbnvInwwup9EkMxzzgUaAR5mxtQg7wFiDbeeOOliw==
X-Received: by 2002:a05:6a21:7903:b0:181:a1b0:c330 with SMTP id
 bg3-20020a056a21790300b00181a1b0c330mr5904684pzc.60.1699543414617; 
 Thu, 09 Nov 2023 07:23:34 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:b178:6138:397c:2ce7])
 by smtp.googlemail.com with ESMTPSA id
 y16-20020a17090264d000b001cc311ef152sm3707107pli.286.2023.11.09.07.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 07:23:34 -0800 (PST)
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
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v10 4/7] intel_iommu: allow Extended Interrupt Mode when using
 userspace APIC
Date: Thu,  9 Nov 2023 22:19:21 +0700
Message-Id: <20231109151924.267515-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109151924.267515-1-minhquangbui99@gmail.com>
References: <20231109151924.267515-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pg1-x52a.google.com
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
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/i386/intel_iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5085a6fee3..cb6ce4a646 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4124,11 +4124,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
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


