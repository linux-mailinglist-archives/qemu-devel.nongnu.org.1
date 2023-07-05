Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699E7482E5
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0dp-0000kT-4y; Wed, 05 Jul 2023 07:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qH0dn-0000kC-SD
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qH0dm-00076W-A2
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688556345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fN1gKUVWYzBXCW4iOosyxGBEgv4p6P8Hh+uRtjqvf2I=;
 b=TgCu87yTdwIgWP5Z9YRzw7VEL+MBCqbUS0cyWzFY0vy+TWNJIyPsaNDejs+CLwJQctR5rN
 xywdIH65lC5CEoqyYXZqx+SOL/Tcn0FBX+4IclbJJ/DliEoda0bHO5sCMuB5czZfHCR3N3
 yiODsBhg3ssTwXo8j0uAO/JeNVyAg7A=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-T-C4F44iNBy206WvagFbqw-1; Wed, 05 Jul 2023 07:25:44 -0400
X-MC-Unique: T-C4F44iNBy206WvagFbqw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6997407faso63719511fa.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688556342; x=1691148342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fN1gKUVWYzBXCW4iOosyxGBEgv4p6P8Hh+uRtjqvf2I=;
 b=JrMHHB2O/xN04jZq0y/jFVDpVMd1ZQ4gc/LFclqzhsNBukrM1vZN2+K5AbMtJDCroJ
 33gt2YDNQW5IhSs6FHaFnKXvGYNZWEsfUwXC6DJbVDyvzaAaydULj7yUYI/IZs5xk7Un
 LCT9w2PpjY4S/zGyeXD1zuLMI4C9wnNkL2YEYh2gFbPCXVXGBh/UoFov3c3Wq9UhnIre
 YPvrfhw/1Si8odDoLsJZY4uwLNBSKpSWXWCSnD+qcAv6TLaupzoYwhFUhjdjWWno7rxL
 oLYHbMiL3XOKDkNq8fthJalpTdkjoec+FRfUkvrGno0Ea8VvBj+DGo0mdcHERUZ24oh4
 4dKA==
X-Gm-Message-State: ABy/qLYQXB2yE856gcsP/7URFnmSQKatNKn1wmd6h/+oF0jvqgZaoNKB
 hBAHOWFvNZ0YtZ76k5FNjHHTf24pzUx6mrMzEkFf64Vc6ZCI5veqtbBgVbcXGPh8gMtUhxamSqp
 rzXp3ZZ/1kHnI2szcwCysvS0iU5nB9MFC3iFJ5RmHraLCNItWUGCZuONjlA7IWniUJ6kZ3IerNx
 g=
X-Received: by 2002:a2e:9059:0:b0:2b3:3175:5d46 with SMTP id
 n25-20020a2e9059000000b002b331755d46mr10823498ljg.45.1688556342297; 
 Wed, 05 Jul 2023 04:25:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF6sWqgraO7Gb/e5WyqmwLv9JtvDYIR4+ZIKrNKli+ugYLybneqRT8uCg39GnZEGwe85rtkAw==
X-Received: by 2002:a2e:9059:0:b0:2b3:3175:5d46 with SMTP id
 n25-20020a2e9059000000b002b331755d46mr10823472ljg.45.1688556341903; 
 Wed, 05 Jul 2023 04:25:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 b18-20020aa7d492000000b0051da4b5bc8fsm10113139edr.20.2023.07.05.04.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:25:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 2/2] python: bump minimum requirements so they are compatible
 with 3.12
Date: Wed,  5 Jul 2023 13:25:36 +0200
Message-ID: <20230705112536.54025-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705112536.54025-1-pbonzini@redhat.com>
References: <20230705112536.54025-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/setup.cfg         | 2 +-
 python/tests/minreqs.txt | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

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


