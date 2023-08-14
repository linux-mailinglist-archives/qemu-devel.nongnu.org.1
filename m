Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0977B4ED
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVTPH-0001qT-JQ; Mon, 14 Aug 2023 04:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qVTPF-0001qF-7b; Mon, 14 Aug 2023 04:58:33 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qVTPD-0007BD-On; Mon, 14 Aug 2023 04:58:32 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a76d882080so3550209b6e.2; 
 Mon, 14 Aug 2023 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692003509; x=1692608309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qu3bVl7jCDDdGJ4YFOuae/jvOn5imfkD1DKsfKioqqs=;
 b=n4bwrrwWoHGnPvKGwn1gMmBpvE7sRmAS0ZcUJRer/nlzlj2B9IjiE+JM6D7F1XBX07
 fN3Uzr9ysFPPjka/XS6wu6Xu0wVGIS4zTtaIfGbiocau2kZDrA4xAugihklFY1wv/Cy/
 2TYnHQHx2cDp1G0IqfyTcqoIE1Ujr38JibIQxvlBTDmJLKR72SJxNgYNjXBghVwFjPQ4
 OP2ifMlALnm7sX5PGtVtw3upLMZq+qecHX9cjtZ5BiJtkZwr8wCyddYLhV8uE2NOoh5F
 SNxdw357TrRkPLohnqrd7NLwbUP1zWmYrIaa63GAm2Y3qpx0LFeJfc8pmCREMJajgwj8
 +tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692003509; x=1692608309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qu3bVl7jCDDdGJ4YFOuae/jvOn5imfkD1DKsfKioqqs=;
 b=TgfvRws0YOlg1LnWSJAkygiNssY+21G0HDeSZU12PhM0itMUjem7gD3aH7QYhVGY/H
 sTa9Az05vrEutlTsNDQ5fLSra1rlr1/oHcmo5fFQYOUhsgvogc9mybcBQ88w4+Jtz71x
 poJVh0G6c8mS2/rNJzYXmmWA14biZNE1afLXIlOrfmphEKBQS8KiKaE3gL31CfeES8DB
 6dp8wNCOLjXNZg42MXDgWtkon+3yO7iw33FE5fQtUhtUP44y/ChkHvq+OLQtSi5cB8Hl
 yh01m1QZPCy4Mz4kOA/EiQA5D0Nkf57p5DMcnBNwKeYwB+scGVgOpt5IVbiuCgKd4o8d
 Fr1Q==
X-Gm-Message-State: AOJu0Yy4F6r88cNAn1dgVMydQzz0gV3JTEuWDIx5+Q4FBcaKWLzhMinR
 cdZg44EYuDTE/JvCm7Grm/CE4x8aa7dbc7ASYpY=
X-Google-Smtp-Source: AGHT+IH2N0bneuph6baTUH6uMHqBftkP+7B0cQIFR5e3k5O9KrBCLBk6bYc66HPxFIRhO3h/vC8JnA==
X-Received: by 2002:a05:6808:b16:b0:3a7:1915:c99e with SMTP id
 s22-20020a0568080b1600b003a71915c99emr9849660oij.53.1692003509225; 
 Mon, 14 Aug 2023 01:58:29 -0700 (PDT)
Received: from fedlinux.. ([106.84.134.250]) by smtp.gmail.com with ESMTPSA id
 bt24-20020a632918000000b00528db73ed70sm8238890pgb.3.2023.08.14.01.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 01:58:28 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: hare@suse.de, Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 stefanha@redhat.com, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v2 1/4] docs/qcow2: add the zoned format feature
Date: Mon, 14 Aug 2023 16:57:59 +0800
Message-Id: <20230814085802.61459-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814085802.61459-1-faithilikerun@gmail.com>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=faithilikerun@gmail.com; helo=mail-oi1-x235.google.com
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

Add the specs for the zoned format feature of the qcow2 driver. If
the zoned_profile is set to `zbc`, then the qcow2 file can be taken
as zoned device and passed through by virtio-blk device to the guest.
If it's `zns`, then it can be passed through by virtio-blk device or
NVMe ZNS device as a ZNS drive.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 docs/system/qemu-block-drivers.rst.inc | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 105cb9679c..2c1620668f 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,45 @@ This section describes each format and the options that are supported for it.
     filename`` to check if the NOCOW flag is set or not (Capital 'C' is
     NOCOW flag).
 
+  .. option:: zoned_profile
+
+    The option configures the zoned format feature on the qcow2 driver. If
+    this is set to ``zbc``, then it follows the basics of ZBC/ZAC protocol.
+    If setting to ``zns``, then it follows NVMe ZNS protocol.
+
+    The virtio-blk device allows ``zbc`` and ``zns`` options to pass through
+    zoned devices. While NVMe ZNS device only allows ``zns`` option.
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


