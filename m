Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF70709AA0
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:55:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Sj-0003vo-VB; Fri, 19 May 2023 10:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01SM-0003tF-SP
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01SK-0003gH-Ra
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Y4RlRUifuWdGvfjUojCEkNyIBAd0v/LeQqgJVREKVs=;
 b=DRB/etKIJizbOeoJ7CPVz0qF17AFvYaloVQkyk0OcnIKnUoEcDKxCpr+XvcRS4JffL48o5
 zkYFV5VtzX05xRidcS8lI3JKuW8OL5XKsGSCZANKIZ/CtG9fYg3WN+GxWOJjY7ETnyDk7B
 S2sSz43PWi43e1IN+vRQJ1g7A8UtIzQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-sM43P0yjMUStktIED10Scw-1; Fri, 19 May 2023 10:51:40 -0400
X-MC-Unique: sM43P0yjMUStktIED10Scw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f38f48be8bso2238357e87.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507898; x=1687099898;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Y4RlRUifuWdGvfjUojCEkNyIBAd0v/LeQqgJVREKVs=;
 b=AahGrRmkn9ieXZiZivmkpVnNoPupj5J2+inOzUAim+xKTM49SfNKNEWAr2OjirYFkC
 AcfSKIVafN6smNPbaHRUf12CXf1g7l4Gu7aXTLASw1qqJQ6a3lBwB7Oh5x8Hcads6au0
 MMD2wgsWBOKznCECJAKubxuFxumNhTt1jnQxGtxuJwjRu99T47YR4MifzBGqwua8Xezz
 /XpZUhK5oql6zNpYBmX+9Xg9QkSPqPhk7pn9hX0exb2ZTEqiWAqnVi+IlmPcacCYCor2
 YPGX11prwE6Dmp8BxtLJq3sdaK5S5mkchWR6/TAaoD3GoF0qYfM6ceUSafOtT8ZwyECs
 flvA==
X-Gm-Message-State: AC+VfDyV/9gKDFE9ELQLhC+9GNjR7Cm3RW6EnXLJ2XqVyhpbUYi1LHfP
 tMJ2PW0rWTRaUkQ3HIcHzQbOcnM1aFVtg4ScdEdLUEiE8+Q+xFaxKrkzt2H5rPk9ds+YKvWkxKm
 JrXOYpY9KweNo8DNVp8sUhGhRZgH+alvHpoKkyAgKntUMtAhc+/YPnD/h5HBoM4wHaoJx
X-Received: by 2002:ac2:5973:0:b0:4f3:ac64:84f8 with SMTP id
 h19-20020ac25973000000b004f3ac6484f8mr851479lfp.34.1684507898528; 
 Fri, 19 May 2023 07:51:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7AYWDiUW4KeHq8NfvE66wGpALh6ea0vXBc9tAjZ4u6rgWH2zFOSb1svzzx9YUAxZ/jLqAEHQ==
X-Received: by 2002:ac2:5973:0:b0:4f3:ac64:84f8 with SMTP id
 h19-20020ac25973000000b004f3ac6484f8mr851466lfp.34.1684507898180; 
 Fri, 19 May 2023 07:51:38 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 u3-20020ac248a3000000b004f14591a942sm614489lfg.271.2023.05.19.07.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:37 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 22/40] virtio-net: not enable vq reset feature unconditionally
Message-ID: <1fac00f70b3261050af5564b20ca55c1b2a3059a.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Eugenio Pérez <eperezma@redhat.com>

The commit 93a97dc5200a ("virtio-net: enable vq reset feature") enables
unconditionally vq reset feature as long as the device is emulated.
This makes impossible to actually disable the feature, and it causes
migration problems from qemu version previous than 7.2.

The entire final commit is unneeded as device system already enable or
disable the feature properly.

This reverts commit 93a97dc5200a95e63b99cb625f20b7ae802ba413.
Fixes: 93a97dc5200a ("virtio-net: enable vq reset feature")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

Message-Id: <20230504101447.389398-1-eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 447f669921..8ce239a34d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -805,7 +805,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     }
 
     if (!get_vhost_net(nc->peer)) {
-        virtio_add_feature(&features, VIRTIO_F_RING_RESET);
         return features;
     }
 
-- 
MST


