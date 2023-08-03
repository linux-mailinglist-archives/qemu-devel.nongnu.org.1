Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC276F5A7
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghz-0006ND-M0; Thu, 03 Aug 2023 18:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghq-00067E-Rq
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghp-0000d8-9w
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CAtiw9pOJqz+4/AtNB9psY6BRMakFeABmSxYufoyBfw=;
 b=LEWP93vpX9t3E55EHVo2Bb2kkcqyKCKxXAXikGOhFvwlClHboND4bN2UOXiZPGco0/w/XK
 ML22oJd2jFovl1l9rTzZv3DQPHXyn5mp9RPojkBdeVxbFdoD82WwNwfJuLjTLkhmLjf+wN
 hYKWtM3rrGKonK6zEW+wUXmUtmwXu84=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-bQ1bp6rKPJ6oM5i9BmLFCg-1; Thu, 03 Aug 2023 18:22:03 -0400
X-MC-Unique: bQ1bp6rKPJ6oM5i9BmLFCg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb87c48aceso1548585e87.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101321; x=1691706121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAtiw9pOJqz+4/AtNB9psY6BRMakFeABmSxYufoyBfw=;
 b=jMMJNRF4/wvKPu7PybWdzpfd0vSbGuwII7LtGY8Vv0YRI1yuPaM/PmS69D5ia7D4Bw
 vsSChZtJpgrpwHQTkEzJDvvf+4rKanmPs81p/Vu0t3XOMn5htoh7/pkx4XzjSGwdl0hj
 LjPOYz31DKBBmHOTdjXgpkQwka02gSkLIIauPOqsIBHBl/IrrqPYF/ZpHKTMdgWWx13L
 GfydXAMH0CznYWRwIiB0zgNhPQnLoBee6CaHTAs3vueKvHone+C1OaD8KrTwrYleMF/6
 CMZ4M8zYWEljjMd0U3EcV9YVeTpBqfK55Qr17IJf1BCUf7KfbklhbSt+iZ6aRF0pEr2E
 W94Q==
X-Gm-Message-State: ABy/qLaT8hDfG8DUfKi+ddZMH+54g9qxSw7yP0wjp+X33esIfmzG17lU
 +6bNBl7As61eyiis8vSoHYBu90E0ylKPitt48K4VOj8LUPev9+GcbmipsnLzvrYGGJ4nfYNud7E
 jzPFhQ8yFUJtGqk+in2AuETZ93J3Ya+xFRIN6YiFQvFgGCVvAB56jGMWXngp+OevuhFwX
X-Received: by 2002:a19:921a:0:b0:4fd:fafd:1ed4 with SMTP id
 u26-20020a19921a000000b004fdfafd1ed4mr6935218lfd.2.1691101321687; 
 Thu, 03 Aug 2023 15:22:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEB46lCbnx/anJD76gv6lYMucYEdx1EEI0uTWFKKsXxEElAUP8TWhybI3AJ4fXUyHgvI5fbSw==
X-Received: by 2002:a19:921a:0:b0:4fd:fafd:1ed4 with SMTP id
 u26-20020a19921a000000b004fdfafd1ed4mr6935204lfd.2.1691101321289; 
 Thu, 03 Aug 2023 15:22:01 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 d19-20020aa7d693000000b0051ded17b30bsm362300edr.40.2023.08.03.15.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:22:00 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 zhenwei pi <pizhenwei@bytedance.com>, Gonglei <arei.gonglei@huawei.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Xiao Lei <nop.leixiao@gmail.com>, Yongkang Jia <kangel@zju.edu.cn>,
 Yiming Tao <taoym@zju.edu.cn>
Subject: [PULL 22/22] cryptodev: Handle unexpected request to avoid crash
Message-ID: <15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: zhenwei pi <pizhenwei@bytedance.com>

Generally guest side should discover which services the device is
able to offer, then do requests on device.

However it's also possible to break this rule in a guest. Handle
unexpected request here to avoid NULL pointer dereference.

Fixes: e7a775fd ('cryptodev: Account statistics')
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: Xiao Lei <nop.leixiao@gmail.com>
Cc: Yongkang Jia <kangel@zju.edu.cn>
Reported-by: Yiming Tao <taoym@zju.edu.cn>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230803024314.29962-3-pizhenwei@bytedance.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 backends/cryptodev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 7d29517843..4d183f7237 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -191,6 +191,11 @@ static int cryptodev_backend_account(CryptoDevBackend *backend,
     if (algtype == QCRYPTODEV_BACKEND_ALG_ASYM) {
         CryptoDevBackendAsymOpInfo *asym_op_info = op_info->u.asym_op_info;
         len = asym_op_info->src_len;
+
+        if (unlikely(!backend->asym_stat)) {
+            error_report("cryptodev: Unexpected asym operation");
+            return -VIRTIO_CRYPTO_NOTSUPP;
+        }
         switch (op_info->op_code) {
         case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
             CryptodevAsymStatIncEncrypt(backend, len);
@@ -210,6 +215,11 @@ static int cryptodev_backend_account(CryptoDevBackend *backend,
     } else if (algtype == QCRYPTODEV_BACKEND_ALG_SYM) {
         CryptoDevBackendSymOpInfo *sym_op_info = op_info->u.sym_op_info;
         len = sym_op_info->src_len;
+
+        if (unlikely(!backend->sym_stat)) {
+            error_report("cryptodev: Unexpected sym operation");
+            return -VIRTIO_CRYPTO_NOTSUPP;
+        }
         switch (op_info->op_code) {
         case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
             CryptodevSymStatIncEncrypt(backend, len);
-- 
MST


