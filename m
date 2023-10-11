Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1540F7C56A9
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa4v-00021M-JP; Wed, 11 Oct 2023 10:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qqa4s-00020Z-0c
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qqa4q-0001qf-GW
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LKaaY57fds3Y07ZNi/dKzUJV4s8++5LVgW/lbvyd/8=;
 b=bMNRtJ8vHvDsWSpt2m85dMKsDNAUf3C8eIBakBtR8taWdje6MIUhSMn4Rq9WqRV9opMF0R
 hnboZDCK+6q7Dg5SkWpRmdxTw523BYc7XUHFG09jR6kqUT0CW1trC1ge+DMdSXkzyd9fUg
 o4pPM62344w+3cBMInJqrLTeUWTgZAE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-8xN5wbDZMhyFwl6dF7Mn-A-1; Wed, 11 Oct 2023 10:20:35 -0400
X-MC-Unique: 8xN5wbDZMhyFwl6dF7Mn-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED69C3C0CF1C;
 Wed, 11 Oct 2023 14:20:34 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C2EE111CD23;
 Wed, 11 Oct 2023 14:20:34 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/3] qapi: qga: Clarify when out-data and err-data are populated
Date: Wed, 11 Oct 2023 17:20:30 +0300
Message-ID: <20231011142030.112018-4-kkostiuk@redhat.com>
In-Reply-To: <20231011142030.112018-1-kkostiuk@redhat.com>
References: <20231011142030.112018-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

From: Daniel Xu <dxu@dxuuu.xyz>

If output is being captured for a guest-exec invocation, the out-data
and err-data fields of guest-exec-status are only populated after the
process is reaped. This is somewhat counter intuitive and too late to
change. Thus, it would be good to document the behavior.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/qapi-schema.json | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b720dd4379..876e2a8ea8 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1220,11 +1220,13 @@
 # @signal: signal number (linux) or unhandled exception code (windows)
 #     if the process was abnormally terminated.
 #
-# @out-data: base64-encoded stdout of the process
+# @out-data: base64-encoded stdout of the process. This field will only
+#     be populated after the process exits.
 #
-# @err-data: base64-encoded stderr of the process Note: @out-data and
+# @err-data: base64-encoded stderr of the process. Note: @out-data and
 #     @err-data are present only if 'capture-output' was specified for
-#     'guest-exec'
+#     'guest-exec'. This field will only be populated after the process
+#     exits.
 #
 # @out-truncated: true if stdout was not fully captured due to size
 #     limitation.
-- 
2.42.0


