Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A609473E082
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:21:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNo-0006Tw-Os; Mon, 26 Jun 2023 08:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMA-0004Zx-IF
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlM8-0003Qv-RS
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/guoVEX4OEQ4WBRKvv4H2+UF4n2CT9gVTBO3TjC4WE=;
 b=B4mFJ68mBI/J/p0LEmbKLMcODyEWUPq4jLHbeD9E87z/Z1tEfOTVRakDP/gEcSLBvqU80I
 Sp5IrAAxu/9wEvYKNvUkod0Q8bznXn+c7dQzYbt3MAsKL6r8P8qs4Lfyf0wTym4Aqk6Z1F
 rCfxJ9iXNJ0ACym2kYcL6Q/cX21K8oA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-5DPbn-ryMeKLGkDtMXmH7g-1; Mon, 26 Jun 2023 08:30:06 -0400
X-MC-Unique: 5DPbn-ryMeKLGkDtMXmH7g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5fa06debcso24064755e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782605; x=1690374605;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/guoVEX4OEQ4WBRKvv4H2+UF4n2CT9gVTBO3TjC4WE=;
 b=ji8iodIwS6BoPFTmixHaP0L4owZ07IES4sT6ljd8oXaRK2w+1LRbPCqQJjf2X3tS0p
 RgiPyD/PicAUaeLzn2oV1fpJZoQbEbDhTkruF69GRvRcYtHcZAaDPqV+6Q/4NhWW18ND
 uJzy9caZTOxCXE/ptdiXjiR0YlT9aiq4LSAPEN0sR4n7roD7apPq1S62KZqU51VVeiTM
 gK49geC3ppBKJkX6XmowCoiStrZPRC/gM4T7ltD5jEUDmaUV0ZZPV6LiN5zZY3rVMerm
 kKgWi9KCMs3AS/WF9dKcUQFJdnhtcKefxKuIYn5Wps67rOWfHRR6G9zPolOIYYvMRxIL
 JVAg==
X-Gm-Message-State: AC+VfDx7g2AP0TlrGvC48otVqWxD2MvPmtqe14eYxksTHZabIxeZOpHA
 F1qzXIepM8RfdEOJSNG00vZ9pToqS7al9XCE55IuPQh6QB5yLUYcms2h2+AyIcn7xSTF7zQHvkb
 T58QkMBU68pgmM5QTwHZgSUx9kunYvjbB49v+021L+xmACkD3OGKjK0R5ZofCPyEpXZva
X-Received: by 2002:a7b:c5d7:0:b0:3f8:c70e:7ed1 with SMTP id
 n23-20020a7bc5d7000000b003f8c70e7ed1mr26006957wmk.20.1687782605254; 
 Mon, 26 Jun 2023 05:30:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bbe9dPsA4QEvoVXT9Tyjm16oa1fjmFc6EaTQqnfYdwBd1KfqoVVWQR6lYEVMRhW8DwivQQQ==
X-Received: by 2002:a7b:c5d7:0:b0:3f8:c70e:7ed1 with SMTP id
 n23-20020a7bc5d7000000b003f8c70e7ed1mr26006944wmk.20.1687782605033; 
 Mon, 26 Jun 2023 05:30:05 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 f26-20020a7bc8da000000b003f819dfa0ddsm7590256wml.28.2023.06.26.05.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:30:04 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:30:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 45/53] vdpa: fix not using CVQ buffer in case of error
Message-ID: <4d721661622df08359541a2a7b40e5827f0a1582.1687782442.git.mst@redhat.com>
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

Bug introducing when refactoring.  Otherway, the guest never received
the used buffer.

Fixes: be4278b65fc1 ("vdpa: extract vhost_vdpa_net_cvq_add from vhost_vdpa_net_handle_ctrl_avail")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230602173451.1917999-1-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 75352efa39..9e92b3558c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -794,7 +794,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
     }
 
     if (*s->status != VIRTIO_NET_OK) {
-        return VIRTIO_NET_ERR;
+        goto out;
     }
 
     status = VIRTIO_NET_ERR;
-- 
MST


