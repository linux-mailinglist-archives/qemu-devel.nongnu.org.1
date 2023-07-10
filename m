Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3368274E1EF
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwa-000393-UZ; Mon, 10 Jul 2023 19:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwO-0002jW-Rg
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwI-0004b4-45
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvUl4/drtgXBRU9CPKwk/PRPx+0o4aik4MUaSEpTsWY=;
 b=OGoH6s7nZoIoRySJsq9ijNwdg10El6/UvJg04JXN1NG3++wf/9WaSHNIK/DeF4tCjMDZFF
 Ht/9EC5TwWzU3cIobhuoR3tmXWf8LrkkcXv+DoexfU2i908wStkygFqTIwsvRm3UPvesLg
 JJJsoXNAiQOQtfdJ0GkItKU9UrpYumk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-MdwVQz74M_izAgPUrrNMfg-1; Mon, 10 Jul 2023 19:05:02 -0400
X-MC-Unique: MdwVQz74M_izAgPUrrNMfg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbb34f7224so33549135e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030300; x=1691622300;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kvUl4/drtgXBRU9CPKwk/PRPx+0o4aik4MUaSEpTsWY=;
 b=IQKkT9DgYvWGD3c9CJgR3PkVk8yy4JKUrkV2sfz+m7xaRdhtUWOEzI5auGmCXUYvdU
 2GbMbaXK9aZHbi058MpqtIb95GssEBV+EFHo9W24GY5159lvRhvhG+w3q9f4p+wvFThR
 clz/m7DiSgmyOT6r9HwNhrSaZSdpDNckzXR1HbTpiNW0k/9jdLEbH4ETbDlIlzpJG2Sg
 w1CUkSEA5osaoV596mlTEBc0KPoiqUnRnWgX2ChiZMuPJwRDIP9i6B2SCDL+bKnYSno0
 ZXB63fkjm+8iuhWVIXQXWPCYkR4h3ob2AiW40tm8VqPu66/oQC0VIJ5JqBYVk8sGdKJ9
 YV1g==
X-Gm-Message-State: ABy/qLZ+lDEOr9LIRqjsVDUmqyjKEhQykh3b9BqMJIn2RpXlWo9FFGAd
 HN2SNy9SZdH2POQRfSSl5ABWgwAdSZmbfGT+E2pL4WZbCTvOZOVI1NWTgukGtbUqJgTbJOI0rv/
 MY5e9ycnkVamRSC6tLoIRYOpnUhpWNzFFxbT1X3zMq3oRPHGF4uVsq9aDbqWPKNEithHv
X-Received: by 2002:a1c:f712:0:b0:3fb:e643:1225 with SMTP id
 v18-20020a1cf712000000b003fbe6431225mr14193474wmh.13.1689030300437; 
 Mon, 10 Jul 2023 16:05:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEbs3QvCHtKoskpiYyQaZ9EwuExgtcstTr9yKZXW1SzYsFCu5KnwvdAGGAZDMKdn0VmfcBQ+A==
X-Received: by 2002:a1c:f712:0:b0:3fb:e643:1225 with SMTP id
 v18-20020a1cf712000000b003fbe6431225mr14193448wmh.13.1689030300141; 
 Mon, 10 Jul 2023 16:05:00 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 l15-20020a1c790f000000b003fc01f7b415sm9206642wme.39.2023.07.10.16.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:59 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 53/66] include/hw/virtio: document virtio_notify_config
Message-ID: <a0cc7673ab731794caefed2033d68a2199d6bfaf.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
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

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230710153522.3469097-5-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 0492d26900..0671989383 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -276,6 +276,13 @@ extern const VMStateInfo virtio_vmstate_info;
 
 int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id);
 
+/**
+ * virtio_notify_config() - signal a change to device config
+ * @vdev: the virtio device
+ *
+ * Assuming the virtio device is up (VIRTIO_CONFIG_S_DRIVER_OK) this
+ * will trigger a guest interrupt and update the config version.
+ */
 void virtio_notify_config(VirtIODevice *vdev);
 
 bool virtio_queue_get_notification(VirtQueue *vq);
-- 
MST


