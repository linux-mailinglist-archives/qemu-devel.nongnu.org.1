Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B22E72069A
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574q-00036k-Cc; Fri, 02 Jun 2023 11:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574n-00035p-Ga
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574l-0003PP-R8
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f6d01d390bso22478115e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721146; x=1688313146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rNxhB7EnJM12BgC75bBgDgUuEfpzts0vP4J/yX/3Qb8=;
 b=tXPLlG59hUN5UFADIvCk2EsiwWpzE7s6DiukaQ1ypicfFEBrvWqv+ypWsxejrvtjih
 0JCz/2U6OmbZ4DJfI2C+qJigfWvxoLEMKunSx4CUN21MV2lhj/ysBupgEq3tTtXF2uDg
 FLOqu+0qlyTb5hDMGIyJfq4ytEFXLKu2kcM6RmAXZMugY45xL52nXJzl4O+fss5wGfmj
 EELFWP6thTGOVMSnmTLSPM17COZMwmlzTxbUZqdKw3tY8ltpYR5/wKpvCXda/2OA60fF
 FPzqbRvoe+WsAjhvwyRSpP4CEDbNqwH575SwZ3mFJIOi4ei7NFeb2cZftskcif6hi1iT
 cAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721146; x=1688313146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rNxhB7EnJM12BgC75bBgDgUuEfpzts0vP4J/yX/3Qb8=;
 b=GgfuUe8pr+YEGV8KJN7N5CXUb80/WdEKrUKMgygYJN/bsmBDsL9/fL4Rw/KvM1xoz8
 4YY1Xrz3rzKbgQNNP5WWXZEp3ZArb8G1kWhfzXqJI+MLPXdqBOFrRaeZMCZNgL1e/1V8
 C0upUHodjS2HlCNziFyR+/FyEaExUJbT75r22ECK9HlETe6YRh9rv+V/o1Z7Z0C0EccD
 etAltXHMhZF54fXlMnFbQrex7JE4zrbuqFt6irzrtcY6tpICt8lD4ibo0cdCpR9vqnp4
 b6DXMApCr9HD4fOPrlLyQzMbBOFOwsYqhIBeqwPi2UkRswiFBEWoztovfGphXEQFWGcV
 lM4Q==
X-Gm-Message-State: AC+VfDyxVkN3W3iidLhWiUE6leJguGOHS6cQWJK0zZzdKSxJn3+xwl/L
 Pvh18PBWKdiPhWswfxnr8bJwuw==
X-Google-Smtp-Source: ACHHUZ7AF7jpKimMvoZMV6+jz2WW14mA++SQMVW726LOM59KIdc6hQ5nuTwq9HF1xSuDoID/tGkadA==
X-Received: by 2002:a7b:c7da:0:b0:3f4:2174:b28a with SMTP id
 z26-20020a7bc7da000000b003f42174b28amr2302370wmk.15.1685721145966; 
 Fri, 02 Jun 2023 08:52:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/20] target/arm: Convert exception, system,
 loads and stores to decodetree
Date: Fri,  2 Jun 2023 16:52:03 +0100
Message-Id: <20230602155223.2040685-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

This patchseries does more of the conversion of the A64 decoder to
decodetree.  It covers the exception-generation, system, load and
store instructions.

After this the remaining legacy decoder pieces are:
 * data-processing (register)
 * data-processing (SIMD)
 * data-processing (floating-point)

I plan to take a break from conversion after this series to work on
FEAT_MOPS, but want to come back to the dp-register parts for this
release cycle.  The FP/SIMD stuff is a bigger job and I'm inclined to
leave it for the moment.

I include the LDSMIN/LDSMAX bugfix as patch 1 to avoid a conflict
later.  Speaking of conflicts, this is going to conflict with RTH's
LSE2 series, which I expect to get in to the tree first, but I'm
hoping the rebase of this series won't be too painful.

thanks
-- PMM

Peter Maydell (20):
  target/arm: Fix return value from LDSMIN/LDSMAX 8/16 bit atomics
  target/arm: Convert hint instruction space to decodetree
  target/arm: Convert barrier insns to decodetree
  target/arm: Convert CFINV, XAFLAG and AXFLAG to decodetree
  target/arm: Convert MSR (immediate) to decodetree
  target/arm: Convert MSR (reg), MRS, SYS, SYSL to decodetree
  target/arm: Convert exception generation instructions to decodetree
  target/arm: Convert load/store exclusive and ordered to decodetree
  target/arm: Convert LDXP, STXP, CASP, CAS to decodetree
  target/arm: Convert load reg (literal) group to decodetree
  target/arm: Convert load/store-pair to decodetree
  target/arm: Convert ld/st reg+imm9 insns to decodetree
  target/arm: Convert LDR/STR with 12-bit immediate to decodetree
  target/arm: Convert LDR/STR reg+reg to decodetree
  target/arm: Convert atomic memory ops to decodetree
  target/arm: Convert load (pointer auth) insns to decodetree
  target/arm: Convert LDAPR/STLR (imm) to decodetree
  target/arm: Convert load/store (multiple structures) to decodetree
  target/arm: Convert load/store single structure to decodetree
  target/arm: Convert load/store tags insns to decodetree

 target/arm/tcg/a64.decode      |  406 ++++
 target/arm/tcg/translate-a64.c | 3183 ++++++++++++++------------------
 2 files changed, 1801 insertions(+), 1788 deletions(-)

-- 
2.34.1


