Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CAE786044
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 21:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYt5V-0000Eo-9S; Wed, 23 Aug 2023 15:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYt5O-0000Bw-QT
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 15:00:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYt5L-0005Po-TI
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 15:00:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F9441C70D;
 Wed, 23 Aug 2023 22:00:21 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 43123215DF;
 Wed, 23 Aug 2023 22:00:02 +0300 (MSK)
Message-ID: <2c56752c-b04f-3d64-4b99-b83271c28630@tls.msk.ru>
Date: Wed, 23 Aug 2023 22:00:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 17/24] xen: spelling fixes
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-16-mjt@tls.msk.ru>
 <23b504c5adb8a0261459992e77a5dfc0be540912.camel@infradead.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <23b504c5adb8a0261459992e77a5dfc0be540912.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.684,
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

23.08.2023 21:38, David Woodhouse wrote:
> On Wed, 2023-08-23 at 09:53 +0300, Michael Tokarev wrote:
>>
>>   include/hw/xen/interface/arch-x86/xen-x86_64.h | 2 +-
>>   include/hw/xen/interface/arch-x86/xen.h        | 2 +-
>>   include/hw/xen/interface/event_channel.h       | 2 +-
>>   include/hw/xen/interface/grant_table.h         | 2 +-
>>   include/hw/xen/interface/hvm/hvm_op.h          | 2 +-
>>   include/hw/xen/interface/io/blkif.h            | 6 +++---
>>   include/hw/xen/interface/io/fbif.h             | 2 +-
>>   include/hw/xen/interface/io/kbdif.h            | 2 +-
>>   include/hw/xen/interface/memory.h              | 2 +-
>>   include/hw/xen/interface/physdev.h             | 4 ++--
>>   include/hw/xen/interface/xen.h                 | 4 ++--
>>   12 files changed, 16 insertions(+), 16 deletions(-)
> 
> Please don't make changes to these unless you also change them in the
> upstream Xen project, from which they're imported.

Aha. I didn't know they're imported from elsewhere.
Is it just include/hw/xen/interface/ or whole include/hw/xen/ ?

I guess these changes can be sent to xen project :)

> Thanks.
> 
>> --- a/include/hw/xen/interface/memory.h
>> +++ b/include/hw/xen/interface/memory.h
>> @@ -185,5 +185,5 @@ struct xen_machphys_mfn_list {
>>       /*
>>        * Pointer to buffer to fill with list of extent starts. If there are
>> -     * any large discontiguities in the machine address space, 2MB gaps in
>> +     * any large discontinuities in the machine address space, 2MB gaps in
>>        * the machphys table will be represented by an MFN base of zero.
>>        */
> 
> If you're already correcting that line, why not also correct MB to MiB?

That's not really spelling fix anymore.  Also, this is not universal, some
still prefer MB over MiB (to mean 1024 not 1000).  Else it's just too many
changes and the thing will never finish :)

Here in this patch, after removing include/hw/xen/, there's just one file
with one fix left, hw/xen/xen_pvdev.c. Hwell.. :)

/mjt

