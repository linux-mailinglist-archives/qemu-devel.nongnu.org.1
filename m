Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8F8722E0D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ESD-0006Af-Lb; Mon, 05 Jun 2023 13:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ES6-00064c-9C
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:57:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ES4-0001Y1-On
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:57:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f735bfcbbbso16957735e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685987827; x=1688579827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4h08X8wNRk/W0u78n9MISqwTuuV4tVr3G/frFQxS+nI=;
 b=fcKTKezUZ/2SC65EQvQcTdBnbWzOpKzYNcwLoJiBXZ/uGvBPcBZuoXScM2Th5M20eQ
 poWoihXSCRNZo0BnJFQ5EJEG1YYgBZpUTcKpdZQUMpcXTJOEmbiSVVQcOwjazsl53qEe
 6XkYgA+N1jaf/e8eLlJfseOFOgNM2j+BTFwtXpcr9uNw/zCP6wiel0VyUGdXY0TtLEuR
 f0okmS/JN4REKY+s8TIq3taaIAAAIAzzlcFgcrEozH35UcQarVcnH2W0x9cdyxlgHYz5
 agEz0M7/qo3AOoBmFagcRe0aEsOwz0ZDYVlKB3Lb8Sco7PF+NeS98k/WM9On6T03xAWb
 mdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685987827; x=1688579827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4h08X8wNRk/W0u78n9MISqwTuuV4tVr3G/frFQxS+nI=;
 b=AM3cJCbI2cyz1jzp7m0pRfmC23v4BDej8d18RtLKEqUM7TgHq6cxXOtAY5yxgQgddY
 5kMXrDxOeXFH8+qw06clPUj++Z3xVO6Qon2aF5YSFLlkpOGaANUDWJPYjirV7b4o5nAv
 TYkj07LG8F40VAiGQrEq0tNzNvH/SOdHmz8sUKgDQsnVCIfT6lsN6xTYZxftBpw++F9V
 W2OCXRGv+E9KqULLJUMK/owfgf9bPwE9EVmZDn8FKnC7P9uQkCfep871GIIj0ItOOk5N
 5apeHmVnq+fq3zSeusVJGzIdq9KoC46shJIzmWdMAxaw0n/iE4LMdRE3haXpm4U3/XCH
 vabg==
X-Gm-Message-State: AC+VfDzZIVNKtflBINRCf7qsdfFtNs6XzRBXKMX7abXU85KjozRumnbO
 YLRqWDUbLwgqu9bOUyeKHLOxzd2U6XHg13ST6lU=
X-Google-Smtp-Source: ACHHUZ5MnBKCAy5UO8GyEd5jI/AWhsL54b3kieEzjxt6yHR4BsoVl/Gl4Y4gauBsUzIrEazivs+sew==
X-Received: by 2002:a5d:4d82:0:b0:30e:32b4:88a9 with SMTP id
 b2-20020a5d4d82000000b0030e32b488a9mr4196675wru.5.1685987827201; 
 Mon, 05 Jun 2023 10:57:07 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a7bc7d0000000b003f605814850sm15194456wmk.37.2023.06.05.10.57.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 10:57:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/5] qemu/uri: Use QueryParams type definition
Date: Mon,  5 Jun 2023 19:56:45 +0200
Message-Id: <20230605175647.88395-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605175647.88395-1-philmd@linaro.org>
References: <20230605175647.88395-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Follow QEMU CODING_STYLE, use the type definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/uri.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/uri.h b/include/qemu/uri.h
index b43f35a6a6..2875c51417 100644
--- a/include/qemu/uri.h
+++ b/include/qemu/uri.h
@@ -96,7 +96,7 @@ typedef struct QueryParams {
   QueryParam *p;       /* array of parameters */
 } QueryParams;
 
-struct QueryParams *query_params_new (int init_alloc);
+QueryParams *query_params_new (int init_alloc);
 extern QueryParams *query_params_parse (const char *query);
 extern void query_params_free (QueryParams *ps);
 
-- 
2.38.1


