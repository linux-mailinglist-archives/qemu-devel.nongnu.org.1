Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 871EB725E59
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6s2x-0006zR-2S; Wed, 07 Jun 2023 08:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q6s2u-0006xw-UG
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:13:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q6s2t-00037g-Eo
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:13:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b0236ee816so4146965ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686140026; x=1688732026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQJmHy0KSk8y5Lwl9VPrZd1umjZ0oo+o3EskG53S5WA=;
 b=kN2TpeyD/kINn2laFiG+cKLjidurTySQS61WIb2d/4P+8EdMEV8YAKRFIIKyc3AJl8
 4dPbLwEcPTpQNOBHRZOcNDW3vle3nw47TrwUXoPVeYNrbRu3vhD/XshTrw0DDb4AHYx9
 KVjl4EQjj2dZqLcaCjWsrJh/+5tIZLQ3RD1HrqXVZCl2PqclnpBW1l5F4iPtlp6c2Rj5
 iyutgmxhJnjiyY5Zdg4R8qGvL2nYuQnl//uxYs8BGjQNY7a2MRLM4s7dLd/nsHw5h9Ay
 CNZ+xSr7eGM71yI7SPuF/WYwoiUH8UVqYhwvouEJxWs7HfuWxZaLYRALvYiSrffU2+OA
 Du7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686140026; x=1688732026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQJmHy0KSk8y5Lwl9VPrZd1umjZ0oo+o3EskG53S5WA=;
 b=DawSGuNM6gfa7URTkRM6TJ1QaNJnVtHYoy2+Ws+ZKkJFerCs5UBTBMZHtvoxObNne2
 HxxKtt0S0+NUaTwLTR/XOK3WD4NWxHCqP0LXbBcVGeIeI6Q/SLAuXYszIqd4vZIyXJfX
 xaTtARI8hbwIi6ukEjwRy5N1MlR3AxLQGLANJ5BRyUWzYjwVZC7zvQlDu5ONwtDyBZWd
 clBFRbf/2TGQIZLUSjuqP/zeXbDUmhnocbcACHNG/RmTg7VNgv9nlLE8x+axPMBECN78
 yY0AFMPSKq2rtmbAD0XMBDjE/Djq4kt7+FMKUZIBrxpiJyHiLFo0XJPwxSwVdIBnLJ9K
 PKmg==
X-Gm-Message-State: AC+VfDy7qJUcKO04JydR0XMxGR6HulYH165yz2d0Xqc5Vzfs+4pcw5FM
 zkpd4dTttkXU3gjqcpsN1pM=
X-Google-Smtp-Source: ACHHUZ5hDx8MtC0de9H6xpQLalqNZ+0o/qrDC/F+ammJoEcNTlQdTL2g59QDeuqfdWIDhBMnZBjwoQ==
X-Received: by 2002:a17:903:1209:b0:1ae:8fa:cd4c with SMTP id
 l9-20020a170903120900b001ae08facd4cmr16610055plh.7.1686140025695; 
 Wed, 07 Jun 2023 05:13:45 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 21-20020a170902c15500b001ae6b4b28adsm10308747plj.130.2023.06.07.05.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 05:13:45 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC 1/2] vdpa: delete duplicated VIRTIO_NET_F_RSS in
 vdpa_feature_bits
Date: Wed,  7 Jun 2023 20:12:17 +0800
Message-Id: <3b43907b66b7f9782eb59598055f9655e875e421.1686137925.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686137925.git.yin31149@gmail.com>
References: <cover.1686137925.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x635.google.com
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

This entry was duplicated on referenced commit. Removing it.

Fixes: 402378407dbd ("vhost-vdpa: multiqueue support")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 37cdc84562..d90c8e2796 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -69,7 +69,6 @@ const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_CTRL_RX_EXTRA,
     VIRTIO_NET_F_CTRL_VLAN,
     VIRTIO_NET_F_CTRL_MAC_ADDR,
-    VIRTIO_NET_F_RSS,
     VIRTIO_NET_F_MQ,
     VIRTIO_NET_F_CTRL_VQ,
     VIRTIO_F_IOMMU_PLATFORM,
-- 
2.25.1


