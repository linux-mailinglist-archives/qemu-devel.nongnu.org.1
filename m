Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B747EFEBC
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:28:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4HbW-0006vt-FY; Sat, 18 Nov 2023 04:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HbR-0006m8-Lq
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:02 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HbP-0003kr-Uz
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:01 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6c10f098a27so2387940b3a.2
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299618; x=1700904418;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2l2kwRZ3SSXGYY+q7Rmmw2UBIt1gERzTGqTOyDqDwA=;
 b=AK5+l9ia9/sQbvjR2jTLaLU6N0X05cVVXuYKTEQH1R/Ik7Ouszm32XnHOfjLf+Wbt/
 vIXWb7ip9ZW+FryASHLKYFAjV460SFfAJbgPDMMdWgObxfM7AMY8MSd/hGMKFnWtXDEP
 q3BRxcruZ8DyKDlnNK8sgMWMRkPZwXbfwIzYCEQaS5L5Jk/Wf2O5FMV6pm2eVqyoM3HC
 IXVDqlqTB9+A3AWuViOoWNnSaIZusZMnuEg2oJfRW+pBI2y8GrXF9MCz7ovozQ8rPe8d
 yhsgUlXo3AGA1MYu1BeutOWnWsXpj2sbmb1VETHIu98wWwt6M4//gLmNHFY9hE/OFutr
 fNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299618; x=1700904418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2l2kwRZ3SSXGYY+q7Rmmw2UBIt1gERzTGqTOyDqDwA=;
 b=C9bhj2yX9rrqT/yK34/TtGVzNu58ptsc/Df6m7GOZ6DOx6z5VDq6En+XvDogR/mA0w
 aqZ1PbhgHYJLbYxH86Hi6pqg82D1ORk8bXDsEYSZ6OEmGJG1OLf7+uC3ULk1D8Mrotmf
 JI1opFah3bPgwMQ7HLoU8tafIOI/176VTitoTelOP4OJ5EUcQIkk6yLyt/HNrWQ3oB9y
 aagjromRwkXY8RwCKMkPW8Y4kvyjAvK2+LfqDg5m3kzJS96ywfbOHmzSsU3dqyoSPLMX
 Z/hlKudt2+8W7Cic6vlnykZEyuzLrCxp7SkszPn7ULGShtjxGgx5LbDbpETcYDEqrY3x
 VpDg==
X-Gm-Message-State: AOJu0YzgSdKaJpdFe0UxAcLDTnLQYQaBbwR52CGUB7ysJizG9qhuLSdK
 4X150/N6gqHRsHiByZtdqKGbKq4wK8L2HZqh9og=
X-Google-Smtp-Source: AGHT+IEBPAga0e5EnChJFHJs3RJsyg4mhT4hpEcdfw+qceecjtis7x93FdiUhJuiEz3+zS2rTYHPgA==
X-Received: by 2002:a05:6a00:2d0d:b0:6b2:5d32:58c with SMTP id
 fa13-20020a056a002d0d00b006b25d32058cmr1638277pfb.22.1700299618640; 
 Sat, 18 Nov 2023 01:26:58 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 gu5-20020a056a004e4500b006b97d5cbb7csm2686565pfb.60.2023.11.18.01.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:26:58 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 12/19] virtio-net: Always set populate_hash
Date: Sat, 18 Nov 2023 18:25:52 +0900
Message-ID: <20231118092601.7132-13-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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

The member is not cleared during reset so may have a stale value.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 40beff2262..eed5a9bc46 100644
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
2.42.1


