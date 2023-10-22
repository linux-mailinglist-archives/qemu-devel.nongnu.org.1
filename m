Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 908FF7D221E
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUfQ-0000Rz-5r; Sun, 22 Oct 2023 05:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfM-0000R7-ON
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfL-0000E2-8p
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axsLHZnyDqeJsUPQJ6Te7VvBOL93A3E/3UAHlG8ASYU=;
 b=N0EVNoQN/X/vtOGasVfQVpkgX2E6CdJDQ4v/2rmvp8sVJgQLk0uY47qG/KsfJ3Rrjqr2SE
 KctM98z7hkqcj8QHhAE05pjCWE3+wq+G1PnjGsh6kgKht2FTK/68kc/OyP8eRfep+MFnNf
 kWmyHJyTGnYUS5DeFnczSiH54VplNGA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-jAqZ-f8DORuEWaM4aNMIqw-1; Sun, 22 Oct 2023 05:22:27 -0400
X-MC-Unique: jAqZ-f8DORuEWaM4aNMIqw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32da215295fso883862f8f.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966545; x=1698571345;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=axsLHZnyDqeJsUPQJ6Te7VvBOL93A3E/3UAHlG8ASYU=;
 b=XreRxtDA3jqtCxq7Sr6XlrhsOYrC8KFBOuu7N0FBYrHoVnbDWC5/RRf1ZbmFdJjblI
 Xv4EgEgNQ+Ho52NFwocdBcIHiTBCahwah2hMr/UyiC69zxOCnnsRzz2mfpa4yppDr7wq
 76H5yWV47Nu/EJhGUU/fMJDCCHTOV0bQZUPud5YfPoDpA148kJU6aVmFQQs7vpVNj6F0
 5K5TiNX2Lx7baTKN4qSfgqXU+bMxtWE2/tji57Vk8pGXsOk273eC9lLdeKKU7wRoG54F
 S7+VmbkCaUeUNlcnnHdb5ZkL1o7iBRA0CZrgqsVxjOyQ4l95db9CIN8uiaBg+E3gOYHQ
 EotQ==
X-Gm-Message-State: AOJu0YyIs/G809bNH8usWzBMeLy/QAuFPxulkjVdaAwQG1Pv0eTcsmVP
 XwvbMrh63D9uE8vz3ASvGuxFfFaO1zBtfOOIzhQssVpnQhdQcNMDGsbjSvsj4gDcKZIWUAKF+jN
 BwGsYCuDrziVY/2jJe1ixurPoG5dp4mJ6Irf1fSfagwEH+QAnF5aLPDEsb1W8k3fV48i0
X-Received: by 2002:a5d:5248:0:b0:32d:8e6f:ecb3 with SMTP id
 k8-20020a5d5248000000b0032d8e6fecb3mr3718280wrc.65.1697966545693; 
 Sun, 22 Oct 2023 02:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRkt+oQtTrxs6yjVSKS5dSPv3OkL5oRYBMviLbxkIuAb+awd1Cif4ecBe6EqPC7Hy0kZDVpw==
X-Received: by 2002:a5d:5248:0:b0:32d:8e6f:ecb3 with SMTP id
 k8-20020a5d5248000000b0032d8e6fecb3mr3718264wrc.65.1697966545427; 
 Sun, 22 Oct 2023 02:22:25 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 p5-20020a5d4585000000b0032d8034724esm5289950wrq.94.2023.10.22.02.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:24 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v3 08/62] vhost-user: strip superfluous whitespace
Message-ID: <1428831981edc53fe819f76d07306f6b041fe55c.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Laszlo Ersek <lersek@redhat.com>

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Cc: Eugenio Perez Martin <eperezma@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Liu Jiang <gerry@linux.alibaba.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20231002203221.17241-2-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 68eb1f0c99..3e33a2e9e0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -388,7 +388,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
      * operations such as configuring device memory mappings or issuing device
      * resets, which affect the whole device instead of individual VQs,
      * vhost-user messages should only be sent once.
-     * 
+     *
      * Devices with multiple vhost_devs are given an associated dev->vq_index
      * so per_device requests are only sent if vq_index is 0.
      */
-- 
MST


