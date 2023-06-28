Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CCC741915
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDO-0004le-OL; Wed, 28 Jun 2023 15:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDM-0004lA-WA
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:33 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDL-0005kX-EN
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:32 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51d805cb33aso6481087a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981949; x=1690573949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJccraeGb/rRnN46LM+nPCIzD/H53Jyy3MeNDBjGgJI=;
 b=MC0zvE1oIMHN6UoOtv35Aqb3H3VaACk9G+5/RCoVdIQNM4gEMvjT91ZjFm37uM4E6h
 wMr+rwtXBDO7+lOaT+dnaoUif6h/c5d61Wo4vPO/n57ag4UYYb2uGha+VI0QBiuEJDvZ
 qf8+4WhALAUjSVdfs95vsjleZeKrPD3SL4klHvYpn3H/e9iHe9pZ0rdXTZeiH3rvBDY0
 mGhW22KW4j+bV6sWL0wafpDviaNNF9HPN4T3WkW3ycUOQ5vc00dRgJvkqqs//H6pWS0e
 l9mHfQMUJe0vE5sqFLLr00nyZ2vuRUyDrSooTLz5lMBOThayKJn2xoqO2JhdIS3721Mo
 wZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981949; x=1690573949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJccraeGb/rRnN46LM+nPCIzD/H53Jyy3MeNDBjGgJI=;
 b=He4fKSllY3aIyHjDgvZEM0lwWc4vIpAxPw+Q3acKjrmFaCPi4GmgjsTr6plb22Gewy
 l2NyOaP19amKuzHxWNQCL5I0dbuaOPrLo5FAT9kM1pCEnakguY3srMhmQhomLm2oysz9
 xqHXyTf2+3/XYLfQUfpNRMm+fYWagN9sqircwSa2h1BIYj9VfM5JVvR1wsE5/CPk68yK
 zG6kYsR9+KR5Z+35ZjjodmlKIT5vufGa//gANkgF/orTphzQ148F3o24uAed0fKiZ2L6
 O4MZU5+1iNJFQ800FOKQ5z0xffA+grtpIxUpPYkTYP3eTNKUlvJUG24L4f3/3ONy7C9D
 ZNJA==
X-Gm-Message-State: AC+VfDywziZRYcdXRdJv8WSlg4Vrj+ZZoNACSNsKmSg2ohXrrCvM/3KK
 zEUMDpoqd0YHCtwjDhuD7CE9KTthIa8=
X-Google-Smtp-Source: ACHHUZ7cyHvGsM2plJT35qbKPUG8NT1rbMZH7+Aw+ZY7vnEmQErtBAZkLRp/p1XflxKsAbzs54IohQ==
X-Received: by 2002:a17:907:1dd1:b0:98e:1484:5954 with SMTP id
 og17-20020a1709071dd100b0098e14845954mr10101065ejc.71.1687981949612; 
 Wed, 28 Jun 2023 12:52:29 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:29 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v2 15/16] hw/i386/pc_piix: Turn some local variables into
 initializers
Date: Wed, 28 Jun 2023 21:52:03 +0200
Message-ID: <20230628195204.1241-16-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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
---
 hw/i386/pc_piix.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1df309b8e2..d07218a8c9 100644
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
-    Object *i440fx_host;
+    uint64_t hole64_size = 0;
+    Object *i440fx_host = NULL;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -205,11 +205,6 @@ static void pc_init1(MachineState *machine,
         hole64_size = object_property_get_uint(i440fx_host,
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


