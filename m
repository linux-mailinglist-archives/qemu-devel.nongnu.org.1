Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A9833736
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 01:22:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRLaA-0002VK-V9; Sat, 20 Jan 2024 19:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLa7-0002UO-Sm
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:00 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLa6-0007Mr-3U
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:20:59 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2906dffd8ddso553458a91.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 16:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705796456; x=1706401256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KxhZwbZAcm1asBjHob1LgeGTJkXdHPPGTQpwmtvThw=;
 b=luDG2Cf9OECkgoT3f/VB0mWaYPwAh2Y+OYkGJ/3eVyX9u5ZwE6OHVG6bDvqBznyL9/
 4sbfcBagNHPbY1ICyoj86Gh1/ic+vMs+NC8cw++tK7/uVvWRKwhk96pcIvkopryK4/HP
 H74IagG9x0KNn/KvImZMsTNqPU6pGzyXvD/KZbHQvNkGiLHMEy+RuHPRdBA1IHtItoGo
 gqIl2UJYSOCDVFzKDdlslTZBbjyZIyYVAoH09+1RMIHKfhSMI868qM2EC3EBtG/kGxUX
 nhQH37YwtGP5sMRSFnAXR6CspJMmfH9wgGSD2pYVM0kAZvQm3x+QPaFT0fewTUq6YrUA
 /V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705796456; x=1706401256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KxhZwbZAcm1asBjHob1LgeGTJkXdHPPGTQpwmtvThw=;
 b=hw9nybuIBXs6oJwlaTeD2zfsUZcxjAulfflCNO1X5u7B6upQxlDRNCF8fT4vDFaKHh
 /7J+KlouwRwrOClB3ibABeFA2LFE1KBh+MUbe1xBizXR7Bt689ewuFJ5a6NaKpzRej8D
 CkdN88l2eBNYe3M0v2utYdzjDvzc0lG30WzyRIkKI9tRcLcxfXey9IEuUSiiUki/wIP0
 gQhAwoSCTTiev8ysM2VLWedIPmt5jzP8J7fqtjfcWasB5ahKPbb+KGbSnrrp8k0sA1Ij
 4/CntH+XJ8Z5tGLeQyOwfwdSRvDD0o8xc773uGrWC/Gixidh3VLyQtMoHEUtiNx0jarR
 hU4Q==
X-Gm-Message-State: AOJu0YyoziZrD0XJaT0Y6n2NwlIHHrlasTqbNywexmlEkCAxMcjgcEMJ
 IReU/HiH7Wu5JjFxzp+x5q3RDONHMGp+sk0HpR9bw0f+ZAHvNswcHMQRu5rUo4FBPDGRfduCrXk
 6GLo=
X-Google-Smtp-Source: AGHT+IHHIaDEQeNXpAuLF9wYfwYVW2+qTTlzU/3VNlEqA8drj2Za+NBQTPSYDspL1DaClHCJnXASiQ==
X-Received: by 2002:a17:902:b78a:b0:1d6:fbab:d40b with SMTP id
 e10-20020a170902b78a00b001d6fbabd40bmr2467590pls.85.1705796456442; 
 Sat, 20 Jan 2024 16:20:56 -0800 (PST)
Received: from stoup.net ([2001:8004:5170:1e39:1361:3840:4873:7990])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b001d5af7fbda0sm5023546plt.122.2024.01.20.16.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 16:20:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/8] tcg: Remove unreachable code
Date: Sun, 21 Jan 2024 11:20:40 +1100
Message-Id: <20240121002047.89234-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121002047.89234-1-richard.henderson@linaro.org>
References: <20240121002047.89234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Samuel Tardieu <sam@rfc1149.net>

The `fail_rx`/`fail` block is only entered while `buf_rx` is equal to
its initial value `MAP_FAILED`. The `munmap(buf_rx, size);` was never
executed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2030
Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20231219182212.455952-2-sam@rfc1149.net>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 86692455c0..467e51cf6f 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -597,9 +597,7 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
  fail_rx:
     error_setg_errno(errp, errno, "failed to map shared memory for execute");
  fail:
-    if (buf_rx != MAP_FAILED) {
-        munmap(buf_rx, size);
-    }
+    /* buf_rx is always equal to MAP_FAILED here and does not require cleanup */
     if (buf_rw) {
         munmap(buf_rw, size);
     }
-- 
2.34.1


