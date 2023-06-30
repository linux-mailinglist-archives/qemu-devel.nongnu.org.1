Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9C17435F8
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:39:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hT-00026t-Uh; Fri, 30 Jun 2023 03:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hI-00023p-5F
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:41 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hG-0005Q1-2R
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:39 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-98df6bc0048so182951866b.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110656; x=1690702656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9VshA+nEvMeFHx9v6+4HVVvUJImbOd3NSibU4Qf9Cg=;
 b=CpatTUw/t7XCQaHdjk52TbqXO/d944AVcGs5NdHCyjIUX0EWqnasKNKvSedClVXptf
 fwv5L6sRsXcBupjlz5ysn1DyuV7HNaiT4PohWZjPP+FXkiEapEqaMNutVSQBR6yB0Aig
 jSB0j+s1OUB2ZvZiyJLy15t03Kjlp9EeTiOBX3QB59mUC+6VHMrj/TJcVYmzUp8QtBgy
 UjCr3AehrRcnam3H+B1sTpwrtvHf/4t/98sK48QKip+nJcXQBulmnCSeIKkBArbW0ErL
 QVfD0Izfb5pQTUQJyYDyfiUGO7msb5Nh2vb2Ll2AdjYDeEX/8QnRfV4tori87yVRoBGm
 kmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110656; x=1690702656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9VshA+nEvMeFHx9v6+4HVVvUJImbOd3NSibU4Qf9Cg=;
 b=amlZsqVB7oqb8H8LI+IVBRWPQU7fV2x2NXqikT0RboIYfn9duBwNQWnfp4g+AGeAJj
 mlLWRz/KwZ+trv8buj4HXdj9yKr5buNBAVJxgq+CTDkHK8r5SM3l0qTxdC7GMDryn8Qh
 /7M2S9+UiUzArABNdqzAuIVboa+ggLM/rLOLORbwneAquij8pS6/mgN8ISVXMi+rRwoi
 dRxrQ3Fj+FhGfUNCcH+RX4pfsRKayoHy1oyVOerTV2Cq9nuVOL4ndsay03irFPGm3UXM
 9vC1bt7Ae8A/GxDaBpZi5NHSOBoy676wJCpYYOnCz0hYvNIBTo18YLh9asRjbRptIRxp
 W9nQ==
X-Gm-Message-State: ABy/qLZQ+EDBMbo90uO+D4CBfj2RWZ7GTaY1mWtB6kIaVQLUlWKTe6oo
 nD6JPzcjGoIMYaGGI/IdJWOPCtRCPrE=
X-Google-Smtp-Source: APBJJlEjzVnXXE24xd3g0H/KAbmNYInzNBXvLxagqtivVuzMWdmVVWBN5KK5hbwgACl0CmsJWW9ZYA==
X-Received: by 2002:a17:906:2c16:b0:992:a0c7:8d2a with SMTP id
 e22-20020a1709062c1600b00992a0c78d2amr1031920ejh.54.1688110655847; 
 Fri, 30 Jun 2023 00:37:35 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:35 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/17] hw/i386/pc_piix: Turn some local variables into
 initializers
Date: Fri, 30 Jun 2023 09:37:10 +0200
Message-ID: <20230630073720.21297-8-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Eliminates an else branch.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f9947fbc10..6a5b6dad2f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -122,11 +122,11 @@ static void pc_init1(MachineState *machine,
     BusState *idebus[MAX_IDE_BUS];
     ISADevice *rtc_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *pci_memory;
-    MemoryRegion *rom_memory;
+    MemoryRegion *pci_memory = NULL;
+    MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
-    uint64_t hole64_size;
-    DeviceState *i440fx_host;
+    uint64_t hole64_size = 0;
+    DeviceState *i440fx_host = NULL;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -205,11 +205,6 @@ static void pc_init1(MachineState *machine,
         hole64_size = object_property_get_uint(OBJECT(i440fx_host),
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                &error_abort);
-    } else {
-        pci_memory = NULL;
-        rom_memory = system_memory;
-        i440fx_host = NULL;
-        hole64_size = 0;
     }
 
     pc_guest_info_init(pcms);
-- 
2.41.0


