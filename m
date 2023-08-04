Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027F770B0F
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 23:35:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2Qu-00067n-6P; Fri, 04 Aug 2023 17:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qs-00067N-8Z
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qp-0001r2-9u
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:01 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso18001615ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691184837; x=1691789637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=irTsi/f0jepGemOBOwrmATTWT5AramkVaQf262N01N0=;
 b=cA9mb8YdlHmrrMK89g+4TsHImBVVRswJrrDivilF4F4M19Nuk9DwkGGfbIDqlbCMEm
 lFSaHls/vGkGBIFcCg9m6epVGIavwESy2/zP0PLNLtnePiKXQN5ALcASxU8M2nji66UZ
 goSFhkNDuv3gsnzHpZbXFppV0bTwpNBaDOOZIGTISut2O570/5bogHm/ik6db02wxZvT
 jNPukDR5ycBPt6tMpv2/13k+RzRAxSSzyWF5bTkOupOb4QIFPBnq/9pUUUvJ71kzLDJu
 fZaEnKsg/tlWMXVXynphmScmKgFivElsmFsByUzdY1GxJp6CbWi1rNP/EOekWmiD0wL8
 cnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691184837; x=1691789637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=irTsi/f0jepGemOBOwrmATTWT5AramkVaQf262N01N0=;
 b=cmJ7/6VZDjFsrXhYPCKTdaS0jUbpL97XU1R+fJCjwVWreHzT+FjISVcAsoY1Vh5t11
 naSU1aiHZsCsVo/TCo5QbKgzvF4Ys4QnpLMtfQgIOFCSBZ78jnS+vxhO/DE+ufeNnXLP
 4qVUSvwUqmdzQ99tw6IJOgnDffHS3S7f8SPo6zw1qF3VyB0Cf5kJRR9JDF9lrXmnaD9y
 sp8BY9/XVWgQ5Y2r7o6W8ZkMBviAHlahg1uud3IKeHg7m3SwsKoAD/89l0UC5YDHNYn+
 8hOdArPGu+2yPOJa+iEbCPHDtguaaOcoRKxK4c4MsIgCjFHE9QNGvXSCbUlIsor4gkS6
 U5Dw==
X-Gm-Message-State: AOJu0YzUF/fAV3Dg/CS13uWDgvlGcC6/WuAW1ozjgNFQ7HFgxcYtf5sT
 06xL3+KZWloz2g8vraVtkAp9w4ey9xG68wYQBDs=
X-Google-Smtp-Source: AGHT+IFPHS12RRUWxEfdNpLJf/IiD/5JKUDhX+Jmyk9scuIP7zPVm9EX/nNQu/4p6nnQWfe43blZqg==
X-Received: by 2002:a17:902:cecf:b0:1bc:239:a7bd with SMTP id
 d15-20020a170902cecf00b001bc0239a7bdmr967554plg.6.1691184836775; 
 Fri, 04 Aug 2023 14:33:56 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001ae0152d280sm2188662plg.193.2023.08.04.14.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 14:33:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com,
	qemu-ppc@nongnu.org,
	bgray@linux.ibm.com
Subject: [PATCH for-8.2 0/7] tcg/ppc: Support power10 prefixed instructions
Date: Fri,  4 Aug 2023 14:33:48 -0700
Message-Id: <20230804213355.294443-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Emit one 64-bit instruction for large constants and pc-relatives.
With pc-relative addressing, we don't need REG_TB, which means we
can re-enable direct branching for goto_tb.


r~


Richard Henderson (7):
  tcg/ppc: Untabify tcg-target.c.inc
  tcg/ppc: Use PADDI in tcg_out_movi
  tcg/ppc: Use prefixed instructions in tcg_out_mem_long
  tcg/ppc: Use PLD in tcg_out_movi for constant pool
  tcg/ppc: Use prefixed instructions in tcg_out_dupi_vec
  tcg/ppc: Disable USE_REG_TB for Power v3.1
  tcg/ppc: Use prefixed instructions for tcg_out_goto_tb

 tcg/ppc/tcg-target.c.inc | 233 +++++++++++++++++++++++++++++++++++----
 1 file changed, 211 insertions(+), 22 deletions(-)

-- 
2.34.1


