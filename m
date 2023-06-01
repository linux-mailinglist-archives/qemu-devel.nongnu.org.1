Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E0B719ECC
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:50:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4igX-0006S0-Mi; Thu, 01 Jun 2023 09:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igU-0006AZ-0c
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:46 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igS-0000Ui-7q
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:45 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-52c30fa5271so320593a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685627383; x=1688219383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeSLdi9yuZuMrDKTknXLipIRbAeJX5rbyOelk6PqFnI=;
 b=Le19K3YXveHDhvYLM5OLu4tBZLfyNvW22J5+Cv+dCTRafiRJqycB6KQMN6KooyK8oX
 54pYVCnfxrQkUmAMUbIrMMJ0jacOpzlzQmrvIdgYzx3BrXb3knIa2N0OioB/WfuzUPbL
 cccOQlTGo0+zAiARdFKw0I4NF7x3uNWkUYEX7JihOoVH295x5xlR2jSyYaY7Wv0FZ5CQ
 whIU25/d+JNbLc66zxDAYDwM6P+sh5n/fcaaCDCdHCmD5qoatMbPNhHNwtWUrQjS+e/j
 ZtiebMmFSTsFz0DKqAcq0RwAUbXoawc7lKnB5y6kWgapbjwzY1/WDWkPldlT0fZgT4VB
 jK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627383; x=1688219383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xeSLdi9yuZuMrDKTknXLipIRbAeJX5rbyOelk6PqFnI=;
 b=kjc9o0gby4GTc3l12hB5yfFlaj9rLEAygQ0J3tnYsp01rAiDOQWGcasQe7G7i3MLBS
 Le/bJ9JLiUwyAFXYAN2y5Iz0KIMKH0wNZuTkhfv63Lis5TvFgDJwj5+y+rWSYb3zhXHC
 yasxrz91V4gu7qnFKd+3JXb2TINnf7F/C5Rhf8dIUZmQcQm2ZznhcylNPbSOszrCh/R+
 lF3iVcl61gPQcN0F1h2ZVTwkX2dlVx55fetz9yKy5UCokaTBTR0S5K9Ce14dFh3pFRkZ
 nu03VuTiOuAEjyncUSefgssAnoop8cqQZ4xVf+4v0AdqpLixzwtdwXXtNzHXVFPVy3dO
 X2KQ==
X-Gm-Message-State: AC+VfDxbse7CbT0sgnmIqd5urXtnQABy0AUyU++y4MY7Ue/GAUXEc0Em
 pvexaoq/StGu8XdGE9gRFcE=
X-Google-Smtp-Source: ACHHUZ4HDBoh3uYOf9a70J+NPy1leD2w8G6g3hYOWI4MxUT03kSVPmT2L5EyzL6HhgHtxeMpH9nijw==
X-Received: by 2002:a17:902:ce86:b0:1b0:3df7:5992 with SMTP id
 f6-20020a170902ce8600b001b03df75992mr6815382plg.32.1685627382671; 
 Thu, 01 Jun 2023 06:49:42 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 b1-20020a170902d50100b0019aaab3f9d7sm3521385plg.113.2023.06.01.06.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:49:42 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 3/6] hw/net/virtio-net: make some VirtIONet const
Date: Thu,  1 Jun 2023 21:48:22 +0800
Message-Id: <91f7437bab18dff4b1bb300c80f1367e492db7ca.1685623090.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685623090.git.yin31149@gmail.com>
References: <cover.1685623090.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x532.google.com
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

The VirtIONet structure is not modified in
virtio_net_supported_guest_offloads().
Therefore, make it const to allow this function to
accept const variables.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6df6b7329d..7b27dad6c4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
     return guest_offloads_mask & features;
 }
 
-static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
+static inline uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
-- 
2.25.1


