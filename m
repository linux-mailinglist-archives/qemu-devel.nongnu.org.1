Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BA47F77BD
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:26:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2o-0004jC-T0; Fri, 24 Nov 2023 10:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2n-0004ig-6M
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2l-0004Bt-Pb
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzYmqGK1sc5KNjAki6O7HKkHFVFkLf7FyAN6a9MLixs=;
 b=E+oOweEExeBQqIsQAT5aj2+8CpkBd19B5W47HYM3wmxbdJXTc+az0K+nYpCfUgZ/7Q1ZBX
 /klY+XJkwNyRhExGLfunFlOFq3zzbaU4nt6RVHkwRQCS8VSCLrBiG/DsJ3anxP5hwKu/nU
 PIKGOW1k+NKruzFBS4XTu0kqCwSWG0c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-4262gkXENHSeFh-TH8vEmQ-1; Fri, 24 Nov 2023 10:24:34 -0500
X-MC-Unique: 4262gkXENHSeFh-TH8vEmQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4239f75a585so2486861cf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839473; x=1701444273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dzYmqGK1sc5KNjAki6O7HKkHFVFkLf7FyAN6a9MLixs=;
 b=kxC74YaQLSO5AGxFsCD3n7V3KJUz/lnQ2vlSXAhNbQcddnyRGTnpKvEw4xaVN6TMdr
 s8L1XkgT3AQPOpvsmO1ro2VJIZuvkzYfAmNeYMqD73KlA5cViruny8iF4Aw6Jq751BVd
 R4A+4bmZX9LWWJXltjTSgE0/1aKn2dOuHmSiCefdSVP1545Vs6rBrzn5UlUk7wxQNTaK
 1KXf8UWUfPGMOCtwCqbK1O2yqdIquTd7RZdnRuwz6hL+M5jdzfD3o9B9HLFc4oFN9gUs
 /0ZPt5rQfxOIaDb2JFvb2umf8KGCGlTzA0D/cygovm4QGiaTBXhHisxo2VcYDDkZHsPx
 PD1Q==
X-Gm-Message-State: AOJu0YyXaZAt4nai1m0Au9VTT47jzIi/oQdAjY1GFQNcUpH1Yjy3wDlh
 3AFA8IArvrRg4B+tjvtI34SoBCIxOM0laetvtATC3DZtMAI8mIiQrWJbJdvYfE91I0vos1WJzlm
 ecJpHxn0GhEifNxSSxo/nmdc6DnvCYsUDzDvxo1tw6LRwyx8ewIUOFN7VHNVBKrwkBM91glFRjw
 o=
X-Received: by 2002:ac8:7c4e:0:b0:41e:20e8:a279 with SMTP id
 o14-20020ac87c4e000000b0041e20e8a279mr4133051qtv.43.1700839473060; 
 Fri, 24 Nov 2023 07:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUzFcLvxnAdxTV+qjsJzureiJZi9m4cX+dUK6I2jJQDrpmwG4qr+VgkPAqgQh3SIgeOHe9MQ==
X-Received: by 2002:ac8:7c4e:0:b0:41e:20e8:a279 with SMTP id
 o14-20020ac87c4e000000b0041e20e8a279mr4133012qtv.43.1700839472681; 
 Fri, 24 Nov 2023 07:24:32 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 f17-20020ac84651000000b004179e79069asm1329663qto.21.2023.11.24.07.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 09/10] configure: Make only once with pseudo-"in source tree"
 builds
Date: Fri, 24 Nov 2023 16:24:07 +0100
Message-ID: <20231124152408.140936-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
References: <20231124152408.140936-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Pseudo-"in source tree" build used to run make in the build directory
as many times as goals. Worse, although .NOTPARALLEL is specified,
it does not work for patterns, and run make in parallel, which can break
things.

Add a new rule "build", and let it call make. The pattern rule only
needs to specify "build" as its prerequisite and have a no-op recipe so
that it does more than canceling built-in implicit rules.

Fixes: dedad02720 ("configure: add support for pseudo-"in source tree" builds")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20231119101604.47325-1-akihiko.odaki@daynix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 959b1a20c1c..bdda912f362 100755
--- a/configure
+++ b/configure
@@ -41,12 +41,7 @@ then
 # This file is auto-generated by configure to support in-source tree
 # 'make' command invocation
 
-ifeq ($(MAKECMDGOALS),)
-recurse: all
-endif
-
-.NOTPARALLEL: %
-%: force
+build:
 	@echo 'changing dir to build for $(MAKE) "$(MAKECMDGOALS)"...'
 	@$(MAKE) -C build -f Makefile $(MAKECMDGOALS)
 	@if test "$(MAKECMDGOALS)" = "distclean" && \
@@ -54,8 +49,9 @@ endif
 	then \
 	    rm -rf build GNUmakefile ; \
 	fi
-force: ;
-.PHONY: force
+%: build
+	@
+.PHONY: build
 GNUmakefile: ;
 
 EOF
-- 
2.43.0


