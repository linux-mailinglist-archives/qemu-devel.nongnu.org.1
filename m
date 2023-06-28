Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4177415C1
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXVB-0008RY-IW; Wed, 28 Jun 2023 11:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXV9-0008KV-0x
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXV6-0000Pn-Rm
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:38 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-313e1c27476so1068438f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967675; x=1690559675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pi0JrV9creowU9ObUgp45MMaCEBswiUX78mksPrAn/0=;
 b=aopn16Dm83ueyxHDVs5T/Oko5RhmxXsGx6+nv3LZ81vAC6WHLOB4BFdLKJuFnJebIt
 qC4vjwCUxwfoG87QZ/QgleEWl+t94ZxhMG2V2dNAvzr2Tl0W8StCMH+cAq904TaGnpqD
 z5A5kHv0LF3XTd5YwJ/kGTlFf6g+WRv59sWqlQR9NnJpML4YIUhm1d4964PJmZHQz66d
 NLcOGs3Ot1/LJpTArcX0gllcKR4VDD85DzTkAvieun/7PBP6gO/QU+0D9oa9IP3HOLKc
 P4VW/oNshlK0olSQM3kWbDm5PjoQfL/QpwfVqgN1Fcr1z4sBK37rxI/+w5H63YKXBxK9
 hPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967675; x=1690559675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pi0JrV9creowU9ObUgp45MMaCEBswiUX78mksPrAn/0=;
 b=LzMS/x7IbmdvAga3IVIRHOeiYANVnllQE/akJWhvVhLg1diPZBwZILIBAi53Ejl0s+
 cQw4VvhOphqQrPKBceOfOlH9fcrCYsHNkZEilnSp2aQvO0wVZhJ42gj6Ncfg8nNyR3vy
 Vv/RWjYHWxgHBxo5EdjqLuKQEkXCV6y+EOrdIDglZVJyHo9qKmxqW+rRomj1fFqG4tAp
 X6ZCwcictPN+8BoXJNFvL6SftsecxvmZcHy4kNpSJwkRP32jwtJed8Bxn98iX/VmD9Ef
 RLC2XwM3sov7sMxyhL77JTPFKuPgRvpyiSa5XCXHH6/upI0IiXBTwhMGZVGTEPaeLFGN
 34ew==
X-Gm-Message-State: AC+VfDxyv4e9BlR4LXAJLjo4PO6za5e7ayORbW/Xw8uBVsFInOCAFcRB
 LcSy2KDBqmUJv+cDui8MNCaZFkTqIWtkmr04tAc=
X-Google-Smtp-Source: ACHHUZ7RSxbDmfsyN0jcpdHGp0qmdWZnUijitIkmvmefTCQHAlOrXbAhub96w+R1KO2QZnt8QVv8dw==
X-Received: by 2002:a5d:62ce:0:b0:306:3352:5b8c with SMTP id
 o14-20020a5d62ce000000b0030633525b8cmr2293024wrv.7.1687967675402; 
 Wed, 28 Jun 2023 08:54:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 cx16-20020a056000093000b00301a351a8d6sm13779867wrb.84.2023.06.28.08.54.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:54:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/30] accel: Remove WHPX unreachable error path
Date: Wed, 28 Jun 2023 17:52:57 +0200
Message-Id: <20230628155313.71594-15-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

g_new0() can not fail. Remove the unreachable error path.

https://developer-old.gnome.org/glib/stable/glib-Memory-Allocation.html#glib-Memory-Allocation.description

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230624174121.11508-13-philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7fc8d4ffe5..63be5fbdad 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2179,12 +2179,6 @@ int whpx_init_vcpu(CPUState *cpu)
 
     vcpu = g_new0(struct whpx_vcpu, 1);
 
-    if (!vcpu) {
-        error_report("WHPX: Failed to allocte VCPU context.");
-        ret = -ENOMEM;
-        goto error;
-    }
-
     hr = whp_dispatch.WHvEmulatorCreateEmulator(
         &whpx_emu_callbacks,
         &vcpu->emulator);
-- 
2.38.1


