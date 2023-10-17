Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCFA7CC353
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjLd-0002nq-GS; Tue, 17 Oct 2023 08:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjLb-0002nP-QL
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:38:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjLa-000797-51
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:38:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40651a726acso50884015e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697546332; x=1698151132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OhFMjHcLTmx5YMC21w64yYqtjreemJg/ZrxDkYX/VNk=;
 b=Nb+pvSEFiLLB5u7XOd9ciyaWPCmfVoRHcRKEMkqeeqN54S8a9eQpcvr6ljEtCerlXg
 yWKwtfv6s/6zN9owdK5ewXTeOdw9CFHRJ0alCoY2qUlyHJHF+q3pDiBqyz7tdDYSV98w
 dH1bNXjdAc6BV4SKHYAnTICc9JNMsp9fU2cUu231RW9mpb1r672b+bmZykg2UPD7v1ZZ
 GSe2aMgZHiHoxo2C7Y8nTjAsum4a71wMp8enHjGwPZmLeG7tuVYS+x0clIMFXFMEQ0/x
 z2qUZNHIuJ/ayQJvvjKukPc2mYrfpj5PU66XLiORj41DEhQZKfJKcN53HoIFCBy7IYiH
 kzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546332; x=1698151132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OhFMjHcLTmx5YMC21w64yYqtjreemJg/ZrxDkYX/VNk=;
 b=IxCFUB81DHyZjIrqSn6OSqNYSWYu+XR9Ig4hYdrDsb3g++Q1hOBp07A1X0H+OUhCfY
 AMUsTyTVJ66Bmd6ikneqsJk9Kwoynyr58lzyad5j+qCUs979XCKh4FSuitcZ53G9noGX
 v5lIxUcH95Kho6/fpxz89e/fXpVS8k40Lk8pPXoWsXOaJ4Q0J0ei82eI7eEM7UEk69N/
 lOYxn6ArB/+znqLjUtzF/BsFeExWlAPRXtAcEkJkFVp4T1LSyhHNG+gQDQ8+ccWi/wTy
 nYPqT2419WKAapejo1Q8u0Nt9OUzEmX0zeduSzZQA2obKDDLP6FNzgHkrKkvMXyX1LcO
 RWPw==
X-Gm-Message-State: AOJu0YzRi9G3E1oVFgxtBbsasrZU6JbNYSJG8OCcVlA7IGmAZoYDbRNy
 KysmOVgyB8KM8fOQCCIaJXDJdpuQa01i+LIvT1Qw/w==
X-Google-Smtp-Source: AGHT+IEmApoktBjcNJY9I3tctSnyJr1Al8jxoYTyEP0TvEOGrm92ejk+Mjn43rvgmqfzCrFIc7Zj2A==
X-Received: by 2002:adf:cd08:0:b0:32d:967d:1bae with SMTP id
 w8-20020adfcd08000000b0032d967d1baemr2070609wrm.0.1697546332281; 
 Tue, 17 Oct 2023 05:38:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 l8-20020adffe88000000b0032d9548240fsm1602074wrr.82.2023.10.17.05.38.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 05:38:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/2] target/loongarch: Use i128 for 128-bit loads/stores
Date: Tue, 17 Oct 2023 14:38:47 +0200
Message-ID: <20231017123849.40834-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

RFC because unsure and untested...

Based-on: <20231013175109.124308-1-richard.henderson@linaro.org>
  tcg: Add tcg_gen_{ld,st}_i128

Philippe Mathieu-Daudé (2):
  target/loongarch: Use i128 for 128-bit load/store in VST[X]/XVST
  target/loongarch: Use i128 for 128-bit load/store in XVLD

 target/loongarch/translate.c                | 12 ++++++
 target/loongarch/insn_trans/trans_vec.c.inc | 46 +++++++--------------
 2 files changed, 28 insertions(+), 30 deletions(-)

-- 
2.41.0


