Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C35C78410A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQgx-0006H8-Ni; Tue, 22 Aug 2023 08:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQgo-0006Eu-HX
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:40:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQgl-0005Tv-Sq
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:40:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3feddbb670cso31553555e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692708048; x=1693312848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u8Ncu8aR3h9eMD8scGzi1n3AJbGQYzVdDS6hz26+JPk=;
 b=NF3/NnBqtM3teswifD6fa3hcHPneD1HhvqQpaLmWGojJnKrQn1HY5lz+I0z1WI0AWp
 7+Qlshl5m95u1vi9StXBqznx/BFqzBr26r18dHbbXGH70IpEx51Frn3hcl+Z+UXaPVXS
 rWqYewYClt1P6981XuXwxekFN2OWDQwQh/KbbztLTMDyqI4t0XChFHtWUMPtOCwv0ZVa
 C3RpkczLngV7517x95aVMh2mrnaA9aXbfjAj/I2MAFswVbY25gPjdLR9f4aYcJFvwUYy
 IUOrl/iAQHvcbmMEzUcI4agfHdgQTA9f8olSnC6ynZ4IC60nJ0j5f8dF1CbGuOSvnXAz
 RiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692708048; x=1693312848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u8Ncu8aR3h9eMD8scGzi1n3AJbGQYzVdDS6hz26+JPk=;
 b=PyITw8unjPB6E4vbKPJU9U/FcQknpFgz2rDOotswc0HNbl7LU1jqpyIb0Qr3X9CsLB
 cUQcELsvO7ESS9b6+/52B8X4Q0xRI2lhJ3YnUIarKwXFkEiGSWTR12NUhjC4raQ/5ZTa
 gdWoPFILqLOJFtT/bMAWqSG55Bez9YpKgTubOLkARKxYB6NZzC5lyrb4CowsJ0VmCS+t
 ROwyGZco6gCuUvPueNG85dBugMwZTOUjBfRSFS8LWqWXu5FBSZuQrMPqhkU/h62rajw4
 uwzvKX1/7qbLAJkH8DjF/tBoTeKIxfcq3GBAw3bpwds6ERwNcAG8RUE43swQilpUS/HI
 kAtg==
X-Gm-Message-State: AOJu0Yxo9hKBiyZ52xErgGWBEn8bj2uhlsF4allmu4qyg38Y5ff1vhKA
 PEiPzyX+GaTjBDx1x+D1MIQMqmGMh1Y/MIt5vVgpbQ==
X-Google-Smtp-Source: AGHT+IHTQSu/OSYD3zeda/IeT9Ylwcc42fD2Pwyye1FfedxYaapLjxByC2JwosoDAOvAFanbaTHeVA==
X-Received: by 2002:a05:600c:2349:b0:3fe:18be:76f8 with SMTP id
 9-20020a05600c234900b003fe18be76f8mr7377654wmq.38.1692708047726; 
 Tue, 22 Aug 2023 05:40:47 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 x26-20020a1c7c1a000000b003fc16ee2864sm15541120wmc.48.2023.08.22.05.40.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:40:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org
Subject: [PATCH 00/12] tcg: Factor hrev{32,64}_{i32,i64,tl} out
Date: Tue, 22 Aug 2023 14:40:30 +0200
Message-ID: <20230822124042.54739-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series factor the "byteswap each halfword within a
32/64-bit value" code duplication as generic helpers.

Modulo the documentation added, there is a good negative
diff-stat, so I believe this is a win from a maintainance
point of view.

I used "hrev" to follow the other bswap/hswap/rev helpers
but it isn't very descriptive, so any better name suggestion
is welcomed.
(In particular because there are other patterns I'd like to
factor out and then naming is getting worse, such 'wrev').

Philippe Mathieu-Daudé (12):
  tcg/tcg-op: Factor tcg_gen_hrev32_i32() out
  target/arm: Use generic hrev32_i32() in ARM REV16 and VREV16 opcodes
  target/cris: Use generic hrev32_i32() in SWAPB opcode
  target/rx: Use generic hrev32_i32() in REVW opcode
  tcg/tcg-op: Factor tcg_gen_hrev64_i64() out
  target/mips: Use generic hrev64_i64() in DSBH opcode
  target/ppc: Use generic hrev64_i64() in BRH / BSWAP16x8 opcodes
  target/loongarch: Use generic hrev64_i64() in REVB.4H opcode
  tcg/tcg-op: Add tcg_gen_hrev32_i64() and tcg_gen_hrev_i64()
  target/arm: Use generic hrev_i64() in Aarch64 REV16 opcode
  target/loongarch: Use generic hrev64_i32() in REVB.2H opcode
  target/mips: Use generic hrev32_tl() in WSBH opcode

 docs/devel/tcg-ops.rst                      | 10 +++
 include/tcg/tcg-op-common.h                 |  4 +
 include/tcg/tcg-op.h                        |  2 +
 target/arm/tcg/translate-a32.h              |  1 -
 target/arm/tcg/translate-a64.c              | 11 +--
 target/arm/tcg/translate-neon.c             |  2 +-
 target/arm/tcg/translate.c                  | 14 +---
 target/cris/translate.c                     | 20 +----
 target/mips/tcg/translate.c                 | 24 +-----
 target/ppc/translate.c                      | 10 +--
 target/rx/translate.c                       |  8 +-
 tcg/tcg-op.c                                | 81 ++++++++++++++++++---
 target/cris/translate_v10.c.inc             |  2 +-
 target/loongarch/insn_trans/trans_bit.c.inc | 30 +-------
 target/ppc/translate/vsx-impl.c.inc         | 19 +----
 15 files changed, 99 insertions(+), 139 deletions(-)

-- 
2.41.0


