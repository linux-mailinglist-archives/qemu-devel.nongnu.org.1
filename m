Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5B714A25
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 15:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3cli-0001kX-W7; Mon, 29 May 2023 09:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q3clg-0001kA-GR
 for qemu-devel@nongnu.org; Mon, 29 May 2023 09:18:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q3clf-0006RN-1D
 for qemu-devel@nongnu.org; Mon, 29 May 2023 09:18:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b04706c974so7053015ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685366313; x=1687958313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eIbonBk1byr7asSpTfTnd6xDf//hFIDNuN/1vOhpKCE=;
 b=j6bO6KXWuOjXl7rD8lX9CHqFAJ9Wf27AEbgnuY60gnDo17IMvvYIKn9KQYLfWlZ3mE
 Gk+mHph8QaLIhJf2Uyl3g0uB2ntM6jciosvOvQhC0xKpDTqZN4nQzbHVKCPj1pmIbEhJ
 9FSZYyaMk42heXx6ap10aceucjVubOVraZwKF77YoxyzEBa7Lre6AXq15oGFPicBK5eU
 eInmJI2PxLHxR3W4mBHAPKkHvTc8FFZA3WqcEgz6SZMrr7x/J1mxNjREIjT7tCzkCv/o
 SE8xtaFhzqbHcc5fPRhs7F9Hv1TG+R5CPy58OdaYvV5gz32a/Ra0T8+aqvoemWZ2+CeS
 FswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685366313; x=1687958313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIbonBk1byr7asSpTfTnd6xDf//hFIDNuN/1vOhpKCE=;
 b=K130oE9jaScMJ/ihrQkzefPwLp/oRh1DMyaS81BVdSsh3a6ZuvlwYsFJW1pFlzVCfJ
 xdpeLJNCCJTs0pzteTqnbVceGxhfNM3adTcmAVUDP1YVXKVyUkgZtF1lXnuqHpwhogVk
 eFZaufcNzGFw53MxVPXNpLW9NtRP6h1hEaHTlF4etKagqu/ishYp9OYXL9rId/DKh/GY
 +VEnGeDSA1EmQ9qbxD2cpV+SiLX9KcIhUPAAmYqOtoReSYmy811qGO+gIdQQ8NJ0e9Rj
 E+/CSTBMlwmgYPXyso31kuaNlY/sV4oADTMBPwelYONWh0/Rag3WTBj2uYP2v3JMC7cX
 dOgQ==
X-Gm-Message-State: AC+VfDxow0gEHza5x9ph5MT9ME0Iir2Fs1MMlva8TDlq7XZ/AXC3wTO+
 kjbhLjgJpVeRpd52tAtvAE0Y04+N8B2kXA==
X-Google-Smtp-Source: ACHHUZ5Bb0XvkQHEFJjI6beo/c8W/Y/kPuxK4CNHNML/ZJ0PHjP5ENkAPIRpk+copPMFWQaBNCPwcw==
X-Received: by 2002:a17:902:c94a:b0:1a0:7156:f8d1 with SMTP id
 i10-20020a170902c94a00b001a07156f8d1mr15634078pla.19.1685366313463; 
 Mon, 29 May 2023 06:18:33 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 h7-20020a170902680700b001a6dc4f4a8csm2533527plk.73.2023.05.29.06.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 06:18:33 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: eperezma@redhat.com,
	Jason Wang <jasowang@redhat.com>
Cc: yin31149@gmail.com,
	18801353760@163.com,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
Date: Mon, 29 May 2023 21:18:22 +0800
Message-Id: <77af042566b6f3fb10e3bd454962b52c3b60f12c.1685359572.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685359572.git.yin31149@gmail.com>
References: <cover.1685359572.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x631.google.com
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

Enable SVQ with VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 682c749b19..cc52b7f0ad 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -85,6 +85,7 @@ const int vdpa_feature_bits[] = {
 static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_CSUM) |
     BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) |
     BIT_ULL(VIRTIO_NET_F_MTU) |
     BIT_ULL(VIRTIO_NET_F_MAC) |
     BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |
-- 
2.25.1


