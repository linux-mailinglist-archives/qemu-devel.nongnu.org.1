Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B387D5626
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:23:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJFt-0006Z7-SW; Tue, 24 Oct 2023 11:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qvJFq-0006XT-PL
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:23:38 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qvJFl-0003RG-Fp
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:23:38 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-352a3a95271so15648365ab.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698161012; x=1698765812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+DcP9rpz5JyLOwB7KXd5+DJgILMyX9VqImS6IR4us0U=;
 b=SR8ynAw+bGSQaJnDR4VrGxu5kIukkOrNo5g3exRpQ+XWiRYGOZJWbVTwtxznLs/VFm
 m9VPueOC4gJYRMSsXkNE85Ea7tPyVnBoKz+jk3mDmcGSdgf8JZB5cavsnlwC2KmTBve/
 MR/E6w+m0IBnbkv7rhyLx9L8E/E+TynN3oGf+UuuHTVULK4MGpPljFZfg0m0CRY4u6zQ
 mb1s6NhndeVE6MEND4QcqjXhJ+wHNX8MJxjs4pV0oCesDnywtylJ+OYEzFTMCnPwklDD
 j1LEx7WAwn30ouFwae5AI46uUe7ju4/CYn3ItxXNToE2K4lYnoaNnyfK38nLgNPsg4xV
 yeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698161012; x=1698765812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+DcP9rpz5JyLOwB7KXd5+DJgILMyX9VqImS6IR4us0U=;
 b=xQNuKZWuxPeaKVbo5utiN77kYyR3WrxAR66CBMOKc5k5H3z3/NspwjS+4lVkU0WL/a
 u5VaQVjB5PzzHYLTPfoANAy+8Y0on1zO54iiXi7U5oRoiI9LaIf6UzrKBGV8SMi8YMRf
 uNFahM6O7k2YH4blOmq2jb6+g4or43gmoF90zfotDWqy808gdviOLA3y0zivx9F4Un4B
 kFzLLchIhYyRksAUG1PYmCky/+5mh72PteyBYd8uWCPxVrvOVbel1qh1LrnM/OplCNhz
 ChzbHRR9vPQMuoBh72nMAeYVOTQcSK8ODDndd/AICfyNaVONxK6X05od3xwFAo1Ppm+D
 aK6Q==
X-Gm-Message-State: AOJu0YySzlitJSOjQnye0z6a916ePAeG26nd9+v5yGCqUzNmIHLuhWiU
 heeSq4S1CsZuWlfwVsfFWizl8ztqy7p3lw==
X-Google-Smtp-Source: AGHT+IHTBfZJh08rrg2DrtdwGrQOKQAeoBgf+hDfulE69nm0UUBP+457s3E9vCA98cveXbJUMg6IVQ==
X-Received: by 2002:a05:6e02:784:b0:34a:a4a5:3f93 with SMTP id
 q4-20020a056e02078400b0034aa4a53f93mr13142918ils.5.1698161011926; 
 Tue, 24 Oct 2023 08:23:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:647f:b391:99d7:635d])
 by smtp.googlemail.com with ESMTPSA id
 t29-20020a63445d000000b005ab46970aaasm7196180pgk.17.2023.10.24.08.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:23:31 -0700 (PDT)
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
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v9 4/5] intel_iommu: allow Extended Interrupt Mode when using
 userspace APIC
Date: Tue, 24 Oct 2023 22:21:04 +0700
Message-Id: <20231024152105.35942-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231024152105.35942-1-minhquangbui99@gmail.com>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=minhquangbui99@gmail.com; helo=mail-il1-x12b.google.com
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
index e4f6cedcb1..848511b7f8 100644
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


