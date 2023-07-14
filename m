Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED8F7542D2
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 20:50:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKNs1-0004gG-6L; Fri, 14 Jul 2023 14:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKNrk-0004Wt-N8; Fri, 14 Jul 2023 14:50:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKNrh-0002Vf-CN; Fri, 14 Jul 2023 14:50:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3761613F4B;
 Fri, 14 Jul 2023 21:50:18 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9AC3114C96;
 Fri, 14 Jul 2023 21:50:01 +0300 (MSK)
Message-ID: <849f5b3a-33cd-3406-4462-90ac11bcde96@tls.msk.ru>
Date: Fri, 14 Jul 2023 21:50:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] treewide: spelling fixes in comments and some strings
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-3-mjt@tls.msk.ru>
 <20230714122201.3b118f40.alex.williamson@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230714122201.3b118f40.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

14.07.2023 21:22, Alex Williamson wrote:
> On Fri, 14 Jul 2023 14:38:06 +0300
> Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
>> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
>> index d8aeee0b7e..12e7790cf6 100644
>> --- a/hw/ppc/spapr_pci_vfio.c
>> +++ b/hw/ppc/spapr_pci_vfio.c
>> @@ -39,7 +39,7 @@ static void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
>>   void spapr_phb_vfio_reset(DeviceState *qdev)
>>   {
>>       /*
>> -     * The PE might be in frozen state. To reenable the EEH
>> +     * The PE might be in frozen state. To re-enable the EEH
>>        * functionality on it will clean the frozen state, which
>>        * ensures that the contained PCI devices will work properly
>>        * after reboot.
> 
> This looks like personal preference, I can't actually find a source
> that indicates "reenable" is anything other than a valid alternative of
> "re-enable".  Thanks,

Well, it was one of the questionable suggestions from codespell.  I like
the re-enable better but in this case I don't really care for one way or
another. I can drop this and other similar fixes. This one definitely
does not hurt my eyes when I see it ;)

$ git diff qemu-master..spelling | grep -c re-enable
8

I can drop those 8 out of 400 :)

Thanks,

/mjt

