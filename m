Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082575F240
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsWA-0007jl-2g; Mon, 24 Jul 2023 06:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsVw-0007hj-V2
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:05 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsVl-0000XX-Ew
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bb2468257fso20695985ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193386; x=1690798186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wc7I1mWSNpxFRwbHpc4PW0roReVOcC4gzLLVvJF/AEs=;
 b=dfDJDEhN2+tHvna/LfG4iCNzU01Pung5Z8GLon5jM+R3YvU3tqRJbJCAoxJwZ0QEAG
 QW/VPdRzZUvyjI2fk34e/rvItFIqmSCYUjawYTQNR6XxUcHgFIfhT0dkGyGkMfRWAkn+
 Q6NhTSyKlKZ7d82xNbOX9o9reW9vo51LFOJN9v7zShDa6eozpShKhlCrXeWfNeZCQwMJ
 nf7Uyy7RuxCmgLttEYo74k8vmwoGbWocpxoJEdMSGRlIMvV/K+x53IZt8ArBm5h4Uzgt
 Tp11vhUmt/O3sJu1WFomEzoLS8bN09AEV4wRypjXdKfUS1dFpRBC2d/wXascIPwOGNgX
 qHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193386; x=1690798186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wc7I1mWSNpxFRwbHpc4PW0roReVOcC4gzLLVvJF/AEs=;
 b=c6IiHMXHI0z7z9MkRWe+THnfAj2w4HP5gcCfJD7yuPXxopeb93A0wYca5UcFxPZyh5
 /3vt4VJVPRZ0+DWI11pUTl8NCQPnGxZ74IlbB/rYt0j9CW8xCGcMVoOLNmRXDw1nVuUq
 abaFhkQWScxeRuYESbNGADYRRhCxHqo9pmiC2Bqra8oPaokCcALWjveye5WzfCm7im1m
 N9wuaFKxfh7x6LkJulg5x25w8gPHSojKKdSpARfiZDSRyHJqaLaMCe74wjI1AOK288sO
 J+MRASLJUWl3a9KuUzzxwRuC/a3rIPxls5GyXiKsr/hpQ8CIGSjl3qFy/+SMNl2KoOzn
 UocQ==
X-Gm-Message-State: ABy/qLYVoD1cLezPY4YiabW641TIv0yIZUs2UGY87HuAPVqYN/Cn0anx
 Z8g9D3YJvcaA1Zr/rGI/Vit3Ag==
X-Google-Smtp-Source: APBJJlEtFKod2+49Kom2GqABFV5R72VSNAs3k/HoOtCAlmMz4RzkYjAspCBd4Smu5GA6gTRwSlTDkw==
X-Received: by 2002:a17:903:234c:b0:1b8:8b2e:ae36 with SMTP id
 c12-20020a170903234c00b001b88b2eae36mr8154307plh.3.1690193386693; 
 Mon, 24 Jul 2023 03:09:46 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001bb9d6b1baasm2419124plb.198.2023.07.24.03.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:09:46 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 0/9] Misc fixes for throttle
Date: Mon, 24 Jul 2023 18:09:30 +0800
Message-Id: <20230724100939.1022984-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62d.google.com
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

v3 -> v4:
- Hanna pointed out that 'throttle type' is not clear enough,
  'throttle direction' would be better in the v3.
  Use 'ThrottleDirection' instead, also rename 'ThrottleType throttle' to 'ThrottleDirection direction'.

- For patch 'throttle: support read-only and write-only', reduce codes by:
for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
    ...
}

- Add commit message for the removed 'FIXME' tag.

- Append 'throttle: use THROTTLE_MAX/ARRAY_SIZE for hard code'
- Append 'fsdev: Use ThrottleDirection instread of bool is_write'
- Append 'block/throttle-groups: Use ThrottleDirection instread of bool is_write'

Finally, 'bool is_write' has been fully removed from throttle related codes,
'type foo[2]' becomes 'type foo[THROTTLE_MAX]'.

v2 -> v3:
- patch 1 -> patch 5 are already reviewed by Alberto
- append patch 6: throttle: use enum ThrottleType instead of bool is_write

v1 -> v2:
- rename 'ThrottleTimerType' to 'ThrottleType'
- add assertion to throttle_schedule_timer

v1:
- introduce enum ThrottleTimerType instead of timers[0], timer[1]...
- support read-only and write-only for throttle
- adapt related test codes
- cryptodev uses a write-only throttle timer

Zhenwei Pi (9):
  throttle: introduce enum ThrottleDirection
  test-throttle: use enum ThrottleDirection
  throttle: support read-only and write-only
  test-throttle: test read only and write only
  cryptodev: use NULL throttle timer cb for read direction
  throttle: use enum ThrottleDirection instead of bool is_write
  throttle: use THROTTLE_MAX/ARRAY_SIZE for hard code
  fsdev: Use ThrottleDirection instread of bool is_write
  block/throttle-groups: Use ThrottleDirection instread of bool is_write

 backends/cryptodev.c            |  12 ++--
 block/throttle-groups.c         | 107 ++++++++++++++++----------------
 block/throttle.c                |   8 +--
 fsdev/qemu-fsdev-throttle.c     |  18 +++---
 fsdev/qemu-fsdev-throttle.h     |   4 +-
 hw/9pfs/cofile.c                |   4 +-
 include/block/throttle-groups.h |   6 +-
 include/qemu/throttle.h         |  16 +++--
 tests/unit/test-throttle.c      |  76 +++++++++++++++++++++--
 util/throttle.c                 |  84 +++++++++++++++----------
 10 files changed, 216 insertions(+), 119 deletions(-)

-- 
2.34.1


