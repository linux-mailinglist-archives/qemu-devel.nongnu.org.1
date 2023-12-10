Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8557780B900
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:31:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCOi-000221-0b; Sun, 10 Dec 2023 00:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOb-00020W-Le
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:31 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOa-00033d-2g
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:29 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ceb2501f1bso2671431b3a.0
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186226; x=1702791026;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t1tcGfQ4SRRj8JwSrh0aUXk+5EheMc4ohsnW0IBo9tQ=;
 b=YIHo+l5+obfVtvufeF04qaPEBYQZZSv8gSKd/U8U4I2wntsExdEOw+phsxM89bc1nD
 R6xQI8yZT7JATIpYzGM/lEbXUZLhs2+dX06vvC+r/EoicICib8qC4uz53de7w7KQ8CR4
 NQJhsXHoJFFUa9n4AWWzfELy/zX0c2699KNxymsg8P0VJ5KqWS2GQhoSIlHdzaSFB8yg
 yde2sy1lzEKtIzMvYBcpdfjPRInVmnkTL2/Yj5i4EfErzJCuoLxnhwGom/ZH9rSswKT6
 IDQBG8qobaORLGo8p2oUEbKjvCI8P1h0eFl3pRLNLwZL5GqJ7d1IFmO34fKj7dnori99
 UeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186226; x=1702791026;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1tcGfQ4SRRj8JwSrh0aUXk+5EheMc4ohsnW0IBo9tQ=;
 b=XScxpSk2ILlqb7H+qTMijLuFyjQP3JNNAI+s0Bf8inoDCUcWrIV/KFlTuzpsDTyVns
 K/5pEhQiEOvaS0O84IWAfCbF0e0F3qgXqwMxFwBom/oubLFrf1uwFV7+Y+BxHwTKlzUp
 HnvJfpNnktEAk3gahBkipd5ca+Bq4McF5b/kPq95nxEjI5AJ30P9C6md4Fw5JL06NGaP
 o4v46TUzDpYEgMrgiAxEBPHLBq2HjKm2pFySEFz3dpZmmcLcUoPoq/aiuKHt/b1jGuVi
 OA5FHLfevyS74X14Qv3EcdrNMjMN3yZE6jOXhPRaF+q8/C1xbFIAPtAQoRLBCrRsXvUJ
 G1dg==
X-Gm-Message-State: AOJu0YzpppeVZ44vCog60HXsfgmU258sUZW/NCYX4eO7wqC717/gdUcQ
 YpzAnXmMRu3kHFcSpx6YpurykQ==
X-Google-Smtp-Source: AGHT+IEUKIn0G33uVfQTK3Z2qxeuNENKqZEFY5jh5Qh75fJ0898jVpMBTy5yfVFXtm50QNCV2o8VmQ==
X-Received: by 2002:a05:6a00:2301:b0:6ce:f81c:a436 with SMTP id
 h1-20020a056a00230100b006cef81ca436mr1914957pfh.21.1702186226728; 
 Sat, 09 Dec 2023 21:30:26 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 q6-20020a635c06000000b00528db73ed70sm3939431pgb.3.2023.12.09.21.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:26 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:44 +0900
Subject: [PATCH v8 06/19] tap: Shrink zeroed virtio-net header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-6-9553ee714d38@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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

tap prepends a zeroed virtio-net header when writing a packet to a
tap with virtio-net header enabled but not in use. This only happens
when s->host_vnet_hdr_len == sizeof(struct virtio_net_hdr).

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 4d450d2972..7666ada8d9 100644
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
2.43.0


