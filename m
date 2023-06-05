Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2C7223B6
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67eO-0001zs-Vq; Mon, 05 Jun 2023 06:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q67eN-0001zb-3q; Mon, 05 Jun 2023 06:41:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q67eL-0006o9-IC; Mon, 05 Jun 2023 06:41:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b075e13a5eso40043445ad.3; 
 Mon, 05 Jun 2023 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685961679; x=1688553679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Tls8VZU7Ofv7la2Mwd3gt97iymWk+im8mzONkVgbMc=;
 b=YgbImyHDTIJg+IxVCdgR0ntfeVKUbiWFU9OkxIzX5YYKxD5nlcZKiXYo22xgeqKped
 XigWHvM1XDpyBE92uowUqPjI/4wHSCxFMsmCpqC4lVhkdhYtMVqvFFgDABYa9ewtDOS2
 PHonyzMMyd3zL/23xWknLPCzHGIv5i5FLqvgW+aNUHIxE0aaYQTgEgeskLTjOFPl9fUX
 NiC8o7LBWRslq/M4oS4X8CMIiMvQIXAvRN0lhy35OMzGzRs+HPYtD47Tm/M3x8RxuYmP
 AhF3FZRSm9a5qumgTaLNPZyU9XsucaAAC1KZWWBXZa6MvbtB9HQ/p/E8nN5XdyeuQCIJ
 LBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685961679; x=1688553679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Tls8VZU7Ofv7la2Mwd3gt97iymWk+im8mzONkVgbMc=;
 b=Y5N478DJ3pwUMLgvt6r07EQYTPv79uYRH84ZpHW5e55GTSrAU08rBpLULSwUINF4x2
 umqwz1f13tMqyY23QXZpbi7vZEcaqb5639fg1IIws8QGvq52tjEIpsBJj7jFJ82BA5aS
 e2N85cqn5c8DZO/W072/fb9zAMO55PoDDsA7APGoSBzY2nbrmPVRmQMvpUA/99scyFfM
 CZkA3UN/f6tZH4ghT/0LHsP2LNIFlKIxujFQPsZwGGQ89iva0etUqw5H7DwgROolV/kY
 xxcdCpwa6Jow7reTJUopEuEAMy4ZLBNNhbZNINnGcFhlGX77YBHdug7av0CLYz4/PQ1t
 OcCQ==
X-Gm-Message-State: AC+VfDysV5WwpcLxjFbNZgTGHR7ZAcHTQmyMI53KV5tgiSzAfa/c/SQ3
 PPwzOtnebRIcMD6wrq5mgUohwfzxJbyNT8HO
X-Google-Smtp-Source: ACHHUZ7sgsE/AXoKOFn3Kzn35zWWE8dmdnioEXjfeS2pQ/eDzYUUHQYJVNRh1Yo1wnrzxGEfpX7Hkw==
X-Received: by 2002:a17:903:32c6:b0:1ad:cba5:5505 with SMTP id
 i6-20020a17090332c600b001adcba55505mr7989831plr.14.1685961679078; 
 Mon, 05 Jun 2023 03:41:19 -0700 (PDT)
Received: from fedlinux.. ([106.84.132.130]) by smtp.gmail.com with ESMTPSA id
 x4-20020a170902a38400b001b0457705e8sm6340141pla.140.2023.06.05.03.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 03:41:18 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, dmitry.fomichev@wdc.com, hare@suse.de,
 stefanha@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [RFC 1/4] docs/qcow2: add the zoned format feature
Date: Mon,  5 Jun 2023 18:41:05 +0800
Message-Id: <20230605104108.125270-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605104108.125270-1-faithilikerun@gmail.com>
References: <20230605104108.125270-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x62b.google.com
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

Add the specs for the zoned format feature of the qcow2 driver. Once
the zoned_profile is set to `zbc`, then the qcow2 file can be taken
as zoned devices and passed through by virtio-blk device to the guest.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 docs/system/qemu-block-drivers.rst.inc | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 105cb9679c..fdcf343652 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,37 @@ This section describes each format and the options that are supported for it.
     filename`` to check if the NOCOW flag is set or not (Capital 'C' is
     NOCOW flag).
 
+  .. option:: zoned_profile
+
+    The option configures the zoned format feature on the qcow2 driver. If
+    this is set to ``zbc``, then it follows the basics of ZBC/ZAC protocol.
+
+  .. option:: zone_size
+
+    The size of a zone of the zoned device. The zoned device have the same
+    size of zones with an optional smaller last zone.
+
+  .. option:: zone_capacity
+
+    The capacity of a zone of the zoned device. The zoned device follows the
+    ZBC protocol tends to have the same size as its zone.
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
+    The maximal sectors that is allowed to append to zones while writing.
+
 .. program:: image-formats
 .. option:: qed
 
-- 
2.40.1


