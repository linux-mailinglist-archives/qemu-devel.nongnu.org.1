Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDEB7CB99C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbPd-0007hk-T9; Tue, 17 Oct 2023 00:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPb-0007hS-PT
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:31 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPa-0004VC-BJ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:31 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b9e478e122so3643904a34.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515829; x=1698120629;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofnl2rSm4r49GjzkzKanf5elg8fbXPmivnVlSUNWXyE=;
 b=qPcyeEL3FdSutqyrgVTB8K+zRbd0kBrB0JovDPMh9L1r/3EAqlO01Na6CvxY+jLRPj
 SZjFbmz7PQTl1C1IR6m2+1nbdNtxCqTfhaDEEfQunLSOvVwsZzpMMFqaYNMn8zcfxl9Q
 EzvCsyb/LFS5Ie7R+pweSbbdEwL3IrM/YDO6J0Vq13KfUGdjazkpwm6KlRi23bUqCCsQ
 HdoUOC+T5O/OOBE5jWt/krQl+7dWsrc9XuemX9bAoHG+/ujwzdM4gKazNoD9yiFy+onY
 lVEZYwdaG2rze13kONh3oH71AlsmJpQbkzX4r1Lw5dEZRfXrDZpAUMDy3LJyk5F4kIK2
 Ml3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515829; x=1698120629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ofnl2rSm4r49GjzkzKanf5elg8fbXPmivnVlSUNWXyE=;
 b=YxTYYiVMUTdAS2Yl3iXKF5AkTb9R5s1P8EQfHLpX6CbXXDI0CPO5z+OPHIeZRM15N8
 Zdi8Z6zHSDooM9cuYTLy3cfNYfRbADDJx7o/fvkwNN0+bJ3tcHHxARkWVYDzzBezlKJa
 VdICigGF0vnqjbk39PgSUpJiL2OFqkeAfD0ilZUwNU/hh1MZA6KWEFF5X9xEpOv6xj4T
 g7NxdeFKPv9ZLF8Ob0iiteb1/Ve7VdqN5KHD7WVnM7z0SuYHAetzfw0+Zrr3quOo7n/J
 tWr1/qFnjVGctV/reerKh/kcqfR+rGYhMDKoEzaRJXCWCfD+bO/pWZmJFNt18x9J117N
 FbxQ==
X-Gm-Message-State: AOJu0YyyQBHK58yXwAfZVBdnmo1shCXR3Q8MUltkrz4st5kpcJ3Oipsk
 zuWBkFFAZG44/i6UmZuH4PJtpsUJPm1pfbxM5GaTCQ==
X-Google-Smtp-Source: AGHT+IET5sRIh5lbhlBxd9z0T5Ipwe3i0Fnehjpt3u74OR/iW/2PV4g2bo6W4j93EI2RNtGLBI+6Kg==
X-Received: by 2002:a05:6830:1d4c:b0:6bd:c7c3:aabc with SMTP id
 p12-20020a0568301d4c00b006bdc7c3aabcmr1240467oth.19.1697515828902; 
 Mon, 16 Oct 2023 21:10:28 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 g5-20020aa79dc5000000b0069346777241sm362023pfq.97.2023.10.16.21.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 15/21] virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
Date: Tue, 17 Oct 2023 13:09:21 +0900
Message-ID: <20231017040932.62997-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x334.google.com
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

virtio-net can report hash values even if the peer does not have a
virtio-net header.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c6a92ba3db..dc2b7b8ee7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -763,8 +763,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
     }
 
     if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-- 
2.42.0


