Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BFC74B2A7
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHm4k-0007BP-QY; Fri, 07 Jul 2023 10:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4h-0007As-AP
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4f-0006MJ-8Y
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688738680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSQvtdibzf8kOI4lB3nUm6N/pn4ErguFNC1K35xxW6Y=;
 b=FWwG7Nvvc3FaPCCOPswYABbI5kFYhj6E64JqoPMMseWjW7ourlnP2j1vIwMleI3bbLnW8t
 DY2zk6OhFiiHbfXcPFT9QVsnQtNADlyg/zylwgzR5GzsVc+QFwCwKgG1C7VB52ojBTMtgS
 zwD5HbdFTaR6NqkJiYObNIjLeXVv4KE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-JqkvLsl_PVmMT9QeLsxo3w-1; Fri, 07 Jul 2023 10:04:38 -0400
X-MC-Unique: JqkvLsl_PVmMT9QeLsxo3w-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb9364b320so1903923e87.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688738676; x=1691330676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSQvtdibzf8kOI4lB3nUm6N/pn4ErguFNC1K35xxW6Y=;
 b=Dn396sAcaCJYgQjPW6OkGJWf9NliFQ8bM0N4/jPE5GLmm49ZNIQu0TFWJi6ZcgcOFj
 Ys5n8DBslGSmLrLONu17tFSd6w3n2N8VOFAC29tKLSGt3jb+ph7GR/GqI6AoMn0sMOeV
 joLJTwYa6jMFL7UakhhIRw+3yHIB5oGxa6lHaRbdjHVbR40yIHpAlXw44S83dTkpafxF
 u4QDm1g4UuNuQZe4c0snwk0ggkemj0rZHFYbE+z+bEyjMUhduVde7j+86beNr/ZULvrH
 HlUZpat5gcYWs1JdITTXIeMwmxJHOY/9ZqaE2sW0feYIiA6zFVyzxqpZh0VvnUN9GrFV
 GPrQ==
X-Gm-Message-State: ABy/qLa6/TGsaWxEX0e8tq0TFWzq56bIU2PzZNGjfLe8ZKKWMsWQHxRm
 GmovZGMhFSbiOfXsLviK+i2FYxBy4YhoYNBZL6DdAUI8LPvaWR+5zwUw+9rpNAmv8CpZWNuDI0L
 3Ohc3uWmNJGGuxBZ0QFcaTCKSmGjDzDOJ5pXi/kRFezrOiCwftVDVVbKDHKfQ2LU+mjVMEsCKSa
 E=
X-Received: by 2002:ac2:4e07:0:b0:4f8:5e49:c613 with SMTP id
 e7-20020ac24e07000000b004f85e49c613mr4674520lfr.43.1688738676415; 
 Fri, 07 Jul 2023 07:04:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHFX36aggTGOMMyhdRuJ5rG+g7DMvDw5O4YTyyl1RQc+swEEMCSeypDCosr50fexKFSp2CriA==
X-Received: by 2002:ac2:4e07:0:b0:4f8:5e49:c613 with SMTP id
 e7-20020ac24e07000000b004f85e49c613mr4674480lfr.43.1688738675865; 
 Fri, 07 Jul 2023 07:04:35 -0700 (PDT)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m11-20020aa7c2cb000000b0051e2a4edfd5sm2086120edp.21.2023.07.07.07.04.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 07:04:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] python: bump minimum requirements so they are compatible
 with 3.12
Date: Fri,  7 Jul 2023 16:04:24 +0200
Message-ID: <20230707140432.88073-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707140432.88073-1-pbonzini@redhat.com>
References: <20230707140432.88073-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There are many Python 3.12 issues right now, but a particularly
problematic one when debugging them is that one cannot even use
minreqs.txt in a Python 3.12 virtual environment to test with
locked package versions.

Bump the mypy and wrapt versions to fix this, while remaining
within the realm of versions compatible with Python 3.7.

This requires a workaround for a mypy false positive

    qemu/qmp/qmp_tui.py:350: error: Non-overlapping equality check (left operand type: "Literal[Runstate.DISCONNECTING]", right operand type: "Literal[Runstate.IDLE]")  [comparison-overlap]

where mypy does not realize that self.disconnect() could change
the value of self.runstate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/qemu/qmp/qmp_tui.py | 5 ++++-
 python/setup.cfg           | 2 +-
 python/tests/minreqs.txt   | 9 ++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 83691447231..2d9ebbd20bc 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -346,7 +346,10 @@ async def manage_connection(self) -> None:
                 self._set_status('[Disconnected]')
                 await self.disconnect()
                 # check if a retry is needed
-                if self.runstate == Runstate.IDLE:
+                # mypy 1.4.0 doesn't believe runstate can change after
+                # disconnect(), hence the cast.
+                state = cast(Runstate, self.runstate)
+                if state == Runstate.IDLE:
                     continue
             await self.runstate_changed()
 
diff --git a/python/setup.cfg b/python/setup.cfg
index 42f0b0be07d..5d7e95f5d24 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -39,7 +39,7 @@ devel =
     flake8 >= 5.0.4
     fusepy >= 2.0.4
     isort >= 5.1.2
-    mypy >= 0.780
+    mypy >= 1.4.0
     pylint >= 2.17.3
     tox >= 3.18.0
     urwid >= 2.1.2
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 1ce72cef6d8..979461be6bb 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -28,7 +28,7 @@ avocado-framework==90.0
 # Linters
 flake8==5.0.4
 isort==5.1.2
-mypy==0.780
+mypy==1.4.0
 pylint==2.17.3
 
 # Transitive flake8 dependencies
@@ -37,12 +37,11 @@ pycodestyle==2.9.1
 pyflakes==2.5.0
 
 # Transitive mypy dependencies
-mypy-extensions==0.4.3
-typed-ast==1.4.0
-typing-extensions==4.5.0
+mypy-extensions==1.0.0
+typing-extensions==4.7.1
 
 # Transitive pylint dependencies
 astroid==2.15.4
 lazy-object-proxy==1.4.0
 toml==0.10.0
-wrapt==1.12.1
+wrapt==1.14.0
-- 
2.41.0


