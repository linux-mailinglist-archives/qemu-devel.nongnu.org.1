Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD1C826194
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:07:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDrq-0005gL-K9; Sat, 06 Jan 2024 16:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrn-0005fH-Qf; Sat, 06 Jan 2024 16:06:04 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrm-0001Af-8D; Sat, 06 Jan 2024 16:06:03 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3368abe1093so631412f8f.2; 
 Sat, 06 Jan 2024 13:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575158; x=1705179958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/DnmwsZ7xP8YAXiG+Ug2+agkl77mYRu9Wp28MfNLeE=;
 b=OJTvaIsE03wJqP0DmNEqYo7PrFR+epFXHRFVbJJAUABbwbkg4nxgf7met5CgSAt47U
 dF6/9YuLwIynNT3H7nqrg0DS6OrSy8N4yFdJ9qt3PhoLS3+1nBnpxZCDLM9HxAtwKnRi
 bcjV8Up+9Lqj4Gy+Mwoh0GNyM+DMlEQwfZcbHypfP6Y26DQ4DcgMtyC5lFVhsFfcj4JO
 mEQN2DIMSDtuhgmvj2l560anQNJd3Cn4rereLwgUXCFI4Bfnl30hykLw6xMm/qEey9Zr
 EmK6IP1T9F4rCyx9lOaDX6V7FUWKTpYbTU+7NFv4wSNaR7kUWlRL24M1OBUBpM+H74t6
 svLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575158; x=1705179958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/DnmwsZ7xP8YAXiG+Ug2+agkl77mYRu9Wp28MfNLeE=;
 b=o/YTnULqwX30XZTsSkX7Ke3+yfUv2Uw4ik8YoLYD76EC+LoO61rQ4kUnylHI+zI72G
 p3xlu3vLZ32i2kVPWvhvJZ4FQnY2aFr2gbHADTqOT9tqdRrtOI0aHcsmrsOCBLYgyyv4
 2a2mHeknGhBMIvM2bkmPNkRHI5o1T/YJychBEZ8ukWCWHOd+73cQaVVMK17ibLHf2ZCB
 gWLx3FUXQfl3HZwXmDswJwG21KBwEbF6ql+C55JgwL69CoNX+PUv/k5dc3FTe5nYWR28
 /4qxRqK2331yoa3yxU1+Hdx4TuqysmFywaJc64hno99WSDAJBP+QB98sDMiR9Ykx/+wT
 QPcQ==
X-Gm-Message-State: AOJu0Yyh/ADlgzRlTrSL8216yNLR28ueWk1oAcqJ26J2eHXWGK4DcxjW
 PaJiI46lYtXX9cUTmkj9hIMGsvbJSbE=
X-Google-Smtp-Source: AGHT+IHhalljsJT/0csqKr/rwDF2CMzpSFNjT0vQQ4dyeFph8JRw6xTd8IWJO/gC+R9KNpRWhxPiHg==
X-Received: by 2002:adf:fe03:0:b0:336:5f08:bbe0 with SMTP id
 n3-20020adffe03000000b003365f08bbe0mr700600wrr.101.1704575157677; 
 Sat, 06 Jan 2024 13:05:57 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005576f4471besm624922edz.42.2024.01.06.13.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 13:05:57 -0800 (PST)
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
Subject: [PATCH v4 07/11] hw/block/fdc-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_FDC
Date: Sat,  6 Jan 2024 22:05:27 +0100
Message-ID: <20240106210531.140542-8-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106210531.140542-1-shentey@gmail.com>
References: <20240106210531.140542-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x435.google.com
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


