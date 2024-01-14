Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73B82D092
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:41:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzmB-0003LF-4n; Sun, 14 Jan 2024 07:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzm8-0003KQ-UO; Sun, 14 Jan 2024 07:39:40 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzm6-0001f4-Ko; Sun, 14 Jan 2024 07:39:40 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a28b1095064so876134466b.2; 
 Sun, 14 Jan 2024 04:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235975; x=1705840775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpEcA88cRod9dP4VaT6aI75tyeAltviYyOMgF+q17FQ=;
 b=kbQjCUMIdEHzDtl4kaX2V/G3rT7eN6v6tAIptA+tv7CdD/diFQpS9ILEe9RYEUz+6Y
 JWC5lhLYOz55SPJrqBl3qzs1vAfsUlpiLtS3nFliy1lb/bw/3+Q4sZSog3aQlX1Olm19
 5enquQBeSjvVHWLzsgHbAAuc0bd/+i5X5FAcYwBke9KBODR0fT0BO0QzrTaFg5EPxLux
 eg33btUBRT76AsyqCxsu03lcipXtWn84QlypaaoII3kseGYHBFeVEEEc7RHLdmFY/sG9
 TUWnTbjhhV2Zm5U3ZYMb/0o9a3AtwbdEJdi1W78WzEwVi+KFBmCSmgyqzUN5rHPRyWc7
 Kaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235975; x=1705840775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpEcA88cRod9dP4VaT6aI75tyeAltviYyOMgF+q17FQ=;
 b=mBF/S8GQSGfklimUDk81No1KNHjhl8mpDQgD587ZcvcxINIl3WKY70Qvq/JhkWuvCe
 CcIe0Pcd7EPngXXWxgXYg1E/URJE0FXjHbUWJvLhg/Wjg+MhXbLfo/hs0IxIN2OSQErf
 SZSe6w/KMQHfOQlbzjhfRQzMCw43Bdoi84sjjC8cSGn/do5pAz6W2sw6hZcdwerTpwWo
 Blk7u9tG1JawIPWFfnjLRhz7eSJz6N48mby2MEfJS2E9t7mbZV6Mq6Cjgxw/UrUYj6g6
 tap45JIa8eGB7fpkiBUpVB7hmp9hJe08S+3ybwCKsXzAAItHXZGWcwob9V+E/PRuqveo
 d3AQ==
X-Gm-Message-State: AOJu0Yxj1jIjhGUdQ+FeqxxtGIGJfwJqxYtGq4hG2VvJnkdKMGXdVq8Y
 7Nh3Mx4j3eeljblaLxUz7UiXCB9yDck=
X-Google-Smtp-Source: AGHT+IGQi48VndYlJg97lVNKOTVDYwWLT6ubnWar1GScAV7aR7TeuAF5yLm3gA6oksfpHMuBSXla+g==
X-Received: by 2002:a17:906:1d4e:b0:a2c:22ae:e729 with SMTP id
 o14-20020a1709061d4e00b00a2c22aee729mr804631ejh.2.1705235975294; 
 Sun, 14 Jan 2024 04:39:35 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:34 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 05/11] exec/ioport: Add portio_list_set_address()
Date: Sun, 14 Jan 2024 13:39:05 +0100
Message-ID: <20240114123911.4877-6-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

Some SuperI/O devices such as the VIA south bridges or the PC87312 controller
are able to relocate their SuperI/O functions. Add a convenience function for
implementing this in the VIA south bridges.

This convenience function relies on previous simplifications in exec/ioport
which avoids some duplicate synchronization of I/O port base addresses. The
naming of the function is inspired by its memory_region_set_address() pendant.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/devel/migration.rst |  5 +++--
 include/exec/ioport.h    |  2 ++
 system/ioport.c          | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 95351ba51f..30b05f0f74 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -452,10 +452,10 @@ data doesn't match the stored device data well; it allows an
 intermediate temporary structure to be populated with migration
 data and then transferred to the main structure.
 
-If you use memory API functions that update memory layout outside
+If you use memory or portio_list API functions that update memory layout outside
 initialization (i.e., in response to a guest action), this is a strong
 indication that you need to call these functions in a ``post_load`` callback.
-Examples of such memory API functions are:
+Examples of such API functions are:
 
   - memory_region_add_subregion()
   - memory_region_del_subregion()
@@ -464,6 +464,7 @@ Examples of such memory API functions are:
   - memory_region_set_enabled()
   - memory_region_set_address()
   - memory_region_set_alias_offset()
+  - portio_list_set_address()
 
 Iterative device migration
 --------------------------
diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index 95f1dc30d0..96858e5ac3 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -54,6 +54,7 @@ typedef struct PortioList {
     const struct MemoryRegionPortio *ports;
     Object *owner;
     struct MemoryRegion *address_space;
+    uint32_t addr;
     unsigned nr;
     struct MemoryRegion **regions;
     void *opaque;
@@ -70,5 +71,6 @@ void portio_list_add(PortioList *piolist,
                      struct MemoryRegion *address_space,
                      uint32_t addr);
 void portio_list_del(PortioList *piolist);
+void portio_list_set_address(PortioList *piolist, uint32_t addr);
 
 #endif /* IOPORT_H */
diff --git a/system/ioport.c b/system/ioport.c
index a59e58b716..000e0ee1af 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -133,6 +133,7 @@ void portio_list_init(PortioList *piolist,
     piolist->nr = 0;
     piolist->regions = g_new0(MemoryRegion *, n);
     piolist->address_space = NULL;
+    piolist->addr = 0;
     piolist->opaque = opaque;
     piolist->owner = owner;
     piolist->name = name;
@@ -282,6 +283,7 @@ void portio_list_add(PortioList *piolist,
     unsigned int off_low, off_high, off_last, count;
 
     piolist->address_space = address_space;
+    piolist->addr = start;
 
     /* Handle the first entry specially.  */
     off_last = off_low = pio_start->offset;
@@ -322,6 +324,23 @@ void portio_list_del(PortioList *piolist)
     }
 }
 
+void portio_list_set_address(PortioList *piolist, uint32_t addr)
+{
+    MemoryRegionPortioList *mrpio;
+    unsigned i, j;
+
+    for (i = 0; i < piolist->nr; ++i) {
+        mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);
+        memory_region_set_address(&mrpio->mr,
+                                  mrpio->mr.addr - piolist->addr + addr);
+        for (j = 0; mrpio->ports[j].size; ++j) {
+            mrpio->ports[j].offset += addr - piolist->addr;
+        }
+    }
+
+    piolist->addr = addr;
+}
+
 static void memory_region_portio_list_finalize(Object *obj)
 {
     MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
-- 
2.43.0


