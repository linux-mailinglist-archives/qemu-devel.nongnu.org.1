Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFB07B6459
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaos-0003LX-BW; Tue, 03 Oct 2023 04:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoM-0002ND-RQ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoL-0000KG-9s
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zaDS58SaB+9o6+flazBQrj9kRQw5pA/KRCUziy84sQ=;
 b=YMONj6r6VFwiIV1CVrWafvxvdQa3dCPMdDZDLmJxW9kYjziRFV6H/zFwfIwgolzoqECVJf
 GXnjvYfwMLD84I8d4taNj0ViNoH3SS+n/aUMO/NIubetbEeYuXS/9X6SNBvYFfr9wuYG1y
 w0mn7iAznlcORMBEgJudWbU1MoT3ojI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-FhNX1VbDN76gUAQJa_SfZA-1; Tue, 03 Oct 2023 04:31:12 -0400
X-MC-Unique: FhNX1VbDN76gUAQJa_SfZA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a9d7a801a3so55232766b.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321870; x=1696926670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zaDS58SaB+9o6+flazBQrj9kRQw5pA/KRCUziy84sQ=;
 b=VHkKqC7ly80H4P7jvPBnq/rUEb+6CfDsdf0UykWm8RR1Pc43kYxfvD3IFyLk4ILmAC
 S0JKWJww3c3z8sQkBB/R2E7FI1Wofbsp4o+XoX65vNr9cFkNi1ZG0ayFONjcdjJHBzU2
 Ps1mPwcGJIKWCAodoQwLIRDoZhRzyoBcn2jxrQxBP4ZvhhSgYyzl5yHcvUmnV8rf6UHs
 TWqCaF7oZSJfGT5pmHpWkWMrA5yxE6cNKrx9qh3pG+T5fqBUtVa/XUl6WUpLYnEQXLKf
 j5vAJQCNWPf/Crk8OQb6CPW5sZxm4KK0knz93iowQupD8YmJIy3pINjIClTjm4JOi1K8
 0Eqg==
X-Gm-Message-State: AOJu0YzZJBdFR1Oqb7xiLXyzMA2uMmswY3Gecz8vWkoD20Omqqp+dpT/
 /dfiz6aXQwVwsbnCaX8FxqSbsLn/dKNfJEU+Y3SLgFKuW89BQDRSpfvxI09vf3E+9bl3W5kQGSH
 6EvMF7RVq2SQn5hT1dNFIV6B7vtyurEllKj5BckHkZZTnEYpckGF1SexpezQa92J42na8m17T06
 w=
X-Received: by 2002:a17:906:74ca:b0:9b2:94a8:df5 with SMTP id
 z10-20020a17090674ca00b009b294a80df5mr12232611ejl.35.1696321870319; 
 Tue, 03 Oct 2023 01:31:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK5ocTogznjUcIcfCewj+5asU7+eNkif6eojK06Ls3wBc/c3PyBsADazKtHHdtMEl4MXTOVw==
X-Received: by 2002:a17:906:74ca:b0:9b2:94a8:df5 with SMTP id
 z10-20020a17090674ca00b009b294a80df5mr12232599ejl.35.1696321870084; 
 Tue, 03 Oct 2023 01:31:10 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a170906468b00b00997cce73cc7sm659455ejr.29.2023.10.03.01.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>
Subject: [PULL 13/24] audio: Require AudioState in AUD_add_capture
Date: Tue,  3 Oct 2023 10:30:30 +0200
Message-ID: <20231003083042.110065-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
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

From: Martin Kletzander <mkletzan@redhat.com>

Since all callers require a valid audiodev this function can now safely
abort in case of missing AudioState.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <c6e87e678e914df0f59da2145c2753cdb4a16f63.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 2f479657117..d4387cb3e21 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1876,10 +1876,8 @@ CaptureVoiceOut *AUD_add_capture(
     struct capture_callback *cb;
 
     if (!s) {
-        if (!legacy_config) {
-            dolog("Capturing without setting an audiodev is deprecated\n");
-        }
-        s = audio_init(NULL, NULL);
+        error_report("Capturing without setting an audiodev is not supported");
+        abort();
     }
 
     if (!audio_get_pdo_out(s->dev)->mixing_engine) {
-- 
2.41.0


