Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A981BA4B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:11:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKfA-00005J-6Y; Thu, 21 Dec 2023 10:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKex-0008KC-Oe; Thu, 21 Dec 2023 10:08:28 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKen-0004M3-8L; Thu, 21 Dec 2023 10:08:27 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cc6863d43aso8862441fa.1; 
 Thu, 21 Dec 2023 07:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171293; x=1703776093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iquediHwxiTNDcXJ44lhoBWeyM5ESXdCgXvXlhjLxU=;
 b=mmTs/f8r2VZoGqWVOD2cr1M8Ttu3sLpn0yFOE4to34ep9gtxvtKddStIemB0ZsC4SR
 aM9cePzAknbOnnknAWt9CbG6QISs/ZAvy1g4dJE696gpsJQL/DuvdWXXpXZQ8AJDgzWW
 fh8fNKw+70IQT4B7aML+JtEF4FkpyWXqtYlKGC19DsY2i9LEpcdwUdi1IAi0jhTluAcS
 7y6GFADsI4EZ7UsY1jkTy6yTi8pKnjnty1hT8vEqyGKrXaP1ZDHNfFbYIzWD+ZOXXFpf
 gBYWB55Qip5OEJqY+Oix0eI+9uitxoowcf4Nxqb6pNVwqRVSlvCTgwVtb4jWh0jG3tr4
 6x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171293; x=1703776093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iquediHwxiTNDcXJ44lhoBWeyM5ESXdCgXvXlhjLxU=;
 b=FL5XK2lE7tPT/nFP6yp+qfJsQ1sYevXddG/qYhARWbcoMk2pTDXtmOEGiLGu/L7l16
 83zyL7FhdH+UQpygLo26/NRymnmZReZRQWDSRgy4qmQBsHbgp9wDbQXwyCMluawPvdNz
 ZuLtrqx3/tFnWPfsmEFK3IZHeOcFy9P6A27Np7fInmHjmQHP67jZUaLZqqXpXsC7/QCe
 g/cQSakFnnVFIGxGnpuq15GrYgMgWX+vq9DF/rijedzYf7oh/NS6W9vsuyBE5ufVHZEg
 Adty2mOvneCCjVpRaoz+25pgNhizLd3rjCJKH698QQYA73mwDSyXlByVQgpa2Olkqc2E
 kgpw==
X-Gm-Message-State: AOJu0Yzte2Nfy+qKss6j6Zjz2gJqTiBtrSfP9BLwj3V+b2VSQ6MLY2ik
 BzAkTuqBRKLS0T4XD0QrKwxQaUhd9OHb2w==
X-Google-Smtp-Source: AGHT+IH1ExdNDRtE+22ptgOee0aQrp0ByMejiBOxpId0oKXMxgEgYaoAkqHTUfI/FOd2cziNwf3Wxw==
X-Received: by 2002:a2e:b172:0:b0:2cc:7c8e:2f79 with SMTP id
 a18-20020a2eb172000000b002cc7c8e2f79mr2317583ljm.107.1703171292664; 
 Thu, 21 Dec 2023 07:08:12 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:12 -0800 (PST)
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
Subject: [PATCH v3 07/11] hw/block/fdc-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_FDC
Date: Thu, 21 Dec 2023 16:07:46 +0100
Message-ID: <20231221150750.5435-8-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index b4c92b40b3..c989325de3 100644
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


