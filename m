Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BADA7DB9C5
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 13:20:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxREq-0005ci-Ja; Mon, 30 Oct 2023 08:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxREe-0005c3-14; Mon, 30 Oct 2023 08:19:12 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxREc-0006Bv-GO; Mon, 30 Oct 2023 08:19:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc3bb32b5dso12863635ad.3; 
 Mon, 30 Oct 2023 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698668347; x=1699273147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqILtahsmpKEGgPpWoojJBg/GYJJwPwwT5GHSZIcz4Y=;
 b=Tx3NZ38g4S/4Jlv0oA7PBFibB1UsYrNXj5P1uyXlDm0efgzNKd4TdMICCObHRp4V2m
 ndQdULLN2l2Dffo2cyBjI7WkhSqFkoCfMRimPKs5vUdPK5U7Y0OHEV/ZdostIqYLXkdQ
 0IsSLNaxANVMHEmltOgmObkXQ6cj/8DRt0G+SdULg7MkZ0YfX49GhvM63hdFenQJEEa0
 DQv4erwqpt18XaKQQUJ/Cl3SU0IuwW5AArTLmTozNpYOHA4YYlxhd72tcYld9r7Jt0wK
 GUKCGpVYFDkn0cUzIa3tR+36O3/j6CgnirZHBtolWzXtj6BJUv9rve7n9W5nD8y/IOTY
 jIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698668347; x=1699273147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqILtahsmpKEGgPpWoojJBg/GYJJwPwwT5GHSZIcz4Y=;
 b=SBMVe6zYb73sCIbguNED+CxApB+TWj5+5p5yLC/ZWGftwxgZldbfT+TLuQj3cvzbmD
 D/7Vm2+LejLxkH4EIavMszTbuB7UyotlpVe9TFiP7obFIhdLvyZ9S3gEn9R4DEuf+RnE
 P95ZpeM6lyi/1J5+rKcwvhV6SMhnzbyk3aPnWXj5lfaz0vtnjw4TQky/fqIiMsIHscXf
 djUScfQBWQ6/Aty6u/D0lpsMdAyMg/EzaRu3MjbQmnr22TcQSHl5ru/p07EzQFS+pAUr
 //rZnNWuPsiPuMaC5fglcLCOmGus/6saIUR4khcKwbpt2iWEGmDpXiRJIBIGHHmsa5DA
 Y8jA==
X-Gm-Message-State: AOJu0YyQh3/Ws9WH6aCycU1oEf0zdtuWz8DIoOxzRC+KjvhRqchAgssk
 8hTdehu+uH1t8gQ4wtRKxp8UxgABbXEv8dJf
X-Google-Smtp-Source: AGHT+IELIk39dQ8I+/8XH1ldBHGVAT5ilFu5+9R/H06FQc4IabfhyosN5eObo0xWoYlwabxDzlgu0g==
X-Received: by 2002:a17:903:41c4:b0:1cc:4a84:27fa with SMTP id
 u4-20020a17090341c400b001cc4a8427famr2823084ple.9.1698668346909; 
 Mon, 30 Oct 2023 05:19:06 -0700 (PDT)
Received: from fedlinux.. ([106.84.131.249]) by smtp.gmail.com with ESMTPSA id
 f12-20020a170902684c00b001b9f032bb3dsm6362339pln.3.2023.10.30.05.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 05:19:06 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org, hare@suse.de,
 dmitry.fomichev@wdc.com, stefanha@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v5 1/4] docs/qcow2: add the zoned format feature
Date: Mon, 30 Oct 2023 20:18:44 +0800
Message-Id: <20231030121847.4522-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231030121847.4522-1-faithilikerun@gmail.com>
References: <20231030121847.4522-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x633.google.com
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/system/qemu-block-drivers.rst.inc | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 105cb9679c..4647c5fa29 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,39 @@ This section describes each format and the options that are supported for it.
     filename`` to check if the NOCOW flag is set or not (Capital 'C' is
     NOCOW flag).
 
+  .. option:: zoned
+    1 for host-managed zoned device and 0 for a non-zoned device.
+
+  .. option:: zone_size
+
+    The size of a zone in bytes. The device is divided into zones of this
+    size with the exception of the last zone, which may be smaller.
+
+  .. option:: zone_capacity
+
+    The initial capacity value, in bytes, for all zones. The capacity must
+    be less than or equal to zone size. If the last zone is smaller, then
+    its capacity is capped.
+
+    The zone capacity is per zone and may be different between zones in real
+    devices. For simplicity, QCow2 sets all zones to the same capacity.
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
+    The maximal number of 512-byte sectors in a zone append request.
+
 .. program:: image-formats
 .. option:: qed
 
-- 
2.40.1


