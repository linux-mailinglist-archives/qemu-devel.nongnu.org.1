Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3271B82B20C
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:46:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxEm-00083t-3b; Thu, 11 Jan 2024 10:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rNxEk-00083l-Am
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:44:54 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rNxEi-0007kM-Ls
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:44:54 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6dac225bf42so2937620b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704987891; x=1705592691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iumyWiRV4aypo77YQP2QuWFP+cC5Zxynr/zst/qlwqM=;
 b=musIrtoFkAUF3sDWKcYEbJ7afy3KfKdDI/cjMqNkq+YzhX0dsEmBVHvtT7+/+3r4nQ
 0OBfmictxUFOE5OCCYNYjB9iPVE1pm3/cCeULz3f8hcobP5NmehNIz6Qa8FfqOjeVSpv
 PWHEA3VY85Y0uqu3yV6nSjTScNQTwNsrRKYgPDA6U2q1NudmrF7YPJEFtroACR8svNK9
 c/N75pEzed+7Z7vvDmI5+I+ngX6fvAYhHXUS2FhoZEatU/Hnkm2pQGxeIkRSPZCvBnvh
 oYB6AXnQKXMg0a4qDb/1hSz9MNsn3P7+ItrU+qnQNdhFcW060UCwfgOeQ8nEQDFoVAbH
 Adcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704987891; x=1705592691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iumyWiRV4aypo77YQP2QuWFP+cC5Zxynr/zst/qlwqM=;
 b=IH1TWDJxRPglK1iXAvh03JlQLEtdj2932HpH7TFzxu9j83+eLWoJdw4re0htZTVnSj
 JtK/N3eBaA/5bWmhom74AClZuPh1ILtbKoxIGFc4cA/9K6D9WwCqrJS4IRY84yCMRwWb
 hBElkvWjakHbK6Bz2TMuVs5LPN98vZ3yV2H6NmXA2yAYGRb8Esvj6IEhJOUVBH6iowHI
 AQ+KQWdYCuOkyTMTwG/SLQNnhSfs9gUg+S01RJJya8Awnp7CTCKZKv5INlaCTiq5l2hu
 1XotNywsAtCLx3yEGOTTIUGLDRLWvtMz31F6dOBPbimw4EAq3HZ5bRHJ3seKWTLmfiP5
 /Q+A==
X-Gm-Message-State: AOJu0Yzoyxy1qZ0/4FkdjMUzOlndxJkV77iYjhMeHZOEFrdX+hTbfM7s
 fqfSQ7Yh+2GtsPnSDvcUkdB7C3uZSj51P2fK
X-Google-Smtp-Source: AGHT+IFrg+MRfHbQnRSw8JsZHbNmupiWNdfwQgMwIPtDlyrDazhH0Se4aPjEeqz4Yiix+VnQU/21ZQ==
X-Received: by 2002:a05:6a00:b1d:b0:6d9:b242:e47 with SMTP id
 f29-20020a056a000b1d00b006d9b2420e47mr1281227pfu.42.1704987890618; 
 Thu, 11 Jan 2024 07:44:50 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:e868:3e48:c113:4a7f])
 by smtp.googlemail.com with ESMTPSA id
 fb9-20020a056a002d8900b006da550512d8sm1317887pfb.126.2024.01.11.07.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 07:44:50 -0800 (PST)
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
Subject: [PATCH v12 4/7] intel_iommu: allow Extended Interrupt Mode when using
 userspace APIC
Date: Thu, 11 Jan 2024 22:44:01 +0700
Message-Id: <20240111154404.5333-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111154404.5333-1-minhquangbui99@gmail.com>
References: <20240111154404.5333-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x42d.google.com
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
index 1a07faddb4..cf933189d3 100644
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


