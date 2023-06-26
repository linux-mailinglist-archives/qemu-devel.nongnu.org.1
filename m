Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4814673DF74
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:41:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlPD-0000Mc-1j; Mon, 26 Jun 2023 08:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlN5-00063z-3a
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMj-0003iZ-SZ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=am5myhsqD+fEwFvcZjXyQzYIV9qRjvKXNDjfcB6tC8s=;
 b=Yvqp5kDlm+FXp6V5X/0BnZ9AAxlrb8xD2yXqyUiJXAi4offze1CfpKgc/OpagvG2pj51+X
 52DbxTjFvfLSBUzUmco0awozSMdLdyuTKOynCFGZqQsOMZK/rXgaADieDbpCsDE/Go/w47
 KivWnJMugxCBPz2H8wtrvFqlcGU42K0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-8gHaMsGkO2-kvvryVi0INw-1; Mon, 26 Jun 2023 08:30:43 -0400
X-MC-Unique: 8gHaMsGkO2-kvvryVi0INw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b479d12b31so23025071fa.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782627; x=1690374627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=am5myhsqD+fEwFvcZjXyQzYIV9qRjvKXNDjfcB6tC8s=;
 b=jC5Fl/SgoeFMbCUznEpZStykOLvLGizdfVRLg/zolILP26Sn0Xh4G+IjrueJ0n24Vm
 UMtNCqVHMD7USxapS4eA2WLqe+sGa4tZRon8/+r48P8Vx/7uRpuK4oPly2nez2+d6gaN
 IWYEJwcZoSa0pTVVzN9N4cPxDt0SDBDUWjmT5oWjVSjfyGeKuj41RzQB3FC3skZei0gv
 W3U6YjgM4dcipGWNdBMtwvT+Ff6TYyxHKWETxXOu3KU+jZW8svipAtnQ7L1c+Icj/vB3
 8V0EheqNeYr9aMvQzh32AvZ8+yBXFsYaLFAU09+HmvQTM1oRpwru4+X5O6azMi20r7Li
 d36w==
X-Gm-Message-State: AC+VfDxuISz58SgIKYzETSorN9q41VJt7acgmMOPKcpIgrLxOcAlIcn3
 XOI5a2eX2eTIwggeX3jvvZ1nsUwdiSSpHv8oYLZ8Hm7MPBfIkPS9EGl6ZUNfL6/1SjMhxfns0B0
 EalcW6lRLdJAd4kPEg8IvBeDQAn67zSyhDMTHwD/VO4d5ZDRk7nq0NOn/pksKcqeYIjuD
X-Received: by 2002:a05:6512:b86:b0:4fb:7666:3bc0 with SMTP id
 b6-20020a0565120b8600b004fb76663bc0mr1260130lfv.47.1687782626865; 
 Mon, 26 Jun 2023 05:30:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Dbpbz+kRgmg53qnrJxccE80t/Qeb83yDoU/q2OEhUg1IMwd+/nfxVfNlbnvncuUtwvHS2ow==
X-Received: by 2002:a05:6512:b86:b0:4fb:7666:3bc0 with SMTP id
 b6-20020a0565120b8600b004fb76663bc0mr1260109lfv.47.1687782626472; 
 Mon, 26 Jun 2023 05:30:26 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 g17-20020a7bc4d1000000b003f9b1131a90sm7615633wmk.23.2023.06.26.05.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:30:26 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:30:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 52/53] vhost_net: add an assertion for TAP client backends
Message-ID: <0af710813dcde638379e3bece8f9b1bde31af2f6.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Ani Sinha <anisinha@redhat.com>

An assertion was missing for tap vhost backends that enforces a non-null
reference from get_vhost_net(). Both vhost-net-user and vhost-net-vdpa
enforces this. Enforce the same for tap. Unit tests pass with this change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20230619041501.111655-1-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index c4eecc6f36..6db23ca323 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -507,6 +507,7 @@ VHostNetState *get_vhost_net(NetClientState *nc)
     switch (nc->info->type) {
     case NET_CLIENT_DRIVER_TAP:
         vhost_net = tap_get_vhost_net(nc);
+        assert(vhost_net);
         break;
 #ifdef CONFIG_VHOST_NET_USER
     case NET_CLIENT_DRIVER_VHOST_USER:
-- 
MST


