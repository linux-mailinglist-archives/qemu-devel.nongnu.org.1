Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6173D815FEB
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:43:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLh-0005Zo-9N; Sun, 17 Dec 2023 09:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLc-0005Wk-Iv; Sun, 17 Dec 2023 09:42:29 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLa-0003O9-8J; Sun, 17 Dec 2023 09:42:28 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e3845abdaso150484e87.3; 
 Sun, 17 Dec 2023 06:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824142; x=1703428942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzCBxca0nCRHR665JCCwURJqMXPSu7RYmWln7L2TOQo=;
 b=XNeNj3NrPVzuevmyRKddkJDEtGgy+eOXbD7du5FA0tR7a+lI2Gd3bTdgBldyFxyFph
 D0OZIvoEpbk2V7C04ha76fdGuKE0IxxjpiLMtZk7CDvJfZGnIgJ6JV2u6QQoUznKFDBf
 ZUzkLZJfk5Sg1NEB9pxNI+IypF2yoAIQOn44Y2CwH+5oWCXxVYGq7Yidc8RrUBKZKEbR
 wi7yI5zrTvs0vlIq+xpLW6Dw1Drh9jAsNplHTNiDcFmQpCwHWFefVE0IJNZO7Ed3Fw9v
 esEOP4Gz9FYPqaem0CPkSmod22Qc//okm73booaAdLYkZW61XojORO4ZxapWWuJh/K3Y
 JkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824142; x=1703428942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzCBxca0nCRHR665JCCwURJqMXPSu7RYmWln7L2TOQo=;
 b=dKej14RaT9BhtXKEqmnJvzj54vd6zFssqu8qpGkVPq4BRP+ITVL69oomYTK/cEV+Du
 BgJ8dijyr0+82sY2qlMwp4czVwmfojmO00KqBeTQTeCVwwRF4SijW/Imdgy/VgDgoBp3
 UExvF/9OcgYdf6DyrxtzmNz7be7z2VVYFTASj/7DaaE7rcGTGYjc8VmGszxFmBQNQQEX
 jW1Eot2yR2JljRki+hI3pRhQcHv7YcQfljZEk0qJDxl0s4nMWNuLUlzSZIlD1IxfETHE
 I4sibc+vLgo8qxemZ+6iBSyTECqcCl3scSgjnNWdgAkW3ZrqyOque67wpSjK3p2gdEnk
 4rnw==
X-Gm-Message-State: AOJu0YztXSyVEpA8hS8k1OKn0V/Xn7ytqbzLdGQjkllCfXutg0xknWQ4
 L7Lm/CNfdAck3LrKSXAM1XSey5alaHE=
X-Google-Smtp-Source: AGHT+IGqxDD4QAGLWAmtt2whmjrwaYtSNnwn/JDU6WBUGA5O0NK2I+X4umHdKlyJewr3O+phPPh8sA==
X-Received: by 2002:a05:6512:3e0a:b0:50b:f0f7:2c43 with SMTP id
 i10-20020a0565123e0a00b0050bf0f72c43mr9271061lfv.4.1702824142281; 
 Sun, 17 Dec 2023 06:42:22 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:21 -0800 (PST)
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
Subject: [PATCH 09/12] exec/ioport: Resolve redundant .base attribute in
 struct MemoryRegionPortio
Date: Sun, 17 Dec 2023 15:41:45 +0100
Message-ID: <20231217144148.15511-10-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217144148.15511-1-shentey@gmail.com>
References: <20231217144148.15511-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12d.google.com
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


