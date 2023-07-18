Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D420757CB6
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 15:04:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLkMH-0006Sz-V6; Tue, 18 Jul 2023 09:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1qLkMF-0006Sj-KB
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 09:03:15 -0400
Received: from bonnix2.bonnix.it ([37.247.49.194])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1qLkMD-00039F-FG
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 09:03:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 978C4ADC30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1689685390;
 bh=ixXY9hpmzkYQbn+pkOZMs7RFJD+PtCStLusueWMjyAU=;
 h=Date:To:From:Subject;
 b=g942uVgfOJn8n3eOaahrA3u7nBvNke1u/h4iNtqx3uXovq+iCXfjhwkmXufXI5gFt
 T8lLdRBO5pdNXtQECaYJyJ1qxtRU/Do1lLdWajoFSO8q9v4YyjAp+4r8yNlAXCfDpg
 zrbhfrG5GnfP/zyEBughSA/DSW/38wW+3scxGt7Q=
Received: from [10.0.0.152] (unknown [82.84.102.14])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 978C4ADC30
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 15:03:10 +0200 (CEST)
Message-ID: <750c569e-a922-d3bb-1f97-1698960d5b05@bonslack.org>
Date: Tue, 18 Jul 2023 15:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: it, en-GB
To: qemu-devel@nongnu.org
From: Luca Bonissi <qemu@bonslack.org>
Subject: Wrong unpacked structure for epoll_event on qemu-or1k (openrisc
 user-space)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.247.49.194; envelope-from=qemu@bonslack.org;
 helo=bonnix2.bonnix.it
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The or1k epoll_event structure - unlike other architectures - is packed, 
so we need to define it as packed in qemu-user, otherwise it leads to 
infinite loop due to missing file descriptor in the returned data:

--- qemu-20230327/linux-user/syscall_defs.h.orig	2023-03-27 
15:41:42.000000000 +0200
+++ qemu-20230327/linux-user/syscall_defs.h	2023-06-30 
17:29:39.034322213 +0200
@@ -2714,7 +2709,7 @@
  #define FUTEX_CMD_MASK          ~(FUTEX_PRIVATE_FLAG | 
FUTEX_CLOCK_REALTIME)

  #ifdef CONFIG_EPOLL
-#if defined(TARGET_X86_64)
+#if defined(TARGET_X86_64) || defined(TARGET_OPENRISC)
  #define TARGET_EPOLL_PACKED QEMU_PACKED
  #else
  #define TARGET_EPOLL_PACKED

