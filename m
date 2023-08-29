Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882AE78C0C5
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qauOy-0008L2-U8; Tue, 29 Aug 2023 04:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qauOt-0008Kb-83
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:48:40 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qauOq-0007n0-Kg
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:48:38 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-26d4e1ba2dbso2289418a91.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693298915; x=1693903715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtTvXcgjRorRBn8kaBMTkcM6K2Ovcp/xG38XsSvb3SE=;
 b=lspylYwTvP8kcQQ0oiQQan47AuH/YXSgekWDHXh8BmqqIUUdBhij2Z1DYli1g+U3+F
 Nz0WbzXLFvxv3wYvs39BiUiK6zqSfBOhrwVjPP9iZzKLvoITB3tzWLV7Noymd1sJZ/dS
 5jDvm3lUhWncPYL2eDFHbgZiTKbbKVx+K6vRJYVw0zpv+jdaoRT4yihnKdC2w1VXFFtb
 X8adnFsbr3GUvqLa6qOYFcbwu4Lmz7DKv7KL6UBENbiMEpJEzbxUtDf8t4fZM+rz79Bc
 EBxFCqAY2PiQeXN7/JD2H35uU8DhKYm4JGIpqB4Hy7nIrx20tn1MwNqf0MxweZpSykT4
 JbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693298915; x=1693903715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtTvXcgjRorRBn8kaBMTkcM6K2Ovcp/xG38XsSvb3SE=;
 b=f4e59Sp7rinIarSW466RKi2M5k1tuDWgLj2gRhbypvDVK74xYkwrCI+eC5ywg00rMa
 niOmAmib/k64mpeTMCGLtSMcP/mMNTy171ZCyvXyJaK9WaiXcUJoIgzXgNN3ADvdh5V/
 M7qtIWcqmbXxP8vSMNKKa2hL5ePuNZr/MiMF+aa3ybcqpHXnwSuK2G8x1Kq2gcGeE4wp
 HqRwHpPZl0NFAJJpBixlhgCwk6oclqbnbdqsLrs6sLd149d3HHeVNn3+Bmjj4bLtOyLA
 BbVB5g+VW66Ux3sGM+Y070HyeqjcVM2fgmyd+0PUUd8ozQE3HWabF7JUhe1VL33E9Fvq
 3c0Q==
X-Gm-Message-State: AOJu0YwNqsKbun4TY5y1kvsK3CQEpeckQQ0+CmXvJ/5RVr0ozJm6tCq9
 NIBF60NDKPB0go/MXqTtCK8=
X-Google-Smtp-Source: AGHT+IFPrANE1dbUiFZ+ZTrAbNL7n/NOmmkAj+ffAA7pjFDcnngS3OTsuhrANl0LtNF+lhO3fwUBtw==
X-Received: by 2002:a17:90a:fd14:b0:26d:ae3:f6a7 with SMTP id
 cv20-20020a17090afd1400b0026d0ae3f6a7mr21530688pjb.21.1693298914942; 
 Tue, 29 Aug 2023 01:48:34 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 fz23-20020a17090b025700b0026b4decfe59sm8603881pjb.31.2023.08.29.01.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:48:34 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v2 2/2] vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ
Date: Tue, 29 Aug 2023 16:48:16 +0800
Message-Id: <a67d4abc2c8c5c7636addc729daa5432fa8193bd.1693297766.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693297766.git.yin31149@gmail.com>
References: <cover.1693297766.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102e.google.com
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

Enable SVQ with VIRTIO_NET_F_HASH_REPORT feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 139bb79468..b29f84f54c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -118,6 +118,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
     /* VHOST_F_LOG_ALL is exposed by SVQ */
     BIT_ULL(VHOST_F_LOG_ALL) |
+    BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
     BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
     BIT_ULL(VIRTIO_NET_F_STANDBY) |
     BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
-- 
2.25.1


