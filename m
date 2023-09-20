Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C5E7A75DE
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 10:28:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qisXq-0007Aj-8K; Wed, 20 Sep 2023 04:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qisXl-0007Aa-4I
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 04:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qisXj-0006sM-4G
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 04:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695198400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tXrm1mbFex/YRTsO+Qb8vfsMz22Y+qvdWINTU7drBLM=;
 b=DydzQ45cElong10lKau5jytJXz5t7KZ/a7U6P0kT3Sl16uAJPthoUm83KneyWrxQrYtf9k
 83VJCEWCKI4tR8PQV2uQhVKXtIYuI/dkrO9RrpFvqAjI1Mo5+2IP1iA1dndzcOU0bauAlM
 kXr0Qkj2HC6dQWISEO713UmnR+Gzt9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-CkTlIw__Pcqy8d-1Gt06Ig-1; Wed, 20 Sep 2023 04:26:38 -0400
X-MC-Unique: CkTlIw__Pcqy8d-1Gt06Ig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 394E98060C9
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 08:26:38 +0000 (UTC)
Received: from localhost (unknown [10.39.208.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F021A40C2064;
 Wed, 20 Sep 2023 08:26:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ramfb: avoid potential leak
Date: Wed, 20 Sep 2023 12:26:34 +0400
Message-ID: <20230920082634.3349487-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

If the fwcfg is written several times (without surface being displayed
in the meantime), we may leak surfaces.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/ramfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 4cd90a9382..116d674348 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -100,6 +100,7 @@ static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 
     s->width = width;
     s->height = height;
+    g_clear_pointer(&s->ds, qemu_free_displaysurface);
     s->ds = surface;
 }
 
-- 
2.41.0


