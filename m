Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E92F7C8C1F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLg3-0000zt-PX; Fri, 13 Oct 2023 13:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg1-0000zc-Jq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:17 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLfz-0005U7-Ta
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:17 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b72807051bso285230b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217014; x=1697821814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=amw5rWwKOEnOt99g+OsLsyKAiCnRelMX/V2tMxq7+tU=;
 b=pWl1C7H5WQg+HcupR2EWrxNLuZ/oW+vx8BSvrvE8q+ZzeS3Snlo5kRvOS4Tix9gbSI
 rfmfg3k6mIq6rNVjPg9fJoPeFbmyLrE/akXevAtkwWL+Bx42KEEjwNhwPQGO5fI4X7HM
 SaIVrjR7J/rwf86pLCrFMfECvIhNrfjDZjGNlR6u+jo16xP7JfQTdtJ9P1IPOMP5AXFj
 MB0eaJicMO7lO9alpEEOUj050rv+0vi917NYBr8wkHG7mcGbTZWja9FwtGXjCYnNjr/l
 XS2a8DhTaDk1KPOpRnyocrZP+ibjjK8ZdrCbcKYHnj/PXE4jOjUQ4Zzf+9W4hbDtlNx1
 0FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217014; x=1697821814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=amw5rWwKOEnOt99g+OsLsyKAiCnRelMX/V2tMxq7+tU=;
 b=MrAA1Ntc70W06VKXc3U/mStVWvrMQQs0JNMlIPQntzKl8mZMxfsjfn4Q489pqVOCsz
 vLCUc+77nIkKCXjyWdYBWRNxkPRSrxaQz0/1g59GnD3UyQ15cDHkdab9tZdteScuAzF2
 ifG+nqeAGkmIpLnJ3T9e85lvjn/Aty5VSRjU5MXV+ZmYBOFttzSpgMfhXIL35LgsCtDw
 fT8lXDyv+qE1gmlNYxJHUt04+TejhluTE1sdY7kld00e1Zf4F5AcAY/SBfqXngMgvwxm
 /fWoBj7P9tJj37i5XO/nuHwbi4rdEH4rzrmDC16vQiFM8inBEXdoFJn1qx6gtMHatilo
 O/0Q==
X-Gm-Message-State: AOJu0YwnesZDhr0hWWBP7ajI6g6rnKclPXUhiGmm+wXJ3+9U8YQVfHgH
 JUKQbQugEYFY8Lb2pT4CdqujuRdFJpA0A+OqE1I=
X-Google-Smtp-Source: AGHT+IGf8oPz+2D43EzEKaLL5rmWca7PCGMG0ABk3F8YS68yVQTIGyVo2LnbjfPki8GZa4jqczY3+g==
X-Received: by 2002:a05:6a00:1810:b0:6b6:e754:9e02 with SMTP id
 y16-20020a056a00181000b006b6e7549e02mr1105172pfa.12.1697217013811; 
 Fri, 13 Oct 2023 10:10:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 00/13] tcg/ppc: direct branching, power9, power10
Date: Fri, 13 Oct 2023 10:09:59 -0700
Message-Id: <20231013171012.122980-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Build on Jordan's patch to allow direct branching and USE_REG_TB
to co-exist.  Use the power9 addpcis wherever pc-relative addrs
might be handy.  Merge in my power10 patches for prefixed insns.

Finish up with an RFC to disable TCG_REG_TB for power9+, when
pc-relative code sequences exist.  I've only lightly tested this,
and it seems to increase code size by a few insns per TB.  It
really depends on how much we end up using the constant pool.

Changes for v4:
  * Fix tcg_out_addpcis.
  * Drop RFC from the final patch.  Jordan's testing suggests that
    pc-relative addressing is slightly better than tb-relative.
    I can imagine that addpcis+ld might be fused in the pipeline
    to an absolute 64-bit address, and so has no real cost.


r~


Jordan Niethe (1):
  tcg/ppc: Enable direct branching tcg_out_goto_tb with TCG_REG_TB

Richard Henderson (12):
  tcg/ppc: Untabify tcg-target.c.inc
  tcg/ppc: Reinterpret tb-relative to TB+4
  tcg/ppc: Use ADDPCIS in tcg_out_tb_start
  tcg/ppc: Use ADDPCIS in tcg_out_movi_int
  tcg/ppc: Use ADDPCIS for the constant pool
  tcg/ppc: Use ADDPCIS in tcg_out_goto_tb
  tcg/ppc: Use PADDI in tcg_out_movi
  tcg/ppc: Use prefixed instructions in tcg_out_mem_long
  tcg/ppc: Use PLD in tcg_out_movi for constant pool
  tcg/ppc: Use prefixed instructions in tcg_out_dupi_vec
  tcg/ppc: Use PLD in tcg_out_goto_tb
  tcg/ppc: Disable TCG_REG_TB for Power9/Power10

 tcg/ppc/tcg-target.c.inc | 277 +++++++++++++++++++++++++++++++++------
 1 file changed, 236 insertions(+), 41 deletions(-)

-- 
2.34.1


