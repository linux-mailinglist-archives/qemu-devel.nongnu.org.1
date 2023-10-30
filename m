Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C47DB2B2
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:16:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKcK-0002Fa-Jp; Mon, 30 Oct 2023 01:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKcD-0002Cv-J5
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKc6-0001o3-K3
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc58219376so746505ad.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642897; x=1699247697;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeHqh5ROds9WlVkY1AXprqzj/F8R+EYfVz7LrzmcUL4=;
 b=TyNkKoLp5pY7ZWMQ/nvulAHFW1YVtO/73kRY2YEqV+J3hLMO5RkVUKLpMTzvXbTH8y
 fIRXESztYukLatbr3OXD7MJSlvaWdumVZWljb2OhYlGn4TwodmIUGJHeN7JBRLkjiSk9
 y2blrK+dPhsDXmagjIHgG2l2mYrC42NrxsqwGJ1ma3kRTEp5Ac8a+dkY/MMtbHj6W1Cn
 20tIFfvq/rqP3DwqTp8QTFEMgScZfsup8CUZUqahxzgokE3Q4wwwqNjc6H56FKWLm0bY
 7MmjpvTSNw3vEsi9jRoa0IpnS85WL9SIJf9NkxYdFXOj4XfbKcLCpbi0slhsNAYVztoH
 /I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642897; x=1699247697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NeHqh5ROds9WlVkY1AXprqzj/F8R+EYfVz7LrzmcUL4=;
 b=iQlx0HuMSJfVQePUaoTR2V4eL8NOI7HYJRFDhkhsHFoXJ040JqtYfOdUqDiSZdw6wB
 KtXVvfQ89B9KCnRhaQMGq4VNUyy2e+wDXWhh/3NmlXi/DnYgozcUD05SSBvPjCz8hZ9T
 3KuDQ8uIZDCT8PiFTAqSY4hTZ8ooykij1DhCWe309AS6egLPCRj4Nv99ythpWLGo+dIp
 B6wfV/bT03UgcbWEzcRrDA/wgwOLq8lkmhNABr/HGkorLl8CpBD/QVKfe9XT93E8Uf+X
 vY+npvGxxw9QvFrvV8jFw5s0I6EVXJBeYbW3esv0NHrHDrHIkzv+nsSZovebL5Gg0sc6
 ve4w==
X-Gm-Message-State: AOJu0Yyb5ugWDY+wm2fL4RyJSoWfgCuBlaeZcv60cHi7njcgpnEOAKvj
 qm0/4dbLDiXmvzL2LBCNPbt+Ev46zCnTcmqWQdtcUg==
X-Google-Smtp-Source: AGHT+IFFERJVHqqVUwaFGE+tZd7RwYIUu9Ns1ZmhAP720NV3b41+ipDmmBO+ym7yf6XhO2t8Y6xfBQ==
X-Received: by 2002:a17:903:2945:b0:1b8:90bd:d157 with SMTP id
 li5-20020a170903294500b001b890bdd157mr8761532plb.26.1698642896949; 
 Sun, 29 Oct 2023 22:14:56 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 d13-20020a170903230d00b001bbb25dd3a7sm1667107plh.187.2023.10.29.22.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 13/21] virtio-net: Always set populate_hash
Date: Mon, 30 Oct 2023 14:12:34 +0900
Message-ID: <20231030051356.33123-14-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

The member is not cleared during reset so may have a stale value.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1fa020d905..0fe75b3c08 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -650,6 +650,7 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
         n->guest_hdr_len = n->mergeable_rx_bufs ?
             sizeof(struct virtio_net_hdr_mrg_rxbuf) :
             sizeof(struct virtio_net_hdr);
+        n->rss_data.populate_hash = false;
     }
 
     for (i = 0; i < n->max_queue_pairs; i++) {
-- 
2.42.0


