Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2613276F5A6
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghs-00067Z-2u; Thu, 03 Aug 2023 18:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghm-00060u-V5
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghk-0000cE-OY
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jCTXF+0lbl62gsI88fAfOsRF/xYzDCyMeNpegzpcFFI=;
 b=P9HEp3MT2JfAHb23a5A4XDyJ8c75Yw3LJX56ljCWhniOLpaSD2O6C+xlorELpMakAEGxyV
 GL+Xm6D+sHYuUgH0P7ldKy0dRdzoQkUlGzqtwegZXOFNZnbqfZVqjLPY9VruAtiLh1XOE3
 Wt8MvWitFnvGiLFSbRBteP0+zSURY4I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-L94ddGMHOf2FJjBQiVGjug-1; Thu, 03 Aug 2023 18:21:59 -0400
X-MC-Unique: L94ddGMHOf2FJjBQiVGjug-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bfe6a531bso131000666b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101317; x=1691706117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCTXF+0lbl62gsI88fAfOsRF/xYzDCyMeNpegzpcFFI=;
 b=SBcqA/4WGTepiORn+m14GKf32IFRb0w3OYBndxdX0+4egvD8FkMuhoBWPvs2dTNkoe
 AEvWqBbNMv+PBW99m6aRzkiCPQ7b4hTSyBWrXfR3mvuf6zB9ZOOPrZsKCJLKfw2pbeXG
 2wilwHbs6A9ayPm6jX2Q6CE9ueckQIYDVw8HMVejEZmDnscqrIMTlhg8FwpV8KC+UwFy
 O7IMfCO14Hun92fC/Qj0ehmCM2mVYiHiEQl8JHi+uNBdbAuUH2SaXSMWWk1/CNET1t9m
 wI7TrRSVVgSddngrpsTjooNqKohzahxAuA2SGpKPM9VZO/qGvwS3MV/r4Wa7bp0dFP+j
 OSDA==
X-Gm-Message-State: ABy/qLbqMuaFc85dcgxgplcrno5/sARDlRl7EfzyxHCm+tdak4fXlUxc
 IcHRwrDVZhLlHV1GUQDDvQALVneiJKsp/LCb9MhkuQwUVou8PVy/O2d1ODNYCdlObcjZfkHO431
 GwgHBKH6o+vKq4PJxM8XZPty3osYjB9zVS85Eymia0178K62qEk8AsQFzPGuOXsW6+jb1
X-Received: by 2002:a17:907:7710:b0:99b:f50b:d7d5 with SMTP id
 kw16-20020a170907771000b0099bf50bd7d5mr8377023ejc.44.1691101317506; 
 Thu, 03 Aug 2023 15:21:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFmL+JMoTuDZVaB5J91GZ325tj9Dj5HOpixZz7DGkr+eEDuNJzbU50rveyARl8BJqWeCMF3tw==
X-Received: by 2002:a17:907:7710:b0:99b:f50b:d7d5 with SMTP id
 kw16-20020a170907771000b0099bf50bd7d5mr8377004ejc.44.1691101317215; 
 Thu, 03 Aug 2023 15:21:57 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 q18-20020a1709064c9200b009875a6d28b0sm379345eju.51.2023.08.03.15.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:56 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 zhenwei pi <pizhenwei@bytedance.com>, Gonglei <arei.gonglei@huawei.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Yiming Tao <taoym@zju.edu.cn>
Subject: [PULL 21/22] virtio-crypto: verify src&dst buffer length for sym
 request
Message-ID: <9d38a8434721a6479fe03fb5afb150ca793d3980.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

For symmetric algorithms, the length of ciphertext must be as same
as the plaintext.
The missing verification of the src_len and the dst_len in
virtio_crypto_sym_op_helper() may lead buffer overflow/divulged.

This patch is originally written by Yiming Tao for QEMU-SECURITY,
resend it(a few changes of error message) in qemu-devel.

Fixes: CVE-2023-3180
Fixes: 04b9b37edda("virtio-crypto: add data queue processing handler")
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: Yiming Tao <taoym@zju.edu.cn>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230803024314.29962-2-pizhenwei@bytedance.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 44faf5a522..13aec771e1 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -634,6 +634,11 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
         return NULL;
     }
 
+    if (unlikely(src_len != dst_len)) {
+        virtio_error(vdev, "sym request src len is different from dst len");
+        return NULL;
+    }
+
     max_len = (uint64_t)iv_len + aad_len + src_len + dst_len + hash_result_len;
     if (unlikely(max_len > vcrypto->conf.max_size)) {
         virtio_error(vdev, "virtio-crypto too big length");
-- 
MST


