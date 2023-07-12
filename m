Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A50074FF0E
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 08:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJT1T-0000Yb-S1; Wed, 12 Jul 2023 02:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJT1I-0000W7-MK
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:08:12 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJT1H-0006ws-5t
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:08:12 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9923833737eso755545366b.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689142089; x=1691734089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3szu8ghL3u+CCDpVqiPrJrYsfL+9qCD0zYeOF0+PJvU=;
 b=v9bsfnsK/7AURRvaYCj1a5UOu6w85ODbi8Z9/mKrsN16dQRp3wKhxdUEK5OE9SnbAn
 Put2tJDp7B7vw3d30wjk4YJ30o5n2iEM1VoxybOBMHxGVuLGpmU8RJD2ZJg1Dfzc6c9j
 d9HFBgAQmO/GFsPGJ/RRXcfHS2h2f8Tb7XNNomPI8DVXfHzxYlJqw3pJdTHXzWjeNjJv
 cMgdtyYjI9f7G35kqu3X6NgQfSuxo0ppolkt/TtDDMtHlQE7i0PmEa6wPFYhgUqrr0Bh
 DEBUAgjVzpp3CNQOBHCruJc2DSgqYH870lbVFu23sPHzDP7fDHuPH92NO0n0uLPGwgyz
 C4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689142089; x=1691734089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3szu8ghL3u+CCDpVqiPrJrYsfL+9qCD0zYeOF0+PJvU=;
 b=NUhmZpkW40iyuWUzk4DUJ8I5AqMxBpVhnFoPLa8prsaCAGISlXdLgpeOohP3QvICFB
 gZuVikwOLHlyWgybnph4GA89lSqzJtUOuKVVjCkUOmJNqVw09W6LdFsv7V+wKK7Uk5zX
 JaRHjE4KQ3geebkAz7NxaUH5fElqq01+6muX68xTIQ/rICEwJnRFIiCBnAghwOWWE/9K
 oyCrmzmvbj0beSY58c1yM9ZvL+Ux+G3KCXCXv5rRv1h/3GvVysO/Cf4Y144DeXLe2/wq
 C3ZHQtIPgdjtspBq2T8ThbraRN6GZXDE55NmBZHyFsaatNMzVtN2rdazJq6dtboBmnHE
 X21g==
X-Gm-Message-State: ABy/qLalZUVrP1JrXy8wmZEdFeAgGGxSpQm44JPuPUbQAoQwjb8Ppi1j
 OTJf5A+k+3fdNQ4pQIt1vdlRd+zHkGrXh0aGS54=
X-Google-Smtp-Source: APBJJlGfdRr+FQvOKYy9kf3DFnfDIz+CruRoyvquh2sazNws4K/+lz/Pe/ZPnPGsOI0MK2jaeVEU7w==
X-Received: by 2002:a17:907:124d:b0:991:d2a8:6588 with SMTP id
 wc13-20020a170907124d00b00991d2a86588mr18166125ejb.51.1689142088945; 
 Tue, 11 Jul 2023 23:08:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a1709060dd200b00982d0563b11sm2059473eji.197.2023.07.11.23.08.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 23:08:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Craig Janeczek <jancraig@amazon.com>
Subject: [PATCH-for-8.1 0/3] target/mips/mxu: Fix overruns
Date: Wed, 12 Jul 2023 08:08:03 +0200
Message-Id: <20230712060806.82323-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Fix overruns mxu_gpr[XRb - 1] reported by Coverity.

Philippe Mathieu-Daudé (3):
  target/mips/mxu: Replace magic array size by its definition
  target/mips/mxu: Avoid overrun in gen_mxu_S32SLT()
  target/mips/mxu: Avoid overrun in gen_mxu_q8adde()

 target/mips/tcg/mxu_translate.c | 36 +++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 11 deletions(-)

-- 
2.38.1


