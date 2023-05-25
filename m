Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0B710A15
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:30:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q28DH-0007lU-PK; Thu, 25 May 2023 06:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q28DF-0007ks-4S
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q28DD-0000pN-O4
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685010530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZCrtTv/I0pTmPaDIW2c3+cGEqE7OPGdWrlUNQsNPHg=;
 b=RCbK34bLGVYWmmWGPQtOZ1OZDksJr7Cq8h1YW3XxIJP8hwodFwTdfb5ZrUO9COv7o0RLjy
 6rxePAvoR+aPXkNe9WEQRvJrdCeSdZ1h/Pja3ngy/wXy4nFFELaZ/oRjXC4MaSu7QLee5t
 8+tQS7WNBWCzF/rYfYo1ceuu3vfDjOk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-Ru0oyDGROGCWwRrD0xyUlw-1; Thu, 25 May 2023 06:28:49 -0400
X-MC-Unique: Ru0oyDGROGCWwRrD0xyUlw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96faa650a3fso60957466b.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685010527; x=1687602527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZCrtTv/I0pTmPaDIW2c3+cGEqE7OPGdWrlUNQsNPHg=;
 b=AyhPMBpXTFoZ3TC4rwpdxKOum3kR8btHg1VM4+iW3lLjgrdXBOn1P803JmWpv1HqdM
 YgntJBK9FiaChVfDzsYWquR59yiLUtvQAO+fU+XmAGAwap5riookh+AJtaxikh4nPL7/
 TADjAETua34OT3M/VutJtk1GATvSoY2x0Vk7S0Lq1+XpVUYmnmx34c/nVCDoeh/OW6vc
 wFwGkij2iwZNB2L/FLIDdq6zI7l41qM6GFM4pYd8MeF4sEh+VyLLkO3qlSuF5jhbPHYY
 QhoNltSlNZo/Ri0q8AeWI53gTj758zJyGa4MnhDDy1D+HUo399u9wcpWMN5X8CdYS2jO
 G4FQ==
X-Gm-Message-State: AC+VfDzcPzCw59Wot0rTyF2ldOxKU3GpowHhxMrLE+5y28eQSUCz/ZBj
 z/BnwXYOwYW8efhCwaSlsNfa1y3WXWVabl9d++meOCg00pV7uzUIf7VohrZ1rcZknO+IPYDUbTU
 6Hco2xEs2R70zeZVhAKhTEYbVZ+yHQauYku3rtM9dyHFqu3ZcHvU7NVJIVHuLWRJquiLfDDPg5x
 M=
X-Received: by 2002:a17:907:720a:b0:966:5035:6973 with SMTP id
 dr10-20020a170907720a00b0096650356973mr1064983ejc.50.1685010527470; 
 Thu, 25 May 2023 03:28:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ekcBI5pSn/2Sq8PvkdNOv1MH4fxkkrHmPKgJIzFRBszycY6icazRiE8ei5ZQq8O3C+Lm18Q==
X-Received: by 2002:a17:907:720a:b0:966:5035:6973 with SMTP id
 dr10-20020a170907720a00b0096650356973mr1064968ejc.50.1685010527130; 
 Thu, 25 May 2023 03:28:47 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a170906254d00b0096a6be0b66dsm648856ejb.208.2023.05.25.03.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 03:28:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	jsnow@redhat.com
Subject: [PATCH 1/3] tests/docker: simplify HOST_ARCH definition
Date: Thu, 25 May 2023 12:28:42 +0200
Message-Id: <20230525102844.209240-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525102844.209240-1-pbonzini@redhat.com>
References: <20230525102844.209240-1-pbonzini@redhat.com>
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

ARCH is always empty, so just define HOST_ARCH as the result of uname.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 94015253254c..142e8605eee9 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -6,7 +6,7 @@ NULL :=
 SPACE := $(NULL) #
 COMMA := ,
 
-HOST_ARCH = $(if $(ARCH),$(ARCH),$(shell uname -m))
+HOST_ARCH = $(shell uname -m)
 USER = $(if $(NOUSER),,$(shell id -un))
 UID = $(if $(NOUSER),,$(shell id -u))
 
-- 
2.40.1


