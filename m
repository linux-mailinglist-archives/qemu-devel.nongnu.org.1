Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE5F9386DA
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jul 2024 02:19:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgjh-0002N9-C7; Sun, 21 Jul 2024 20:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgje-0002Lg-7j
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjc-0005h0-N1
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7lYzPlslzs28OpL2JOdMIA3bwyrM1HvLLKU1gK7kNg=;
 b=eq3pynZ+uENv5+MYhh6Mi4Fr7g155OQ/v5c8iqfoi7BqA6a/mwRD29W7cWNUeC6GARgAeo
 J8T0BT/981Wo2BdqXGvAbCJ+P7smFbxQRMh5BhfpdOhvwv9fWR+RVJrNY5K3dQV0CwgEgA
 8egRcun8vcyW+lMatavNRC97+7X4H9o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-4nHZaR3APFaO5eSRKXDczg-1; Sun, 21 Jul 2024 20:16:56 -0400
X-MC-Unique: 4nHZaR3APFaO5eSRKXDczg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-427b7a2052bso37773355e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607415; x=1722212215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7lYzPlslzs28OpL2JOdMIA3bwyrM1HvLLKU1gK7kNg=;
 b=XBTFC1VKzG9JqcU5W7HJUSPpFm6WxOyLHPueya1EKNXFvzQY7Jp7ZohjVqyUBeAU5U
 fPpeQJHIo5vlw/6a+/3h/6bRrz1oqBqQ9oqv8CYb7f1ZERQxzOokxoia4Cc9GcVf9ZI7
 tEXrzFMV2wqowamIABcIZWTsI9CbtcIYIOS94ripPzhBt23ug9gK4tHXpWpCS52byb7x
 UH5Q+h6f/+aZBV/SUVJ0tMpMJ/zUSAoACl9HtTuRArGspdoYvIAD9xj07VoZjNYUppWy
 qmqX2R3QCH7M8mDP0kxr+9Ynp6i1KeW/U2ARUEr6kp7R5+2n9q8pHPk92u293r1tV2Wm
 4viQ==
X-Gm-Message-State: AOJu0Yzw1MgZ2X8bdqbyFp4JhSNbQAwFDglalx8kiqwleOOLvkwwcLsd
 uhKs5fBQcOQfsr1rc17vlaHtY3O+sYS0nuTUPW/YHPsWm6YnHX2UeIOYXoOLlublZskNz60zaVP
 S4I0zazbMIESEBh0rGWthY0571bMpI+d+PVY5tHTB2sMzfMs6jkTL9Jn5RjzAFeeW9ljFdl9qU2
 L4emmEUpLg1eWTmMqC56U1inCjzmLvoQ==
X-Received: by 2002:a05:600c:5125:b0:426:6fd2:e14b with SMTP id
 5b1f17b1804b1-427df7aaadbmr25998535e9.11.1721607413877; 
 Sun, 21 Jul 2024 17:16:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQHpan3kjP1E1Bnwiin8yCv3Lsx7Xxh8sIlTO0AFok6pw9t9aKNChdy0WRI2nBCr2gOQ+3Nw==
X-Received: by 2002:a05:600c:5125:b0:426:6fd2:e14b with SMTP id
 5b1f17b1804b1-427df7aaadbmr25998295e9.11.1721607412650; 
 Sun, 21 Jul 2024 17:16:52 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm105740125e9.12.2024.07.21.17.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:16:51 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:16:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zheyu Ma <zheyuma97@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL 01/63] hw/virtio/virtio-crypto: Fix op_code assignment in
 virtio_crypto_create_asym_session
Message-ID: <89cf6574bc4bcdb99894e9401ecea0063d8212ce.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zheyu Ma <zheyuma97@gmail.com>

Currently, if the function fails during the key_len check, the op_code
does not have a proper value, causing virtio_crypto_free_create_session_req
not to free the memory correctly, leading to a memory leak.

By setting the op_code before performing any checks, we ensure that
virtio_crypto_free_create_session_req has the correct context to
perform cleanup operations properly, thus preventing memory leaks.

ASAN log:
==3055068==ERROR: LeakSanitizer: detected memory leaks
Direct leak of 512 byte(s) in 1 object(s) allocated from:
    #0 0x5586a75e6ddd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
    #1 0x7fb6b63b6738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
    #2 0x5586a864bbde in virtio_crypto_handle_ctrl hw/virtio/virtio-crypto.c:407:19
    #3 0x5586a94fc84c in virtio_queue_notify_vq hw/virtio/virtio.c:2277:9
    #4 0x5586a94fc0a2 in virtio_queue_host_notifier_read hw/virtio/virtio.c:3641:9

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Message-Id: <20240702211835.3064505-1-zheyuma97@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index bbe8aa4b99..5034768bff 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -205,6 +205,7 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
     int queue_index;
     uint32_t algo, keytype, keylen;
 
+    sreq->info.op_code = opcode;
     algo = ldl_le_p(&sess_req->para.algo);
     keytype = ldl_le_p(&sess_req->para.keytype);
     keylen = ldl_le_p(&sess_req->para.keylen);
@@ -224,7 +225,6 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
         iov_discard_front(&iov, &out_num, keylen);
     }
 
-    sreq->info.op_code = opcode;
     asym_info = &sreq->info.u.asym_sess_info;
     asym_info->algo = algo;
     asym_info->keytype = keytype;
-- 
MST


