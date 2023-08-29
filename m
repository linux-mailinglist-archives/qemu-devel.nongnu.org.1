Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1749F78C103
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 11:12:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaula-0000eG-D2; Tue, 29 Aug 2023 05:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qaulK-0000JV-Uv
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:11:55 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qaulA-0000WD-HJ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:11:47 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a9b41ffe11so2662202b6e.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693300298; x=1693905098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EdC04DKJRg0k0TroStlEZWBXnoc/i7QdqwqQNziTZT0=;
 b=iC6qYZEnSi+ojVW6gOk3Wow5cQB1qQ/BJUXcO3DPboksWeYDoZIyta64X67Rk192bF
 6GQDxjU1nTqhEco7E/OWptSqVgWr4oX6FcRsSmgSzA2H2V4gYh5aTU0It1QT53Vu/JW5
 ZCLW3V1mAm6ILhQZT+O1LA/AiUSAxvqhefqXdwZ7PeIKz6s8ULOJhJPSd0dmUk1Ix6ml
 ZWaQsAIyZA4rIqRVnUzyEQm8cpPx+SKlr2sktby/jkEVLTsPeaYJB+aBF26skbPCS82O
 Z7zWLIpBbduO5DHoX5W3mhd24PguYQXxm3UpVSHFEedfyoVTv3Fo/vGXwXBNZUdJ5dsx
 o0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693300298; x=1693905098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdC04DKJRg0k0TroStlEZWBXnoc/i7QdqwqQNziTZT0=;
 b=LmceJVjI+ZIkawE1AFqi02M+9gjtPxrID2uesmiTaTEHXYyP19PLdDntElQTw2o9oX
 f5B7tMFRLUOJ42Bk5tzpIUTo+KyVCmsStjkJ0ujZWcnWx1wJ001+WXtbxkkm6FV2YkfL
 6Dm6NADXvU7tUw674SgiolmAsCkwMWW1GhoqcPokvZibQ6lNMskqNuoV4eI680qqbA4g
 9i4oPMQf7dmOn7QfKsO9S3pZafVFpWVkiU4NOMcO9BT6A7zGmh/E6RQ6HBhj5tf6Fj9e
 VlM7Tu0ohr7U2WN1jvwOXXyCdHLT5O8bX8ec03+RzsLI7vzgN6eK/dyUc12UVK8zoh12
 nO3Q==
X-Gm-Message-State: AOJu0YwUOmrQ+mY4BUnbGwZhy4pDux4QI9yzPNODmEA8BEEQiPRqspQ2
 e1UPYyM5d51ZIdY6KG0GgEY=
X-Google-Smtp-Source: AGHT+IHCu7Lxlq5PU5yHR9cQQ7MImnIiopTkEgJpHYEh5VnvEr2MMbzgmfmyOqKFu3Xdd6imIGEt5w==
X-Received: by 2002:a05:6808:901:b0:3a1:e17a:b3fb with SMTP id
 w1-20020a056808090100b003a1e17ab3fbmr15557601oih.1.1693300298334; 
 Tue, 29 Aug 2023 02:11:38 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 x5-20020a62fb05000000b0068bff979c2csm7989156pfm.82.2023.08.29.02.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 02:11:37 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 3/3] vdpa: Allow VIRTIO_NET_F_RSS in SVQ
Date: Tue, 29 Aug 2023 17:11:17 +0800
Message-Id: <2d2a378291bfac4144a0c0c473cf80415bb580b3.1693299194.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693299194.git.yin31149@gmail.com>
References: <cover.1693299194.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=yin31149@gmail.com; helo=mail-oi1-x233.google.com
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
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 85547b7bbb..13da60aeda 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -119,6 +119,7 @@ static const uint64_t vdpa_svq_device_features =
     /* VHOST_F_LOG_ALL is exposed by SVQ */
     BIT_ULL(VHOST_F_LOG_ALL) |
     BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
+    BIT_ULL(VIRTIO_NET_F_RSS) |
     BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
     BIT_ULL(VIRTIO_NET_F_STANDBY) |
     BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
-- 
2.25.1


