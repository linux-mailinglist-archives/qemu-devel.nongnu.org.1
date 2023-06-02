Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 321277200EC
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53KZ-00087i-Lo; Fri, 02 Jun 2023 07:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53KY-00085O-5L
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53KW-0007Et-IP
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:29 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b04782fe07so10669195ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685706747; x=1688298747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tfdwdo9EGbsNiJTfLy+KhuY6lhHyln8G6IJjnc2Afnw=;
 b=cWfXOQU2YhIGZsMj82/COrOTmeBBd6U6GlyzADl8OUu7PZqtF7NrIpQnPd1LLZTd+q
 k2ZVVaKoN8n4GtVzqy0/UIzCB+qUI9yE0NkD700SJH3taVyUuhk2lgIfMdxxCGeH654X
 6rdoVFjB9nFufcNBR+dxWgr6U2mLULwz+xNtjr2s/5lv3ocTLMCyYiZxsY1t9bJ6VBUf
 B2gKtjH/uAlbWg7MbCxlW5EapL/IpBnOoy8YTQwA5JhQaaDoBpgt7ngDP9p61pttE72X
 5HpPS1h1NhKjuKu/B/k3Xu3z+USYebQKchXW7RZTeFXozX+8M5teOMbZXPxLVArsvXZG
 SPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685706747; x=1688298747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tfdwdo9EGbsNiJTfLy+KhuY6lhHyln8G6IJjnc2Afnw=;
 b=J5iZoKsPoF25AF+H3TC7gvVIvkrlz354R1nOeDvyLzjipPmSedHzejfHiK92qxT28k
 ris4Rfwdls+bFt/VLhtz08WxdFcQxZKe7Q+Qy6XboazDaG/CC1dbsR+xzfHTr9Vs/XaC
 wh6M9sD4TwXl23eGT/UMjRuzjqmQJkPUV0nRd9cjhmGHS6fwNBYO1gaSybKcB05Uii4T
 KAEnKZaiZ/cDoq0Mf3CQ0U/Nf/2ECMN4092Qmcx9MdeLYTlmkQanjKtzN9bPRC1yxEn5
 tG7G0i/O5Puhsv2VFzPaux5YYix4bEJ4PZLc4vUwckcs/A/U9q6bv0nA7jo6/pPkvOND
 sJ1w==
X-Gm-Message-State: AC+VfDznofFOwFe9c9J972FzrUDuxHIUuiz44rbMm8qMQ8RrAjQAEKzL
 H9MWl/w9c0rEDL/BRxa6zBI=
X-Google-Smtp-Source: ACHHUZ4HRSpWSlwD9a3iktO23cNwRfTQD0RhdhkKT7hmDRNv6e0jXpfRDDHkOUjAxTcj0FVzxcGwZg==
X-Received: by 2002:a17:902:d894:b0:1ab:eee:c5d7 with SMTP id
 b20-20020a170902d89400b001ab0eeec5d7mr1181610plz.48.1685706746864; 
 Fri, 02 Jun 2023 04:52:26 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 ju11-20020a170903428b00b001a9b29b6759sm1181585plb.183.2023.06.02.04.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:52:26 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 1/6] include/hw/virtio: make some VirtIODevice const
Date: Fri,  2 Jun 2023 19:52:13 +0800
Message-Id: <16c0561b921310a32c240a4fb6e8cee3ffee16fe.1685704856.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685704856.git.yin31149@gmail.com>
References: <cover.1685704856.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62c.google.com
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

The VirtIODevice structure is not modified in
virtio_vdev_has_feature(). Therefore, make it const
to allow this function to accept const variables.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Reviewed-by: Eugenio Pérez Martin <eperezma@redhat.com>
---
 include/hw/virtio/virtio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index af86ed7249..0492d26900 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -402,7 +402,7 @@ static inline bool virtio_has_feature(uint64_t features, unsigned int fbit)
     return !!(features & (1ULL << fbit));
 }
 
-static inline bool virtio_vdev_has_feature(VirtIODevice *vdev,
+static inline bool virtio_vdev_has_feature(const VirtIODevice *vdev,
                                            unsigned int fbit)
 {
     return virtio_has_feature(vdev->guest_features, fbit);
-- 
2.25.1


