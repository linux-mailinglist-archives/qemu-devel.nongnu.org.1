Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 558EE73599F
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFsj-0000aR-Oe; Mon, 19 Jun 2023 10:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsf-0000YD-9U
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsc-0002AS-QC
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f904dcc1e2so24313685e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184957; x=1689776957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DRiCDQf6VnX7QrB2jN0QiTtMgaauc3TNsMR5cTED1OI=;
 b=GjLpGB49fbi9nTLLGboX6JYyxI+R1FsiCeFsNuYDBsv4VAQPS4bdAK5ACDEc8QDS1R
 XPGRqzliiQjLdulb1FItwrKqHDDBFa5g5TxfmfU4BjpWq9Wn2/jt566tt1cjtm4QjNM6
 1jeh5FK6sCz/v32CFZ51IyZpwfsKZfVRdqCSBM+nKL86v/D78tdo9Puf/ZvTJyOgNU/k
 j9oIpfByncDAwWAp+PZig9gJXYF9FWj0dTyag45rEbPWY6+N5OHt4vPJ5mQsTNW0qhgt
 LExwCiU9QZa3VnNlRsGZfNONC1IF9xuS03NL6mBnkhuG/bvjPEL+RyMKFZED5Wg/lQjB
 iK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184957; x=1689776957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRiCDQf6VnX7QrB2jN0QiTtMgaauc3TNsMR5cTED1OI=;
 b=Ofw6vidfk+m+r3KM4oQ5HJmKpakAPr3BN+L68HNW1YpB8ABqN+H9niag0+cIHpwfqY
 Qtr68QXPk9cyuQiNTtQLBj3HNfaGYClU7wvF9Zsbw5DoRkYD1X0w8cByHIbwDAvcZ/Ie
 Mr96h4m2NjPkou1GY6WdYzAG4VbL7hCAhXmZ32CLed7a0dsBx5rFoCRygvTnGFcKPkRl
 AaKZiWY8EW2jH4/2KmuZQF9gh5JvOrrMX7gWb4hg3XF3BPyhxiBN3BZxUvOLSNwYnvmi
 WL4yd3SHivBWRCLi6B0n1GSLXwp2vgFV+9HL3JA5cMh2oWh0KJnaCCd0/7DM9SoiUpdF
 mgrg==
X-Gm-Message-State: AC+VfDxavdLUoi9ZOB4bDovYE9NsYCtONyRgThBIE1lJzUqGk8mYhjNa
 M5YchPYdu0ZpII3F6CKQoUfA6OupjF8THaoofgo=
X-Google-Smtp-Source: ACHHUZ4zSKMX+8WRIILnPvXWfHodD9J/Z9OngsBpOvgufZJEhV1FXKbaJSRAwQmkw52B89d3Ahz7FQ==
X-Received: by 2002:a05:600c:a38a:b0:3f8:11ec:7c0a with SMTP id
 hn10-20020a05600ca38a00b003f811ec7c0amr7517338wmb.23.1687184957598; 
 Mon, 19 Jun 2023 07:29:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/33] target/arm: Pass memop to gen_mte_check1_mmuidx() in
 reg_imm9 decode
Date: Mon, 19 Jun 2023 15:28:44 +0100
Message-Id: <20230619142914.963184-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In disas_ldst_reg_imm9() we missed one place where a call to
a gen_mte_check* function should now be passed the memop we
have created rather than just being passed the size. Fix this.

Fixes: 0a9091424d ("target/arm: Pass memop to gen_mte_check1*")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4ec857bcd8d..d271449431a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3226,7 +3226,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
 
     clean_addr = gen_mte_check1_mmuidx(s, dirty_addr, is_store,
                                        writeback || rn != 31,
-                                       size, is_unpriv, memidx);
+                                       memop, is_unpriv, memidx);
 
     if (is_vector) {
         if (is_store) {
-- 
2.34.1


