Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD824719601
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dz5-0001wl-4P; Thu, 01 Jun 2023 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dz0-0001w6-Md
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:48:34 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dyz-0006F4-31
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:48:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b04706c974so4998355ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685609311; x=1688201311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XG/vGXSzD1X2DKFaeuOHuABz/AWh01w+UQ5wuAYsDFc=;
 b=VC9/fW6sc/V8UYBRccGkdo2wq/3jzaM/E/RrUDdIf7EpSClpNSHBYrXvpXMM2y6RX6
 3Ci2U8qKoeIZpsKViSqn0YPKg1GqLpwQXVPOrxZxAd+8nwJMf3OoHR+ym3rbiSLWhljG
 zYOuyCZ1vuKCMfvILBQfA4KHpdiDJWR3LUpGnvtnIL3seMC86esIwnuJZxYscjlPQx65
 5pB3Dyl0fPHlV1rW3bZi842WDBsci0cqN107TCr4NpazCFJ/cfwP7WLVy2HxbQ9oMBOv
 YGTvJwbErdUjEqN5HjLQB4kn3U2fq2nUoAY8kFgIRpu8IZVxJmSfTFqmxMpAFEQ91NJh
 rt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685609311; x=1688201311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XG/vGXSzD1X2DKFaeuOHuABz/AWh01w+UQ5wuAYsDFc=;
 b=P0DDJ83f0J292hM7lLNik9XH2Ceozpnh38R922SWp/ovX4hlFf0+ejPNM0DeLQcZgh
 jw3q0QIbwPzUJU6c9w9NBdA1AYBI84XUvlz65wHGOyB/036PmophRI68QFurf4GG1B19
 8sVVbukIyMS4tTKeVnqoPYNOrP3h6nFRBXzp+27LU5tsB8SAe4FpExm5F6Ajm7CoSZTy
 Gpu/sUbiIzpzSwJSPaELRFcodBO0iLHuqsvpf7MhrvemPN3kqUgLhNH3TlOlkVeQLUhN
 Ow4x+2pzmx+Jk4MJj1mj/lgMTEKeUywTz273NZvBtXiYzQ3fRbFe3ej9M3u9M9W2NNsa
 bhgQ==
X-Gm-Message-State: AC+VfDyxNIIuD1ElL0iozc7KkFfaVutxV13BqjDT1j3f/nHcOg+3iJ54
 5r1TFIVl+xcHt8HboV3VKYk=
X-Google-Smtp-Source: ACHHUZ48Wulsp0cKE6Q4Rl1n34wjHUCaQ2eb8l+xpUqERNXWzbdT29U0hehdL6AqF44M23ILwe9yXA==
X-Received: by 2002:a17:902:b10a:b0:1af:d812:d27 with SMTP id
 q10-20020a170902b10a00b001afd8120d27mr6775204plr.9.1685609311360; 
 Thu, 01 Jun 2023 01:48:31 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001a221d14179sm2824091plc.302.2023.06.01.01.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 01:48:30 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com
Subject: [PATCH v2 1/6] include/hw/virtio: make some VirtIODevice const
Date: Thu,  1 Jun 2023 16:48:15 +0800
Message-Id: <194d91a57682c661d3550a9d12006033adc8b803.1685584543.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685584543.git.yin31149@gmail.com>
References: <cover.1685584543.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x636.google.com
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


