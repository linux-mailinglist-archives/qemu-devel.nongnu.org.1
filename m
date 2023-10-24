Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B12797D593D
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:00:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKkM-0008MB-Dm; Tue, 24 Oct 2023 12:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkJ-0008K6-9L
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:11 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkG-0002f5-M0
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:10 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99de884ad25so708965366b.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166746; x=1698771546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=meadOaY/vISXrQ1MdYhALhEL1/kbfcMpkUIjS6WbmVg=;
 b=BhpxUCoxOOcAfVnAbLabGuMM0xAfmK9UFO/TODT2KN68dV9L5hMQ+uApDtX0oKifsp
 BVjaSQ+TZvQx4+46i58mlTEnkTns6+gTYTvbYfU5VamgvaMcN2cwIP90W4g4RRnVmIXi
 bC1ew1Rv9b6+58i1vuMwn6pWV/D+4pZfyE6upzT/4DEcNR/l3wkYu4xMAhM7ReS9gIhF
 o42h0kGD9kSI8KNEWbOGt1tHteP314vDho6HIpNypGvKm09xlcVgwdctdXf5Riq4KQje
 oqhufiq0Q/G6lnejy7RwV2UcHP60X4Cvk45fuFBknSlVNwNN5O+XHDNSp7UZ82i+qcRd
 RnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166746; x=1698771546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=meadOaY/vISXrQ1MdYhALhEL1/kbfcMpkUIjS6WbmVg=;
 b=OT4gesBscj/0vgMAX7ninhPC+SAbsp71ujs8ap6Q1Sa21eA0V5WwHkAB8Y7K5bsNJJ
 ZwopIAYT5CFOiBrvOMUlcxfrMFYmdkeIcjyvAHitdgHpkTsjVjDAv/rfpOkgyHO3soyP
 6LtU+VEDA3SMBNoRxgtf4yHWHJNykA7w5j9kOBiTX+RuSwV0Yz/5otoZor1WWilUd8es
 Q9sFEp0JThLXwNeccrXPfboItr2QP9JZ6lHJE6grL9NnkuIxuo8cDMZm58pjL2sIrCpk
 xMvKB0J7pDk0TtyqvDXOdJrKM3672Xn3rV5DyVZ/j5cdaKvf5XXGWAnw/aQe20DMSBzq
 PUcg==
X-Gm-Message-State: AOJu0YyQt6rXGEiEp1GbjEHpicZ2WjOniVlnqfTFKHnChTuNsAHHavjM
 Oc8ZR2LQj1Gm6tNlRaZflMCUFlUQSwNltNfP1m0=
X-Google-Smtp-Source: AGHT+IHVLr20r2YH9xmUmUkiDhh3FcjVPNnz4ppxyQ+jyRFj8Dd2YuKNBSohoe6k0zDggH9ecWDCQQ==
X-Received: by 2002:a17:907:728a:b0:9ae:41db:c27f with SMTP id
 dt10-20020a170907728a00b009ae41dbc27fmr9543824ejc.10.1698166745706; 
 Tue, 24 Oct 2023 09:59:05 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 n17-20020a170906841100b009c8b720cf59sm5100238ejx.42.2023.10.24.09.59.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:59:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/9] tcg: Use tcg_gen_[s]extract_{i32,i64,tl}
Date: Tue, 24 Oct 2023 18:58:53 +0200
Message-ID: <20231024165903.40861-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Since v1:
- Dropped 2 RFC patches
- Added R-b tags
- Updated 'Use tcg_gen_ext() on MIPS'

Philippe Mathieu-Daudé (9):
  target/avr: Use tcg_gen_extract_tl
  target/cris: Use tcg_gen_extract_tl
  target/i386: Use tcg_gen_extract_tl
  target/mips: Use tcg_gen_extract_i32
  target/ppc: Use tcg_gen_extract_i32
  target/sparc: Use tcg_gen_extract_tl
  target/xtensa: Use tcg_gen_extract_i32
  target/mips: Use tcg_gen_ext16s_tl
  target/mips: Use tcg_gen_ext*u_tl

 target/avr/translate.c          | 18 ++----
 target/cris/translate.c         |  3 +-
 target/i386/tcg/translate.c     |  9 +--
 target/mips/tcg/mxu_translate.c | 98 ++++++++++++++++-----------------
 target/mips/tcg/translate.c     | 12 ++--
 target/ppc/translate.c          |  6 +-
 target/sparc/translate.c        |  6 +-
 target/xtensa/translate.c       |  6 +-
 8 files changed, 67 insertions(+), 91 deletions(-)

-- 
2.41.0


