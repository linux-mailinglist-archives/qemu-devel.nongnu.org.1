Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C02DF7B9A46
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFHF-0003rf-Lu; Wed, 04 Oct 2023 23:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHD-0003cf-4C
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHB-0000B2-Om
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAoyD8naooe+1owbsXcnZ1RIo6I7CUVOQ7MqfozanzM=;
 b=bXK64DYztbBQE5l2xIEF5RnRYvk4rm/NyIJTlaTgibWLf+uWZO5smcUlY23K76MNqnngGn
 aMQiPY7DZG7u1RJ6wO9HSC/tckRH5BDimjQdwAFK2AKrcKvyxjQu68czimLnsnkgndX5U1
 YMnckmnVyF8CqICtiLrIMI0Tq3NnqU8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-cJk0YpCzPm-hyxumX4VwPg-1; Wed, 04 Oct 2023 23:43:45 -0400
X-MC-Unique: cJk0YpCzPm-hyxumX4VwPg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so384659f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477423; x=1697082223;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wAoyD8naooe+1owbsXcnZ1RIo6I7CUVOQ7MqfozanzM=;
 b=eYFGGC8lBZvvG75pLJUTPAAjcELKcQzMCYX99NoZikXGmQHVw+0D3f0nOaETB67gW0
 heKF8uA/v9zR+f/uAZXFq/mcJe/Rm9vFASR7e8+CcNCY2xzuQY67ibodl1JJ4xB5itUn
 HY/iuZRA0W8qll1ZwZ0NSWZPpKVMgLJB7RtHBpWl9yI+gtq3u2/ykr9kBmPIYui7lPTz
 BwSTt/YI3ujMftckAwzAUhm/gVI1nkz8b2orvT1v/j72+RfxV8ZnA3fgMf+Gs+EUJjXn
 +0toBPQjeSyG4f8i5NzqJxuex2yzsKvObyVl2lqmAXKwL/8Qbl4iWSEFh9HIXumJmfKB
 IDDg==
X-Gm-Message-State: AOJu0YxkTcmPRqHN8FwwhY5wp6IINPeyMbpNkMOmxTz7MkAtVKsmvlKv
 NbmWmO/UBdcu3Ph6XVS0FYqM81X0kvCxt3Z5ORLhDeEYbE3LoKWw4XOOP/EADuJrEreXgKll8/0
 8DuOUyXYYOc90Ik6JX3ehwBJ/vdXsq88UVl8Rhgy+T++1q3+5O7sths/tpSxRcblSk/vm
X-Received: by 2002:a5d:4f8a:0:b0:31f:84a3:d188 with SMTP id
 d10-20020a5d4f8a000000b0031f84a3d188mr3460430wru.22.1696477423768; 
 Wed, 04 Oct 2023 20:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe+zKbYMQCRSDnlAREDlwnArxQTyu3GCbcxN+JpaJb5CuB+r0K3ujicmcz56cj/r3MRDRQQA==
X-Received: by 2002:a5d:4f8a:0:b0:31f:84a3:d188 with SMTP id
 d10-20020a5d4f8a000000b0031f84a3d188mr3460420wru.22.1696477423461; 
 Wed, 04 Oct 2023 20:43:43 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 q13-20020adffecd000000b003176aa612b1sm632618wrs.38.2023.10.04.20.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:43:42 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:43:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL v2 19/53] vdpa: remove net cvq migration blocker
Message-ID: <f13f5f6412fc51574c961f39dbd625357948282b.1696477105.git.mst@redhat.com>
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


