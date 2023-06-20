Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C56FC736615
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh4-0003pD-Qt; Tue, 20 Jun 2023 04:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgu-0003n0-Jx
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:20 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgr-00065A-9Q
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:19 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51a4044b7a1so5441187a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249575; x=1689841575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iu9NYRz6Ra5A62BXzInURdN1K99XZz4HoyPXiDzEZbw=;
 b=GEEvcbOC2aBtwZ2SJpJdLjluYMniVSd736VdZDawiICngQUT/kftQhdILdImEOIayU
 DE/bJr36thZtrloZtVIsLFdI1IzLeGlG3vQD6HbHq2slmgKGechPUuCyrx0bduzyIQyH
 Fm25xe9gGLIb5n1qnMKFx6FVuzhtvAbNpSvH4NdUt20IHZLZnEfOJsC+AyARI7amBlOK
 dd1o8cXxWGSZO2nGptGrAeOisxGQuV8Ai75Od4P2frdI8dnU8vTrm3mPuU1hVLT8VMnn
 cNwaYPv8ZvLCNAZQREytzi8+4lvjoaoQ4dRQbzdu6I4j3nLOSgA9IvcdTM7olQgyZA+p
 KMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249575; x=1689841575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iu9NYRz6Ra5A62BXzInURdN1K99XZz4HoyPXiDzEZbw=;
 b=Lg9AD42onY6JdLITbaCy+LJfpMwmkCDfOIsbqtSp0uSmT0MK2Wmp5v/vAjztVeShuv
 YhrxpO/5OSIrRAPWfYg/GLqPfhH97Y7h4gwbxHWToA6c2VCHy+EOAQHOrac7PHPHajv9
 zKwinjMeHGPiq17z1ouaSzhAaVBAt4Wx9NHgauqv+yBp3jjSakM6CTXB44JXlvzbN/3e
 d2e0FzlQYTfZP96vdm+quK3Apd24fFUh9rHWSb5kKbZI9CqMrvIOjgxg4GkzUoH2NKag
 v0xtRVgoJlhaLkpHDWt7efgu47ETd7N0MfTpOacxxgxG5b824eZx9WOqSsfcvigu0/E2
 DzfA==
X-Gm-Message-State: AC+VfDwIUvMxDtW3mUsUzn4AFsyvXJhQmeNZbTCZQKtLgz18hdRdvVnS
 VnlZfJ9ZM/Tj0PeRZyQBiuInYOD4Rgb6SILK4qfGOdpv
X-Google-Smtp-Source: ACHHUZ7tsWShJulBlla1CTKzaNxL2Rnvrj9pXDqywiMERiIb/MFs26Yqc2IAJvvsB5EoC/bDW4Ta4w==
X-Received: by 2002:a17:907:7245:b0:982:a454:6d24 with SMTP id
 ds5-20020a170907724500b00982a4546d24mr10653212ejc.74.1687249575697; 
 Tue, 20 Jun 2023 01:26:15 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/16] accel/tcg: Handle MO_ATOM_WITHIN16 in do_st16_leN
Date: Tue, 20 Jun 2023 10:25:57 +0200
Message-Id: <20230620082611.770620-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52b.google.com
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

Otherwise we hit the default assert not reached.
Handle it as MO_ATOM_NONE, because of size and misalignment.
We already handle this correctly in do_ld16_beN.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5e2ca47243..14ce97c33b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2727,6 +2727,7 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
          * and so neither is atomic.
          */
     case MO_ATOM_IFALIGN:
+    case MO_ATOM_WITHIN16:
     case MO_ATOM_NONE:
         stq_le_p(p->haddr, int128_getlo(val_le));
         return store_bytes_leN(p->haddr + 8, p->size - 8,
-- 
2.34.1


