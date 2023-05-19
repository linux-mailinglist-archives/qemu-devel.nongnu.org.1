Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4088709F38
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 20:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q051U-0001g5-BO; Fri, 19 May 2023 14:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q051Q-0001fp-On
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q051O-0005ms-OY
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684521609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iYItxu7m4awRJ5FFPZ2WrqhKQ6rnduawzAHt+HM9nCE=;
 b=TQONEA7NQFM8DAzo/hUakdzgXZWNj0TpAkjYtseyBaKKMd0wCkaIx87qiKSYlMWv3rjNa9
 YeJ6r7g39U/13TGRln4e/iamVACG2eV5/+CS6NqaDAgSQM7LSgQNPqc5EmtNyIvIUy7puF
 Zo/xRWBZZQy70b/agJdlo+UcrGNspuI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-A-1qaIw3OUC0kl1xhtMmAw-1; Fri, 19 May 2023 14:40:06 -0400
X-MC-Unique: A-1qaIw3OUC0kl1xhtMmAw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-511b509b55bso930744a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 11:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684521605; x=1687113605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iYItxu7m4awRJ5FFPZ2WrqhKQ6rnduawzAHt+HM9nCE=;
 b=WRQwXeHdS8Z5ilp0XZgVXoOWV8YAD/kIxwDNL8n3PjuX4BkfqoLhYyGoRx4VAXEj/m
 DqoV0kgbKNLWgB9R0K8hiaZC8uyVoi4JtkWngRW4LR3EZQr1Ihu0O0HvmFg/ZgBaz9Ow
 oa5DRVtE32u+36+tJRGDYS7ZKOGa0ZQh0dbrstcymzaljB9erCXra2JF2cB8ClIBxQeH
 ZqQ6fEtJ63nQalaunicYMPopNz4A2Ap92Oqr0zzVPo0KztnXtBHp9JTNGLyvF3P49wcr
 14lgucIek4eDaV1UBw6xdPtKjLobmdIszUFOdmJ77QW5SYyQ9PxnYLEFpDXcd2Sl3zFw
 S1jQ==
X-Gm-Message-State: AC+VfDxG65+2EjTQ+rx7g8EFe00LaKwKYzEgDjQ1yITdd03BGaw0WAwE
 Q3wUUxCsV3xdavqm282DTF1JcOQRIZhqS7wqpdfDNZq4BSag8njW52BEbQZrpFX+4uEhj7NUZFG
 KCmhfaMDVCLVouehFDqhcO6U9urQ3XtX9i65BRk5hGHklpc4CInQXNUYi3fopku9+MnWq0xY2dO
 g=
X-Received: by 2002:a05:6402:357:b0:50d:682d:d431 with SMTP id
 r23-20020a056402035700b0050d682dd431mr2625149edw.16.1684521605003; 
 Fri, 19 May 2023 11:40:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7diUBsmeGrtFSYhC7bwr1m5U8rQ2G0puLNH2nBA8s1DTR/PoQo3VWgh3mgCbiWqrHnmjkodQ==
X-Received: by 2002:a05:6402:357:b0:50d:682d:d431 with SMTP id
 r23-20020a056402035700b0050d682dd431mr2625137edw.16.1684521604635; 
 Fri, 19 May 2023 11:40:04 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a056402015300b0050bc5acfcc0sm42906edu.24.2023.05.19.11.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 11:40:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] build: rebuild build.ninja using "meson setup --reconfigure"
Date: Fri, 19 May 2023 20:40:03 +0200
Message-Id: <20230519184003.1185450-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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

Do not use the rule in build.ninja, because the path to meson is hardcoded
in build.ninja and this breaks if meson moves (for example if the distro
meson suddenly becomes too old after an update).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3c7d67142f13..08fb6a3b058a 100644
--- a/Makefile
+++ b/Makefile
@@ -115,15 +115,15 @@ Makefile.ninja: build.ninja
 	  $(NINJA) -t query build.ninja | sed -n '1,/^  input:/d; /^  outputs:/q; s/$$/ \\/p'; \
 	} > $@.tmp && mv $@.tmp $@
 -include Makefile.ninja
+endif
 
+ifneq ($(MESON),)
 # A separate rule is needed for Makefile dependencies to avoid -n
 build.ninja: build.ninja.stamp
 $(build-files):
 build.ninja.stamp: meson.stamp $(build-files)
-	$(NINJA) $(if $V,-v,) build.ninja && touch $@
-endif
+	$(MESON) setup --reconfigure $(SRC_PATH) && touch $@
 
-ifneq ($(MESON),)
 Makefile.mtest: build.ninja scripts/mtest2make.py
 	$(MESON) introspect --targets --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
 -include Makefile.mtest
-- 
2.40.1


