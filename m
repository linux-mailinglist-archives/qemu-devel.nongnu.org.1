Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D5758F7E
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM1ur-00008q-Pe; Wed, 19 Jul 2023 03:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM1uh-00006E-2E
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:48:05 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM1uf-00029G-H2
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:47:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-668704a5b5bso6600485b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689752876; x=1692344876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4m+qFiL/6vxm0QTuj55sm23sigcWT4ob6LjjN0fg1I=;
 b=Kw+giX1P3zy1Mk7FD+zglYwSzNDMyAv5jYWF1goqshb+ZZVPXQDulVzPNP3mgiyv6U
 uhoOJFPUTFeL+7HFS45PMtLMzzi6UxgUNsUHT4gX89+8gK9r0IlIrSefNNw6Em8cKfBE
 7P7gyRYUyaOdhWol0ASbQlHrJzFVxTaX/YBO94BoUP8vodqSD4KGcyA2cuO+DstZOuum
 +xF0y9DYCdgTn32fgCrC04L9Nq9wGLdQTxBIby3GMb4Dw5QeeroIRTbYjiByfKa6WJwR
 JNbGAc/2+LQH9TrDtYeKWPu+mA1l0IeeqzdVf1/BFGLD8I8CpdIfUqyumDzSbZLnveB8
 mEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689752876; x=1692344876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4m+qFiL/6vxm0QTuj55sm23sigcWT4ob6LjjN0fg1I=;
 b=XYaDFPPdSiMuafY4dkFPFBFByOQ1vcXzq/MUunUxQASYrm+5tWbskK9RgVhkhXvQFv
 j16BiM0q7SnYffsIf5T3S7tt4diM0CSy4Jivv76EUzey6SqqEiCCwTF21aB5o8YRVjS6
 /DRxCQveyDYkhPiOf8LGCZgLd3ltrTQfJrO5OhKg9G0ZavBQsuBupAPfwhsyUSh6rtw0
 XR0OllqBSvYrzVjaOj0o9GQVfijKk/blrZ6N028qFauBbsv91F0jh2QDARoWtInmJFav
 S7nhfKLAicTZQkHBY7vOl6t3JKfCretcCthOUbstLlqS2S/+25ZiiwHPO7fDnU89k1Fl
 kH/g==
X-Gm-Message-State: ABy/qLYAFQB21eUbC1mNyQfj6/tYUfN7zo33lgI2cAUIjapXi312E65V
 /PeUJGzrQgZahO8LzWWVIoY=
X-Google-Smtp-Source: APBJJlELPexmWm8yl4cHI3cD84Ae0C+ksVyBFmVaKBane5eKqgFuwCjg2gJASdvlVUsCjCUJNDLOtg==
X-Received: by 2002:a05:6a00:ac7:b0:674:6dd4:8337 with SMTP id
 c7-20020a056a000ac700b006746dd48337mr22135800pfl.12.1689752875894; 
 Wed, 19 Jul 2023 00:47:55 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 p22-20020aa78616000000b0064389eab4c8sm2675143pfn.126.2023.07.19.00.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:47:55 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH 4/4] vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
Date: Wed, 19 Jul 2023 15:47:31 +0800
Message-Id: <abf658219d97ab9cec519a95c502998406db1c8e.1689690854.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689690854.git.yin31149@gmail.com>
References: <cover.1689690854.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42f.google.com
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

Enable SVQ with VIRTIO_NET_F_CTRL_VLAN feature.

Co-developed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0787dd933b..dfd271c456 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -111,6 +111,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
-- 
2.25.1


