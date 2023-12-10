Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48C80B907
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:32:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCOh-00021O-8G; Sun, 10 Dec 2023 00:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOX-000202-1z
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:25 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOV-0002zc-FN
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:24 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35d67599613so21360045ab.3
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186222; x=1702791022;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wXts4hDTKg1kNp331Cjsk9KmYW3djoMTUaudTD1RCVY=;
 b=pJBGvNrC2IbZmKOPhgPqeyIJq11RoEdTEi+rOLA2OjDqgV3BSsGzJ215P3gEoS2cT3
 k6PgJ0tl3952RMYWYkCN65tdVBu8uBSLU7W0GXj81YROp4YtJOjf6f5Pz6soss/9iKxQ
 QvPiO2Mrra2mIMbk3t0nbUFhO0sZ0W4MV0i0R5mOeu1SvCjQb8undZJxt0ap20s+yIuw
 tIL1jCvvlGeQb6pWu3KIjCNToGg3YXD9cwxZGBTIiJmQ73mGgsggeH+0g5P/s9A4CYAD
 aHzZRoKWJJSo1hjyQ4qdAeWWeVTo93Vlg456i3wrII2cScReSpS/w2AvL6VIiVa2QUf8
 fCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186222; x=1702791022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXts4hDTKg1kNp331Cjsk9KmYW3djoMTUaudTD1RCVY=;
 b=CUDUqV79gEq15Im/tK2gf5C5qqmLVltWNeTE6kgZPm/8uK9YAWTcftVS2dP7Plyvpb
 1Kg67qgWIBeAi8PmwAQ7NszFyR7nKPrSTjQVOfl5mmf5UkXT82djOfyXYAGN4Aq7fFVz
 ugXxpN3HeVn7R9DkNvfHZ0IX8BIJwyWElhmN9Z5yg0kNmMo1r80o+x0HLKiTu4mZ394y
 h5c9XHa+XmP74cOnbbvokxhXJIogLhzbjb6mVrfQ+aJPbb7EXVBe7V9ip2r57LYyZfvc
 k/+lD7qdIFDl2AK4mqbVIGYYX2s9xE8brSGX8IbUW1sXGIXXNXz+mtzq4tvta/BuKo3S
 ClLw==
X-Gm-Message-State: AOJu0YzwXtdXkM0akZ00I4JcJTmqe1Jd8BCjRJt3wUJkRQPFhJJFSfUY
 KQmGqjEd6CWlLK1LnkPe1AqCGA==
X-Google-Smtp-Source: AGHT+IH5sKmCL5MzNX7bwMcfMRu9aX5aS5i6Pc0dpXR3OrX3cEUkkTvH3GoWxuoxWlktn38BHHw+lQ==
X-Received: by 2002:a05:6e02:1b81:b0:35d:5995:79a7 with SMTP id
 h1-20020a056e021b8100b0035d599579a7mr4300156ili.65.1702186222255; 
 Sat, 09 Dec 2023 21:30:22 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 h17-20020a170902f7d100b001d0695106c4sm4222854plw.105.2023.12.09.21.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:43 +0900
Subject: [PATCH v8 05/19] tap: Call tap_receive_iov() from tap_receive()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-5-9553ee714d38@daynix.com>
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
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Zhang, Chen" <chen.zhang@intel.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::133;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x133.google.com
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

This will save duplicate logic found in both of tap_receive_iov() and
tap_receive().

Suggested-by: "Zhang, Chen" <chen.zhang@intel.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 09ad8ae255..4d450d2972 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -133,39 +133,14 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     return tap_write_packet(s, iovp, iovcnt);
 }
 
-static ssize_t tap_receive_raw(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[2];
-    int iovcnt = 0;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
-
-    if (s->host_vnet_hdr_len) {
-        iov[iovcnt].iov_base = &hdr;
-        iov[iovcnt].iov_len  = s->host_vnet_hdr_len;
-        iovcnt++;
-    }
-
-    iov[iovcnt].iov_base = (char *)buf;
-    iov[iovcnt].iov_len  = size;
-    iovcnt++;
-
-    return tap_write_packet(s, iov, iovcnt);
-}
-
 static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[1];
-
-    if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
-        return tap_receive_raw(nc, buf, size);
-    }
-
-    iov[0].iov_base = (char *)buf;
-    iov[0].iov_len  = size;
+    struct iovec iov = {
+        .iov_base = (void *)buf,
+        .iov_len = size
+    };
 
-    return tap_write_packet(s, iov, 1);
+    return tap_receive_iov(nc, &iov, 1);
 }
 
 #ifndef __sun__

-- 
2.43.0


