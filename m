Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A0E81BA49
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:11:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKf8-0008Vm-Jk; Thu, 21 Dec 2023 10:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKes-0008Gd-9I; Thu, 21 Dec 2023 10:08:22 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKep-0004NL-IR; Thu, 21 Dec 2023 10:08:22 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5534dcfdd61so1638340a12.0; 
 Thu, 21 Dec 2023 07:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171294; x=1703776094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jf2Frpf/cWzzHNSpTj0JllWtoYDJKF8fvZF01FoVocs=;
 b=YBs84vSwznnJHz5GDTdS7jjiEJ+WzZ/oqXVYEnoOeAQheCECNKtHwoMZsN2q9YSuh/
 cfO9SAqTj1/hWVYVd3Zo/aKyhtDcGXk9PKAv6nsTrT4oaClSCTB8b6IsxbGo8Bu0qf1D
 bf2xkVmhfx7EX/Y/gvpiFux5pR3Z4dQKVKa/UcULSBIoMJIT9W3MUHaWSG9rh5d6ahjl
 rv+XawCDkqxs04MtRAmzHUzDb9+EKFntkekWUMdl7NYWX52yHNJa2im8A9TtvjhTkwyN
 LQbcfOS+GlZFDgCaeev7+oi+M7DVeGYIwY1j0kMCAABoZ0D6iAiQWePWkYtNrv0NPJmF
 dRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171294; x=1703776094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jf2Frpf/cWzzHNSpTj0JllWtoYDJKF8fvZF01FoVocs=;
 b=ZXtcU03M9MfuYwXGvw+pqQRTlfzr+4RWvk2aKWa0hrpQCI7m/7bmiI+TMv5mYiuiRR
 x8EKqbtHRo9pSAEXR08C8dKlB3ZI1wsMvWrpEi6Q3oCIphDOhgzmGC3/EGVZzqh6zZ1p
 RCZigvM9wWbn2KaCAmrYPi0x7zEBLF3TQGoYe35SRogvTnnz/XVYx1GYCneqGdnKTx3G
 Rw7XM4GYyu97hng+byfvxAoKRcZgmBtuzmTZs1ofyAt9Q3YltP6MP0jfU6HN1Ogrwooe
 HR0GhvDpPdqLv+vWYGHGfeRiKNdqHl3xbAtotG4sFsT0Qm5KY3Pb28fhSj6Ee4bBK+sf
 K7+g==
X-Gm-Message-State: AOJu0YzQ3HvvC9i7xcZgR8yotsNgcwmyiXB00IPrgKGd8uUgNuqXVyba
 viMJVpo6mBz7rXTBScW/ubqR+5qc8oaB5A==
X-Google-Smtp-Source: AGHT+IHfGDcR3gelstRDI3O3+ocZ3/ETvaa7z7pjrSqQQPVpMtsrv58PkOR+Zhoe8SnSRjb6IPZxbA==
X-Received: by 2002:a50:baec:0:b0:552:d75b:c6d9 with SMTP id
 x99-20020a50baec000000b00552d75bc6d9mr857577ede.7.1703171294333; 
 Thu, 21 Dec 2023 07:08:14 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:13 -0800 (PST)
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
Subject: [PATCH v3 08/11] hw/char/serial-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_SERIAL
Date: Thu, 21 Dec 2023 16:07:47 +0100
Message-ID: <20231221150750.5435-9-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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
index 141a6cb168..62fb529e39 100644
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


