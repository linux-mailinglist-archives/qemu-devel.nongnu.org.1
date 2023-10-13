Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D257C8C9A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:52:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrMJt-0001KI-Im; Fri, 13 Oct 2023 13:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrMJr-0001K7-0f
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:51:27 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrMJc-0004jw-IV
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:51:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c88b46710bso18223225ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697219471; x=1697824271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e461dKZbVEcZFsG+p5G+fMxyaajTuKonL2vTTJDuK5k=;
 b=nmLn+OrO7h35yzQU65Fs/yAz9fNYimJ1jcJNPX2ud73RtcWyg9uyzY248qhDWPjq/o
 p64y5XCx7DPepuUob11R8f7i9/yWg53eYXTQ4195BPKFPn4ygtLkcCTXE4cifqfOsiyO
 XmrO0sIKgKCyv7wVyGzTtXVZsjVMSirfIggBSEaEuhCq3GjEQdC2bTXpy+rCJqaMleY/
 wKniSq30MCxGqRfRCdcqfOYIeG3/MQAoFCdUfMXV2ElCVwEiKSJnzVAJOdgKTZm3ovFH
 4XJdkZkwy9p9leHGDKVG9qu/kLy4ZJOV8jsmpXq4ry2uiBlpxdys7opi9buOId3XkVzE
 qgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697219471; x=1697824271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e461dKZbVEcZFsG+p5G+fMxyaajTuKonL2vTTJDuK5k=;
 b=sEkTMbI1/WjcA++XX0OhyNY6yKB2yBV8q8qOVAerWw2T4XNt3eGPDC8euUv/oebOjP
 EdZyGFy6mstpWXv4y1smvEmqhDMWzfBq+VSJzfVOSxAsMJZ7hh9L7xjbmXXKf7hg/JMs
 Df6mg63TnMzcILACEm1dUpijdRKbKUGBsp1zskJo1P+DM9LyPWpnC8+GrfLlPi9Dw+Rb
 8mOhP1rY5dbPlwXblaXV6OB8mBacP4l5+aoVTbNTvaDdBmeppwJL9tY6nPnfwUr/uTQ0
 gYoTv4788L7Kg3GlyniGwgnXIguwRj2GyP9vFBIxF5qirnQ4QLlFU/PwYzfX3m8XKGXi
 tfhw==
X-Gm-Message-State: AOJu0YyssBEqxQrL5ongh608PG/E9+58Lo1bfbTEfLBgI41ad85Xusyy
 75J+WK6ulLsxToxyytZ1y9nqPOC4k269YK2kNm0=
X-Google-Smtp-Source: AGHT+IGWxcvMIaQLRjcRdr0VYFW9ksOTUT1vYDG/+deT3jiom1s8/xIEX4UQ/GZrIR006xjbEqJY0g==
X-Received: by 2002:a17:902:e847:b0:1bd:d92d:6b2 with SMTP id
 t7-20020a170902e84700b001bdd92d06b2mr30307089plg.10.1697219470679; 
 Fri, 13 Oct 2023 10:51:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h24-20020a170902ac9800b001c3be750900sm4164324plr.163.2023.10.13.10.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:51:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 0/2] tcg: Streamline vector load/store
Date: Fri, 13 Oct 2023 10:51:07 -0700
Message-Id: <20231013175109.124308-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We have tcg_gen_qemu_{ld,st}_i128, which can be used to implement
load/store of vectors to guest memory.  But at present we have to
split into, or concatenated from, two i64 to reference the guest
vector register backing store within env.

Provide tcg_gen_{ld,st}_i128, which can avoid the trip through i64.

This does require that the target store i128 in host byte ordering,
which is true of i386 (and some other backends) but not arm or s390x.
There is definitely further cleanup possible.

Changes for v2:
  * Set atomicity for x86 vector operations.


r~


Richard Henderson (2):
  tcg: Add tcg_gen_{ld,st}_i128
  target/i386: Use i128 for 128 and 256-bit loads and stores

 include/tcg/tcg-op-common.h |  3 ++
 target/i386/tcg/translate.c | 63 +++++++++++++++++--------------------
 tcg/tcg-op.c                | 22 +++++++++++++
 3 files changed, 54 insertions(+), 34 deletions(-)

-- 
2.34.1


