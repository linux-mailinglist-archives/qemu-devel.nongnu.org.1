Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 830D073599A
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:33:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFsh-0000ZG-SM; Mon, 19 Jun 2023 10:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsf-0000YE-Aj
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:21 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsd-0002AP-2l
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:20 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f122ff663eso4496103e87.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184957; x=1689776957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3mwJOChiCQUlVNSGMLtjTUS0WqEV7jHFVk5J5OdBzPw=;
 b=wyVZvXysiK8nU+VO8MMjtO2pB/vpgNMQbSYFkyeZot8GjsJ/SibcZ7LG2ezFXxInOd
 Wq/vV/AVvghSJGL3N9ke8BIusYIKxsHL+SPY/ZyD/eFwSDixxKVZ4kY8U+cYe6yUme9p
 oN8VdfeLtae/rRer/Mwxx3JATi79Evs2O/kQmW+1n3u8cQpLeIiEv2tJR7ocx37i0Sau
 6f/Gthpdz98kO8pitpBsgD/aKDVwwQAXr3Q+AlDBCCp9dVSfUgwO2099cLPDvjWjs+jp
 sWobWV6HUMthsf+2OJxZVF5OtrpkVVf5XTrZ1nycaOObVgUrCB6ya/U6G15jZzY+WxBx
 5nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184957; x=1689776957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mwJOChiCQUlVNSGMLtjTUS0WqEV7jHFVk5J5OdBzPw=;
 b=QT8T5q5CHYbCmscc/UfGiFJs+5SH6WDkn4hLDcCBDq540c07hVqVkRvfLrKP0+Qv3H
 TfBciJs8+kVOq5d56ngCSxpGIOuUqOnM/iGo7rPhbv9jMT6cZqwj3bdO7TRxGiBwv6tv
 bgLrS3XNIVhFDz/gHFDpy3KZ1VAW6nc2XqUS6NMXqOtC98dg6cllC8pMT4fTAywEwaRy
 InMdjfVCKxSO4wPHtRGk4G1SOAdpB2DWFw5zouT3szMep3kLxEIPJxr+GhHXuUoQvI1/
 RSTK9lji4guJ7pHqwfZ+BP8R0niIoRqBXDO7tZ+MrQFnELcu1PFx0yaWuqCgRaRCXkKl
 kNRQ==
X-Gm-Message-State: AC+VfDzK+Rhnmih6wDk4nkv2YXQiLGePSEr9wchmQsaLEM8T+k+tD0/P
 /xM9/GO4IDWZz8PKIfSk48uRorPf6CfGniGCwWc=
X-Google-Smtp-Source: ACHHUZ4xtYO4bynF2LGOFuA9Th1+oZP3RP7kjKRB8xRFsLXbDAs2fJvP5Rby97BPg1Q9/wzC+fAI5g==
X-Received: by 2002:ac2:5f9b:0:b0:4ed:d2cf:857b with SMTP id
 r27-20020ac25f9b000000b004edd2cf857bmr5373226lfe.5.1687184957097; 
 Mon, 19 Jun 2023 07:29:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/33] target/arm: Return correct result for LDG when ATA=0
Date: Mon, 19 Jun 2023 15:28:43 +0100
Message-Id: <20230619142914.963184-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

The LDG instruction loads the tag from a memory address (identified
by [Xn + offset]), and then merges that tag into the destination
register Xt. We implemented this correctly for the case when
allocation tags are enabled, but didn't get it right when ATA=0:
instead of merging the tag bits into Xt, we merged them into the
memory address [Xn + offset] and then set Xt to that.

Merge the tag bits into the old Xt value, as they should be.

Cc: qemu-stable@nongnu.org
Fixes: c15294c1e36a7dd9b25 ("target/arm: Implement LDG, STG, ST2G instructions")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 246e3c15145..4ec857bcd8d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4201,9 +4201,13 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
         if (s->ata) {
             gen_helper_ldg(tcg_rt, cpu_env, addr, tcg_rt);
         } else {
+            /*
+             * Tag access disabled: we must check for aborts on the load
+             * load from [rn+offset], and then insert a 0 tag into rt.
+             */
             clean_addr = clean_data_tbi(s, addr);
             gen_probe_access(s, clean_addr, MMU_DATA_LOAD, MO_8);
-            gen_address_with_allocation_tag0(tcg_rt, addr);
+            gen_address_with_allocation_tag0(tcg_rt, tcg_rt);
         }
     } else {
         tcg_rt = cpu_reg_sp(s, rt);
-- 
2.34.1


