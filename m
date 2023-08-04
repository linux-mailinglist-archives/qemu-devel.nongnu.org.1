Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A9176FB46
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 09:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRpLm-0005vw-7k; Fri, 04 Aug 2023 03:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRpLQ-0005rc-U8
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 03:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRpLP-0007FF-7C
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 03:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691134530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+kayrjiyC0ZO4pX9WhMUdrcmgMbn4j6eurZheNyDV1o=;
 b=ULnvCSigMdIA0bTCkIbL4IAgpwiDHsbGvllInxIB2A7pQRbyAOn9VAuzvZVhf1F6rVroHP
 UjaboY4qERAVfzgUEsuYb8K+XArdhYbKmJ2TzzeoDnTX/Gq10jAjzWi9t+MD7L3JcduMdl
 /PdGgup5MEuP5bWnF+DFqxWzwoahFms=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-1eN_yI79PM6DYqARYkrM5A-1; Fri, 04 Aug 2023 03:35:28 -0400
X-MC-Unique: 1eN_yI79PM6DYqARYkrM5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A2AD185A791;
 Fri,  4 Aug 2023 07:35:28 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 354A310E55;
 Fri,  4 Aug 2023 07:35:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH for-8.2] hw/s390x/s390-virtio-ccw: Remove superfluous code to
 set the NIC model
Date: Fri,  4 Aug 2023 09:35:25 +0200
Message-Id: <20230804073525.11857-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

The check for nd->model being NULL was originally required, but in
commit e11f463295d95aba ("s390x/virtio: use qemu_check_nic_model()")
the corresponding code had been replaced by a call to the function
qemu_check_nic_model() - and this in turn calls qemu_find_nic_model()
which contains the same check for nd->model being NULL again. So we
can remove this from the calling site now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4516d73ff5..b83187effb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -222,10 +222,6 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
         NICInfo *nd = &nd_table[i];
         DeviceState *dev;
 
-        if (!nd->model) {
-            nd->model = g_strdup("virtio");
-        }
-
         qemu_check_nic_model(nd, "virtio");
 
         dev = qdev_new(name);
-- 
2.39.3


