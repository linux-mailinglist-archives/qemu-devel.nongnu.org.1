Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0AA87D036
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Mar 2024 16:25:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9P6-0007kM-LC; Fri, 15 Mar 2024 11:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9P3-0007ij-8h
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9On-0001zg-IY
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99xpQP3dRXGRzaZ4BSuLJQSah/GSEKGmhJqf2/Q2Rrs=;
 b=EDh+3++b413tQ+wsEb5AGA76cADk7nU+8SOOnDeSoiHibZlfJdVvYUQkYMteb1F8TfJRHT
 5dGnln/dEa3J8DfHZGcL8od8qOl2RmI/IFYEKbrg3Ixdithj016rY573sBHVPOerZWIbAT
 WoKzXpNZvkYZkksiwgq+LIRYUR/6jVs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-Y1tilC4XO6697LypnGE2wg-1; Fri,
 15 Mar 2024 11:23:06 -0400
X-MC-Unique: Y1tilC4XO6697LypnGE2wg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41E4C1C00D2A;
 Fri, 15 Mar 2024 15:23:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21E042166AE5;
 Fri, 15 Mar 2024 15:23:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1FDF21E6827; Fri, 15 Mar 2024 16:23:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 11/25] qapi/schema: assert resolve_type has 'info' and
 'what' args on error
Date: Fri, 15 Mar 2024 16:22:47 +0100
Message-ID: <20240315152301.3621858-12-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-1-armbru@redhat.com>
References: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: John Snow <jsnow@redhat.com>

resolve_type() is generally used to resolve configuration-provided type
names into type objects, and generally requires valid 'info' and 'what'
parameters.

In some cases, such as with QAPISchemaArrayType.check(), resolve_type
may be used to resolve built-in types and as such will not have an
'info' argument, but also must not fail in this scenario.

Use an assertion to sate mypy that we will indeed have 'info' and 'what'
parameters for the error pathway in resolve_type.

Note: there are only three callsites to resolve_type at present where
"info" is perceived by mypy to be possibly None:

    1) QAPISchemaArrayType.check()
    2) QAPISchemaObjectTypeMember.check()
    3) QAPISchemaEvent.check()

    Of those three, only the first actually ever passes None; the other two
    are limited by their base class initializers which accept info=None, but
    neither subclass actually use a None value in practice, currently.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 1034825415..0ef9b3398a 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -996,6 +996,7 @@ def lookup_type(self, name):
     def resolve_type(self, name, info, what):
         typ = self.lookup_type(name)
         if not typ:
+            assert info and what  # built-in types must not fail lookup
             if callable(what):
                 what = what(info)
             raise QAPISemError(
-- 
2.44.0


