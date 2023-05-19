Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82234709AAB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:57:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Sn-0004KI-3R; Fri, 19 May 2023 10:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01SO-0003va-KV
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01SN-0003gf-1x
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHVWE9pMIWQclfvDGF+QtPkpgYsCEq0QUnqNj9BA47s=;
 b=HkKFNnLRzJqTHeC3Irv1pJnUodsjPsrnFOrjNpaHTLg5xG3hb8zeGJ3vCpjDA4eoGfAMQH
 AT+P3d3ozdueyX5EeWbanPT4ykipWkKmBPyVbpU4+gq3FHfH8D0zJFbit//lxAAkDIcwhT
 VWPaUbwONM+cuWz6tXlCZHBOTU3UWGQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-4RVGdg4aMqa8FlGHYkru7A-1; Fri, 19 May 2023 10:51:45 -0400
X-MC-Unique: 4RVGdg4aMqa8FlGHYkru7A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f397572596so2010024e87.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507903; x=1687099903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHVWE9pMIWQclfvDGF+QtPkpgYsCEq0QUnqNj9BA47s=;
 b=cb4CBGpAFPrjwAzM46cM/8nlWpmLXLlRBkZ2XMVx/kcVtNSaiAv6+ykass6dlyYTIB
 iuqPoNHcfcuZ7mui+91xyXObA5rLElGQSxlG8dFyrw79Z1Dx221f3Vnc50GqZcf/OTNG
 OSb98A/kFawuBMZbIzuIcOOla64tB3PIF0rTkRzPWXmSNNw4tCgpAV78osLwZyCg66Y5
 UWZyM7YDpxp80QLFPpYMMo1JmTWBPjWLqEAHujHbgWgzENYTikyRUAYofwVM/9Ls2Yph
 IGp8NCsYtcgLoXsQdIqfpaiiVx0lH/wE3AlZMzw7VOmLTQrBlo+Hh3+EC62Tkw8cCGW4
 k6sw==
X-Gm-Message-State: AC+VfDwnr4joAXYuRkxqaWzPHznHCTGQ2uCddfOIMw0oTmrvNCxVtYsO
 rfoT+1mI3cwOPlFIUnyjdy23BToRuFpjZBv43QqUHgWoS5is+grzqjKi2sh6LnuOrb22BqgjeTg
 wPFuCW7paOvMdifFAgJqI5R85OOmXnW1TL6hw9EeBbqFhVY7L4A659yHLsuQNZFMnHUA4
X-Received: by 2002:ac2:4846:0:b0:4dc:8192:c5e6 with SMTP id
 6-20020ac24846000000b004dc8192c5e6mr802942lfy.13.1684507903307; 
 Fri, 19 May 2023 07:51:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Txw1swKS3OJfyf//G8/Xuy1YQxI8949xdqLPQQRFSEe04UYk9HZTxQkns8DTpSxashjS+Eg==
X-Received: by 2002:ac2:4846:0:b0:4dc:8192:c5e6 with SMTP id
 6-20020ac24846000000b004dc8192c5e6mr802929lfy.13.1684507903066; 
 Fri, 19 May 2023 07:51:43 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 e5-20020a056512090500b004f38411f148sm626343lft.84.2023.05.19.07.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:42 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Yiming Tao <taoym@zju.edu.cn>, Gonglei <arei.gonglei@huawei.com>,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PULL 23/40] virtio-crypto: fix NULL pointer dereference in
 virtio_crypto_free_request
Message-ID: <3e69908907f8d3dd20d5753b0777a6e3824ba824.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mauro Matteo Cascella <mcascell@redhat.com>

Ensure op_info is not NULL in case of QCRYPTODEV_BACKEND_ALG_SYM algtype.

Fixes: 0e660a6f90a ("crypto: Introduce RSA algorithm")
Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Reported-by: Yiming Tao <taoym@zju.edu.cn>
Message-Id: <20230509075317.1132301-1-mcascell@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: zhenwei pi<pizhenwei@bytedance.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-crypto.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 2fe804510f..c729a1f79e 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -476,15 +476,17 @@ static void virtio_crypto_free_request(VirtIOCryptoReq *req)
         size_t max_len;
         CryptoDevBackendSymOpInfo *op_info = req->op_info.u.sym_op_info;
 
-        max_len = op_info->iv_len +
-                  op_info->aad_len +
-                  op_info->src_len +
-                  op_info->dst_len +
-                  op_info->digest_result_len;
+        if (op_info) {
+            max_len = op_info->iv_len +
+                      op_info->aad_len +
+                      op_info->src_len +
+                      op_info->dst_len +
+                      op_info->digest_result_len;
 
-        /* Zeroize and free request data structure */
-        memset(op_info, 0, sizeof(*op_info) + max_len);
-        g_free(op_info);
+            /* Zeroize and free request data structure */
+            memset(op_info, 0, sizeof(*op_info) + max_len);
+            g_free(op_info);
+        }
     } else if (req->flags == QCRYPTODEV_BACKEND_ALG_ASYM) {
         CryptoDevBackendAsymOpInfo *op_info = req->op_info.u.asym_op_info;
         if (op_info) {
-- 
MST


