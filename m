Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D54DA7EB4E5
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:32:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wKO-0002zx-0j; Tue, 14 Nov 2023 11:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKM-0002z9-4k
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:31:50 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKD-0006SW-Jh
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:31:49 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-54366784377so8939090a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979499; x=1700584299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SmG1RvmEVqSdouF1EAJ1JhQ2v4iViVsF9xcNQ9FZB1E=;
 b=fd33UyHfhL2KOd+4pQXKOa+ousREo4ROPZ4hdyTygjHyzfyVcaRW38i7tqMIaVIp1D
 RUsL/tjO2N5dticujcIs+eF6citKuRq+hCMw01Rj6edmUJx/JgFLKqlPOSkR9eWFi1Si
 buXknv6BgDcH1rax8rjGYn3Y5q0s8eSXPd1Tz2fDOHGwnXdhO0mfthxU2k64ojctQCER
 f0fKefSjkPcef+hxmL9Xjs/C4AXrcIeHQyCK8Zc8FxZGiAGDNKtoJ6EdKAxJcRCPWCqx
 MpKFteY9VW6Z/GmCQyIDZJAC7aD84AbAMP8PXuH51V7/DrxgO+Up1WUnEzwe5018AFJU
 5Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979499; x=1700584299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SmG1RvmEVqSdouF1EAJ1JhQ2v4iViVsF9xcNQ9FZB1E=;
 b=XnFV4r7sBSuZczPBX5UiPMMJ6emuYF/yMoU6XP85NNLCQ1lYGm1oIwI/InoQnbCu0E
 +FIrXIDMFkTwZs+x+gOXrqaOM8aX3dgFtShzRcyxW8EtHU873RHli+CIPy7qbnrmzHgy
 cz40avnsN+6O3Z+4fqWbK6ftgZalWD4u6hmozdDJWgFrwXa4t/OICXhwB9kitfEYjomB
 uhhGZOuaJZzHU6am5OIlyjM4izq5DmyiK2F9CJ0fOrlpEaQHshspOSQV6dmDdiDBnNva
 6g/oiTHVRiQ42RGESlZ9GLxi8PnHBoozT6wUBMvon6VLqzzXCQMtuHy9t6j4PaZA2aM+
 F1lA==
X-Gm-Message-State: AOJu0Yy25khauJ1/l/Y8lflsMn8m95hcvCWnp+zDDNdbvzNw6IOYXfKE
 dFI87RklKDUgIARo4vAFET710oQyVlKd0kGmo8o=
X-Google-Smtp-Source: AGHT+IHL3uPIWo3k1FIfttqQPpxRZY2ZBH7YhX3W4Qy+3Zh4pc0MQhOvVP2dpnkHA2n+Lr+G86EpBQ==
X-Received: by 2002:aa7:c487:0:b0:547:cbc:e07d with SMTP id
 m7-20020aa7c487000000b005470cbce07dmr7903450edq.1.1699979499591; 
 Tue, 14 Nov 2023 08:31:39 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 d17-20020aa7c1d1000000b0052febc781bfsm5326899edp.36.2023.11.14.08.31.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 08:31:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.0 2/9] hw/xen/hvm: Propagate page_mask to a pair of
 functions
Date: Tue, 14 Nov 2023 17:31:16 +0100
Message-ID: <20231114163123.74888-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114163123.74888-1-philmd@linaro.org>
References: <20231114163123.74888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We are going to replace TARGET_PAGE_MASK by a
runtime variable. In order to reduce code duplication,
propagate TARGET_PAGE_MASK to get_physmapping() and
xen_phys_offset_to_gaddr().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/xen/xen-hvm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 8aa6a1ec3b..3b10425986 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -174,11 +174,12 @@ static void xen_ram_init(PCMachineState *pcms,
     }
 }
 
-static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size)
+static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size,
+                                   int page_mask)
 {
     XenPhysmap *physmap = NULL;
 
-    start_addr &= TARGET_PAGE_MASK;
+    start_addr &= page_mask;
 
     QLIST_FOREACH(physmap, &xen_physmap, list) {
         if (range_covers_byte(physmap->start_addr, physmap->size, start_addr)) {
@@ -188,9 +189,10 @@ static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size)
     return NULL;
 }
 
-static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size)
+static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size,
+                                       int page_mask)
 {
-    hwaddr addr = phys_offset & TARGET_PAGE_MASK;
+    hwaddr addr = phys_offset & page_mask;
     XenPhysmap *physmap = NULL;
 
     QLIST_FOREACH(physmap, &xen_physmap, list) {
@@ -252,7 +254,7 @@ static int xen_add_to_physmap(XenIOState *state,
     hwaddr phys_offset = memory_region_get_ram_addr(mr);
     const char *mr_name;
 
-    if (get_physmapping(start_addr, size)) {
+    if (get_physmapping(start_addr, size, TARGET_PAGE_MASK)) {
         return 0;
     }
     if (size <= 0) {
@@ -325,7 +327,7 @@ static int xen_remove_from_physmap(XenIOState *state,
     XenPhysmap *physmap = NULL;
     hwaddr phys_offset = 0;
 
-    physmap = get_physmapping(start_addr, size);
+    physmap = get_physmapping(start_addr, size, TARGET_PAGE_MASK);
     if (physmap == NULL) {
         return -1;
     }
@@ -373,7 +375,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
     int rc, i, j;
     const XenPhysmap *physmap = NULL;
 
-    physmap = get_physmapping(start_addr, size);
+    physmap = get_physmapping(start_addr, size, TARGET_PAGE_MASK);
     if (physmap == NULL) {
         /* not handled */
         return;
@@ -633,7 +635,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
         int rc;
         ram_addr_t start_pfn, nb_pages;
 
-        start = xen_phys_offset_to_gaddr(start, length);
+        start = xen_phys_offset_to_gaddr(start, length, TARGET_PAGE_MASK);
 
         if (length == 0) {
             length = TARGET_PAGE_SIZE;
-- 
2.41.0


