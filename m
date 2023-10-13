Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D437C80D4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqv-00023r-00; Fri, 13 Oct 2023 04:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqS-00009o-Kh
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:33 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqP-00015G-Mp
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:32 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bb9a063f26so23023961fa.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186904; x=1697791704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vN7zbaDV9qsbxUyF/7PGOqcvOaxw8SCgdHuFArC3d8=;
 b=X+k4vt/p08uQIhGWAJFLp0KVnB7BWPTO2sjTaHZnX3KDUB6y/4RFrTLKjLRRST1Cm5
 3eqiAiBmMJY9BKCoICznNn5Gxc9G/0hn1nLu+GAlC8imzjxkaoGOxTJbbvu+28G9sv4Z
 lLhOOHux7UHFLYJ/u0epAwn2e8SRdui+7t+BOpXPytWR8Jpbzy+fmxpU4trRQR1bZ6Vo
 uJRIEuiwdcEC6PruEKiNtV+E3bugOwwn/97xkoIKL8FgodtpCrSK0ZOPoRwYFBI8kawW
 vvJJztuKufE2RzMReKjnNHdN653ddbnSvVUDL40vEzoSNDpFKc7IPqYJuFzzQi8c3wfY
 sxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186904; x=1697791704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vN7zbaDV9qsbxUyF/7PGOqcvOaxw8SCgdHuFArC3d8=;
 b=wb/KgqyeEGBJI2wdxKNUdc6Poi6fRoWSG6pUvGyPGOhzF/imK4Cm881JnoelTIrcbB
 KBVq4+y2wAGXNWFKljoY8QfrWAqo6jDuzx0va0pmh+itW3yX4aeCcI9FVlAeVOabKFnC
 fbuoGTxQJ7cVyR0cyDGZXwLn7lL5L5V5KV/49yXT9ysJTVNVJftAxqaJQh/jJ2F1kjxW
 kIoPam450ak0gWFAkcEj4hONfyZC23wHSn30zpOfApRcA84xI0z53SK8DjOHaPf8OAXh
 YuquLgJewrdmDxZzzPh6NjJGKkSCxpyxLWAvQtoZsX+F7RWIcAjqcM/4u6nsPkSOCxKF
 lwjw==
X-Gm-Message-State: AOJu0YxAfvVFsPPMP7pD8HAHLT6IAH5V+R0gOdpD7gfl4k6dwGJim4SD
 lR+hsS8h/Lba9sFY8TMF7ySNfgE/c7izhT08O24=
X-Google-Smtp-Source: AGHT+IHdw+Mzmgy9g1gohFJ+vRXQwY7373fbf60dMQbEM03YyH7EuHpsrg9Jluwk3SwA12fcwMwVIg==
X-Received: by 2002:a05:6512:5cc:b0:503:2d9d:8226 with SMTP id
 o12-20020a05651205cc00b005032d9d8226mr19668293lfo.17.1697186903841; 
 Fri, 13 Oct 2023 01:48:23 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:23 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Subject: [RFC PATCH v3 42/78] hw/i386: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:10 +0300
Message-Id: <067271cdae96ce1e3e6232d9c7c7b30c8c3941ec.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22e.google.com
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
@@ -2108,7 +2108,7 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
 
     switch (type) {
     case VTD_CCMD_DOMAIN_INVL:
-        /* Fall through */
+        fallthrough;
     case VTD_CCMD_GLOBAL_INVL:
         caig = VTD_CCMD_GLOBAL_INVL_A;
         vtd_context_global_invalidate(s);
@@ -2525,7 +2525,7 @@ static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
     case VTD_INV_DESC_CC_DOMAIN:
         trace_vtd_inv_desc_cc_domain(
             (uint16_t)VTD_INV_DESC_CC_DID(inv_desc->lo));
-        /* Fall through */
+        fallthrough;
     case VTD_INV_DESC_CC_GLOBAL:
         vtd_context_global_invalidate(s);
         break;
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index a731738411..d15e324f6e 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -2068,7 +2068,7 @@ int xen_be_evtchn_bind_interdomain(struct xenevtchn_handle *xc, uint32_t domid,
             }
             break;
         }
-        /* fall through */
+        fallthrough;
 
     case EVTCHNSTAT_unbound:
         be_port = find_be_port(s, xc);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b3d054889b..c1fd0a966a 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -605,7 +605,7 @@ void gsi_handler(void *opaque, int n, int level)
             /* Under KVM, Kernel will forward to both PIC and IOAPIC */
             qemu_set_irq(s->i8259_irq[n], level);
         }
-        /* fall through */
+        fallthrough;
     case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
 #ifdef CONFIG_XEN_EMU
         /*
-- 
2.39.2


