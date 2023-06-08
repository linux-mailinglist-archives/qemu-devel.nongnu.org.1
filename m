Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE67C727AF5
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 11:15:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7BiR-0001Z9-Jn; Thu, 08 Jun 2023 05:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q7BiP-0001Y4-1v; Thu, 08 Jun 2023 05:13:57 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q7BiN-0005LD-DK; Thu, 08 Jun 2023 05:13:56 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-39a3f2668d5so273790b6e.1; 
 Thu, 08 Jun 2023 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686215632; x=1688807632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e8ASZN5bBPDez5EtaMiipgaDAZWmsRjoWDi/2uvuu1g=;
 b=bh168EoZJ1KybRCLkiva0FDFgbxqh2wZEN2kgkCfKH62ZMWzw+3ckkvjWNRNkSAhFI
 CGWmChxSdeAVDnHR/uiGFTUsc/xy8C7wtFAda0d6quXB7v0zEL3kjr29+6hiTIkcnqoI
 5w3xH8nPgYNOGA4jUA6enPMLqjOwYoMTTvLkHfXMrGgMvggnUcK+ExPa2bQIp1M/Yyg3
 URNEoPESC+m/SRK9aHr1sPrlbOfXYhYALw2aUDK7v1jTmGjWyHVlFTOMFAjO6DIR31kW
 KJ/IzxWYA3lKb7ZVZQOHHI/EQ5cGvECdFQBaI1caSUfb+df7dCUaWZBeLFG9p8y+YK1I
 T7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686215632; x=1688807632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8ASZN5bBPDez5EtaMiipgaDAZWmsRjoWDi/2uvuu1g=;
 b=Gkyu72IS9Q+UVNBWQ92enVue2IAyUcJ8EQphAiYxyoxXH9/SjBFd3EIu8A8hZqlekN
 qWKQb7O1EwpIJbkRJvyQfkRaxNhWNZfoec/RI1xdSs1tgOvoiZ4sHYxt+KyZEaf8KVqL
 +5094V+PSoRSWBxBc/jzTg1sqcoBvsW5QzFMEzPP9AR1oDr4BU+/4z4g0Fjt4JJbPXAj
 yvFeN1j734Dw3AQAwr8uPdPnnLNGqADiU8U4smZZrZapItHzrZ+nzLFFuw9iK9jhSogW
 6qEi/ma79+SsO2J+VgCvdNekwUbLpCijc+Y0tItZMi763KZKXi0+Mn+wWDYddJjn/lYf
 fSOg==
X-Gm-Message-State: AC+VfDyPzjXxChUnpfHwmzRyIS5GD7ejGzr2xN5EKsm7HbcSCJMOLOmL
 mjkSJCgDkNbjFSRsJkybNpMbPqLgBek=
X-Google-Smtp-Source: ACHHUZ6CCX0pK9GTst157xaD0y1GOw0iyr3cFJzKmaYNCmmxZylr9AgWa5djye6uzQOaXjLMJIXe9Q==
X-Received: by 2002:a05:6808:28d:b0:396:1678:2492 with SMTP id
 z13-20020a056808028d00b0039616782492mr4846487oic.54.1686215631945; 
 Thu, 08 Jun 2023 02:13:51 -0700 (PDT)
Received: from wheely.local0.net (58-6-224-112.tpgi.com.au. [58.6.224.112])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a17090a5d8b00b002563e8a0225sm823577pji.48.2023.06.08.02.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 02:13:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/4] ppc/spapr: Nested HV fix and tidying
Date: Thu,  8 Jun 2023 19:13:40 +1000
Message-Id: <20230608091344.88685-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x230.google.com
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
these cleanups done and move nested to its own file. These were
posted earlier, not much changed except rebased on the CR helper
accessor functions.

Thanks,
Nick

Nicholas Piggin (4):
  ppc/spapr: H_ENTER_NESTED should restore host XER ca field
  ppc/spapr: Add a nested state struct
  ppc/spapr: load and store l2 state with helper functions
  ppc/spapr: Move spapr nested HV to a new file

 hw/ppc/meson.build              |   1 +
 hw/ppc/spapr_hcall.c            | 334 +--------------------
 hw/ppc/spapr_nested.c           | 496 ++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h          |  61 +---
 include/hw/ppc/spapr_cpu_core.h |   5 +-
 5 files changed, 502 insertions(+), 395 deletions(-)
 create mode 100644 hw/ppc/spapr_nested.c

-- 
2.40.1


