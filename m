Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C43BA92CB9
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 23:32:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Wpi-0007O5-8E; Thu, 17 Apr 2025 17:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u5WpZ-0007ML-8a
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u5WpX-0000We-Mf
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744925490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2Gd4l5OJt8E6olS/WX2slCeQRVOJ0F0HIGale2vGgE=;
 b=IqKi+PH4rH4TwLN8yKFFc7l8M9bS0DMgPSnjIhWb0dtF0m91RmpJOReN7zgXhRGFK0eTve
 GsoK7BJeGn3A9skfGiPpE658t5zopQOYn63tmu83KrUNeg09f3DbCEm4DvMloODN6c+78e
 ykHBjiDU7raEJJs3w3bIC6aUHZSF0iQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-eBtCv7ShMRCS3mEECNd6pg-1; Thu,
 17 Apr 2025 17:31:27 -0400
X-MC-Unique: eBtCv7ShMRCS3mEECNd6pg-1
X-Mimecast-MFC-AGG-ID: eBtCv7ShMRCS3mEECNd6pg_1744925486
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E8021956088; Thu, 17 Apr 2025 21:31:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.220])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 607421954B0B; Thu, 17 Apr 2025 21:31:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 3/5] python: update missing dependencies from minreqs
Date: Thu, 17 Apr 2025 17:31:12 -0400
Message-ID: <20250417213114.2336239-4-jsnow@redhat.com>
In-Reply-To: <20250417213114.2336239-1-jsnow@redhat.com>
References: <20250417213114.2336239-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

We pin all dependencies for the "check-minreqs" test because pip lacks a
dependency resolver that installs "the oldest possible package that
meets dependency criteria". So, in order to test our stated minimum
requirements, we pin all of our dependencies (and their dependencies,
transitively) at the oldest possible versions that still work and pass
tests; proving that our minimum requirements are correct.

(It also ensures no new features accidentally sneak in from developers
on newer platforms.)

A few transitive dependencies were omitted from the pinned dependency
file by accident; as a result, pip's dependency solver can pull in newer
dependencies, which we don't want. This patch corrects the previous
oversight and pins the missing dependencies.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/tests/minreqs.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index a3f423efd84..19c0f5e4c50 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -38,10 +38,14 @@ pyflakes==2.5.0
 
 # Transitive mypy dependencies
 mypy-extensions==1.0.0
+tomli==1.1.0
 typing-extensions==4.7.1
 
 # Transitive pylint dependencies
 astroid==2.15.4
+dill==0.2
 lazy-object-proxy==1.4.0
+platformdirs==2.2.0
 toml==0.10.0
+tomlkit==0.10.1
 wrapt==1.14.0
-- 
2.48.1


