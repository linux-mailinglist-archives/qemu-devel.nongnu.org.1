Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC6677A647
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 14:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qV9nP-0002e1-VQ; Sun, 13 Aug 2023 08:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qV9nN-0002bU-9Y
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 08:02:09 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qV9nL-0007zj-7H
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 08:02:09 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686f94328a4so2324743b3a.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691928126; x=1692532926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWlbRiQXU9gddI5oKN/IiHFJnr/wffsiljRPll1sFTc=;
 b=aeqyZBSWtgvPoEcsKT0IGn3rfWqaShmKLYTOEqyyk8G9T2GfJCeNWYrXiZUK7Tx0XS
 J1KyaCoG5QrgEp4ZlmU7V+96glQoB2nmlOtEjYeZ/SA+Ek0q/rjlffYIKJq6JPFK06/9
 Vu8yTSmNvFhfUQTID4PxstwROn0JtMboPlz+GdE7L8NJAVF4bCxHyy2KKsewgJQ5hVmm
 fjOWfH2lfB2NmWGNawJyzKYFHPiVaVAsxoEpgWnKYN6wRwC97bsLD2DIHwKD5CfoRP8F
 /sjYMGyDANQtfHHSMmNWnMSx14KNYQL4Ndtz3xkjSpPfA7y1c+wbGEUHJiqjC91LlZvY
 AKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691928126; x=1692532926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWlbRiQXU9gddI5oKN/IiHFJnr/wffsiljRPll1sFTc=;
 b=Oz/OD0WE4pVuo1EFTjqOTktaBRApmeubROXrzLBE1sRJr9WOgDBcNoyKe1pg0vaegR
 8/mo1NL0hCo9rw9zjomRXTE4fkIckbQB9t3DSyVH+jlyaaGhYZCVyxA2hCKxdtQiAhYN
 0cfEgz+R1PqIx+1rOle9tIQy6DSBrsxRVctIZes8G5m8LHwKl7QK0H7dihkqzL7JFkr2
 4Y/dCRh9rU5j4LVWELCLt70Ye68kSqiYBcpVmqI3Z+QjKzWEUG8PJMB7OMS087Jnp2IL
 K+RkQHDyEbgPDOqjPn7HDUIEtp9RM6C/86IRDJVHAzj7f6hhuMb1ucvVxZkJOqccwXeE
 /eaw==
X-Gm-Message-State: AOJu0YyBUvockrzUWieWz7NTZjIoZGnEjSuGtwi3wXE6cWLl//OW1/Zi
 WTSeDbQgI24vknzRa5o2Kvf099Lpd2I+sgWF
X-Google-Smtp-Source: AGHT+IF+LppDmvtucCarc0RYx4rwrJ0qrEGmy1EQRHVxqqUwOMnHdW+tgDD3wfbkkWjYnEJL074o5w==
X-Received: by 2002:a05:6a20:4426:b0:12e:44:a1a6 with SMTP id
 ce38-20020a056a20442600b0012e0044a1a6mr8809235pzb.11.1691928125630; 
 Sun, 13 Aug 2023 05:02:05 -0700 (PDT)
Received: from localhost ([125.35.86.198]) by smtp.gmail.com with ESMTPSA id
 v16-20020a62a510000000b0068285a7f107sm6309667pfm.177.2023.08.13.05.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 05:02:05 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [RFC PATCH v2 3/3] vdpa: Allow VIRTIO_NET_F_RSS in SVQ
Date: Sun, 13 Aug 2023 20:01:54 +0800
Message-Id: <f46fb929582cef326282a42237589efb85a7124b.1691926415.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691926415.git.yin31149@gmail.com>
References: <cover.1691926415.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x435.google.com
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
index e21b3ac67a..2a276ef528 100644
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


