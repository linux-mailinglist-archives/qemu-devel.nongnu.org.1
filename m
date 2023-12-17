Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA6815FF2
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:44:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLp-0005g8-Hk; Sun, 17 Dec 2023 09:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLd-0005YG-Bh; Sun, 17 Dec 2023 09:42:29 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLb-0003OS-L4; Sun, 17 Dec 2023 09:42:29 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a2339262835so63204466b.3; 
 Sun, 17 Dec 2023 06:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824144; x=1703428944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17iaMgElBiTn1QygUisbFlOq9KXGCt1sZ32e3Q8CD7c=;
 b=ej0RjnG3D3F4es2J0a/YSsLKuvhF45lfdcIs2IxjoCcUTpub52xFCNhxtpoeR3JTV1
 8CNwSP3f3S6DzRXBzmrmc/qSbOE+5BmPYjzlkLLP88G2ir83HdiN4Yyyf+63ygxTqiDY
 RX65UAoncYSFw/BXwkRtV0rQRR30WCHN2jenW3Vw/rBkafY486aaqQDh25TpRUQ3g7rM
 C5VdVopuDl4LCPKu20b4wUTCJgcp7MZCigGov7UQf6eaJQ5LKjbmyZFLRurQ+O3jaru3
 MC62I6PQ1R5BTBgR+qSuoPT/caz029hcIUsVO1joqdFlHWWTUBE8Sk52zz8YgkwpLczB
 upLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824144; x=1703428944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17iaMgElBiTn1QygUisbFlOq9KXGCt1sZ32e3Q8CD7c=;
 b=LXelBGoFLGVKxSkkJ8sl8cGys8y8JI4s3khRzsNXDRUMN0IimRlkLNbi90M2R7nWEe
 IPxUaOBydV5KVO1sESu5kj3aEktlE39+VQ2GDWkxL71Kc+2C6Bvl3NADuoYE0J1Edzg8
 F3NOBk5BqUHqcwj310bmWoPg2Nj4dF6eZWUQ4q6cwGW8Yc+Ph4v8wcna0L8Yrq2s4ocV
 sOMAEUCGsH9Mho0XAgRnhBQgJCugj1bWUuiWf3FBbrYtQUB5VWo7xWJ77dIOQ9QALYys
 JsKz6aBLCLLfVsST09gqIWfqMJkdDTsWN6cWJEt4aVjTvnEWvbfdEFANy268rgof3tkl
 Fe3g==
X-Gm-Message-State: AOJu0Yzz+RgtDh9GJBhWl8g275a4S6J4fr+0vAhctQ0Eri9QVz/8j3/W
 8F2T+3faVc/ILb4MKqOJykQ/M0cEqco=
X-Google-Smtp-Source: AGHT+IGza0tPhcI+QDCedVnDHaYSCoPG+rzPM66Xo4yzMpGmRclckvv4kzCKClHrgnh1XyoSJTJHBA==
X-Received: by 2002:a17:906:4e:b0:a23:f5f:3444 with SMTP id
 14-20020a170906004e00b00a230f5f3444mr3234350ejg.133.1702824144139; 
 Sun, 17 Dec 2023 06:42:24 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:23 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 10/12] exec/ioport: Add portio_list_set_address()
Date: Sun, 17 Dec 2023 15:41:46 +0100
Message-ID: <20231217144148.15511-11-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217144148.15511-1-shentey@gmail.com>
References: <20231217144148.15511-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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


