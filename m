Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4617DB2AF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:16:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKbq-00025P-Gd; Mon, 30 Oct 2023 01:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbo-00025B-Dk
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:40 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbm-0001k6-Vd
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:40 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b2e73a17a0so2719136b6e.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642875; x=1699247675;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KaQnLJekJxShSPCiJ353ikQgxPXpg/lUHYJSCDri9/c=;
 b=zWwyxF9OE7D5xdDOQqYtMFarz2u1Cd0t4SKFTBVDNUZGEzNc/fhPDWXv1paCUPmSyv
 QUXE9c0Jn27UqCKmuvM5o/zOmbvRSwv3up4RaX9joBvfRAN0P349sOQkPR01iwD7D9TA
 TzK5OCoXsw7O2npL0iZKrz2lqE2/CUtR6TsR0r4po8n4jmonCssD5Ji60S9Xdbr/fmEe
 55+Z+me/dBwNkj+GTzD1/RJG9r/ELTzYa3JwWGEOjqKSKokldE0yEqI9kH2CeReeiIPO
 FhvI+FvFIVD+UFtgGVrNKobOsTMWQGX0mqTjfH87RxpM0Fr3tZSg1Hr13DvzSgyUzxzN
 1gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642875; x=1699247675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KaQnLJekJxShSPCiJ353ikQgxPXpg/lUHYJSCDri9/c=;
 b=kK9YuuAErY/X7DNHAK6n3DKj79hlS1lpn1N872gKWJ3ajyDhE9yu+0EyzcJ15Mt2Kh
 nGeZPTqhrNRxVpzUQQlCsm2ggbjkjORzXI4+kQMXutNPFYQoQfW21DwUtsVMDItWYoKl
 27K3Egl+MDjIgJJQmg6D9/eRB6YV6vwrZlIHwlwLG4vSYhU9rA7g8sDwvGIK+cnqEiOT
 QzZtTwUxqGy12HSe9U8B0v0RVgdtjF7pHceRXml+OhMisBiJ09LOpWowrufKArFvyMaN
 mUymFzrOZXoTTlbD8yhBHwYo3vdbSj3iAV7cForgzPxNIuWduuCjP65VXOd6gbeoumSk
 ZImg==
X-Gm-Message-State: AOJu0YxwHS3zEIJX8JXYU5IvPI1cwFJqCZFbx7anJFG/12n7LCu60aLy
 zt4vnQVrGBN74DR6pRGts1zkYvYBAMDmU8LjtW0cMQ==
X-Google-Smtp-Source: AGHT+IHI1do2kL+mRZkbiFdFMkNxlNhPWuICcnwsj6qlDprmPNbwt8O/dBnqgA1Scj2MuSpy9lJyJw==
X-Received: by 2002:a05:6808:298a:b0:3af:cc62:533a with SMTP id
 ex10-20020a056808298a00b003afcc62533amr8554224oib.19.1698642875648; 
 Sun, 29 Oct 2023 22:14:35 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 x6-20020aa793a6000000b0068fbaea118esm4984057pff.45.2023.10.29.22.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 07/21] tap: Shrink zeroed virtio-net header
Date: Mon, 30 Oct 2023 14:12:28 +0900
Message-ID: <20231030051356.33123-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

tap prepends a zeroed virtio-net header when writing a packet to a
tap with virtio-net header enabled but not in use. This only happens
when s->host_vnet_hdr_len == sizeof(struct virtio_net_hdr).

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index ab4e5a0e91..bef680bdab 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -119,7 +119,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     const struct iovec *iovp = iov;
     g_autofree struct iovec *iov_copy = NULL;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
+    struct virtio_net_hdr hdr = { };
 
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
         iov_copy = g_new(struct iovec, iovcnt + 1);
-- 
2.42.0


