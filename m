Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC579857DF
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Sep 2024 13:16:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPxn-0002qv-9f; Wed, 25 Sep 2024 07:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPwX-0005yR-6T
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPwV-0003xk-K9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vyo/LNnRGhGjQKrTujAh2NlkCB5//86Ns8KFFI34pWI=;
 b=UnvHQGl6cUnta7lbJ9H36jrEBQg7o0USmKJAuLVHXklGYnhkGRH+tOrYw7EAV84F4yRBEW
 9oiV6gBS0VwV8tUgLznKLeZjN4LrG4CiN8R0tuO8EU6VqH8r2AiSHZpDpoa5z7tco8o7RQ
 S36utVO0nhLEGbccdo+9cKBSED5F7+4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-B50DJvwZMZq296UnqNY2dQ-1; Wed,
 25 Sep 2024 07:12:18 -0400
X-MC-Unique: B50DJvwZMZq296UnqNY2dQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BBFC1977034; Wed, 25 Sep 2024 11:12:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE74A1956094; Wed, 25 Sep 2024 11:12:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 39/44] qobject: remove return after g_assert_not_reached()
Date: Wed, 25 Sep 2024 13:10:20 +0200
Message-ID: <20240925111029.24082-40-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240919044641.386068-32-pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qobject/qnum.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/qobject/qnum.c b/qobject/qnum.c
index 2138b563a9..dd8ea49565 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -86,7 +86,6 @@ bool qnum_get_try_int(const QNum *qn, int64_t *val)
     }
 
     g_assert_not_reached();
-    return false;
 }
 
 /**
@@ -124,7 +123,6 @@ bool qnum_get_try_uint(const QNum *qn, uint64_t *val)
     }
 
     g_assert_not_reached();
-    return false;
 }
 
 /**
@@ -157,7 +155,6 @@ double qnum_get_double(QNum *qn)
     }
 
     g_assert_not_reached();
-    return 0.0;
 }
 
 char *qnum_to_string(QNum *qn)
@@ -173,7 +170,6 @@ char *qnum_to_string(QNum *qn)
     }
 
     g_assert_not_reached();
-    return NULL;
 }
 
 /**
-- 
2.46.0


