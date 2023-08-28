Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA5E78B44C
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae2w-0005q2-Gb; Mon, 28 Aug 2023 11:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2q-0005cQ-Ap
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:49 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2m-0007Ll-US
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:48 -0400
Received: from ls3a6000.. (unknown [223.72.44.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 6CA8F44079;
 Mon, 28 Aug 2023 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693236026; bh=jd6gph67Z1Fyfqo4IehZADLR8RTulk3C2pZU4N0WtHs=;
 h=From:To:Cc:Subject:Date;
 b=RR+zx2wDp4r/khMuL0MkWpHj6FuhWGP5pDxdssYTzLtKra1ZbsvBUc30UziiRGMhm
 0GYnNh0Ms5aeZnYoR4f/GTs8MiFfwDJOX/oUKJPHArROO5tVdLgKJBtEPA59kUR5M7
 uH6I7d+sa3IARJM6Fd0yOt/vT5YWtCaiPvlmS+Pw=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, Jiajie Chen <c@jia.je>
Subject: [PATCH 00/11] Lower TCG vector ops to LSX
Date: Mon, 28 Aug 2023 23:19:38 +0800
Message-ID: <20230828152009.352048-1-c@jia.je>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This patch series allows qemu to utilize LSX instructions on LoongArch
machines to execute TCG vector ops.

Jiajie Chen (11):
  tcg/loongarch64: Import LSX instructions
  tcg/loongarch64: Lower basic tcg vec ops to LSX
  tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
  tcg/loongarch64: Lower add/sub_vec to vadd/vsub
  tcg/loongarch64: Lower vector bitwise operations
  tcg/loongarch64: Lower neg_vec to vneg
  tcg/loongarch64: Lower mul_vec to vmul
  tcg/loongarch64: Lower vector min max ops
  tcg/loongarch64: Lower vector saturated ops
  tcg/loongarch64: Lower vector shift vector ops
  tcg/loongarch64: Lower bitsel_vec to vbitsel

 tcg/loongarch64/tcg-insn-defs.c.inc  | 6251 +++++++++++++++++++++++++-
 tcg/loongarch64/tcg-target-con-set.h |    5 +
 tcg/loongarch64/tcg-target-con-str.h |    1 +
 tcg/loongarch64/tcg-target.c.inc     |  414 +-
 tcg/loongarch64/tcg-target.h         |   37 +-
 tcg/loongarch64/tcg-target.opc.h     |   12 +
 6 files changed, 6601 insertions(+), 119 deletions(-)
 create mode 100644 tcg/loongarch64/tcg-target.opc.h

-- 
2.42.0


