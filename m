Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCDE78119C
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX39h-00057i-3y; Fri, 18 Aug 2023 13:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39Q-0004RV-Jc
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:46 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39N-0001pO-QB
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:44 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe85fd3d27so1825184e87.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379237; x=1692984037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKQfb1Masg0LUXafLP8DDVqoNx75e63Lg2kg56KHPJU=;
 b=gAelpra3Z3G7V0iS9SpWq98pdTYMzwEhv5/HjdE7UQoR4CVK92Uzzp9gk10wA6RdaZ
 ixQw6u1yq2fyCDzQcX4Vj1VcV/5j0RFOa8o1pfazrFwJtwzu+w1+AfMA+MkBh2a8b0P3
 U1o4GSh+iM6ar7k70NzjVokRl91z2Gp3Mw6raQGp4gJHoXMoWKkOS6vPQTh5w4SpvhmG
 yS4fV3sYs/oqrdZS2vNVT5ddDiUfG0E9Gw8s97GrH+yPh9AMjEa45b6BtP8ORJQwg6jl
 DMINAMfUlgqokbwD5pKP5XGhPgTU7A+AmG1FQgCtrNemDsClVS9BwtQ89E11HV3RY2Wd
 yHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379237; x=1692984037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKQfb1Masg0LUXafLP8DDVqoNx75e63Lg2kg56KHPJU=;
 b=QU7zokJRaz+XZEGH4QJbNDW/qR+5uwnhMLm6PLBCpQNjZb65R3NA/5GqUfZ2H7T18v
 2qdSywO+zXxzrMGtvHTZCxBs4vIEzBXQ09Ee2Ff/IeuW9A+MENJibKzIeMnD1CP8RQFJ
 sEdN8UYXhkjmlcPQ7+0dcCWBmRLYjS9EA61+cxZVI8USvOPobTkkapytimNYA9ERf/BM
 fsNbmGh2Uks9omKB3eIJCj6qyfhH8zlLD5B/WSGAB96IF38udPKPVsGEJu86/eCoudjg
 QU6Kg7ZOE+6AQvqVrkZ6MBtWQYw7cNzEW+zQRiAnZVBh/xvzWFwrElQ1ldiQVEew72SW
 kRlA==
X-Gm-Message-State: AOJu0Yz4By7ciZ0OkGEbCGTGafBXxxOpGzYeJxRR01yVsDdjKH82+GKI
 Ry386J/AcxSHBJ642YcFPXpzTQwg1Yqxc5PBHoQ=
X-Google-Smtp-Source: AGHT+IHm1PfyxD4yJwxbdGdMTXxS/91m6ZONd89NIjQKb0ux4rkcjW4Twe6BXbjD0F4qdnissMT9Rg==
X-Received: by 2002:a05:6512:318f:b0:4fe:1d88:2c61 with SMTP id
 i15-20020a056512318f00b004fe1d882c61mr2617738lfe.32.1692379237350; 
 Fri, 18 Aug 2023 10:20:37 -0700 (PDT)
Received: from m1x-phil.lan (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 lg5-20020a170906f88500b009937dbabbd5sm1404250ejb.220.2023.08.18.10.20.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 10:20:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/8] target/loongarch: Fix loongarch_la464_initfn() misses
 setting LSPW
Date: Fri, 18 Aug 2023 19:20:11 +0200
Message-ID: <20230818172016.24504-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818172016.24504-1-philmd@linaro.org>
References: <20230818172016.24504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

From: Song Gao <gaosong@loongson.cn>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230817093121.1053890-11-gaosong@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index dc617be36f..a1ebc20330 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -391,6 +391,7 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG2, LSX, 1),
     data = FIELD_DP32(data, CPUCFG2, LLFTP, 1);
     data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
+    data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
     data = FIELD_DP32(data, CPUCFG2, LAM, 1);
     env->cpucfg[2] = data;
 
-- 
2.41.0


