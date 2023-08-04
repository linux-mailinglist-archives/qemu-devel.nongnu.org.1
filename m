Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 869EB7705D8
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 18:23:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRxZM-0006Ks-8a; Fri, 04 Aug 2023 12:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRxZJ-0006Ik-Eu; Fri, 04 Aug 2023 12:22:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRxZH-0001jV-Ov; Fri, 04 Aug 2023 12:22:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5965B183D5;
 Fri,  4 Aug 2023 19:22:38 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 292901B85F;
 Fri,  4 Aug 2023 19:22:18 +0300 (MSK)
Message-ID: <aae7b3b6-b7d7-f415-a2ec-30fe0ee47057@tls.msk.ru>
Date: Fri, 4 Aug 2023 19:22:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PULL 02/10] util/interval-tree: Use qatomic_set_mb in
 rb_link_node
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
 <20230731210211.137353-3-richard.henderson@linaro.org>
 <8854030f-73ea-b92b-2ee4-c219acfbe1c3@tls.msk.ru>
 <04b4edc5-f24d-3d33-970a-172e889d9c02@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <04b4edc5-f24d-3d33-970a-172e889d9c02@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

04.08.2023 16:41, Richard Henderson wrote:
> On 8/4/23 02:02, Michael Tokarev wrote:
>> 01.08.2023 00:02, Richard Henderson wrote:
..
>>> +    qatomic_set_mb(rb_link, node);
>>
>> FWIW, there's no qatomic_set_mb() in 8.0 and before, so this can not be
>> directly applied to stable-8.0.  This commit is missing in 8.0 before
>> qatomic_set_mb() can be used:
>>
>> commit 06831001ac8949b0801e0d20c347d97339769a20
>> Author: Paolo Bonzini <pbonzini@redhat.com>
>> Date:   Fri Mar 3 14:37:51 2023 +0100
>>
>>      atomics: eliminate mb_read/mb_set
>>
>> I don't think it's a good idea to back-port this commit to stable-8.0.
>>
>> How do you think we can solve this for 8.0?
> 
> The function is called qatomic_mb_set instead of qatomic_set_mb in stable-8.0.

Sure, qatomic_mb_set has been renamed to qatomic_set_mb by the commit I
quoted above.  It is just a bit awkward to rename the user like this
when back-porting, especially since the commit subject mentions the
new name already.  It was my first thought to use the old name, but
I thought I'd ask first.

Ok, let's rename the function call in this patch, but keep everything
else (incl. the subject) intact.  I've added comment about this though.

Thanks!

/mjt

