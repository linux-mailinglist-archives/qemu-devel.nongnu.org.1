Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA62817A1D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:53:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIie-0006Go-8t; Mon, 18 Dec 2023 13:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiW-0006A3-8z; Mon, 18 Dec 2023 13:51:53 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiM-0008Pe-3g; Mon, 18 Dec 2023 13:51:45 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c3f68b69aso34818915e9.1; 
 Mon, 18 Dec 2023 10:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925495; x=1703530295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzCBxca0nCRHR665JCCwURJqMXPSu7RYmWln7L2TOQo=;
 b=E26h59jBb+5M/4+VT+NqbBE8mO2CkylG9pJXSSXhC4Ru7gtbKj2UzhfgEwdzqVq+CN
 YsyP3rv2/SWEtwxwfFrObDlKBzwPfDBowzYEwnqD9rgiWy6RLyPHQfZnb1mdTUOuJRHm
 GgX4lFstqbuqzDnpypcGEvhiIcc+YJZAFTFqZd+LkpTQkhun+0JiUOx42Joj+opsY3z9
 2MD2ftQ9TslWYsGh9/tFdRa/HD26SO6uqZXp6dddmBZP7OWSQ46ZJcfms4kzEK6dJEEf
 frPtBWDcEyvl1xtt+PMhynQlpUcceMP81umT5xmGQwRVck3KiHTDC01QoMRJiJCo3NYK
 rUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925495; x=1703530295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzCBxca0nCRHR665JCCwURJqMXPSu7RYmWln7L2TOQo=;
 b=cBS7LlhKgzI6rKA19gzsfR0T82oYWIq01sGHADDsZK3li3kaTOC556qrhkgbABpjLX
 5/+vqZe+ePco6QAc8dbSIgZThwyEEdgE7MzWLiSjmRE0R7FWjS5HUWCvxWmIJsKaLAoK
 BH6mlvhVX2f3NLfdTBNVmb8ujsKQd7tXldIFYvM1/muxoc9zUJkNi+9qTmjjQLieeU1C
 1e6nDFKtrnNBcoQdF4f+A/2GgjJvISPKit7vW7cXQ/1jK0p+Bb9J7rbwkYD3VPF4bp/I
 F9t+ni+WZKE1UilBoH0gGLYU6YI8C9uwlYYQYY54bTYNMQgUnHWA5FZT8QJODv1voViu
 mYHQ==
X-Gm-Message-State: AOJu0Yz/sq9UAIIPoSZTwrdE5a3Jn3n24lU/Q4RrFqo8LVC6X9pxU+8h
 /lttfcupLvSV8RgFHuzvKeinvCCgCNc=
X-Google-Smtp-Source: AGHT+IGsWFEirahMFrh58jiwkZNyscmLG2VaPeyxApkkWpaqR9Yo5bn2LMrWqYF8KB7AdccwOWx6kw==
X-Received: by 2002:a05:600c:1d10:b0:40c:50c:9f3f with SMTP id
 l16-20020a05600c1d1000b0040c050c9f3fmr9680834wms.95.1702925495291; 
 Mon, 18 Dec 2023 10:51:35 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:34 -0800 (PST)
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
Subject: [PATCH v2 05/12] exec/ioport: Resolve redundant .base attribute in
 struct MemoryRegionPortio
Date: Mon, 18 Dec 2023 19:51:07 +0100
Message-ID: <20231218185114.119736-6-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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


