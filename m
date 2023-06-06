Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC38E724633
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:34:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xid-00053K-5b; Tue, 06 Jun 2023 10:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6XiZ-00051l-Jf
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6XiY-0001Do-5P
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJmPl67EZdGS0u4wblM0LBTqwsJ039UKge02/qw8oPk=;
 b=Avws7ktqAZ9nLPLO6kqoN2Zeqa8dFtR6cAA7hM4rCgTGzhONmWQeZWbHH++WCQLVAT/qxi
 QrrgNHNN5i7rA/+f6m8wxxyvSpYIt4ht1QWLZ9ZX1VJwCFkq2NnfkdCo9C0jAd9NfrisOh
 RuQIxYZgDivpH5LPP4LAe5O6QZ7eKPs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-ZyDPOfB3OtCVvf_6ZX2msQ-1; Tue, 06 Jun 2023 10:31:24 -0400
X-MC-Unique: ZyDPOfB3OtCVvf_6ZX2msQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-513f5318ff2so3935482a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061883; x=1688653883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJmPl67EZdGS0u4wblM0LBTqwsJ039UKge02/qw8oPk=;
 b=L+Y/DCvOoPU05LsovYsq3ThSt5rVhHU+1Bjus6+CsSkZ28RVCoTL7JbvyXRuHG+8jE
 Xs/KSTPxZJOcWEn4bdf527UpEbqGzcgc5MKd74+MuJqJ81kXW467WVuHgl6nIPbM7C12
 C+YJbVXwo9emrcAorU2H31BPcYFkdPZpC/Oz1qZQeY7mIBKoyAvDVNsq86pDo4+T9rhl
 mMRmCvra6KF8IMjHeAkr1vOyOFWDJmf6eg+7AwX2vZxR2POr7xILMK4KsLQV1A/SInN2
 HvmN9b6nDZGnNLvZnurb+L9he327Pbaihbc3k7eV922VtpQWmpBZhXZNmPhy3fwZAqXB
 bYJw==
X-Gm-Message-State: AC+VfDwl1UFcc/ltdxmTsPkz6JWxyWdIe2wsJO4Mj5nazeG2okaPMM/l
 DT66jM7SlAL3wn4zW3p+zHWi2gMxwM5yxBA/9awgKVtjDtMSN931GrIJUjyTOCNFTu8MdNdROQM
 rc0Hj9AxgqpTEAcQzCxR18An+5LCHNAHB3weEv5agGAUiWZVMUwYYNDOI5iY+semlqPK5WpF4Si
 w=
X-Received: by 2002:a17:907:7e84:b0:958:4c75:705e with SMTP id
 qb4-20020a1709077e8400b009584c75705emr2400938ejc.17.1686061882692; 
 Tue, 06 Jun 2023 07:31:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KkVBhgBRmp/sPHKTqpUKRw3bdLgcQ73OWon2ve3xC4CIMXg1gMA5ek5tAZpjQ+VV1yPmOog==
X-Received: by 2002:a17:907:7e84:b0:958:4c75:705e with SMTP id
 qb4-20020a1709077e8400b009584c75705emr2400918ejc.17.1686061882320; 
 Tue, 06 Jun 2023 07:31:22 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 lx5-20020a170906af0500b00965c6c63ea3sm5694972ejb.35.2023.06.06.07.31.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/21] scripts: remove dead file
Date: Tue,  6 Jun 2023 16:30:58 +0200
Message-Id: <20230606143116.685644-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
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


