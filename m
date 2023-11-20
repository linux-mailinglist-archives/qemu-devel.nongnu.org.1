Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB327F1F4F
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:38:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bwb-0007xg-A2; Mon, 20 Nov 2023 16:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BwI-0007Cg-TJ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:36:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BwD-0004FT-Fn
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:36:14 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso20368165e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516170; x=1701120970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOzYF2dzBcuolmQzvvXqLCwUi3E1rapeqqZCPtHm/3E=;
 b=nU4SQtss+A5RcGRDcXNWpwmn6Q4k2ciTRipTM7zrxgPsJgPTSwiol5AjjsqAf4MnDn
 y3fZpZ82ayPHe8WFsz981bajPQzZWKWMGJ9apQeNY5f7d2JeCGgsxUzXsMkSTy8UYntf
 ng6xE7aDzFpsCMs/BrDiGq75cnPr7Mi9LsYNu4BJU+8YYp25abkKwNhdT+Pcnge6lWkd
 wxSYevVHiWP53YD8wy+8GVm7PY+cs8hMRaGmBxrNzcPy61Ip0hvsU3I9AoX1Tes3KLqE
 3sUWPgSlub0xwfpcowUZsLS7XSvnbOVyHGJWAnjbpy5KPBp6uV7/mHE14v9EVsDNiXOg
 wxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516170; x=1701120970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOzYF2dzBcuolmQzvvXqLCwUi3E1rapeqqZCPtHm/3E=;
 b=bOCGVgf6Rh32ITIC7AUyG3IHbw2iapiFa2P2wFV5hB3c/0e6yPUIeCiM4R9GT3vo1S
 BjJVV8aMEyc+HKNCh2JjUt5qh56tkZ6Vmi+7FkfpzjmdZqHEZBq3BUvMj39tg/9jxvez
 CtkZjua44emZJF4QnH3fm6NnXV0Q2QYfB+93MYD7ePvO/Fh8YDNne1Bdoo0aIawn1mNb
 JiJ7ltkpstZzCQgruin776BwYEp1dH63ET4ZZ0G2BGhn2HzQPv9H/UdUKKht5vmsPM74
 q3seJGAKnO8UEE+Uvu+wsl+e1sbZw1YfrIwUtu3U2AtqW9InULdIaDuGurovYOYyFT48
 JqEg==
X-Gm-Message-State: AOJu0YyYDTdh46QXQx7JYFjRtd185qXtc6lR8xttX8b4pd18N6ML6TaR
 8im1S3UKIbd6AYgw4U2jt4SSIZokiGmTjeOVfKA=
X-Google-Smtp-Source: AGHT+IGeJlR/HkVqyUUEWHAjFyqHC1WcCYFo5ZDZidCF/ISCKiyZ0Bi5axUFaKzlaf91QClbY/DD9A==
X-Received: by 2002:a05:600c:1c96:b0:405:336b:8307 with SMTP id
 k22-20020a05600c1c9600b00405336b8307mr7178838wms.7.1700516170346; 
 Mon, 20 Nov 2023 13:36:10 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a7bc8c6000000b004030e8ff964sm18674108wml.34.2023.11.20.13.36.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:36:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-9.0 17/25] backends: Reduce variable scope in
 host_memory_backend_memory_complete
Date: Mon, 20 Nov 2023 22:32:51 +0100
Message-ID: <20231120213301.24349-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reduce the &local_err variable use and remove the 'out:' label.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/hostmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 3f8eb936d7..1b0043a0d9 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -324,7 +324,6 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(uc);
     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
-    Error *local_err = NULL;
     void *ptr;
     uint64_t sz;
 
@@ -400,15 +399,16 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
      * specified NUMA policy in place.
      */
     if (backend->prealloc) {
+        Error *local_err = NULL;
+
         qemu_prealloc_mem(memory_region_get_fd(&backend->mr), ptr, sz,
                           backend->prealloc_threads,
                           backend->prealloc_context, &local_err);
         if (local_err) {
-            goto out;
+            error_propagate(errp, local_err);
+            return;
         }
     }
-out:
-    error_propagate(errp, local_err);
 }
 
 static bool
-- 
2.41.0


