Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9783B7E9A5E
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 11:35:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UHB-0004wI-Il; Mon, 13 Nov 2023 05:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2UH9-0004ur-7A
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2UH7-0003qS-Dm
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699871676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+kpVpCpHa96AM9uqfu+PCMuf1A9EuVf8AG3yVlTUWY=;
 b=bp9orFewlGK2aLMjkXR+EVulY94PBIqUroxDhiJGmOkRavthTsmJVZzvFfQRRPCXA5xBuE
 2FUrQZcXZn9gKr+wJtsN08qSCRTlmqoDo/oGfLY7uzJqkTFfc9156x4OrI+SxA1TQBfNup
 hpP0qRuEzFW2nuvo7js47gxtVA8bfEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-u1f52s_RNwCoMan2kVx0nA-1; Mon, 13 Nov 2023 05:34:33 -0500
X-MC-Unique: u1f52s_RNwCoMan2kVx0nA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C12DE867900
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:34:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FDFA2026D4C
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:34:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8082D21E6A28; Mon, 13 Nov 2023 11:34:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 2/3] sphinx/qapidoc: Tidy up pylint warning raise-missing-from
Date: Mon, 13 Nov 2023 11:34:30 +0100
Message-ID: <20231113103431.913394-3-armbru@redhat.com>
In-Reply-To: <20231113103431.913394-1-armbru@redhat.com>
References: <20231113103431.913394-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Pylint advises:

    docs/sphinx/qapidoc.py:518:12: W0707: Consider explicitly re-raising using 'raise ExtensionError(str(err)) from err' (raise-missing-from)

>From its manual:

    Python's exception chaining shows the traceback of the current
    exception, but also of the original exception.  When you raise a
    new exception after another exception was caught it's likely that
    the second exception is a friendly re-wrapping of the first
    exception.  In such cases `raise from` provides a better link
    between the two tracebacks in the final error.

Makes sense, so do it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20231025092159.1782638-2-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 8f3b9997a1..658c288f8f 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -515,7 +515,7 @@ def run(self):
         except QAPIError as err:
             # Launder QAPI parse errors into Sphinx extension errors
             # so they are displayed nicely to the user
-            raise ExtensionError(str(err))
+            raise ExtensionError(str(err)) from err
 
     def do_parse(self, rstlist, node):
         """Parse rST source lines and add them to the specified node
-- 
2.41.0


