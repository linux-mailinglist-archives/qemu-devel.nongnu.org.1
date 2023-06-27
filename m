Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A775F73F595
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE34A-00080E-JO; Tue, 27 Jun 2023 03:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE347-0007yy-Aq
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:43 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE345-0005tm-85
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-66869feb7d1so2259958b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687850677; x=1690442677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dyP3PiN0Y+FblDfKYQIaF4R37Nmy5AUdk5vpThfltY8=;
 b=hB79/xreyhFnGGPuLvfjvGDF5A16sK//X2a7CmYRyg4Jssqbdkrjt2gggVNaRzxNSZ
 iG1YrKKGngPK2/7YkimN+aO0NducC8iqMt1Yd0piiPPdE1Q48LTq8l+J6yHUk0uwa23q
 8xuVcoiup08+h9YW7Cp5Snn5rUU+MkzkJL8Ds+3CHUqQ1/5Gw4gnwrTK1ho03afmKT9z
 ne/Rxr0GjSES5hkU02ulAmp7BP/0sLMZC91Pb3RIFXvTCdUprr9yOvkfJFIOsbnJP38D
 dM4Spk3Ob7ySXlEXixufWPRqC8eqw36IRFL9bPpipwu+nOEGgoaWXFN5psUZsOEGwCyz
 eDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687850677; x=1690442677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dyP3PiN0Y+FblDfKYQIaF4R37Nmy5AUdk5vpThfltY8=;
 b=K7cuF+7KR7P0ebCpeGNuNEo2ah2aogj6V+RQFxOFwImcnKiQBUwT9x4V+oeJ9YKou/
 tIUgZqjQ5FfwQGuOZ/uQHpskoS8VoTs6FdyH+NHPiHDtmngvnnZp/RJdou03fJ6AgVY3
 MiepOa6Tc8Cv/G2JvqdExJ0YHc3bp4vWesL+ST2DQsJ0MBHigmFLP9QkPtR6lki8dBEa
 UAUhgkoBhDriQ/Ntx0Ci0ULFr9pyZR4MaUH+8LC4GmsXekMltLcwUtSqeauqWvDFdRCq
 UIVFz2vX4Nh/XPWyhE6/vG0IuvvMjXuZPZFCBWrMPLUPwx6Z3YgN/BlV8aUM3juzuAfj
 pKKg==
X-Gm-Message-State: AC+VfDy3JcsQdT2kxf1kGx5zFhItSm/BqwaCTLogi4hZZnCeQ565/fYB
 XdZJC2dNC6iiJibcglnc7YYIHQ==
X-Google-Smtp-Source: ACHHUZ4qnFQsTo/xCUwVDa5G3jZFBx1C/EUkgMmXcG+U3rnXzBI3dMT0LFsDl0hETgEOR/xCZrCwYA==
X-Received: by 2002:a05:6a00:18a8:b0:67a:31b7:456c with SMTP id
 x40-20020a056a0018a800b0067a31b7456cmr3542649pfh.9.1687850676886; 
 Tue, 27 Jun 2023 00:24:36 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 u22-20020aa78496000000b00640f1e4a811sm3210915pfn.22.2023.06.27.00.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:24:36 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/5] Misc fixes for throttle
Date: Tue, 27 Jun 2023 15:24:26 +0800
Message-Id: <20230627072431.449171-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

v1 -> v2:
- rename 'ThrottleTimerType' to 'ThrottleType'
- add assertion to throttle_schedule_timer

Something remained:
- 'bool is_write' is no longer appropriate, the related functions
  need to use 'ThrottleType throttle' instead. To avoid changes from
  other subsystems in this series, do this work in a followup series
  after there patches apply.


v1:
- introduce enum ThrottleTimerType instead of timers[0], timer[1]...
- support read-only and write-only for throttle
- adapt related test codes
- cryptodev uses a write-only throttle timer

Zhenwei Pi (5):
  throttle: introduce enum ThrottleType
  test-throttle: use enum ThrottleType
  throttle: support read-only and write-only
  test-throttle: test read only and write only
  cryptodev: use NULL throttle timer cb for read direction

 backends/cryptodev.c       |  3 +-
 include/qemu/throttle.h    | 11 ++++--
 tests/unit/test-throttle.c | 72 ++++++++++++++++++++++++++++++++++++--
 util/throttle.c            | 36 +++++++++++++------
 4 files changed, 103 insertions(+), 19 deletions(-)

-- 
2.34.1


