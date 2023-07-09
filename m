Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6333674C483
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:02:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxm-0000h3-Ru; Sun, 09 Jul 2023 10:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxJ-0000ON-Hw
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:07 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxH-0000PP-Hs
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:05 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2710322f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911202; x=1691503202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Cz1+kZjkC5u47gB2bogcl1IkIjVlfgBFhqhPCwU85Y=;
 b=ipXBaAA0216lsicNBvbsgtSTiPcTReEhGWDokJKpWpR7V2hYxxlkQS0kIcCwl/O4Xf
 42LHz7CcHpRKWUq6nOhsVdEqjhhqdWSZuLV41QBXucINQ0ZLtoWWiC/FRgkGqXs2fsqx
 dDggWlOpz6eIpbpEYXPOf6NNLldJBu8G4TSRYTvb2yylgnPagyNEtR0liECBTJfuxlCL
 5r5Ek+iN6fUhGyVNCNQmyNYXsMpSKZyOr0TDrqop6DR19hhJLvkfMFjTDuIQ1hl0/zrX
 rPGg2wCS3x+zMWIIA/+edioKDLDcvH1HsdAwg21apRSC5tXDrsP50mIpuuZ8oXUbDLz0
 vSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911202; x=1691503202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Cz1+kZjkC5u47gB2bogcl1IkIjVlfgBFhqhPCwU85Y=;
 b=M6ayQ5GNzp2n1Ks3deX8gYkSbJwggpiHWNYEVcQBnR1AXD3FA5J3BzuoFtWy1AJfWt
 HGfsbNMh/9Kl+KzO9pG6eLwdaXqYTKpQ4kYYprOKZTftjgpITd+Ip9E32i+etJ1UxD5P
 FXTQPQdY/iaZsGEfIWSiTFk8zzNWQ9eibFGP7+XogDpKbTjxS+Dygllh7a8f5U12mDQj
 7o7ga+lZq6KTqGnbo4ahuXAq8TuCoY5zNxglB0C7tdpY2Y2d++dwjHzpCnWocBo0p0Qt
 4BjShILOEyEFZH2rzyu9XkGrwQ4jzeVxUnSYtfga2k9tzYTAdPaWQj+G1uB7Oz6i/4mV
 nD8A==
X-Gm-Message-State: ABy/qLYrJPU9J7b8br1/xY8wQu8cVTUqKWF9BeYcZAVSYdPK1UqNELZJ
 ZxdSrplQa8rWT77MIgrSEeFK97p3/zh3Nmpvb3xFdw==
X-Google-Smtp-Source: APBJJlE4mKuqRnm774L90UUFJRJ2b6Qru4qE7r1KTIO8V+fGdp1mc4ghqJF9j+v3HsWO34GdWzjD9g==
X-Received: by 2002:a5d:490a:0:b0:314:323b:9d3b with SMTP id
 x10-20020a5d490a000000b00314323b9d3bmr12558993wrq.32.1688911201832; 
 Sun, 09 Jul 2023 07:00:01 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 17/37] target/ppc: Use aesenc_SB_SR_MC_AK
Date: Sun,  9 Jul 2023 14:59:25 +0100
Message-Id: <20230709135945.250311-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

This implements the VCIPHER instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 15f07fca2b..1e477924b7 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2933,17 +2933,11 @@ void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 
 void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
+    AESState *ad = (AESState *)r;
+    AESState *st = (AESState *)a;
+    AESState *rk = (AESState *)b;
 
-    VECTOR_FOR_INORDER_I(i, u32) {
-        result.VsrW(i) = b->VsrW(i) ^
-            (AES_Te0[a->VsrB(AES_shifts[4 * i + 0])] ^
-             AES_Te1[a->VsrB(AES_shifts[4 * i + 1])] ^
-             AES_Te2[a->VsrB(AES_shifts[4 * i + 2])] ^
-             AES_Te3[a->VsrB(AES_shifts[4 * i + 3])]);
-    }
-    *r = result;
+    aesenc_SB_SR_MC_AK(ad, st, rk, true);
 }
 
 void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1


