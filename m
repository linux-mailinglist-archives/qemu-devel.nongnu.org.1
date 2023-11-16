Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C07ED903
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:48:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQP-0005Jp-ON; Wed, 15 Nov 2023 20:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQJ-0005GM-LV
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQE-0001zp-20
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCAXe+RXvP9aNPfdOK7rQogOvX6tsD3P/HmDMl4jIYA=;
 b=IYs3RH8vpnDga1bQ5PUAfy6k2e1zUbtcCZv1z85Fx3eo3W/w7oOGe13cJhV774ejqXUs9e
 lZVo8QXbpEtIJhw1m9wJuLDM2Na7+QayMPsI+mWvRaciw8Nubi037R/ImIRYhsMR5N59ji
 hp39iZTYvorXVwnDf9Y9sOwN+auC98k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-Tvtl6IfANB-HwN9aaIQgtw-1; Wed,
 15 Nov 2023 20:43:54 -0500
X-MC-Unique: Tvtl6IfANB-HwN9aaIQgtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 587A03C11CC1;
 Thu, 16 Nov 2023 01:43:54 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15AD5C15881;
 Thu, 16 Nov 2023 01:43:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 09/19] qapi/schema: assert info is present when necessary
Date: Wed, 15 Nov 2023 20:43:40 -0500
Message-ID: <20231116014350.653792-10-jsnow@redhat.com>
In-Reply-To: <20231116014350.653792-1-jsnow@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

QAPISchemaInfo is sometimes defined as an Optional field because
built-in definitions don't *have* a source definition. As a consequence,
there are a few places where we need to assert that it's present because
the root entity definition only suggests it's "Optional".

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 3308f334872..c9a194103e1 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -733,6 +733,7 @@ def describe(self, info):
             else:
                 assert False
 
+        assert info is not None
         if defined_in != info.defn_name:
             return "%s '%s' of %s '%s'" % (role, self.name, meta, defined_in)
         return "%s '%s'" % (role, self.name)
@@ -823,6 +824,7 @@ def __init__(self, name, info, doc, ifcond, features,
         self.coroutine = coroutine
 
     def check(self, schema):
+        assert self.info is not None
         super().check(schema)
         if self._arg_type_name:
             arg_type = schema.resolve_type(
-- 
2.41.0


