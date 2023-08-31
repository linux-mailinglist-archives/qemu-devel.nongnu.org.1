Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF24178F418
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:33:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qboJb-000083-3p; Thu, 31 Aug 2023 16:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJH-0008WN-Sq
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:36 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJF-0002c6-Nl
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:35 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so158530166b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693513832; x=1694118632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4v4pNCupIU5kKxCqNO3QPDjJEZxzCp5Jcv4RC0vKsz8=;
 b=WWfOT1BGMHy2ij52RDMP32HeiW+za9rchDZoK1sYObGtr105B+d7RS5EL9GHTDkXX/
 hKhYqiYPUrtc/d+3UTKefHch4/voZi3s3mbhS85mvudf06ojVlPmJbG7mbQAcCe117Vt
 dKh+bM520SAvkcZz14Y3UC/PD57FaSDBwBCe/D2p4m0aF3GcDKA9NjG1wSRYQIFAhnT5
 qU/U7ewkF+4JMZFOQfMPLVLw9uEZjJKOax6LSM9rX/WXAa9/Vg4Gv+udIngzJ5eJKMEG
 h/Auf5TRtVoPNcB6q77Lh7O3my4o5kBY2CrMf3mtomZ8wwyjnRFo2YPskvuCqnlqjs+H
 6C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513832; x=1694118632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4v4pNCupIU5kKxCqNO3QPDjJEZxzCp5Jcv4RC0vKsz8=;
 b=OYqhNFufFH4myYKiHuj/ugFessl3wGt9D/76OoqIMW6uTwVtdPcotL+N6zHMrIZfeL
 QUq8Flx1QsNKy5r6Go2DC2R6pH+SGD0bqFY4jE1fe1HPh9yIvSU9ZMXSPCOOemia4pyg
 8W+wYY3HXnb0NMoyTrkkY8q7rZnjX8gYYj1JyBfHfiuhSVmrM9NJr/vYZdbgO28cejMg
 WZj1oRQw+oBWAqHSZrH4m3nQGYwQsJyFnktbZnd5+8Ki468Bz6KF96WpUYJ14oRDAY91
 RHm+HQVMKxns6/ud7irt60rS831fKWkKYFZiuGt219csf/BiM2MusQ4kMQrmbFfUJjN1
 fUgg==
X-Gm-Message-State: AOJu0YzJPz7zqaY4rVfOtvgnWK9TgWjV5aPm6rygO1LeromEgS7Ousrq
 YkgkQAAuKNQLdYCmUHfArq1QPWp7adp/1xajQjo=
X-Google-Smtp-Source: AGHT+IFQ8/9HnMrftcVtUbdUJ9d3pfWWOe9D0xEu64IvHAeCZVji57fY/jmhQ9NjdWdyY2Wy4FsEjg==
X-Received: by 2002:a17:907:6087:b0:9a1:db97:62a1 with SMTP id
 ht7-20020a170907608700b009a1db9762a1mr296331ejc.46.1693513832176; 
 Thu, 31 Aug 2023 13:30:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a17090655cf00b0098dfec235ccsm1131941ejp.47.2023.08.31.13.30.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 13:30:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/7] target/mips: Simplify Loongson MULTU.G opcode
Date: Thu, 31 Aug 2023 22:30:17 +0200
Message-ID: <20230831203024.87300-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831203024.87300-1-philmd@linaro.org>
References: <20230831203024.87300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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


