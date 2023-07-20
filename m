Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED66175A796
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 09:18:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMNtj-0000my-0j; Thu, 20 Jul 2023 03:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qMNta-0000fY-06
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qMNtY-0007V2-CR
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689837375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XyL8DP+qz5RtdvWmX4o2RvvaG70DKmKG3Lom7YU9HI=;
 b=Aeps8eMT+0i/IGSNvDOBF5qVDXyQ8tmKY8l8NjNDILUB4seDb3ZYrW25SoO2mUcik1ryVp
 aVsv7aPVgFB3GhSaEMQR/mfJGxyBLAeG1Pa6i90gmRp/5wyFV8ES7wp7gTZ1mNFWLwfsMj
 c4vkUrmyaNowwzHFhWDEsIKXLYTSGFo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-gpb3S9-wNzuU9lrlo_EIJw-1; Thu, 20 Jul 2023 03:16:11 -0400
X-MC-Unique: gpb3S9-wNzuU9lrlo_EIJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4063638008B8;
 Thu, 20 Jul 2023 07:16:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 131631121315;
 Thu, 20 Jul 2023 07:16:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0DEF621D0B4E; Thu, 20 Jul 2023 09:16:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/6] qapi/trace: Tidy up trace-event-get-state,
 -set-state documentation
Date: Thu, 20 Jul 2023 09:16:07 +0200
Message-ID: <20230720071610.1096458-5-armbru@redhat.com>
In-Reply-To: <20230720071610.1096458-1-armbru@redhat.com>
References: <20230720071610.1096458-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

trace-event-set-state's explanation of how events are selected is
under "Features".  Doesn't belong there.  Simply delete it, as it
feels redundant with documentation of member @name.

trace-event-get-state's explanation is under "Returns".  Tolerable,
but similarly redundant.  Delete it, too.

Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/trace.json | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/qapi/trace.json b/qapi/trace.json
index 39b752fc88..0819d93016 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -60,9 +60,6 @@
 #
 # Returns: a list of @TraceEventInfo for the matching events
 #
-# An event is returned if its name matches the @name pattern
-# (There are no longer any per-vCPU events).
-#
 # Since: 2.2
 #
 # Example:
@@ -90,10 +87,8 @@
 # @vcpu: The vCPU to act upon (all by default; since 2.7).
 #
 # Features:
-# @deprecated: Member @vcpu is deprecated, and always ignored.
 #
-# An event is enabled if its name matches the @name pattern
-# (There are no longer any per-vCPU events).
+# @deprecated: Member @vcpu is deprecated, and always ignored.
 #
 # Since: 2.2
 #
-- 
2.41.0


