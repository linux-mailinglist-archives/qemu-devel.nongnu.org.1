Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 811B79C7FD4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Nov 2024 02:18:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBORJ-0007wl-CP; Wed, 13 Nov 2024 20:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBORF-0007qO-48
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:25 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBORD-00023g-5p
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:24 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso946285e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546859; x=1732151659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkMAKYtUsFK+2kHSHv5+o6ejmYyvsynMitsyE7ErdJE=;
 b=nMTLgNZuUNokikg1kST+CcEwOA9jPPKQev18C1iXymHiQo4wI+f+duzowWZTOG2/Lo
 jMdsxKkDYi/yYqyIbjzxlIyeQ4tY3mgmgXjolTw1gI2ZPwkVstBEaLGmzowFNjLGtIuP
 4WXRbWqz8G9UdRpc5TdnVD48c9JBowxuwbpfGL0MKLAQHBPRIGU7rR3nCjlx7kZ8zgiL
 xAWaKSZ64ZqymV/IOxdo/m2xY78fbxtlk6rRBhuLhFfhttSWgHuRc2D5VaZsOIdUMUaE
 VXxzzj7QqwaWhgtVm0p+oxEaK01/BXXbyI+3FHo5duwM+auSM5S8bdveHTA/SgLn8X8U
 zMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546859; x=1732151659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IkMAKYtUsFK+2kHSHv5+o6ejmYyvsynMitsyE7ErdJE=;
 b=GoCFchnCjDAKAwJ8urWncFkq2p9K+gtE0qZiUlqvs20TTiO507hZxKzP5LFtEwCLAm
 63CiH/0JFQJ4hjPqaUtsr4ZtDIxZ+8F249zpTppwxntTn0YxfSAI5Zv5n62vnfQTHJos
 uYdhEL85c3FuyLdZde6wf34Z8QM8j2yFjYLk9PsMYpUfINkM216R/KTRslyNK2LmIpj5
 XU+rmZXXFeVIQDt7G78Tv92q6InUMBoyoNn1QhXjSk7W36tObrKOiGcZBIEkfEUJfGLm
 K7etUQdL/FAqMPJhL8Hzxy1A8pu+6GkKtkFdh+nqrpbjA980fGp4UWdVigC50X14FLuO
 THaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJEIpzL4fDX48UGj7/7ZeNptFlvwcmv4j0c4sHA2c5ICfxHr2MEF4RA+nQKLPCo3JktphXsEE7Ifkw@nongnu.org
X-Gm-Message-State: AOJu0YzmkgV/BMp8cRH6pbtfW4xn85OgfQNI2eUo6xvF1SkJMvfRWq9O
 vwMHqx/P28gFJgx8ernIq6v5nOlZlnQxomCMB2js0b2SpmzUOfLParrgnuLGZeM=
X-Google-Smtp-Source: AGHT+IGq7l4w9ev6D28X1Yepm7vUOOMFRow8CZfJhEURSVFhxjg71fxbtKf1kANyx9ZamVx3FRm1Lg==
X-Received: by 2002:a05:600c:1d20:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-432b751dec4mr186860785e9.29.1731546859011; 
 Wed, 13 Nov 2024 17:14:19 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27f4f8sm4766295e9.18.2024.11.13.17.14.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:14:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/24] system/watchpoint: Include missing 'exec/cpu-all.h'
 header
Date: Thu, 14 Nov 2024 02:12:52 +0100
Message-ID: <20241114011310.3615-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

TARGET_PAGE_MASK is defined in "exec/cpu-all.h".
Include it in order to avoid when refactoring:

  system/watchpoint.c:52:24: error: use of undeclared identifier 'TARGET_PAGE_MASK'
     52 |     in_page = -(addr | TARGET_PAGE_MASK);
        |                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/watchpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/watchpoint.c b/system/watchpoint.c
index 2aa2a9ea63..f7366574a3 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
+#include "exec/cpu-all.h"
 #include "hw/core/cpu.h"
 
 /* Add a watchpoint.  */
-- 
2.45.2


