Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 280DB82D098
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:42:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzm8-0003Ih-M5; Sun, 14 Jan 2024 07:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzm6-0003G0-6D; Sun, 14 Jan 2024 07:39:38 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzm3-0001eE-Jx; Sun, 14 Jan 2024 07:39:37 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a28ab7ae504so751275866b.3; 
 Sun, 14 Jan 2024 04:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235972; x=1705840772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzCBxca0nCRHR665JCCwURJqMXPSu7RYmWln7L2TOQo=;
 b=R+4YzVSaOixGv8SI8D+rtdIbBCbTSynv4mr9A5RKf6Xpx3kKxYkmHkO5x/ry/dLRf4
 COEDcHQPjSfOioZVm3Z0Q7Ef5MbEq8SRb1oQaAmt0V+HOqDwFIbvV0VxQbSi432m1ejM
 I7lJh4szIfBuoxwGMMfCZbTOJ5Evp6V+wcBm68N2KO9+A7bMiUp4fVxsRA7SiMH5nDz5
 P5IsvUHKvsbk8AKubgPy13KaAh4tl/xcHtMwQiA9fbgWe9t5Snb7EuE+Mpiu8t9dkYJQ
 O5mt+5QXOn7QtyNLZ6J5tfo4KPKSokOeFGZF+PdNRCJvTI8IyfVHQcN+mv1tAN8Npa/u
 85ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235972; x=1705840772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzCBxca0nCRHR665JCCwURJqMXPSu7RYmWln7L2TOQo=;
 b=MG+yA2uVFDhL2AOgnuvv5r9xgrSVoZfvOocOSrO2qWEq28W5c1FiOqao7hCrrE+SLF
 LBtz8xngVe6+d+/y5Qt90sWlHeoZJvZ9GCJRXZLyxOixpA+b11bDnjSk5w6XOE53gwK9
 P1J6sqpVQFpejAqFvF/gTI1TRfCKy3XNI+EoeW8DqSVfu4lk7M8tMWrgS8GM+4+h3niH
 l+458qHTu1FHmNqxDS6+Y76UqcfH53bIiMPf/2M7mOx4eIHlKoZc65NMTclgJMe3GqYM
 Cvu6Hr4NVvLmji8kw6lJqHpiS5Yteg/2A96tJa6wEj8ABGrL4/9BBgvGHyKIoIGc5wkK
 Gj5g==
X-Gm-Message-State: AOJu0YzD3CdCEWybxe2CkQiWPVutgHQ+2XEboffEUEWiVl/8+CK0X9AI
 jSvXSU5huA8WuPY5hPgpwjNuIbIR+V0=
X-Google-Smtp-Source: AGHT+IExDEBbKKzXK0q/e+qgxMzzycbVzZx9NcqByiyHmvLI6Z07oZd9r8tEIlvczoOIuKUlM5G7gA==
X-Received: by 2002:a17:906:4bc8:b0:a2a:18ad:ebb4 with SMTP id
 x8-20020a1709064bc800b00a2a18adebb4mr1713945ejv.62.1705235972480; 
 Sun, 14 Jan 2024 04:39:32 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:31 -0800 (PST)
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
Subject: [PATCH v5 04/11] exec/ioport: Resolve redundant .base attribute in
 struct MemoryRegionPortio
Date: Sun, 14 Jan 2024 13:39:04 +0100
Message-ID: <20240114123911.4877-5-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
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

portio_list_add_1() creates a MemoryRegionPortioList instance which holds a
MemoryRegion `mr` and an array of MemoryRegionPortio elements named `ports`.
Each element in the array gets assigned the same value for its .base attribute.
The same value also ends up as the .addr attribute of `mr` due to the
memory_region_add_subregion() call. This means that all .base attributes are
the same as `mr.addr`.

The only usages of MemoryRegionPortio::base were in portio_read() and
portio_write(). Both functions get above MemoryRegionPortioList as their
opaque parameter. In both cases find_portio() can only return one of the
MemoryRegionPortio elements of the `ports` array. Due to above observation any
element will have the same .base value equal to `mr.addr` which is also
accessible.

Hence, `mrpio->mr.addr` is equivalent to `mrp->base` and
MemoryRegionPortio::base is redundant and can be removed.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/exec/ioport.h |  1 -
 system/ioport.c       | 13 ++++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index e34f668998..95f1dc30d0 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -35,7 +35,6 @@ typedef struct MemoryRegionPortio {
     unsigned size;
     uint32_t (*read)(void *opaque, uint32_t address);
     void (*write)(void *opaque, uint32_t address, uint32_t data);
-    uint32_t base; /* private field */
 } MemoryRegionPortio;
 
 #define PORTIO_END_OF_LIST() { }
diff --git a/system/ioport.c b/system/ioport.c
index 1824aa808c..a59e58b716 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -181,13 +181,13 @@ static uint64_t portio_read(void *opaque, hwaddr addr, unsigned size)
 
     data = ((uint64_t)1 << (size * 8)) - 1;
     if (mrp) {
-        data = mrp->read(mrpio->portio_opaque, mrp->base + addr);
+        data = mrp->read(mrpio->portio_opaque, mrpio->mr.addr + addr);
     } else if (size == 2) {
         mrp = find_portio(mrpio, addr, 1, false);
         if (mrp) {
-            data = mrp->read(mrpio->portio_opaque, mrp->base + addr);
+            data = mrp->read(mrpio->portio_opaque, mrpio->mr.addr + addr);
             if (addr + 1 < mrp->offset + mrp->len) {
-                data |= mrp->read(mrpio->portio_opaque, mrp->base + addr + 1) << 8;
+                data |= mrp->read(mrpio->portio_opaque, mrpio->mr.addr + addr + 1) << 8;
             } else {
                 data |= 0xff00;
             }
@@ -203,13 +203,13 @@ static void portio_write(void *opaque, hwaddr addr, uint64_t data,
     const MemoryRegionPortio *mrp = find_portio(mrpio, addr, size, true);
 
     if (mrp) {
-        mrp->write(mrpio->portio_opaque, mrp->base + addr, data);
+        mrp->write(mrpio->portio_opaque, mrpio->mr.addr + addr, data);
     } else if (size == 2) {
         mrp = find_portio(mrpio, addr, 1, true);
         if (mrp) {
-            mrp->write(mrpio->portio_opaque, mrp->base + addr, data & 0xff);
+            mrp->write(mrpio->portio_opaque, mrpio->mr.addr + addr, data & 0xff);
             if (addr + 1 < mrp->offset + mrp->len) {
-                mrp->write(mrpio->portio_opaque, mrp->base + addr + 1, data >> 8);
+                mrp->write(mrpio->portio_opaque, mrpio->mr.addr + addr + 1, data >> 8);
             }
         }
     }
@@ -244,7 +244,6 @@ static void portio_list_add_1(PortioList *piolist,
     /* Adjust the offsets to all be zero-based for the region.  */
     for (i = 0; i < count; ++i) {
         mrpio->ports[i].offset -= off_low;
-        mrpio->ports[i].base = start + off_low;
     }
 
     /*
-- 
2.43.0


