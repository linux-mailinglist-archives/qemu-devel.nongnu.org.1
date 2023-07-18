Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94068758025
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 16:52:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLm2k-0003yB-8Z; Tue, 18 Jul 2023 10:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1qLm2g-0003wG-MR
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:51:10 -0400
Received: from bonnix2.bonnix.it ([37.247.49.194])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1qLm2e-00036s-6f
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:51:10 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 854B3ADC8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1689691863;
 bh=NYRh+FKfBmZk0L9PF7AVDiEJoZEvTwWJbIm3uKYQXsI=;
 h=Date:Subject:From:To:References:Cc:In-Reply-To;
 b=JMYaC61m+6kUhSWq5tn4KkAG3eJkSxEIU+ppjNuVE/a62eYAqytOiJ8dLcakl72W1
 7XmAywsUdqIoCAwsOIsxudjgR2Fs5ickCk9t2digOOnvms29nOgQEIlGKBQTafDN8Q
 xA1mR65ymMw00HILB2p9//1knit9u0aE9tezZW3Y=
Received: from [10.0.0.152] (unknown [82.84.102.14])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 854B3ADC8E;
 Tue, 18 Jul 2023 16:51:03 +0200 (CEST)
Message-ID: <327460e2-0ebd-9edb-426b-1df80d16c32a@bonslack.org>
Date: Tue, 18 Jul 2023 16:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Wrong signed data type on pageflags_* functions - limit
 to 2GB memory allocation
Content-Language: it, en-US
From: Luca Bonissi <qemu@bonslack.org>
To: qemu-devel@nongnu.org
References: <4e1b1c75-8f00-83cc-86c3-0401c8bd0b2a@bonslack.org>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <4e1b1c75-8f00-83cc-86c3-0401c8bd0b2a@bonslack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.247.49.194; envelope-from=qemu@bonslack.org;
 helo=bonnix2.bonnix.it
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 32bit qemu-user targets, memory allocation failed after about 2GB due 
to incorrect signed (instead of the correct unsigned) "last" parameter 
in pageflags_find and pageflags_next functions (file accel/tcg/user-exec.c).

The parameter, on 32bit targets, will be signed-extent to the 64bit 
final uint64_t parameters, leading to incorrect comparison on the RBTree 
(only the first call to mmap on the upper 2GB memory will be successful).

Following the patch to fix the bug (re-submit to add "signed-off-by"):

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
---

diff -up a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
--- a/accel/tcg/user-exec.c    2023-03-27 15:41:42.000000000 +0200
+++ b/accel/tcg/user-exec.c    2023-07-15 14:09:07.160453759 +0200
@@ -144,7 +144,7 @@ typedef struct PageFlagsNode {

  static IntervalTreeRoot pageflags_root;

-static PageFlagsNode *pageflags_find(target_ulong start, target_long last)
+static PageFlagsNode *pageflags_find(target_ulong start, target_ulong last)
  {
      IntervalTreeNode *n;

@@ -153,7 +153,7 @@ static PageFlagsNode *pageflags_find(tar
  }

  static PageFlagsNode *pageflags_next(PageFlagsNode *p, target_ulong start,
-                                     target_long last)
+                                     target_ulong last)
  {
      IntervalTreeNode *n;

