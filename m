Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 442457ADA4C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmsp-0000dv-I4; Mon, 25 Sep 2023 10:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsh-0000ce-Do
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsf-000868-3j
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yXh2gOGuGydxlcHn0MJWkG6oNwaWADlluHpoQ0K5Bu4=;
 b=RN/IHMMFCQlG08GxlyougszrhUio5BaGL61AMtFqkSSiN3WLxHM66sGnj1xJpjkN+fLhTZ
 76CbshWQW5k2oV1MXh2P1LfBpXCkLN5un/uGs7cXdJW6dl3eQ5ZH9giGZoqvk8hIyP3NOZ
 SPRr39MCX1CsAfqWU1jl6I195vE5p7A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-d2r-GsXBPfKq5njlI25t8Q-1; Mon, 25 Sep 2023 10:48:08 -0400
X-MC-Unique: d2r-GsXBPfKq5njlI25t8Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso60369655e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653286; x=1696258086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yXh2gOGuGydxlcHn0MJWkG6oNwaWADlluHpoQ0K5Bu4=;
 b=WF+GK09fHC0XsSV4FWi9jm4oz9jSiEf7G9HujGnH6eWSq/2qWCIXDALLwix9RwvNGo
 9GKORJMIFonCVV50DJT+K7CcaLndOFHAvTfD0HEVQRkr8HYj8nsMlmXvZv9XcPwybG51
 4+USZPyy8SdfsGwfbtebF276JayH8OAS+YzFUXFjLup1psJJppSC1HIiKNITwrExkPoL
 fzuEGr0g+oG0fgWZe94R7bixqpgpqxpVE4ZygMZSqGv5AjDCGdJHwGQ6RUKX2xZgQ1IE
 mIyCWwLPawazczCkzc4wjZz8hMoHxkDgpT8bkZIiQO4GuHnY10AfopqBk9MrFRrQgzBA
 t7Xg==
X-Gm-Message-State: AOJu0YwbJX9qCjjV3RmTVY/vA8zsg5kKSgWsCzzUHOwUMKm4xE5WwDG/
 LtPzsbfufVIx4OwwJLiRzHvyZbdJXazKlbstUHbWFGKaMxJnWxHUaa+dqCD8+dG/REidZZWahJG
 tssiU9VNl2MlSjpddy/RZgyzFNoAtEy5cRDoYCaCV19zAQg+yooxkJd9AV9aI1V5ulGEr518Kuq
 Y=
X-Received: by 2002:a05:600c:1d99:b0:405:7400:1e3d with SMTP id
 p25-20020a05600c1d9900b0040574001e3dmr4065676wms.32.1695653286391; 
 Mon, 25 Sep 2023 07:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMqoWL1ZL+HJ/gSv1GJasXeX0HeIkHTYZsmIoLsowkY4DQiuptyFm+dybWeynQN8v9VRy2PA==
X-Received: by 2002:a05:600c:1d99:b0:405:7400:1e3d with SMTP id
 p25-20020a05600c1d9900b0040574001e3dmr4065655wms.32.1695653285970; 
 Mon, 25 Sep 2023 07:48:05 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c23-20020a7bc857000000b003fefca26c72sm12479683wml.23.2023.09.25.07.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:48:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] target/i386/svm_helper: eliminate duplicate local variable
Date: Mon, 25 Sep 2023 16:48:04 +0200
Message-ID: <20230925144804.528508-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This shadows an outer "cs" variable that is initialized to the
same expression.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/svm_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 2d27731b608..32ff0dbb13c 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -387,8 +387,6 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     env->hflags2 |= HF2_GIF_MASK;
 
     if (ctl_has_irq(env)) {
-        CPUState *cs = env_cpu(env);
-
         cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
     }
 
-- 
2.41.0


