Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C85B736A18
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:58:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZ3a-0007Fo-T6; Tue, 20 Jun 2023 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBZ3Y-0007EH-8H; Tue, 20 Jun 2023 06:57:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBZ3V-0000he-KS; Tue, 20 Jun 2023 06:57:51 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-666ed230c81so3078907b3a.0; 
 Tue, 20 Jun 2023 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687258666; x=1689850666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AwiU0NZRbNgBahqPdOO3ID7YQKsvDvALEYol6NiywmI=;
 b=XRu5P0FvK4Myv0Bzdawg3YrF4d2k1CdguxMJjFcJn+8B7ujJlmZQFl+5hmvPu5J6z3
 WLlzHQNuOjTvEz1pb9Ier94YzGjUDb0zZRUin59eH7PZ5xAWjxz3bas9AB4TRwpaeOq4
 9ehFJO1Qugx9YygvykfC1KiSN6SO2+VAS8V/ED3UCyJWwrK6jLw8kqN0Zgf+auV8jWI8
 nL9Kcgp2ykUsUOlyjuSO87NwwBnsWcPDvKiyf1IqsZTsFODWI7+xouQ4jqvZViD5njnb
 dlmA8iA9sMQXxrQxSsrjLQZA2Bjni6ty76ngThie1BEh3761HDaB+2LFycYvfX5ZrDxu
 oXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687258666; x=1689850666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AwiU0NZRbNgBahqPdOO3ID7YQKsvDvALEYol6NiywmI=;
 b=cYY2TxONMM5TPazCCMr0ZjOpLq18FHU4Dcr7TnlKeTBaCtGQ3TpvAnhaxp9CAvK0AC
 3CHcxRKUbgLU3NwVUESLQZeFAKpC81+ruxfGDLQmSJwZsDAQqn1rAUtbzYW5vCLsgAmA
 9GtQghIq6aPGqnww4Lc/rpNI/5lzo9tq6yuMM5mWVtMDkB5YHYBiFmaifS1Kzwieq/T8
 uK2cyNLtnDgDJoKyLiL5asYRXyIYRkoKI9ziezoObf8AKhIj2AwkRurM9OLiSi6+TLCV
 Kh/DrnrvBCzfjqC19NuWjq1yCvwJsMZ/vKnP4tS/96i6S7qyzD5TD9DW0ot2Cm6uDsW/
 Zpdw==
X-Gm-Message-State: AC+VfDx/L34WF4MMwf2BPRB480XOhScs1qXsDgcuMgeWU5E0KwiXShv8
 Yx5kqIOC41uZ6lMv3S21j5rZXoXpmA4=
X-Google-Smtp-Source: ACHHUZ5GljTkW9vSfLHjND5f5/RBi3JWBklp2KEdwjVI2883fQDdH0v6SmrWV0TZIM7eHzdYFV+BRw==
X-Received: by 2002:a05:6a20:4304:b0:122:2e73:3f28 with SMTP id
 h4-20020a056a20430400b001222e733f28mr3904469pzk.24.1687258665874; 
 Tue, 20 Jun 2023 03:57:45 -0700 (PDT)
Received: from wheely.local0.net ([124.170.190.103])
 by smtp.gmail.com with ESMTPSA id
 n13-20020aa78a4d000000b0064fabbc047dsm1126412pfa.55.2023.06.20.03.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 03:57:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v2 0/4] ppc/spapr: Nested HV fix and tidying
Date: Tue, 20 Jun 2023 20:57:33 +1000
Message-Id: <20230620105737.160451-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

To prepare for some later changes to nested-HV I would like to get
these cleanups done and move nested to its own file. This is
rebased and patch 4 has some nested function definitions and
structs in spapr_nested.h that Harsh suggested.

Thanks,
Nick

Nicholas Piggin (4):
  ppc/spapr: H_ENTER_NESTED should restore host XER ca field
  ppc/spapr: Add a nested state struct
  ppc/spapr: load and store l2 state with helper functions
  ppc/spapr: Move spapr nested HV to a new file

 hw/ppc/meson.build              |   1 +
 hw/ppc/spapr.c                  |   1 +
 hw/ppc/spapr_hcall.c            | 335 +--------------------------
 hw/ppc/spapr_nested.c           | 395 ++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h          |  62 -----
 include/hw/ppc/spapr_cpu_core.h |   5 +-
 include/hw/ppc/spapr_nested.h   | 102 +++++++++
 7 files changed, 504 insertions(+), 397 deletions(-)
 create mode 100644 hw/ppc/spapr_nested.c
 create mode 100644 include/hw/ppc/spapr_nested.h

-- 
2.40.1


