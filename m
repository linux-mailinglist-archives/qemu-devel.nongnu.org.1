Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FA57EB6DF
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 20:27:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2z3y-0003ts-3J; Tue, 14 Nov 2023 14:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2z3v-0003tW-RS
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:27:03 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2z3u-00070e-Ac
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:27:03 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc3542e328so45124915ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 11:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699990020; x=1700594820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YU1go63PndchrVnK6DHWLmkVnDCLAEuAU/t//fUCSL8=;
 b=apjY9uTQYnXdfj26MSngIfqL69GokTmwPbrjmLKVROSwvxol9MihKQNgrGalLVuRn8
 crsTkfgh/tiZq12b0C6qmc6kyuCTpVdfV1eLtaJOUmeCNXPJ0nySum5cN6utoA+m/SGx
 +rf5YqHY7rcZJuv8F++XiCHDZp+rJA3DkWWBsq0vBAxY4uAlwu1ecNVRBAmINZoioA6D
 OixZqXZYPMVDEUvMbpHOCAZ6t/9MIaFck88Gst/D3TmxaQNa55vGcmnHa2wKTscOizV7
 J4jDayVPpMWN3OQ9n4WwJzh9pJomWte0aoTRiQ6p6X1ciJCV476g+N+UWONZvFybrQLO
 FNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699990020; x=1700594820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YU1go63PndchrVnK6DHWLmkVnDCLAEuAU/t//fUCSL8=;
 b=DeSS9kjvQQIIpqWTs2+/GZQvlcB6JWZGglNk6UPdil3xNzuGeWTdRJpFEbo71is4gJ
 nl3z1XHQPdnakcEhoheV+lOhX+CFBxqwXxWniPOaPdhOoIVEcCTXyAupVjuGZN2PiYwH
 eclFjprXvjP0Pk0Vi1+eWVSo3eZUO4uxRXY940q045zPQaGJXi/PrIoSyzrPqE/jLNAy
 wEoHFDqZUy+a8ltpg8Vx70ngourgt7cUDFT1wzI2TX8V1eCC0xmkaxf1nU34N0GVYB6Y
 Us7PptSKaSJnGrIhTJtwTWiMtagnwsYdOPiElR0X8O8VKzaiZam538NLqV/4J7si/HW3
 Rh7A==
X-Gm-Message-State: AOJu0Yy6FwxpFxVwZq7uvyPqzg2oexly4q7qFdO+a5nQj7ZRggsOfH1a
 M9OP351LvnWR6M2IBd7noiNmkFtpyKCnM2F9N9I=
X-Google-Smtp-Source: AGHT+IHAmf4TroXDJy7fnn9wm1607bIHkKVWNmmIsYJ4iKPRB/42/rC8IhBtWHXi5vZs8l98YMIVKA==
X-Received: by 2002:a17:902:db0b:b0:1cc:5833:cf5e with SMTP id
 m11-20020a170902db0b00b001cc5833cf5emr3872457plx.27.1699990020403; 
 Tue, 14 Nov 2023 11:27:00 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j18-20020a170902c3d200b001c728609574sm6052643plj.6.2023.11.14.11.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 11:27:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/3] target/sparc: Fix RETURN
Date: Tue, 14 Nov 2023 11:26:56 -0800
Message-Id: <20231114192656.176451-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114192656.176451-1-richard.henderson@linaro.org>
References: <20231114192656.176451-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Perform window restore before pc update. Required in order
to recognize any window underflow trap with the current pc.

Fixes: 86b82fe021f4 ("target/sparc: Move JMPL, RETT, RETURN to decodetree")
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6fc333a6b8..9387299559 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4096,12 +4096,12 @@ TRANS(RETT, 32, do_add_special, a, do_rett)
 static bool do_return(DisasContext *dc, int rd, TCGv src)
 {
     gen_check_align(dc, src, 3);
+    gen_helper_restore(tcg_env);
 
     gen_mov_pc_npc(dc);
     tcg_gen_mov_tl(cpu_npc, src);
     gen_address_mask(dc, cpu_npc);
 
-    gen_helper_restore(tcg_env);
     dc->npc = DYNAMIC_PC_LOOKUP;
     return true;
 }
-- 
2.34.1


