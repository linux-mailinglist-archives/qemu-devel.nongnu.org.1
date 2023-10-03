Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8499E7B742E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 00:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qno0H-0000sZ-3S; Tue, 03 Oct 2023 18:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qno0E-0000sC-4L
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 18:36:30 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qno0C-0005Vq-Hb
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 18:36:29 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c6219307b2so10605835ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696372586; x=1696977386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rJdxKUBwtOhHhDDaKNhbEXnQNqTqh4ny1AhelVVqjo4=;
 b=ZC7M/U9MIRZlC4Mz2Wx2EDrkgJppRfcGyI/B9FPqp6XJwE/3naiOvv7RDN1VD2Soro
 ZriRCageaenjHea6rXC82YdtIYW8H1SbXJfQJn4uk8yda5h8yW1bgt1Z4lelAYhk5JHh
 1VZjvzsDoCuhgD1MecQcoDgHRDL3T5o61kDYNyUAc6C48mpOyaFI4Qp646VyIKeNdb45
 YfXH8wdAoFM7r1tC8bRa/0vn3D6XLrT1DBlI+QBm0FZsQEM5AoZbK5AE7ehhGauxdiZe
 Sh/3Ge0/lLMdC+Ys8P050bu33ShxSb2lojHrLHTZdhQvSZ6UqzPM3G7tMCBdJ87RuyF2
 6Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696372586; x=1696977386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rJdxKUBwtOhHhDDaKNhbEXnQNqTqh4ny1AhelVVqjo4=;
 b=ZJbXXiQ8EX8TrKE93RSbOpmxxex8mv5r+FSnoL7+sSFq3mY/LqNk6K+Lr5+e+26H2G
 m2/YzcvhhERi2XBquyerelu7yFMMbheD0/Dcz1CLFI3IhzTjFiUcOzVKiNGtYWNrCOQi
 a2rlrNtQMHC2qAh5eI7+gbMrUYEG2T3f/meKCy0hBnS0iZVb2dPEj6/Opf+O7QUg6OMf
 16EwVebG7NpQqn1ZDHoxjIC8cSf5Nkovf4UFUZ5uSjpOQNnuzxU6ljtT6x5RYFLIAkW/
 MoS9PGPO4lT7Nut8/Ip53O4iewasNrbsf0OCWuXRNA5po2lgxibS3LbbiJKlrYrl8SIN
 5Stw==
X-Gm-Message-State: AOJu0Yzk36P5vrdngmiscWUhXgawRq3Pogb8w/bcr1KJITBwWve3JnUo
 6YqGUo0jeNXDvF6prk6Z+ruOHOxeTxCuOHqGSn4=
X-Google-Smtp-Source: AGHT+IH9mWHkmHlkN6R0YIZLs5su57+OJxuaBobjpUemCpVyMBcAc33p6zaETdVswd9mKMQqfFkAmg==
X-Received: by 2002:a17:903:11d2:b0:1b8:8b72:fa28 with SMTP id
 q18-20020a17090311d200b001b88b72fa28mr1012466plh.58.1696372585816; 
 Tue, 03 Oct 2023 15:36:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 q16-20020a170902dad000b001c75d7f2597sm2126055plx.141.2023.10.03.15.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 15:36:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: keithp@keithp.com,
	laurent@vivier.eu
Subject: [PATCH v2 0/2] target/m68k: Support semihosting on non-ColdFire
 targets
Date: Tue,  3 Oct 2023 15:36:22 -0700
Message-Id: <20231003223624.1753000-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Hi Keith,

Sorry this has languished for a few months.  I wasn't happy with
the frobbing done by EXCP_HALT_INSN, and less keen to replicate
it with EXCP_BKPT_INSN, so I've re-organized a bit.

So far only compile-tested.  I guess gcc testing with m68k-elf
might exercise libgloss and thence semihosting?


r~


Richard Henderson (2):
  target/m68k: Perform the semihosting test during translate
  target/m68k: Support semihosting on non-ColdFire targets

 target/m68k/cpu.h       |  2 +-
 target/m68k/op_helper.c | 14 ++----------
 target/m68k/translate.c | 50 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 49 insertions(+), 17 deletions(-)

-- 
2.34.1


