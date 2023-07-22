Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7000E75DEA3
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 23:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNKP0-0000J3-QN; Sat, 22 Jul 2023 17:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNKOw-0000HJ-G7
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 17:44:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNKOo-00032y-E8
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 17:44:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso28861425e9.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690062264; x=1690667064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xEasaoZboN8KJf7SaKtCeZLZ0vIGHvm2h3QG6FL0N38=;
 b=MZYePx8YKRB54b/rNsyLqlx16uAHZUzlvR1Yq/Lmc4ZifnREG8SEXxX7/3eO1JnK0O
 PjwnTkF0Xdw5gOle5eTVo/RdGgKI+OiwppRpaBQrPxnkFkfZBDZ96S9LAdtLURE6mcMI
 Bsuuc0UZ77i5S2a8qNqlgKx+XM2p143TMfp8EoAxkOCsCP9TYDTtb2zlh4BuTtcjd6k0
 8iVs2kWVdBR/kOoOkrMoeEUGh9AWMVeBzltwn8q6OryVJEDdhX2ipLrqhtOjwIGqAEoi
 pstu2Or2FcKKM/46Zk1ccrcT65o90jTBTH2dJbO0ojaCxWv9oXMGgRHisfHvqHXoKamH
 w2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690062264; x=1690667064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xEasaoZboN8KJf7SaKtCeZLZ0vIGHvm2h3QG6FL0N38=;
 b=B1yXDvMCaE6bHdsRq2ZeegqmF/1q1Hf63rsuN6WAEWigKfly0xZmOBAegx4IdySrqJ
 q2TXt1v1h8BuwxxV3N6nMmPRY7bZUPu1sK5BdisNH4QipzNIQQNmBU4xoGnoDBay+bM+
 i4CHWHnRgQog2IxyAETGjzim01w7kgbX2g5gZFSRFbkfMvshFMpcAuaaHSPJEsLmeyD6
 u811i28vMFZ2Emj1djDuagEsseOsvaBo449J/8nK2zpz1VJUcgAzsdxQ0E21EkHbCebS
 8b1EaIuLnGD83iKyIcJUUvYZHqu7dpJq4rC5JChXyge5MRhMzRxivPbTabCWPDi0X4Lr
 hCpQ==
X-Gm-Message-State: ABy/qLbDZnoJ5q5Qrp+Lw9JsAApaIu4BpldjG9HUt54xIVGwI8r6NKrr
 0XXvBNCucnxWiT8l7ElI12RD6LUv++yiNnibqz28ZA==
X-Google-Smtp-Source: APBJJlFp5CF0OvXE+dYZuRAweW7DAFv7Qw6OSEm0bIoP5WiQ7UphcWN6CvfamWFBpdmZ8EPjGsidjQ==
X-Received: by 2002:a7b:c5d9:0:b0:3f7:f584:5796 with SMTP id
 n25-20020a7bc5d9000000b003f7f5845796mr4026595wmk.2.1690062263609; 
 Sat, 22 Jul 2023 14:44:23 -0700 (PDT)
Received: from stoup.acentic.lan
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a7bcb56000000b003fbb9339b29sm8846384wmj.42.2023.07.22.14.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jul 2023 14:44:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 0/4] util/interval-tree: Avoid race conditions without
 optimization
Date: Sat, 22 Jul 2023 22:44:18 +0100
Message-Id: <20230722214422.118743-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

Read the left and right trees once, so that the gating
tests are meaningful.  This was only a problem at -O0,
where the compiler didn't CSE the two reads.

Changes for v2:
  * Use qatomic_read for left/right while searching (pmm)
  * Use qatomic_set_mb when inserting a new node, so that
    we're sure that the new node is consistent.
  * Abundance of caution: Use qatomic_read/set for manipulating parent.


r~


Richard Henderson (4):
  util/interval-tree: Use qatomic_read for left/right while searching
  util/interval-tree: Use qatomic_set_mb in rb_link_node
  util/interval-tree: Introduce pc_parent
  util/interval-tree: Use qatomic_read/set for rb_parent_color

 util/interval-tree.c | 79 +++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 31 deletions(-)

-- 
2.34.1


