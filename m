Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D017B6FA2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:24:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnj74-0004sQ-M4; Tue, 03 Oct 2023 13:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qnj72-0004s0-96
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:23:12 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qnj70-0005gE-NL
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:23:11 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 59D4311EEDF;
 Tue,  3 Oct 2023 17:23:08 +0000 (UTC)
From: ~h0lyalg0rithm <h0lyalg0rithm@git.sr.ht>
Date: Tue, 03 Oct 2023 17:23:08 +0000
Subject: [PATCH qemu 0/1] contrib/elf2dmp: Conversion of conversions of
 malloc/calloc/free to g_malloc/g_new/g_free
MIME-Version: 1.0
Message-ID: <169635378817.28428.8916197505999208589-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: trivial@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_REPLYTO=2.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~h0lyalg0rithm <surajshirvankar@gmail.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Switch malloc and free calls to new coding standard.
g_new is used where structs are defined and g_malloc is used for simpler
structures

Suraj Shirvankar (1):
  Switch memory management calls to new coding conventions

 contrib/elf2dmp/addrspace.c | 4 ++--
 contrib/elf2dmp/main.c      | 4 ++--
 contrib/elf2dmp/pdb.c       | 4 ++--
 contrib/elf2dmp/qemu_elf.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.38.5

