Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4DD7B7A6F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUg-0004MQ-Uu; Wed, 04 Oct 2023 04:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUD-0003IC-HM
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUB-00017E-8S
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIDUejF6EpBPfsNHFdD2Xl6gePUB6dtvvan4JQ2+wgc=;
 b=dOMfXi5xH2GwlKz+96EjKS/cHCwhnak8RiotsSUP+F+xwlP5Mgomt2Tn7vklUhEEaxZGkA
 PNGlsJ2pi3l9uYP6gas9rlaR4vZT14RSVwaG0UIXP9WHeajBKnNwlHLVxPGAbeaeu/aazD
 LDZVxnQ8chyh327RUk0wQg2Grw1s5pQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-RuNN1R1aMy6jhzHJ3bUAPg-1; Wed, 04 Oct 2023 04:44:01 -0400
X-MC-Unique: RuNN1R1aMy6jhzHJ3bUAPg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso14727915e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409039; x=1697013839;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CIDUejF6EpBPfsNHFdD2Xl6gePUB6dtvvan4JQ2+wgc=;
 b=R7M1NuGDjMJLPo1QXAOEhdb8oXQE1pbuC6U9ooQDLrT4+M6FVeLhIaMY7f6n/J8Xyg
 xfjbwAz6eTvajEg38w4jcAECISYny9mkiFU5dNJc71KmKuXEvKUfsJyzddRwMl+UDNXI
 xUNOLM2M4UKI2TR2fCefYrqGHSFKpb8HJG60yENKxovCnFOdCGIWVOY7pYZb5YrNQ8d7
 JpkE8IZsGnnmZOIXwR9xER+Nme4wmvBPGSQ+SPfmMsIvZQ4kAkiCH8CRVdxHREU2/grp
 qoHaxouiDJVbsez0nIthKVLHbGAeGH1ZkjP8lLVztpEYrrNwO5x/uTVL7yYfGuoNE1/X
 JDww==
X-Gm-Message-State: AOJu0YwSFWJ6a8uy/HEMzqF++OOqChlEt5+cbZQQRuQ2wwiJ4cg7IyCg
 /Pal2ZAI8z1QMxKH1cWicNUyLFMXnCz1jKPo8lwSE8VYOiKZQQaPnPWNWpwq9z2PNYf9r9VdYWW
 ZfI46/3XGNDUxdgh/zXnXABdXfkbSQhvc9794DRaZqqRyphi99Ok0r32CAckOr/UCLLFf
X-Received: by 2002:a5d:4b48:0:b0:319:7a91:7107 with SMTP id
 w8-20020a5d4b48000000b003197a917107mr1328991wrs.48.1696409039266; 
 Wed, 04 Oct 2023 01:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD7MgbAm4UPUJAr14BC+W0RceW7ndCcAQPzXaWCOJiHWlw0VTKyxSFqr8csCVJt6n57sEAlw==
X-Received: by 2002:a5d:4b48:0:b0:319:7a91:7107 with SMTP id
 w8-20020a5d4b48000000b003197a917107mr1328972wrs.48.1696409038846; 
 Wed, 04 Oct 2023 01:43:58 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 c15-20020a5d63cf000000b003143c9beeaesm3427134wrw.44.2023.10.04.01.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:58 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 15/63] vdpa: use first queue SVQ state for CVQ default
Message-ID: <f28f469914c31eff4c86e019363d1e93421c2ff8.1696408966.git.mst@redhat.com>
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

Previous to this patch the only way CVQ would be shadowed is if it does
support to isolate CVQ group or if all vqs were shadowed from the
beginning.  The second condition was checked at the beginning, and no
more configuration was done.

After this series we need to check if data queues are shadowed because
they are in the middle of the migration.  As checking if they are
shadowed already covers the previous case, let's just mimic it.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20230822085330.3978829-2-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 144b33f997..30dc7e77c9 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -509,7 +509,7 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
 
     s0 = vhost_vdpa_net_first_nc_vdpa(s);
     v->shadow_data = s0->vhost_vdpa.shadow_vqs_enabled;
-    v->shadow_vqs_enabled = s->always_svq;
+    v->shadow_vqs_enabled = s0->vhost_vdpa.shadow_vqs_enabled;
     s->vhost_vdpa.address_space_id = VHOST_VDPA_GUEST_PA_ASID;
 
     if (s->vhost_vdpa.shadow_data) {
-- 
MST


