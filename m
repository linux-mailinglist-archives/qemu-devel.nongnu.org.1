Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA9749508
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 07:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHHiQ-0003Gx-HD; Thu, 06 Jul 2023 01:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHHiM-0003GK-9D; Thu, 06 Jul 2023 01:39:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHHiJ-0003yg-Ut; Thu, 06 Jul 2023 01:39:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b89e10d356so891735ad.3; 
 Wed, 05 Jul 2023 22:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688621971; x=1691213971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t8eMOUdjwjx45ZbFU0bDgCsnLhHmOXHPvngyXVv5AN4=;
 b=DVfsRqG1fy5kq8T86z/APrKhdnkWVYd4s/jt5IHZ1wG39dnyTVSv7Tx/067y/AXX6f
 BMs3eKQrolKxVkrMjsM4+foWgy/bOMD9N5IAfJ2sKp4z3KhNx7LMjfyQhETqSFDrviVj
 chmJP+vRQo1VbWGZtCG+OoW0b/cbWo/BSf0ERuHB4uD9jtkdbybxWdePxYihUXdLp4/z
 4Ugne1nRXTLbRyllip/7KkGO8D/7lrKqf1mGLdfSa18g+EbnZ89RFOh6Hr4S7Gg/QRFv
 xm+mnkCYTgP24n1l4pug/dzOIiwqbgd5UHD2l978d8pGAddXIgx6s7tFSAPIftVne7gx
 Hntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688621971; x=1691213971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t8eMOUdjwjx45ZbFU0bDgCsnLhHmOXHPvngyXVv5AN4=;
 b=YbcIQDcXAGbKlYCtS2crXaZzSc/ywAw7GUGbocSQQT0lxdFYsUjBxOVkv8Wci0NvxA
 S1eYxCX72FqHDEHW2hB27X9pxf6r75PbuktP05aA/ALp4HT9fKgeZOP54+jR/GIDI5Wy
 W3mdkCWLFFyHmFsd54ct+HurVvG55rwdMIuilBy89Yt67osjAto3+nTrCS0SqjWtkTh3
 hbudFjTGrc7d4pYEIlk3eIUMozaa46nGN3AkwZij6db1yhooPpl67/FiQfjNp9eoBep1
 bczCiQBrZ9QO1vQebQ2f0pRMufx77bkIkWZ4AZR0GfprXo9cczuCmYSUZSw9p1tVRrbY
 IyZg==
X-Gm-Message-State: ABy/qLZtLaREDcjs7r9Oy3nGICtHvjZBIZAIW14qkXgO/IbgvotL4f/8
 vmDZWjQGAKL0Yv7h4g9/xNQ=
X-Google-Smtp-Source: APBJJlGbaM7LAUZBlZDyEdKLqciu91dg/h5eCIjtoPBGlnaAA07GUJ+hLNK62f0t1oRTCnjJ295Y5g==
X-Received: by 2002:a17:902:f546:b0:1b0:3df7:5992 with SMTP id
 h6-20020a170902f54600b001b03df75992mr933225plf.32.1688621970862; 
 Wed, 05 Jul 2023 22:39:30 -0700 (PDT)
Received: from wheely.local0.net ([61.68.2.145])
 by smtp.gmail.com with ESMTPSA id
 ix10-20020a170902f80a00b001b3d8ac1b6bsm427764plb.212.2023.07.05.22.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 22:39:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 0/2] ppc/pnv: Set P10 core xscom region size to match
 hardware
Date: Thu,  6 Jul 2023 15:39:21 +1000
Message-Id: <20230706053923.115003-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

Sorry about the paper bag bug in the first version of the patch -
I broke powernv8 and 9.

This adds a xsom_size core class field to change the P10 size without
changing the others.

Also added a P10 xscom test, and passes make check.

Thanks,
Nick

Nicholas Piggin (2):
  ppc/pnv: Set P10 core xscom region size to match hardware
  tests/qtest: Add xscom tests for powernv10 machine

 hw/ppc/pnv_core.c            |  6 +++--
 include/hw/ppc/pnv_core.h    |  1 +
 include/hw/ppc/pnv_xscom.h   |  2 +-
 tests/qtest/pnv-xscom-test.c | 44 ++++++++++++++++++++++++++++--------
 4 files changed, 41 insertions(+), 12 deletions(-)

-- 
2.40.1


