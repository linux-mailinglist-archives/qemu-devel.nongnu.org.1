Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A21C8036D5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:34:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAA0n-0006G2-UO; Mon, 04 Dec 2023 09:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rAA0m-0006FG-FB
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:33:28 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rAA0k-00066X-M0
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:33:28 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c09d0b045so14978805e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701700404; x=1702305204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jXlBzBqt+9HVj+S60eTLkosn3w0p4HXaOoJ2l+c0IDo=;
 b=FSlQPvMUV6mnM794KW2emQy3KbYMJ3mHynT2Wz4LceOERnCTvpHa2gRyz5Wsxg5NeB
 l73EaR77Oxcojkq9OjhwC0LeWFmpxVDh+AEbpdha/yGvhOngnro/1ux3CtCn5/VdTYr7
 ZWy8pSlzFsaRRlOqieXF67NvR250SgZV8moGWufH9fOwyt/S93kZttgPK8mMRKGOmdDS
 7CWJ5O4utUm5Ug1vw0bIxv66yG9YVeonTX08s814oHmu2qxPYqIhmS2lstVXfyAqMbFs
 ROiE875Y473iCuAH7CQi8F4NlR7n8TTdQsaYNhKyc3Su1eYbanpofIncCLSoTVlJrSFa
 GK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701700404; x=1702305204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXlBzBqt+9HVj+S60eTLkosn3w0p4HXaOoJ2l+c0IDo=;
 b=xBzQvIw9mHntK3a5eSQWqKNZUBDBn9Cxf8dQUJx5qOVpuWaHUdXt0fxRk+B42EJYQ5
 4sRGszmCEzFkUaamNHiX647tRUswU5x5QoVeIup2BcjQKfqkUMzvx5VEFkGZKfIyBG/E
 7GE+juapmFioLlzURD3K/vL/0puUErPZ2ZV2ajvY823Nu/iCX0Z5f/LRXdu2cco3Wwg4
 iTU/2uu2wRp2oQDpvbHZbqVYeAlsC6jEkjqbENn+zBkQimp59GhC6HQf8sfo1rFsNY+R
 pAki/Qgi041FHnicmxCkQ9ZWENOrfcmmbYuxGm+NYCLm2e03C3GnEDafvhAzw7yUFjFJ
 LnvA==
X-Gm-Message-State: AOJu0YwgVFkiE7R6l850jUjk1DqQpLrzN1+arcN1ivHJMaWK4YP66r3H
 Uq5QJGvGOKjZ0S5RqWDq7Xe5Pt9wC+NWD/9dQb8=
X-Google-Smtp-Source: AGHT+IF1ObJWQI/UUt44rMuV31zUJr7UfbO0cvb92dzyJG/qowVzvW/i1rpioagfe8tkMwhU5kA6Aw==
X-Received: by 2002:a05:600c:4444:b0:40b:32e7:2e89 with SMTP id
 v4-20020a05600c444400b0040b32e72e89mr2009370wmn.18.1701700404601; 
 Mon, 04 Dec 2023 06:33:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a05600c4f8a00b004053e9276easm18736143wmq.32.2023.12.04.06.33.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 06:33:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] target/arm: Disable SME if SVE is disabled
Date: Mon,  4 Dec 2023 14:33:22 +0000
Message-Id: <20231204143322.837136-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204143322.837136-1-peter.maydell@linaro.org>
References: <20231204143322.837136-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

There is no architectural requirement that SME implies SVE, but
our implementation currently assumes it. (FEAT_SME_FA64 does
imply SVE.) So if you try to run a CPU with eg "-cpu max,sve=off"
you quickly run into an assert when the guest tries to write to
SMCR_EL1:

#6  0x00007ffff4b38e96 in __GI___assert_fail
    (assertion=0x5555566e69cb "sm", file=0x5555566e5b24 "../../target/arm/helper.c", line=6865, function=0x5555566e82f0 <__PRETTY_FUNCTION__.31> "sve_vqm1_for_el_sm") at ./assert/assert.c:101
#7  0x0000555555ee33aa in sve_vqm1_for_el_sm (env=0x555557d291f0, el=2, sm=false) at ../../target/arm/helper.c:6865
#8  0x0000555555ee3407 in sve_vqm1_for_el (env=0x555557d291f0, el=2) at ../../target/arm/helper.c:6871
#9  0x0000555555ee3724 in smcr_write (env=0x555557d291f0, ri=0x555557da23b0, value=2147483663) at ../../target/arm/helper.c:6995
#10 0x0000555555fd1dba in helper_set_cp_reg64 (env=0x555557d291f0, rip=0x555557da23b0, value=2147483663) at ../../target/arm/tcg/op_helper.c:839
#11 0x00007fff60056781 in code_gen_buffer ()

Avoid this unsupported and slightly odd combination by
disabling SME when SVE is not present.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2005
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231127173318.674758-1-peter.maydell@linaro.org
---
 target/arm/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 25e9d2ae7b8..efb22a87f9e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1743,6 +1743,16 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
 
+        /*
+         * FEAT_SME is not architecturally dependent on FEAT_SVE (unless
+         * FEAT_SME_FA64 is present). However our implementation currently
+         * assumes it, so if the user asked for sve=off then turn off SME also.
+         * (KVM doesn't currently support SME at all.)
+         */
+        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_sve, cpu)) {
+            object_property_set_bool(OBJECT(cpu), "sme", false, &error_abort);
+        }
+
         arm_cpu_sme_finalize(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-- 
2.34.1


