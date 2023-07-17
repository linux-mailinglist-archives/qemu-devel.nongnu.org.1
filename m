Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE175636D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNgj-0002QG-Q2; Mon, 17 Jul 2023 08:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdn-0008JK-V0
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdl-0008T1-L9
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so40886085e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689598068; x=1692190068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lc/JyiyZgpBbRhPJHv6Eck7fC3EzTyvUqeMAeNaID8o=;
 b=m06OfYyocoroxH3beXUbA1s4DD2mHijPyi0wsYU5/+LzvzhSWf2FG3pk9nFkC8iWvI
 71kL4H+S5vLPqKTIDu2aockE0bTvlfGVZZM46h4kBfKGgDAFG9QQ21fAHwT4q+6yRLRa
 XK1T/Thqk9Qblc1q5hRH6d1NqZZ4BmqAVYB6mQcIvxwjteOS0RKZOqar2/HkPPX2zf2n
 eK1/ccnRXDmDrrYnKHMxZiYOYaP9HLLc4WRmTk681EaKRSFA0R9s15I32lvf0UPjK2aA
 WOKZa+LmtR2eOqjgF+bs1AJLjc5P+sXUITHsL88/icMJt1/xnsyCewqHHE4HLl54Wl2k
 s6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689598068; x=1692190068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lc/JyiyZgpBbRhPJHv6Eck7fC3EzTyvUqeMAeNaID8o=;
 b=DEh+1vZKSU5lDcRdBSJ6WkbJhhtn5CHRcvhFOCp0MRO+8DJBhLuqd3J34imk5HXfJ5
 B1lr8U8HRulvP+mY4uaXeZXJxURlUBPw8o/yqfPLgFENJo++zngAb723wz+XbrdxSMfc
 AG9TFouCXtta0Vbt9fYWumxBeVhTc4LhaGDM8EfiEkwze/EUXtp38UjZAaBXyCaiL99L
 LiJzgGURMARDuJQuMhlFPKRq0kXnm74OByhzCRau1W3OiJ5UcXdvM8rBmeF8oMonL9MJ
 fAPg9QEPbfAY+++HdFIBSPtfRNMKO+VEwl5EINC6FpPydE5MWOUH6oqM1NKp/J+4cIXi
 5atQ==
X-Gm-Message-State: ABy/qLZPXrTxBxJAgPl6vxfiXRzEnr+NpgIPTfirsP9Vx4q5/akuxI8+
 /tC+1J2LC9x/KsZLZfLtsQGmuWX2eTuDDK06Kts=
X-Google-Smtp-Source: APBJJlG8DPwiv2dfmVoxVRzmzWoZx4lF9GDA9Xgl3oCL0y0zYwAP8l+EbEQn+0k7JR0SxBSegnCtLQ==
X-Received: by 2002:a5d:4482:0:b0:314:2b0a:dabe with SMTP id
 j2-20020a5d4482000000b003142b0adabemr9067949wrq.30.1689598068035; 
 Mon, 17 Jul 2023 05:47:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6790000000b003112ab916cdsm19337737wru.73.2023.07.17.05.47.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 05:47:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] target-arm queue
Date: Mon, 17 Jul 2023 13:47:39 +0100
Message-Id: <20230717124746.759085-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

A last small test of bug fixes before rc1.

thanks
-- PMM

The following changes since commit ed8ad9728a9c0eec34db9dff61dfa2f1dd625637:

  Merge tag 'pull-tpm-2023-07-14-1' of https://github.com/stefanberger/qemu-tpm into staging (2023-07-15 14:54:04 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230717

for you to fetch changes up to c2c1c4a35c7c2b1a4140b0942b9797c857e476a4:

  hw/nvram: Avoid unnecessary Xilinx eFuse backstore write (2023-07-17 11:05:52 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/sbsa-ref: set 'slots' property of xhci
 * linux-user: Remove pointless NULL check in clock_adjtime handling
 * ptw: Fix S1_ptw_translate() debug path
 * ptw: Account for FEAT_RME when applying {N}SW, SA bits
 * accel/tcg: Zero-pad PC in TCG CPU exec trace lines
 * hw/nvram: Avoid unnecessary Xilinx eFuse backstore write

----------------------------------------------------------------
Peter Maydell (5):
      linux-user: Remove pointless NULL check in clock_adjtime handling
      target/arm/ptw.c: Add comments to S1Translate struct fields
      target/arm: Fix S1_ptw_translate() debug path
      target/arm/ptw.c: Account for FEAT_RME when applying {N}SW, SA bits
      accel/tcg: Zero-pad PC in TCG CPU exec trace lines

Tong Ho (1):
      hw/nvram: Avoid unnecessary Xilinx eFuse backstore write

Yuquan Wang (1):
      hw/arm/sbsa-ref: set 'slots' property of xhci

 accel/tcg/cpu-exec.c      |  4 +--
 accel/tcg/translate-all.c |  2 +-
 hw/arm/sbsa-ref.c         |  1 +
 hw/nvram/xlnx-efuse.c     | 11 ++++--
 linux-user/syscall.c      | 12 +++----
 target/arm/ptw.c          | 90 +++++++++++++++++++++++++++++++++++++++++------
 6 files changed, 98 insertions(+), 22 deletions(-)

