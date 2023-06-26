Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7815573DF73
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:41:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlMV-0005eE-LY; Mon, 26 Jun 2023 08:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLP-0002pP-QH
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLJ-00035h-8a
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fXU90TCrPGTJYXwM0DjJPPrOfmo7FHnSBsI1Li4hHxI=;
 b=MsyJVi+LZN7G+JhpSqvfXO5tnNR4/guQCfqR/kKdKe6O0c5XVlm29sXyVRhaBMK+6ZRss9
 +YTaQMao7fd46jnh0FMVQHAUmjnkUp3veNkR7z9/3LhJdMgOFCVpHiaAoqbLdOIabehHlG
 g4ctb72bG7xIyHeXX/Z+pAljlbYHG9g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-y1Unr-5yP8qh8-uGAN_28w-1; Mon, 26 Jun 2023 08:29:15 -0400
X-MC-Unique: y1Unr-5yP8qh8-uGAN_28w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f814f78af2so13116045e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782554; x=1690374554;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fXU90TCrPGTJYXwM0DjJPPrOfmo7FHnSBsI1Li4hHxI=;
 b=VYFrHx60e9uRE56AokKgvkbMYhCAlWPeMbOBXVEfpIzc+HnPUceXOi1oSBY24F3mIC
 L3QUrYJDzgU9TGnktNoAU2vss7IvI8DhnyR4Dj3YNfeuY9emzlysM4he7juZVPJv51dU
 liHAiGvWBoWDflrliPQBraFZ1EdE974+DnrUtZCRMR0J7nEp6uJfDY8os1buCT+x8daH
 1HFO66biDd7ghkqBB1a4ajkVGmQ4+/ePtMQ9SMAr7MWKb2HkYQV/yVrO52I6lQwpdwSb
 SM20GWBXid9q7uw7xcp7kcwfPR4KcEZxjSTGJM0qX2qtZUefmwlnPs2ayH13g7McfWYt
 0qFg==
X-Gm-Message-State: AC+VfDxy2ZupwYyupvpE8XaOIKjS0xFRgaoAqDeV5cEGRpdkzj42YdWs
 KW1P+1nWBmea9/YP1yTcXgxaX020W9W7eaS/xVwIBl4EeNA1XmADafr7QMIwTqIMrellUKxPt73
 usTlyylf86frpfOEfm0n3hywCDVMu26VkvNdbgmB9Occe3S67NfIqVzjy54q89sK0+VUT
X-Received: by 2002:a05:600c:2204:b0:3fa:8db4:91ec with SMTP id
 z4-20020a05600c220400b003fa8db491ecmr2409540wml.10.1687782553958; 
 Mon, 26 Jun 2023 05:29:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yQcKQX++d4QM53cylS2Kk+92ukcHM0rFU4P6sy6fzGSG4gYYsmaSjDUZn5IGEPD0Aez0XBg==
X-Received: by 2002:a05:600c:2204:b0:3fa:8db4:91ec with SMTP id
 z4-20020a05600c220400b003fa8db491ecmr2409526wml.10.1687782553638; 
 Mon, 26 Jun 2023 05:29:13 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 i7-20020adfdec7000000b00313dfe954ecsm7160021wrn.11.2023.06.26.05.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:13 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 27/53] vdpa: return errno in vhost_vdpa_get_vring_group error
Message-ID: <0f2bb0bf38b04e9dfdc32ce5c762dd317f5a4c5a.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Eugenio Pérez <eperezma@redhat.com>

We need to tell in the caller, as some errors are expected in a normal
workflow.  In particular, parent drivers in recent kernels with
VHOST_BACKEND_F_IOTLB_ASID may not support vring groups.  In that case,
-ENOTSUP is returned.

This is the case of vp_vdpa in Linux 6.2.

Next patches in this series will use that information to know if it must
abort or not.  Also, next patches return properly an errp instead of
printing with error_report.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230526153143.470745-2-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 37cdc84562..3fb833fe76 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -362,6 +362,14 @@ static NetClientInfo net_vhost_vdpa_info = {
         .check_peer_type = vhost_vdpa_check_peer_type,
 };
 
+/**
+ * Get vring virtqueue group
+ *
+ * @device_fd  vdpa device fd
+ * @vq_index   Virtqueue index
+ *
+ * Return -errno in case of error, or vq group if success.
+ */
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index)
 {
     struct vhost_vring_state state = {
@@ -370,6 +378,7 @@ static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index)
     int r = ioctl(device_fd, VHOST_VDPA_GET_VRING_GROUP, &state);
 
     if (unlikely(r < 0)) {
+        r = -errno;
         error_report("Cannot get VQ %u group: %s", vq_index,
                      g_strerror(errno));
         return r;
-- 
MST


