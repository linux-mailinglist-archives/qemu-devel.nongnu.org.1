Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 914F97C994B
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:04:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1iK-0001Ls-RH; Sun, 15 Oct 2023 10:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iI-0001LC-LQ
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iG-0007iR-VN
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9d7a98abbso23829175ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378603; x=1697983403;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3g8IJT6uWVVctIq1l77oTeOIaQXbUPqE/HwHsGc+XSA=;
 b=S8KfYbavG+YYJfIXwTTX+Fqe6Zas9X1cfTe232xnHF45JKu0Yn00tAMhFIIMvui6Pp
 FVSkILM9BJZ+OdNi862BifHzuao6p6Ez2sLN86ZgiYASLuCZUwAn1101qXMawg2k6SYC
 gc1C9zqqOfZktT849+kHp59NMmZD+Lj3x0+y3TtD+BzzwSCR7nfW4cs+vVqSikrgEuzJ
 HECThriALXHaJBX1eVXOoo4DL8Jp1hTsyALS1Q9JwjF6P+RkUi8H4v177jKMNhdWFNoT
 7V2hV42jqgm6iOY/gTDXZBaoz1yLxuZ1CHdylNLbPT8msRralnyiMUmziihDn2QGPP60
 NSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378603; x=1697983403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3g8IJT6uWVVctIq1l77oTeOIaQXbUPqE/HwHsGc+XSA=;
 b=P7BY8XQ+XkFBcxHXjxNMQIUi00PhC1oZDZvn9uEUxEG2gg275CIrUhvWTjmgyheROT
 +57TzDAdHIXQc6aN78rX0zCJvSx0toy7wtF1S8uFRXJdMNvDYT0sLGtupKE99fmMtJsf
 RZp05FMsBEtDvwTg7eS7c/y6zo73FctMRKmVtJnPXO/Kj3scGUVLZ8WrhzaQ3jCFzoTi
 mu70ABZfqDZOBOSkzUNha/EH1kuqnOKVk5Pe3TwMRsdrZrrm/tZFlFFqnuPFrcVYav1x
 i5qHF72zMG7TTh70G2ZqVz0zoRHoEeTpUoeg7ezCXh/pGspsQs1c+Vd9eTOw0xVBE+OS
 WIEg==
X-Gm-Message-State: AOJu0YzdEjGEHdXkJZoZdP338O5bOQF24kc0+LWlX7kQS497hXByu8/1
 jtFujuj20ZuAjI2QX5//vOxTZFMTlkKhl56tY0M2lA==
X-Google-Smtp-Source: AGHT+IGBZHYWEuoALtK83el65uFn9YN4sC/d1R6xfERsS6cKoX6N/OgTvo21L8g0kiyHmxPIvUsdyQ==
X-Received: by 2002:a17:902:9b8e:b0:1c6:2780:3adc with SMTP id
 y14-20020a1709029b8e00b001c627803adcmr24350587plp.24.1697378603646; 
 Sun, 15 Oct 2023 07:03:23 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 x11-20020a1709028ecb00b001c3721897fcsm6778042plo.277.2023.10.15.07.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 05/20] tap: Remove tap_receive()
Date: Sun, 15 Oct 2023 23:02:37 +0900
Message-ID: <20231015140259.259434-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

The receive member of NetClientInfo is only for legacy clients and the
receive_iov member is always used when it is set.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 087b2d3bc6..668d69c0de 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -131,41 +131,6 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
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
-static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[1];
-
-    if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
-        return tap_receive_raw(nc, buf, size);
-    }
-
-    iov[0].iov_base = (char *)buf;
-    iov[0].iov_len  = size;
-
-    return tap_write_packet(s, iov, 1);
-}
-
 #ifndef __sun__
 ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
 {
@@ -355,7 +320,6 @@ int tap_get_fd(NetClientState *nc)
 static NetClientInfo net_tap_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
-    .receive = tap_receive,
     .receive_iov = tap_receive_iov,
     .poll = tap_poll,
     .cleanup = tap_cleanup,
-- 
2.42.0


