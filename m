Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B01A945277
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Aug 2024 20:00:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZa5T-0001lu-IA; Thu, 01 Aug 2024 13:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5Q-0001ex-IN
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5O-0005uU-U8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722535172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zES+mmhVU8SsFPQE0hElHiI8+xOwlfTDlFG7CvA+oM=;
 b=gSWHu7doMCqspORG1eER09poRUhH6UyuRa7nudcliNBScPx6qSALHSIejZSgThd80LFq6r
 XrkDahmmqxI5Byu3KH09hatQNl7NMjDYLVtJQIqUYT8Fql3MUkvqDUPslCyaa1/OSGsxAn
 6XaDI5qzmR/Am2ohHYXDC5oUAH8MCqY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-SMTymVH1Ns21yS_wFyZeFA-1; Thu,
 01 Aug 2024 13:59:31 -0400
X-MC-Unique: SMTymVH1Ns21yS_wFyZeFA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEC1B19560AB; Thu,  1 Aug 2024 17:59:30 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.17])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDD5A195605A; Thu,  1 Aug 2024 17:59:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/6] qapi: cope with  feature names containing a '-'
Date: Thu,  1 Aug 2024 18:59:11 +0100
Message-ID: <20240801175913.669013-5-berrange@redhat.com>
In-Reply-To: <20240801175913.669013-1-berrange@redhat.com>
References: <20240801175913.669013-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When we shortly expose all feature names to code, it will be valid to
include a '-', which must be translated to a '_' for the enum constants.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/gen.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 0ff29dc776..036977d989 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -24,6 +24,7 @@
 )
 
 from .common import (
+    c_enum_const,
     c_fname,
     c_name,
     guardend,
@@ -41,7 +42,7 @@
 
 
 def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
-    features = [f"1u << QAPI_FEATURE_{feat.name.upper()}"
+    features = [f"1u << {c_enum_const('QAPI_FEATURE', feat.name)}"
                 for feat in features if feat.is_special()]
     return ' | '.join(features) or '0'
 
-- 
2.45.2


