Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3B781E19C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 17:43:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHo2F-0006Bi-1B; Mon, 25 Dec 2023 11:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rHo2D-0006BJ-KS
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 11:42:33 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rHo2C-0001iu-7N
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 11:42:33 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5cd8667c59eso2910992a12.2
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703522549; x=1704127349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asPbK5RsxzV7D2i8+TJweFfezDNcRjnY/Rk2pVdzoJs=;
 b=CjvchUiVf/TNW3zdlUGhVOTiZvRw7GwofVp88bfyyd+ScfS4dJuJytMKLi19i19vBq
 P10Fjjf0dtd/Hu1gM+aJ2Eft4LfuWpTjvIikUM8MYUbolbzIP5mCfh0x522zpVbmzXqv
 LKzJNEcyQ7cRI3I2UK0OaehR/S/0hKEG+bSUcT4GByYFocMv3Y75qcqTH+4SKMh3jKLR
 jmxtMCCwLWEgxr8ZojYtWuHgVqEJXY7J9X0UOoUMjxSdaEqyGwA/HW6CC9mJ2SImRe4D
 z6hWgnX9LtYMXFFxP6PlsZEDvk1uD9i+hWtLmbmsA9+qZErU+amTQ3RSVIrM6MuHaWBn
 vFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703522549; x=1704127349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asPbK5RsxzV7D2i8+TJweFfezDNcRjnY/Rk2pVdzoJs=;
 b=E5R3HB9r4FYJcLAhPiqxWkFaLaC1zfKcCgNVq2h/OfSneThh5//QkcN+UgqxK0I1tB
 DbXTFDMbjtlonHHa5bXX/0MDltR2dUNnCV47dtSOLpk46IW76PPJ7vdpLqvGmUktycsf
 l0H+r+p/9QYQUYPU1ubAe7MJnPFcFXDR/XCaeIdCri8x3z3fKj6wiKFndmYd3vN72QVL
 eamjcTcLdfsLhKcVEz6XSsYMRTr8coTUd8zTHrdBoeAM1lR2rNftIlDYO0Yu/vrRs2In
 1yRWVMdyVYPuRopESg1uMQiXsMec9yRTrpbkl3awz3C6Uu+1VIqd0bsmvJQVr7j8vnlh
 HRhg==
X-Gm-Message-State: AOJu0YzMOMgpy74wn/WNmu7+yuL93Va7WIjrX6yQoNolqfPm7CmOPhoO
 rSQaxDLttpdXXWz2Qu5kVufTHK5JnSX7bg==
X-Google-Smtp-Source: AGHT+IHzWNY0PGUe261GPjy4tgJss5FG1cTCZ6995aRXTDDAL4t9RsYf8hP0vi7JozpLWSCtGsMR+g==
X-Received: by 2002:a05:6a20:4294:b0:195:992a:f7e0 with SMTP id
 o20-20020a056a20429400b00195992af7e0mr3083320pzj.56.1703522549382; 
 Mon, 25 Dec 2023 08:42:29 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:d7ef:8aab:5b58:14b2])
 by smtp.googlemail.com with ESMTPSA id
 x22-20020a63fe56000000b005b92e60cf57sm8092928pgj.56.2023.12.25.08.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 08:42:29 -0800 (PST)
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
Subject: [PATCH v11 4/7] intel_iommu: allow Extended Interrupt Mode when using
 userspace APIC
Date: Mon, 25 Dec 2023 23:40:58 +0700
Message-Id: <20231225164101.105958-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231225164101.105958-1-minhquangbui99@gmail.com>
References: <20231225164101.105958-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pg1-x52f.google.com
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


