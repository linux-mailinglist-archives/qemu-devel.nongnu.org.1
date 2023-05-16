Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F2704B47
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:00:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysP9-0001Ps-Bg; Tue, 16 May 2023 06:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP6-0001Iz-7u
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysOi-00084U-BA
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sMI/vELh+V1mQrg7S9f/3I9CjXifMeo4Wxxeeo1ATPw=;
 b=V1ss2/4kgzN7fdsU/MhTU3WI7okxkefMyHeHZoXujoj24me6/nxfnJ1EeFWlbJyTbmGjXq
 KUGsUgfljGbCfJzUWZrLLZv8Tcl8iYa6rViV2cNKZtxS58uyzcD41tCsX1sI5MKAMPd+gd
 7tAiBIQPHY4eTXgz6ouVzaJsjySPDPc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-ISI50yhJOi-nSFf_aE93Vg-1; Tue, 16 May 2023 06:59:11 -0400
X-MC-Unique: ISI50yhJOi-nSFf_aE93Vg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB6DE3C0F371;
 Tue, 16 May 2023 10:59:10 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1601B492B00;
 Tue, 16 May 2023 10:59:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 01/27] python: shut up "pip install" during "make
 check-minreqs"
Date: Tue, 16 May 2023 12:58:42 +0200
Message-Id: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

"make check-minreqs" runs pip without the --disable-pip-version-check
option, which causes the obnoxious "A new release of pip available"
message.

Recent versions of pip also complain that some of the dependencies in
our virtual environment rely on "setup.py install" instead of providing
a pyproject.toml file; apparently it is deprecated to install them
directly from pip instead of letting the "wheel" package take care
of them.  So, install "wheel" in the virtual environment.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-2-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/python/Makefile b/python/Makefile
index c5bd6ff83ac9..47560657d27e 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -54,6 +54,7 @@ pipenv check-pipenv:
 	@echo "pipenv was dropped; try 'make check-minreqs' or 'make min-venv'"
 	@exit 1
 
+PIP_INSTALL = pip install --disable-pip-version-check
 .PHONY: min-venv
 min-venv: $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate
 $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.txt
@@ -62,10 +63,12 @@ $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.tx
 	@(								\
 		echo "ACTIVATE $(QEMU_MINVENV_DIR)";			\
 		. $(QEMU_MINVENV_DIR)/bin/activate;			\
+		echo "INSTALL wheel $(QEMU_MINVENV_DIR)";               \
+		$(PIP_INSTALL) wheel 1>/dev/null;		               \
 		echo "INSTALL -r tests/minreqs.txt $(QEMU_MINVENV_DIR)";\
-		pip install -r tests/minreqs.txt 1>/dev/null;		\
+		$(PIP_INSTALL) -r tests/minreqs.txt 1>/dev/null;	\
 		echo "INSTALL -e qemu $(QEMU_MINVENV_DIR)";		\
-		pip install -e . 1>/dev/null;				\
+		$(PIP_INSTALL) -e . 1>/dev/null;			\
 	)
 	@touch $(QEMU_MINVENV_DIR)
 
@@ -100,7 +103,7 @@ check-dev: dev-venv
 
 .PHONY: develop
 develop:
-	pip3 install --disable-pip-version-check -e .[devel]
+	$(PIP_INSTALL) -e .[devel]
 
 .PHONY: check
 check:
-- 
2.40.1



