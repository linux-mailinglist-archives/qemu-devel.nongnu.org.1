Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F0716D0D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:03:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44ac-0001sR-DM; Tue, 30 May 2023 15:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zq-0000t6-RO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:16 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zo-00019c-Nj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:14 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2563a4b6285so2742413a91.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473211; x=1688065211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOSY1OWrbK4eSo0NG6B7wYDOM6jJQSGNupGv5PeOSxU=;
 b=PT34K9MXldOFNIa8qEkbe+Mhze36kuVCEsuWonrdMPbIrlL1BN4Cy1yRsqLGrkwi1g
 YdYJJb8X2teVfqA/Oyb6/wvzBotO84Z/+XmfHexX0Tdcf92XEr6aNosRTSpUIThFfO3g
 LjuE69pdraxkIZJyW8CJkK8eYXwn9tkWxTnRA30NuupumootTs/bx8DiDOf+INnf+mvC
 Ee08jjCOwwha9CD26zGDQyAf3PR/cnmBXWfkyzcwkrrRZxQIQSFu5B1FshVquJY9+7s1
 V3QBQycVsh1xucKApmj2n/JgCSYT1QpZWFI9CedSnzJSvrmKHQJkNRtMtOJjNE1UoRN+
 +ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473211; x=1688065211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SOSY1OWrbK4eSo0NG6B7wYDOM6jJQSGNupGv5PeOSxU=;
 b=KdQwhyS6jSSoJniloDZ0QSFQ4Zh+pEagtGJ/sUngZUtDpwcHSY4aDyOxzIAB1syTpe
 luYFwUQYQsFxMA/QHXth/otUPe5QFa8TU3jAitrFbjfu/8glK+OflqqIXYKroL0gNohs
 vISTNpBcnadAq3+Pcedf/Hkia52aUiXc+jQf8iPY8fDD1Y249VlDAsIXK25bUAIfQ0ZU
 tTpZbJmzKonUr4Rzu0hAxLRW9/fXjOQwZnLxCCnVRN814HY3PbvS1GsFqHblSxkQuTNr
 DymUN7j2WmI96k292j3K1Z9nrs6Gzps9SRANi+iwBFyY/yNIABdizr42DFJgWHf3SPqC
 6C5Q==
X-Gm-Message-State: AC+VfDz27lAKzuxAPFfnsL1sdQjDsdq1J1PZhV4LAE1ViVuXHkoqIOs4
 ueowsmqyPJ0bhf5dNJrCLegSmURwGIlu+RK2I38=
X-Google-Smtp-Source: ACHHUZ7v9i2SYvAa7cMN9T+iQvz8ixsQBqJ5tSM4zEZL/2xw0BHgv6DwdD+DgouFrTh1V+Ac+sFdaw==
X-Received: by 2002:a17:90b:4c06:b0:250:6c76:fd9b with SMTP id
 na6-20020a17090b4c0600b002506c76fd9bmr3097147pjb.38.1685473211161; 
 Tue, 30 May 2023 12:00:11 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 23/27] docs: Document decodetree named field syntax
Date: Tue, 30 May 2023 11:59:45 -0700
Message-Id: <20230530185949.410208-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Document the named field syntax that we want to implement for the
decodetree script.  This allows a field to be defined in terms of
some other field that the instruction pattern has already set, for
example:

   %sz_imm 10:3 sz:3 !function=expand_sz_imm

to allow a function to be passed both an immediate field from the
instruction and also a sz value which might have been specified by
the instruction pattern directly (sz=1, etc) rather than being a
simple field within the instruction.

Note that the restriction on not having the format referring to the
pattern and the pattern referring to the format simultaneously is a
restriction of the decoder generator rather than inherently being a
silly thing to do.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230523120447.728365-3-peter.maydell@linaro.org>
---
 docs/devel/decodetree.rst | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
index 49ea50c2a7..e3392aa705 100644
--- a/docs/devel/decodetree.rst
+++ b/docs/devel/decodetree.rst
@@ -23,22 +23,42 @@ Fields
 
 Syntax::
 
-  field_def     := '%' identifier ( unnamed_field )* ( !function=identifier )?
+  field_def     := '%' identifier ( field )* ( !function=identifier )?
+  field         := unnamed_field | named_field
   unnamed_field := number ':' ( 's' ) number
+  named_field   := identifier ':' ( 's' ) number
 
 For *unnamed_field*, the first number is the least-significant bit position
 of the field and the second number is the length of the field.  If the 's' is
-present, the field is considered signed.  If multiple ``unnamed_fields`` are
-present, they are concatenated.  In this way one can define disjoint fields.
+present, the field is considered signed.
+
+A *named_field* refers to some other field in the instruction pattern
+or format. Regardless of the length of the other field where it is
+defined, it will be inserted into this field with the specified
+signedness and bit width.
+
+Field definitions that involve loops (i.e. where a field is defined
+directly or indirectly in terms of itself) are errors.
+
+A format can include fields that refer to named fields that are
+defined in the instruction pattern(s) that use the format.
+Conversely, an instruction pattern can include fields that refer to
+named fields that are defined in the format it uses. However you
+cannot currently do both at once (i.e. pattern P uses format F; F has
+a field A that refers to a named field B that is defined in P, and P
+has a field C that refers to a named field D that is defined in F).
+
+If multiple ``fields`` are present, they are concatenated.
+In this way one can define disjoint fields.
 
 If ``!function`` is specified, the concatenated result is passed through the
 named function, taking and returning an integral value.
 
-One may use ``!function`` with zero ``unnamed_fields``.  This case is called
+One may use ``!function`` with zero ``fields``.  This case is called
 a *parameter*, and the named function is only passed the ``DisasContext``
 and returns an integral value extracted from there.
 
-A field with no ``unnamed_fields`` and no ``!function`` is in error.
+A field with no ``fields`` and no ``!function`` is in error.
 
 Field examples:
 
@@ -56,6 +76,9 @@ Field examples:
 | %shimm8 5:s8 13:1         | expand_shimm8(sextract(i, 5, 8) << 1 |      |
 |   !function=expand_shimm8 |               extract(i, 13, 1))            |
 +---------------------------+---------------------------------------------+
+| %sz_imm 10:2 sz:3         | expand_sz_imm(extract(i, 10, 2) << 3 |      |
+|   !function=expand_sz_imm |               extract(a->sz, 0, 3))         |
++---------------------------+---------------------------------------------+
 
 Argument Sets
 =============
-- 
2.34.1


