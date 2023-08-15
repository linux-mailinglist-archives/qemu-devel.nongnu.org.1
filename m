Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEBB77C5AD
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 04:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVjW7-0004XZ-Jy; Mon, 14 Aug 2023 22:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVjW3-0004X9-15
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 22:10:39 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVjW1-0004sV-EL
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 22:10:38 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-564b326185bso2804652a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 19:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692065435; x=1692670235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AUkwCSY2Z5NmP5NuhukVPybh9Vik8ZE536LOygUa4Ao=;
 b=SqrfQ+JepusJe0nsjF/w3lA1OpMlp72z+vY9fvvDhZG5qQ9Ypo2SVb5+m8nEGM6HKs
 cF2euBEKOxeHndnJpCTSaQYN/9A1r7kXcnrWwNr10RnbwtL2Tga8/UUaCLQkisAmTRKV
 aSGMzpKbmEwg4rIXNam3A6yFwpYWf/ySHCzfn9YZ9NzbtCY9/WjC3ydCCsMmeUvAU554
 7rdrnga1fUlt4PqCZRc+oQEdPxpZ96CaH8DZpuBJWvXNPs4SvQm7ULhvAHvG1V5nlo9F
 knUOE3lHJj13QrqBE1d4hbpJMigUFig/QOQsMWd1Syub5Shxjb2zRtHli8YChpJjq24a
 sIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692065435; x=1692670235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AUkwCSY2Z5NmP5NuhukVPybh9Vik8ZE536LOygUa4Ao=;
 b=O1TUBzOGDILKc6QzJVLIgYrUGViYfsvWCbGCY8obKkGx7YvK+SGQ+DrExVah4yZ6z/
 uNQUjoZbshajGBdlu6q4+DUSABUoU9epniB2k7C30o3M1TjOE4xMc9XHoD1StbWocBtw
 GqIhNBPSujqnF2E3q9gATmMMCNU6GGqT6gxTxBT90ejdXrMZtRLFNYS1KxuGfOACub4m
 cOqyhMmipzuaDeHFGcEtAEROx6swVUw1pCJJRw0agL2DSjr/vQ1S33fKv8+vd1j5ACjq
 e4NOncapmqHEbv+bKEEK60zCgsQva8cu3iE04c8pRckz4PYGpIdtATiMbXA7Wu0Vm5Aw
 QtuQ==
X-Gm-Message-State: AOJu0YxZwcGaf/ot6Jc8yNsWKB1TazeLWLd3+McNj1MR1KtuevLPlb+I
 ZAbCADR9AIGNPgFk1XotWMH0NsuLyCTkoNR5N6w=
X-Google-Smtp-Source: AGHT+IHvw9P4pKUiz5NuoQqX08WntbCcW3twapiLh8Ul9PYsim1hOZ64Z5XAW1i84D2TQwaBYpjfKw==
X-Received: by 2002:a05:6a20:9383:b0:130:7803:57bd with SMTP id
 x3-20020a056a20938300b00130780357bdmr11625281pzh.3.1692065435052; 
 Mon, 14 Aug 2023 19:10:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:9b47:f2a4:a84:2c9c])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a62be06000000b0066f37665a63sm8535160pff.73.2023.08.14.19.10.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 19:10:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] late tcg fix
Date: Mon, 14 Aug 2023 19:10:32 -0700
Message-Id: <20230815021033.1090676-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

The following changes since commit bb5f142cb320d45d3d8dee2c82dae003cad39da8:

  Merge tag 'pull-riscv-to-apply-20230811-3' of https://github.com/alistair23/qemu into staging (2023-08-11 14:47:23 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230814

for you to fetch changes up to d3b41127c205062ca6c29c89c9542c4112c39ca0:

  tcg/i386: Output %gs prefix in tcg_out_vex_opc (2023-08-12 08:51:12 -0700)

----------------------------------------------------------------
tcg/i386: Output %gs prefix in tcg_out_vex_opc

----------------------------------------------------------------
Richard Henderson (1):
      tcg/i386: Output %gs prefix in tcg_out_vex_opc

 tcg/i386/tcg-target.c.inc | 3 +++
 1 file changed, 3 insertions(+)

