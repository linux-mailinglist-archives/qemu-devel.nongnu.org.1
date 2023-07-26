Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A36A27634FD
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 13:31:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOchu-000396-BD; Wed, 26 Jul 2023 07:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOchV-00037e-Ee
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 07:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOchT-0003zS-Qt
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 07:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690370940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q6WktvEiBBfPDDRztLga//C6G3FMj55cSqKNFm9CcNc=;
 b=FMw9xy26u2VYpgsNbu+7igvVdvYPnrm7Y1/DKb4iVwZ9pjWDdFQW6NRI/oVv9OJHLHHb8U
 8OKZfMBRsAxhj2+05+kdpUYh6TyMYs8xUimOUim7sWouHDdd1MnfaMtxHsu7BUmu9736Vk
 TyxNlvW6cKUMYNot/axUOBaBYE3YoK0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-E87xwLqkPoWV5iKWw0hykA-1; Wed, 26 Jul 2023 07:28:56 -0400
X-MC-Unique: E87xwLqkPoWV5iKWw0hykA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CCF5867940;
 Wed, 26 Jul 2023 11:28:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BFFB40C2063;
 Wed, 26 Jul 2023 11:28:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F66521E60F4; Wed, 26 Jul 2023 13:28:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/5] qapi/block: Tidy up block-latency-histogram-set
 documentation
Date: Wed, 26 Jul 2023 13:28:52 +0200
Message-ID: <20230726112855.155795-3-armbru@redhat.com>
In-Reply-To: <20230726112855.155795-1-armbru@redhat.com>
References: <20230726112855.155795-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Examples come out like

    Example

       set new histograms for all io types with intervals [0, 10), [10,
       50), [50, 100), [100, +inf):

The sentence "set new histograms ..." starts with a lower case letter.
Capitalize it.  Same for the other examples.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20230720071610.1096458-3-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/block.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 0f25ce3961..535892fddc 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -547,7 +547,7 @@
 #
 # Example:
 #
-# set new histograms for all io types with intervals [0, 10), [10,
+# Set new histograms for all io types with intervals [0, 10), [10,
 # 50), [50, 100), [100, +inf):
 #
 # -> { "execute": "block-latency-histogram-set",
@@ -557,7 +557,7 @@
 #
 # Example:
 #
-# set new histogram only for write, other histograms will remain not
+# Set new histogram only for write, other histograms will remain not
 # changed (or not created):
 #
 # -> { "execute": "block-latency-histogram-set",
@@ -567,7 +567,7 @@
 #
 # Example:
 #
-# set new histograms with the following intervals:   read, flush: [0,
+# Set new histograms with the following intervals:   read, flush: [0,
 # 10), [10, 50), [50, 100), [100, +inf)   write: [0, 1000), [1000,
 # 5000), [5000, +inf)
 #
@@ -579,7 +579,7 @@
 #
 # Example:
 #
-# remove all latency histograms:
+# Remove all latency histograms:
 #
 # -> { "execute": "block-latency-histogram-set",
 #      "arguments": { "id": "drive0" } }
-- 
2.41.0


