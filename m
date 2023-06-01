Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5964E719600
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dzj-0002iR-FX; Thu, 01 Jun 2023 04:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dzW-0002Si-JH
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:49:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dzU-0006Im-Sq
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:49:06 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-650a9ba426fso214075b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685609342; x=1688201342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njzkDyjtwOWFxOUUDhj3QrAL+aWZx2wnp3b8e3dX67o=;
 b=FNICpp+q5w25/yegSycQ90SYITNYvLVxuPQf9/KttmMawIHoYFQdRTVTKcVzxkSrgR
 KZIIei0dV01G765T5MKTXrcaZXmM/Wj9omrsQ9t1tuN7ZaGWo5u5Tt/FKGnI1e/bTlNV
 nta0cHIjHcMqljZGaXWDbHcGHSD/282t20eCsP2dNolxhLkXtB4vuXhs1SnFoCoUFyCU
 hTtDoGZ0+XWXLgXR6Mu+TeGhaC2k3XZu5QVnOqLm1g9i/Z51ZOswJ972e7aU6NH8KUH1
 XDSN/cAuCzy6GYHDLQReh6Yn8m8nrSltanFYDN3JZtBbaPvElpQ2I4haiC+wEwr/TAgk
 Cmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685609342; x=1688201342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njzkDyjtwOWFxOUUDhj3QrAL+aWZx2wnp3b8e3dX67o=;
 b=huYQ5ZkpeQjnYCLe4NFTrO851iHNgScaBlHqY8JaKopM+Wl2LvsyVQjfpzXFZ16pgH
 MCA2a+1XWclmY/dCixTHWq8xqPFTKpYmlKDoUUOSjy9LJ+QBAsJA81fqwfRM3275Z50Y
 8+cQj+gjE6L6qlYgvecvgv8Cf1ZpBS06P6MYx/T5HzTtEyM5b2fpK4hQ7PWUYusd/ldG
 Wa7N/QLDrBaT8oAsFnJ+gtS89IruGvNNhLf7AscDg8LYapXGsUTdRiGoGwAChF9n2iuh
 Cc0cYxK7MKnMtUYPPtLwmuVWlhIaZ0I9SPV3LSp9y7J3L2fBQP8yaGIR2OFTaxqamwED
 8VGQ==
X-Gm-Message-State: AC+VfDxlBl6uRWcDdS7gKldd1htJ2CQlfHP08hpbnvYvrnOTHiOI655D
 OmptPumykqEOI3D79BDepyL69/5FfM4SxAHZwI4=
X-Google-Smtp-Source: ACHHUZ4EnTJUSyBwlmBNUMgHM2FYZV7l2fiIfr2tx7GGyXBYjgMGLGn1iOQf/EFiQhhscmkiUvxl1g==
X-Received: by 2002:a05:6a20:a1a0:b0:103:ef39:a829 with SMTP id
 r32-20020a056a20a1a000b00103ef39a829mr6930646pzk.26.1685609342257; 
 Thu, 01 Jun 2023 01:49:02 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 u10-20020a17090341ca00b001a2104d706fsm2846418ple.225.2023.06.01.01.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 01:49:01 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com
Subject: [PATCH v2 6/6] vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
Date: Thu,  1 Jun 2023 16:48:20 +0800
Message-Id: <2b88df2f2daedbec4541841d64ef528065adff0d.1685584543.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685584543.git.yin31149@gmail.com>
References: <cover.1685584543.git.yin31149@gmail.com>
MIME-Version: 1.0
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

Enable SVQ with VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0e647886d1..4cc24a2997 100644
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


