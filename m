Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 438A478BAE9
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:16:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qakV2-0006O1-Ve; Mon, 28 Aug 2023 18:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakUv-0006Kk-HI
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:14:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakUs-0004Gq-UO
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:14:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401b393df02so36191295e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693260849; x=1693865649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSeyYv9fGrIvCDH06h643mqOjyw7AdOjJCHmBe/MXEk=;
 b=HvpjAnYRFHzC3gtkDTwozxlhG1ak3ReMatVzT8Pe0f/2/gI/eOPL8drNj6EvvQXkzT
 PnxkW24IbXCXfBdCjXBsnft67rjOkTE5pbQOjeWS3ZOswjwjIrSnXtasLA8XdguJiCn5
 LKpGf4rCE2MbWRyegi0TsE19qhrEV64Wt6M/gGbaL61fb402qJJfIqFZ3bb8fIH97kaj
 MZ1kFgogBOV2m5GILZi7f9xJSbCB5RTmXduGjLKF24PZrwUIwvVTTbDT9fwXZN6VbEIM
 AKDFZGWliSdjHbqATogc/XWNy7TqDjB+aiUqjUytuQ0tPKujK5W6Ucjz/V5R4OzPOPPG
 9yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260849; x=1693865649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSeyYv9fGrIvCDH06h643mqOjyw7AdOjJCHmBe/MXEk=;
 b=T/dWciqvAFLBWGw543zABq8rPal10IZVNQXhLX1FyDenu8acsc3KAziEnK0WYQ0WoP
 K4+vbvnaOXPh/Ko1xE+IniQz/Bzsf7uFK+ZjOt3b0OmdgxmCdCDZeYaljFYSVYW8aH6W
 JcLGgcz2tYFqjpX+J+7hVphe+AiO1vOPaoVYuJ6oqJX/NzEKdj6dunYoGB5Ubo/9EPWA
 MpoTSaJC2ywWDNELr7okmEeK5jx+ZV/YKQhKkiAH/6JrFfXsTngwDo/S7EL/CExTy1zA
 6LZSDvMHnPrMBsCAo4TuY/HnKSD0wYcS/psloTUMSAzT3/UO5tmihxW/QtRc965/+HkL
 qHbg==
X-Gm-Message-State: AOJu0YxA34DXkIW9+d8treU+GdPxP1eRPymcj4JDHliCB9KZij+kH/Af
 5XpxdTHQlIEVEx0M+6k9K2TXEGH14d4fbmv3aFs=
X-Google-Smtp-Source: AGHT+IG0aQKYb6DlbV2N24HjFxpA9NrADQwJU8AU1W1d0IIL2g5Eza/hYPPIaBvlWNUffe1U7ZTSpQ==
X-Received: by 2002:a1c:7407:0:b0:401:c338:ab96 with SMTP id
 p7-20020a1c7407000000b00401c338ab96mr4610157wmc.34.1693260849479; 
 Mon, 28 Aug 2023 15:14:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a1c7c07000000b003ffca80edb8sm12058270wmc.15.2023.08.28.15.14.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 15:14:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 08/11] target/mips: Remove unused headers in lcsr_helper.c
Date: Tue, 29 Aug 2023 00:13:11 +0200
Message-ID: <20230828221314.18435-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828221314.18435-1-philmd@linaro.org>
References: <20230828221314.18435-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

This files only access the address_space_ld/st API, declared
in "exec/cpu-all.h", already included by "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/sysemu/lcsr_helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/mips/tcg/sysemu/lcsr_helper.c b/target/mips/tcg/sysemu/lcsr_helper.c
index fb57bcbb78..25e03572fe 100644
--- a/target/mips/tcg/sysemu/lcsr_helper.c
+++ b/target/mips/tcg/sysemu/lcsr_helper.c
@@ -8,10 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "internal.h"
-#include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 
 #define GET_MEMTXATTRS(cas) \
         ((MemTxAttrs){.requester_id = env_cpu(cas)->cpu_index})
-- 
2.41.0


