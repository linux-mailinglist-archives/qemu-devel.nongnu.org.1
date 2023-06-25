Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8373CF95
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 10:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLY4-0003IX-Mm; Sun, 25 Jun 2023 04:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLY1-0003IE-TY
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:41 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLXz-0006ms-U9
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:41 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b512309c86so14498275ad.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687683397; x=1690275397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MHDiC37WD6lz2thKCfkgk2nIFAN8skW8KWji9uGuEyA=;
 b=es/yP6ru4snuxUA+++OlJQgI6DaWOxEJhTlpHOoiWAtcGjUK1DYtpTxMIChRCmA9L4
 DfG+pY3gaCTQi+18CaueDZShzV/T8UwiepnmevV1SrI3397rF1PSThS3ldIJPqbxV2Qd
 V+QSg/Fudo20TaY73C9fgJGQYnUAFIAFTEaCmnilto1SyeT1UD/ktv0z4Gc/3WHla+Sa
 iXfZ0JQP73bXIxBE1fgpKOgcLJRZLSzSLN6eUb345UNvJIN3rgfX8EmpjCbJhZZdMSoi
 0RmWfIxYjtZ7qTVRya+e1k15G0+Zpl0wzaGiMrpoScJrxhI6MfLSf248WP2gMxdcsXUh
 pW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687683397; x=1690275397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHDiC37WD6lz2thKCfkgk2nIFAN8skW8KWji9uGuEyA=;
 b=WV8rFqLjsPHVXkFQ72jN5+XDHkKBFTFXpZtCN3OYSBe0be51Lhi6ndfnTHrUHGhwwr
 M8tPl/xIplrDg4VbqCGV2LvqTAzVYeb0DZN6Rcq+6HYImsKKavWkxPf0Yr4hMiCvqQ99
 8LOEimlzbc4h5bd8EEpxnKiUQS/1W0vqmzRz98xZ+50kIy5vWc9AS4xcHheLCar9qXqx
 7ck+wcWZYY52hJcAbkON26ZWNf38J5GVPboqd6UbuAuVgrqaLn+ezMKJiZZcgV2JH0lk
 fRtAzauokKwLTp9HJGsE9wrWgfJcFQ26oVnkKC6WEjaCQlJnpp9mdIQGKt7zVwYNlBsT
 7Bbw==
X-Gm-Message-State: AC+VfDwUGN3x+c726gHpcVTOxlfcRsy5qIoSLRZGw6JOoCF0QWrxFtRC
 oUUERD8TDfaVLzIJFB1DRh4kJg==
X-Google-Smtp-Source: ACHHUZ7w1DXWbAMrg8XZsygayvT7RUdyi1/DwbkXtFGsLP+J+BrlU84d05qYN4yg2dPfgpZgSbyVpg==
X-Received: by 2002:a17:902:d506:b0:1b6:6c32:59b3 with SMTP id
 b6-20020a170902d50600b001b66c3259b3mr5220425plg.19.1687683396738; 
 Sun, 25 Jun 2023 01:56:36 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a170902e88900b001b1f991a4d0sm2176308plg.108.2023.06.25.01.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 01:56:36 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/5] Misc fixes for throttle
Date: Sun, 25 Jun 2023 16:56:26 +0800
Message-Id: <20230625085631.372238-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x629.google.com
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

Hi,

v1:
- introduce enum ThrottleTimerType instead of timers[0], timer[1]...
- support read-only and write-only for throttle
- adapt related test codes
- cryptodev uses a write-only throttle timer

Zhenwei Pi (5):
  throttle: introduce enum ThrottleTimerType
  test-throttle: use enum ThrottleTimerType
  throttle: support read-only and write-only
  test-throttle: test read only and write only
  cryptodev: use NULL throttle timer cb for read direction

 backends/cryptodev.c       |  3 +-
 include/qemu/throttle.h    | 12 +++++--
 tests/unit/test-throttle.c | 72 ++++++++++++++++++++++++++++++++++++--
 util/throttle.c            | 28 ++++++++++-----
 4 files changed, 98 insertions(+), 17 deletions(-)

-- 
2.34.1


