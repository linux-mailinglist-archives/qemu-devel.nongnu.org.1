Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F68A92CB6
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 23:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WpX-0007LX-2K; Thu, 17 Apr 2025 17:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u5WpT-0007LI-BK
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u5WpR-0000VE-Qe
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744925485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PDfmKs2FRYilFGSf9BHWC+dQMg43pD84g/qhAfepq4=;
 b=FYdHVzQEKOZLvllzxUvhRqNAddZYChRpo1T985230baoFjK+LpWIOtUuXGc/3lidRaHTDW
 QrN7+OS0GSb2BUFaAxFKIy+QHgk4+KxGYZBDtCJ9RueIxiPklrhcqOPAJFBWYvy9uAaVCm
 PEq57IWorNsTKxGzaRIiNkDw8UdbPW0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-s1NSQwqIOhy65IBR7p11wA-1; Thu,
 17 Apr 2025 17:31:21 -0400
X-MC-Unique: s1NSQwqIOhy65IBR7p11wA-1
X-Mimecast-MFC-AGG-ID: s1NSQwqIOhy65IBR7p11wA_1744925480
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 913BE1800368; Thu, 17 Apr 2025 21:31:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.220])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9DC919560A3; Thu, 17 Apr 2025 21:31:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 1/5] qapi: Add some pylint ignores
Date: Thu, 17 Apr 2025 17:31:10 -0400
Message-ID: <20250417213114.2336239-2-jsnow@redhat.com>
In-Reply-To: <20250417213114.2336239-1-jsnow@redhat.com>
References: <20250417213114.2336239-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This restores the linting baseline in QAPI.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/backend.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 14e60aa67af..49ae6ecdd33 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -13,6 +13,7 @@
 
 
 class QAPIBackend(ABC):
+    # pylint: disable=too-few-public-methods
 
     @abstractmethod
     def generate(self,
@@ -36,6 +37,7 @@ def generate(self,
 
 
 class QAPICBackend(QAPIBackend):
+    # pylint: disable=too-few-public-methods
 
     def generate(self,
                  schema: QAPISchema,
-- 
2.48.1


