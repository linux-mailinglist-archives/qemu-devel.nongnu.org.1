Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFyvFarDb2lsMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:04:26 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E2490BD
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:04:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viG5B-0006sI-R6; Tue, 20 Jan 2026 13:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4y-0006bN-SJ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:52 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4v-0000Tb-Qz
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:47 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so537491f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768932224; x=1769537024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRzT62H79hhfu62kmgyNxqbBArhK3Nz4ofwZjq+4f9M=;
 b=yaOWa+S8VlTzAJkrLD5RrzSVHGJF1tAUf4QKXkivO5JRvsP1NOZp+2zUhAxcFz6aDe
 FDnXObURFZp4f/04mL3V0V8OgTKOxDg3/ejh9W9JCZkoSowcfvOA4q0iruApNz619pvI
 6OPxS2bD4lE8P0PAISiK1PmwR060/ZCeX88xhphMyWEkIg7YKoCDrdieXU6QqwSueViP
 nxFarWrWqAgGcUlASV0vmpsjAxty3yRlOcCAZOgkU7iAZPqfhBrGYAMnwg3dFjXT0auL
 AdGMbAu06bpAM20KAOU0thbE2m5KQMjyFRu0+QDRYH3pmp7Fg2khjtFBriZsSjRPljee
 cSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768932224; x=1769537024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NRzT62H79hhfu62kmgyNxqbBArhK3Nz4ofwZjq+4f9M=;
 b=XB5lKjXLtaUBY7lxKTaYzSByvlO4r0NWLgn7M65+cavD+NE5U6ij46Uokl6hF+q3+f
 3Gh61Q53fq2WFr9a76AoFqw99ZTfIuO/Xtb2u1V2UOpD/R1447LqCyB6fi8cgJPREsyO
 xE2BFZoTPrlJEDBwfOvcnTFVOGor4wP5LEp+pX4dpqmUZvbhw1w7QR7lf691BHo2SC3s
 L6ScSZYpq2v6c3VAaWTHdQsRHl488yng8wz8arfjAGurRls06srwtn5pIObhAkcIBq5j
 IpK5d2S9P4cqQGEl1w0cPqGo58t0p0kGfRa57dBX02BKQQpaFT+DabARXX7L5cRSHjvO
 cp8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpjsyYyUub9+tvVKkuApmWfxmtPWT9rH24zfPcqMv0OU2GmqiqyHpq6YjXkCu1UGccOMUJEserGQR/@nongnu.org
X-Gm-Message-State: AOJu0YznviEqvajcW26jCaeSe5QfrX1LzJtW0G+aRz/p9XWL7B+EcLnJ
 aO8Z75ML/9E2pFjNhLqeYpt6aGdE+u+7ZkauYTLXBXKgCi35WCjmVndqysqMZob3OjU=
X-Gm-Gg: AZuq6aIPlGyzIHNSQYYODnoRfUmpP20yGZ+0Ah3EgU+pVmLK1lCfoOPCs1QRa1EmKXQ
 JqEXmV2N0cLBimbbIiyI/nAuUGOvJBMm5SP6PHnVlXOpG1nyvvnyw/sIZ8fSZjt/foCxvlVwHJQ
 D4L5il2wiaA2s/PaMQFrLB+8OQIETkT0lpev1NUR9+eL8I4xnHEUrmr5INxMMYEO6zRLkfYulaP
 EFtqTc7aWCMr7mGW6gkhQWfL3ag2C5Ih0wHOn5LdmYVeHPaq9uzQSMAGtXOQsahB+RqV5RvNW83
 dbDx+jbxQweZJja7oyZizFGG9FbCv3K+kIMEZ4YvwTuIy7DGjILNG4CaBey4Bbm/mLxQtJu0SHI
 SsJKOsPvE4RGHfDfvC4+PJRiJYrMpDJXw9sN0sZGpgrw79BDVp67rRcy6aBKHSvBb5zekN2gFiF
 q7CfeixLbgpPXUxmcX2U83AVGhc+x2iZv3CLhhVAw9S0l6Jt7cMzzR
X-Received: by 2002:a05:6000:186f:b0:432:c37c:d83b with SMTP id
 ffacd0b85a97d-43569994296mr21748670f8f.20.1768932224074; 
 Tue, 20 Jan 2026 10:03:44 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf58sm31310889f8f.22.2026.01.20.10.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 10:03:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 3/4] hw/arm/virt: Drop VirtMachineState::tcg_its
Date: Tue, 20 Jan 2026 18:03:38 +0000
Message-ID: <20260120180339.1416328-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120180339.1416328-1-peter.maydell@linaro.org>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
X-Spamd-Result: default: False [0.29 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.20)[mailman];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:qemu-arm@nongnu.org,m:qemu-devel@nongnu.org,m:mohamed@unpredictable.fr,m:pierrick.bouvier@linaro.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[peter.maydell@linaro.org,qemu-devel-bounces@nongnu.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[qemu-devel@nongnu.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[peter.maydell@linaro.org,qemu-devel-bounces@nongnu.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
	TAGGED_RCPT(0.00)[qemu-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.gnu.org:rdns,lists.gnu.org:helo,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: 4D6E2490BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We now use VirtMachineState::tcg_its only in the
finalize_msi_controller() function, and it is always the inverse of
the VirtMachineClass::no_tcg_its class field.  We can simplify to use
no_tcg_its and drop the VirtMachineState field entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c         | 6 +++---
 include/hw/arm/virt.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a231aef268..b65f571532 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2082,8 +2082,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
      * the relevant user settings and compat data. Called
      * after finalizing the GIC version.
      */
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+
     if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
-        if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
+        if (!kvm_irqchip_in_kernel() && vmc->no_tcg_its) {
             vms->msi_controller = VIRT_MSI_CTRL_NONE;
         } else {
             vms->msi_controller = VIRT_MSI_CTRL_ITS;
@@ -3511,8 +3513,6 @@ static void virt_instance_init(Object *obj)
 
     /* Default allows ITS instantiation */
     vms->its = true;
-    /* Allow ITS emulation if the machine version supports it */
-    vms->tcg_its = !vmc->no_tcg_its;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5907d41dbb..577b4b3362 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -147,7 +147,6 @@ struct VirtMachineState {
     bool highmem_mmio;
     bool highmem_redists;
     bool its;
-    bool tcg_its;
     bool virt;
     bool ras;
     bool mte;
-- 
2.47.3


