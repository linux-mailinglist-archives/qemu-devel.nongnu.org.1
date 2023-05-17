Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C3C707002
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:52:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLF8-00029X-DP; Wed, 17 May 2023 13:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEY-0000Jn-A6
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEW-0004NO-Nj
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJN2jANxJFA4WG6/RjjsAlRU9ohw2knjG165asZhq/Q=;
 b=L7+aquQoJyFaJThQe7m215qtu5keHy/Wl5G8XcvMHh8beqDOZa01oOoNGPRBHwDCAB2k5f
 WHw7zLFKud8ZRLTIlbbnRwmGk9JaECQk82XnARCpY2S13I3OlBb6+6rKfLCIP0jYmnR8Gp
 8BZGmNpRA1/9ywFe13JWytMkh4HSdRo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-t4SnR1jiPFaoFv6F82LmuQ-1; Wed, 17 May 2023 13:46:37 -0400
X-MC-Unique: t4SnR1jiPFaoFv6F82LmuQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30479b764f9so451450f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345595; x=1686937595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJN2jANxJFA4WG6/RjjsAlRU9ohw2knjG165asZhq/Q=;
 b=MyVACe7heE5Wq1ZhULv6Pr2jlBjF03B0m55es8h1FN7GXJjGdUYl9x96KwZNrq7npc
 bhZ5fRO6abKVRvZIcZPaQS2GmtBnl4lgLmVg+ohvXyu/2mjQ/cSlo1ghd5zrHFnT/XQK
 rFJ39joW+0aUtxhRaWubPSvoG1Nn004NpldQT0A4M+lHfrjZ3dUHFmCjfsKrV7H7v+s7
 U29v5Ne8aMhLPQPw7wIPVw853w1KBQogRRrczaB2M2VI5dnlc/DDD/vIO3eg0vbD3p9+
 k/JIXVZIIOTsPmAmudFPiBv9FVQIRPGDqnGmoh7ArkjnWk4d/7JO3Hs8Y7SlO0XRWi0q
 OVTQ==
X-Gm-Message-State: AC+VfDwQaW2LVj8zApmE7oVvQ9936UtfK1xc8OhSt08m6ydyd2o7WaLV
 Cg7Hcw/RDRfvdmR/pDWv76n+ulOz2PC4h78fsjmV2jj9i/j+97sMoENkbZL+IEdmLpxLwmRMXlt
 +eIOSpwac5pcuzCPoRsP50Z20DM71oSedFdzmweyFysU4BNNb3gm11RXXEj+0KfMs60qh2z9qxQ
 g=
X-Received: by 2002:a05:6000:12cc:b0:2fe:6b1e:3818 with SMTP id
 l12-20020a05600012cc00b002fe6b1e3818mr1274583wrx.51.1684345595600; 
 Wed, 17 May 2023 10:46:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ739Ri/uf7NjcD04MzY4r/F7HLDiA40TYeqtd4MxUm+eWe5jUJPiGemAZhAf/8OHf/4x3s3cQ==
X-Received: by 2002:a05:6000:12cc:b0:2fe:6b1e:3818 with SMTP id
 l12-20020a05600012cc00b002fe6b1e3818mr1274573wrx.51.1684345595243; 
 Wed, 17 May 2023 10:46:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d4e82000000b00309257ad16csm3383089wru.29.2023.05.17.10.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 44/68] python: bump some of the dependencies
Date: Wed, 17 May 2023 19:44:56 +0200
Message-Id: <20230517174520.887405-45-pbonzini@redhat.com>
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


