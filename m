Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E90EA5B786
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 04:50:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqbG-0006VH-1Z; Mon, 10 Mar 2025 23:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqZt-0000cq-BS
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqZl-0002qx-Le
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95agMskPgnBc4AkyN44TZ2mvq+7CH/4kl3dTXY02EW8=;
 b=L0jaXlNnFMjlo2UpsphdtvjGhkJAP879trAm7BYccccOhAUTg1gsCik6PYAXsZ8j1yl73F
 WcQBEpuEsleFFu5l1Hru4zjc4NLwSBcGrqjyg5UUocfvA2uVMSZFBGRfar6Dk6V0Ae4UI6
 g3ihVVEBN6CFLcQ6Nu3FrTObpk1QFlw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-TOA9WdDpNxm0xkae3FGA5A-1; Mon,
 10 Mar 2025 23:46:36 -0400
X-MC-Unique: TOA9WdDpNxm0xkae3FGA5A-1
X-Mimecast-MFC-AGG-ID: TOA9WdDpNxm0xkae3FGA5A_1741664796
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2EB8195608B; Tue, 11 Mar 2025 03:46:35 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 398271800366; Tue, 11 Mar 2025 03:46:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 60/63] docs: disambiguate cross-references
Date: Mon, 10 Mar 2025 23:42:58 -0400
Message-ID: <20250311034303.75779-61-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

The next patch will engage the qapidoc transmogrifier, which creates a
lot of cross-reference targets. Some of the existing targets
("migration", "qom", "replay") will become ambiguous as a result. Nail
them down more explicitly to prevent ambiguous cross-reference warnings.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/codebase.rst |  6 +++---
 docs/glossary.rst       | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 4039875ee04..1b09953197b 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -23,7 +23,7 @@ Some of the main QEMU subsystems are:
 - `Devices<device-emulation>` & Board models
 - `Documentation <documentation-root>`
 - `GDB support<GDB usage>`
-- `Migration<migration>`
+- :ref:`Migration<migration>`
 - `Monitor<QEMU monitor>`
 - :ref:`QOM (QEMU Object Model)<qom>`
 - `System mode<System emulation>`
@@ -112,7 +112,7 @@ yet, so sometimes the source code is all you have.
 * `libdecnumber <https://gitlab.com/qemu-project/qemu/-/tree/master/libdecnumber>`_:
   Import of gcc library, used to implement decimal number arithmetic.
 * `migration <https://gitlab.com/qemu-project/qemu/-/tree/master/migration>`__:
-  `Migration framework <migration>`.
+  :ref:`Migration framework <migration>`.
 * `monitor <https://gitlab.com/qemu-project/qemu/-/tree/master/monitor>`_:
   `Monitor <QEMU monitor>` implementation (HMP & QMP).
 * `nbd <https://gitlab.com/qemu-project/qemu/-/tree/master/nbd>`_:
@@ -193,7 +193,7 @@ yet, so sometimes the source code is all you have.
   - `lcitool <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/lcitool>`_:
     Generate dockerfiles for CI containers.
   - `migration <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/migration>`_:
-    Test scripts and data for `Migration framework <migration>`.
+    Test scripts and data for :ref:`Migration framework <migration>`.
   - `multiboot <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/multiboot>`_:
     Test multiboot functionality for x86_64/i386.
   - `qapi-schema <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qapi-schema>`_:
diff --git a/docs/glossary.rst b/docs/glossary.rst
index 693d9855dd1..4fa044bfb6e 100644
--- a/docs/glossary.rst
+++ b/docs/glossary.rst
@@ -120,7 +120,7 @@ Migration
 ---------
 
 QEMU can save and restore the execution of a virtual machine between different
-host systems. This is provided by the `Migration framework<migration>`.
+host systems. This is provided by the :ref:`Migration framework<migration>`.
 
 NBD
 ---
@@ -212,14 +212,14 @@ machine emulator and virtualizer.
 QOM
 ---
 
-`QEMU Object Model <qom>` is an object oriented API used to define various
-devices and hardware in the QEMU codebase.
+:ref:`QEMU Object Model <qom>` is an object oriented API used to define
+various devices and hardware in the QEMU codebase.
 
 Record/replay
 -------------
 
-`Record/replay <replay>` is a feature of QEMU allowing to have a deterministic
-and reproducible execution of a virtual machine.
+:ref:`Record/replay <replay>` is a feature of QEMU allowing to have a
+deterministic and reproducible execution of a virtual machine.
 
 Rust
 ----
-- 
2.48.1


