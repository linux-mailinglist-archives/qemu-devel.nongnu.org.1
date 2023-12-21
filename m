Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 034CD81BA3B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:10:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKey-0008ED-61; Thu, 21 Dec 2023 10:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKel-00089U-NX; Thu, 21 Dec 2023 10:08:15 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKej-0004Jo-CH; Thu, 21 Dec 2023 10:08:15 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cc9fa5e8e1so7889071fa.3; 
 Thu, 21 Dec 2023 07:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171289; x=1703776089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAVGWN1SPHpUXrz0I2hkwmpe5VJKf6+xuSizlPV5vEs=;
 b=TeQUi0l6j0JNx+ANpnCGILCWpASNwEfDLvW4hib0BdT6Vm/38pDP3EoXAkWvylhNnz
 otFHR9br5UBdoO70aUK2BpSAwUytXlLecnUbGbDDYvF0vfoeIsqDMD3mG29Yu04DKFMB
 J4DHqri3rnUNmQIkIDYCldC4sY5rqTENVqV09JAJwCaZqycGlHWhNqkLz/ZRA5AKD1d8
 nqKQhHETOTMJM5ZjN4+A0klIF3TDKM8cCgTM2GK6lD0USxuxy56dLvjefKopQupwJjgW
 06bYJ8zMSph9SPOGCHcbXI54OmU7xCm0aOgDqmAEn817xt91mxPgZXIYwmxPfwstU24Z
 UY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171289; x=1703776089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAVGWN1SPHpUXrz0I2hkwmpe5VJKf6+xuSizlPV5vEs=;
 b=ac/crxK9DVeJyovnXpuCoPNzJrZ8lXd0loBQg20P4s9BA5XjAIKLKKaYDlcj3cRrMv
 MGAK/0aVfglCwWMuc39jX8Kexwy6olgJ6xjIJROjYpb/9yVuJqfOY/oOi+Lu8HRxgZW3
 8dEYngRDYnZbSt8f9Gvq9ToVkMHojaMYGW5QYafEPWPgzEIxGDrd7rNvr+3XrH3fnn1m
 CEVblcbT504/+G33/zQBNxB8dVVVLmaPeMd8s/ZjclN2MhLMI2PnFDO2kS2aJLYfKV0W
 xHMfCgkB2+1pkZw1IBznXmTaWCtav11n2vNLhdpqWull22pvTFMJtcgCx/5jt39PTvN5
 IaQA==
X-Gm-Message-State: AOJu0YwVu3ohKAmpdgIfl9avZyStMHg9q5fOm+2LFzeZsJ3jpJiRmI6v
 oG0n8jxXkzN1MqcpS6tBGmq76mptXRTHFQ==
X-Google-Smtp-Source: AGHT+IEvcAepzDsO8kCQXktjHwLw4/SeO8b/S8khq2eD+cbrZU3Mab6MkOeCa3RZZFwurjmKLnjh9w==
X-Received: by 2002:a2e:9e0f:0:b0:2cc:9506:9bb with SMTP id
 e15-20020a2e9e0f000000b002cc950609bbmr1324792ljk.97.1703171289237; 
 Thu, 21 Dec 2023 07:08:09 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:08 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sergio Lopez <slp@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Hildenbrand <david@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 05/11] exec/ioport: Add portio_list_set_address()
Date: Thu, 21 Dec 2023 16:07:44 +0100
Message-ID: <20231221150750.5435-6-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22a.google.com
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
index ec55089b25..dc35a17461 100644
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


