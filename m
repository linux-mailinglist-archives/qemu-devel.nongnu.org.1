Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD5E7518F8
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJq1G-0004dW-Ci; Thu, 13 Jul 2023 02:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1D-0004cb-6l
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:39 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq19-0007oA-Hv
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:38 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso3155845ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 23:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1689230488; x=1691822488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C5317l/3RH5VTIQNgJ0dLvyu+rjLIFjSiP19mc14D9M=;
 b=CivA+P1Epf+f/sh9hQbzxe0vSVw69c/nTfkfs52ZRGKG98LOerdFqwN5+n/nBU23QD
 SBMV9taaOOItaaTSMdHVGRFk4w41xC+oxScGH6PRjOfgAXUdwMFqqPIEE2idWW/fkiaF
 rWqTRAbAlKRNEpjR1QLTI4UqcITCAqFTZpCTb/YKW3lZPqieFJHl0145cWLDFiJG8Gx5
 aBjkwUwOh7H/0ScVQtaz1XP8//bXeo6KlbsLUAZKjKAv2oIMigxEX0SYyxUXCm4SQYXP
 8LwC2C8l6E7QCzoEhqaRu6LR3kUJumZtUXdhdcfYPqUTPyaLYlWBm3L1axHrYan5uJJS
 py8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689230488; x=1691822488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C5317l/3RH5VTIQNgJ0dLvyu+rjLIFjSiP19mc14D9M=;
 b=bfmCOYFn0qoP7Aq7KGc7cNFQurAtmyNmg/eNhLYEStrGLL8+IIt8AOBs6dcNo+NNbu
 NjeSOJrVbbxz1SBR1dQ/Ok7lkeOalZJ/RB3O7W0Y7hqOzv0QXfjksSLXzIiFbcdJnBWa
 JJ48pK0MrcyGIXbZT5Rfm+pDIh8r8Fzt3tfxp5eTmGM5x6v45/vTDwCk94p+jyAEkLcz
 hUxaPA+nTnpQ4ETX9N6oWZ2TjDQiNf4WvNcdS1Btzykmo504WfhI/k3FmjFlNM4ePFtT
 xRkzFOXks1PUUN1fWKHo/RmQ+/mNJU4izRLTSwOVBS7pftGDpO2gYHWCkW8ZFn/SjW4v
 W0mQ==
X-Gm-Message-State: ABy/qLY7bfFbDlwq9CKeCB+6LWP/UUqqnI6OupvbH+gRPQl+k8FpTlvA
 cUdPLU9G75iNS8HRawiyl32CAg==
X-Google-Smtp-Source: APBJJlF04MjrfBVqhT2PjdOljvsbHjljh/UNiXEfjXrY3LMJn2g772fb54WGMv8Y8yhDt2lDA6uDqA==
X-Received: by 2002:a17:902:b188:b0:1b8:c708:5d1d with SMTP id
 s8-20020a170902b18800b001b8c7085d1dmr718490plr.39.1689230487792; 
 Wed, 12 Jul 2023 23:41:27 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902680d00b001ac2be26340sm5144966plk.222.2023.07.12.23.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 23:41:27 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 0/6] Misc fixes for throttle
Date: Thu, 13 Jul 2023 14:41:05 +0800
Message-Id: <20230713064111.558652-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x632.google.com
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

Zhenwei Pi (6):
  throttle: introduce enum ThrottleType
  test-throttle: use enum ThrottleType
  throttle: support read-only and write-only
  test-throttle: test read only and write only
  cryptodev: use NULL throttle timer cb for read direction
  throttle: use enum ThrottleType instead of bool is_write

 backends/cryptodev.c        | 12 +++---
 block/throttle-groups.c     |  6 ++-
 fsdev/qemu-fsdev-throttle.c |  8 ++--
 include/qemu/throttle.h     | 15 +++++---
 tests/unit/test-throttle.c  | 76 ++++++++++++++++++++++++++++++++++---
 util/throttle.c             | 64 +++++++++++++++++++------------
 6 files changed, 136 insertions(+), 45 deletions(-)

-- 
2.34.1


