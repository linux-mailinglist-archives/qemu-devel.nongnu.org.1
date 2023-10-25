Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDBE7D66C9
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:30:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaCk-00053Z-UU; Wed, 25 Oct 2023 05:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qvaCh-0004xD-Ue
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:29:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qvaCe-0001dg-00
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:29:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axuerp3zhlB4A0AA--.26842S3;
 Wed, 25 Oct 2023 17:29:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxK9zp3zhlpuExAA--.39806S2; 
 Wed, 25 Oct 2023 17:29:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn
Subject: [risu PATCH 0/5] Add LoongArch LSX/LASX instructions
Date: Wed, 25 Oct 2023 17:29:10 +0800
Message-Id: <20231025092915.902814-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxK9zp3zhlpuExAA--.39806S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hi, Peter!

This series adds LSX/LASX instructions.

We tested 10 million instructions without any problems.

client:
x86 host  QEMU + patches [1].

server:
3A5000 host.


[1] https://patchwork.kernel.org/project/qemu-devel/list/?series=791633


Please review!

Thanks.
Song Gao

Song Gao (5):
  loongarch: Add LSX instructions
  loongarch: Add LASX instructions
  loongarch: reginfo suport LSX/LASX
  loongarch: init LASX registers
  loongarch: Add block 'clean' and clean_lsx_result()

 loongarch64.risu           | 2309 +++++++++++++++++++++++++++++++++++-
 risu_reginfo_loongarch64.c |  107 +-
 risu_reginfo_loongarch64.h |    3 +-
 risugen                    |    2 +-
 risugen_loongarch64.pm     |   30 +
 5 files changed, 2418 insertions(+), 33 deletions(-)

-- 
2.25.1


