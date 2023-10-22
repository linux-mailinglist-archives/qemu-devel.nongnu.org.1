Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 307597D20BB
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 04:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quNmE-0004wH-D1; Sat, 21 Oct 2023 22:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quNmB-0004w0-Rf
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:01:11 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quNmA-00005N-9l
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:01:11 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-581fb6f53fcso1333889eaf.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 19:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697940069; x=1698544869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Zkhc2NQAeeqYzXh/RsRR65qUOXQfq8E//Iu0JHwYnI=;
 b=aGSK8CRmllk+BqdnEMiiPdZWM1WYiCFBco1lSuKYCx1Jm17X9+KUtmPk/kF5dV46KU
 QwD7+OmICM92lVU/KV4thkjObcIO5yLbqgBCbgEPltHiPyFYWYq9eKAXXmTfzbX9wauW
 0idljUEYggs2C92dlGt/XnEwbGkmybtZLllZKCM4jOWzBQCZD9ETQ7qc3Il5SYdqMyCN
 KBhgsro8Rg8DUndk3P9Upwi1mzneAHxz2zATKqXgkclDiqql9cJSYPhsymZSRGv7gSoQ
 Cav514N7cNCxX4KjPyscnxtxz2g+QOUKxy9rz8Q4dZmixkYudaeSh44J/1QiOu7yLfmV
 K16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697940069; x=1698544869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Zkhc2NQAeeqYzXh/RsRR65qUOXQfq8E//Iu0JHwYnI=;
 b=i8kbZetbg+m8Fu/BuMSGxN+Fpk6QE4jabfqx3hts+v7PM87viJ4nZQiSJPa27Zc+/q
 7Gc2ZiW6qUMM994SBJyqPwx544Qd5ZdT5KF3bM3ES3z9WTTqFAyfQpElb8nHp1JRqHbp
 HPDgUXzRJhv2OOT+tKrFONsPRmwa6Fz8H6gaZsicklb0esT8W6mzMuLD/s+OLhRryiNJ
 lEDZmw38oFLVglTM9iuojp+sBReHVd8Me9aIJkXYVISwDvBUkZhza0n1muGg62HZ9M3+
 yrEI5NwsbIkvpHRxPu5zVloPtApL+8J6CiUImmx+xyZI0xODqC3MOuAuZkPglgVNuhfA
 QRfg==
X-Gm-Message-State: AOJu0YxJHLLEAS+p5u+XRYlQtJvuOVTyg6cp30hVZnwr8spUIV1PvzWq
 ZFHFiT6zkSgbRrmIdhNuiCM=
X-Google-Smtp-Source: AGHT+IE+WyWb8lPJABCuNLNANvRs0o/kGIUDwRD8vur3KpUnskZHhTUQkR8oNJEdSmS5fh9fic3B1g==
X-Received: by 2002:a05:6358:7f09:b0:143:91a2:8df1 with SMTP id
 p9-20020a0563587f0900b0014391a28df1mr6488487rwn.3.1697940068626; 
 Sat, 21 Oct 2023 19:01:08 -0700 (PDT)
Received: from localhost ([124.64.17.222]) by smtp.gmail.com with ESMTPSA id
 i13-20020a056a00004d00b0069344caf840sm3975537pfk.18.2023.10.21.19.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 19:01:08 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 2/2] vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ
Date: Sun, 22 Oct 2023 10:00:49 +0800
Message-Id: <c3b69f0a65600722c1e4d3aa14d53a71e8ffb888.1697902949.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697902949.git.yin31149@gmail.com>
References: <cover.1697902949.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=yin31149@gmail.com; helo=mail-oo1-xc2a.google.com
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
v3: no code changes

v2: https://lore.kernel.org/all/a67d4abc2c8c5c7636addc729daa5432fa8193bd.1693297766.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 2e4bad65b4..4c65c53fd2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -121,6 +121,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
     /* VHOST_F_LOG_ALL is exposed by SVQ */
     BIT_ULL(VHOST_F_LOG_ALL) |
+    BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
     BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
     BIT_ULL(VIRTIO_NET_F_STANDBY) |
     BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
-- 
2.25.1


