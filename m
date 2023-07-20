Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E9075A792
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 09:17:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMNtn-0000tH-4d; Thu, 20 Jul 2023 03:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qMNtZ-0000fX-QJ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qMNtX-0007Uo-0l
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689837374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+zDVhz17FMSRUuB0yJ7Lf1+9BARA57sUzbFm5cNQUk=;
 b=XYcqRa4wJs2nWlrGVEOShXgI4HyYniiXcwSVYYISOnK7N5hCGs3TvgtQd/4blBsXqcs5Je
 AkQpRjPbkHIzG6n/uc6+KPSIMfuflBGLdwvl16ckEPCmvzMAXXD11HcCIa3W++5eslj819
 nAUsns+7dbocYrH+oDNGXBwCFs8mFag=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-U7QH5KG6Mb-zWxjRvawVBA-1; Thu, 20 Jul 2023 03:16:12 -0400
X-MC-Unique: U7QH5KG6Mb-zWxjRvawVBA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C7F42800E81
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 07:16:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2725F492B02
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 07:16:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0FF4E21BA8DD; Thu, 20 Jul 2023 09:16:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com
Subject: [PATCH 5/6] qapi: Correct "eg." to "e.g." in documentation
Date: Thu, 20 Jul 2023 09:16:08 +0200
Message-ID: <20230720071610.1096458-6-armbru@redhat.com>
In-Reply-To: <20230720071610.1096458-1-armbru@redhat.com>
References: <20230720071610.1096458-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/char.json | 2 +-
 qapi/misc.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index e413ac2b70..52aaff25eb 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -18,7 +18,7 @@
 # @filename: the filename of the character device
 #
 # @frontend-open: shows whether the frontend device attached to this
-#     backend (eg. with the chardev=... option) is in open or closed
+#     backend (e.g. with the chardev=... option) is in open or closed
 #     state (since 2.1)
 #
 # Notes: @filename is encoded using the QEMU command line character
diff --git a/qapi/misc.json b/qapi/misc.json
index ff070ec828..cda2effa81 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -18,7 +18,7 @@
 # fail and the FD will be closed.
 #
 # @protocol: protocol name.  Valid names are "vnc", "spice",
-#     "@dbus-display" or the name of a character device (eg. from
+#     "@dbus-display" or the name of a character device (e.g. from
 #     -chardev id=XXXX)
 #
 # @fdname: file descriptor name previously passed via 'getfd' command
-- 
2.41.0


