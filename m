Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD877200EA
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53Kl-0008LU-Pg; Fri, 02 Jun 2023 07:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53Kk-0008L9-EC
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:42 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53Ki-0007HE-TL
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-652328c18d5so814504b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 04:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685706759; x=1688298759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSlNPZFePKdQEbEASdUB2CHWXuLAoQ8iKDnQOm/+zKI=;
 b=V/aLzWX9C3sGodHjt03sHEQDYuEqp9b9/rALEjN9AldjvsKQsj3/fPtQxqdqPppk3r
 N6D2Hje2wGx9BtuPItvJvXlTsKYTYNOM7ZmiIeNImz/IH3QAezUNOTor7AN9s7vETZXk
 yhnqRH+13sjKiZIP6pXKNO0vRqveanN/ZuQTVBgZmk2wFK1GS8qj9mG5+KOqE1JVAvhe
 PnTzdfMrc48dUtX9j9dBeUMKUC50L1fTU+PxOXnLQTxAz9iNhie9SqTbjEm7tY42XqGN
 IHp6xnCWoWES6cNEKb5dNKNS1ubDfhuuFN5HRksphTAUVFFERrUZ2CmFj+/AoiHmYzv3
 p2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685706759; x=1688298759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSlNPZFePKdQEbEASdUB2CHWXuLAoQ8iKDnQOm/+zKI=;
 b=aLEzF0klcfeHwvu4oZEv5toAn4hWOscqzN04+nMk35a+uxcGe0nJConaQInvxxYtMi
 jyxr0cqnEMObsbxBUjhx17XlW9jjIs35IDU64Xus3veLtbwQ3fvnimPK6PBlj9Y3rCBS
 E4jQR/R+hVYibdlviyhKce6xGmqXoqPr6sGll+M9Vb83MXb33NSTZIAg/eMgio34hqgh
 iHoX2Xzv46p5dJFX8EWlpt+kZUxA8bLOKlTML3e8y7PwzG6TwyBScEuSvpCIJ1teMk3m
 A+aMYI1pKH8wUHVKx0YGi469WgI91/kvdEZh30FdhY5JcEBcFu6gyYEFpe2EsQ4YuIPn
 nvrg==
X-Gm-Message-State: AC+VfDzkKt4YskIj+U+6UpZa2QxT/slXvl6NxjfecivhnYQu3L6BbBs3
 MtxJEbvPajUpTGgYAJBidq4=
X-Google-Smtp-Source: ACHHUZ5SZQB3siTx5GSYGp3q6o7bdm5wiPddcQvhZIyvUXPQXi64GNNtLcc22zkCTdasUCvN8A0yCQ==
X-Received: by 2002:a05:6a20:9389:b0:10f:1d52:93c2 with SMTP id
 x9-20020a056a20938900b0010f1d5293c2mr9384958pzh.28.1685706759415; 
 Fri, 02 Jun 2023 04:52:39 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 l17-20020a170902f69100b001a96d295f15sm1155751plg.284.2023.06.02.04.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:52:39 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 6/6] vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
Date: Fri,  2 Jun 2023 19:52:18 +0800
Message-Id: <778d642ecae6deed8a218b0e6232e4d7bb96b439.1685704856.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685704856.git.yin31149@gmail.com>
References: <cover.1685704856.git.yin31149@gmail.com>
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

Enable SVQ with VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 1a295af51d..5a72204899 100644
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


