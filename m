Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8DE7467F8
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 05:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGWoS-0001AV-Ke; Mon, 03 Jul 2023 23:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGWoQ-00019v-TV; Mon, 03 Jul 2023 23:34:46 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGWoP-00032n-8G; Mon, 03 Jul 2023 23:34:46 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6682909acadso2481168b3a.3; 
 Mon, 03 Jul 2023 20:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688441683; x=1691033683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3CZYmpUITOvdpykc8+NdOHFwjtnMg+PjG83VfEH+ko=;
 b=Uq/u1hIJ7xw51iyIgtADhmz+x3+puH1MxqnU6+RYOPoTzdBLz4EeOIbpKIOz1HMqrU
 uOpjliQcyfkcclZx2qr6Ye1HMCMV7caLkFy06lI1p6rdQGILnGwPIb6CDYLK7xCNyM5e
 /Ovlhze+idafiZRNyZUF6xY2SYlhn6cDkgZZ9uxY8JAqc3HOKBeWg5mu6ciqE2U4CRzT
 BsAwd+biBP8vR7N96Q5yeDDPC3Zmco4lZSsMsMI2qbKZ/KW/A2jPsWxJbJ2AYQMp0WFk
 ru23H8H5N3P8Pn0p4UjDoldiiGFxX/o6KXbpp3J4vNBe9UXGOiMiiJklGOsu+24k3pHk
 g6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688441683; x=1691033683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3CZYmpUITOvdpykc8+NdOHFwjtnMg+PjG83VfEH+ko=;
 b=CInAXS5w60O/CzYr+piExqYnLRWns8DdtSkcPcH8o+qb7tQg/fPviga3OLGcF7HYYZ
 iXgj4MufG6zVnt2hyIL4v9yznTctEE/b2oc5M2iBzux4hqvsGsm5kJ7UvKphO5gjjIAx
 QuZR0KrDX6rTdrL8oqARHQNa0imtLgCBhIy1easzWUtAh4YGkXCQNIztJ1U3jpjAv2s+
 nFM622dB+cFJ4OzijJ2ybF9V+sBUNDNyLYKHtMxy15SWCs4J+8KMPJ4PQFe32LVmB2MJ
 V/jYXglAzu4+huYOldgW2fS1hEwljVqILncvfM3Q06F0+Pyy2AIFs+gtmq1s4lwxnr3P
 767w==
X-Gm-Message-State: ABy/qLZ83zx07YszgwDSy7WAAQyp/FPpT5jFsELqLs5jET2T2gdAq9rn
 NQ1bAMBfpseLrJWKN3f4gik=
X-Google-Smtp-Source: APBJJlEeHJhvL8yO/rkOGOHEpR1DL7v8DKpPl14CmhRaV7CP+9aV2PkZyKMpLff9ycajS0y2Gj6Zlw==
X-Received: by 2002:a05:6a21:9991:b0:12d:cf28:3bc7 with SMTP id
 ve17-20020a056a21999100b0012dcf283bc7mr8820484pzb.11.1688441682986; 
 Mon, 03 Jul 2023 20:34:42 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 z10-20020a170902708a00b001b830d8bc40sm9905139plk.74.2023.07.03.20.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 20:34:42 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, yin31149@gmail.com,
 18801353760@163.com
Subject: [PATCH v3 1/3] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
 _load_mac()
Date: Tue,  4 Jul 2023 11:34:33 +0800
Message-Id: <a21731518644abbd0c495c5b7960527c5911f80d.1688438055.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688438055.git.yin31149@gmail.com>
References: <cover.1688438055.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

According to VirtIO standard, "The class, command and
command-specific-data are set by the driver,
and the device sets the ack byte.
There is little it can do except issue a diagnostic
if ack is not VIRTIO_NET_OK."

Therefore, QEMU should stop sending the queued SVQ commands and
cancel the device startup if the device's ack is not VIRTIO_NET_OK.

Yet the problem is that, vhost_vdpa_net_load_mac() returns 1 based on
`*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
As a result, net->nc->info->load() also returns 1, this makes
vhost_net_start_one() incorrectly assume the device state is
successfully loaded by vhost_vdpa_net_load() and return 0, instead of
goto `fail` label to cancel the device startup, as vhost_net_start_one()
only cancels the device startup when net->nc->info->load() returns a
negative value.

This patch fixes this problem by returning -EIO when the device's
ack is not VIRTIO_NET_OK.

Fixes: f73c0c43ac ("vdpa: extract vhost_vdpa_net_load_mac from vhost_vdpa_net_load")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
v3:
 - split the fixes suggested by Eugenio
 - return -EIO suggested by Michael

v2: https://lore.kernel.org/all/69010e9ebb5e3729aef595ed92840f43e48e53e5.1687875592.git.yin31149@gmail.com/
 - fix the same bug in vhost_vdpa_net_load_offloads()

v1: https://lore.kernel.org/all/07a1133d6c989394b342e35d8202257771e76769.1686746406.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e19ab063fa..ee273c40ca 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -646,8 +646,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
         if (unlikely(dev_written < 0)) {
             return dev_written;
         }
-
-        return *s->status != VIRTIO_NET_OK;
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
     }
 
     return 0;
-- 
2.25.1


