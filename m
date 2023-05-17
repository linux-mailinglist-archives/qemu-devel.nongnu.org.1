Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CCE706FD9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:46:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLE9-0007OH-89; Wed, 17 May 2023 13:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDq-0007JO-RB
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDp-0004Aq-AL
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMI/vELh+V1mQrg7S9f/3I9CjXifMeo4Wxxeeo1ATPw=;
 b=Me6xWzfbuEhL7QOg+MLq/gv9xjTvIJScKbSjz0scZgh5GAjdAHO6fDxTqJ/Cml3ZRRjYcC
 /+0yDOynnUDoRNqowb1voo0KzBALBWxt5yQZPW2je2KXhYbp4QasEiCnEOaSjdzJ9bW3SD
 Vv8hJ7tU5Yk2wT2V59hiy+C0KeQtZ6g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-r12uwnviNr-sAeb2iHso0A-1; Wed, 17 May 2023 13:45:55 -0400
X-MC-Unique: r12uwnviNr-sAeb2iHso0A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f426514683so4393635e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345553; x=1686937553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sMI/vELh+V1mQrg7S9f/3I9CjXifMeo4Wxxeeo1ATPw=;
 b=P4t1wZpoVhIP35bSEkJ7780cefbXy1HLnlk1wOab5g1Y8aU1SZd08ndm5Z0cyuGHmv
 l2RnCVcVjv94kckbtvnEHOPO02Hxfi1UB+ZggZP6KtdvD7U/PykocCASs9xc3N88xFK6
 WusZs+piTnqOfz4xnDpP1VC/oHkDypP4sWiMp9S1x19SBYxZLsRqV8plLjQVvCWF9Yff
 4HNBzCTI8BF88ze35oyK27NPWbSrmDE+4Iit7FO26j7+Eps81cHnT/1ZLIOPzIlcQsLf
 ze4wETOGtt1VKuDmvfFeeqpXwLq6VzR2vChCp1rau2/xkHR/xpDj8ouaMX+uC/rNObDc
 N3Yw==
X-Gm-Message-State: AC+VfDxpPjElR1cneHSEjJxjh07FZ1AYEWrB4wm+GLjMg0Holfay1Asv
 2yYGlLIK1iscvBtbAim/pxfyfr/fzBLuO5vEs0vXRxNHEmYsPGZgD49wkPX6teUIYmW1c6ACo+W
 PWmVaOa26VkQefo+GTA7cTECKg7fnoJdnGhObD725UMAKK8fIZhTEjf3/pz4IK2F+Gy00HNoaI0
 0=
X-Received: by 2002:a5d:6848:0:b0:306:3b5f:45e2 with SMTP id
 o8-20020a5d6848000000b003063b5f45e2mr1119153wrw.69.1684345553222; 
 Wed, 17 May 2023 10:45:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5d8KRZbTqKJ7p7EUnEn0tW3z7+8SP1p82ckwulroLbljSJhDGqdQ7QyeLbMpNStRq0xvwzaQ==
X-Received: by 2002:a5d:6848:0:b0:306:3b5f:45e2 with SMTP id
 o8-20020a5d6848000000b003063b5f45e2mr1119145wrw.69.1684345552885; 
 Wed, 17 May 2023 10:45:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a1c7309000000b003f423cc11e4sm2874756wmb.16.2023.05.17.10.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 18/68] python: shut up "pip install" during "make check-minreqs"
Date: Wed, 17 May 2023 19:44:30 +0200
Message-Id: <20230517174520.887405-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


