Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D59FE7C7F83
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:08:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4l-0002Rz-U0; Fri, 13 Oct 2023 03:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4X-00010d-Ix
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4U-0006wJ-1e
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4075c58ac39so18881305e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183935; x=1697788735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMx3/5vgsTaEtEgPUucXxRgTomEP574B32d5MnG3ZJk=;
 b=xVXeMLZ4SVNRvSGibOV2OAAFLGYGZoPyCI/pTmeTSwqg/PqoriYsnvmMrAZkBm5TRS
 a1xH/7b+N3gCqaFb/CTx8Pv3qpzZLmXMHRtYwF2l3REznSdhYEzEQ8pSrlq3XfZxeLB0
 Tb/dGg0ByU3+qwRhvOnt5jmUuLp4UeoSNXeRQteegnCFnKdQv28eurnimCtMEzik7q1A
 m88i7xwXnEZ5PalTjujvoghIWiUzs9mOH6hsZuoTTMXk+qEPT3seZxre/N2QjKK4Onyf
 ce1PDRhUDDvu56zJ5+fkDRL0bspVdaf9iI7O+YtZUXlsvh2QQuEB58fFAAwmHmlbNfAR
 yshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183935; x=1697788735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMx3/5vgsTaEtEgPUucXxRgTomEP574B32d5MnG3ZJk=;
 b=UNbWdW0quQ5kothSSt1cKufKJF7BUK0vbdYadgq++jDvStLCj8ngJ/EJ5wusFbmER5
 o8GPIDiDhY0kTUFcxb33L/llMAnf5tOMOo7LZ7K30gjKAbx6iv7zx3jqGc1h7SmzEYX5
 GTUaudk5b/epJiIOws1I/VEcP0publMNrSKde9mHuT0MAtqL0QqO3tRuSaV+FbYqV6uA
 j0ezZnEo8VvZfBs3PbWSBm/YvnqhLqRg0xpMIwCi2wXkyFp1O+a8AUHIU3ilib/CMU4R
 oXXYl5Ked1JBTouCH+ZSTv/D3/3gKS+CmgCx0Uy7XrLnqT4lCI2Br3An5I/BXRwpqSJ+
 R43A==
X-Gm-Message-State: AOJu0Yx2gwakSecOyD5ALNguPuIj6TbEptNM2iFY4A3Gx7RVJ4hoYfTt
 fHRXG1KHI45ptBBaPIMfzZJ3BbKxHfFaZ4PwpxI=
X-Google-Smtp-Source: AGHT+IFHfmsQl2qD5jkaraAsKtswmVHZUkIAD96k8D1ntWKXpHQ/Su4FocUarExnNKJmNnRDHDsvow==
X-Received: by 2002:a05:600c:211:b0:405:3dbc:8823 with SMTP id
 17-20020a05600c021100b004053dbc8823mr23388337wmi.12.1697183935165; 
 Fri, 13 Oct 2023 00:58:55 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:54 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [RFC PATCH v2 33/78] target/rx: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:00 +0300
Message-Id: <8e229ef043423876a2c0fc906a513382cf6f9205.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/rx/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index f8860830ae..b00c0a21fb 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2232,24 +2232,24 @@ static void rx_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void rx_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     switch (ctx->base.is_jmp) {
     case DISAS_NEXT:
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, dcbase->pc_next);
         break;
     case DISAS_JUMP:
         tcg_gen_lookup_and_goto_ptr();
         break;
     case DISAS_UPDATE:
         tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-        /* fall through */
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
     case DISAS_NORETURN:
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2


