Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D0375D752
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 00:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMyRV-0000If-Pt; Fri, 21 Jul 2023 18:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qMyRT-0000IH-IY; Fri, 21 Jul 2023 18:17:43 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qMyRS-0005K9-22; Fri, 21 Jul 2023 18:17:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3336E7456CE;
 Sat, 22 Jul 2023 00:17:40 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 00EEB7456AC; Sat, 22 Jul 2023 00:17:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F3A967456A4;
 Sat, 22 Jul 2023 00:17:39 +0200 (CEST)
Date: Sat, 22 Jul 2023 00:17:39 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH 0/3] pegasos2 fixes for 8.1
In-Reply-To: <e3eee7ac-a6f8-4643-4600-845d6718e1d4@gmail.com>
Message-ID: <960ab00b-23b9-e1ee-4929-db87fab43e46@eik.bme.hu>
References: <cover.1689725688.git.balaton@eik.bme.hu>
 <e3eee7ac-a6f8-4643-4600-845d6718e1d4@gmail.com>
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

On Fri, 21 Jul 2023, Daniel Henrique Barboza wrote:
> On 7/18/23 21:32, BALATON Zoltan wrote:
>> These are some small fixes when using pegasos2 with the QEMU built in
>> VOF instead of the non-free board firmware that fix bugs in the
>> generated device tree and matches the board firmware in the reset
>> state of on-board USB devices. This fixes booting AmigaOS with VOF and
>> only touches parts that are used with VOF only so I'd like these to be
>> merged for 8.1.
>
> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>
>
> And pushed to ppc-next. Thanks,

Thank you. I've just sent another similar one I've found later so was 
missed from this series but I hope this can still get in. This should be 
the last one from me for 8.1 now, sorry for sending it so late.

Regards,
BALATON Zoltan

> Daniel
>
>> 
>> Regards,
>> 
>> BALATON Zoltan (3):
>>    ppc/pegasos2: Fix reset state of USB functions
>>    ppc/pegasos2: Fix reg property of ROM BARs
>>    ppc/pegasos2: Fix naming of device tree nodes
>>
>>   hw/ppc/pegasos2.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>> 
>
>

