Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 936EC72133B
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 23:45:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Z2W-0007u4-S2; Sat, 03 Jun 2023 17:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q5Z2N-0007tH-Bx
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 17:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q5Z2K-0003M3-Vy
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 17:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685828627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bJmPl67EZdGS0u4wblM0LBTqwsJ039UKge02/qw8oPk=;
 b=R3mtPLWJO2cysDOqhvMYTjuKVBRmWBJevlqADGbMRwOF5JBDQ87H3/2gEVU6u4gOUqgYVv
 RIWdpmil9wWVelDMvYcqbEBY49PGXOEDNAjVX47ErJInc8IZtKHoUslQdqrZcVCUUD85Tn
 fJ/GSo07c6mUhF4ubHcqHRH/zIOWQKQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-_D2uYL9DOiy71gVHM54NQA-1; Sat, 03 Jun 2023 17:43:46 -0400
X-MC-Unique: _D2uYL9DOiy71gVHM54NQA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-97463348446so147751866b.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 14:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685828624; x=1688420624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bJmPl67EZdGS0u4wblM0LBTqwsJ039UKge02/qw8oPk=;
 b=cZoEZVMlQXawTtAWVe1NwOzS4OvshhqqFpmWUVB/sJk2coV3KzaWWudPw0w0mT81t/
 ba4RIuWkwjh7hgEI9LQ0A2yGCLp+quFzdEqe0ZP5RhXa4UJ8TtgCMK/on1khqKQUiVr0
 isAAeMZeK1bUBar4GzfSdTRwZdNxVNiFsnOhEA1+S0kpRftJaxEfcbTazfbA/9Mj+k1z
 GNMsOpAYNC8/PZWqXKVU1TPpttoxXfcajzFTZKVZr4ySsDwW5jwLibu6hbwElvVzwBxa
 w4BrVC5MUTBcd3LIrDex6mleTdzxOzsjStyvqp6TbDoQk6ubgKE96CM0x5+JCy7lUjVY
 bcrw==
X-Gm-Message-State: AC+VfDxJTyFwRfAyRgajFCz9ScHja4ERN8Lmz7Jlx+XP83/iDV4I3TZC
 xx2S6i4BFVJ9HPOli1JLNYlNFqje5mfKIVIKmSopwMAiziw1VfCdHrD+6sl7Y9Z5HzUwoRYewZZ
 NP7ZqjlWJc73c73yz4925lOMdyRVcugEPtAAg9YfRvlPScc2COGk3gI2nIfOP6cX7/4x/8A7Goi
 o=
X-Received: by 2002:a17:907:6095:b0:95e:d74b:d171 with SMTP id
 ht21-20020a170907609500b0095ed74bd171mr2825089ejc.28.1685828624727; 
 Sat, 03 Jun 2023 14:43:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nj2wF1pRbNmggTBVbAdapNBWul6H40PhoJC+CCAQBWM3+K1Mzba4qB++RyOh5W0yvGo8VbQ==
X-Received: by 2002:a17:907:6095:b0:95e:d74b:d171 with SMTP id
 ht21-20020a170907609500b0095ed74bd171mr2825070ejc.28.1685828624304; 
 Sat, 03 Jun 2023 14:43:44 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170906261500b00977cad140a8sm561250ejc.218.2023.06.03.14.43.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 14:43:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts: remove dead file
Date: Sat,  3 Jun 2023 23:43:42 +0200
Message-Id: <20230603214342.471752-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.157,
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

scripts/test-driver.py was used when "make check" was already using meson
introspection data, but it did not execute "meson test".  It is dead since
commit 3d2f73ef75e ("build: use "meson test" as the test harness", 2021-12-23).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/test-driver.py | 35 -----------------------------------
 1 file changed, 35 deletions(-)
 delete mode 100644 scripts/test-driver.py

diff --git a/scripts/test-driver.py b/scripts/test-driver.py
deleted file mode 100644
index eef74b29a8f..00000000000
--- a/scripts/test-driver.py
+++ /dev/null
@@ -1,35 +0,0 @@
-#! /usr/bin/env python3
-
-# Wrapper for tests that hides the output if they succeed.
-# Used by "make check"
-#
-# Copyright (C) 2020 Red Hat, Inc.
-#
-# Author: Paolo Bonzini <pbonzini@redhat.com>
-
-import subprocess
-import sys
-import os
-import argparse
-
-parser = argparse.ArgumentParser(description='Test driver for QEMU')
-parser.add_argument('-C', metavar='DIR', dest='dir', default='.',
-                    help='change to DIR before doing anything else')
-parser.add_argument('-v', '--verbose', dest='verbose', action='store_true',
-                    help='be more verbose')
-parser.add_argument('test_args', nargs=argparse.REMAINDER)
-
-args = parser.parse_args()
-os.chdir(args.dir)
-
-test_args = args.test_args
-if test_args[0] == '--':
-    test_args = test_args[1:]
-
-if args.verbose:
-    result = subprocess.run(test_args, stdout=None, stderr=None)
-else:
-    result = subprocess.run(test_args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
-    if result.returncode:
-        sys.stdout.buffer.write(result.stdout)
-sys.exit(result.returncode)
-- 
2.40.1


