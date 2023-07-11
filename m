Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9D874EDE6
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 14:17:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJCGv-0001PI-D7; Tue, 11 Jul 2023 08:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCGt-0001Og-CQ
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:11 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCGr-0005JA-Qw
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:11 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-991f956fb5aso650379066b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689077707; x=1691669707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+y8TbzD6KdBtm6bLNfPNIrlfjZlgAQDCnaTrCBY8joc=;
 b=ky7dD/l+7JH9oc91EBb7CpQU96KFSW55KJR/dfaWlSSoPOAqb1YHwDFaS9FPy+XvQ/
 WmbSPkCU7mLRdD/BVTjMLVpozxlm4R8ZkPpND4rnKEdEnZrBtN9tix2EvdIlkou0T0S8
 eKGTPeCPwAuvgiNYeQX/Nnb2NxDI09mVmX9rTBRuN6ohxDqcwLrHKrjYUxTsPrVlQ7Di
 2T3/xqiv9aZImOYkArCqyJ4iUMWLss1dzv6UkiSVNBg5vUkD44ZSrSjp8dxdns6/AGL4
 8ojCkF8adLjGNLJi691NxLRlK+kKZArurCXd7jNURxrc25/tCOeAF7WwJM0LthkPzEoK
 KwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689077707; x=1691669707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+y8TbzD6KdBtm6bLNfPNIrlfjZlgAQDCnaTrCBY8joc=;
 b=N25zMBIXMRgb2UdBXjPyvbGtKIOEQcncwPgwwqdtkw2I6Opogep5Far3d09U/CXndi
 YyOAmELZ0KpGYC18ocF985admY1qFspqmmcBAvRzJdYoMLSIRxL7xQQhWT3RS8yF90hS
 eeSDUa7Opxg9RvIye6sdS8+wt3BNuHyw3CAusI27Ir7ro42wmudQiPcj3J+iHrv9hK9v
 3c2Xjyvur9Bt5mjH96j0Lf4VJRqrK7FoN1AWwms3I7+u3mZ2glNh2Im7CZjRdT+aPcaj
 y/nZZLe3AoEUVDeBWQiHGD1VctJXaPu/UpJvEiL+QSSaTWHx2t929FrjySyFI5f6U0W0
 knGw==
X-Gm-Message-State: ABy/qLYuLbqTTJSRypgJnyOanYPekZkndsOfV8kJTmbfHOlkxFMAqkXq
 WQttBXWQ004pNsRUik7D5RifjIVYJ1H//61yS7I=
X-Google-Smtp-Source: APBJJlHzK4g8lcEmJouxGDoYhtgvMDXt5/YhVTZi4upJNUytt/5T0yIVaIU8EhUtPxa1dBjH8shUDA==
X-Received: by 2002:a17:906:2dc:b0:957:1df0:9cbf with SMTP id
 28-20020a17090602dc00b009571df09cbfmr16164985ejk.19.1689077707650; 
 Tue, 11 Jul 2023 05:15:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a170906140b00b0099297782aa9sm1085053ejc.49.2023.07.11.05.15.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 05:15:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 02/16] target/riscv: Remove unused 'instmap.h' header in
 translate.c
Date: Tue, 11 Jul 2023 14:14:39 +0200
Message-Id: <20230711121453.59138-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711121453.59138-1-philmd@linaro.org>
References: <20230711121453.59138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 697df1be9e..c65be83442 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -30,7 +30,6 @@
 #include "exec/log.h"
 #include "semihosting/semihost.h"
 
-#include "instmap.h"
 #include "internals.h"
 
 #define HELPER_H "helper.h"
-- 
2.38.1


