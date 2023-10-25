Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA547D5F50
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 03:03:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvSIH-0005Au-KX; Tue, 24 Oct 2023 21:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSIF-0005Ai-7s
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:02:43 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSID-0007Xb-J7
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:02:42 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3577ce73552so17754475ab.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698195760; x=1698800560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjDDGokUOw6r/LVFqprMKqogFb3FbKI48l2UTMka15Q=;
 b=Z1uK4rX6Y7jhgGgZFcONtsQAYGcMrtZHmDsV1AbSIlxQWRgiZvy/x2QlmVBaF5aeTL
 V7+c+/WyIwCN4+E+hMO/q6RWDlWxnUT3vexgrtLKvARHdRmT2U4BczbP66aoO2pmD0f5
 tr7njlZbDmSGvKAQBqEApfHtipIKftgss8+b5Vxbu7b8moHcNBIilD6yy1l4YSadmay1
 Vy6wz4Thpk//ajGvZZFbekqu0jbo7nGEFgCuvIMKcbFnF1sO4GViPX4KbD4OizUeNn+8
 FWoI6saIwfn04Dcaa7JnXlbfYVqKFtNqvYpgzIUwczkzHVWYTVuY3tREl+4cCiPeSwbu
 TiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698195760; x=1698800560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjDDGokUOw6r/LVFqprMKqogFb3FbKI48l2UTMka15Q=;
 b=eed38X/vG6l7OO6z+M8YDjSS3QkOKBAgLbOD1RGLzj0wfx4qSyNVNbakrR8SHdOsVG
 NQR3NQS7v8xOmrDKyl3AtmAdVCkh5rkmABF1WGnAH8TVkY1LwWqilBgpubeqXumhBW6k
 ogzjkhGCnpj6m+AdyE5YtvkyR7tJJl6mwJXjP4MrRDfreP9POgC31okCtrzw29kpn/1W
 kYtHda1tw/xkIygS+UQuw0m1iZMCVr6k8iCcrwcrCnndG3QKtVYfxXRo0f05FrsnK13a
 AqdqPjDo2Dw2JW/000oJb0/SrFzApajr7jeK79vJHbPsxUQwoJ0GU8djM9z4x0dCIPuq
 4Kmw==
X-Gm-Message-State: AOJu0Yx0aro16d5HHeuxGZFFSW8WzWCyAf/gkc/BUySqZHBIBMklA89h
 YM0cAz0tuj+IlrmiroTqzME=
X-Google-Smtp-Source: AGHT+IGR1rn3K4uDqRq63fkCjWKk1hdgF0JN4ffq60uM5nwGjrS6bgl/2SZXS5e0abzVQHMGyJ+eVQ==
X-Received: by 2002:a92:d2d2:0:b0:357:70f3:c431 with SMTP id
 w18-20020a92d2d2000000b0035770f3c431mr15361733ilg.9.1698195759888; 
 Tue, 24 Oct 2023 18:02:39 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 by2-20020a056a02058200b0058c1383fa8bsm6761233pgb.0.2023.10.24.18.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 18:02:39 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 2/2] vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ
Date: Wed, 25 Oct 2023 09:02:25 +0800
Message-Id: <d66b0aee501cdad7954231900c35a11cad1e13db.1698194366.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1698194366.git.yin31149@gmail.com>
References: <cover.1698194366.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=yin31149@gmail.com; helo=mail-il1-x134.google.com
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
v4:
  - no changes

v3: https://lore.kernel.org/all/c3b69f0a65600722c1e4d3aa14d53a71e8ffb888.1697902949.git.yin31149@gmail.com/
  - no code changes

v2: https://lore.kernel.org/all/a67d4abc2c8c5c7636addc729daa5432fa8193bd.1693297766.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e59d40b8ae..54f748d49d 100644
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


