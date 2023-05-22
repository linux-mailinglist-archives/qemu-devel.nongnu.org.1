Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F270BCD4
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:01:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14Di-0003sp-FX; Mon, 22 May 2023 08:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q14Da-0003lc-7f; Mon, 22 May 2023 08:00:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q14DX-0001YL-Mm; Mon, 22 May 2023 08:00:49 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 426B8747DF8;
 Mon, 22 May 2023 14:00:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0BD82747DCF; Mon, 22 May 2023 14:00:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 09FE3747D5D;
 Mon, 22 May 2023 14:00:45 +0200 (CEST)
Date: Mon, 22 May 2023 14:00:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] bitops.h: Compile out asserts without --enable-debug
In-Reply-To: <CAFEAcA9gAYPpOJ6VyPYwCVyOhMmJMEe4QyGzB57xCbK0MOED5A@mail.gmail.com>
Message-ID: <0ab99dea-dbe6-9b3c-37a1-0ad66c0573b2@eik.bme.hu>
References: <20230520205444.887287457E7@zero.eik.bme.hu>
 <CAFEAcA9gAYPpOJ6VyPYwCVyOhMmJMEe4QyGzB57xCbK0MOED5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 22 May 2023, Peter Maydell wrote:
> On Sat, 20 May 2023 at 21:55, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> The low level extract and deposit funtions provided by bitops.h are
>> used in performance critical places. It crept into target/ppc via
>> FIELD_EX64 and also used by softfloat so PPC code using a lot of FPU
>> where hardfloat is also disabled is doubly affected.
>>
>> Normally asserts should be compiled out from release builds with
>> -DNDEBUG but that cannot be used in QEMU because some places still
>> rely on asserts instead of proper error checking. To resolve this,
>> compile out asserts from deposit/extract functions in optimised builds
>> which improves performance for target/ppc and possibly others too.
>
> Can we have some figures for performance improvements,
> please? General QEMU policy is that asserts remain,
> even in non-debug builds, so exceptions from that policy
> should come with justification with figures attached.

Here are some figures converting a 10MB wav file to mp3 with lame on 
AmigaOS pegasos2 which is using a lot of FPU operations (which is using
softfloat on TCG target/ppc due to no hardfloat so it's very slow):

    8.0: 1:11 0.8264x, 1:11 0x8258x
master: 1:12 0.8117x, 1:12 0.8103x
  patch: 1:02 0.9541x, 1:02 0.9506x

The numbers are time minute:seconds and speed compared to play speed (lame 
calls this play/CPU). I did two runs, first after booting the guest and 
another one after the first. Despite the second run should use more cache 
and less compile overhead the first runs seem to be a bit faster. Real 
hardware gets about 11x speed although that's with Altivec where on QEMU 
Altivec does not help much so we're still much behind even on an Intel 
Core i7 3.6GHz CPU for FPU ops where integer ops are much better. I got 
similar reports from Apple silicon hardware with macOS too. Eventually 
fixing hardfloat for target/ppc would help even more but this is 
independent of that and significant enough to remove this overhead now. 
I've never seen these asserts firing and unlikely to depend on run time 
values so leaving them in non-debug builds seems unnecessary overkill that 
also hurts performance.

Regards,
BALATON Zoltan

