Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 745817CB994
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:11:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbPU-0007fV-Vq; Tue, 17 Oct 2023 00:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPS-0007bB-6R
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:22 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPQ-0004Oc-NR
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:21 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57bab4e9e1aso3262550eaf.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515819; x=1698120619;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66Wq6nwp6JKCW7FgLUM3GGIozoOuRE9kC20BLESWHY4=;
 b=e9w6STz4bNVhKtIEqBuFwRK6RophrZxXXfm+N4ssDqzEovY+gyJR16OC8Jyh+eXgiX
 1M0faIHahEUa6NU2ltupUlQFNXdjyue8kCUui8bje/ROu0JXEzk2QZ2q6JGkSBBKdnEC
 ClzEbNBoSXXw4jAYu9hNSC97m4un6BPjAA8+MDHSESfROjloXLEeHJXphGu09QntuUea
 junB2LgXtJv9UFvWRR3jZ/Zwev7lyuJL8qLr7lEzYFRMOA/y3cEyNAYK8zG6mPXda7hu
 SbisrK7ZHWf5+g7GTfrzUpobzUmB/+su/XLlA7etFy+E7nct8zQI+eLVL9HkCNtgbWPN
 15Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515819; x=1698120619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66Wq6nwp6JKCW7FgLUM3GGIozoOuRE9kC20BLESWHY4=;
 b=CZaFXE4kBi28uvBDiPMve8tknvPUd+zHthwxiyRRlwEDZyui6ahyWjUJPSrqWdaMug
 Vdlf9EL97jNxO5bPZcS1MgnkdBjE6rlha0+PBi6d51+ELNYGX/NYms4pDgHHKysYvu31
 MgwuuJ9x4QEcGUkyNZnnt4C9E6Zuua0FCYIzkKE6KxQqrbtHtQxE1wi5aT4J7wADEJIW
 xttrDYr306RLMQGCjN+1iUAyqHcmixbLt/FYlOVy0cVWIaG4F/lb6SWu1hlkrWWt4/57
 XZ0qNrTeNEqS3BAa/ETCJ//csL6zl4DwB+qzczYIzl2ZAnGUF72+pvVHKc4IMVWLhHQn
 amHg==
X-Gm-Message-State: AOJu0YxVTlDrnSIZXReuG69hUYV3TCE1Kjuf1nY3Quvh/bwhINSTI11K
 bDq3rOHjxpqToBD2iIO2DhVymrGQqCow0l66aOnR5A==
X-Google-Smtp-Source: AGHT+IFLEm6zXba3nYI8pIfrCmD2UmaCw5dp7n1ytu+vstsMi0uQWUmh0MNEyPpYZZCYwE6/407Fcg==
X-Received: by 2002:a05:6359:5e9b:b0:15a:8dfd:9c68 with SMTP id
 px27-20020a0563595e9b00b0015a8dfd9c68mr1297153rwb.27.1697515819232; 
 Mon, 16 Oct 2023 21:10:19 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 y18-20020aa79432000000b006bd2bbbaf49sm353207pfo.122.2023.10.16.21.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 12/21] virtio-net: Always set populate_hash
Date: Tue, 17 Oct 2023 13:09:18 +0900
Message-ID: <20231017040932.62997-13-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc36.google.com
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
index 20feb20bb1..6eb206f297 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -643,6 +643,7 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
         n->guest_hdr_len = n->mergeable_rx_bufs ?
             sizeof(struct virtio_net_hdr_mrg_rxbuf) :
             sizeof(struct virtio_net_hdr);
+        n->rss_data.populate_hash = false;
     }
 
     for (i = 0; i < n->max_queue_pairs; i++) {
-- 
2.42.0


