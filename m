Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E90968039C0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:09:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABV2-0006iS-Jt; Mon, 04 Dec 2023 11:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akinobu.mita@gmail.com>)
 id 1rAAWo-0006JK-Cr
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:06:35 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akinobu.mita@gmail.com>)
 id 1rAAWm-0004td-TX
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:06:34 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d05212a7c5so14931645ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701702390; x=1702307190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1ziSnIsPzByqpD+AtC2nGk/p66cLnCzLz6sUZDTWMY=;
 b=aaFZyxHY6MmkXoQntrS2WXKYQAoRdZs6eNpEAC6/9jipKykZjsaAnQCe70X3PPhEGs
 Io1nYV9HVmAwZu2eEgHqsEbDQHEZtCqH32H/zVabjT7v4nnM8DyU7X+ccyhJnQKaXR79
 FmEiETzAKqXaU7tg+VpIbJlutmH6JvqzJMzTb/BdCiYPCp8BACgYm5unppQXHmd3zZrS
 fMJcGCTLVJOaB93UZkibFKU8QbvCI7JqAKy4NF/7KlYN87t2963Qf3uJslJuGbp4PbAH
 NO5KdVabeZCQXpBz/ftQUtHSZ0pE8husONKYdrt0/aIdsNxK2xu4QQYTvvU904n3dr0I
 QRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701702390; x=1702307190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z1ziSnIsPzByqpD+AtC2nGk/p66cLnCzLz6sUZDTWMY=;
 b=ZROR91gE8y0Zzhrw7oX7MB5k4iLgoo7YJ3wEv7P5qO4Q/Cdom3HNPA+NQNfV+SDDlF
 zZf2eofOxKWxbbaAPnoACAxuy9bAOP+04kmj8Hn8dWv/LIeXNscq0g10fIKwjeHRkpGn
 tmxYOtuIAb9tYEzXwI9A48mT2oxz+cPn8mrq04rHCT3XYbK1DRudQMNOsoUbT19yzSXP
 AKQtlYou2HGouvBPAlykIZD044o/XZAC0lyvKCpr1OtJJiNC9d855LGYI0YE+EV06NY3
 NRhGGM8oCnKxoQ+PfhfOI2zT31wmdDELMwYR27xFCRRTfwwKFUZPrIin5ZK+RWQ9wKRq
 t5Zw==
X-Gm-Message-State: AOJu0Yy1PFxUsDoWlBLvmaSOr5eLKzUZm9vYr0C27hU7t59ERRDx3E8t
 hx+QiJCldAnk7f708d78CTk4QAFgK/E=
X-Google-Smtp-Source: AGHT+IF2Yntqr+Ia61wFnxx5qVXf0MXYOH6iU5/yJHBwTJgR9FFBUr8iIkmklQwL6kO31Yxt0qEZ0A==
X-Received: by 2002:a17:903:1251:b0:1d0:6ffd:8359 with SMTP id
 u17-20020a170903125100b001d06ffd8359mr1481367plh.100.1701702389557; 
 Mon, 04 Dec 2023 07:06:29 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:38:7f96:4b01:61da])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a170902ed5500b001d04c097d32sm6967791plb.270.2023.12.04.07.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 07:06:28 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: qemu-devel@nongnu.org
Cc: akinobu.mita@gmail.com,
	jeuk20.kim@samsung.com
Subject: [PATCH] hw/ufs: avoid generating the same ID string for different LU
 devices
Date: Tue,  5 Dec 2023 00:05:43 +0900
Message-Id: <20231204150543.48252-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akinobu.mita@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 04 Dec 2023 11:08:47 -0500
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

QEMU would not start when trying to create two UFS host controllers and
a UFS logical unit for each with the following options:

-device ufs,id=bus0 \
-device ufs-lu,drive=drive1,bus=bus0,lun=0 \
-device ufs,id=bus1 \
-device ufs-lu,drive=drive2,bus=bus1,lun=0 \

This is because the same ID string ("0:0:0/scsi-disk") is generated
for both UFS logical units.

To fix this issue, prepend the parent pci device's path to make
the ID string unique.
("0000:00:03.0/0:0:0/scsi-disk" and "0000:00:04.0/0:0:0/scsi-disk")

Fixes: 096434fea13a ("hw/ufs: Modify lu.c to share codes with SCSI subsystem")
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 hw/ufs/ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 68c5f1f6c9..eccdb852a0 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1323,9 +1323,17 @@ static bool ufs_bus_check_address(BusState *qbus, DeviceState *qdev,
     return true;
 }
 
+static char *ufs_bus_get_dev_path(DeviceState *dev)
+{
+    BusState *bus = qdev_get_parent_bus(dev);
+
+    return qdev_get_dev_path(bus->parent);
+}
+
 static void ufs_bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bc = BUS_CLASS(class);
+    bc->get_dev_path = ufs_bus_get_dev_path;
     bc->check_address = ufs_bus_check_address;
 }
 
-- 
2.34.1


