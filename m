Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D97826195
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:08:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDrl-0005e2-LP; Sat, 06 Jan 2024 16:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDri-0005d7-Mp; Sat, 06 Jan 2024 16:05:58 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrg-00019t-Vo; Sat, 06 Jan 2024 16:05:58 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5537114380bso521018a12.3; 
 Sat, 06 Jan 2024 13:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575154; x=1705179954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpEcA88cRod9dP4VaT6aI75tyeAltviYyOMgF+q17FQ=;
 b=kG124pNvvBBXgKdlbUVv3P9Lf23amA2OJTnuBGJK5a5o/561v+FJnJpgDaWicP3CpJ
 6u15MwAx2FKlB03P2QHe9h+GzQLjFdHXN34OsyDxBCIxtIgp3B5FdNymXZVL6JKd1ueR
 7fiOOpr4rJeCdt2ZJlOcKswYW2w3Gh+CMlVf0x4LlDe+lKdmOX6eLi4sxaV2hfkfBWXi
 E1TcU1/NU/ye5NhjVBS2tnPydZsVl9LC//LBpGVEN/x4da7VMgF9aVD4rSaumOjC9DFf
 RM6zVbeqkRUCDcBvTTXF/rrLGwV3yVdlsFI09g74BW+AQxC8H5up3Tk598gm5KDk4Voh
 CV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575154; x=1705179954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpEcA88cRod9dP4VaT6aI75tyeAltviYyOMgF+q17FQ=;
 b=dbqGNJMcnQhOd0Ngm/j2Jnp/6Zlj11FuEIFd2NMfxtGpMtD1yRf3SbWuhbPNzSUvFu
 eSjR5u18m5YWk+ud5UcDLMe0XEgSeR03ZCVarfXhU78IKZbXNjv5d9EXKPQWJiBHIt86
 sPFPoXD0hz1C7tbzohl03s5B6yhVW9riEn/zcz88n566Nrr+joGEXKp1Nu/onYDDJHuY
 yKQ41KTbni5XNYvgLkcJTu0wTaBTt/3aNkEJExpDBLi5raJiBJMPNL7MPBdWB0FShw1Q
 x4lHE4S6x3pNfeCwYghXBJPta3QTPH2J+d+wt3TEry7f0pBlaRol8YIP60G/m33nRXy4
 sprw==
X-Gm-Message-State: AOJu0YzGJnT8nZQzjkeRoDiDhk96Kw6uPyL3h1124leVSj2YzGK+SQY7
 zbT1nJlgCBstjF167or69jaivh5R3aM=
X-Google-Smtp-Source: AGHT+IENYIdxkdE1rCadPLo6XT+K1UXZvjSx71X6xdpeqC7Tk6nq9C4EpM/rJQWJE/jx/bAszQ9TcQ==
X-Received: by 2002:a50:a68b:0:b0:557:1006:40a8 with SMTP id
 e11-20020a50a68b000000b00557100640a8mr761463edc.5.1704575153946; 
 Sat, 06 Jan 2024 13:05:53 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005576f4471besm624922edz.42.2024.01.06.13.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 13:05:53 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v4 05/11] exec/ioport: Add portio_list_set_address()
Date: Sat,  6 Jan 2024 22:05:25 +0100
Message-ID: <20240106210531.140542-6-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106210531.140542-1-shentey@gmail.com>
References: <20240106210531.140542-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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


