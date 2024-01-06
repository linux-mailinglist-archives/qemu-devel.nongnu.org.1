Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F69982619C
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:08:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDrp-0005fp-Lu; Sat, 06 Jan 2024 16:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrn-0005ev-D2; Sat, 06 Jan 2024 16:06:03 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrl-0001Ai-SZ; Sat, 06 Jan 2024 16:06:03 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5576fd0ded7so412300a12.0; 
 Sat, 06 Jan 2024 13:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575159; x=1705179959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=py92FQejKDlLtWW57eF8TnbqU3TrVAOsFf1Pvat3KP0=;
 b=bdpwCToRsGOSXQnrJy0laaxQgKwYM4xwd+OAo8RCCLjugKnJb+mX2XiGRZ23Qvgyrb
 AXJqlPElryp9cEB6lwePkteDGmp51l3qlvrmVT5XZJeV7jHw8bz/W1fisvZyYqBOzsgO
 UhH3gOqWEsj1kd09KJvmyWPlA7Ew3nNjpqZet9Z3uggElSjpeHJ1zZjOrmsMax6NkOQj
 liejEM61u9Tk2gksQ0GpknQWSUxAu6W44o/DLRPzxbC/ot2K48ppTS0EW42JGmecWmLd
 JWmEV2A3pFvwH2NV/nziRzUkOr9D4clMB1nZVZnn3/mvEmt//IAcQ0p25AHGxf7GarvP
 gTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575159; x=1705179959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=py92FQejKDlLtWW57eF8TnbqU3TrVAOsFf1Pvat3KP0=;
 b=o3K700/VL6BXrvvhMaAoYXuVp1t+bTtKfQWGSe31bGJxSKRu2w+xzB+nH8oyjOvzRv
 ZNeu8yTJEa9CTBeg4pLIn2SPPK495EG0wt4CPEqyg231KdgHmHkPhr6ggutSbqCyOd7l
 fv4W+kNsgmrZsbu3FE4PgdDVBvNh4NrORN1udqIp26piXHmoLyT+c2pNvqdxyVg59OH1
 xk4PYnB3t9HrIzu15WyIih1PWcIVmWnwnib2R5icnPohddq9ffKHnLe6onn5jJo8R8os
 TZQfxYEcgLbGctfaNLarruKJQDlXG0YgZIusTKDf2mt2bKi6g1T7rPKFwyt7v0jG+7lH
 W0uA==
X-Gm-Message-State: AOJu0YwUW0ag8ymWv/h3NgOmp/YCjv7IC7g3NhTKOQS7nvpJoXGr0aEJ
 62ZOjCzrlQJJlVU2aAg4n911yGkde9k=
X-Google-Smtp-Source: AGHT+IELw8mPxKFc41Q8uSbl5gicbbEH8EpGDEMqaJFg+sXFiIQ7hN7Fvfa0BLQAWVt8elDR2pE5jw==
X-Received: by 2002:a50:d7d7:0:b0:557:7c2:1114 with SMTP id
 m23-20020a50d7d7000000b0055707c21114mr524894edj.171.1704575159369; 
 Sat, 06 Jan 2024 13:05:59 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005576f4471besm624922edz.42.2024.01.06.13.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 13:05:58 -0800 (PST)
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
Subject: [PATCH v4 08/11] hw/char/serial-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_SERIAL
Date: Sat,  6 Jan 2024 22:05:28 +0100
Message-ID: <20240106210531.140542-9-shentey@gmail.com>
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

The real SuperI/O chips emulated by QEMU allow for relocating and enabling or
disabling their SuperI/O functions via software. So far this is not implemented.
Prepare for that by adding isa_serial_set_{enabled,iobase}.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/serial.h |  2 ++
 hw/char/serial-isa.c     | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 8ba7eca3d6..6e14099ee7 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -112,5 +112,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
 
 #define TYPE_ISA_SERIAL "isa-serial"
 void serial_hds_isa_init(ISABus *bus, int from, int to);
+void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase);
+void isa_serial_set_enabled(ISADevice *serial, bool enabled);
 
 #endif
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 1c793b20f7..329b352b9a 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -184,3 +184,17 @@ void serial_hds_isa_init(ISABus *bus, int from, int to)
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
+    memory_region_set_address(&s->state.io, s->iobase);
+}
+
+void isa_serial_set_enabled(ISADevice *serial, bool enabled)
+{
+    memory_region_set_enabled(&ISA_SERIAL(serial)->state.io, enabled);
+}
-- 
2.43.0


