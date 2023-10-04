Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 172C17B7A93
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxYN-0003u2-J5; Wed, 04 Oct 2023 04:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVl-00085X-Bs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVh-0002I5-Bi
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSDvCARja0+YrHJdMmbqGg3nJ8ng+OFiaj4ATw5ERL4=;
 b=b1Gx+kJlviIJ1mwnLUzNoh2MpszrDzZhDTYxme/RySgC0vdCWE8kH0/owjLsXdkNcM/WfP
 qlBEyX2yg7wN6jFL0+o4qXe9mUa7Y2yF7BRspPs15XMQE2eddjObX3Im3+tPHC8NCIvknB
 r+JchFYnvbedCD+hP6CLHW7DtiB9RDY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Phq1RU76MOmLnZgreWb2aw-1; Wed, 04 Oct 2023 04:45:34 -0400
X-MC-Unique: Phq1RU76MOmLnZgreWb2aw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5056cc81e30so1742884e87.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409133; x=1697013933;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSDvCARja0+YrHJdMmbqGg3nJ8ng+OFiaj4ATw5ERL4=;
 b=oHT+amR6HmgxOQVNRiESvAia8mkDW19Q11FAzxP8LSuQVN4cjhZ4brXrTRVEkFD+AM
 rw200UYYSTiIHf8o8EIjItDwuRUulGlRhJB1cdkSNt9edY0rfqQ4Cwj3YsR3YFUU1LY5
 aBSBlR1nDcdedObWchH+vhD5OJvdkeWLT1uK6abiXa2s0CRoeaQKfOw/2fym6xYYkEMO
 GfAEeCknKUKdacOLHWtLBQu2ksJR08kySDDXqVIqf1cwcJFwMpO3OeBNeCX6MVZn6Yfk
 0+nGS+nyaII3wFTEctKO6P2fRJlHMOCgTtiCuVJsD8l76WLZONHhB8pNyXao9s+Mgtw3
 V+Xg==
X-Gm-Message-State: AOJu0YzHDYm2zKnmnjuPTIlEirgPjSei2z183qLIzEOnCwmcOyt67klj
 6phPati8mFnhcR7cxT2Duw8sUFBf1IG6/ty8aLhmeIRMkK89sTrZMItc1Dv1Q/bR7u+2gVXtVSo
 emihusl7qBY7Q6jykFnQTgio1YtRSnr1tqWv1PqE0Gs08z7HIv9+TJH9WYHeUp354riKR
X-Received: by 2002:a19:7906:0:b0:503:3cc:cd39 with SMTP id
 u6-20020a197906000000b0050303cccd39mr1075593lfc.8.1696409132982; 
 Wed, 04 Oct 2023 01:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbAqH1VOkIlBHX+HTDG+knirCvDUU6P2LV2+j8cVQckmSeNOhfuLjbXyYjWUZqubNmQEOAhg==
X-Received: by 2002:a19:7906:0:b0:503:3cc:cd39 with SMTP id
 u6-20020a197906000000b0050303cccd39mr1075580lfc.8.1696409132549; 
 Wed, 04 Oct 2023 01:45:32 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 h5-20020adffa85000000b00327bf4f2f14sm3481939wrr.88.2023.10.04.01.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:31 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/63] vdpa: fix gcc cvq_isolated uninitialized variable warning
Message-ID: <e57765e83e309e24cecbfe983f733218c048a89d.1696408966.git.mst@redhat.com>
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


