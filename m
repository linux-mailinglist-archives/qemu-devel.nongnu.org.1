Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00118759543
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 14:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM6Rp-0000wP-2B; Wed, 19 Jul 2023 08:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1qM6Rl-0000wD-KF
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:38:25 -0400
Received: from [2a00:dcc0:1ea5:31f2::1] (helo=bonnix2.bonnix.it)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1qM6Rj-00016g-Ck
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:38:25 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 7D4AAAE230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1689770296;
 bh=Tc9O+HlzBIFoqgdf5Yi5RQez8hsjfignEIpISwOM0W4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=O+wwh7qSChSx/jtf3NXlKIwytOJ6KyLXCv4iNlbXZZzvmjKjrMQIdbNmLrMe7s6oK
 z5ZToQ+KYA/Kj4xoZPoDabfftH94plpb9bPGShxZ5M1H6liunm3IbCzmi6hbbXpfA5
 G8TmAmfv8TS44W01PPYb6q7GyZAywmN/3qEUVIaE=
Received: from [10.0.0.152] (unknown [82.84.102.14])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 7D4AAAE230;
 Wed, 19 Jul 2023 14:38:16 +0200 (CEST)
Message-ID: <38f8621c-98e7-53c4-ac1b-7ff4c569ed18@bonslack.org>
Date: Wed, 19 Jul 2023 14:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Wrong unpacked structure for epoll_event on qemu-or1k
 (openrisc user-space)
Content-Language: it, en-US
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <750c569e-a922-d3bb-1f97-1698960d5b05@bonslack.org>
 <CAFEAcA9vkyO_kivpSGV7jPW+DCbSD1BNA+SsLixViamXRi61CQ@mail.gmail.com>
 <fa561a63-991a-329e-d9f2-5b334d94516b@bonslack.org>
 <29cd5218-a9be-1947-e075-b892023213e8@vivier.eu>
From: Luca Bonissi <qemu@bonslack.org>
In-Reply-To: <29cd5218-a9be-1947-e075-b892023213e8@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a00:dcc0:1ea5:31f2::1
 (failed)
Received-SPF: pass client-ip=2a00:dcc0:1ea5:31f2::1;
 envelope-from=qemu@bonslack.org; helo=bonnix2.bonnix.it
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 19/07/23 10:49, Laurent Vivier wrote:
> 
> According to linux/glibc sourced, epoll is only packed for x86_64.

And, in recent glibc, also for i386, even it seems not necessary: even 
if the __alignof__(long long) is 8, structures like epoll_event are only 
12 bytes, maybe "packed" for historical reasons. Ancient i386 gcc[s] 
(<3.0.0) have 4 bytes for __alignof__(long long).

> Perhaps the default alignment of long is not correctly defined in qemu 
> for openrisc?

__alignof__(long long):
- 8 bytes: all 64 bit targets + arm, hppa, mips, ppc, sparc, xtensa, x86
- 4 bytes: microblaze, nios2, or1k, sh4
- 2 bytes: m68k
- 1 byte : cris

offsetof(struct epoll_event,data):
- 8: all 64 bit targets + arm, hppa, mips, ppc, sparc, xtensa
- 4: cris, m68k, microblaze, nios2, or1k, sh4, x86

So, epoll_event is "naturally" packed on the following targets (checked 
in linux-user container and/or with cross-compiler):
- cris, m68k, microblaze, nios2, or1k, sh4, x86 (32bit)

> See include/exec/user/abitypes.h to update the value.

OK, abitypes.h should be updated with the following patch (discard the 
previous patch on syscall_defs.h):

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
---

diff -up a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
--- a/include/exec/user/abitypes.h	2023-03-27 15:41:42.511916232 +0200
+++ b/include/exec/user/abitypes.h	2023-07-19 12:09:03.001687788 +0200
@@ -15,7 +15,15 @@
  #define ABI_LLONG_ALIGNMENT 2
  #endif

+#ifdef TARGET_CRIS
+#define ABI_SHORT_ALIGNMENT 1
+#define ABI_INT_ALIGNMENT 1
+#define ABI_LONG_ALIGNMENT 1
+#define ABI_LLONG_ALIGNMENT 1
+#endif
+
-#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) || 
defined(TARGET_SH4)
+#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) || 
defined(TARGET_SH4) || \
+    defined(TARGET_OPENRISC) || defined(TARGET_NIOS2) || 
defined(TARGET_MICROBLAZE)
  #define ABI_LLONG_ALIGNMENT 4
  #endif



