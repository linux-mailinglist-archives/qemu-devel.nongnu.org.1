Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 325399A2141
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Oct 2024 13:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Oo9-0006KT-Qm; Thu, 17 Oct 2024 07:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Olx-00040V-QU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Oll-0005v2-6r
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aelJS2m7G93c4Ga4/p+dM5dvctvhteTaVGTvUzDxilY=;
 b=ORpytTTZrqNeGzjXM77Htr7NFGGFtIjgDNdfBVdkYoihhmwSkvRkqkO0IhccFLvxExJntR
 IE8ZWK15E8h0fKvYIz9Sjp8x1Vo1gOEhi6WuGRNfkNE4An0P8ZkcoA2MyNKlUAB6RcRK9O
 uzZdFHmEPKahjonOWKRBlCJLFQbHjCw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-oopPzVstPHaGU4y-Xh8CUA-1; Thu,
 17 Oct 2024 07:34:15 -0400
X-MC-Unique: oopPzVstPHaGU4y-Xh8CUA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AEFB19560B2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:14 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7685D19560A2; Thu, 17 Oct 2024 11:34:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 15/31] qga: adapt to new import path for qobject data type
 headers
Date: Thu, 17 Oct 2024 12:33:27 +0100
Message-ID: <20241017113344.883424-16-berrange@redhat.com>
In-Reply-To: <20241017113344.883424-1-berrange@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/guest-agent-core.h | 2 +-
 qga/main.c             | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index b4e7c52c61..a536d07d0d 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -13,7 +13,7 @@
 #ifndef GUEST_AGENT_CORE_H
 #define GUEST_AGENT_CORE_H
 
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 #include "qga-qapi-types.h"
 
 #define QGA_READ_COUNT_DEFAULT 4096
diff --git a/qga/main.c b/qga/main.c
index 50186760bf..e74c14b3fc 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -19,9 +19,9 @@
 #include <sys/wait.h>
 #endif
 #include "qemu/help-texts.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/json-parser.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
 #include "guest-agent-core.h"
 #include "qga-qapi-init-commands.h"
 #include "qapi/error.h"
-- 
2.46.0


