Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C0710E23
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:19:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Bkw-0004ZT-N3; Thu, 25 May 2023 10:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkq-0004WS-Tx
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bko-0007Y8-A5
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/jNkPoTNc33RHmtgQTu7JrJl3cHFubTvj/jW5MYZE4=;
 b=G9hzzhuxa1kcaQZvgcefNbbigT8ghbTxJ79h6p3ZMnTajqD+JgI+ridM3dSQd8wpkUmkbP
 z755U8tHokOmKUjA3txV/1Rz+j/JECiya05ydKmYYpH3g2z1n01loSTl4SdETlx8oYIzUB
 OvuzvjtYrGJcedrYdJ1LBFmji5aE5Js=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-tSbud7NnO-KzgkP-zgaWtQ-1; Thu, 25 May 2023 10:15:43 -0400
X-MC-Unique: tSbud7NnO-KzgkP-zgaWtQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f4d917e06so76542966b.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024142; x=1687616142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/jNkPoTNc33RHmtgQTu7JrJl3cHFubTvj/jW5MYZE4=;
 b=jKUxGs+AadICFeywfReP0qan6uIvkoRbSkur6q4Cn5bEK417peg8Zduhp5w7PZRHTo
 0Va1BvGkbNE5evX4ypXEjCp1zKFj6+Aftt1FJnHjtvOxGjZKNR/MYLK3CUpIpj6Xsm5T
 uo63XzAENbQZ+5aa8ZtLMTHkzSOLxGfV7em7BFG9H7M1+QjVL8RI8012jwZ1qia2vybd
 nBA0zx1p8FNqLdTMQA+n7pqk8gqUAx9lk4vZTcU66shghPz3Tn8tF1bv2AfFoEl0yrMw
 Xz94Oizg+zOmUCwQEugrzpZFw39owAvuR385WkuHDhNEP+5Po09Lbn7JCT7ikSVnbKiF
 pFZg==
X-Gm-Message-State: AC+VfDz0Dg2O1abpXtkBLjz4nuyD8r/e91QbCxPG9l1utqQTTgEWyqGk
 OzDWjad9Jmnfliw+HsX27J7Hfu1WlJwqzWcITNfzooyJF0v0wmSWX215kA85o6EA6ocD11svNau
 QpKh6eqiNWZMOE8iXs/nQ11Bt6ME43pj9vmWSB85Q/cB1TOTigZWCU71bjcR9oAQrW82gKcwVY7
 c=
X-Received: by 2002:a05:6402:27d4:b0:50d:56f3:76ed with SMTP id
 c20-20020a05640227d400b0050d56f376edmr2618624ede.11.1685024142480; 
 Thu, 25 May 2023 07:15:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70JKTzCF01ORrMpfMGlS6XP123V5WNV8uCRQsETdS+Thi1N6BFuvGSDcJzZqXr0QOpliq1tA==
X-Received: by 2002:a05:6402:27d4:b0:50d:56f3:76ed with SMTP id
 c20-20020a05640227d400b0050d56f376edmr2618603ede.11.1685024142170; 
 Thu, 25 May 2023 07:15:42 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 d19-20020aa7ce13000000b0050bd4b8ca8fsm589171edv.14.2023.05.25.07.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/20] tests/vm: fix and simplify HOST_ARCH definition
Date: Thu, 25 May 2023 16:15:18 +0200
Message-Id: <20230525141532.295817-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

ARCH is always empty, so just define HOST_ARCH as the result of uname.
The incorrect definition was not being used because the "ifeq" statement
is wrong; replace it with the same idiom based on $(realpath) that the
main Makefile uses.

With this change, vm-build-netbsd in a configured tree will not use
the PYTHONPATH hack.

Reported-by: John Snow <jsnow@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vm/Makefile.include | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 2cc2203d0916..c2a8ca1c175a 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -1,14 +1,12 @@
 # Makefile for VM tests
 
 # Hack to allow running in an unconfigured build tree
-ifeq ($(wildcard $(SRC_PATH)/config-host.mak),)
+ifeq ($(realpath $(SRC_PATH)),$(realpath .))
 VM_PYTHON = PYTHONPATH=$(SRC_PATH)/python /usr/bin/env python3
 VM_VENV =
-HOST_ARCH := $(shell uname -m)
 else
 VM_PYTHON = $(TESTS_PYTHON)
 VM_VENV = check-venv
-HOST_ARCH = $(ARCH)
 endif
 
 .PHONY: vm-build-all vm-clean-all
@@ -23,6 +21,7 @@ ARM64_IMAGES += ubuntu.aarch64 centos.aarch64
 endif
 endif
 
+HOST_ARCH = $(shell uname -m)
 ifeq ($(HOST_ARCH),x86_64)
 IMAGES=$(X86_IMAGES) $(if $(USE_TCG),$(ARM64_IMAGES))
 else ifeq ($(HOST_ARCH),aarch64)
-- 
2.40.1


