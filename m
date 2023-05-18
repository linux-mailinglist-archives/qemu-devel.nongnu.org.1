Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019E707B13
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 09:35:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzY9u-0005vl-Ix; Thu, 18 May 2023 03:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pzY9r-0005vZ-TW
 for qemu-devel@nongnu.org; Thu, 18 May 2023 03:34:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pzY9p-0001kc-Qr
 for qemu-devel@nongnu.org; Thu, 18 May 2023 03:34:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CBF746DBF;
 Thu, 18 May 2023 10:34:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 50F446276;
 Thu, 18 May 2023 10:34:37 +0300 (MSK)
Message-ID: <8c3a4f60-b3ab-7c38-27c0-3f8f2caaeae4@tls.msk.ru>
Date: Thu, 18 May 2023 10:34:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/1] hw/pci: Disable PCI_ERR_UNCOR_MASK register for
 machine type < 8.0
Content-Language: en-US
To: quintela@redhat.com, Fiona Ebner <f.ebner@proxmox.com>
Cc: Leonardo Bras <leobras@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20230503002701.854329-1-leobras@redhat.com>
 <7f308149-5495-d415-5e51-1fa15fc20f84@proxmox.com>
 <87jzxf5ki9.fsf@secure.mitica>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <87jzxf5ki9.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -82
X-Spam_score: -8.3
X-Spam_bar: --------
X-Spam_report: (-8.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.412,
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

11.05.2023 11:40, Juan Quintela wrote:
> Fiona Ebner <f.ebner@proxmox.com> wrote:
...
>> Closes: https://gitlab.com/qemu-project/qemu/-/issues/1576
>>
>> AFAICT, this breaks (forward) migration from 8.0 to 8.0 + this patch
>> when using machine type <= 7.2. That is because after this patch, when
>> using machine type <= 7.2, the wmask for the register is not set and
>> when 8.0 sends a nonzero value for the register, the error condition in
>> get_pci_config_device() will trigger again.
> 
> I think that works correctly.
> See https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02733.html
> 
> What we have (before this patch) (using abbrevs as in the doc before)
> 
> Current state:
> 
> (1) qemu-8.0 -M pc-8.0 -> qemu-8.0 -M pc-8.0 works
> 
>      not affected by the patch
> 
> (2) qemu-7.2 -M pc-7.2 -> qemu-8.0 -M pc-8.0 works
> 
>      works well because 7.2 don't change that field
> 
> (3) qemu-8.0 -M pc-7.2 -> qemu-7.2 -M pc-7.2 fails
> 
> With the patch we fixed 3, so once it is in stable, 1 and 2 continue as
> usual and for (3) we will have:
> 
> (3) qemu-8.0.1 -M pc-7.2 -> qemu-7.2 -M pc-7.2 works
> 
> If what you mean is that:
> 
> (3) qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 works
> 
> Will fail, that is true, but I can think a "sane" way to fix this.

That's a great summary indeed.

>> Is it necessary to also handle that? Maybe by special casing the error
>> condition in get_pci_config_device() to be prepared to accept such a
>> stream from 8.0?
> 
> Well, we can do that, but it is to the pci maintainers to decide if that
> is "sane".

So, can we go from here somewhere? I'd love this fix to be in 8.0.1,
either with or without the (un)sane part of the (3) variant above which
might fail.  Or else we'll have the same situation in 8.0.1 as we now
have in 8.0.0 (the deadline is May-27).

We did broke x.y.0 => x.y.1 migration before already like this, such as
with 7.2.0=>7.2.1. I'm not saying it's a nice thing to do, just stating
a fact. Yes, it is better to avoid such breakage, but.. meh..

Thanks!

/mjt

