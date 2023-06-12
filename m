Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7F172BCE1
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:41:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8e2p-00088p-C8; Mon, 12 Jun 2023 05:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1q8e2U-00084U-BD
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:40:51 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1q8e2S-0002tl-Cx
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:40:41 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 5A5E411EE64;
 Mon, 12 Jun 2023 09:40:36 +0000 (UTC)
From: ~jhogberg <jhogberg@git.sr.ht>
Date: Mon, 12 Jun 2023 09:40:36 +0000
MIME-Version: 1.0
Subject: [PATCH qemu v2 0/2] target/arm: Improve user-mode compatibility with
 JITs
Message-ID: <168656283612.26761.9869630057811681568-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: ~jhogberg <john.hogberg@ericsson.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The previous version of this got mangled, so I'm re-sending it through
sourcehut as mentioned in the documentation in the hopes that it's
foolproof. Sorry about the extra traffic :-(

----

When running in user-mode QEMU currently fails to emulate JITs that
use dual-mapped code to get around W^X restrictions, where one mapping
is writable and one is executable. As it has no way of knowing that a
write to the writable region is reflected in the executable one, it
fails to invalidate previously translated code which leads to a crash
at best.

(Note that system mode is unaffected as the softmmu is fully aware of
what is going on.)

This patch series catches changes to dual-mapped code by honoring the
cache management instructions required to make things work on actual
hardware.

See https://gitlab.com/qemu-project/qemu/-/issues/1034 for more
background information

John H=C3=B6gberg (2):
  target/arm: Handle IC IVAU to improve compatibility with JITs
  tests/tcg/aarch64: Add testcases for IC IVAU and dual-mapped code

 target/arm/helper.c               |  47 ++++++-
 tests/tcg/aarch64/Makefile.target |   3 +-
 tests/tcg/aarch64/icivau.c        | 204 ++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/aarch64/icivau.c

--=20
2.38.5

