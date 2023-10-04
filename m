Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A27B7B7A8D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:47:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUh-0004Kr-Va; Wed, 04 Oct 2023 04:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUI-0003cg-LU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUG-00018t-4J
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9qcIDsSMMkJCqsoeBuaE/sgIJa1XEttY+aCH5LMOdA=;
 b=dppHfopSbkH15Ms5sEclYM8ptuJ/OJPaukq0uYikxgmV2EKFWrEXqwmWFUIE+xeOUDIBrb
 WGLAnJnL16l0/s9Wv4zeKq0QDCszTDomeUBnOVKH4g/QuphDb7gas9eP8r3sEatnJ9AxrF
 3UHtY4WBdXObJ3fnbzsL9YR3sjBE79E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-JXfViYyvPea1I6zXqOSzSg-1; Wed, 04 Oct 2023 04:44:06 -0400
X-MC-Unique: JXfViYyvPea1I6zXqOSzSg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4064b38dc63so2868905e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409044; x=1697013844;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D9qcIDsSMMkJCqsoeBuaE/sgIJa1XEttY+aCH5LMOdA=;
 b=RQbmK1Rtf66By6vpZwtReWJsU57kgzd8p6VusCzK2rDaRPAWakEOLplhFxyZIyaH+J
 fSnbpfsYwTbIX1tN3vClOWUd0w/C600ZHHfd0AVKxKWuF20fHR9BOdAtmw6qXr+bJfq5
 gkxodmNYR6axmxkPN1+7KXj3rRVqd50TJhAbkRC7pPVm5b31EcO+3tP11Z6nwGlLA5Cb
 te0ydtrNqNbETV/eICT3/VwZDKS6qZ6ETk48c2ppq8KalT8XLLAFr5fdXrZ5XhdL96F9
 icPNXSb/FFjtfcfiy9tDN3CLqNXYSVZh4EsYPpC0qJOIgW3cTwCQGJBAk3DHrwy43zlD
 tjBg==
X-Gm-Message-State: AOJu0YzHfGhGW1SWJAuS6w1a1DrrHULzn/+ildfK1IauUY2f2J+JpSWj
 u2XYjohEzxTDu+nTova6uwrwppS8izPC5B67+da1l9Cj2jq1v/4Gfk+DVAWIcIeB3ZKCsjIhrEO
 O9by5jHUIFBBnJDPFwHmuUdonensrStbao71mxDEjqATkgXcIIu+mx2mmF3wOMI7NXR/f
X-Received: by 2002:a7b:ca50:0:b0:406:4e2e:b185 with SMTP id
 m16-20020a7bca50000000b004064e2eb185mr1189802wml.1.1696409044735; 
 Wed, 04 Oct 2023 01:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGThrMz2KW9yXV7KX4Q85BmxCVq61xp9dnuj14hJhL95OxxyWzJT+YAzJNRbKjylWEl/cUtCw==
X-Received: by 2002:a7b:ca50:0:b0:406:4e2e:b185 with SMTP id
 m16-20020a7bca50000000b004064e2eb185mr1189789wml.1.1696409044459; 
 Wed, 04 Oct 2023 01:44:04 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 f2-20020a056000128200b0032196c508e3sm3475193wrx.53.2023.10.04.01.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:03 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 17/63] vdpa: rename vhost_vdpa_net_load to
 vhost_vdpa_net_cvq_load
Message-ID: <b01a3dbd69365441c7006a2da98e82c86fa70c6e.1696408966.git.mst@redhat.com>
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


