Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C24C870AA98
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 21:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Ruh-0007Fn-Fa; Sat, 20 May 2023 15:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Ruf-0007Ey-Ha
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Ruc-00007X-VB
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684609602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYItxu7m4awRJ5FFPZ2WrqhKQ6rnduawzAHt+HM9nCE=;
 b=C2hPjJXD7QW+Kk97460XE7kO7JBK2X81Qkt7do+AUHRX4/YvXwoRJ7bxRCETjsPvWJ4aJs
 7dnJuof+oBHZIdCPAXN3kzRBmhG0R+V49sEH8xPD1vbPLjL9xDQQ1Snce+x/+4kSWADfZu
 9O6xLT7XnUwBKcV/8YQEf7Hfla7TB+w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-XiE0EcBOM9aGQz4MQHwWsg-1; Sat, 20 May 2023 15:06:41 -0400
X-MC-Unique: XiE0EcBOM9aGQz4MQHwWsg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96f46e5897eso338824766b.3
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 12:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684609599; x=1687201599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYItxu7m4awRJ5FFPZ2WrqhKQ6rnduawzAHt+HM9nCE=;
 b=QWiLn3pPcY3BVCzbtAUOc9lglqgm90uFiL1KMKbTDiJaHVPWaeFRMmdW5uYBUBpfoi
 yoSHyDosA8qI4ajzv81addm4GYQsVvcSRQZFvymk9K+cFgTjkNDhwgrsr3oi1xoZhQkf
 +qHr62Q9zKE8HK4BJRPaoHKdPng0h+kP5dvpqusppHp8Bik+mzN4GrLl9J6rLf5HCKYB
 qX+tLsPo0coDTgppiU/Ju5ySc7l9m0mU3p34ur2s28jCqXnsqDbyK3QCAsGKnl14itDZ
 K0bTQAy9uq9zdD+mgKGvaLSqo6Gum907cpXEV5UjeLQKdztM8+3G7uObfhXkiVgmALoL
 CDWg==
X-Gm-Message-State: AC+VfDzcPqWeMa/+kzcn6Xrte9OtLYzUOZBD51fLtewC0xlkexZCnzSl
 1Az1B1iP+L66XC5Kon2axnxf/uYF2mIWMYKG+yxi1ZntFH9qShh1rv4VgOxw6t19madyRHSkUTw
 umYWTq7CntBzzJiaYLzQb7cK2ydLjaxL+8MHtLRL7oMdhq7KQN2pTT1+uh6tnimBma/rBmiQDkP
 I=
X-Received: by 2002:a17:907:720e:b0:94a:58a5:2300 with SMTP id
 dr14-20020a170907720e00b0094a58a52300mr5897407ejc.27.1684609599413; 
 Sat, 20 May 2023 12:06:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kHcVrELgfH4EGc19JNilexRNP8FfM+hFFkMz6Ez1MZoB0hsufrl2p9wVc84WoKw+LS9OQAg==
X-Received: by 2002:a17:907:720e:b0:94a:58a5:2300 with SMTP id
 dr14-20020a170907720e00b0094a58a52300mr5897389ejc.27.1684609599078; 
 Sat, 20 May 2023 12:06:39 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a1709063e1100b0096f641a4c01sm1066943eji.179.2023.05.20.12.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 12:06:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/7] build: rebuild build.ninja using "meson setup
 --reconfigure"
Date: Sat, 20 May 2023 21:06:28 +0200
Message-Id: <20230520190632.7491-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520190632.7491-1-pbonzini@redhat.com>
References: <20230520190632.7491-1-pbonzini@redhat.com>
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


