Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD4706CAE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:27:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ1v-0004Jc-7X; Wed, 17 May 2023 11:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzJ1o-0004IJ-BY
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzJ1l-0000Cx-Lv
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLoxcRGeGs2PLS+wGR+/bUKoIoL3qqDZwVwasugfdPo=;
 b=S3dJGNeJJSLagzChzNZ4mBceHm6ve3ZkuhjsCch/PMUrKhD0V71LmyMISeCf7kEexjO4YH
 Vt6DUCiyNHobeIIp6hIMsS33Cab2Tdi5bbbNrjO5wHg+DL4ypjnihCcd++Np1wfl5VBO72
 MxfB+kNDhGgUKb+be1qMunAQpzhrgss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-6GDMsWJGO4Gy9udRJsCvng-1; Wed, 17 May 2023 11:25:17 -0400
X-MC-Unique: 6GDMsWJGO4Gy9udRJsCvng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E73C185A7A4;
 Wed, 17 May 2023 15:25:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BD214078908;
 Wed, 17 May 2023 15:25:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 275C721E669D; Wed, 17 May 2023 17:25:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 3/5] docs/interop/qmp-spec: Update error description for
 parsing errors
Date: Wed, 17 May 2023 17:25:14 +0200
Message-Id: <20230517152516.1884640-5-armbru@redhat.com>
In-Reply-To: <20230517152516.1884640-1-armbru@redhat.com>
References: <20230517152516.1884640-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The description text for a parsing error has changed since the
spec doc was first written; update the example in the docs.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230515162245.3964307-3-peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/qmp-spec.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/qmp-spec.rst b/docs/interop/qmp-spec.rst
index bfad570a16..2609b3ff9b 100644
--- a/docs/interop/qmp-spec.rst
+++ b/docs/interop/qmp-spec.rst
@@ -307,7 +307,7 @@ This section provides some examples of real QMP usage, in all of them
   .. code-block:: QMP
 
     -> { "execute": }
-    <- { "error": { "class": "GenericError", "desc": "Invalid JSON syntax" } }
+    <- { "error": { "class": "GenericError", "desc": "JSON parse error, expecting value" } }
 
 .. admonition:: Example
 
-- 
2.39.2


