Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9696E7395B0
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 05:03:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCAae-0002UT-5G; Wed, 21 Jun 2023 23:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCAaS-0002Ty-5I
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 23:02:20 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCAaQ-00019q-NZ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 23:02:19 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-666e3b15370so3891302b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 20:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687402937; x=1689994937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBBdrT3dzjnyM/vOnuRuLp8V9vlx6F1I/QOopUv05pQ=;
 b=VrWPZLpz6LESkCUi6v34LuYCD00nK9y/HPw30a5zrVFdv3pQxkzKHDVR3u8L8PVOxL
 Xv1CFzk9i1cs4CnxH2B5rBr0MFOzZm5EowVeJQ/NTJBgSVP99vJ2AmWZ+LtZrWq9gFhr
 /JQLVOcmXRJJk2nskwat8joiSniwUc/V3vEeiiNB0TRVxl/xKGzV0Ko42UdkXFWT1Lmn
 30orjFW35Y5qaf1WhuWF2oPvl3OvMbkKWP7mK62W9s2hKylAnpgplFDpwxM13wI8V/3Q
 pXrVvwDpJZgXZRBcWf+d5ZDGdFwUar+hBp7oB8x8dkmLoaeHYkzbNb8dWYYVodb1nmgN
 QBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687402937; x=1689994937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBBdrT3dzjnyM/vOnuRuLp8V9vlx6F1I/QOopUv05pQ=;
 b=JlDfj24Ghm2rmeVcJzLlx1uBPXxqnB7JiFB2RJLqZutsHKX0vNtiT6o11DoDFUSxKh
 tiZ22HcORSjXarsysZbSG3vHI+T8a5nKkkuhBnrqPltpvPu/NsB32/7xJOC79szyJZ4g
 amQWc+4gHYJS66bJU6T8fXNLWlmUIl4S6bX4FtC4tM1Bbvgt+qcQI7lFK17wngdv87zW
 mGyTUpAFfTa2Tlmm03pPha32WD469iyd4awm4ntk6FYBIumA73LhXh2ZOqSQKAjZAEJ1
 30cgcnU2MbSyXCcVbs9CM0Y1Cp6oImAUr2I94RmdR/5Eni09iWVEvF6pEfe3ZRUAtQhx
 Cmtw==
X-Gm-Message-State: AC+VfDwXec/3xTso4OEQIM5yUzFREPHPNJI30AOcaSq5hbQkNMFI/aN+
 ZUSJ+AGMEpYOapfI7Cog9aA=
X-Google-Smtp-Source: ACHHUZ6Od9wV4TeX5peftH1CrYnPpfByfG5vYFxuRMIDV24WZOJeXPX+LUhYyYu2LcysWYXLDKjqeQ==
X-Received: by 2002:a05:6a20:734e:b0:10c:dd4f:faa7 with SMTP id
 v14-20020a056a20734e00b0010cdd4ffaa7mr17928622pzc.1.1687402937241; 
 Wed, 21 Jun 2023 20:02:17 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 y20-20020a1709027c9400b001a9bcedd598sm4161724pll.11.2023.06.21.20.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 20:02:16 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC 3/3] vdpa: Allow VIRTIO_NET_F_CTRL_RX in SVQ
Date: Thu, 22 Jun 2023 11:01:44 +0800
Message-Id: <32ae7e729449bde7a4252dd354e27d41f7ad1dac.1687402580.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687402580.git.yin31149@gmail.com>
References: <cover.1687402580.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x433.google.com
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

Enable SVQ with VIRTIO_NET_F_CTRL_RX feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 355a6aef15..ca800f97e2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -99,6 +99,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
-- 
2.25.1


