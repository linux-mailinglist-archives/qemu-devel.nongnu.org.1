Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31207783D02
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:38:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNpB-0000SI-8j; Tue, 22 Aug 2023 05:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpA-0000Rb-0i
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNp7-0001ea-MS
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so40567595e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697035; x=1693301835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=By2scDfpsI642sRWhvtzZHy47CDzblUOx5DkV3YceXA=;
 b=hMeUjkTMIdskm+csKGgDGceGsjJeUULW9/ft7jhExtaeG+FHM/H3eeUe9u/TGVpDcU
 LTSnoHdtWn2LhCn8SEr5gf8nD61L5SCrZ3/pK2fnpNzNm6K9+zaCdtbLUnKX5MklUQD+
 D1LrWeluYOdZ0Podg8tZq9w4k0CDjUsDWvtI/K70PLL3D5SnVFj0vpe3jtSyxAOs1q3T
 e8ltAiI7lg7xcAwvqswICnPnH7z09qYNSbTWyiHTqhbM2R9cztnEbeI3EFUqmVV2c2m5
 VbcWNJnwjDzPesMCB0j5beq9yTHiZfMTYCLupC7qljw14H8Q19WPQ7T5vepEaP22mFX/
 T7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697035; x=1693301835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=By2scDfpsI642sRWhvtzZHy47CDzblUOx5DkV3YceXA=;
 b=e60EBrhTQfkEMr8DmBTunOGy0oD2uNBa8d7d+PapgIiUAm5FGklTrFL4P6vkBx6F0w
 v6LYIxklXgwKCuWjr/RbskOr0Jiq89d7XAVOg4ub6tl2skSDA2ceVHNb2WAAaoPKh+U2
 AL0OEAhTipLXlsaROWxYIg03bU1FjNcONlZvi2mXUhDDQIH0AEIHSyekrq1nAqVIgeKX
 bmFO/t8cUGCYVSyRltb3SVtvXWZvR4x5FoSuq+QgiE6XihcDeHzbePrV5sFHl56gnj/l
 w4vzICpJlTr1QK9DEnlEzauf+UdjlJgQS79wLCj8BVNQ6snqb5r32k+T3ZsBOFQtJqr5
 woYg==
X-Gm-Message-State: AOJu0YxSD6mdyhZP/iaBoNoP/gb+8h4wL27CE2yZGqdrN/2ZigbF1y7C
 1rXZ4VNPu+Dn8T8EiYoZUT+wOdI8nFfy+w3dJis4sw==
X-Google-Smtp-Source: AGHT+IG6PwOjzGuied8QRhomfilX9xb/5HaLXRmpn9s9sHAgW4zXrKa+Xc2mGOUnnq1pacopF13SLg==
X-Received: by 2002:a1c:f711:0:b0:3fe:173e:4a34 with SMTP id
 v17-20020a1cf711000000b003fe173e4a34mr6785970wmh.40.1692697035461; 
 Tue, 22 Aug 2023 02:37:15 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a05600c0b4900b003fbd9e390e1sm18884536wmr.47.2023.08.22.02.37.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 02:37:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] tcg: Document *swap/deposit helpers
Date: Tue, 22 Aug 2023 11:37:05 +0200
Message-ID: <20230822093712.38922-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

While reviewing a recent patch from Richard optimizing
deposit() [*] I ended looking at the *swap friends, taking
some notes, which then evolved to proper documentation.

[*] https://lore.kernel.org/qemu-devel/20230816145547.477974-3-richard.henderson@linaro.org/

Philippe Mathieu-Daudé (7):
  tcg/tcg-op: Document bswap16() byte pattern
  tcg/tcg-op: Document bswap32() byte pattern
  tcg/tcg-op: Document bswap64() byte pattern
  tcg/tcg-op: Document hswap() byte pattern
  tcg/tcg-op: Document wswap() byte pattern
  tcg/tcg-op: Document deposit_z()
  target/cris: Fix a typo in gen_swapr()

 docs/devel/tcg-ops.rst  | 12 ++++++
 target/cris/translate.c | 20 +++++----
 tcg/tcg-op.c            | 96 +++++++++++++++++++++++++++++++----------
 3 files changed, 96 insertions(+), 32 deletions(-)

-- 
2.41.0


