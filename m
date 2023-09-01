Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC778FAE0
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 11:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc0X2-0004sO-Oq; Fri, 01 Sep 2023 05:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qc0Ww-0004rW-EN
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 05:33:30 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qc0Wt-0000Tf-7B
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 05:33:30 -0400
Received: from ls3a6000.. (unknown [223.72.40.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 616534446C;
 Fri,  1 Sep 2023 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693560798; bh=uaZo5XEWzvvln14ddikcCGPeHGb+pVCJGp2w+0iHy0g=;
 h=From:To:Cc:Subject:Date;
 b=UG+i3D4Dz7AcXD4WrJMmM3LYBKesSbICi/+nSeRLQlS80XqxM9DarscMc568WPRK2
 UUvB+onWMdJ1VFfC325s7zlZ5l34Ug8dfVvQEEgH8NvycovW2F0Fyk8OU7BFO4YL0i
 8JoSfHi54upn8SZjBH483/3y0bUTbO/FYsElt1xg=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v2 00/14] Lower TCG vector ops to LSX
Date: Fri,  1 Sep 2023 17:30:53 +0800
Message-ID: <20230901093258.942357-1-c@jia.je>
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

Passed tcg tests with x86_64 and aarch64 cross compilers.

Changes since v1:

- Optimize dupi_vec/st_vec/ld_vec/cmp_vec/add_vec/sub_vec generation
- Lower not_vec/shi_vec/roti_vec/rotv_vec

Jiajie Chen (14):
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
  tcg/loongarch64: Lower vector shift integer ops
  tcg/loongarch64: Lower rotv_vec ops to LSX
  tcg/loongarch64: Lower rotli_vec to vrotri

 tcg/loongarch64/tcg-insn-defs.c.inc  | 6251 +++++++++++++++++++++++++-
 tcg/loongarch64/tcg-target-con-set.h |    7 +
 tcg/loongarch64/tcg-target-con-str.h |    1 +
 tcg/loongarch64/tcg-target.c.inc     |  550 ++-
 tcg/loongarch64/tcg-target.h         |   38 +-
 tcg/loongarch64/tcg-target.opc.h     |   12 +
 6 files changed, 6740 insertions(+), 119 deletions(-)
 create mode 100644 tcg/loongarch64/tcg-target.opc.h

-- 
2.42.0


