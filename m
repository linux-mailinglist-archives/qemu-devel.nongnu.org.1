Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2742A7B9A59
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJC-0008HD-3J; Wed, 04 Oct 2023 23:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIF-0007TF-8E
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFID-0000Lu-Nl
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSDvCARja0+YrHJdMmbqGg3nJ8ng+OFiaj4ATw5ERL4=;
 b=BQjenSilsMXUmBb2ikT/kOPiiCRBqqhaQSLjf3qD+7tY/DrD6KjbA9ywG8F1jmn+I2WaUJ
 a0SM/sU4PEK5kPQHDgDzXap4x4L5OlAaj1cm/8t0pXMD3vrINK8nJWAwvSIHRrtkUaC7Z2
 Sg/wb78SrxbLUFaH+9jbGv0pSSJ+dG4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-boHijuZhOnKSov9w2Lp3GQ-1; Wed, 04 Oct 2023 23:44:46 -0400
X-MC-Unique: boHijuZhOnKSov9w2Lp3GQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso410584f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477485; x=1697082285;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSDvCARja0+YrHJdMmbqGg3nJ8ng+OFiaj4ATw5ERL4=;
 b=qbqeMCj7vnSFQHq1dIUwWMisu+MuWoQMWZ2tYzBmET0Q5+2J3wflMKjhGTc3riKvPQ
 O3vgybRV6txinSXNMeoU1CZsJBOQT8kggdm3TCTRqPu2VMFeEUXFECMJIYv2e/8R/cRz
 VF3SbgC7X/bsFlW7vcmGKCbTPfPixc69k8remc3IYrRUElI3mfYLHyOzlo6iy0b7LfVC
 l7CIlzt5XPuydkOUuzw9JsdkITDTUZvTXtz3CfnDLPu/klMmgak+PdrX8zfIhrZ8T25m
 KJLbLsoSlmdnI9lobCLuWAHrVAbWr2xOx5FgbeLdrAFCgT1BFnHHRtlZKgFvfoGS3Och
 qb6A==
X-Gm-Message-State: AOJu0Yy21DGMwhSmRAXjEd3/OhAwdv0zFrr3JKNfnmWQM6DDkxsmbbL2
 FrhK9b4U7eFE+E1gFhDWb5KUCUI2hjb2f0fAT2WR4+KhkNBKn5iI0M/27jBuXjuH0iggkezx5HG
 4LRKlU0EeYgAvxnuaR7+NYLvx9Ikw4n8uKcJcH9t4Kv3zhrNEnu3uo8mE9fZYlMVeFBVz
X-Received: by 2002:a5d:5103:0:b0:319:79bb:980c with SMTP id
 s3-20020a5d5103000000b0031979bb980cmr3762599wrt.64.1696477485325; 
 Wed, 04 Oct 2023 20:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJvz9NZgPoBUDExz/n5jSNKdag2U1gidPBS3CWH3J8gM4OU8SPwNczc9PYwzlnG0FnXPQbKw==
X-Received: by 2002:a5d:5103:0:b0:319:79bb:980c with SMTP id
 s3-20020a5d5103000000b0031979bb980cmr3762585wrt.64.1696477485064; 
 Wed, 04 Oct 2023 20:44:45 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 p1-20020adfce01000000b003258934a4bfsm633570wrn.36.2023.10.04.20.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:44 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 33/53] vdpa: fix gcc cvq_isolated uninitialized variable
 warning
Message-ID: <e77db790d1bdef9370d23a0a9350c084ce45d91d.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

gcc 13.2.1 emits the following warning:

  net/vhost-vdpa.c: In function ‘net_vhost_vdpa_init.constprop’:
  net/vhost-vdpa.c:1394:25: error: ‘cvq_isolated’ may be used uninitialized [-Werror=maybe-uninitialized]
   1394 |         s->cvq_isolated = cvq_isolated;
        |         ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
  net/vhost-vdpa.c:1355:9: note: ‘cvq_isolated’ was declared here
   1355 |     int cvq_isolated;
        |         ^~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cc: Eugenio Pérez <eperezma@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230911215435.4156314-1-stefanha@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 5808d1b60c..94635fcbee 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1425,7 +1425,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     VhostVDPAState *s;
     int ret = 0;
     assert(name);
-    int cvq_isolated;
+    int cvq_isolated = 0;
 
     if (is_datapath) {
         nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device,
-- 
MST


