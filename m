Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BCF7B7ABB
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUu-0004v3-TA; Wed, 04 Oct 2023 04:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUN-00045h-PG
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUM-0001Df-4x
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAoyD8naooe+1owbsXcnZ1RIo6I7CUVOQ7MqfozanzM=;
 b=WOv19mm7IxzP9+QfZPokGi8Vx5tIIFFQrq4sbd/ktSCTiYMT3Pm4UN8tAGoNjSLv+zfd2N
 7UmaT1ukp2lWs5QiLgnXXQBxUYihJDtuQ/kbkxd0FmsC+heu2Jt3fg77NqXKpYPo5cSSzv
 X7AfHQJz6ynYxgC5ep8ZzxsmYdvgH68=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-lkTr44dPO4mQXvjStXCLhw-1; Wed, 04 Oct 2023 04:44:12 -0400
X-MC-Unique: lkTr44dPO4mQXvjStXCLhw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso14557875e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409050; x=1697013850;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wAoyD8naooe+1owbsXcnZ1RIo6I7CUVOQ7MqfozanzM=;
 b=l949pEby95kWgJTxsaYe5fwADUr74tOheQ6ofEJXNpVYF+wqEwjlxAEokDqIlk2KGT
 Z8TjTM3Xk2Fwfhx28efgg+Hie1UtSp+4/n0EVzOFGgrc2rKtdzeXpdZ4CHc3v5im4HCG
 19aQ5kNEpWLFtAMoKdLHuE85GA/cnlA+tQTbIIOc+1dVO5L9gXy9esYnyri/APmA9hdG
 85E1ExFtiv+tRfCQJJxg5rsVvXOAfirdqDO7eUkOLNeZZ4JP4crvNj6P6Olgeey3jC2e
 9OR7RhhbuOcNCDZexJ6qiZscN1Lwj1/zuzlXrHiL31fVXzPwAvkQ+34Gou+AWFUaeVwJ
 FnMQ==
X-Gm-Message-State: AOJu0YwQrvrnC9lhc+QOQXeKe3ayxzVg5kDyWmRG/EA+5Om+qKYwius8
 rG9pTZ8LSuQBZMKQW5mZUr/cszJMj6u8JdnT7RjDL+2ecZ6vJUeQeG5GET9/voJhkekTbmxMVT0
 JW6JMbjZFQAt+vX0ENmwz35Pb+xTFdd/5gpAdHIc4d+iH0aVRDVlJDjKNjM15Bb0GhXrV
X-Received: by 2002:a05:600c:b91:b0:406:84cb:b014 with SMTP id
 fl17-20020a05600c0b9100b0040684cbb014mr929759wmb.22.1696409050754; 
 Wed, 04 Oct 2023 01:44:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhL0LEBlxG9Gw0c36n0nP3Brj48WF+Ql3+Q1fvJq+iC2TkXknO86CFYaR47JPDcWPhEYpLOA==
X-Received: by 2002:a05:600c:b91:b0:406:84cb:b014 with SMTP id
 fl17-20020a05600c0b9100b0040684cbb014mr929741wmb.22.1696409050503; 
 Wed, 04 Oct 2023 01:44:10 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 y8-20020a7bcd88000000b00406447b798bsm935840wmj.37.2023.10.04.01.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:09 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 19/63] vdpa: remove net cvq migration blocker
Message-ID: <8134d128881c6392f091aa4cd51986daa42f62bb.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

From: Eugenio Pérez <eperezma@redhat.com>

Now that we have add migration blockers if the device does not support
all the needed features, remove the general blocker applied to all net
devices with CVQ.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20230822085330.3978829-6-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0715bed8e6..90beda42e0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1465,18 +1465,6 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->vhost_vdpa.shadow_vq_ops = &vhost_vdpa_net_svq_ops;
         s->vhost_vdpa.shadow_vq_ops_opaque = s;
         s->cvq_isolated = cvq_isolated;
-
-        /*
-         * TODO: We cannot migrate devices with CVQ and no x-svq enabled as
-         * there is no way to set the device state (MAC, MQ, etc) before
-         * starting the datapath.
-         *
-         * Migration blocker ownership now belongs to s->vhost_vdpa.
-         */
-        if (!svq) {
-            error_setg(&s->vhost_vdpa.migration_blocker,
-                       "net vdpa cannot migrate with CVQ feature");
-        }
     }
     ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index, nvqs);
     if (ret) {
-- 
MST


