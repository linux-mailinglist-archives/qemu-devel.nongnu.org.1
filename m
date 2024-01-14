Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E982D096
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:42:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzmJ-0003R3-N2; Sun, 14 Jan 2024 07:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmG-0003OC-BD; Sun, 14 Jan 2024 07:39:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmE-0001km-PB; Sun, 14 Jan 2024 07:39:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so99108915e9.3; 
 Sun, 14 Jan 2024 04:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235984; x=1705840784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=py92FQejKDlLtWW57eF8TnbqU3TrVAOsFf1Pvat3KP0=;
 b=ZXw04qH0zOo5Lqd0SoFrI4UZIBbMvj71MbxOKXDf9au8/WhQzqyrjRPHVEA9bVZYEs
 X3l9l0561cEQa9x5++2zzVIqPwsgmG7fYVNZqYQr1ShOKqhE2E9ghJ6Bx5ANh+2UjOkW
 Aa1U3FsWp1glranN2w978kleWLGCC52gfpZfaqB2ETXNW0KUbTfH/EN1GIMR2v7t7kXO
 ZVX6jhxNAdblZN38t/NR/+83k28m6efHp+3Ow9xNRi6nHzZrMa6/oDDMB0IFBVv4PMbU
 b3V7wQZpWe3EWvW/ertM/Xos/Cpp13U7AfzzXyXDEjXFF5SaeEcxeJ813WoyRKUPjvKb
 lS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235984; x=1705840784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=py92FQejKDlLtWW57eF8TnbqU3TrVAOsFf1Pvat3KP0=;
 b=DzUeXe+F/fQyIjjrPd/fNKFlXqPDZbWusLPxYI7CrkzTBScnuQllzZ/j4ZNkimTOOE
 T9zh9AWXaiOdmlMkMggAYtp5ZvdCqwOexgv4klbL2UxISruega3JnthR6aGJhmtZOfgT
 HlWkpam+02n0bpCLqWF21Dm8hNDDqJdE3XmZ86TSfa0Iyvidi/IRPz70SanisAZ5wepZ
 55AA42whUVZvtey7UUOZXjPJp466EgkmnFlRtFJni/Es1EFwN5hV0Rt2LoTG4DL6Jqz+
 TKJXqAIe/n/wJsncmggeTOLzOjjz1zupPp0R+vFueRB/S5vODOCQS+6ag+oTkbrENRNd
 CO0Q==
X-Gm-Message-State: AOJu0Yyy7HhVz+WhQqf9mac+sH7/7zMsC81wKepVoUH4PyLycPzfjF1t
 MEEsBrpXkPt6uL1ZSTgP70o/ph/JCfY=
X-Google-Smtp-Source: AGHT+IFGbSXyitt7K4m7I8zZWCmULOkOrSj1QUV2ekxQATdQftbyUYosF4zunSkCkV+ps3YAW7ifrA==
X-Received: by 2002:a05:600c:3224:b0:40e:46ff:6e54 with SMTP id
 r36-20020a05600c322400b0040e46ff6e54mr2086123wmp.58.1705235983692; 
 Sun, 14 Jan 2024 04:39:43 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:42 -0800 (PST)
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
Subject: [PATCH v5 08/11] hw/char/serial-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_SERIAL
Date: Sun, 14 Jan 2024 13:39:08 +0100
Message-ID: <20240114123911.4877-9-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
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


