Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 734FA848489
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Feb 2024 09:35:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWBTp-0002pf-Dt; Sat, 03 Feb 2024 03:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWBTn-0002p9-Nl
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWBTh-0007IQ-Ur
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706949261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jW8SclU8xjYW+7U3sM/QxsutMrigZVQ0ru9I3/zWcGk=;
 b=OM44AMnnzzsvu5XgwKUEJ9b2hT7O6slL5Bvl2wNrh3w/s3fBjusFEs7ZRF8oaf2gTr3Uae
 s/ySQhgH64wW97gE99QlxgiQWmv7WZE9Za946hF/nFTf+xhjuTK/nGlPYaa3ttzKtjL4r1
 V1G3ni1qE2tZTyye7ETY4yUMjbrF+8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-LW93Ya38MXmibWbCxrXQ3w-1; Sat, 03 Feb 2024 03:34:17 -0500
X-MC-Unique: LW93Ya38MXmibWbCxrXQ3w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4320483B86B;
 Sat,  3 Feb 2024 08:34:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A5C9492BE3;
 Sat,  3 Feb 2024 08:34:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1B9F21E66F2; Sat,  3 Feb 2024 09:34:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 2/5] qapi: Drop redundant documentation of conditional
Date: Sat,  3 Feb 2024 09:34:12 +0100
Message-ID: <20240203083415.2937003-3-armbru@redhat.com>
In-Reply-To: <20240203083415.2937003-1-armbru@redhat.com>
References: <20240203083415.2937003-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Documentation generated for dump-skeys contains

    This command is only supported on s390 architecture.

and

    If
    ~~

    "TARGET_S390X"

The former became redundant in commit 901a34a400a (qapi: add 'If:'
section to generated documentation) added the latter.  Drop the
former.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240129115008.674248-3-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/misc-target.json | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 9195e7d26b..03e83c053f 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -237,8 +237,6 @@
 #
 # @filename: the path to the file to dump to
 #
-# This command is only supported on s390 architecture.
-#
 # Since: 2.5
 #
 # Example:
-- 
2.43.0


