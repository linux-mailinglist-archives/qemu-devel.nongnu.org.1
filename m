Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 865097B9A62
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFH5-0002ag-0L; Wed, 04 Oct 2023 23:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFH2-0002LH-HQ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFH0-00009x-TO
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9qcIDsSMMkJCqsoeBuaE/sgIJa1XEttY+aCH5LMOdA=;
 b=SucnFecEbGXF4dmpBcwc5zerwVAWQmJ+Hh+LE0oiXYTg7PCNY21Bp+24M0OZL/Fb73+bbB
 wAX98z47WLb6V0YPxaBPk0dlTv5bGKtETVqhENDd10Z8xLK9HobN2NgsPx9vo17LboVlA1
 HmRYRG9K+tURBoc+nqs2gr4MRif0N+Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-o3ZQzx7qP1mCP4LrQ5K28Q-1; Wed, 04 Oct 2023 23:43:37 -0400
X-MC-Unique: o3ZQzx7qP1mCP4LrQ5K28Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-323334992fbso471609f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477415; x=1697082215;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D9qcIDsSMMkJCqsoeBuaE/sgIJa1XEttY+aCH5LMOdA=;
 b=gPeviioT1jGAJxGTdyqe0PGs/6GJw8YOV7Rd7T1bU6sCMCPjiiUiDGS+bEwT+sCGIk
 Y1vMGaXlyE7cZYkRb6ru8Zfsc94yFY7RNpWXPIk1eJAzz5G3CySt/unuPac9EiFHTcAq
 NIEptzMlvp7ybsoLApZ97DiNwdlS2UhGGFDYCusm537ZVzVNkq0IxLdw+YOOU+3pHavK
 l7NjbNNQAxP7cM0sSMJq6ZSdkO/pKYwwMcConU0fSt5rNTjzTepmZZdOQBm+WG/t8hxL
 0cvoLrKXT4I4JI2xioKX5BW27EQATgek/n3COx8K6xiJ30GoR49EkvbGElEe5gJ46/yA
 VGZg==
X-Gm-Message-State: AOJu0Yw5m9gBv4aFdWWVkGYoWR1fiHwKplSVZu5HV5sESIxGg42T5A4H
 AhPPVcC4tOyPVQtfsWsAKwvKPFiX6uhVTvBs9UicHk01OTYx/evsy7kKKgPX3zmU+Aq2roJLYHR
 Fbx7ezE9/MWTn5SJLMcldRUmcwhvYdK6nM1JBEJxW2xrPqy61dbKUszmp4p97qp13T5mW
X-Received: by 2002:a05:6000:100e:b0:320:485:7010 with SMTP id
 a14-20020a056000100e00b0032004857010mr3884417wrx.67.1696477415388; 
 Wed, 04 Oct 2023 20:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDlGSMp5uxDZte1h0BJWBWLazTNKlDBJ/AKVFPzrJVKoAWnpCpqtJqcepf9QQ91VWxiRKoDw==
X-Received: by 2002:a05:6000:100e:b0:320:485:7010 with SMTP id
 a14-20020a056000100e00b0032004857010mr3884405wrx.67.1696477415107; 
 Wed, 04 Oct 2023 20:43:35 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 h16-20020a056000001000b003217c096c1esm628111wrx.73.2023.10.04.20.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:43:34 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:43:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL v2 17/53] vdpa: rename vhost_vdpa_net_load to
 vhost_vdpa_net_cvq_load
Message-ID: <f3fada598c909bac12bd18da36437d9bed0b9f06.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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

Next patches will add the corresponding data load.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20230822085330.3978829-4-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 30dc7e77c9..008c0cf8b3 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1013,7 +1013,7 @@ static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
     return 0;
 }
 
-static int vhost_vdpa_net_load(NetClientState *nc)
+static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
     struct vhost_vdpa *v = &s->vhost_vdpa;
@@ -1056,7 +1056,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .size = sizeof(VhostVDPAState),
     .receive = vhost_vdpa_receive,
     .start = vhost_vdpa_net_cvq_start,
-    .load = vhost_vdpa_net_load,
+    .load = vhost_vdpa_net_cvq_load,
     .stop = vhost_vdpa_net_cvq_stop,
     .cleanup = vhost_vdpa_cleanup,
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
-- 
MST


