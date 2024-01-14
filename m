Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55B82D093
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:41:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzmG-0003Nr-Bp; Sun, 14 Jan 2024 07:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmE-0003NM-5i; Sun, 14 Jan 2024 07:39:46 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmC-0001jN-Ev; Sun, 14 Jan 2024 07:39:45 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e63bc90f2so24762105e9.2; 
 Sun, 14 Jan 2024 04:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235981; x=1705840781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/DnmwsZ7xP8YAXiG+Ug2+agkl77mYRu9Wp28MfNLeE=;
 b=TvhOHXCG+T9ueMTz3X7pk9CVszmsZiVT0mros0s7gJ5P6gULpedZTx64Gq0YQ9qfpp
 OlofSh8qw0hOwZbwpLK+AsAduKmLKovWNLj3dYJsGiYr+cJas3kv5O1P3nCYsWnXaD3n
 L/yWNLNylggQu3Kk9RybGJnUCVv1Yfpm+2V362IXFOMNVoTf0uYTHYlTifz3xnJTVYzZ
 q3/eDTJQM5Y5gKOVe4BK7qFeyOOmSb+5KWl0NJvN5CPFOKmL/h38sKEEZISWYcS0T3H7
 VoAcHmt+HXox9ZsNr8enNiW0WyUvB1t7oWLg8nTcIExAsTgEpSn+u2M03PeZ8p3NxBE4
 7fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235981; x=1705840781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/DnmwsZ7xP8YAXiG+Ug2+agkl77mYRu9Wp28MfNLeE=;
 b=fV0QrSfksF8UsqbB3LRvnllJbwxlKGQmL4P7dAChmx+33uiCh0kyLtN1rXj2yqJ1qX
 DNZ7ig26+MR01YK2CCU0Pgta1CApe3TedO9ZjBbA1dCvVyB9Srtou7nGVwtAf45v9eCO
 e6bYDwLnNUcYDLoyVOsHO4ViNgv3U57pvBefpULB9/DVPeu/8V3nT4J7wnsOnvhMUQOm
 Ws89Ungu6Uwr9jX09b6YrfgI/CCcShZTw2wD/ik8izVB71bOVpGQnc++rxqIA/ZdIfUI
 E1/5IyKUysWUsHs55UyjyCJpbrK2i/iM7GBjXhxD7ZcG/oaYi34LsxhcEj4ltiEMm69T
 0a/w==
X-Gm-Message-State: AOJu0YxpjZV4F4eAxfnXI7NBC+RL44lbNTZB85sCAwvinvhWuvrSrt1C
 ocFx/1wG9NLxXjLaH2O3oLckKaUeTvk=
X-Google-Smtp-Source: AGHT+IHd8Z37S+Z8k7S+pRomCbI3yME/rVdXQCWk5EUCJhJvuRxiHOBRGfdf10qKEJPTKEV9RBOOXg==
X-Received: by 2002:a05:600c:5d1:b0:40e:70c0:830c with SMTP id
 p17-20020a05600c05d100b0040e70c0830cmr679197wmd.15.1705235981294; 
 Sun, 14 Jan 2024 04:39:41 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:39 -0800 (PST)
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
Subject: [PATCH v5 07/11] hw/block/fdc-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_FDC
Date: Sun, 14 Jan 2024 13:39:07 +0100
Message-ID: <20240114123911.4877-8-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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
Prepare for that by adding isa_fdc_set_{enabled,iobase}.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/block/fdc.h |  3 +++
 hw/block/fdc-isa.c     | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 35248c0837..c367c5efea 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -14,6 +14,9 @@ void fdctrl_init_sysbus(qemu_irq irq, hwaddr mmio_base, DriveInfo **fds);
 void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
                        DriveInfo **fds, qemu_irq *fdc_tc);
 
+void isa_fdc_set_iobase(ISADevice *fdc, hwaddr iobase);
+void isa_fdc_set_enabled(ISADevice *fdc, bool enabled);
+
 FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
 int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 2d8a98ce7d..e43dc532af 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -192,6 +192,20 @@ static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
     return dev;
 }
 
+void isa_fdc_set_iobase(ISADevice *fdc, hwaddr iobase)
+{
+    FDCtrlISABus *isa = ISA_FDC(fdc);
+
+    fdc->ioport_id = iobase;
+    isa->iobase = iobase;
+    portio_list_set_address(&isa->portio_list, isa->iobase);
+}
+
+void isa_fdc_set_enabled(ISADevice *fdc, bool enabled)
+{
+    portio_list_set_enabled(&ISA_FDC(fdc)->portio_list, enabled);
+}
+
 int cmos_get_fd_drive_type(FloppyDriveType fd0)
 {
     int val;
-- 
2.43.0


