Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F2C766225
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 04:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPD5e-0007tq-4x; Thu, 27 Jul 2023 22:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5Z-0007sb-4J
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:21 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5W-0006tt-Vv
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:20 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bb775625e2so10429555ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 19:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690510813; x=1691115613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uT64XsAOeJTE6CiQBR1qi4eMZDEgppkFyArA5MdLOhQ=;
 b=HaaTtTJnUTxmRL2r8+LkFFZaWOfZktOVxlwad/F0r7JJb5k7oBd75cTCyQA0wb/p7p
 Gq6g0G4SAVICV5/1aXC1KuuDc7FKjYx5saayhorOrPpvb0b74ck9S+UX61At6Xd+PowU
 SY9mssFpybFymu7NS9f3yAcpslz3gzWuqdbdo8piqyYin6n+nE9tGY6rG8Pu9dgv7ngB
 HDLL8klQrzC6svg0iIKZIsgLUL8uB762urJAKXvpCujsjqB9i0QAIpY3YB1IHLVR5jsz
 oAjeToxHHEyznxqKIF7GTKEIQJAbejiOsTterAbY2xU66tZEVBIGdmCQkKMJuo+UHmr3
 oFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690510813; x=1691115613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uT64XsAOeJTE6CiQBR1qi4eMZDEgppkFyArA5MdLOhQ=;
 b=lk7TOf++sdV5aivi8ed3Ly6pDutIS/P6NXgD1RpLehmYpqqVZf3BCA1XAiZOIqoWbg
 7JFD3KxXzWpFegkPMv271/KfybWjAPq7I8Kc7fiS8Qzng5iNG/amZokbwSYo7UDAFBUD
 vTeFBxuYSkpOQ4b+YTwYEB7FWhGgdo0Ry25TkFhiqdGeXhINXFNPUoKjUnsijQRWwQlY
 xluoKjsHjDpWwLk2VjuHSdZQZ8va95kuOYsZqVPYuIy7iLqkyCoU6L7GpM66gd9jDniP
 +nFUj8rnZl89pYqHBvFz+Vi99kWYbuys8yoMIPE50KcMhYaAmruzVh6gramgLvMxc0yY
 Gf3Q==
X-Gm-Message-State: ABy/qLYAm2K2KDL6EVA+CZNkNHmq6iWzZ+LPXAd1jSscR1E1GZrLfcLl
 EfkUgd1CmsqCKNz1kUSQYwKecg==
X-Google-Smtp-Source: APBJJlEJasuQWbADV9IaPn6OzeByx70MkuwjhsWP6FDfnUvOX3twU4aTv/Iso0nHNl+OgPFELYfwfQ==
X-Received: by 2002:a17:902:e5c5:b0:1b2:676d:1143 with SMTP id
 u5-20020a170902e5c500b001b2676d1143mr790347plf.15.1690510812962; 
 Thu, 27 Jul 2023 19:20:12 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bb9f104328sm2312947plc.146.2023.07.27.19.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 19:20:12 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v5 0/9] Misc fixes for throttle
Date: Fri, 28 Jul 2023 10:19:57 +0800
Message-Id: <20230728022006.1098509-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62c.google.com
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

v4 -> v5:
- typo fix in 'throttle: use enum ThrottleDirection instead of bool is_write':
  '@throttle:   throttle direction' -> '@direction:   throttle direction'
- several 'for (i = 0; i < 2; i++)' left, use
  'for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++)' instead.
  'true/false' left, use 'THROTTLE_XXX' instead.

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

 backends/cryptodev.c            |  12 +--
 block/block-backend.c           |   4 +-
 block/throttle-groups.c         | 163 ++++++++++++++++----------------
 block/throttle.c                |   8 +-
 fsdev/qemu-fsdev-throttle.c     |  18 ++--
 fsdev/qemu-fsdev-throttle.h     |   4 +-
 hw/9pfs/cofile.c                |   4 +-
 include/block/throttle-groups.h |   6 +-
 include/qemu/throttle.h         |  16 +++-
 tests/unit/test-throttle.c      |  76 ++++++++++++++-
 util/throttle.c                 |  84 +++++++++-------
 11 files changed, 246 insertions(+), 149 deletions(-)

-- 
2.34.1


