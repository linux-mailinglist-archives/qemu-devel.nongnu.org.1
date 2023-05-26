Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC7712A33
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzg-0004F8-Ti; Fri, 26 May 2023 12:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zza-0004BP-38
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2ZzX-0002d6-Fq
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/jNkPoTNc33RHmtgQTu7JrJl3cHFubTvj/jW5MYZE4=;
 b=Lck3IMNh2lkJxfVwDLmYWZmDdXarXKarXllRsqnZ5Kvhpq8Kx0Nta2Z18Vdh9Fi5gGfpOf
 UO7hEf2APhfgyGulwn8Mdq51l5pmqJ2MsXPp/Bzlc4neYuxkH4TNBbt4cIsU3K/D25F5KE
 R6AdUs10flRHfYni625eQPbUlqly+PA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-8Rw9vacfMnCN_wqXd3Qygw-1; Fri, 26 May 2023 12:08:31 -0400
X-MC-Unique: 8Rw9vacfMnCN_wqXd3Qygw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5147e3dfccdso493077a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117310; x=1687709310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/jNkPoTNc33RHmtgQTu7JrJl3cHFubTvj/jW5MYZE4=;
 b=JAMv6y6eKC5PRwRSyvsdJ/SbPyVnSbX00RD2plpXfXvHVykrrbRdx/rUwrxWNd6l4E
 DF0HvwaL7JCvbXeXhFPcXpoH46sxBjCivhDV0vBm8gX9gx0p7DicZS5LfskWKf5/dRvw
 u2yT5vUUeEC8U68wLSliPwcPpbS40VRXSP4hoPDDKFlXekYMGGLydath01P/BkIxv+rc
 wS5yr5EuyF2pteN0HAwXLjAM649cGhTjyT1kDuMStsYGGqv4TeXYdU0L6hXwjOAvjdCU
 gjW/8PRljd2wGR3BJ9+v7GDPttxVzybuqbOt6ehz0LVWUZ24O9QvJAMw/QUgX/mjaVTa
 DgdQ==
X-Gm-Message-State: AC+VfDyN5eAU0dWg/4QQ06ptZcIdZ0oUzrG+Ok69GFP7crDO0NoafuTl
 fBT8qZJ1dpu1+MHFEzZC/Jh2nkywd0dcZu2ojQJgHkjUfFqolfu32W09J3lB1C6oBLECaJIsjTr
 ZlBQeT7KPQ1llUT9HFeWETr3Xz0jZ+S4+K12Fs+zT0P2Z/2+AStB59nE/vPwpg+HP2Zd+aGAL7i
 Y=
X-Received: by 2002:a05:6402:1655:b0:514:75ff:6a86 with SMTP id
 s21-20020a056402165500b0051475ff6a86mr1465963edx.29.1685117310157; 
 Fri, 26 May 2023 09:08:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Y93AtEe6Zw56uSGF4y/k3Cil67bit26uh2XOpvR+f8JtAeJlL1w2HRN8G32ZYe6XeGRmlCA==
X-Received: by 2002:a05:6402:1655:b0:514:75ff:6a86 with SMTP id
 s21-20020a056402165500b0051475ff6a86mr1465950edx.29.1685117309940; 
 Fri, 26 May 2023 09:08:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 g7-20020aa7c847000000b005106975c7a1sm103207edt.23.2023.05.26.09.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 02/12] tests/vm: fix and simplify HOST_ARCH definition
Date: Fri, 26 May 2023 18:08:14 +0200
Message-Id: <20230526160824.655279-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
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


