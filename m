Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1FF7483A3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH18Q-0004qC-M0; Wed, 05 Jul 2023 07:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qH18O-0004pi-Au
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qH18M-0000S3-Gt
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688558241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N++WiWEiQqTpU3n1+BxKbZVdBB7OkN7BfzASnJd2JLE=;
 b=PrgvpxsGffokhRmVDu333VNlLleUc7SBP6+wUAvB8o6o6XD9q82RemED2qVhw8clKPf0Tu
 mc2u3nvHgtyhy5xxX1xoRjW+JiQ36ZPNrV2tZlrI7l1Y+3gNyPQTC6KPyG4WPnL8P4iK2g
 CEwYUNMtBD9X9ZQj2UO8aVYyjfksNHg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-rz1xvdUJOXOcHxjSo5vKbQ-1; Wed, 05 Jul 2023 07:57:20 -0400
X-MC-Unique: rz1xvdUJOXOcHxjSo5vKbQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so373975566b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558238; x=1691150238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N++WiWEiQqTpU3n1+BxKbZVdBB7OkN7BfzASnJd2JLE=;
 b=gzEe4AIUvDMDv3CgcGkwCGaYSFbnasAER4VaJB4ksxyiVucmbEFmP+INySNha3qB4y
 Ov3+EaCDUmh7N853pKn+BJ7tKE9ILw1sCyy40m5gv6kgmKB5TIXba7jrRSiqUGCQ042X
 16lxvJIb66wD2S5XR1prgOhybOdn2uPiLe9pCFO9E6Vi8WZWlBV8BMyYOgE1H+ccnz7p
 uNAsLBvAtFwZYqmn/Fsnq9A7R958bik4Uh9xmImdtozEb0AX2pl/K6gUOSIW2/td/bnG
 aHV/aHa63EBBsITJYLYFB1S2my5x1j5uWsVFkkA8C1G3xVSR0ydYpY91sWoZTPoOE+zB
 Iu1A==
X-Gm-Message-State: ABy/qLbLXlkLUQVnGR0loMdMK/Kqyth09Eb0gaMLfdjGsuJnDuel9CDQ
 yYljCM20x2/rTwuyhzMieUEw22FNfLwzCM67ULpclcuGHLQNTL0o+maEGYK1ti7a3segkWtCiov
 foCh5BixhfJvWM593Q5HVEBIqQakMFrECMOaRNTq5+223fsxEPBl4ELHBKGRLVNBxginAoUlU72
 w=
X-Received: by 2002:a17:906:77d0:b0:993:8d16:4c22 with SMTP id
 m16-20020a17090677d000b009938d164c22mr4150187ejn.75.1688558238482; 
 Wed, 05 Jul 2023 04:57:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH476BvPwt2wjhmUniEzQRsFI1t3gS769nQ8i09INMda9loUdxbM7t4dM/+WOndyh+k7Sb+lQ==
X-Received: by 2002:a17:906:77d0:b0:993:8d16:4c22 with SMTP id
 m16-20020a17090677d000b009938d164c22mr4150167ejn.75.1688558238071; 
 Wed, 05 Jul 2023 04:57:18 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a1709067e5200b00985bdb7dd5fsm14277835ejr.201.2023.07.05.04.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:57:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH v2] python: bump minimum requirements so they are compatible
 with 3.12
Date: Wed,  5 Jul 2023 13:57:16 +0200
Message-ID: <20230705115716.59894-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

There are several Python 3.12 issues in QEMU's python/ directory, but
a particularly problematic one when debugging them is that one cannot
even use minreqs.txt in a Python 3.12 virtual environment to test with
locked package versions.

Bump the mypy and wrapt versions to fix this, while remaining
within the realm of versions compatible with Python 3.7.

This requires a workaround for a mypy false positive

    qemu/qmp/qmp_tui.py:350: error: Non-overlapping equality check (left operand type: "Literal[Runstate.DISCONNECTING]", right operand type: "Literal[Runstate.IDLE]")  [comparison-overlap]

where mypy does not realize that self.disconnect() could change
the value of self.runstate.

The remaining issues are due to missing support for Python 3.12
in released versions of flake8 and pylint, which should be
related to https://github.com/PyCQA/pycodestyle/issues/1145 and
https://github.com/pylint-dev/astroid/issues/2201 respectively.

Supersedes: <20230705112536.54025-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: switch to the python-qemu-qmp fix for the mypy issue,
                which however requires merging the two patches into
                one for bisectability

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


