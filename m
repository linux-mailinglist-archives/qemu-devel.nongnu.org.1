Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9D78F413
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:32:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qboJZ-000058-Lb; Thu, 31 Aug 2023 16:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJD-0008W0-Cm
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:32 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJB-0002Zk-1D
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:31 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99bcfe28909so140399566b.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693513827; x=1694118627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GPoMTlp876b4GOvagv/YEBtZYu5eWFRVSdZFP4aw4Ic=;
 b=rVaHC0UQAlTx0n+qDCiwgcD/ypK5+rMl/oLyBfsgmsddH+6gohCXq0o6/dX2S+DNwx
 EXKr1VWpTQfyLcuMR/oQLaj470dGkWzat1Gbxk3zqHUitox5quv1BIHxvsdNHcLF2vNA
 u/Y58mIbhPWrnaB3HvA3SrViKmOdFZh7xAhjAH2Lb3zPcEFer2EyTERO1S5nMa6uqGoO
 80jzQfMWglXQi9rhn6SE/Psm38xdlD7T+WURJ1U6TGNf7FAZLq1OdoUC6guzR1xLwCkq
 3qt3GJqtZ9TCFqo3Its25bl5RchzaCw3PpCMV6iTjHHZWO7ROEZpSbYpwT95Lmk0zhI0
 90wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513827; x=1694118627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GPoMTlp876b4GOvagv/YEBtZYu5eWFRVSdZFP4aw4Ic=;
 b=kcal+G/Q9dFAm+BSSF3kbvPUY7b8l2yyrwhieowakAwLT+p83zEbUIZzp1AZAfgTrt
 bQXdDx9MrT1af8fuOst18d0Z51nF20342OBpURrK24pe4S/502a4RWU+4oEZqNluJerG
 bYDBNZr9K7Uk8XdQomo469Vxl0app9bOt90VIZEB4LI9fogZb6IZiKZAOyR7mlnlZ0kD
 /mAly5rgd3Sz6b65Dc/JK7RXTc0s/pLQVLUvuBluWc5rjcbgjf7EPFr+OZ5vLP3CuQmT
 E8ZL1Hsqbd/qUfv/Cf9B2pDV4kqa3Tyz/OMXODe9kNOnVioOjKV1HcdNot0aXUhIljhg
 TIEA==
X-Gm-Message-State: AOJu0YxDoxDumfCjwiPdlECcaPkKoIxTN9mKfyTM0wiKuWXx64klRiQy
 15ti/QKQ19Bn1Z15MRGY1zedS5EgtCSmTlbd2+I=
X-Google-Smtp-Source: AGHT+IH0hJ8tIdH/KxlvGDjtrgqF4/fOx0h+Xje101YuuBelFW1yHqtAojUzcJ0BdFaMKasz7pn4hQ==
X-Received: by 2002:a17:906:5a5b:b0:9a1:db2e:9dbf with SMTP id
 my27-20020a1709065a5b00b009a1db2e9dbfmr278843ejc.14.1693513826789; 
 Thu, 31 Aug 2023 13:30:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 qq7-20020a17090720c700b00992afee724bsm1121684ejb.76.2023.08.31.13.30.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 13:30:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH v2 0/7] target/mips: Convert Loongson LEXT opcodes to
 decodetree
Date: Thu, 31 Aug 2023 22:30:16 +0200
Message-ID: <20230831203024.87300-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Respin of old series...

Since v1 [*]:
- Fixed '!is_double' check (rth)
- Rebased (removing tcg_temp_free calls)
- Simplified MULT[U].G (rth)
- Added R-b

Cover from v1:

  Loongson is next step in the "MIPS decodetree conversion" epic.
  Start with the simplest extension.

  The diffstat addition comes from the TCG functions expanded.
  The code is easier to review now.
  IMO this is also a good template to show how easy a decodetree
  conversion can be (and how nice the .decode file is to review) :P

Please review,

Phil.

Based-on: <20230831201140.85799-1-philmd@linaro.org>
          "target/mips: Simplify Loongson MULTU.G opcode"

[*] https://lore.kernel.org/qemu-devel/20210112215504.2093955-1-f4bug@amsat.org/

Philippe Mathieu-Daudé (7):
  target/mips: Simplify Loongson MULTU.G opcode
  target/mips: Re-introduce OPC_ADDUH_QB_DSP and OPC_MUL_PH_DSP
  target/mips: Convert Loongson DDIV.G opcodes to decodetree
  target/mips: Convert Loongson DIV.G opcodes to decodetree
  target/mips: Convert Loongson [D]DIVU.G opcodes to decodetree
  target/mips: Convert Loongson [D]MOD[U].G opcodes to decodetree
  target/mips: Convert Loongson [D]MULT[U].G opcodes to decodetree

 target/mips/tcg/translate.h       |   1 +
 target/mips/tcg/godson2.decode    |  27 +++
 target/mips/tcg/loong-ext.decode  |  28 +++
 target/mips/tcg/loong_translate.c | 307 ++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c       | 264 +------------------------
 target/mips/tcg/meson.build       |   3 +
 6 files changed, 376 insertions(+), 254 deletions(-)
 create mode 100644 target/mips/tcg/godson2.decode
 create mode 100644 target/mips/tcg/loong-ext.decode
 create mode 100644 target/mips/tcg/loong_translate.c

-- 
2.41.0


