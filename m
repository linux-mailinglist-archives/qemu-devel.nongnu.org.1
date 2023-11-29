Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C1C7FE09D
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 20:58:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Qfn-0007Qa-Hr; Wed, 29 Nov 2023 14:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8Qfl-0007Q0-Da
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8Qfk-0004Oq-0R
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701287794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huM4CwyuFE14O20iKZjfHtDOU9jky102zE6IbKmjBhQ=;
 b=DD6XeE3fhPihGLlEhqgvBmq1crNVcvmlhf2yDuBbORA91Ssy5AUjV8QThy55eorRRdGxF8
 oys68WY9X6oubHJqL1JnR8chY+SMH05Sq+qBrPRcWzNGEZXbLbDsc7UHxpK8pR7S+91BAL
 cxRvYCy/HCkFgfKS5cQToIfLUCrDfjU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-YQHcEqJ8MoSrPDOZze2dXg-1; Wed,
 29 Nov 2023 14:56:28 -0500
X-MC-Unique: YQHcEqJ8MoSrPDOZze2dXg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94C14381A90E;
 Wed, 29 Nov 2023 19:56:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEF7B492BE0;
 Wed, 29 Nov 2023 19:56:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 <qemu-block@nongnu.org>, xen-devel@lists.xenproject.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xie Changlong <xiechanglong.d@gmail.com>, Ari Sundholm <ari@tuxera.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Cleber Rosa <crosa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhang Chen <chen.zhang@intel.com>, Peter Xu <peterx@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 10/12] scsi: remove outdated AioContext lock comment
Date: Wed, 29 Nov 2023 14:55:51 -0500
Message-ID: <20231129195553.942921-11-stefanha@redhat.com>
In-Reply-To: <20231129195553.942921-1-stefanha@redhat.com>
References: <20231129195553.942921-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The SCSI subsystem no longer uses the AioContext lock. Request
processing runs exclusively in the BlockBackend's AioContext since
"scsi: only access SCSIDevice->requests from one thread" and hence the
lock is unnecessary.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-disk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index f1bd5f5c6e..ef0d21d737 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -351,7 +351,6 @@ done:
     scsi_req_unref(&r->req);
 }
 
-/* Called with AioContext lock held */
 static void scsi_dma_complete(void *opaque, int ret)
 {
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
-- 
2.42.0


