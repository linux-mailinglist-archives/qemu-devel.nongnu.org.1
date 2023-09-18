Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BAD7A466B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAwj-0002Iu-Dr; Mon, 18 Sep 2023 05:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiAwh-0002IO-Kb; Mon, 18 Sep 2023 05:53:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiAwg-0002HO-0o; Mon, 18 Sep 2023 05:53:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6907e44665bso684871b3a.1; 
 Mon, 18 Sep 2023 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695030812; x=1695635612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxSJRCnX8SN2drnrq6vb4a5EwxGykJ0hHcfM5c4bJm4=;
 b=ULzuGnAn68TlyDg0hqtn1lA980YFCK4e/P5kBNdT4sv9JbViy6wwBoeFuhm4NZA1mK
 zoER4ueeNov9sHSwF3yuAETaipATrmNAqc0KR4eUgURDzcQgmVuYXSCnVSCigieJ4NSA
 EPgIwm0mLl+h0akbn/1PTuDLZ+xo2kTwqgdI6vuWOFHNF+5X1ruJ3HsVh6AF1yVhWD/G
 DWZroBAq1mMfW9BrQJSsNKH69nwnfoWMZDZ/9oqLRufQfuIOjH4N3DATcAClacpIQkem
 cW77CuLIJeLXMsjM8ViMn1i8iie3E7pFgZ225XnlKN4OSXmLVxNdopmADYdLWIf4Hbmi
 qrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695030812; x=1695635612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QxSJRCnX8SN2drnrq6vb4a5EwxGykJ0hHcfM5c4bJm4=;
 b=OtqdPUF9E2sWhNSyGuEym1kbnAiELpHLPyhtoW+pXhliQRxTep6G7rROfnL3tyB+z4
 Xv3gJ2fw9I2vbZqkseJAbdPkP6mO86BTrR+SOnf8vEy+jWCwHFGC1ofFpxyZC+46TD62
 ncWsRE1Y5K5v2h0JCSZ0EImplhU6GTtF2z2csnfON1JnpRK7KhR3Tnku9B0LxQs4XtHp
 q780qeTeVjHWS+WcphpefqynpPz76ynLfVgMYARhIT4LUI+Rajdfq87pSE5UfGYYij7R
 no+qm5rwtuF87ufVgORUx4IoxRWpWPKbesYd7lJcZmK2C4Oq/KBsayvM90I/RElTx/LO
 xMyg==
X-Gm-Message-State: AOJu0YwQffYV/Nf2pBbK25rVdVyzjCD8u9N5cKgwmKGEz8jsQPotAy0l
 ITMvjH+d9Cjif4eEDQPHRzXuLeFuCTadK+euWLs=
X-Google-Smtp-Source: AGHT+IG+7vRRE6Vlo+Sd0sFdgQJ/l6uJ8qgAjOAslIPmhiw9zbLDY3uUv4zm4mLnqZqQDNQJNls74Q==
X-Received: by 2002:a05:6a20:938a:b0:14e:9092:4291 with SMTP id
 x10-20020a056a20938a00b0014e90924291mr11477040pzh.7.1695030811529; 
 Mon, 18 Sep 2023 02:53:31 -0700 (PDT)
Received: from fedlinux.. ([106.84.131.213]) by smtp.gmail.com with ESMTPSA id
 y24-20020aa78558000000b0068fb8080939sm6780553pfn.65.2023.09.18.02.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 02:53:31 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dmitry.fomichev@wdc.com, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v4 1/4] docs/qcow2: add the zoned format feature
Date: Mon, 18 Sep 2023 17:53:10 +0800
Message-Id: <20230918095313.5492-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918095313.5492-1-faithilikerun@gmail.com>
References: <20230918095313.5492-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x433.google.com
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


