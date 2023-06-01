Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB6B719140
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:20:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Yqe-0007QP-Lg; Wed, 31 May 2023 23:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q4Yqa-0007PL-Vl
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:19:33 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q4YqX-0003Dw-8n
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:19:31 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5289ce6be53so1256496a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 20:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685589568; x=1688181568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmIxJv/RQZ1r+yT76IboD8L/ibu/PXdMmNY/Ba4zw4E=;
 b=LifDaFHsjEizUqk1VXUEMNKpYG+2uFwQWZ6WmhqcXRIokhq+sF0/tOYP3m8p66m5Sw
 ixVkHy6LMbrBelnPG8Q1Q9VRLCT+uqGDYCGM6cpIlvIhSQ3FFZGbw6zk85tp5GfS+ldw
 Da0krCI3eNH0oCEHagqgTjS5JGpkwahp96+PqTHoZpg3dydVTmpmjawNVceSXeK03RKl
 uDHry/5Rb534a/JTOwsP6b8N7HJmZpCpM7hLTgB3X2valR5fHWq29yMLiL9qGTiqTqCE
 IGUaKyP4J9vbFD+3AyXaVCi4WEEzIHEifi3LI1MYz+fnnZmTcLeNYfg5/h7F5O8KGHQI
 qzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685589568; x=1688181568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmIxJv/RQZ1r+yT76IboD8L/ibu/PXdMmNY/Ba4zw4E=;
 b=i6ABLmXpsQ4xX9GuMsZS6Uuua+lJ1aXuOhqlP31J4vaShlkr8kwSyIHiiaOzNoa9QZ
 UeqiqihqhGNWyMRAANZH2pYDKT7jgKJD3BOc7bK2bJaJRio+Tekr2B+ki7jXR+ylkJ/r
 0QTXfKugGg15Y7DYmBpVE13deNaBVaqOhh5dc2RLxAtPXtLdUwkEVNufZDtZ2fAPB+AH
 TrPKX6u2mVNjoQR4ATQtRT7A3AwLCjVweLkYKsvmjZudkUqdmqNpF/fIQa9D0XQHELbm
 oBl3dpt7J+arGuRYH11FbOR/2eawJLuXgXUrsZI3Bp8bB2BFSqNmThp8DeWsjTiMAnmr
 8lXQ==
X-Gm-Message-State: AC+VfDxxa4J3FUCkJSkQjAkUvrDU9xO0YN2qnIhz7Fc71mkLMWK8hx1a
 fEkrOuC8Z+3/SugHPBYLLs+YtQ==
X-Google-Smtp-Source: ACHHUZ5miu5cdAr+t12FHP1vTIi7NetVQS5akrT+IyNAzvoVQFkZ1wGN5w557t12H8/USySWfc8W4g==
X-Received: by 2002:a17:902:daca:b0:1ad:d542:6e14 with SMTP id
 q10-20020a170902daca00b001add5426e14mr680893plx.12.1685589567904; 
 Wed, 31 May 2023 20:19:27 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jd5-20020a170903260500b001a245b49731sm2146753plb.128.2023.05.31.20.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 20:19:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Mauro Matteo Cascella <mcascell@redhat.com>, P J P <pj.pandit@yahoo.co.in>,
 Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sven Schnelle <svens@stackframe.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Rob Herring <robh@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 2/2] net: Update MemReentrancyGuard for NIC
Date: Thu,  1 Jun 2023 12:18:59 +0900
Message-Id: <20230601031859.7115-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601031859.7115-1-akihiko.odaki@daynix.com>
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Recently MemReentrancyGuard was added to DeviceState to record that the
device is engaging in I/O. The network device backend needs to update it
when delivering a packet to a device.

This implementation follows what bottom half does, but it does not add
a tracepoint for the case that the network device backend started
delivering a packet to a device which is already engaging in I/O. This
is because such reentrancy frequently happens for
qemu_flush_queued_packets() and is insignificant.

Fixes: CVE-2023-3019
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h |  1 +
 net/net.c         | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index a7d8deaccb..685ec58318 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -124,6 +124,7 @@ typedef QTAILQ_HEAD(NetClientStateList, NetClientState) NetClientStateList;
 typedef struct NICState {
     NetClientState *ncs;
     NICConf *conf;
+    MemReentrancyGuard *reentrancy_guard;
     void *opaque;
     bool peer_deleted;
 } NICState;
diff --git a/net/net.c b/net/net.c
index 982df2479f..3523cceafc 100644
--- a/net/net.c
+++ b/net/net.c
@@ -332,6 +332,7 @@ NICState *qemu_new_nic(NetClientInfo *info,
     nic = g_malloc0(info->size + sizeof(NetClientState) * queues);
     nic->ncs = (void *)nic + info->size;
     nic->conf = conf;
+    nic->reentrancy_guard = reentrancy_guard,
     nic->opaque = opaque;
 
     for (i = 0; i < queues; i++) {
@@ -805,6 +806,7 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
                                        int iovcnt,
                                        void *opaque)
 {
+    MemReentrancyGuard *owned_reentrancy_guard;
     NetClientState *nc = opaque;
     int ret;
 
@@ -817,12 +819,24 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
         return 0;
     }
 
+    if (nc->info->type != NET_CLIENT_DRIVER_NIC ||
+        qemu_get_nic(nc)->reentrancy_guard->engaged_in_io) {
+        owned_reentrancy_guard = NULL;
+    } else {
+        owned_reentrancy_guard = qemu_get_nic(nc)->reentrancy_guard;
+        owned_reentrancy_guard->engaged_in_io = true;
+    }
+
     if (nc->info->receive_iov && !(flags & QEMU_NET_PACKET_FLAG_RAW)) {
         ret = nc->info->receive_iov(nc, iov, iovcnt);
     } else {
         ret = nc_sendv_compat(nc, iov, iovcnt, flags);
     }
 
+    if (owned_reentrancy_guard) {
+        owned_reentrancy_guard->engaged_in_io = false;
+    }
+
     if (ret == 0) {
         nc->receive_disabled = 1;
     }
-- 
2.40.1


