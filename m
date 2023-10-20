Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A72B7D17A5
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLr-0007p3-TL; Fri, 20 Oct 2023 16:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLO-0007hp-29
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:42 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLM-00088x-Hl
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:41 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso996538b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834619; x=1698439419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2CpBYHyN5WTjKAnF9eC52gwF9DPW7ui+s7AIy3W9Zs=;
 b=pImwqOd/1AE+NzS0DLx3mHVnCxK6ZP0NwiA/mCv3t17g7qVml1OWE3lVM8p31Gqfcz
 RNw3nIydILK45fDD3/HdX1bKHR8gTSsNHs72YBcIrv3JBZe9E+v/LFTClVUxkVHQ2Csk
 PuA4gsvhqS/dWK2SSmTIFQIBS3bg5QuLlRLJ+If/HvRVORf1iEs2Z2rsv+xBofbhf7wv
 PYb9RNqxpzK9VFlubISvOq+9oXmXlE/oTRBr6SKA5pAzcSulf4cDMXpiet7ZBqTDEA+I
 UpUhJ5HbH13/HrNofDVZHTzZl2rD9MsC3gp91Fbam4JW8ZA+JQtREvfSB9pS9AvZNCAz
 QUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834619; x=1698439419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2CpBYHyN5WTjKAnF9eC52gwF9DPW7ui+s7AIy3W9Zs=;
 b=k8yoeXCw0135Dd8F3zSbRrEx6KKClkY9EnmR2d58fOjxeOu7yv4Ehfy32RgVNT6FM/
 YvdS8x0lLxsKRB6sz04OnVhbYJlhCK4C2q6T2yj13/Lo6befUTArtbfRVdPoOg2IeWx2
 K43gngya7my5l4HjgxbyMrWr+LEEyr9eiIaZOSVMZ67LervQPSQplMFBPxaM/kOOdqK+
 Ez6S3A39Y+dePzPqHmASeoUqYLTtz0Pdoce5Hgb7G4MFSZm6BU5KN+rwZKWj7R178jGr
 HlTqp75wM2zj0+qBYRNNOZPHeAP86ComH7GEbtsTxiqsKtWwrUbdEOtAwmrU2ITb246h
 SqLg==
X-Gm-Message-State: AOJu0Yw6Nig2rdPC5oKwLPuU//HI2wgiVOSAS+hQwqYqAXQfmW+BnHKu
 BbgKnF+6wYuUglkpDgiCKmjqc+uq6v7hT0DpDOM=
X-Google-Smtp-Source: AGHT+IEqQBT19IfyxEpHrXEOQWDaeUwU2zYKqePB6v8fSQ/dl2zjLW4Um2fXcK5zBMzuzjqJmYVsKg==
X-Received: by 2002:a05:6a20:144c:b0:159:e4ab:15ce with SMTP id
 a12-20020a056a20144c00b00159e4ab15cemr4053103pzi.15.1697834619119; 
 Fri, 20 Oct 2023 13:43:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 06/65] target/hppa: Fix hppa64 case in machine.c
Date: Fri, 20 Oct 2023 13:42:32 -0700
Message-Id: <20231020204331.139847-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Typo of VMSTATE_UINTTR_V and VMSTATE_UINTTR_ARRAY_V macros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 905991d7f9..0c0bba68c0 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -24,9 +24,9 @@
 #if TARGET_REGISTER_BITS == 64
 #define qemu_put_betr   qemu_put_be64
 #define qemu_get_betr   qemu_get_be64
-#define VMSTATE_UINTTL_V(_f, _s, _v) \
+#define VMSTATE_UINTTR_V(_f, _s, _v) \
     VMSTATE_UINT64_V(_f, _s, _v)
-#define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v) \
+#define VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, _v) \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #else
 #define qemu_put_betr   qemu_put_be32
-- 
2.34.1


