Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6B82C750
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:32:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQ2d-000604-Mx; Fri, 12 Jan 2024 17:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2L-0005no-F2
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:30:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2J-00062n-CG
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705098597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bk+I3aXnUX/x448jt0iNAyjJU4D95UxLeG9v4b4zo9o=;
 b=E5DWuLS0AfJPBo8y6wkdEkBJQKL/VJLkFQVUIX5bO8a/873jLvNVf2ZUKVQ4tySXliz+c+
 3LoNhEjBvEF1j79SVPycW4cq4c2KLzAfmUxHB5+sDDAjzdSjefN5bIEjqX2VWfBu0a2dER
 T9YAtJhP46I+R+EM5bgc2eRnPAtQ3Vs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-EfDH9OANM5aUQtFgutC8RQ-1; Fri,
 12 Jan 2024 17:29:51 -0500
X-MC-Unique: EfDH9OANM5aUQtFgutC8RQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A31253C100BD;
 Fri, 12 Jan 2024 22:29:50 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.17.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 575A7C25AC8;
 Fri, 12 Jan 2024 22:29:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/19] qapi/schema: assert info is present when necessary
Date: Fri, 12 Jan 2024 17:29:38 -0500
Message-ID: <20240112222945.3033854-13-jsnow@redhat.com>
In-Reply-To: <20240112222945.3033854-1-jsnow@redhat.com>
References: <20240112222945.3033854-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
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

QAPISchemaInfo instances are sometimes defined as an Optional
field/argument because built-in definitions don't *have* a source
definition. As a consequence, there are a few places where we need to
assert that it's present because the root entity definition can only
enforce that it is "Optional".

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/qapi/schema.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 43af756ed47..eefa58a798b 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -758,6 +758,7 @@ def describe(self, info):
             else:
                 assert False
 
+        assert info is not None
         if defined_in != info.defn_name:
             return "%s '%s' of %s '%s'" % (role, self.name, meta, defined_in)
         return "%s '%s'" % (role, self.name)
@@ -848,6 +849,7 @@ def __init__(self, name, info, doc, ifcond, features,
         self.coroutine = coroutine
 
     def check(self, schema):
+        assert self.info is not None
         super().check(schema)
         if self._arg_type_name:
             arg_type = schema.resolve_type(
-- 
2.43.0


