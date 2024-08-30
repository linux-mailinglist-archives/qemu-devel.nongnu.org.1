Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 144AC966346
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Aug 2024 15:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1t2-0004RP-NX; Fri, 30 Aug 2024 09:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1sv-0003kv-Ot
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1st-0005fx-CL
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mcEgH9LYWJDcmAa9hH6gw18FiSeVNGU6E8/MWL5Wc8U=;
 b=czqUqRPxBXXwBsGQKSXapA0SsIfbCJWiR3iuHgqHbVh2Hkw/6eago4iDdH7ugQVWX7fhsy
 kgXtSAKGRIi8whHL1C7wcfyNyI9W+FVWrP2LofbX6yL0rX5TLHkgGk1PLRCTO+DgH2IjIp
 dJCTt4Max5oY9VP6H3nnSg+E1BKYMIw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-Z8rJm6nLNHaV34tHtutjdA-1; Fri,
 30 Aug 2024 09:41:49 -0400
X-MC-Unique: Z8rJm6nLNHaV34tHtutjdA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AF7119560A2; Fri, 30 Aug 2024 13:41:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88CF4300019C; Fri, 30 Aug 2024 13:41:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 41/44] docs/devel: Split testing docs from the build docs
 and move to separate folder
Date: Fri, 30 Aug 2024 15:38:35 +0200
Message-ID: <20240830133841.142644-42-thuth@redhat.com>
In-Reply-To: <20240830133841.142644-1-thuth@redhat.com>
References: <20240830133841.142644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Building and testing are two separate topics, so let's split the testing
into a separate category and move the related files into a separate folder.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/index-build.rst                      | 14 ++++----------
 docs/devel/index.rst                            |  1 +
 docs/devel/{ => testing}/acpi-bits.rst          |  0
 docs/devel/{ => testing}/ci-definitions.rst.inc |  0
 docs/devel/{ => testing}/ci-jobs.rst.inc        |  0
 docs/devel/{ => testing}/ci-runners.rst.inc     |  0
 docs/devel/{ => testing}/ci.rst                 |  0
 docs/devel/{ => testing}/fuzzing.rst            |  0
 docs/devel/testing/index.rst                    | 14 ++++++++++++++
 docs/devel/{testing.rst => testing/main.rst}    |  0
 docs/devel/{ => testing}/qgraph.rst             |  0
 docs/devel/{ => testing}/qtest.rst              |  0
 12 files changed, 19 insertions(+), 10 deletions(-)
 rename docs/devel/{ => testing}/acpi-bits.rst (100%)
 rename docs/devel/{ => testing}/ci-definitions.rst.inc (100%)
 rename docs/devel/{ => testing}/ci-jobs.rst.inc (100%)
 rename docs/devel/{ => testing}/ci-runners.rst.inc (100%)
 rename docs/devel/{ => testing}/ci.rst (100%)
 rename docs/devel/{ => testing}/fuzzing.rst (100%)
 create mode 100644 docs/devel/testing/index.rst
 rename docs/devel/{testing.rst => testing/main.rst} (100%)
 rename docs/devel/{ => testing}/qgraph.rst (100%)
 rename docs/devel/{ => testing}/qtest.rst (100%)

diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
index 90b406ca0e..0023953be3 100644
--- a/docs/devel/index-build.rst
+++ b/docs/devel/index-build.rst
@@ -1,9 +1,8 @@
-QEMU Build and Test System
---------------------------
+QEMU Build System
+-----------------
 
-Details about how QEMU's build system works and how it is integrated
-into our testing infrastructure. You will need to understand some of
-the basics if you are adding new files and targets to the build.
+Details about how QEMU's build system works. You will need to understand
+some of the basics if you are adding new files and targets to the build.
 
 .. toctree::
    :maxdepth: 3
@@ -11,10 +10,5 @@ the basics if you are adding new files and targets to the build.
    build-system
    kconfig
    docs
-   testing
-   acpi-bits
-   qtest
-   ci
    qapi-code-gen
-   fuzzing
    control-flow-integrity
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index abf60457c2..a53f1bfda5 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -31,6 +31,7 @@ the :ref:`tcg_internals`.
 
    index-process
    index-build
+   testing/index
    index-api
    index-internals
    index-tcg
diff --git a/docs/devel/acpi-bits.rst b/docs/devel/testing/acpi-bits.rst
similarity index 100%
rename from docs/devel/acpi-bits.rst
rename to docs/devel/testing/acpi-bits.rst
diff --git a/docs/devel/ci-definitions.rst.inc b/docs/devel/testing/ci-definitions.rst.inc
similarity index 100%
rename from docs/devel/ci-definitions.rst.inc
rename to docs/devel/testing/ci-definitions.rst.inc
diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
similarity index 100%
rename from docs/devel/ci-jobs.rst.inc
rename to docs/devel/testing/ci-jobs.rst.inc
diff --git a/docs/devel/ci-runners.rst.inc b/docs/devel/testing/ci-runners.rst.inc
similarity index 100%
rename from docs/devel/ci-runners.rst.inc
rename to docs/devel/testing/ci-runners.rst.inc
diff --git a/docs/devel/ci.rst b/docs/devel/testing/ci.rst
similarity index 100%
rename from docs/devel/ci.rst
rename to docs/devel/testing/ci.rst
diff --git a/docs/devel/fuzzing.rst b/docs/devel/testing/fuzzing.rst
similarity index 100%
rename from docs/devel/fuzzing.rst
rename to docs/devel/testing/fuzzing.rst
diff --git a/docs/devel/testing/index.rst b/docs/devel/testing/index.rst
new file mode 100644
index 0000000000..2711fd78b7
--- /dev/null
+++ b/docs/devel/testing/index.rst
@@ -0,0 +1,14 @@
+Testing QEMU
+------------
+
+Details about how to test QEMU and how it is integrated into our CI
+testing infrastructure.
+
+.. toctree::
+   :maxdepth: 3
+
+   main
+   qtest
+   acpi-bits
+   ci
+   fuzzing
diff --git a/docs/devel/testing.rst b/docs/devel/testing/main.rst
similarity index 100%
rename from docs/devel/testing.rst
rename to docs/devel/testing/main.rst
diff --git a/docs/devel/qgraph.rst b/docs/devel/testing/qgraph.rst
similarity index 100%
rename from docs/devel/qgraph.rst
rename to docs/devel/testing/qgraph.rst
diff --git a/docs/devel/qtest.rst b/docs/devel/testing/qtest.rst
similarity index 100%
rename from docs/devel/qtest.rst
rename to docs/devel/testing/qtest.rst
-- 
2.46.0


