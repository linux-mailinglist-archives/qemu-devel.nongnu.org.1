Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5667880B906
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:32:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCPD-0002e0-0Y; Sun, 10 Dec 2023 00:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCP6-0002VI-Fo
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:01 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOz-00038e-T7
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:00 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35d624b0415so14004735ab.2
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186253; x=1702791053;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qfIKInxQq2wvOkxbrwSjlmQGvbAZsun233FD9vE4bKI=;
 b=QXbhvdHcFW5IxKKX/vKBX/czMsVWqXRPefFyl4+aWhr6C0Uf6H1uLfgzor3hNVDWRR
 vy4+drBgTZxQRNWDcchJrX/frBxgTw6JN9ZnuLDe6C2TOiA9IgZqPI9YL6Ltwm0S2wMK
 6o+LQuJJe7zNC9moYFGPJ+/9ZZV42WI/Mk8dYsEWII09cNyhfthG835Njav93rfjp8pO
 IWVfpkW8Ntc9bQF3aInkor8qktzojB5TF9JxwwkcR70K/lee6gMBK0kSQtcg6Yid5ypB
 B1XgupmWO8Vag4AlF1+dRa231hL0CCKGptkhQCOVutcQRlqcIG4o8eeGXOmbWJDWPzyu
 gvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186253; x=1702791053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfIKInxQq2wvOkxbrwSjlmQGvbAZsun233FD9vE4bKI=;
 b=LYDgVmlMCYI26tsonCL+EKbe9KfAH8+mHDCs+KqEC82tH70hmj//ISWuuIddNU+AiE
 E7R9MNEbbsTganVPbocxtFr58UsgizbNOuc1HKf+iXlRSS259qgT/b1XYTgM+1s7gE02
 6TODnQq5InZ/Hd8Y9jVdAe6FHsGBOqV8x6L6zaPr6rKJr+Mdg2GMQ+lHx7MiT8MqZcXN
 ch47FfXL6BPIFI78XTz3bPf5QszKi6Y+wBrYCJu3tzW2Md+h1mT9wTW46vsz5yc1mjca
 ix7g3EyZBAOh5WJmVlPtH6pkk/TTNSE/oGFsA+XxqA4t+SlWGXvoeFjYaVvZVYREzE9A
 px9g==
X-Gm-Message-State: AOJu0YzrqYIOeAKne3o67AoZSgSHWieo0n5jmJxA+PrCgRAnDKhDLKPX
 M7H5vCnras2HvypRh3B5ce2x22iAW6or8D4p3ySEag==
X-Google-Smtp-Source: AGHT+IHMFTfaonpUL+cNo4RdGz24m/TNrKtPmRG3puf9wM/Fuu6oIzLP/ZFHvl/Pfwjo7lHdPhBJPA==
X-Received: by 2002:a05:6e02:20e5:b0:35d:6b64:77f9 with SMTP id
 q5-20020a056e0220e500b0035d6b6477f9mr5308817ilv.24.1702186252839; 
 Sat, 09 Dec 2023 21:30:52 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 w24-20020a1709029a9800b001d316770044sm96282plp.56.2023.12.09.21.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:52 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:50 +0900
Subject: [PATCH v8 12/19] virtio-net: Always set populate_hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-12-9553ee714d38@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::12c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12c.google.com
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
2.43.0


