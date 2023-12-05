Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7604280495D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 06:33:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAO2z-0006nS-Av; Tue, 05 Dec 2023 00:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rAO2U-0006lJ-Uu; Tue, 05 Dec 2023 00:32:13 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rAO2T-0008Jn-Da; Tue, 05 Dec 2023 00:32:10 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d069b1d127so16793285ad.0; 
 Mon, 04 Dec 2023 21:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701754328; x=1702359128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swnPg/7fJEw3CHsdU9PVM7uQ2PGcZxfqGpb64m2qPzc=;
 b=IJBgY6QMAiwVN6j1G+2y5qwqbKLLWUCjr1CbX0ZYWbFoDSAae7qwQf7S6QjDMThSSz
 rG2jYaqNXR2nv8d41Gnl3nY2sGHV8qDB7Jrb0Avb2b9UaiUs2Nl9/uXhAR3yeS6iXvWe
 yJMBZJPV+lFPFgysjRGAWPruqkseXW56KX0G1AzgHlO6WljxoMUO9h4lDg0/sf/zezAi
 8ni5sUz6316RARYiOyHKr9q50Xcyh8gB5oe5GIreDHVMcNV49RQKZXW6sbEgZkeLCTxd
 36CP+3bTL+9oJFsE8KF4RbqL0hTiqHxTAg9XBjsK0Dr2c0Sq+qBkjKdZFjz1pBaJMMnL
 M0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701754328; x=1702359128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swnPg/7fJEw3CHsdU9PVM7uQ2PGcZxfqGpb64m2qPzc=;
 b=npmkYWJTlyUrUe/4WXJzr4UJkVBKHcUbKwtmrk+fqBlJvCrs/pDZnh6GNjdwLvRbDe
 3GpgOfZXwTEsvejgjxFtky+LpWfalUw3gnjVzJ1KwwYUy0IC0O9VOFbFNytuFi12UH+G
 zXzRrGwMpxZeZzgbZ+S3VvapO8XOsy0YFXRrP2B6BE5WJiHzEg9gJ5ygIdf8gi4miw08
 mjMppnIm4cQjjHJLZDbt5Z0nuvNn21OE6zpQDp+vL9QPSKdlj4y1R1hZgI8SXMJtMBNA
 JsZqEyObSYsHGxQT4xct6UU73S34DvCJYBXQkMNHTIdArAobxjhpeeVVYynpkOy6pL8x
 HKeA==
X-Gm-Message-State: AOJu0YyY7b4tt7YuxVJ7JipJSeu1lVKcmRmOUDSj91RLR2ux4A+IXOXz
 OYmGkBwZLAgKQ6hud2c3w1fJshADwvs=
X-Google-Smtp-Source: AGHT+IHgs35mG4ORafhEf+laN9cAWtKFb+3fjnRfXKXLuzs6pvAnNQxOFD0JauM/6TzfdBKLf9LAFA==
X-Received: by 2002:a17:902:be15:b0:1d0:6ffd:f1fd with SMTP id
 r21-20020a170902be1500b001d06ffdf1fdmr2332810pls.83.1701754327645; 
 Mon, 04 Dec 2023 21:32:07 -0800 (PST)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a170902ee8500b001cfc42ccfcasm7581806pld.152.2023.12.04.21.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 21:32:06 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: stefanha@redhat.com
Cc: jeuk20.kim@gmail.com, jeuk20.kim@samsung.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Akinobu Mita <akinobu.mita@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/1] hw/ufs: avoid generating the same ID string for different
 LU devices
Date: Tue,  5 Dec 2023 14:30:52 +0900
Message-Id: <80a37b039ea9473d038bcef8bb64f4213affeae8.1701752391.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701752391.git.jeuk20.kim@samsung.com>
References: <cover.1701752391.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x631.google.com
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

From: Akinobu Mita <akinobu.mita@gmail.com>

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

Resolves: #2018
Fixes: 096434fea13a ("hw/ufs: Modify lu.c to share codes with SCSI subsystem")
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231204150543.48252-1-akinobu.mita@gmail.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
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


