Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0B79804A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:38:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQQ6-0008U0-3D; Thu, 07 Sep 2023 21:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQQ3-0008Sk-Lx
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPz-0007ti-V3
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694136979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtSjEfAHzdABoPlEeICugrYydeLlInhjYHAqu5v/yu8=;
 b=dOt9gOUtmcjwz4lP10WBHV+rp2byv5pUpWBOEvEEVA/d/XcVnAPtC2SbclhImhOWV9NFTr
 kTgRPF6m4U9azBjgIRoGhQGUcu7AxCerOu+nd4YYDQZ0KO7Ve0Vpnek7hdlrNXmRm2qGXU
 7FwsGfds59JDwMj4VBmgeQhZ2argCnA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-HDzedw99Pm6C-GTspxfQdg-1; Thu, 07 Sep 2023 21:36:15 -0400
X-MC-Unique: HDzedw99Pm6C-GTspxfQdg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5493811728;
 Fri,  8 Sep 2023 01:36:14 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5083040C2070;
 Fri,  8 Sep 2023 01:36:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/13] util/iov: Avoid dynamic stack allocation
Date: Thu,  7 Sep 2023 20:35:42 -0500
Message-ID: <20230908013535.990731-21-eblake@redhat.com>
In-Reply-To: <20230908013535.990731-15-eblake@redhat.com>
References: <20230908013535.990731-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use autofree heap allocation instead of variable-length array on the
stack.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20230824164706.2652277-1-peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 util/iov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/iov.c b/util/iov.c
index 866fb577f30..7e73948f5e3 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -571,7 +571,7 @@ static int sortelem_cmp_src_index(const void *a, const void *b)
  */
 void qemu_iovec_clone(QEMUIOVector *dest, const QEMUIOVector *src, void *buf)
 {
-    IOVectorSortElem sortelems[src->niov];
+    g_autofree IOVectorSortElem *sortelems = g_new(IOVectorSortElem, src->niov);
     void *last_end;
     int i;

-- 
2.41.0


