Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F5074BD1C
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 11:27:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI4Cg-0002R2-TJ; Sat, 08 Jul 2023 05:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qI4Cd-0002QV-P5
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 05:26:07 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qI4Cc-0001Ay-D4
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 05:26:07 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b89114266dso19472975ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688808364; x=1691400364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxeNtWgJRVe83GCQvocRBXCW9Y/2jczfQBIZF/TMV5Q=;
 b=S5TGBSjyVPL1dhFceufp+XqynCEQZf4gSlggFMoOGcEJMJTYBdBS7DJspEC6sF72oB
 mip9ZSKapug2azAVafBk5Ny61n1DhFslS1WLg+/5mM2nQvkWXV0l8FPUTGZHbNdxiQLH
 uG9WqodicxYrADFO34Fi2CCHQ52Nu3cESyTrZ5p7dgbNtwtLWaCBgrPShVf/GAnAarEZ
 IN+UaTSuq7FPe9XIKcdAHxnhhl/wnRIlRsha/oQBAQ5wx5c3O0Hm0Xxu1yq1Y6k2oDf/
 c1jShSz0CvadgKOQqtCtiK9IOzF7wYg0QTKL4fc9EVP/ReregVgOJSRUGxR6JHOZZhXS
 KBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688808364; x=1691400364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxeNtWgJRVe83GCQvocRBXCW9Y/2jczfQBIZF/TMV5Q=;
 b=UK/RuXZdlFt9HqMokYDrDs7y79FsxnGrbS6uhqnke3Mxs+uCkWRYHID+6ajjj515Kb
 /aOXeH8FF2NCvWb1b5u6zShIZii7mbgMRckwllzZ4g4vAJnPrSR1wdv7HqgtbKiTX1HD
 O2Rp5SgxD6702tA2JCZ8U5ZPXr4CO2OTpphskFJVGXFD3rWF5WKAtAO+pEHNK2cltHon
 43SD8IJ3hC/Y5QiDzuYvXZ9sizKTJWjBnUlrvw0hnSEXtVQUzYJM+qlR+6eVWy11VyD+
 Q3jssjSxAalaBsUY2WIZKI2MOfWLRxPbIdWbFqP1Y04qoJghsJcfk0wh6QXYV7dMypBt
 dArA==
X-Gm-Message-State: ABy/qLYQQi6Jvzmjc2AMh+2kKAypmpF1d96uaSO0TdQqxlIK/Vjkdo1n
 l57Ew66nhtc0zg/cLWftzi0=
X-Google-Smtp-Source: APBJJlH4sB+TNTFTAo+3UAD14T+eCct/TvtpGvx8Q52oY1se0j77Sz3z8e9TqU7vCmZ+ugbfwTk/mw==
X-Received: by 2002:a17:903:1208:b0:1b8:e41:f43f with SMTP id
 l8-20020a170903120800b001b80e41f43fmr9046205plh.27.1688808363572; 
 Sat, 08 Jul 2023 02:26:03 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 p8-20020a170902e74800b001b8a8154f3fsm4508908plf.270.2023.07.08.02.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jul 2023 02:26:03 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 2/2] vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ
Date: Sat,  8 Jul 2023 17:24:52 +0800
Message-Id: <15ecc49975f9b8d1316ed4296879564a18abf31e.1688797728.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688797728.git.yin31149@gmail.com>
References: <cover.1688797728.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x629.google.com
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

Enable SVQ with VIRTIO_NET_F_CTRL_RX_EXTRA feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9a1905fddd..1df82636c9 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -105,6 +105,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
-- 
2.25.1


