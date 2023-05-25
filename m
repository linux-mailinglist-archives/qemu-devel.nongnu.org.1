Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F23710A18
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q28DI-0007lj-Ht; Thu, 25 May 2023 06:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q28DG-0007lH-Jy
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q28DF-0000pf-5j
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685010532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4WhpL759GeQFwOeDPAbLwrIB8McDQfK5U7xw7OO2GI=;
 b=LI9tCszK7neoYw0U5HmDnItLoZft2YEfMLiEgqJhokGg55yzwA068l5hgLxjEWgg4At00z
 ZOeBktdBAEQuTMmKafwqINjzc3tNptdJIZs28STzqTEzarGxYJOXotM90nHONJqb8EWuFC
 WlqwJ4Omh/nO7m2SuNCF6s72QT/zfuU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-ENrImTnEOOKeGNDjfwvVUQ-1; Thu, 25 May 2023 06:28:50 -0400
X-MC-Unique: ENrImTnEOOKeGNDjfwvVUQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96fffd1ba46so46622066b.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685010529; x=1687602529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4WhpL759GeQFwOeDPAbLwrIB8McDQfK5U7xw7OO2GI=;
 b=DiAnIyZFe7kBYk7Mj3b/UrSrW0P8uQTA5vpT7NkhgiEL0D1SlF+FoZYMUAvxfjMOhW
 pNE+/wyxFhiZjLuPNPdxg5zJnO158ih1gENNzIANiTw3OpgL5n2c7jlyBhcpNOqCbpZF
 VwvYXk0ijSpl81feiMqN7PmoMJtc0NSPL19TSbO41LpRCdJlsilOALpnfCD7q54XTKuW
 k21Wpdmk8c8c2OgsAd2xw8vT7N4d+rmWs0s+hPQn6mtjgvsGxCoZQmB2ubhmAC88duoM
 aOFvZn9WWwgsx7PAq25rVl4ro7O5VwcD3weM7bb1afvdgFC3y01siIvQQWQlXNSuLopW
 Ld6Q==
X-Gm-Message-State: AC+VfDzSSdN8KWDSotB1RNXMBYWBCZIH0NkN6spK73NvrMj2mAGo9s4S
 3rlzliQWA1TAkh3r+qHs1jfN4gk9dATQnHIP1UdmleDTWbElIAj+n05L9nBLBk/IFo8tk99cpEM
 HFxdhZLZhC2zAW3TjvcD+OnFFSSHElCBc1ndxFu4OQlaGc16sCGuLNsol9f2X8ZbBK9JFkx2ho+
 w=
X-Received: by 2002:a17:907:3f0a:b0:96a:4ea0:a1ea with SMTP id
 hq10-20020a1709073f0a00b0096a4ea0a1eamr1022302ejc.44.1685010529129; 
 Thu, 25 May 2023 03:28:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LrxSN/mWx31hSkZ8xS6V+RKf9G7wC16Ecz3FJtK7zUZoKf3/tcxAbxj2I5AH8kR7rBxbtkA==
X-Received: by 2002:a17:907:3f0a:b0:96a:4ea0:a1ea with SMTP id
 hq10-20020a1709073f0a00b0096a4ea0a1eamr1022290ejc.44.1685010528852; 
 Thu, 25 May 2023 03:28:48 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 bq13-20020a170906d0cd00b00965c6c63ea3sm661774ejb.35.2023.05.25.03.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 03:28:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	jsnow@redhat.com
Subject: [PATCH 2/3] tests/vm: fix and simplify HOST_ARCH definition
Date: Thu, 25 May 2023 12:28:43 +0200
Message-Id: <20230525102844.209240-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525102844.209240-1-pbonzini@redhat.com>
References: <20230525102844.209240-1-pbonzini@redhat.com>
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


