Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 345B476A413
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 00:23:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQbGo-0006tp-0Z; Mon, 31 Jul 2023 18:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fermium@anarchist.gay>)
 id 1qQb5q-0005j2-Vb; Mon, 31 Jul 2023 18:10:23 -0400
Received: from box.anarchist.gay ([178.62.216.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fermium@anarchist.gay>)
 id 1qQb5p-000238-7e; Mon, 31 Jul 2023 18:10:22 -0400
Received: from authenticated-user (box.anarchist.gay [178.62.216.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by box.anarchist.gay (Postfix) with ESMTPSA id E0AA97E2FD;
 Mon, 31 Jul 2023 18:10:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=anarchist.gay;
 s=mail; t=1690841415;
 bh=TLC/mVc3NGB8v6pcLvYGYWXxWVMYkZD1ixxLUmTed/4=;
 h=From:To:Cc:Subject:Date:From;
 b=YBxucpK8p07BQ53jXQvejLMwO3rnBZHgeNQ1zu7VyNMh3YVfgvR4aLo8UrUgC8BcM
 Ej+knhepd0pZi6dUMC9r9JkY+L8ttGvZy6QBQGtg6tUYlKwI2c3EApo7MUR0twLBuR
 OrE9C10QFj3cpCYIxQC/YRfE9KEGF88SxMPmKfCZMyoqp31q1HjKtpOz1SDL9ZF3v2
 FJA4ApGJxyXWyNsSIVF/aXnUYeEgnUSECSbGu5TnrFAYGsIfyQR7PsZs3mA0TgDdu8
 l2p0pZs7YYZDcsxmQuLlAU9L4potq8SJ+6kU9h+UtjGVefzqYwWTrLHQD7iCJDtPoI
 CUeibyoUkQSaQ==
From: Lilly Anderson <fermium@anarchist.gay>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Lilly Anderson <fermium@anarchist.gay>
Subject: [PATCH 0/1] Added support for the MMU node in the RHCT
Date: Mon, 31 Jul 2023 18:09:58 -0400
Message-ID: <20230731220959.4142636-1-fermium@anarchist.gay>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.62.216.29; envelope-from=fermium@anarchist.gay;
 helo=box.anarchist.gay
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 31 Jul 2023 18:21:39 -0400
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

The specification was recently updated so I thought I'd submit a patch.
This does not add support for the CMO node, as I am unsure whether its pre-requisites are implemented.

Lilly Anderson (1):
  Added support for the MMU node in the RHCT

 hw/riscv/virt-acpi-build.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.41.0

Signed-off-by: Lilly Anderson <fermium@anarchist.gay>

