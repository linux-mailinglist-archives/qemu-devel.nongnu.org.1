Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CC7476E2
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:38:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1H-0001MV-KJ; Tue, 04 Jul 2023 12:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1E-0001Jy-9I
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1B-0001q0-7y
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3143ccb0f75so1564019f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488600; x=1691080600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=REQxdvHqMD5dtevjQjK3Wnx/HFYuQ118HppndU5qJ5M=;
 b=CRa2WQ7kV4gpM/nsg/Kd4DyhiYAfcXKhsZFfcOQa8ILOkYJSdX+GN3PifsLNC+VIlg
 pn+tRnqo7CY9H4JRmR/Gmtp+HQbNgsrjZBsyVhZoOMpWQ6WH0YELj26jBS5ZiCg6fmn/
 /gAfkYfrOIBlxaPdyBzpq58SdZUeKjUxvcufw/2kX9WqeofT06TaIRYJqEktyHMNjED9
 LG3l0O5CSm99Nv/aqSnoPWnvyAziI27eCRW5sjDe0Serut7tuMnqRkHDjPcihsb3rUZA
 E50KKbiS0jw6fZF9nSZfm11xwKlV05Ca9OM4Mmkhs0iNwuZAHpzI+bDeTn5yp2B2M0CU
 hJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488600; x=1691080600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REQxdvHqMD5dtevjQjK3Wnx/HFYuQ118HppndU5qJ5M=;
 b=JE6KifgbcyvJx3QZmnoLI93h4K/vV0pquAmXvu+0o5JCHvZLTbY9lYEUPfJz4UVRAH
 Ldbs13hmx6Dlp1IZRUCMNAMj3Vd6cNgcW+Fp5w3EIBw9vxw4bMeaeJC+mtWxjwRXW0KL
 OufxlH0Y8SkEaiTymchhhE/CGKPX3hYBsYXdyCOvY76MYwBJwS22ywpA5mwFExqpXhPk
 DyHPEPNhb+MxdWD6G8txU8UQZZV/G+gUyRATaQbn6VAEal6eEf9j9NfqvFC/fKRTP57L
 rEu9faYD3vuTV08PdLa4N/rfvI4W1R397XSKfokKTA/S7tbPcNeNG24WP5kgbClVk1RV
 VhqQ==
X-Gm-Message-State: ABy/qLbdQN7/DeTrx6bhJtIT+jrALZ7VI8IF1qg6ox3Ups2H+/86gyzo
 yctXB2eqDl0KNjfosINdOMeNQYjQCnh6zRzYQhg=
X-Google-Smtp-Source: APBJJlGk2gX1pgqWsYCB335htuXRe5A6WQDnI5mLoI4tRuUOF9poypIftj7xriuQs4N9vV8M0j6ejg==
X-Received: by 2002:a5d:4529:0:b0:314:388b:361b with SMTP id
 j9-20020a5d4529000000b00314388b361bmr7870389wra.12.1688488600526; 
 Tue, 04 Jul 2023 09:36:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] target/xtensa: Assert that interrupt level is within
 bounds
Date: Tue,  4 Jul 2023 17:36:34 +0100
Message-Id: <20230704163634.3188465-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

In handle_interrupt() we use level as an index into the interrupt_vector[]
array. This is safe because we have checked it against env->config->nlevel,
but Coverity can't see that (and it is only true because each CPU config
sets its XCHAL_NUM_INTLEVELS to something less than MAX_NLEVELS), so it
complains about a possible array overrun (CID 1507131)

Add an assert() which will make Coverity happy and catch the unlikely
case of a mis-set XCHAL_NUM_INTLEVELS in future.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Message-id: 20230623154135.1930261-1-peter.maydell@linaro.org
---
 target/xtensa/exc_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index d4823a65cda..43f6a862de2 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -169,6 +169,9 @@ static void handle_interrupt(CPUXtensaState *env)
         CPUState *cs = env_cpu(env);
 
         if (level > 1) {
+            /* env->config->nlevel check should have ensured this */
+            assert(level < sizeof(env->config->interrupt_vector));
+
             env->sregs[EPC1 + level - 1] = env->pc;
             env->sregs[EPS2 + level - 2] = env->sregs[PS];
             env->sregs[PS] =
-- 
2.34.1


