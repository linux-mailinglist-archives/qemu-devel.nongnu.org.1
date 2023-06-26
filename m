Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE72073DF53
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:35:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNQ-0006EU-MY; Mon, 26 Jun 2023 08:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLq-00030d-FV
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLn-00039b-M5
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEHVZ+NYDXJmtsy9/YWzgVDEZU+rV/o2cIqXz94Rhbo=;
 b=ARzNvfLiD2/gxh42hK1IA2Wzbj7z4GYQ/GKGWtsnoYIhlSMXMU1L1Hie9/zAwbfGTjHzph
 7VlUY3ECQzt9F9pgoo5yViRn1ubi0d2LS82fpDcezvVtruu48WK9t0Oxm4PEhLpxr2b9Fy
 ib1W5aZGfeq6DSLY0FOMz0qZTzfkwJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-n0wvxvcKOKmlxW0lfYLqrQ-1; Mon, 26 Jun 2023 08:29:44 -0400
X-MC-Unique: n0wvxvcKOKmlxW0lfYLqrQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7e4dc0fe5so19029085e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782582; x=1690374582;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IEHVZ+NYDXJmtsy9/YWzgVDEZU+rV/o2cIqXz94Rhbo=;
 b=JNEsPWf2kxYbQmOoX00c956FhzxhRQNS+FGGKr42pPQBR9xsLjmTJt13z7N7Ha3luJ
 VTbiaJgURuqSS9Zv6nXZyxMpuE2TIQFSlGOtCNxJ2Gg4iLjIAeqzz86yofxVkCNqLY8n
 K6N9cHbHvXk85/5oHAjTRe5ZMHEDbc/uE4uZOJqfK+lyNkplMO23fpXaE+iYjz0DUopu
 XX8jjfZmuppjSK/53YVHTLCnyFxykVk7UPgz5HYVmRcBDE/uKKAolhkikgOTR2czPVVg
 WvUXr+1fjlprBO2dOKEZ/My9veZmebd46yHKoSZkYyTNOpSZ2VX6b+vPK1y7IwZ7fYOn
 78FA==
X-Gm-Message-State: AC+VfDzw/j/Qm40fIq+Joi8r1wyCljJi64YcGrvM7HJ8rO9PBj95+dUM
 cgNhXd4BANsK/aD0eLeKqlk/cVD4/GYyGMnVATZmQkVjKQsS0UJUEbZrbsuSYEATQtdI/b+ZnLc
 KkCkvIC7Y+G1f8Y/SQBWAouooSqWww/Qi1UnkIO22lXBbubB8m0xKIdBga+hPmbhom+ya
X-Received: by 2002:a05:600c:2315:b0:3fb:407e:9b30 with SMTP id
 21-20020a05600c231500b003fb407e9b30mr515691wmo.13.1687782582561; 
 Mon, 26 Jun 2023 05:29:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KJk9k7ChLfoxdw4mnTg2rip3qIV6K4L/RapyQ+D5ZcGrz2O50mXs6zzsf2DsAUgEhDejyUw==
X-Received: by 2002:a05:600c:2315:b0:3fb:407e:9b30 with SMTP id
 21-20020a05600c231500b003fb407e9b30mr515679wmo.13.1687782582302; 
 Mon, 26 Jun 2023 05:29:42 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 c25-20020a7bc019000000b003f819faff24sm10511657wmb.40.2023.06.26.05.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:41 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= Martin <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 37/53] include/hw/virtio: make some VirtIODevice const
Message-ID: <11e802d37903bd7d2ee52cc2cb785326d603ff00.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hawkins Jiawei <yin31149@gmail.com>

The VirtIODevice structure is not modified in
virtio_vdev_has_feature(). Therefore, make it const
to allow this function to accept const variables.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Reviewed-by: Eugenio Pérez Martin <eperezma@redhat.com>
Message-Id: <16c0561b921310a32c240a4fb6e8cee3ffee16fe.1685704856.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


