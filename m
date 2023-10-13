Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EDE7C7FF6
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:21:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4q-00033L-Ua; Fri, 13 Oct 2023 03:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4j-0002Mx-SF
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:14 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4g-000727-TB
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:13 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so8804191fa.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183948; x=1697788748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/3hfCPHvt3e6pC8tdZlMAdusEcQDSsosJUnihPSBrg=;
 b=lYig3670Vvc0EXpHndq/Po2taUVIVlfmlj8kD3Ax5StW9UX7j8DS27dZuQukn6oaT7
 jZ8iVweGRinXi64p609Km38aftWOaB1ZPekEIT58BNjZZrJTULbtncHf3a21q2NicOnF
 OcGaBj3HQhNFfpMu7fAXHPxtcYxkWYl/oKwgQ3wpFHcIbc2iEfZupaZX88aUqomRqCHc
 URisUvYIUi9LqrdxJLogh5hRBR0UynRQ14W2B/hXZ+OxbPlmc2zwb0HYU+hgs3GYKH2o
 wjqyZHerQi2uYQJicSwlgwerwGeBNPl7JESj4XwRLFNGf5JYBvFXYUoNwz8OlLEY6yVs
 UK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183948; x=1697788748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X/3hfCPHvt3e6pC8tdZlMAdusEcQDSsosJUnihPSBrg=;
 b=vHWYUdDw03xAVN2Nbzx1gJyaMAgWWS9qDbkFN3wPd3ZrH6NItRivHgBT425GoR66ki
 Hz8OsoXYpG0G+qfVRDTYtinfDfiqLQBH0C+FCTEtfkShGali3DtlIs6ggmfm2kQsEjiY
 o8kOvVcEbzMKqveBZByWmsEw/NdY70280S8k/Ylg41h+tyz1l5rIAWfH0RjNn2MAs1lX
 VCy/8grCahQJnzR09AtWm53+wIcG9RdYKykgTww7tSiVZVikZCxpW+khiINPmTL9I2eW
 t3N0zjJWp+MOQLwFQwprIyZr4lWbm8wYkKtCP1IhzElfHyi4LxgvUf8Q3T9ZeEd5uFez
 Boyw==
X-Gm-Message-State: AOJu0YwpcjBvWzJVrMwpp7JWA1aggQF1H3tnJyYMO2VsRDR8ISrOOUuR
 hqYJ6+dT0KQ2gjjFDiBUkpXVJ5zMAVRNHB1KVXU=
X-Google-Smtp-Source: AGHT+IFpdn6OcpWWF/l1PcNfCvFL7NnMZDYWxlv2eCGiu9Z2TPEUR9/T5lFa4Z2X7NzpQI/SWlijOw==
X-Received: by 2002:a2e:7e04:0:b0:2bf:f32a:1f70 with SMTP id
 z4-20020a2e7e04000000b002bff32a1f70mr19333241ljc.11.1697183948652; 
 Fri, 13 Oct 2023 00:59:08 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:08 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Subject: [RFC PATCH v2 42/78] hw/i386: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:09 +0300
Message-Id: <c08e8dbf0e07552a72c1ae3f520592290279d799.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/i386/intel_iommu.c    | 4 ++--
 hw/i386/kvm/xen_evtchn.c | 2 +-
 hw/i386/x86.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2c832ab68b..bdb2ea3ac5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2100,29 +2100,29 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
 /* Context-cache invalidation
  * Returns the Context Actual Invalidation Granularity.
  * @val: the content of the CCMD_REG
  */
 static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
 {
     uint64_t caig;
     uint64_t type = val & VTD_CCMD_CIRG_MASK;
 
     switch (type) {
     case VTD_CCMD_DOMAIN_INVL:
-        /* Fall through */
+        fallthrough;
     case VTD_CCMD_GLOBAL_INVL:
         caig = VTD_CCMD_GLOBAL_INVL_A;
         vtd_context_global_invalidate(s);
         break;
 
     case VTD_CCMD_DEVICE_INVL:
         caig = VTD_CCMD_DEVICE_INVL_A;
         vtd_context_device_invalidate(s, VTD_CCMD_SID(val), VTD_CCMD_FM(val));
         break;
 
     default:
         error_report_once("%s: invalid context: 0x%" PRIx64,
                           __func__, val);
         caig = 0;
     }
     return caig;
 }
@@ -2513,34 +2513,34 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
                                            VTDInvDesc *inv_desc)
 {
     uint16_t sid, fmask;
 
     if ((inv_desc->lo & VTD_INV_DESC_CC_RSVD) || inv_desc->hi) {
         error_report_once("%s: invalid cc inv desc: hi=%"PRIx64", lo=%"PRIx64
                           " (reserved nonzero)", __func__, inv_desc->hi,
                           inv_desc->lo);
         return false;
     }
     switch (inv_desc->lo & VTD_INV_DESC_CC_G) {
     case VTD_INV_DESC_CC_DOMAIN:
         trace_vtd_inv_desc_cc_domain(
             (uint16_t)VTD_INV_DESC_CC_DID(inv_desc->lo));
-        /* Fall through */
+        fallthrough;
     case VTD_INV_DESC_CC_GLOBAL:
         vtd_context_global_invalidate(s);
         break;
 
     case VTD_INV_DESC_CC_DEVICE:
         sid = VTD_INV_DESC_CC_SID(inv_desc->lo);
         fmask = VTD_INV_DESC_CC_FM(inv_desc->lo);
         vtd_context_device_invalidate(s, sid, fmask);
         break;
 
     default:
         error_report_once("%s: invalid cc inv desc: hi=%"PRIx64", lo=%"PRIx64
                           " (invalid type)", __func__, inv_desc->hi,
                           inv_desc->lo);
         return false;
     }
     return true;
 }
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index a731738411..d15e324f6e 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -2028,71 +2028,71 @@ static int find_be_port(XenEvtchnState *s, struct xenevtchn_handle *xc)
 int xen_be_evtchn_bind_interdomain(struct xenevtchn_handle *xc, uint32_t domid,
                                    evtchn_port_t guest_port)
 {
     XenEvtchnState *s = xen_evtchn_singleton;
     XenEvtchnPort *gp;
     uint16_t be_port = 0;
     int ret;
 
     if (!s) {
         return -ENOTSUP;
     }
 
     if (!xc) {
         return -EFAULT;
     }
 
     if (domid != xen_domid) {
         return -ESRCH;
     }
 
     if (!valid_port(guest_port)) {
         return -EINVAL;
     }
 
     qemu_mutex_lock(&s->port_lock);
 
     /* The guest has to have an unbound port waiting for us to bind */
     gp = &s->port_table[guest_port];
 
     switch (gp->type) {
     case EVTCHNSTAT_interdomain:
         /* Allow rebinding after migration, preserve port # if possible */
         be_port = gp->type_val & ~PORT_INFO_TYPEVAL_REMOTE_QEMU;
         assert(be_port != 0);
         if (!s->be_handles[be_port]) {
             s->be_handles[be_port] = xc;
             xc->guest_port = guest_port;
             ret = xc->be_port = be_port;
             if (kvm_xen_has_cap(EVTCHN_SEND)) {
                 assign_kernel_eventfd(gp->type, guest_port, xc->fd);
             }
             break;
         }
-        /* fall through */
+        fallthrough;
 
     case EVTCHNSTAT_unbound:
         be_port = find_be_port(s, xc);
         if (!be_port) {
             ret = -ENOSPC;
             goto out;
         }
 
         gp->type = EVTCHNSTAT_interdomain;
         gp->type_val = be_port | PORT_INFO_TYPEVAL_REMOTE_QEMU;
         xc->guest_port = guest_port;
         if (kvm_xen_has_cap(EVTCHN_SEND)) {
             assign_kernel_eventfd(gp->type, guest_port, xc->fd);
         }
         ret = be_port;
         break;
 
     default:
         ret = -EINVAL;
         break;
     }
 
  out:
     qemu_mutex_unlock(&s->port_lock);
 
     return ret;
 }
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b3d054889b..c1fd0a966a 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -597,32 +597,32 @@ DeviceState *cpu_get_current_apic(void)
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s = opaque;
 
     trace_x86_gsi_interrupt(n, level);
     switch (n) {
     case 0 ... ISA_NUM_IRQS - 1:
         if (s->i8259_irq[n]) {
             /* Under KVM, Kernel will forward to both PIC and IOAPIC */
             qemu_set_irq(s->i8259_irq[n], level);
         }
-        /* fall through */
+        fallthrough;
     case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
 #ifdef CONFIG_XEN_EMU
         /*
          * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
          * routing actually works properly under Xen). And then to
          * *either* the PIRQ handling or the I/OAPIC depending on
          * whether the former wants it.
          */
         if (xen_mode == XEN_EMULATE && xen_evtchn_set_gsi(n, level)) {
             break;
         }
 #endif
         qemu_set_irq(s->ioapic_irq[n], level);
         break;
     case IO_APIC_SECONDARY_IRQBASE
         ... IO_APIC_SECONDARY_IRQBASE + IOAPIC_NUM_PINS - 1:
         qemu_set_irq(s->ioapic2_irq[n - IO_APIC_SECONDARY_IRQBASE], level);
         break;
     }
 }
-- 
2.39.2


