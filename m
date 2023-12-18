Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1DD817A21
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:53:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIil-0006HQ-H1; Mon, 18 Dec 2023 13:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiU-00069p-Tx; Mon, 18 Dec 2023 13:51:51 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiN-0008Pr-Bv; Mon, 18 Dec 2023 13:51:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33662243274so953503f8f.1; 
 Mon, 18 Dec 2023 10:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925497; x=1703530297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17iaMgElBiTn1QygUisbFlOq9KXGCt1sZ32e3Q8CD7c=;
 b=ej1D1nkAkf69vA/SrhPAV/sLf6zEM+P8JIvbBPBkr3ZhZWl2ZlYOzBy+C/SsG4044F
 ThPawZPCH7DSGBXGzW8Si/0UBZ2tn0zhJ+TOWJ/GszOvwQeF2vQGc5pocuQ4KG6Wmn3N
 UsZXTNmjIumy7ANsG9TiGif9Gtth5U+hu+osd1lKzgnwwJ6Qrk0djKwVOPa1vhoNwsY2
 DFq4R3Iwlx6f2PnoCXnFTYJHPkv0HLEyFEcPP4yqLE+b6KyiCKACDYsH1cmjJ7DLoix1
 5FVTqppDKdNGLXMGol5Qz/whYhcvTp/yqB/kxuZCyHgRPd1b05PjO7jbcZ4aXIk/cS2o
 yr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925497; x=1703530297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17iaMgElBiTn1QygUisbFlOq9KXGCt1sZ32e3Q8CD7c=;
 b=SBZesYX8Zr6rKJDuuZkc4N1Scgxd4Wkc9veoUrnq05EHtK0/IMdcZV2QDdMM889W+K
 W+hiQAmVyAN/Tczdu+XcFfM8IcalOI4jWBGgy6dpQGkJzEleZZXV40DL9MiP8hYVELpb
 Wtqrkg+Q6MC6Fca5M1UuTZ0JercatJ0nVVtEr+1dOHKyeRFC/AuMe+FRC8uNDQH7RjLu
 nQiTnppz3e/mX99m+mre+GPFUU8X7UzCu7iYUe9qvbxV+3S6n442M74RpT8HZhcHleRk
 Ao1wwbvL/yFirYhlqXtcM3OFqnjXvdFlPpVIwSPioBO9KbfnToJltXEyM0roBIbnWffz
 Lipg==
X-Gm-Message-State: AOJu0Yy4/CYyuNRAZIBE4TBaHYHYtXUV8quQeWVIiHs9s5Gq3wOYC0Pd
 73IEktA1cOjCVhG0V6F7KBK8e2FVoSQ=
X-Google-Smtp-Source: AGHT+IG6plX8eBegqLonXYFEx0X9cXRItXD2Q015fHph4QTMR0KJGX40ZCjiS5zoBmqRVJ6eS1L9ig==
X-Received: by 2002:a7b:c84a:0:b0:40b:5e26:2389 with SMTP id
 c10-20020a7bc84a000000b0040b5e262389mr8515133wml.58.1702925496862; 
 Mon, 18 Dec 2023 10:51:36 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:36 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 06/12] exec/ioport: Add portio_list_set_address()
Date: Mon, 18 Dec 2023 19:51:08 +0100
Message-ID: <20231218185114.119736-7-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
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
 docs/devel/migration.rst |  1 +
 include/exec/ioport.h    |  2 ++
 system/ioport.c          | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index ec55089b25..389fa24bde 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
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


