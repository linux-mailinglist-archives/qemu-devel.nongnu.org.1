Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2B719603
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dzL-00027I-Ac; Thu, 01 Jun 2023 04:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dzE-00024T-L3
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:48:52 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dzC-0006HM-W4
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:48:48 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-39a55e5cfc0so463483b6e.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685609325; x=1688201325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeSLdi9yuZuMrDKTknXLipIRbAeJX5rbyOelk6PqFnI=;
 b=XWOrALI3R6C1a2Y9H8JTtP5naJ0BpcPp/LnylSFYjKtHaAgCTP9ud0WKU6CY1SLWaW
 9ueTc3MocRdNp7X0AdFd6+Sg7/N/NIi78QR1pO6+/NgAi6pMKhVVoLZ9NfQmZpw/WO+p
 4kFUefiUQoLlXGIUsoyTo4Ji92VZQCDoEpYW7K2x0M7MGwDkKJfLDihvR7JHNNqwCW2j
 rQ5vLSVRy/zrAQylZPIXWVWVKXQiA7zToMq0ys4ZlIdyC0Of0EHiolKTOztogOYgkFX2
 chegX/c5cUffpQmUMgkZwmNqcqqesg+h96lfqprzzKzoTekhduzChd8O/k1/29BuBfkO
 r6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685609325; x=1688201325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xeSLdi9yuZuMrDKTknXLipIRbAeJX5rbyOelk6PqFnI=;
 b=dQ9GXEN8R52/RLu4+bzUceVzK43y6JXGmNgwi9PCGsQ7DL+vNKPK7+5bW3u8PTUXSD
 1v1ne2+9Cd3d3eAZZyHEItEHfPjnN5aA11qhXkZKcV7ieDU6l2RUG2TTCzZdsU4D3ooI
 7UNhbzVC7nUYrvjluk4Pn0aqy/LZGpHygW8tHXmvGxNR09zNnJ9FEPMXiEepC7y6S+YY
 P5ALpsgzsUFcJBsV+XMGr/MZ4H5IkcN1DDZibyM4RmGOo79UWhNfe32ySIu1UCnWc5ae
 yTPT5dlabglDMhxxL7LFtS4yzNNKLUf9B4cJYgql9AcracT8yucSsxT1vx9G33PRZNe6
 tqww==
X-Gm-Message-State: AC+VfDwfGP02HfrsENLpiRe21kuQeWS6V+BAMn5CFA3U+49tqU93CG9R
 8W4Ij/LDjZgS/MmsBTndBhU=
X-Google-Smtp-Source: ACHHUZ6lya269BlkEHUmJI42qAKkOVzuHlaYjYo0dSWaQEusKeG6r5EReG3xhZzRzRGi3+Upgj2bOA==
X-Received: by 2002:a05:6808:1792:b0:38d:ed6f:536 with SMTP id
 bg18-20020a056808179200b0038ded6f0536mr8230521oib.42.1685609325374; 
 Thu, 01 Jun 2023 01:48:45 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 23-20020aa79157000000b0063799398eaesm4613494pfi.51.2023.06.01.01.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 01:48:45 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com
Subject: [PATCH v2 3/6] hw/net/virtio-net: make some VirtIONet const
Date: Thu,  1 Jun 2023 16:48:17 +0800
Message-Id: <edd5a9e395c5f2fb0b7c8c15637459de8e35d6e8.1685584543.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685584543.git.yin31149@gmail.com>
References: <cover.1685584543.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=yin31149@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The VirtIONet structure is not modified in
virtio_net_supported_guest_offloads().
Therefore, make it const to allow this function to
accept const variables.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6df6b7329d..7b27dad6c4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
     return guest_offloads_mask & features;
 }
 
-static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
+static inline uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
-- 
2.25.1


