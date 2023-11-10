Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F41DB7E7A8A
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:18:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Nd9-0002QW-PX; Fri, 10 Nov 2023 04:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1Nd7-0002Pk-K1
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:16:45 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1Nd6-0002m6-0O
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:16:45 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso12596135e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699607802; x=1700212602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=078LHjHgYcIKXgy3K59FfW1+FGsAoPUrmucU4b2BaBI=;
 b=N2/+C1pDYiRsCCW2aqqYLAUpWQdxF964qjZvgNfFV5V2wmDdGC1eiOdqOUlb+Blrm5
 EZR9yAUR55E9pqP/6wSBLBgK8ltEVjQTs8CIVXfj1HQN8dYvlucv6NGRy2JgzqRbEbrr
 YOylhY+Cc2UlpMnGEDj6FzVy60bjbxYT0G67PbHdtxcOaIItCOtqsmfxY0Tn7X8qyuhJ
 kXlyDfM4iMSsi8Lu3KuVKSHIuJ4w8ss4/XsHb26iu7ucpIs+1PeBbV5PAdHkq8rcDrfd
 okdYyvEdtXLANaFLu27B/PgemLb6iGX3OB/Gv7HXnpwZY05X1pMOvHk31QO6nCLnpZ3O
 NNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699607802; x=1700212602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=078LHjHgYcIKXgy3K59FfW1+FGsAoPUrmucU4b2BaBI=;
 b=Jolw+4Y/DNsjf3CsBCn9tkwzIFOwDaeooG3mltf8o2opjBuuwcjaaghrIya6VUH1dK
 tcqhwz0Nm+V7E2SLKRDwGTZ1km2ZV85T2NnGJ19JBHqGEndSSgZymnuQoZZKgT+ZR7lv
 DwODcfx0A0llsSEU6ExaQkiraBr0hUvz7LcBpvW0DwkA+efxjYHo1BKv4yabM5L1iPRK
 yyqsbVKs7EKy/G43kVynJI+dDsCRUad58rizSthm/7BdtRf+eJe5z3l4aTb8fUsNwkVG
 GKoKoXbX5D1dX1Ln0PtgwKR45ksmi1LmDlbCRgyrjzQlqV0mUF1iL/0lLoRtVkDpjLvd
 Lj8w==
X-Gm-Message-State: AOJu0Ywbgfz9Qty/g8LB8cL9LjHRC+g42pi3VGJ1m6lE39LIM2e0wkc4
 CLahpiydcFgskOKzR58Wp38AEOfq/y5njZ31m3a9xA==
X-Google-Smtp-Source: AGHT+IEZrs31ztoeShp0cUaqp9ycmiYeKJfoccSjx0r/JPcjbEC6jIAOhyJDpM3icmAxv9kMxEqy9g==
X-Received: by 2002:a05:600c:293:b0:406:8c7a:9520 with SMTP id
 19-20020a05600c029300b004068c7a9520mr6264962wmk.36.1699607801844; 
 Fri, 10 Nov 2023 01:16:41 -0800 (PST)
Received: from localhost.localdomain (adsl-205.37.6.2.tellas.gr. [37.6.2.205])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a05600c359600b004080f0376a0sm4537493wmq.42.2023.11.10.01.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 01:16:41 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/2] Add QEMU_WARN_UNUSED_RESULT function attribute
Date: Fri, 10 Nov 2023 11:16:37 +0200
Message-Id: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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

Functions that return a value to indicate success or failure can be 
decorated with the warn_unused_result attribute. GCC will stop 
compilation if a caller does not check the return value after calling 
such a function. This was not possible to spot statically before, but 
Coverity detects this kind of bug. I was prompted by

https://lore.kernel.org/qemu-devel/CAFEAcA_TS-B0gc-DUYT6BaKnm8Uauhsx3rW2dmVNUgTToVjSJg@mail.gmail.com/

to prevent this from happening in the future.

This patch series depends on 
<20231109162034.2108018-1-manos.pitsidianakis@linaro.org>

https://lore.kernel.org/qemu-devel/20231109162034.2108018-1-manos.pitsidianakis@linaro.org/

Manos Pitsidianakis (2):
  Add QEMU_WARN_UNUSED_RESULT attribute
  Add warn_unused_result attr to AUD_register_card

 audio/audio.h           |  2 +-
 hw/arm/omap2.c          |  8 +++++++-
 hw/input/tsc210x.c      |  8 +++++++-
 include/qemu/compiler.h | 14 ++++++++++++++
 4 files changed, 29 insertions(+), 3 deletions(-)


base-commit: ad6ef0a42e314a8c6ac6c96d5f6e607a1e5644b5
prerequisite-patch-id: 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
-- 
2.39.2


