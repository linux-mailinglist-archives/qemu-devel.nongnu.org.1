Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7E178E4F7
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 05:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbY3a-0005LQ-NM; Wed, 30 Aug 2023 23:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY3R-0005Kw-G8
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:09:10 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY3P-0001Fe-DX
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:09:09 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c22103bce7so2404945ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 20:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693451345; x=1694056145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4kA3BLp0/lMld5v9IKqvfrL44Pt22Fu1VZt4VFTiNsk=;
 b=RoYAZliVWZ+ovTmdYQk/GC4FDHxi00Y58qolgfCwE7y727Q8wPUI7Add5jLHG7aqKC
 geN3npLiIi/1hnO7+0AZleSt5BdRmCNpz2AHErkDFkSg90rPmmKPGcejg32A3algRl9X
 UpBlmQKV755zdFXwmKCA5PHRsQilSOLzjVK0xA/Q4GbfE1yMxE/taP+hhS5WO+MerW0E
 BLZ+J96bB2o1XVVM3e0nGcC6//YAQoGjMWsZY60TsZ24QqTEmWvNUxN1Tx+NW5UvCnUE
 sHw6c0j/yBK44ZEepJQnlsbIBELt6/3RU/PShnEOWDG9m3xfyzvu6oKWAZHkIKEFTVUL
 IgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693451345; x=1694056145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4kA3BLp0/lMld5v9IKqvfrL44Pt22Fu1VZt4VFTiNsk=;
 b=Bktxc73zg0Z7xEK7UYS0c8+6a9dEflBLPCZqSobHSLiNQHvqi9ClIpsZzC+iJiWggd
 QBZqoNv48I/YWTH6Nmba/Ppg9LcaZSwdEVEOLyDDOF7S38BYhFVO0Dp0pZInF6+r0rzg
 4qpP01iJxH3bAV8B9GGMFvCkqt9c8B4O61VwOPATmHYT7+011AVGFGk+iaY3yRNqWfQ/
 vuU0h06MoAdZbOpThUhuLLdlVJ1HNz1YLImlzev+/yPDBvD7wTrFzg400XYR+g/5lu0W
 L895fB6CxmOa2mDyH0MnFFu0iplnh9jcHDFOd6li36CqGF5QYl2JvJjra8/PLafQddDq
 osBA==
X-Gm-Message-State: AOJu0YxSYfiTCYcqb9qEGBz9t1Jy2YG6ShB1t+g6dsclS2LZRlR7iTDO
 5xqgT2HguomMB6hCn7RsP3h7Z/CIiGtl6UrAGDI=
X-Google-Smtp-Source: AGHT+IFXE/1SAebcv6+VuvnjxXNMiyOEzNqnGoJn2ZqJXVRzjkFaZRrmNbG3tMcg9EPjC17s5vLoEA==
X-Received: by 2002:a17:902:b281:b0:1bb:3979:d467 with SMTP id
 u1-20020a170902b28100b001bb3979d467mr3372087plr.63.1693451345557; 
 Wed, 30 Aug 2023 20:09:05 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 ix21-20020a170902f81500b001bba7aab826sm225123plb.163.2023.08.30.20.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:09:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn
Subject: [PATCH 0/2] tcg: Add gvec compare with immediate and scalar operand
Date: Wed, 30 Aug 2023 20:09:02 -0700
Message-Id: <20230831030904.1194667-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This should be usable for loongarch64 as well, rather than
rolling a local copy there.

r~

Richard Henderson (2):
  tcg: Add gvec compare with immediate and scalar operand
  target/arm: Use tcg_gen_gvec_cmpi for compare vs 0

 accel/tcg/tcg-runtime.h          |  25 ++++++
 include/tcg/tcg-op-gvec-common.h |   6 ++
 accel/tcg/tcg-runtime-gvec.c     |  26 ++++++
 target/arm/tcg/translate.c       |  56 ++----------
 tcg/tcg-op-gvec.c                | 150 +++++++++++++++++++++++++++++++
 5 files changed, 216 insertions(+), 47 deletions(-)

-- 
2.34.1


