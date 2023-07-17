Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB30756EFE
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVsD-0001xd-G1; Mon, 17 Jul 2023 17:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLVs8-0001wx-FX
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:14 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLVs6-0007uU-Sg
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:12 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-316feb137a7so1762003f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689629708; x=1692221708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CkIVAjPbnRqMhnZOipZLpkQ7/XZwRySBWQuizCDexjw=;
 b=EEz92TuZ7uARSNHf+Q5K6ajiKQxz3t6P9mXo7/UWOPpZjGfcPAOD5WAfuhvkwy8Ui/
 7e5dI42LsPuQwe5u4ffyq2wwPpgGTK7BHycuwm1S7748KXVr6qz9Lv5HxsQaVXhT7qjK
 23G6p21lYQC4fvQb+q4L+CFHosQiIiUFFW9dkwEN4/94wvOEqjLsEYFlKpZ+7Lm0tcX4
 OUOSgO8kRZRsItbOKXyMiTSw+GrPI5lJby3TfhhbBWNuTONuSC21bObvan6U9tBIzWZh
 PVRk1FDP+76xrAYCU1zzjGYF7at5NlkUiHOcONCzhx6O5XwklOB/m2JcnV+cvzOVhNxJ
 NBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689629708; x=1692221708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CkIVAjPbnRqMhnZOipZLpkQ7/XZwRySBWQuizCDexjw=;
 b=AxsgxBFsEpvWgJw9WzyvpONTVQPNdJtyvbNyqqkyQhB4UGkZ9hUYr3t7Y43Gs+kgO8
 i8GcPFVhdxaVR7or5Unx4YaTLsNg2Yn3fO4t2Yn8ZgWhDuXVPV49YB5lho9WneVopu/8
 Y1OjvuxttvQHozVE3jugCBShrLeLZK+7GoM7h0nS+Zw9ji93mTpDf+O7SjWtJ9aHlCnX
 bH0IbfEghbSU+W9OfE4mkgtHEq1MbEV4+lPp2u2CTZK9By6B4mCU5Q3/ehwEQuw8DsZn
 49hdO8oUQxJ/LNPvfULjkaTxhhQNuhEvwHgKBbKXkawKy5mY3QkKuG9cS0kS5VsU5VSJ
 YKag==
X-Gm-Message-State: ABy/qLZE+KQqOL4npWRxHHdzDBNNUAvd5Io4kEdSfEoagahPgX9LSn4B
 J2HoaYrf8lLwKQ7trPvd7d2Tx6V+2yCXOhlHsMo=
X-Google-Smtp-Source: APBJJlF/uwfacP88Hwtxv2H44i8V1XVXImo5QUl1bi6ZbLfJvBGApg6HGWbtku8t/r8iePx+0k5S+w==
X-Received: by 2002:a05:6000:114f:b0:316:fb39:e049 with SMTP id
 d15-20020a056000114f00b00316fb39e049mr5350623wrx.46.1689629708622; 
 Mon, 17 Jul 2023 14:35:08 -0700 (PDT)
Received: from localhost.localdomain ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a5d6a83000000b003143801f8d8sm455073wru.103.2023.07.17.14.35.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jul 2023 14:35:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH for-8.1 v2 0/2] target/mips: Avoid shift by negative number in
 page_table_walk_refill()
Date: Mon, 17 Jul 2023 23:35:02 +0200
Message-Id: <20230717213504.24777-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

This is a respin of Peter's patch, but
- pass already-evaluated values to walk_directory() instead
  of an assert(),
- check 'ptew > 1' instead of directory/leaf_shift == -1,
- use unsigned type

Since v1: walk_directory() doesn't have to rely on the to sanitize
          the input values.

Peter, if you don't see this as an improvement I'll take your original
patch.

Regards,

Phil.

Supersedes: <20230717162940.814078-1-peter.maydell@linaro.org>

Philippe Mathieu-Daudé (2):
  target/mips: Pass directory/leaf shift values to walk_directory()
  target/mips: Avoid shift by negative number in
    page_table_walk_refill()

 target/mips/tcg/sysemu/tlb_helper.c | 48 ++++++++++++++---------------
 1 file changed, 24 insertions(+), 24 deletions(-)

-- 
2.38.1


