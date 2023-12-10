Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F53980B905
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:32:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCOe-00020V-Cc; Sun, 10 Dec 2023 00:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOP-0001zK-Bq
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:19 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCON-0002yk-9m
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:16 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1fb04fb8d28so2098228fac.3
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186214; x=1702791014;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0MY3jD2Xj0cz/GhTVoeL+xxUc1zBe6IOx2wcSytOtnY=;
 b=t8vMtNhxR2YSlltkMCmcORGzdWhIKXPIFG98fgEQI7mlesO0vtDl9o0ZiuxEgdUY5S
 MKoBx7NEJv8FG+dPIC3yNKyPwM0qIghzbxReEkXCMOf5Ng81ARz5+HD5eMojeoALs/TR
 X4csb8mNXvKtL8mWiv9Ta2l20rCvHLy5A79ie8l7aAVh+n5xjJGHLUbNTJNO7+qQJUfB
 ZiJolqhJ+j9MJOvI5mO0o2U3sr763l1AquzJvcDYG/Lnd1S32sQbaBwGHDK5PmPcKIjB
 fIF0uYaC7atQ2fR/9K4d5SzTtnYCnCKyIMFy6HYdcmm2qo1hVRxeMYaHiDymkTDvNbED
 Vz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186214; x=1702791014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0MY3jD2Xj0cz/GhTVoeL+xxUc1zBe6IOx2wcSytOtnY=;
 b=PfrpC5SVx4KmgbBALxxJyvN3SNADlhEPVOAnSxpTQmqmlU65ZySWarTqpP2FC481zp
 kr2Qcadz7/3tNKuNdbrbdQY4Mwo//71cpPTSaxH9ATzQo5r2+psgEM+CiB1hu+C+lMa+
 2gZ6X2wqnTcbZTD6dJjTscb2kl9gP1Bu7g64Rw8VCBNERLDP56JaaADokz7LILEb2PPe
 2q+ZcWHvERMLsrAxZhh1FhyMgSRKfcbb4VQArkUbXMcozSk8OLYilPOlQoADQJv9kvxa
 UDwsejv5G0OBdJtQlFDbAWacbPL26kdPBTilOdkDUs6xVeniS0rGlN3fxMA2rJmvIi6v
 PFrQ==
X-Gm-Message-State: AOJu0Ywoel3i/lb2u1u4p3lCudnAREEoXTCgph922pfCUUZ9LxF6nU7F
 dsNtV5+Aryuq2GbHtqZayAR0XBKwwV9vNOcsTYn5Pw==
X-Google-Smtp-Source: AGHT+IEWNWWgVzMJZ5IKEQI6H/cuAbAFwvC2A9pxKrvbppIYJ2x8joFz4T8VPNOiHzkSzCaGCbpwgg==
X-Received: by 2002:a05:6870:a54e:b0:1fb:75a:77c5 with SMTP id
 p14-20020a056870a54e00b001fb075a77c5mr2325850oal.118.1702186213942; 
 Sat, 09 Dec 2023 21:30:13 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 x3-20020a636303000000b005a9b20408a7sm4033365pgb.23.2023.12.09.21.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:41 +0900
Subject: [PATCH v8 03/19] net: Move virtio-net header length assertion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-3-9553ee714d38@daynix.com>
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
In-Reply-To: <20231210-rss-v8-0-9553ee714d38@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The virtio-net header length assertion should happen for any clients.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/net.c | 5 +++++
 net/tap.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/net.c b/net/net.c
index 98ed0280d3..2e70c4f221 100644
--- a/net/net.c
+++ b/net/net.c
@@ -56,6 +56,7 @@
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
+#include "standard-headers/linux/virtio_net.h"
 
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -545,6 +546,10 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
         return;
     }
 
+    assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
+           len == sizeof(struct virtio_net_hdr) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash));
+
     nc->vnet_hdr_len = len;
     nc->info->set_vnet_hdr_len(nc, len);
 }
diff --git a/net/tap.c b/net/tap.c
index ea2dadc943..f2021b699c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -267,9 +267,6 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-    assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
-           len == sizeof(struct virtio_net_hdr) ||
-           len == sizeof(struct virtio_net_hdr_v1_hash));
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;

-- 
2.43.0


