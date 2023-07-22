Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7761475DBED
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 13:36:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNAtN-00061s-Ln; Sat, 22 Jul 2023 07:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNAtJ-00061H-01
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:35:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNAtG-0000hk-5T
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:35:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fc02a92dcfso22977515e9.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 04:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690025709; x=1690630509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=INqOnPLZqSMtROwuX5yxRREghns2EQI4fhnRTubU2b8=;
 b=lwYjo8pvyntXBiUx8Z654pE6RF5AkbmsMtl99heNwRgb87ZiTw2R9fgyfdf/UyyciH
 YlfZQYzM04odIOfYXjWXWIzYKi8d4MGR8NwyxSMDNScpIgTBLYTx6zT6exrfrL6e3S3g
 Aa+AhOna/1fTPOV4Gu0wYCJmOcj0o212AAElLXax7ygj4xE+CwFQHml/VAOOtLqCEiHr
 5e3Gu32LNI6cVtaqA1UGSygUIduKOoJAOdpoH974/nV09YRjR60yxlJjlz1M33d7mrFM
 rx3j7DGouWn0TvD0DJ/F9ErT47znPOhSrXjLoOFuq3z1nI+fWeX1WN5Afh8YwVrZklyB
 nyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690025709; x=1690630509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=INqOnPLZqSMtROwuX5yxRREghns2EQI4fhnRTubU2b8=;
 b=M1I5D+oe+PdyqdcebCb7HEBSYT7XRA1v9aqnXL2yPCM2TsC7g3lUBXsbDxetrmhKAX
 xEEuLH+7iUFCWkWl/s7iphD8tsvG48u2bPRvcy5koxRlQnF+zm5iPnCxvClyTfmOqO+6
 2BQNk2dLXJZ/sbL8GDtfmZR+DMFeDnE1zqxjvj4pVOhSYEl88jI5R7tcoEpIh58WSmh4
 vY4MxaFE8yj9B8xXcxzXwt1pq+4m3O5qwuR37g4AqwwC+/r+h4qehGHe+/SdBvfwLx4q
 2lkBL9ORN43jN44JZaw2j7ZrbSnU6uwbt5ewcstQzvzgJLQ3fUjXditBh0EiP3WBRs+7
 NMpA==
X-Gm-Message-State: ABy/qLbLn2XQgikgVFfr59LSV21kkCch1aaM++at5f3VJrxDl24BQEUb
 3ruek4UFBJ9h5v2vBQh2fLYp/dqDFI3lD3xCDnrQNA==
X-Google-Smtp-Source: APBJJlFH2Yswul1IvLg+ABxURxtZCZ435JFSYXRm5myreBpFHrilW/GgIhNdFSY54czUf2BNdvxqfw==
X-Received: by 2002:a7b:cb8e:0:b0:3fc:27:7e46 with SMTP id
 m14-20020a7bcb8e000000b003fc00277e46mr3680694wmi.3.1690025709042; 
 Sat, 22 Jul 2023 04:35:09 -0700 (PDT)
Received: from stoup.acentic.lan
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a7bcd8f000000b003fbdd5d0758sm5130938wmj.22.2023.07.22.04.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jul 2023 04:35:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH for-8.1 v2 0/3] accel/tcg: Take mmap_lock in
 load_atomic*_or_exit
Date: Sat, 22 Jul 2023 12:35:04 +0100
Message-Id: <20230722113507.78332-1-richard.henderson@linaro.org>
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

For user-only, the probe for page writability may race with another
thread's mprotect.  Take the mmap_lock around the operation.  This
is still faster than the start/end_exclusive fallback.

Changes for v2:
  * Introduce WITH_MMAP_LOCK_GUARD, to simplify the changes.
  * Fix the probes for not-writable.
  * Handle load_atomic8_or_exit and load_atomic16_or_exit similarly.


r~


Richard Henderson (3):
  include/exec: Add WITH_MMAP_LOCK_GUARD
  accel/tcg: Fix sense of read-only probes in ldst_atomicity
  accel/tcg: Take mmap_lock in load_atomic*_or_exit

 include/exec/exec-all.h        | 10 ++++++++++
 bsd-user/mmap.c                |  1 +
 linux-user/mmap.c              |  1 +
 accel/tcg/ldst_atomicity.c.inc | 32 ++++++++++++++++++--------------
 4 files changed, 30 insertions(+), 14 deletions(-)

-- 
2.34.1


