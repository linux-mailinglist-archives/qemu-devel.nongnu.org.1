Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 613A47FF80B
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 18:20:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8khN-000551-Fs; Thu, 30 Nov 2023 12:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r8khL-00054a-Rs
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:19:35 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r8khK-0006dQ-5W
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:19:35 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c632a97786so354759a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 09:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701364772; x=1701969572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=37m80Sr+MJhJOm8ngATALzjP14GgCjasGIeVOeueyPk=;
 b=ddsy8EiuH8ZHx7qJ7TDZung8DHWv4rjiDGtDIoyO/2uNLGoH/g6wpO7d8uLUfokV39
 jqSgkT0QptUQ8pOiw2zjO2/zympdyHnpOtfpwkHV3F4XA+LvRvWiOTDPtVPlW0m49LTy
 qW4flpR8Eh11VmtFaR1Vzd0LqtSQBX4+28t62p/An1ZbbrkvNCicPefY33USesykQbMk
 alQ4V/K7AS0+uV9pEpgn3dsWWSyEavmaBuFt+pmTw5m/zI7B7OLMY+FbCvAuAedgzqH5
 M9GKgOaFKz1m1fRH3RVEOojapSoXFJsfavdv0t0rVTdJSlsLflaAOhTDkptETg+P/iSx
 G7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701364772; x=1701969572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=37m80Sr+MJhJOm8ngATALzjP14GgCjasGIeVOeueyPk=;
 b=oSYy8uvM7GqYg/7putKubYinoh+Q8eI2qQuxs/2RhPI+y3VKvPCe3FNuh/HzDoALOQ
 ygDPkd/A/mBF3y60K3RwbKN68amx3Dn26ya5DPJYILGjBjBRI0xdbuS7qzixGtHl6Fst
 qtatMBObsLRUKcn86s63sdO1ZS1cWUPqfdH1vcEIGqQSmsC6jT1XPC5SnfUYRUNCx6eX
 2lb0PHMKggi7FS7Y+wLT7065swLxKw3+MtyDWnS9H+4I9QMF04LqYTJZZy0XzzFC3bHe
 P3o1uAysrB2qE5IZtDuOCNhrOz9DfAHDonWoeJGGWid+FwIMyanQiAMpPSk+DXOiwtvB
 Auxg==
X-Gm-Message-State: AOJu0YxEiiuH5pPaA/bulWuwZ8eDOFxy8nMDiOpv+2s+09G+BPfgGDUs
 SeUc25bVlTS12i7QJ+MkYlFgpzZqFQY=
X-Google-Smtp-Source: AGHT+IHqUrfh37uC+jl0qJhFl6zlZ60eyvO84DCFGHxr2HybtoWEhBY3EllI3L1sFxlDHK/tuA17bw==
X-Received: by 2002:a17:90b:1e02:b0:285:adb1:6acb with SMTP id
 pg2-20020a17090b1e0200b00285adb16acbmr17619791pjb.29.1701364771973; 
 Thu, 30 Nov 2023 09:19:31 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:646:a201:19d0:7eb0:c76b:d82c:8f94])
 by smtp.gmail.com with ESMTPSA id
 bc3-20020a170902930300b001cc29ffcd96sm1645926plb.192.2023.11.30.09.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 09:19:31 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] target/xtensa: use generic instruction breakpoint
 infrastructure
Date: Thu, 30 Nov 2023 09:19:18 -0800
Message-Id: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello,

this series makes target/xtensa use generic instruction breakpoint
infrastructure removing its use of tb_invalidate_phys_addr. It also adds
a new TCG test checking relative priority of icount and ibreak exceptions
for target/xtensa.

Max Filippov (2):
  target/xtensa: use generic instruction breakpoint infrastructure
  tests/tcg/xtensa: add icount/ibreak priority test

 target/xtensa/cpu.c           |  1 +
 target/xtensa/cpu.h           |  4 +++
 target/xtensa/dbg_helper.c    | 46 +++++++++++++++++++++++------------
 target/xtensa/helper.c        | 12 +++++++++
 target/xtensa/translate.c     | 17 -------------
 tests/tcg/xtensa/test_break.S | 25 ++++++++++++++++++-
 6 files changed, 71 insertions(+), 34 deletions(-)

-- 
2.39.2


