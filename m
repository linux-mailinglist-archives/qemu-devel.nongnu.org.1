Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F067D7C80C2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqV-0000Jw-Fe; Fri, 13 Oct 2023 04:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqA-00083H-F9
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:14 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq8-0000z7-QK
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:14 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53da80ada57so3303816a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186889; x=1697791689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObLZvBfIWsqpBMz1AMe/d33MJDsii0r1Rk9v0m2F3xk=;
 b=qaC2AyUSfs1ORZzUBkVkGmZbslSkkVUdxE/ClAerK7HwFh85twCjvVPgDIRA3u/SpQ
 lBNv71phptphehrhJtKHEtGa3ujlx5b5E9tL/UwW4uUFxTfzK5Fctm96r7gIFURkgVD0
 HTSTQbhzkJ9sB34gC9oesJXBRXdxaO7UtAXgkr2fQ9s9nE7PIHUr0Psf5D4RxD5Wdnyf
 hzYLHa1j/twbE3MwC+VZrhmS+RO1Gam+iXAKTSzZgkHHbBgOfPA6rYIv9XtvOuMpC2O3
 4w+X6LPqg0AiWVvIdnxtaJfvH3hL/fVjgzzTVFXil52I90uE8hBJqthYmEfv4l0PMuCM
 Ag3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186889; x=1697791689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObLZvBfIWsqpBMz1AMe/d33MJDsii0r1Rk9v0m2F3xk=;
 b=F58R51N9pYebG4ndaAOk7IW44ijdvFgeQ2pyMjrcaiyKy3dkhKqTroGc4uOxxPPOrR
 ERDkyYusiSYVLGPyGkWGwK3zC/gN1GC5urMeeZ6VXjYEMalGqC5UrRBcev/GwVs+nr49
 hbGCDub7ETD8KAuTKcDb9WRvTpSQwp/2wFcKETFsRMTQ8tnc8imPkwGUpQHo6cD5JejH
 CXfK/QYUG7GVO/qMVY5D20EdZoNFq4NMz3/hprk2BqCxTPhavF9CZREPYftg/i9sPb6r
 EyL807Q9hyMLv2WPYW0MHpfqdSy6K2c0fsCo4Q+D2Nls1oiOOaFvtUysgXGH6iJVCii3
 1UHg==
X-Gm-Message-State: AOJu0Yye69d2aAu6mun/ywwG6VY4VsBkW+uIYPkjAOMSYTEpkXRN/nL2
 ztnLIwpm1BuDYJpaa2VICugP+EVoYM2lJ3JLY38=
X-Google-Smtp-Source: AGHT+IH7HwdS72AasIkwA171QR7J44aRgmM4nSCznZ/+rq1ENXDvkt5Gl8Igx41cHqggP+LxTb3MAw==
X-Received: by 2002:a17:906:3284:b0:9b8:e670:657b with SMTP id
 4-20020a170906328400b009b8e670657bmr23160046ejw.64.1697186889642; 
 Fri, 13 Oct 2023 01:48:09 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:09 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [RFC PATCH v3 33/78] target/rx: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:01 +0300
Message-Id: <845988d0db898a66623ab13dded5a50138ce7731.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
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
@@ -2243,7 +2243,7 @@ static void rx_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         break;
     case DISAS_UPDATE:
         tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-        /* fall through */
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.39.2


