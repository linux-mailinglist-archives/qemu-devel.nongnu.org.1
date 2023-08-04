Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C602D76F995
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:34:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnRH-0004Iz-E8; Fri, 04 Aug 2023 01:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qRnQl-0003cb-Sj
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:32:56 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qRnQi-0003RE-CD
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:32:55 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bb9e6c2a90so14746925ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1691127036; x=1691731836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALIcxf6j8pNVpITSgEknPHvhepLbPSdSA4YsdvgTdqk=;
 b=5LL34cZlMYOG7PX5hYEsX88hVMaXwi3l4aknkO+cFFaTKK6PzFIUPVsqeEC0ePd14C
 mBtCdzxSqRm9dICPfjonvmJFNcsfstqKqOrzVGf7+i9eOEQQf9qUSRtND6VWOwTxZQbn
 MObuo+1WzWJh8WqM589j9mJby8NTABPyWB42brZpkFwrvuIUHdla/IWsua1RmeUNUfG6
 KYG5wQFPgUSMbDf+AgEK2VvWWoVO0e1f5S0wVzgcH9Epj7f+rjKthFmgh0/FIY7Yz74g
 7+US6UlywmmFl3zGK1+PPNKvf73G8rK6DHfvp/hdrX/votgOmU4aJLmo41AUiSaZPiS5
 u8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691127036; x=1691731836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALIcxf6j8pNVpITSgEknPHvhepLbPSdSA4YsdvgTdqk=;
 b=FKe/FB5zm6ol7jKAM2pGlF6Swz33if2z6hJpurmuSSegG5q1Oo1idUKc11zNfhREWc
 5LREZ9Sx69NAyAjnSliCxlCTuTZieUWD1O3cuFPv6l7VCPT36TZwEZTWnDKoMuWAdYY7
 CtAEXsFRkbewZrRBAGbhLMw4KSs+ddSmrdX6JhDxqvSgtrTQr87fcr4KMLsv92z0yfcv
 DC7/KyWmrMfhW9BmN3hC7atNqOgKFZMFkAGqYv1DVHVqHiDDR7UJlNE36snZtZeff1Vz
 +xX8lInGuzPvE7YW82VIJJ3YMNFisROX9PA8blayLVxUZefA9ONGIVzUl9Icu82cklgU
 e0iQ==
X-Gm-Message-State: AOJu0YwjO9WeBCidbWiVSMsjhNZcxuve2jm9LGqQr7aZHkYEeLjXqZ52
 EVSdEAmp8ILs1QudygQRxdqRPw==
X-Google-Smtp-Source: AGHT+IEvojtbjnWlQqOxczhmdpJID19wYJV4hQSo0aihn1ShjioMjNTwiIPHQdWD5QMnmeoWlG/9MQ==
X-Received: by 2002:a17:902:830b:b0:1b6:6b03:10cd with SMTP id
 bd11-20020a170902830b00b001b66b0310cdmr716161plb.67.1691127036147; 
 Thu, 03 Aug 2023 22:30:36 -0700 (PDT)
Received: from bogon.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a170902bd0700b001bc2831e1a8sm781183pls.80.2023.08.03.22.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 22:30:35 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH 1/2] vhost-user: fix lost reconnect
Date: Fri,  4 Aug 2023 13:29:47 +0800
Message-ID: <20230804052954.2918915-2-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804052954.2918915-1-fengli@smartx.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When the vhost-user is reconnecting to the backend, and if the vhost-user fails
at the get_features in vhost_dev_init(), then the reconnect will fail
and it will not be retriggered forever.

The reason is:
When the vhost-user fail at get_features, the vhost_dev_cleanup will be called
immediately.

vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct vhost_dev))'.

The reconnect path is:
vhost_user_blk_event
   vhost_user_async_close(.. vhost_user_blk_disconnect ..)
     qemu_chr_fe_set_handlers <----- clear the notifier callback
       schedule vhost_user_async_close_bh

The vhost->vdev is null, so the vhost_user_blk_disconnect will not be
called, then the event fd callback will not be reinstalled.

With this patch, the vhost_user_blk_disconnect will call the
vhost_dev_cleanup() again, it's safe.

All vhost-user devices have this issue, including vhost-user-blk/scsi.

Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/virtio/vhost-user.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..697b403fe2 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2648,16 +2648,8 @@ typedef struct {
 static void vhost_user_async_close_bh(void *opaque)
 {
     VhostAsyncCallback *data = opaque;
-    struct vhost_dev *vhost = data->vhost;
 
-    /*
-     * If the vhost_dev has been cleared in the meantime there is
-     * nothing left to do as some other path has completed the
-     * cleanup.
-     */
-    if (vhost->vdev) {
-        data->cb(data->dev);
-    }
+    data->cb(data->dev);
 
     g_free(data);
 }
-- 
2.41.0


