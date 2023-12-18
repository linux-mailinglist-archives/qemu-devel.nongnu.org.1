Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F32DA817A1F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:53:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIiu-0006SD-RP; Mon, 18 Dec 2023 13:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIii-0006Jk-BK; Mon, 18 Dec 2023 13:52:05 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiQ-0008QE-Kd; Mon, 18 Dec 2023 13:52:03 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3364c9ff8e1so2032829f8f.0; 
 Mon, 18 Dec 2023 10:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925501; x=1703530301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=loMZkXqxlBvl+ZoVdyMlIBzJJ+hfWEc5m/Rp26AxyIU=;
 b=UL6yyx5YiZCEfJ2QG2VfocwTxh9IQ1e/9IPTwNc44GeIzkNA6GJTKIk4YBOZBJa2J4
 qnCgRvHERJy1UNQ5j1nsrmJjl6leJnCmlIlJgiFp1DQnMRRHqhWJ4p6Kow3t9q2L61O+
 FJjevT7q6tIApvKBIRpJIlYbmJ1a4kVzEmWB+/Xhnmiw+Hx/MNmhCoWrmndO+wgNNnJQ
 vZYmS9OOuzcvRJc1W1D5E/iQYGB5z8/LKB3tJicEIlGO/uJ66nmPmdzE/51QTeitwJyS
 GD4V21JP4ZAPmA7lPGk3mXOpfXG3WEID1VJ6gr2FxTRi8UCaYLHk5+ly0Hov3WnrnL54
 BgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925501; x=1703530301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=loMZkXqxlBvl+ZoVdyMlIBzJJ+hfWEc5m/Rp26AxyIU=;
 b=PJRDsoYI34cxO9w0FBiq2862S+BR++XxQk9KyyZOCU0FUj2xPiWnVv1H9r9U4q0/58
 xNyyDhtgVZb92407rq+v52gQIVXTwzROQd6jFCJXbt0nQN+FQjImbQrNKCAznNtJn45I
 qRicBNbFH7sS+GAjVTuByWCg33YKJadfYh3B8YhoQk9bA2o+PUL8sTZmHahSghIiZqXK
 9/y2WGqKnakjfOwTrKXjug21FU+J6FCIUquO3+q1zkpNw0zOhRfsM7DXB34ODLOuHVKi
 dC+A3h/d/LeQCkHmMBDRHJ22VpYvYMdSBbHExWr5LAYAsRkAeCyXSv+yJMvk49ikgt8Q
 QRKQ==
X-Gm-Message-State: AOJu0YxHSjmsrOrzo9Jm5XvaOOEakdp6j9Q35KaaFck8I72b7Kn9x+5s
 GMwgs6DLA11eHzw8ZZ2D2JocEmEe49o=
X-Google-Smtp-Source: AGHT+IFB9iwxVPCcvv0LhH8O/b6Bsh3fQ2pTa5qQyyJP3cTfAlo3pVtSYd6JvjM4ul3ACQa1LyCLiA==
X-Received: by 2002:a05:600c:3c8b:b0:40c:4b42:a20b with SMTP id
 bg11-20020a05600c3c8b00b0040c4b42a20bmr6162868wmb.8.1702925501511; 
 Mon, 18 Dec 2023 10:51:41 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:41 -0800 (PST)
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
Subject: [PATCH v2 09/12] hw/char/serial-isa: Implement relocation and
 toggling for TYPE_ISA_SERIAL
Date: Mon, 18 Dec 2023 19:51:11 +0100
Message-ID: <20231218185114.119736-10-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Implement isa_serial_set_{enabled,iobase} in order to implement relocation and
toggling of SuperI/O functions in the VIA south bridges without breaking
encapsulation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/serial.h |  2 ++
 hw/char/serial-isa.c     | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index eb4254edde..ba9f8f21d7 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -112,5 +112,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
 
 #define TYPE_ISA_SERIAL "isa-serial"
 void serial_hds_isa_init(ISABus *bus, int from, int to);
+void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase);
+void isa_serial_set_enabled(ISADevice *serial, bool enabled);
 
 #endif
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 2be8be980b..d51c9ec87c 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -187,3 +187,17 @@ void serial_hds_isa_init(ISABus *bus, int from, int to)
         }
     }
 }
+
+void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase)
+{
+    ISASerialState *s = ISA_SERIAL(serial);
+
+    serial->ioport_id = iobase;
+    s->iobase = iobase;
+    memory_region_set_address(&s->io, s->iobase);
+}
+
+void isa_serial_set_enabled(ISADevice *serial, bool enabled)
+{
+    memory_region_set_enabled(&ISA_SERIAL(serial)->io, enabled);
+}
-- 
2.43.0


