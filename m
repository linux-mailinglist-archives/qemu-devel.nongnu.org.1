Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DAE7B640A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnal4-0005Tb-LK; Tue, 03 Oct 2023 04:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnal3-0005TL-0e
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:27:57 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnal1-00083W-C9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:27:56 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5041d6d8b10so766786e87.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696321673; x=1696926473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLDFiGj6aFnMNrOsUcD90TH387DbLMzLOhHMLFfm8as=;
 b=CDs2ZZkwojIERq4JmlhF1hv/5Wcp826q1cvlx+hQCVnaAIUyqU3ggACrxG+/U6nmmz
 lFiXDdViwOSBb9nEh+5VSAh3qlDcM+4qfjZO52Xbk3jypLD1ngenJbPVtccp5WzxJ99/
 uJjjoH3rvCGCfH75qplPN5mFzz8IJQD9Udc+KgL4dvpHaKohQCzOU+kKCBO1er/WJ38W
 rqNNHcz3xHLOYfQVn6JvC7kYUv3J9AzQ/0JgLPhjfEZwNrrQSVe7mcTi8+NpiqbQo0tr
 LSKI6U7hBuj0aDyTYWgeejaaOEERYBoiUQpwLx8jCgvLhzqI50RGRiX8Lo8Rf65zCJQs
 0yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321673; x=1696926473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLDFiGj6aFnMNrOsUcD90TH387DbLMzLOhHMLFfm8as=;
 b=cQQyyzqV0Dv/qtMwJKAfDxinXp7ra9ZIvI49MociuMVpKtScFxotPO0qUKV8ZBswmh
 CKhFYINJIcg6IbmbB6zb4j0OfPO9v0hGkPpXotwD+1HXU820e3vcljLWYPWkgM813/Xk
 R93KWdRENGZxileI6HXSciuan1DstCnQABCIaaPup9bnfD0L0bvf2cTtHxgzPmXqSAq4
 XUvVr5vLokhetMoovzpePdxlc4K0YvEQGDYYRKEVoeZe4CV+HHz4kPK/EYtEaMtOZoOa
 oSv+q7Fnk5XtQH0XO9Bb5RTwgznF5l3N+SwaTw+cVC2bvkR3pLYmsxwgqiYEiCH15Cbz
 SzPA==
X-Gm-Message-State: AOJu0YzjkyR4oClHDcbtb9BgOx2H3EEjENsJp7/HBbUIfZX4MukeObyU
 sYVpsJwy4QHjzSGpWftbnqW9kXQQsimSaqekeVXGig==
X-Google-Smtp-Source: AGHT+IE9DhGdJEdRvuEhu0sBcxhTR7XPwaD2+0uen0B4Pmgk0wXZ+xqeP6aRWS68eYgCqpQvQ/ubqQ==
X-Received: by 2002:a05:6512:704:b0:500:b42f:1830 with SMTP id
 b4-20020a056512070400b00500b42f1830mr9096945lfs.63.1696321673204; 
 Tue, 03 Oct 2023 01:27:53 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a7bc053000000b003fefaf299b6sm698061wmc.38.2023.10.03.01.27.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 01:27:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/5] hw/i386/apic: Simplify apic_get_class()
Date: Tue,  3 Oct 2023 10:27:26 +0200
Message-ID: <20231003082728.83496-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003082728.83496-1-philmd@linaro.org>
References: <20231003082728.83496-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

Now than apic_get_class() can not fail, remove its
Error** parameter. It can't return NULL neither, so
simplify x86_cpu_apic_create().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/apic_internal.h | 2 +-
 hw/i386/amd_iommu.c             | 2 +-
 hw/i386/intel_iommu.c           | 4 ++--
 target/i386/cpu-sysemu.c        | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 5f2ba24bfc..e61ad04769 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -225,6 +225,6 @@ static inline int apic_get_bit(uint32_t *tab, int index)
     return !!(tab[i] & mask);
 }
 
-APICCommonClass *apic_get_class(Error **errp);
+APICCommonClass *apic_get_class(void);
 
 #endif /* QEMU_APIC_INTERNAL_H */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c98a3c6e11..0a95025ab7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1368,7 +1368,7 @@ static MemTxResult amdvi_mem_ir_write(void *opaque, hwaddr addr,
         return MEMTX_ERROR;
     }
 
-    apic_get_class(NULL)->send_msi(&to);
+    apic_get_class()->send_msi(&to);
 
     trace_amdvi_mem_ir_write(to.address, to.data);
     return MEMTX_OK;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2c832ab68b..dffe3583bd 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -397,7 +397,7 @@ static void vtd_generate_interrupt(IntelIOMMUState *s, hwaddr mesg_addr_reg,
 
     trace_vtd_irq_generate(msi.address, msi.data);
 
-    apic_get_class(NULL)->send_msi(&msi);
+    apic_get_class()->send_msi(&msi);
 }
 
 /* Generate a fault event to software via MSI if conditions are met.
@@ -3554,7 +3554,7 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
         return MEMTX_ERROR;
     }
 
-    apic_get_class(NULL)->send_msi(&to);
+    apic_get_class()->send_msi(&to);
 
     return MEMTX_OK;
 }
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 6a228c9178..9038c65267 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -247,7 +247,7 @@ void x86_cpu_machine_reset_cb(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-APICCommonClass *apic_get_class(Error **errp)
+APICCommonClass *apic_get_class(void)
 {
     const char *apic_type = "apic";
 
@@ -266,7 +266,7 @@ APICCommonClass *apic_get_class(Error **errp)
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
 {
     APICCommonState *apic;
-    APICCommonClass *apic_class = apic_get_class(errp);
+    APICCommonClass *apic_class = apic_get_class();
 
     cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
     object_property_add_child(OBJECT(cpu), "lapic",
-- 
2.41.0


