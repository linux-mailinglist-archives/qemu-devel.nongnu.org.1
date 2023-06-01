Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 811BB719EC9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4igR-0005UB-O3; Thu, 01 Jun 2023 09:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igO-0005L6-DF
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:40 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igM-0000Sd-BZ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:39 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b0201d9a9eso7467485ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685627377; x=1688219377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XG/vGXSzD1X2DKFaeuOHuABz/AWh01w+UQ5wuAYsDFc=;
 b=NwfySpvaemTfiCsw5Gdy9qGLRxOICE0Y9HXbAYBITAWotmJK6mQkliiVZhvyjVR2a3
 foGn0DvTwMHdBdn5/D0/+FyerQ9aXclRe2C2i0ifIoMRCrJNwvTXduF5Bh338SR8CUF9
 WC5fX1x6ReeOtivdghIcy8mbHuNSAv9geHc2FkIysbhU8P0Fv3HP/9JTjet199lH+8Fr
 FT4FYrj9mX4LcKCFbPu3dqQ/wNpst9anAYPXx4m9X8d9l+U9Dn3ct4ufhAw032YJonuq
 c81WgISkLfnwoEt0bamofhwsi7ikVpf4MD6m+hP5qEe/Yqx9FluR0d71uY0sNufYp3An
 XyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627377; x=1688219377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XG/vGXSzD1X2DKFaeuOHuABz/AWh01w+UQ5wuAYsDFc=;
 b=L5eh54FNKGcwHB/QAysDOZurk+94eaD5MrHITDFNUnuQYcIt2j8LZievLwzreOEgC0
 d1kwX2GSRwy9MfqMsXUxH8TP4/zXWAJc6+xhRO7H83/RPxCE5ybQ67raSJsXsVVYX4+p
 5sdSg79f4byQhXzcoXP4gj0UiPqvF87oyC/blyLgfd+kwrgwN3fnNXbT12ygYNs9/rO0
 Xg5KS8GKtEL1JCg6cvmb3U2hxXw4GmhUH6qFNPJgKbZCLqtHa1ManMHT8GunZFs3bIiL
 mzdy0+qKA/sW1YHzLMO89V9acvMY8erW9DW2efW1gbYEhR2PUittsN0FF0v+EolVqFYG
 3Q6A==
X-Gm-Message-State: AC+VfDzgr3hpGtYW9UU2fvlUs8HMP1e3FOf9KhPabH69e58U6QOExxgF
 5QjiKG7PKoqTDQd2GaeZpxA=
X-Google-Smtp-Source: ACHHUZ7+5a60tCBOL7Jy1fk5Ep6uBCd5d17RAI4Wbk96IyujyS6bykecfKDIitHff+7zCVmhtsWBbg==
X-Received: by 2002:a17:902:8341:b0:1a1:cb18:7f99 with SMTP id
 z1-20020a170902834100b001a1cb187f99mr1798298pln.30.1685627376509; 
 Thu, 01 Jun 2023 06:49:36 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 d5-20020a170902cec500b001ac912cac1asm3492402plg.175.2023.06.01.06.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:49:36 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 1/6] include/hw/virtio: make some VirtIODevice const
Date: Thu,  1 Jun 2023 21:48:20 +0800
Message-Id: <894aff17408eb129254cb7f8e5aec45502f4412d.1685623090.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685623090.git.yin31149@gmail.com>
References: <cover.1685623090.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62f.google.com
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


