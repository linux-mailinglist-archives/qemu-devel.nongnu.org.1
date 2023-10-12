Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB27C6C81
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 13:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtdp-0005iG-2F; Thu, 12 Oct 2023 07:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqtdn-0005ha-5T
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqtdl-0002TP-QH
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697109244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=utvRRVUk7SWRLIbeknqP9u5QGLomQ9BK+6bhnUPOdSg=;
 b=A3HC3MZwI31mO+CyEa0FBQHo69cDbJhWmxJWOALvc2enCnc3wN3V//aywK/Jtmrs+G7Fu2
 e7e2h7UVwK2pXA9i7rTiNsQb70ia96N3je64jxMK96gQt7wYzlHTXq3bJh84J17qsYMKIW
 kFx5SzEqjmOBzLBzaQPpnvTt2maWV0M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-IX7uhJBkPsWW7XWwn6Y6Zg-1; Thu, 12 Oct 2023 07:14:03 -0400
X-MC-Unique: IX7uhJBkPsWW7XWwn6Y6Zg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 309C129A9CA5
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 11:14:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 952454619CE;
 Thu, 12 Oct 2023 11:14:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] MAINTAINERS: Add include/sysemu/qtest.h to the qtest section
Date: Thu, 12 Oct 2023 13:14:01 +0200
Message-ID: <20231012111401.871711-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

We already list system/qtest.c in the qtest section, so the
corresponding header file should be listed here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f90c9d814c..bf8ce0e6c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3160,6 +3160,7 @@ M: Laurent Vivier <lvivier@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: system/qtest.c
+F: include/sysemu/qtest.h
 F: accel/qtest/
 F: tests/qtest/
 F: docs/devel/qgraph.rst
-- 
2.41.0


