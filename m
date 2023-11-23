Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 853557F6374
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:58:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C4L-00064u-MB; Thu, 23 Nov 2023 10:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C4I-00064j-FL
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:43 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C47-0002OP-Ks
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:42 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3316bb1303bso577755f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754990; x=1701359790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEdSmkJwzInLFglPGcgp4iVv0Ps+y0cBfXLNR+PGsPc=;
 b=Qg+GO6ldHmaOxcF86oq6wWezq8ULBbz4eafu3KqBwAoABm9Ty96A7n2zEuhw2shdQd
 spu/Jly5rGl2PBjfxicdibNgqTKt7FOxQgNaDcCf7lndSWHavO/YKM5CXcFgJbgzYe9N
 D4fdr2Mg92ZPplLFICyWjKd4rPYEZaruUXUfWXwDOW1REk3ZOH4H2C7abWaFnEP3isyT
 UvEZhpbGFPLnVvx+sWOX7jo4/IJSro5JA+vXzPF3nS+97cF5z5z2pcU/OHvBqQ0eUCI/
 8VyJX8GO3QjYdKgj0Fu4d30ZSTdkeE1k+qWIkz66Ps9XXYEst9JFV0brX6QfJ+eBgu/X
 LDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754990; x=1701359790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEdSmkJwzInLFglPGcgp4iVv0Ps+y0cBfXLNR+PGsPc=;
 b=lw+4pEjIMHL6dTbJBp1537GFePghQa/15KQkMdFXwPU9bHILhZo3c1rj8EKR1NNMVh
 XjsSGLih1cElw2iTn1WJhub+UxJt33xODqX57Z3oSPwi5ekNOm3VzfFIov1gKeLmO9kL
 ynoVd405v7G4xAynrodfJD0utQqCKwBTuVBQ0sSMB1WrFxp0yooBW63gD90OB+34n4R7
 IzXAF21UTOd0gfm5t86NvH+bhuA5kYkcLuWVmGS4ylRvP/VyIZoz1b13BoM5Kl/evTRu
 FUPQmg0C8Gxeg87KgObZVoGXPHGeLx3nW2Cq8G/QA1BwJE1KeWAKmeYA8im5sehSOJdP
 DnOg==
X-Gm-Message-State: AOJu0Yw+JM11gCP72I1IdHBsvgkQ+zl1Y1EZ3JTAbC7yRjwkep6fpW8p
 mpXOA9dFcTUYVqxe1tGh/MuoZQ==
X-Google-Smtp-Source: AGHT+IEyfkYQ99ehd5Ih/8YLNuE0Wq0L0pjpZsnxn6XyEDLrCzBFnNQ4lb6maxg9j2HihIgwfxT5oQ==
X-Received: by 2002:a5d:4576:0:b0:32d:a221:446 with SMTP id
 a22-20020a5d4576000000b0032da2210446mr2570780wrc.59.1700754990006; 
 Thu, 23 Nov 2023 07:56:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f6-20020adff586000000b00332e1c46dddsm2066268wro.98.2023.11.23.07.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D275645FE;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/14] hw/core: skip loading debug on all failures
Date: Thu, 23 Nov 2023 15:56:15 +0000
Message-Id: <20231123155620.3042891-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ELF_LOAD_FAILED is one of many negative return codes we can have. Lets
treat any positive size_t as a success for loading.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231120150833.2552739-10-alex.bennee@linaro.org>

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 3c79283777..e7a9b3775b 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -505,7 +505,7 @@ ssize_t load_elf_ram_sym(const char *filename,
                          clear_lsb, data_swab, as, load_rom, sym_cb);
     }
 
-    if (ret != ELF_LOAD_FAILED) {
+    if (ret > 0) {
         debuginfo_report_elf(filename, fd, 0);
     }
 
-- 
2.39.2


