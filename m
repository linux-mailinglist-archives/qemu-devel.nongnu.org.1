Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 408047E8862
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 03:41:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1duh-0000qZ-AV; Fri, 10 Nov 2023 21:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1r1dud-0000qR-RF
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 21:39:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1r1dub-00062d-PE
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 21:39:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5D23D323D8;
 Sat, 11 Nov 2023 05:39:51 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 57710348FD;
 Sat, 11 Nov 2023 05:39:40 +0300 (MSK)
Message-ID: <610aad34-da0b-4b8a-aa22-4ad19513ae28@tls.msk.ru>
Date: Sat, 11 Nov 2023 05:39:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: disable-pie build
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi!

It looks like --disable-pie configure, which uses -fno-pie -no-pie flags
for the compiler, is broken: it does not not tell the *linker* about the
option, so the link fails (at least on debian bookworm):

/usr/bin/ld: libcommon.fa.p/hw_core_cpu-common.c.o: relocation R_X86_64_32 against `.rodata' can not be used when making a PIE object; recompile with 
-fPIE
/usr/bin/ld: failed to set dynamic section sizes: bad value

This is failing for *all* executables, including tests, qemu-img, etc.

The following change fixes it:

diff --git a/meson.build b/meson.build
index a9c4f28247..0b7ca45d48 100644
--- a/meson.build
+++ b/meson.build
@@ -278,7 +278,8 @@ endif
  # tries to build an executable instead of a shared library and fails.  So
  # don't add -no-pie anywhere and cross fingers. :(
  if not get_option('b_pie')
-  qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
+  qemu_common_flags += cc.get_supported_arguments('-fno-pie')
+  qemu_ldflags += cc.get_supported_arguments('-no-pie')
  endif

  if not get_option('stack_protector').disabled()



