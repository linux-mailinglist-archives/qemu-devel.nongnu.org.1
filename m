Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F89B738E27
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:07:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2Dh-0000Fp-KY; Wed, 21 Jun 2023 14:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Df-0000F1-AM
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:15 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Db-0006nz-T3
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:14 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f8777caaa1so4127249e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687370770; x=1689962770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=slKL0qEFih08fUFX25+/5LU/Qi/Wk8xqBomHUQTCtxw=;
 b=lIn5e/mdoctges1s3ozaAjq12aHy3aeO4uCgOYE7m/18VZs15b8JtBdC/9+n7lqAaJ
 1n/z5lygBzwklK+Megn3WJG0nVoLn+QH0vjzGruaquxL+BuFLth3QhXrbRlwLUp8cH33
 DVGoIiTTPmvHQO8A6S92K9z+0g08tbhVj/5GlHA6Ok7d+VLfX/IYhmbxWy3mgLAS10cJ
 ejL0XFimeYDT0y52Vipij3FAGiiL7Dz1C/u5hZboT1hJyHP8RBZrcGSab98VlY690fM5
 k/bH1x8C5cKzJRFUlDzoQNWsKOq0M02aRYeNsXIvF9wF+AkzNt+k21oxcyzceoUAZ4x6
 L+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687370770; x=1689962770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=slKL0qEFih08fUFX25+/5LU/Qi/Wk8xqBomHUQTCtxw=;
 b=Ews3cH/PUCLe6hw9kfIBvrq7x7Z1y03Uvn/SPtWk1PLSO7hO27aoskc007cChNqfzW
 U8/oNlfWTAVpun/L2VbC200/bdfIrOF4XOXnkw3P2u5/lK84jRc2Sq+8SUTENsUMZ1p5
 cuNaUKfI4kRk+GOTYL5dsCxa0hfGZaFXpT+K3nnhPKln/yYmDtiopgkxDuxEgopS4uiG
 FjhLmL9J5XHSxs1jYSELcWs6T+s4fjIEpHcna8lC1elghjQTr5uOYTWB40L4exfxkj57
 R5rWZ3kPTwYX2RzDKb70whVBS94rwuGO5Fn1WOBPhz2hR8U6RnZU5fwav0DQZ8kKfOdT
 VotA==
X-Gm-Message-State: AC+VfDwwcU4gs0g9IHjF3effieFLTFKZVndlqVRQQ+gyd9IGfXJF+BfF
 QU46MS73o0QawS7Fgi95gWYCufUFXQcxpJLdTxQLkRGH
X-Google-Smtp-Source: ACHHUZ50zcrFsDpgnyifYUBDFkryUOjHqKUHgmFJlMiYIbggUpv6cTg2FT7MmD3nYORNyzUgnpTc1w==
X-Received: by 2002:a05:6512:450:b0:4f9:5887:5218 with SMTP id
 y16-20020a056512045000b004f958875218mr1830572lfk.35.1687370769737; 
 Wed, 21 Jun 2023 11:06:09 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b0051495ce23absm2910944edp.10.2023.06.21.11.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 11:06:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 0/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr
Date: Wed, 21 Jun 2023 20:05:59 +0200
Message-Id: <20230621180607.1516336-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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

Changes from v1:
  * Split into teeny weeny pieces.

  * It turns out the sparc_tr_tb_stop hunk of v1 was buggy,
    in that things that are not simple branches use DYNAMIC_PC,
    e.g. the RETT (return from trap) instruction.

    Introduce DYNAMIC_PC_LOOKUP to distinguish the couple of
    places where we have a dynamic pc, but no other change
    of state (conditional branches, JMPL, RETURN).

  * Drop the change for WRFPRS, because it's too infrequent.
    The WRASI change affects memcpy/memset, so that's more important.

Boots Mark's sol8 install cdrom.  :-)

Top of the profile changes from

    41.55%  qemu-system-sparc              [.] cpu_exec_loop
    14.02%  qemu-system-sparc              [.] cpu_tb_exec
     8.74%  qemu-system-sparc              [.] tb_lookup
     2.11%  qemu-system-sparc              [.] tcg_splitwx_to_rw
     1.63%  memfd:tcg-jit (deleted)        [.] 0x0000000000000004

to

    31.59%  qemu-system-sparc              [.] helper_lookup_tb_ptr
    17.79%  qemu-system-sparc              [.] tb_lookup
     5.38%  qemu-system-sparc              [.] compute_all_sub
     2.38%  qemu-system-sparc              [.] helper_compute_psr
     2.36%  qemu-system-sparc              [.] helper_check_align
     1.79%  memfd:tcg-jit (deleted)        [.] 0x000000000063fc8e

This probably indicates that cpu_get_tb_cpu_state could be
improved to not consume so much overhead.


r~


Richard Henderson (8):
  target/sparc: Use tcg_gen_lookup_and_goto_ptr in gen_goto_tb
  target/sparc: Fix npc comparison in sparc_tr_insn_start
  target/sparc: Drop inline markers from translate.c
  target/sparc: Introduce DYNAMIC_PC_LOOKUP
  target/sparc: Use DYNAMIC_PC_LOOKUP for conditional branches
  target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
  target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
  target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9 WRASI

 target/sparc/translate.c | 410 ++++++++++++++++++++++-----------------
 1 file changed, 233 insertions(+), 177 deletions(-)

-- 
2.34.1


