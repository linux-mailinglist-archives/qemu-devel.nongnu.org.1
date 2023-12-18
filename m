Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C93A817A1E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:53:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIix-0006Vw-1e; Mon, 18 Dec 2023 13:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIil-0006Le-O0; Mon, 18 Dec 2023 13:52:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiV-0008Q5-2q; Mon, 18 Dec 2023 13:52:04 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c6a71e88cso44841905e9.0; 
 Mon, 18 Dec 2023 10:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925500; x=1703530300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hxeuo8c4Hhd1U5I1nXh+SQy23QcDbLcnuSYji2d92Y=;
 b=KLhNt4Chd9pLC/MZqJsrsfY21HJPPHxIaQtxUAiIioXB2/YX2YZrZ1RaffRpUPO4LN
 zQe7KxDTIlfgn74E/8OjP0tx7pcOMNo++skT4J1PJ/VU+F1gSGc1NniRYGaisxn121WG
 4+uzm16mNRDD8KvTTikWslymGEMf7s7+uz+EmLGf1hAm9MDYkqEQuCl4DNnvq07+mc1Z
 TzbghQpFJIn3dI46HvRWF34ZOmMApBDTRz/6ZMnvgsp+E/QP/1WwrRNyyBYjbnUTcvfY
 ligQocT5ysC8KvUIIgDgBGDmeauoajOWSCxVWKhoMD9rk8ZLxr2W2SF8OxJxdrcFRiut
 gXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925500; x=1703530300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hxeuo8c4Hhd1U5I1nXh+SQy23QcDbLcnuSYji2d92Y=;
 b=ALtjJf8KGECtcPhsEW6aWxsUmLDFqQy9wGxvyXwVu3UnRuaOrWZt+ROiel16Q4+dpH
 gWzNCcq66WsZWdSnabXkBLed/2lbh3Alt13LUok13FOlHWk0zh1YoAf2Wd0vZDa8eAfx
 1McP0+2NIM86JrAWXKJd5dhbX8xtzTWwaurzaufp7EVLLTFN5r3RRuFvy3PlLPlQKf6M
 3SFSDq7lbWQBJBHJdhOL54q86XsqMIDw14OJBsvxhgdRr+DcI5yZlstRi/1KdBNN5BON
 VYzGaoVEk3D5UuOHZ25/ag+8s7sl5s99SuzkjUoT3gK7HlgPU+1UOegeCs3X6oDwhbYn
 PLdQ==
X-Gm-Message-State: AOJu0Yy1g6GQIBHVr74e1Tw5dfdXnkqaEC7UESddUvTg9xPlBaPMV1jl
 zoOj9zvK78p7gufXEwRsNgEefXZXj28=
X-Google-Smtp-Source: AGHT+IEUn1jcbNUfsQ8fivnVt89iRBlvSMw5wXEfeOIbn0L8jhkYbtSPPxxjClqFE+/WrUkFT5y+wA==
X-Received: by 2002:a05:600c:3657:b0:405:3dbc:8823 with SMTP id
 y23-20020a05600c365700b004053dbc8823mr9481675wmq.12.1702925500317; 
 Mon, 18 Dec 2023 10:51:40 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:39 -0800 (PST)
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
Subject: [PATCH v2 08/12] hw/block/fdc-isa: Implement relocation and toggling
 for TYPE_ISA_FDC
Date: Mon, 18 Dec 2023 19:51:10 +0100
Message-ID: <20231218185114.119736-9-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
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

Implement isa_fdc_set_{enabled,iobase} in order to implement relocation and
toggling of SuperI/O functions in the VIA south bridges without breaking
encapsulation.

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


