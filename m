Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA767BF125
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq2yG-00045O-8h; Mon, 09 Oct 2023 22:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yE-000459-5d
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 22:59:42 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yC-0007wY-Mj
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 22:59:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-692c70bc440so3940924b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 19:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696906779; x=1697511579;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/drKQsw3H/n//rOXbeBtEedeUYZ8/NjLqaNPEt5EN8=;
 b=Ht5HMHFLs0yX3Vd3qZX2qd5WckIwDoqtFRzsMF0iYZiMVWIdSSUzHAPNE/wCHPzKTQ
 Dl8ovsggt+M6aWoLUoGkb2OeM79DBTD4Aaj4XfHH2HszdwUWLdcGO2PKKSkyjTl/oLb7
 hYvCy17UA4ajM98MiKonNWa6xzmav32oLbkR/DvftGmh3++R0geTF1WqA1J7V6ypDlBz
 L47ItmyvKFg4edPoOxiGQVF+iFqsxu+vGusFHsVrwpFH34xevMYWGQJGAPIidLSGq7R8
 YxDc4zfLWLjXJOR0F+f/dor9SjUfwkLOTFLwZGDHhG5gUNF00mR/4xoz/PSKPSvKGnD9
 9xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696906779; x=1697511579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/drKQsw3H/n//rOXbeBtEedeUYZ8/NjLqaNPEt5EN8=;
 b=LhwTAZZ4UxCH1hRXkqOfNSa8PBVjEeha4Wuu1rpGQLYdYGP0Gh2CzvJ/ntXDrFc6Gq
 RcIFNHvXucCabaPAI+pBfAIDvIEcifgXR+ag/TgCFr0j1dl9OyMftj8hvBN+RVv61INT
 RyOnJsmwKUDyIWzzu6Ag/1yiBzEWN+QU4i9r/LmPqrnAxufFbItEWWOw+7zCoBs8Phgu
 iFDT0wLuCLpRRO/cEiMyH0AmE299AR32FSRRuE81SqHBhTFud/TAxWKVi24JydzxwSAA
 xgbceYWjTe6qskzIlH8eE+oxdqEV96Vu5hQWnJ3YMoH2ysrjtzQD0GMUYpeuso6n8JNC
 Zogw==
X-Gm-Message-State: AOJu0YyLEYWTGjz0ot1Xt7QczlkYhOGvkD66DbYhVptQVbsqHTIv9Hin
 Vd+jbOaMLQUc2qKf999d0NodR7hTQdNEGCBhHmlCoA==
X-Google-Smtp-Source: AGHT+IHjUo0lRD1RIlmM9QDq7lG1mmX6gbJnotAhDAK2Xf04QKyU/vc9ezNhJqyC1ReCkX+SOY3Zlg==
X-Received: by 2002:a05:6a20:7d9c:b0:129:3bb4:77f1 with SMTP id
 v28-20020a056a207d9c00b001293bb477f1mr18006757pzj.0.1696906779164; 
 Mon, 09 Oct 2023 19:59:39 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 ja14-20020a170902efce00b001bd62419744sm10396813plb.147.2023.10.09.19.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 19:59:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 1/7] tap: Fix virtio-net header buffer size
Date: Tue, 10 Oct 2023 11:59:15 +0900
Message-ID: <20231010025924.14593-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010025924.14593-1-akihiko.odaki@daynix.com>
References: <20231010025924.14593-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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

The largest possible virtio-net header is struct virtio_net_hdr_v1_hash.

Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index c6639d9f20..ea46feeaa8 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -118,7 +118,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     const struct iovec *iovp = iov;
     struct iovec iov_copy[iovcnt + 1];
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
+    struct virtio_net_hdr_v1_hash hdr = { };
 
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
         iov_copy[0].iov_base = &hdr;
@@ -136,7 +136,7 @@ static ssize_t tap_receive_raw(NetClientState *nc, const uint8_t *buf, size_t si
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     struct iovec iov[2];
     int iovcnt = 0;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
+    struct virtio_net_hdr_v1_hash hdr = { };
 
     if (s->host_vnet_hdr_len) {
         iov[iovcnt].iov_base = &hdr;
-- 
2.42.0


