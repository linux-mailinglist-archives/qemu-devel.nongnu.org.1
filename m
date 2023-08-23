Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D224A785B3D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpHk-0006qH-IB; Wed, 23 Aug 2023 10:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpGv-0006jK-6k
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:55:49 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpGt-0007Uy-Bg
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:55:48 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so743584766b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692802545; x=1693407345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=znIwo+dRyuUc5vrw5L+zAF6PpY5Nurgy0Cu6pw1b0r8=;
 b=VFGQaj1uUpNReStTeankvKpHVvRZH/PiPnGc0pPJwrzAOijBxYsn9vn6SGU5HeiiNI
 yOb/AIjNQn+w33jmEdVWE69rGaXA0jjeDxHjWxPLo0XmLaoUYxk+oCHjB4WnNg27JN4I
 6D11TwSzqTT+uoMiZSTRO4u3FMbUXWUkPPoT9gBQ7kaPz4TDcpxPxQ3uI0ReBtELNGAi
 jeB4O58Lc4Lqsk51+LGqMsTzHswaWz8sxVXm1grylUFjUtgV93FZxRRETLH2h9nnf0SD
 d85iUkR3Omc2Ib+Fjp13rcsSuNuPb6QGLzyuqzCl0wGen9aOcL1hRaglmx5V8vrKkVQc
 f04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802545; x=1693407345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=znIwo+dRyuUc5vrw5L+zAF6PpY5Nurgy0Cu6pw1b0r8=;
 b=gABCcsOrfUc0j6rxy8uLe5RjdKjx6HEXYOWEzJ7so5Nx8QYTMA8hDik2Ncbt4+yUON
 pQabpuYwU3b6JUNUZOzjpt8VmUkJq2zxJZNBBVd6WttPpR2x6c7IvuV5iie/mZYFpXSq
 2xGIpL6ddhYcDLrHQ2jM+4ZW/wM8AGUFefMNxGJ66VHtujSVns7E/v4sPVsJDahkQYzm
 czoHkSIb4Irk4QMvSEMT+wUS7Kr662GadUwaAPRoyO40Lz3fOcRWI1TPzWeOtQur2KPX
 w+NICeQ6gh3RdTs6Nula4hTOXRrCmEi0iOBC3OdlUVQYIOPDibEgnEtUvRjk+2LBlMcL
 T22Q==
X-Gm-Message-State: AOJu0YzCGs0pZGPyCOT+qwUCprYJYU9bho9RAd7k0ZRE7e4cb5IwCgcp
 7HgNK/B9nplMGUZcWZEGVkhcABmLAUqGPICAItTyNA==
X-Google-Smtp-Source: AGHT+IFz9xaXq5v+t+apIB8fe+NzAWW5O3EyrEpuGtCTHdKn36xXvabG7PZBOAlNUjxMisumV5RKCQ==
X-Received: by 2002:a17:906:cc4c:b0:9a1:fc1e:19af with SMTP id
 mm12-20020a170906cc4c00b009a1fc1e19afmr23974ejb.36.1692802545376; 
 Wed, 23 Aug 2023 07:55:45 -0700 (PDT)
Received: from m1x-phil.lan (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 lw26-20020a170906bcda00b00993a37aebc5sm9778977ejb.50.2023.08.23.07.55.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Aug 2023 07:55:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/8] tcg: Document *swap* helper implementations
Date: Wed, 23 Aug 2023 16:55:34 +0200
Message-ID: <20230823145542.79633-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Since v1 [*]:
- Split few patches
- Dropped 'document deposit_z()'
- Document TCG_BSWAP_IZ flag (rth)
- Added R-b tags

[*] https://lore.kernel.org/qemu-devel/20230822093712.38922-1-philmd@linaro.org/

Supersedes: <20230822093712.38922-1-philmd@linaro.org>

Philippe Mathieu-Daudé (8):
  tcg/tcg-op: Document bswap16_i32() byte pattern
  tcg/tcg-op: Document bswap16_i64() byte pattern
  tcg/tcg-op: Document bswap32_i32() byte pattern
  tcg/tcg-op: Document bswap32_i64() byte pattern
  tcg/tcg-op: Document bswap64_i64() byte pattern
  tcg/tcg-op: Document hswap_i32/64() byte pattern
  tcg/tcg-op: Document wswap_i64() byte pattern
  target/cris: Fix a typo in gen_swapr()

 target/cris/translate.c |  20 ++++---
 tcg/tcg-op.c            | 124 +++++++++++++++++++++++++++++++---------
 2 files changed, 107 insertions(+), 37 deletions(-)

-- 
2.41.0


