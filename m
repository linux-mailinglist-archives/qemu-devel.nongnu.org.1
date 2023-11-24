Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF5E7F7EA8
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 19:34:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6aze-00023g-8N; Fri, 24 Nov 2023 13:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6azb-00023R-TN
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 13:33:31 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6aza-0003Wc-D4
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 13:33:31 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40839652b97so14779585e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 10:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700850808; x=1701455608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BG9qzMW6vxKLmuHoOIA+8WNn8X06Rkd4nFOlQKcmM9g=;
 b=FP3Toa3/UvnJuZVRPiWnTVJ6c/YMKiK3WV1EJ00wokyi0Wb085njUmnxx437PTwHhy
 FDwOYtJW/GowAS66j/iFpX/TvtOqCIfHWXGjPjdcHjJCGpMwW4h6SuVjbyN3uUADCDyU
 93h6Sl6N1yZjZWJbEMyuMffh+ht/D58KMNKArd3jF483LWbrHIuFL5LmD+krxwnfutzL
 uD1mcNCQtIM5BrEMAKy46OQKDwEXE46X5sUT+oNKO+NF0PzOmV9+vxycBjkU6DBkY1bC
 6vclGsd1tXQwCSVI+RyzlAeotCSxEkDD0/c3wtWJnymfKYq/Lbc6wqNwaKZWZuhGmkdW
 Mgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700850808; x=1701455608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BG9qzMW6vxKLmuHoOIA+8WNn8X06Rkd4nFOlQKcmM9g=;
 b=Loty5EO+CgLsaYrbKK86ScctJV3a+J5snOkjmyh5DDK27Oi3uhKaXuuBjqxRcjzLan
 SsRWqH/EjKdVpp9emlQVZDEVq/AlNq5WzpA7W9Ien1nLljbjnAirmdPzVrbIMZqmA4nj
 fBYzyu5sY/i8WwqvnJofw264ltJK5V32qgWgb06ZzDk4I0ajspXNJuQWrZ2KejkZ+nvu
 o3rCP4y3T099c3Ktp0oKorSJxqFo/g4vjgw0N+v3sSv7YGcaYfqu/RCwX47ssyXRh6On
 1LQiqa2rx04H54WIt09PUbe8VXR+JeUi8TTOW72DGiU7pXXojnyGcguw+wnDJG6+5cVb
 R04Q==
X-Gm-Message-State: AOJu0YzmJfQyl7bJo0zpwQ70dqRftCtwybyjCwoX4txHnCgBjRwhFn+P
 SX8f2l8RZJsinv4P1PtTELk3PpESpv0HCf4dKt4=
X-Google-Smtp-Source: AGHT+IGDSzPjgXziGmffWuAst1W1XtAWm1ccNmd5DM9vH4mXqrdXdxBjIc5whUe5BlPzD6kRQi3ofg==
X-Received: by 2002:adf:e808:0:b0:331:3b59:3edb with SMTP id
 o8-20020adfe808000000b003313b593edbmr2352654wrm.42.1700850807945; 
 Fri, 24 Nov 2023 10:33:27 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a5d5304000000b00332eb16d215sm1786310wrv.23.2023.11.24.10.33.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Nov 2023 10:33:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Vikram Garhwal <vikram.garhwal@amd.com>,
 Anton Kochkov <anton.kochkov@proton.me>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2? v3 0/2] hw/net/can/xlnx-zynqmp: Avoid underflow while
 popping FIFOs
Date: Fri, 24 Nov 2023 19:33:23 +0100
Message-ID: <20231124183325.95392-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Series fully reviewed.

Since v2:
- Addressed Vikram review comments,
- Added R-b tags

Fix a pair of fuzzed bugs.

Tested with the CAN tests from 'make check-qtest-aarch64'.

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  hw/net/can/xlnx-zynqmp: Avoid underflow while popping TX FIFOs
  hw/net/can/xlnx-zynqmp: Avoid underflow while popping RX FIFO

 hw/net/can/xlnx-zynqmp-can.c | 67 ++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 11 deletions(-)

-- 
2.41.0


