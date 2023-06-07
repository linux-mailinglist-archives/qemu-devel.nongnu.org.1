Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8770472597B
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:06:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6p6y-0004MD-NN; Wed, 07 Jun 2023 05:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6p6v-0004IC-Ie
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:05:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6p6t-0000QN-IP
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:05:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C5810B423;
 Wed,  7 Jun 2023 12:05:41 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2F2DBA276;
 Wed,  7 Jun 2023 12:05:41 +0300 (MSK)
Message-ID: <ea74b6cf-b247-4ddf-b350-4fca68798818@tls.msk.ru>
Date: Wed, 7 Jun 2023 12:05:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 15/18] s390x/tcg: Fix CPU address returned by STIDP
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
 <20230606055621.523175-16-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230606055621.523175-16-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

06.06.2023 08:56, Thomas Huth wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> In qemu-user-s390x, /proc/cpuinfo contains:
> 
> 	processor 0: version = 00,  identification = 000000,  machine = 8561
> 	processor 1: version = 00,  identification = 400000,  machine = 8561
> 
> The highest nibble is supposed to contain the CPU address, but it's off
> by 2 bits. Fix the shift value and provide a symbolic constant for it.
> 
> With the fix we get:
> 
> 	processor 0: version = 00,  identification = 000000,  machine = 8561
> 	processor 1: version = 00,  identification = 100000,  machine = 8561
> 
> Fixes: 076d4d39b65f ("s390x/cpumodel: wire up cpu type + id for TCG")
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20230605113950.1169228-2-iii@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/s390x/cpu_models.h | 10 +++++++++-
>   target/s390x/cpu_models.c |  4 ++--
>   2 files changed, 11 insertions(+), 3 deletions(-)

Is it a -stable material too?
(applies cleanly to 7.2 and 8.0)

Thanks,

/mjt

