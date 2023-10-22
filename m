Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F107D20BD
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 04:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quO19-0005qg-JJ; Sat, 21 Oct 2023 22:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quO17-0005qT-RJ
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:16:37 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quO16-0003Lq-8d
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:16:37 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1571815b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 19:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697940995; x=1698545795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVUu4fV2FeT020iiPRfyLwwvjP1I3THSzWwFIxv3oK8=;
 b=epZf+ITiFShLY0lLcDfEVFRT+koquq3fELlxohqTDx99Mhm81NpKRr10b1pgkwHxjI
 hNDLhHsn/ufQvQxWotkNAO/Zf5St4T/1Yb0Ck1jA5egAN354OG8ikggI580fWcWT3ceK
 iq7i980EIR0jAYWOjNQkwqPF8o8pTRanpAZKyMsVeMXlmv1SAqELw9nd6DMLO+sNEJmQ
 mmueAKwzoXbgXDv6Dw1tjg/HukQ1mEDa++9oOsK007JnTv0KZ2EDTkoifWajFez+7bGz
 AhsX8ewHuxQd01yVZ4yTc8y4OcoveqcGYoeIgJ2/alquB1VXah6r+S1Tp49/HFKQFU3d
 +XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697940995; x=1698545795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVUu4fV2FeT020iiPRfyLwwvjP1I3THSzWwFIxv3oK8=;
 b=sM7n37cM7C/KOZAW21HppOukwBZg2Nk1tUnGXejfXiptUtpjWzpTlxlUNFsxc6nME1
 p+43eEJ3m3fqri49TIqfPQAoE1A+DYgimf1puJtGGdGePzahdu9BCXb54V2eM34Jd95Q
 p454RMQowpI6sbrwu2dWb2F9maOsv8+p085un03nnxzXbXGjX12Q7w1HvcAg3omnqQMd
 RNOQyqv5U88jEO9u9h9+sQMVmaE+aaDdzfpk6ArwIG2uE/rlDNFfLvmZ4kfGkxysb9SV
 6PHMzFYRf5IfruZIl8+8I4R3BN80N99gBAiBYBCaZk4EHF1grISy3+rR7V5ipF72GxZl
 ipSA==
X-Gm-Message-State: AOJu0Yws93r9ZcGGMpxVvEgun93bscu67J9uUggqWXVyMv9D/svOQJL+
 ac/CH3+JfdbhSBl2xsL2tDI=
X-Google-Smtp-Source: AGHT+IGlr1j1KZQvQrWDOSbJPPe5vneodmqun8AvBiVrYzigK0tpX9p1Wsi2Pqk7o1llMtAcB1a2Tg==
X-Received: by 2002:aa7:900b:0:b0:692:6417:728a with SMTP id
 m11-20020aa7900b000000b006926417728amr11184198pfo.14.1697940994479; 
 Sat, 21 Oct 2023 19:16:34 -0700 (PDT)
Received: from localhost ([124.64.17.222]) by smtp.gmail.com with ESMTPSA id
 bs1-20020a632801000000b005b0b7ede830sm3672410pgb.50.2023.10.21.19.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 19:16:34 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 3/3] vdpa: Allow VIRTIO_NET_F_RSS in SVQ
Date: Sun, 22 Oct 2023 10:16:17 +0800
Message-Id: <4ee7f3f339469f41626ca2c3ac7b1c574ebce901.1697904740.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697904740.git.yin31149@gmail.com>
References: <cover.1697904740.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Enable SVQ with VIRTIO_NET_F_RSS feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v4: no code changes

v3: https://lore.kernel.org/all/2d2a378291bfac4144a0c0c473cf80415bb580b3.1693299194.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 5de01aa851..66133408d5 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -122,6 +122,7 @@ static const uint64_t vdpa_svq_device_features =
     /* VHOST_F_LOG_ALL is exposed by SVQ */
     BIT_ULL(VHOST_F_LOG_ALL) |
     BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
+    BIT_ULL(VIRTIO_NET_F_RSS) |
     BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
     BIT_ULL(VIRTIO_NET_F_STANDBY) |
     BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
-- 
2.25.1


