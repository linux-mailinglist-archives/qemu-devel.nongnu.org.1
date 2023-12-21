Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF79081BA39
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:10:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKeo-0008Ag-Pw; Thu, 21 Dec 2023 10:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKel-00089K-75; Thu, 21 Dec 2023 10:08:15 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKei-0004JW-21; Thu, 21 Dec 2023 10:08:13 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2cc6c028229so9855181fa.2; 
 Thu, 21 Dec 2023 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171288; x=1703776088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzCBxca0nCRHR665JCCwURJqMXPSu7RYmWln7L2TOQo=;
 b=JKxZYdui59DdItgYhwY8P7dMQ9OsiuU8NmSo6YpUBCZdfXpNlNkt/RRMOOwgqDJUMc
 VU9SUomlYKJDj20iGtTY9gKgijecGsrdipO/EOkIlFnzrgYJlKvomS5dhqJzmm6BBMbq
 wkn3INitpN/PCBOb8PJe/Z3fUOma6WkRdlJXN0/7BqkRVaEnXtSpu/r8UTwXZjgunMju
 rGsvcBed6I5att+0XqbdhxR/QMzERo76w+trMbjHhDhvzgEV8RKfXwmswsAUkAuVj4LN
 GYNz6Mtbkba+d4lUMlxBtFK9evksPJZWxiXM/OSl6rkvL0BgfRsq9TNuyPgoXZlPHNlc
 mUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171288; x=1703776088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzCBxca0nCRHR665JCCwURJqMXPSu7RYmWln7L2TOQo=;
 b=gUCgLeDCVShWCnMR3v/XN/c5O4buUGQ7tFe1Nz3ecwiPPVaxOhlAU85ks/kC7xCSkM
 P2g6ouyghD6IMM6taz26Yp38XulX5bWbWcqRyzasH/cbfNWN0xPPAHeQaHrVNTftJnHH
 1UOdy4cx9U7DcWRUvEpBGfv3ezEGvsyihyBCcfwytrWX17273b6EF2kXt5PhXoqjYYvc
 dFz+cdLzmxN/1sjmcZo2BAXBpmlIm/yUy9GeC588oPoFM8UvTJm1Ig3ivYV0MWp3E7OF
 RefR47cdnuewQdqbf/kZOEN5v6VJpWLoZAfGz11adOQOmSjwAE4XvBIUCxwV8mhcKpIU
 STNQ==
X-Gm-Message-State: AOJu0YwfagY2t7S3eumgOSd3S6hMk6hDYt+8DtV5YnmoqArWFKgLytCo
 DaJBGXK7TzU/AnVu0TxPf5Vyz+uQAMoO8w==
X-Google-Smtp-Source: AGHT+IGogPbot+5m01Kk0sVdVFgQ2NLvxnk+ZqKclIUOMLRrZpPgMazyd3DjXbdpEWzls++vQVJhQQ==
X-Received: by 2002:a2e:b60b:0:b0:2cc:6b59:d346 with SMTP id
 r11-20020a2eb60b000000b002cc6b59d346mr3671549ljn.17.1703171287564; 
 Thu, 21 Dec 2023 07:08:07 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:07 -0800 (PST)
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
Subject: [PATCH v3 04/11] exec/ioport: Resolve redundant .base attribute in
 struct MemoryRegionPortio
Date: Thu, 21 Dec 2023 16:07:43 +0100
Message-ID: <20231221150750.5435-5-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x233.google.com
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


