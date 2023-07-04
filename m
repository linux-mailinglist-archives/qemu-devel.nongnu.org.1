Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C05D74765A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGim9-0004kU-E4; Tue, 04 Jul 2023 12:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGim7-0004kB-E2
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:21:11 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGim3-0006Td-TG
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:21:10 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b5c231f842so86149621fa.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688487665; x=1691079665;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1fcddEPTkQdKCH2znvJdFzvdfgSmE3hL5aPgd53HswY=;
 b=YzIkx2Qp9F24N8FExR4IFdgS/8sLzhKXzbGI1PmBLvR2qyG1p7h7mCFBY8sSTRtG94
 NOkW1lr2648rnFdYk/QQx4v0PaJvLwO4y86Dy7nNuRoVhS5qb4CmgqpLXTGA7vtcL6FT
 DD7UsQ8HQTWxSx2QNL3RZBkfUo3JoqWVp1Q08xj/peJoTu+CTi+XnIjy9SYiL+zUg21y
 O3kDtGyKdlLIyYwHlvCUrgj4KjTdHraPnksVpiCp/bBwryvBMACAHXfk9A/Oxxu0W4Y/
 rURXV01AdkJYkcZDJiPwTtXwNWsVeZpS322jN+JNaTbZbycpEWNQfaOVpZ6iq409NDGp
 5W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688487665; x=1691079665;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1fcddEPTkQdKCH2znvJdFzvdfgSmE3hL5aPgd53HswY=;
 b=VXSOwVEnv2E8pT4+6a3/TYvbPNswjoTQagErDvMHHMQicu2gcXBu3PkRUzIGiCFmvH
 ZCkqypS71O1Z0C3Du8GBteno6AkmSs7LpMPdWxmUVque9VvPuUtuedvckOLmOmV4quVl
 FjkXV/D5/vjAX7wliSOFDkOFzd0wKbYMUCfvC5CliL1eNoyww/6siP0VAQLkvUWNfYSK
 Ru3xJCaFApqv67sSiOkA/lrtuubO+bYsL3AZWVAfRPFQrPHsXiqnJLRsC6gQ3J0q3PK0
 XGsdbyl8wzV1W0GeEQDStDhOLaZEZTuDDp+EdmZX4zkWV/s7DAJnV+tihl6GQxQzLIpl
 xOGQ==
X-Gm-Message-State: ABy/qLYRlKkP9/XOXCU3li/OLfxO8oDqjbTK5mC2GXSYikZduZ2c5nXa
 H/cx7qopj7C/DFvuswY9sr1ethuFqFL1LwlfmzcmAxWnkDA+9FtA
X-Google-Smtp-Source: APBJJlHN4FpZzPYYp9Y067TGuDlwNz1U61zErVonMcUEEv1V9mD50ZA1g9yvA+ar+UCa5EO7tRhhED4Xqbp2GULT7ew=
X-Received: by 2002:a2e:9844:0:b0:2b6:cbba:1307 with SMTP id
 e4-20020a2e9844000000b002b6cbba1307mr9253360ljj.0.1688487665553; Tue, 04 Jul
 2023 09:21:05 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 17:20:54 +0100
Message-ID: <CAFEAcA8AzdKw9BH_6757U-P3zCWTdyiVCAa7GB8wcjOF4wdE3Q@mail.gmail.com>
Subject: intermittent clang sanitizer failure during 'make check-tcg': null
 pointer deref in IntervalTreeNode
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

If you build QEMU with the clang UB sanitizer and do a
'make check-tcg' run, it can fail like this:

  TEST    vma-pthread-with-libinsn.so on aarch64
../../util/interval-tree.c:751:32: runtime error: member access within
null pointer of type 'IntervalTreeNode' (aka 'struct
IntervalTreeNode')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../util/interval-tree.c:751:32 in

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../util/interval-tree.c:751:32 in
make[1]: *** [Makefile:181: run-plugin-vma-pthread-with-libinsn.so] Error 124
make: *** [/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/Makefile.include:56:
run-tcg-tests-aarch64-linux-user] Error 2

I only saw this once; when I re-ran the test passed...

thanks
-- PMM

