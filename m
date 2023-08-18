Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C3F78115F
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:14:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31m-0008FV-En; Fri, 18 Aug 2023 13:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31j-0008Er-Rj
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31h-000821-PS
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:47 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bc73a2b0easo9420435ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378764; x=1692983564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jBDFYDN4txkYXCl4MK4JvDX5trolAszB5+TZawsyMV0=;
 b=Pxt1d9D+XP0sFJvyHYNG15isOnN3taKco+vzi1yxM43rFgGnHIosqnwtOR+EcrzM1m
 ZxrJ4+LEbtN/H7B1Ih4SoLJXwyK3TtA8AD+M0JkqvGZZNfLE2ycs7uUMKgkygN1kDk1b
 xR7BIA6BEfIxZBXae6edvUDWQZEKOqk2XsrYWXJPkL+5ObdblBWLF0YsJJLTEopCo8Fn
 9d4C7WxHMu6pKjUIWvz77Yc3PGzwAornGG9VLg+h3r5IfJgn6TgJLRWZehWNHspFROTn
 G8OxC9PWJhn1X0rAKSatvDAqfl2JvjURvEnwt+CaGi34H4wQLVUHho99AV07mX2kiayq
 rGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378764; x=1692983564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBDFYDN4txkYXCl4MK4JvDX5trolAszB5+TZawsyMV0=;
 b=YmRn8jFoXslRGqEd0bx+QFf1oRx2/zSv5eVQgx55ghquG2/VbRb6itVS0ZyReZdUxx
 sPlG38ULF+ISaezHbktZTDQK7ngcAlq3ZRaX0RlAooiz6AoK2Jux3DWbt0gump8TXyOr
 OLLd80LzOrWzfn+wor4RQ0nJCguN3T38yM8V2ZjBxDWGs4XllvUz2Recj5Q5AMPVt5SX
 W/10HbHdV/nvoRFLtvBlZCLCWzNExMhTJA0P1g1ZXvkBL3CsZz44m8xDpG30FbCy7qq+
 5gXpBPrppm4vxHMT3k19RDjP1yWAFwI1VhNEjXAIKC4GwgVvM0sqTzRTLneWH5HXeQPn
 eUfw==
X-Gm-Message-State: AOJu0YxnZfs4Qflt4A/12uALdKdlP9Hzh6OP35JZpHgbzCmXyv4nWEx3
 8K11ojAWKUWGpkz1rjxBhhatNbdOvimg1JwQOn8=
X-Google-Smtp-Source: AGHT+IHKnK6l4nJuZTkeTFcBfpDB31w2oEYvB24UDbHX8eQqMfTRVX+iIB5mo3lkyn1WHd2kkrwhXA==
X-Received: by 2002:a17:902:d904:b0:1bc:25ed:374 with SMTP id
 c4-20020a170902d90400b001bc25ed0374mr2911066plz.49.1692378764559; 
 Fri, 18 Aug 2023 10:12:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/33] hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
Date: Fri, 18 Aug 2023 10:12:06 -0700
Message-Id: <20230818171227.141728-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

The size of the allocation need not match the alignment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/tpm/tpm_ppi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index 7f74e26ec6..91eeafd53a 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -47,8 +47,7 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
 void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
                   hwaddr addr, Object *obj)
 {
-    tpmppi->buf = qemu_memalign(qemu_real_host_page_size(),
-                                HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
+    tpmppi->buf = qemu_memalign(qemu_real_host_page_size(), TPM_PPI_ADDR_SIZE);
     memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
                                       TPM_PPI_ADDR_SIZE, tpmppi->buf);
     vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
-- 
2.34.1


