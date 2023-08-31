Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 787E378F3C2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:13:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbo19-00087w-SR; Thu, 31 Aug 2023 16:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbo15-000841-M1
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:11:47 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbo12-0007AS-Da
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:11:47 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99bcc0adab4so142272966b.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693512702; x=1694117502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4v4pNCupIU5kKxCqNO3QPDjJEZxzCp5Jcv4RC0vKsz8=;
 b=c/GvylCSR6pnOhi3ncOSyNrkNq43tsqQYOrrrwJFaw1XQxzvAO4WPOtcesxkQGfjD/
 okld6YRT9uBWzMt8sG/k2F8iE5ZLGASxjeUqzZjJVUfQ0rr8SN0cjlOD7FUIETt8jZ53
 zCVE+3QjGlNdh5ZQMsJ+B42qtMtVXKl8szL/aAYpVZHHT6Pkq5gTLSsBt0jd49ANgyOX
 R/pAplQVy1n565GOAjVzlbWzr60+31GPpkWwsVlHcQRY2bo4HSiYyV2qRoGQPWSbn+tq
 YRJBAoyz2I8MAz41t+1c0mcphIlPqHUHhAjWl3CHUp8gcZE3g3x57yKBVKIheV489zNI
 GxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693512702; x=1694117502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4v4pNCupIU5kKxCqNO3QPDjJEZxzCp5Jcv4RC0vKsz8=;
 b=hTa9VWUiEThzdMvntNKjuI7R//zVe8hq2CdqJ2IwRrhELQl9T4LfWVpnyuRpt4DA4V
 Nxz8NzoIGckAqAone1pzAju0HY3jknjwP0kDjETdXBiUxY1JFvkKZCUpxQZqqpkW3G0A
 cf79B3COVtjtb7pmtIeYMD8AYF2tpj7lz8bu3SjVS4llOxLV6gHJjitugCfi6y+cvsob
 eqPMRWWp3qsmhZ/vl7A/BOw32b5/IxR0C2cOM894bPMkHFWKSF1sUHZC1tkWvNBD6ayR
 MDqpoMDUZ82qndhs3qshmgspwp5uZY4KAe4e6xUZT508/Y4hQ/FjB+8Onzqbu5TGOtKA
 /LAA==
X-Gm-Message-State: AOJu0YxqQtobcGHt80hvatg9Fcr4FKMvvbF01hLfHmAdj0HBUaN1vcRi
 J21C+YCamMRi0SpxJGMMe1HqHf1VLce52LNa5Gw=
X-Google-Smtp-Source: AGHT+IHsv99GopbtHP5eIs3tLMNioydJK9QQMk0sbgzwSCuUd1YQe1WOMAZjrJ/VaRt9V1++i09ErA==
X-Received: by 2002:a17:907:20f0:b0:9a5:7f99:be54 with SMTP id
 rh16-20020a17090720f000b009a57f99be54mr227897ejb.67.1693512702418; 
 Thu, 31 Aug 2023 13:11:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 hb26-20020a170906b89a00b0098cf565d98asm1100558ejb.22.2023.08.31.13.11.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 13:11:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/mips: Simplify Loongson MULTU.G opcode
Date: Thu, 31 Aug 2023 22:11:39 +0200
Message-ID: <20230831201140.85799-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Since MULTU opcodes don't record the most significant bits
of the infinite result, sign-extending the sources make no
difference in the result.

Once we remove the sign extension of source registers, MULT
and MULTU are identical (as are DMULT and DMULTU).

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 9bb40f1849..e0a76b9432 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -3625,8 +3625,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_MULTU_G_2E:
     case OPC_MULTU_G_2F:
-        tcg_gen_ext32u_tl(t0, t0);
-        tcg_gen_ext32u_tl(t1, t1);
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
-- 
2.41.0


