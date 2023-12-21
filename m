Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9441B81BA07
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 15:58:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKUZ-0005bg-Te; Thu, 21 Dec 2023 09:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGKUX-0005bT-V2
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 09:57:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGKUS-0000MQ-Oj
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 09:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703170652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PnGM5Wb7rrBFn6sw2kitY24V1MnlyeP8A23eyqpjcag=;
 b=eNqMVs3+wux5hWgb1wERvLvCL23THQWsejmbt5taG0AfdaYY6PKOf/o03X/QpxyrtJPKwB
 Lswoun1BlYJJ+4xqoOjY7/mF27apZaaCmPY6wQzXg2Ttday6CwmPV5pyhzQrH697RosKh9
 qRq/fJFdTY4PAw8n0mwT2wlIdNLb6GA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-tvhxFamqM9KI9d4ZqdhzXw-1; Thu, 21 Dec 2023 09:57:28 -0500
X-MC-Unique: tvhxFamqM9KI9d4ZqdhzXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91C2B8B2828;
 Thu, 21 Dec 2023 14:57:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6872A51D5;
 Thu, 21 Dec 2023 14:57:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E02121E6920; Thu, 21 Dec 2023 15:57:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	eblake@redhat.com
Subject: [PATCH] docs/devel/qapi-code-gen: Don't reserve types ending with
 'Kind'
Date: Thu, 21 Dec 2023 15:57:27 +0100
Message-ID: <20231221145727.835905-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We reserved type names ending with 'Kind' because a simple union
'SomeSimpleUnion' generated both a struct type SomeSimpleUnion and an
enum type SomeSimpleUnionKind.  Gone since commit 4e99f4b12c0 (qapi:
Drop simple unions).  The commit neglected to update the documentation
not to reserve type names ending with 'Kind'.  Do that now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 7f78183cd4..972b21a5aa 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -737,9 +737,8 @@ Types, commands, and events share a common namespace.  Therefore,
 generally speaking, type definitions should always use CamelCase for
 user-defined type names, while built-in types are lowercase.
 
-Type names ending with ``Kind`` or ``List`` are reserved for the
-generator, which uses them for implicit union enums and array types,
-respectively.
+Type names ending with ``List`` are reserved for the generator, which
+uses them for array types.
 
 Command names, member names within a type, and feature names should be
 all lower case with words separated by a hyphen.  However, some
-- 
2.43.0


