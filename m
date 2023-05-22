Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D4C70B420
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 06:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0xDW-0001ys-FQ; Mon, 22 May 2023 00:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1q0tEk-0003fr-1Y
 for qemu-devel@nongnu.org; Sun, 21 May 2023 20:17:18 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1q0tEi-0005pZ-N0
 for qemu-devel@nongnu.org; Sun, 21 May 2023 20:17:17 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 45CCD11EE9A;
 Mon, 22 May 2023 00:17:14 +0000 (UTC)
From: ~_6d6178667269747a <_6d6178667269747a@git.sr.ht>
Date: Mon, 22 May 2023 00:17:14 +0000
Subject: [PATCH qemu 0/1] [meson.build] Add conditional dependency for
 libkeyutils
MIME-Version: 1.0
Message-ID: <168471463402.18155.3575359027429939965-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_REPLYTO=2.095,
 FROM_LOCAL_DIGITS=0.001, FROM_LOCAL_HEX=0.006, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 May 2023 00:32:16 -0400
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
Reply-To: ~_6d6178667269747a <maxfritz@me.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

I have a patch that adds a conditional dependency for 'libkeyutils' in
the meson.build file to enhance the build system's flexibility. The
patch addresses the following issue:

If the dynamic library 'libkeyutils' is found by pkg-config, but one
attempts to build with static linkage, the build will fail, even if the
keyring feature is disabled and, therefore, the library is not needed.

Max Fritz (1):
  [meson.build] Add conditional dependency for libkeyutils

 meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.38.4

