Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F667E0655
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 17:24:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywwc-00034a-DM; Fri, 03 Nov 2023 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qywwa-00033y-40
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:22:48 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qywwY-0001i8-2P
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:22:47 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ce2ee17cb5so1381956a34.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699028563; x=1699633363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1GA7dCjPIEa2G0CDrztcduio+waxL2jiD4kwCyJKzdI=;
 b=aA6EuJskmni54kgMwqZvGiQo+5yfQKZL/YwTriA0LW/BUHfTMY+YJL8nhHxF/iUltf
 vqoSfmlzpOV+D9eueUDH0HoWN7UtR7xvqUP7p4n3EwqRsKvyimZahgaTsjHY0udnN3s5
 yBPrSOhkGlrYWxKYIKoB4nnI6W3bgCOFTz44+R4mHDYE8vhKtQF414wta/MRTzlo8mKu
 G9gmF/BFE4dq5P98xb3FLpK9BWY8K/6uazeF4UXQt/BhnFKcoPttIWBKZQ64V5NHaR+e
 4/nkc6XiWdCLThyEgqFnGwUmRkgp8fz8bcQbX3e0rpzBogQryG0KCMz1z8IBemEoz/uL
 mYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699028563; x=1699633363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1GA7dCjPIEa2G0CDrztcduio+waxL2jiD4kwCyJKzdI=;
 b=wOvfFB+FIgM5V71pQ3rpFRvrmj3wqAowydJKi/QsQFuVk7O8zRLhpz78J/E7XjsAtV
 WArLxRylmpZuRFOHNDs+17U6tWJrNUzYDf4kiVAH3uXcqqTUypB/tkAwDALudvpdc5Ko
 M5DgivXKON33HpK90rkaAskqFp3C4QRVOaXd7V6jenRAK0w1LgDCmpqdbYmBzsgEqonE
 tQ1UXIcGSd1xhxqPMSQhOydrnJTLQ3lrGWXimskHdhBA1xy+NdN8U3jwRohsPcvq36HO
 UfFll5Zz+MhgY0p1KCse75oK3ZbVeLMiKBt10GJutx6Yl/RBrqgG002VpSh4WOxaj3Jf
 BLvA==
X-Gm-Message-State: AOJu0YybaCSWA1f1Ki0Xt0I/y212rD9iEsPF4Bj8g+01KCkH1J8oPplt
 kr59f7xYDLHOyhoE7ZIuEwcOMK4a6vz/pA==
X-Google-Smtp-Source: AGHT+IHhUC/05c7GQCN/QysO2R87VHlcW91bLj8XiR+x1mARN6HsWaBM0d0WPcXuPJG9rHKW0T4haQ==
X-Received: by 2002:a05:6870:12c7:b0:1f0:b31:9b7 with SMTP id
 7-20020a05687012c700b001f00b3109b7mr9876774oam.43.1699028563198; 
 Fri, 03 Nov 2023 09:22:43 -0700 (PDT)
Received: from taylor-ubuntu.austin.rr.com (cpe-68-203-8-61.austin.res.rr.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 t7-20020a9d7747000000b006ce2c31dd9bsm316039otl.20.2023.11.03.09.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 09:22:42 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, richard.henderson@linaro.org,
 philmd@linaro.org, ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 0/3] Hexagon (target/hexagon) Enable more short-circuit packets
Date: Fri,  3 Nov 2023 10:22:38 -0600
Message-Id: <20231103162241.92926-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32f.google.com
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

This patch series improves the set of packets that can short-circuit
the commit packet logic and write the results directly during the
execution of each instruction in the packet.

The key observation is that checking for overlap between register reads
and writes is different from read-after-write.  For example, this packet
    { R0 = add(R0,R1); R6 = add(R6,R7) }
has an overlap between the reads and writes without doing a read after a
write.  Therefore, it is safe to write directly into the destination
registers during instruction execution.

Another example is a .new register read.  These can read from either the
destination register or a temporary location.

HVX instructions with generated helpers require special handling.
The semantics of the helpers are pass-by-reference, so we still need the
overlap check for these.

Taylor Simpson (3):
  Hexagon (target/hexagon) Analyze reads before writes
  Hexagon (target/hexagon) Enable more short-circuit packets (scalar
    core)
  Hexagon (target/hexagon) Enable more short-circuit packets (HVX)

 target/hexagon/translate.h          | 117 ++++++++++---
 target/hexagon/translate.c          |  75 +--------
 target/hexagon/README               |   7 +-
 target/hexagon/gen_analyze_funcs.py | 252 ++++++++++++----------------
 target/hexagon/gen_tcg_funcs.py     |   2 +-
 target/hexagon/hex_common.py        |  10 ++
 6 files changed, 227 insertions(+), 236 deletions(-)

-- 
2.34.1


