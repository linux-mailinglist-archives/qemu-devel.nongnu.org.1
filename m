Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C209B78B415
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qadsr-0007L7-5V; Mon, 28 Aug 2023 11:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qadso-0007Gv-Tk; Mon, 28 Aug 2023 11:10:27 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qadsl-0003xc-11; Mon, 28 Aug 2023 11:10:26 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bc83a96067so18703175ad.0; 
 Mon, 28 Aug 2023 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693235420; x=1693840220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDHHz+q6ejXO/n0U7nyQnkQnf0gAzaVz4gaPvyp+lr4=;
 b=P1OUCepmJ8dxYPfsMPjBOubduUYgAC2Hnqo4KN9K3O4gAvHFHdLo89/ySQU7or7g/2
 AYEBQvWG3dJvWq3fN2BwwrbN2X1yvuEr0vosB9W/KBUqm23blk0Zu9ddsJtFqkotH92P
 IEZ24RINZiyqwxgIHHGaju+euz3HF5KgBAIMIEj84N2KhJT5wg4LApCCUvcvUKqxaK++
 JRVpY+SHlzgp5+pLQvNlR2mwmwssX+aAeGjxgjS1cEp9hWDEGVxPdv7p+7yddeS0G4bb
 TtVKC9auBMhNougo63XR8SkSBbvpQgG2mmARJiOrB7w7rOITQw5VBf5D/T5BPesYpheD
 tfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693235420; x=1693840220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDHHz+q6ejXO/n0U7nyQnkQnf0gAzaVz4gaPvyp+lr4=;
 b=C2mZQs9EzCfNyyWh8U3mZG4NiChTkz44MG2kfwdUgu+6OBt0VIF3oELNOQ1NvG1t+4
 u+At1DF6yicLua/31VAYUVUmqhi9zA4wiqPE/gwIecU+gL6vEY495TiH3oxO+XVvuBiv
 nOXPcyxianBydZLTyfwWimnFjOI43U8xKlMdf+JZFn3xyGIVxL0a0PThHQevecEb5wM5
 TinSUUSlBDvAllU1ZUZ6lO7Uos4s2GHY/gNF8Nye86E97gWXOaojWMQ3YswULrdhDmRh
 MgoES2U1DxfhGZ8hFsfUQeuc6eVcqkit8Wp7rc6v3yS6It6B1Csy9WOkkU6NrKutx4+T
 qOoA==
X-Gm-Message-State: AOJu0Yx7+R5GHvKLYnsBzykUhv4fEEPLiVHjy0NZmcvr80Kf+v4Zt93H
 Yfr78N9QrvpiL1E4rLNBqBJZePa4UEBNpWwEDTI=
X-Google-Smtp-Source: AGHT+IHhBF0Q6QzwRQl/qn1zbTgJuL7OFsm7Vx68O7ARYu2cgNlEy2XSeh/fRdIyHKCH7r3RRDV61w==
X-Received: by 2002:a17:902:ee89:b0:1bb:b86e:8d6d with SMTP id
 a9-20020a170902ee8900b001bbb86e8d6dmr18815700pld.29.1693235419672; 
 Mon, 28 Aug 2023 08:10:19 -0700 (PDT)
Received: from fedlinux.. ([106.84.130.225]) by smtp.gmail.com with ESMTPSA id
 i19-20020a170902eb5300b001b8b26fa6c1sm7427456pli.115.2023.08.28.08.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:10:19 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, dmitry.fomichev@wdc.com,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, hare@suse.de, qemu-block@nongnu.org,
 stefanha@redhat.com, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v3 1/4] docs/qcow2: add the zoned format feature
Date: Mon, 28 Aug 2023 23:09:52 +0800
Message-Id: <20230828150955.3481-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828150955.3481-1-faithilikerun@gmail.com>
References: <20230828150955.3481-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the specs for the zoned format feature of the qcow2 driver.
The qcow2 file can be taken as zoned device and passed through by
virtio-blk device or NVMe ZNS device to the guest given zoned
information.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 docs/system/qemu-block-drivers.rst.inc | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 105cb9679c..640ab151a7 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,45 @@ This section describes each format and the options that are supported for it.
     filename`` to check if the NOCOW flag is set or not (Capital 'C' is
     NOCOW flag).
 
+  .. option:: zoned
+    The zoned interface of zoned storage divices can different forms which
+    is referred to as models. This option uses number to represent, 1 for
+    host-managed and 0 for non-zoned.
+
+  .. option:: zone_size
+
+    The size of a zone of the zoned device in bytes. The device is divided
+    into zones of this size with the exception of the last zone, which may
+    be smaller.
+
+  .. option:: zone_capacity
+
+    The initial capacity value for all zones. The capacity must be less than
+    or equal to zone size. If the last zone is smaller, then its capacity is
+    capped. The device follows the ZBC protocol tends to have the same size
+    as its zone.
+
+    The zone capacity is per zone and may be different between zones in real
+    devices. For simplicity, limits QCow2 emulation to the same zone capacity
+    for all zones.
+
+  .. option:: zone_nr_conv
+
+    The number of conventional zones of the zoned device.
+
+  .. option:: max_open_zones
+
+    The maximal allowed open zones.
+
+  .. option:: max_active_zones
+
+    The limit of the zones with implicit open, explicit open or closed state.
+
+  .. option:: max_append_sectors
+
+    The maximal sectors in 512B blocks that is allowed to append to zones
+    while writing.
+
 .. program:: image-formats
 .. option:: qed
 
-- 
2.40.1


