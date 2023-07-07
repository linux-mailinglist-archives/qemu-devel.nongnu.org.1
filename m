Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F274AD8B
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:07:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhQn-0003LY-UP; Fri, 07 Jul 2023 05:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQl-0003Ko-IY
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQj-0007LO-JO
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688720829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s2nqPTnByoUXJ2Ayk7layeEfQQVQnjbe1XGBvW+jvSw=;
 b=OF6CjoYk9N0l+yqTPWfK8izNQ01F/zgFwZFNviBIagszpaJBrlJ5nOWmfJ+ikO8qyYm83X
 3I22Uiw8dmRlbc06jw8vjEjdhMNBegTarMcYUKBaFhvcSTnrQaqKcRp13zAGx9Jd/nHeTw
 tYFvy7M4x0TIg6qsInmM78+vvRuphWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-ol6AUobLN-yh_qX3iW1xVA-1; Fri, 07 Jul 2023 05:07:04 -0400
X-MC-Unique: ol6AUobLN-yh_qX3iW1xVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F41E8101A54E;
 Fri,  7 Jul 2023 09:07:03 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB8131121330;
 Fri,  7 Jul 2023 09:07:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 11/15] net: socket: prepare to cleanup net_init_socket()
Date: Fri,  7 Jul 2023 05:06:24 -0400
Message-Id: <20230707090628.2210346-12-jasowang@redhat.com>
In-Reply-To: <20230707090628.2210346-1-jasowang@redhat.com>
References: <20230707090628.2210346-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

Use directly net_socket_fd_init_stream() and net_socket_fd_init_dgram()
when the socket type is already known.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index ba6e5b0..24dcaa5 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -587,7 +587,7 @@ static int net_socket_connect_init(NetClientState *peer,
             break;
         }
     }
-    s = net_socket_fd_init(peer, model, name, fd, connected, NULL, errp);
+    s = net_socket_fd_init_stream(peer, model, name, fd, connected);
     if (!s) {
         return -1;
     }
@@ -629,7 +629,7 @@ static int net_socket_mcast_init(NetClientState *peer,
         return -1;
     }
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, errp);
+    s = net_socket_fd_init_dgram(peer, model, name, fd, 0, NULL, errp);
     if (!s) {
         return -1;
     }
@@ -683,7 +683,7 @@ static int net_socket_udp_init(NetClientState *peer,
     }
     qemu_socket_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, errp);
+    s = net_socket_fd_init_dgram(peer, model, name, fd, 0, NULL, errp);
     if (!s) {
         return -1;
     }
-- 
2.7.4


