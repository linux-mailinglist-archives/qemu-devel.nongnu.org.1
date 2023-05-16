Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 892D7704B99
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysQf-0004fg-Pb; Tue, 16 May 2023 07:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPN-0001d0-Vw
 for qemu-devel@nongnu.org; Tue, 16 May 2023 07:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPH-0008DL-B1
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJN2jANxJFA4WG6/RjjsAlRU9ohw2knjG165asZhq/Q=;
 b=WyAyLziCkDpnqNuvpVgAuEHykYvY01fExip4gN8ji4hd2gHTEHn3QEav8cLZIow6US4d7v
 DKwKmoD6UCwPdMWurfdtqia7nSfa7KA0BpCDMvjH1hf9xo214DfrafFx6yQnNcx+RVbFuE
 2fqEVpp5ltrx/RDMwqXwyTs4+iJI2w0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-OEWiT50eO6KzTZH1Lc5bDQ-1; Tue, 16 May 2023 06:59:48 -0400
X-MC-Unique: OEWiT50eO6KzTZH1Lc5bDQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 000BA85C06E;
 Tue, 16 May 2023 10:59:47 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF361492B00;
 Tue, 16 May 2023 10:59:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 27/27] python: bump some of the dependencies
Date: Tue, 16 May 2023 12:59:08 +0200
Message-Id: <20230516105908.527838-27-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-1-pbonzini@redhat.com>
References: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The version of pyflakes that is listed in python/tests/minreqs.txt
breaks on Python 3.8 with the following message:

  AttributeError: 'FlakesChecker' object has no attribute 'CONSTANT'

Now that we do not support EOL'd Python versions anymore, we can
update to newer, fixed versions.  It is a good time to do so, before
Python packages start dropping support for Python 3.7 as well!

The new mypy is also a bit smarter about which packages are actually
being used, so remove the now-unnecessary sections from setup.cfg.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-27-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/setup.cfg         | 10 ++--------
 python/tests/minreqs.txt | 14 +++++++-------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/python/setup.cfg b/python/setup.cfg
index 55c0993e70b3..5abb7d30ad42 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -36,11 +36,11 @@ packages =
 devel =
     avocado-framework >= 90.0
     distlib >= 0.3.6
-    flake8 >= 3.6.0
+    flake8 >= 5.0.4
     fusepy >= 2.0.4
     isort >= 5.1.2
     mypy >= 0.780
-    pylint >= 2.8.0
+    pylint >= 2.17.3
     tox >= 3.18.0
     urwid >= 2.1.2
     urwid-readline >= 0.13
@@ -124,12 +124,6 @@ ignore_missing_imports = True
 [mypy-distlib.version]
 ignore_missing_imports = True
 
-[mypy-pip]
-ignore_missing_imports = True
-
-[mypy-pip._vendor]
-ignore_missing_imports = True
-
 [mypy-pip._vendor.distlib]
 ignore_missing_imports = True
 
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 10b181d43a6b..1ce72cef6d80 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -26,23 +26,23 @@ fusepy==2.0.4
 avocado-framework==90.0
 
 # Linters
-flake8==3.6.0
+flake8==5.0.4
 isort==5.1.2
 mypy==0.780
-pylint==2.8.0
+pylint==2.17.3
 
 # Transitive flake8 dependencies
-mccabe==0.6.0
-pycodestyle==2.4.0
-pyflakes==2.0.0
+mccabe==0.7.0
+pycodestyle==2.9.1
+pyflakes==2.5.0
 
 # Transitive mypy dependencies
 mypy-extensions==0.4.3
 typed-ast==1.4.0
-typing-extensions==3.7.4
+typing-extensions==4.5.0
 
 # Transitive pylint dependencies
-astroid==2.5.4
+astroid==2.15.4
 lazy-object-proxy==1.4.0
 toml==0.10.0
 wrapt==1.12.1
-- 
2.40.1


