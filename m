Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D839B7C5847
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:41:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbKR-0003FB-9W; Wed, 11 Oct 2023 11:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJp-0002RG-Cx
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:23 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJn-0001zA-ID
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:16 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9daca2b85so846855ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697038813; x=1697643613;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdRn3xY+r+zZRoAOUO1YfZyC5ZVoV18TeJ1QBbbHIlQ=;
 b=chls8Nw0IoY2052w8BVd40jDHoSy00n2G8JOCjnjYMShFjDkmE58WmWbJFSMGif18e
 iIauhk0yKruCmV3yZHk0R2D6wG6c3sTDZQJzd1nMZDKqdHXT7ZUfVAjBsNT4PAGIfIww
 A7fOKIF8raaWalouQErxeT3XBVwLXOkRZdR9slzfcUg5xkNqsMbtnqU6WIkRjkT4tNWt
 A9yOzvHScI3qF7Uo3OmY9j+96VwgRcKCAhFWTg3TamVzN3rNQcZ7+u+yshCXVEvO9rzq
 QBOgEj/3opeDMNOvHLr4AKpjjvF3UZ0YtnBIpVJZLUP7yEpTIh7SkbpV44HmXxcfZ5qW
 EWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038813; x=1697643613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdRn3xY+r+zZRoAOUO1YfZyC5ZVoV18TeJ1QBbbHIlQ=;
 b=FAI+16EZ4P0COEirzLbdCF6vyhILhodNdeRxdhHQRQMpdEcwqEcfPfStqQUksZ6GIX
 ua2GXbngtgftukq+douQS5DOPOfk3rf/p6ohKPgdnzL7ONCptBTuRYC7L+e/tMBD/bW6
 xCKf5545isaAhQGssKNywfCkdtkO/6lao/QnC0P2HECR6vi8R3IRUKFZQJxBZZ78GKhT
 P0/lDCD08eiCzQQgUgoMFSOj0pXbM8tC/4HHW9rdklJtr5s6dsKQbBUqKkQ2Ao3EL99J
 QPQIx/UkpmXuiBZrZHbUwlWq3qe91HpdhUlAB5X6IAWPgyh0u5mkpgIlMGp/IwLB7Jp6
 lJoA==
X-Gm-Message-State: AOJu0YxwPIgINsFlU5D7HQLjkjdDfHy5ag2/tS/MocQop1S6GJaA5tFA
 PJakJ3TH5HxYh/aI4Rucm0xVzC2B12RWl8Asga5Kug==
X-Google-Smtp-Source: AGHT+IH1HD4+r4MviKA0GkBBfXgKr+2WGRE/dNdg7Nd58+A26GaFikChPb/yf2S1SBc0DKzUUNRdfw==
X-Received: by 2002:a17:902:d490:b0:1c6:de7:add9 with SMTP id
 c16-20020a170902d49000b001c60de7add9mr31722456plg.19.1697038813036; 
 Wed, 11 Oct 2023 08:40:13 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 a12-20020a170902ee8c00b001bd28b9c3ddsm3460066pld.299.2023.10.11.08.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:40:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 05/11] tap: Shrink zeroed virtio-net header
Date: Thu, 12 Oct 2023 00:39:36 +0900
Message-ID: <20231011153944.39572-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011153944.39572-1-akihiko.odaki@daynix.com>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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
index 668d69c0de..4c1eb92076 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -118,7 +118,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     const struct iovec *iovp = iov;
     struct iovec iov_copy[iovcnt + 1];
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
+    struct virtio_net_hdr hdr = { };
 
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
         iov_copy[0].iov_base = &hdr;
-- 
2.42.0


