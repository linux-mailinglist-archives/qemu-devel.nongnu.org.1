Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E28B7853AA
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:19:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjzp-0004Ls-GD; Wed, 23 Aug 2023 05:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qYjzm-0004Kj-QT; Wed, 23 Aug 2023 05:17:46 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qYjzl-0004H7-31; Wed, 23 Aug 2023 05:17:46 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0E495437B7;
 Wed, 23 Aug 2023 11:17:42 +0200 (CEST)
Message-ID: <fb142bbf-d1d4-2a7f-3a4c-b5c59059dc19@proxmox.com>
Date: Wed, 23 Aug 2023 11:17:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Lost partition tables on ide-hd + ahci drive
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>,
 Aaron Lauterer <a.lauterer@proxmox.com>, simon.rowe@nutanix.com
References: <ad7e1294-f19f-5bea-e891-f6adbe323cd5@proxmox.com>
 <CAFn=p-ahLoVd3W2GaFp5EUFq5EOudz+bUkEk5DV+Z07AjHaHtg@mail.gmail.com>
 <d07bdbc1-065e-f8ec-2a44-ab141ffedd41@proxmox.com>
 <CAL77WPAdDyKFWP_Dqsz_xr7OCzHLTkw6VbYDMGobi8kek4e_8A@mail.gmail.com>
 <85488658-80df-f6ac-8a1d-51172148a436@proxmox.com>
 <CAL77WPDJaRBgCeBtVx6tZ6yxKTG6Z2SEk_oif4RCSSnUgOuURA@mail.gmail.com>
 <1f581666-cfe0-cb7e-bbb5-6097e03c76e2@proxmox.com>
In-Reply-To: <1f581666-cfe0-cb7e-bbb5-6097e03c76e2@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.767,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 23.08.23 um 10:47 schrieb Fiona Ebner:
> Am 17.02.23 um 22:22 schrieb Mike Maslenkin:
>> I can not tell anything about dma-reentracy issues, but yes, i would
>> start to look at check_cmd() function call sequence.
>> The most interesting is why Sector Count = 1. I thought about race
>> with IDE reset where registers initialized with
>> value SATA_SIGNATURE_DISK = 0x00000101, but this means LBA=1 as well...
>>
> 
> You got it! Since we got another report (after half a year of nothing)
> and also because of Simon's mail, I gave it another shot too and was
> finally able to reproduce the issue (with our patched QEMU 8.0, but
> patches shouldn't affect IDE code). See below for the traces that
> confirm your theory. The reason the write goes to sector 0 and not 1 is
> because ide_dma_cb() uses sector_num = ide_get_sector(s); and that will
> evaluate to 0 after a reset.
> 
> So the issue is indeed that ide_dma_cb can get called with an IDEState
> just after that state was reset. Can we somehow wait for pending
> requests before proceeding with the reset, or can we force an error
> return for callbacks that are still pending during reset?
> 

I noticed that ide_bus_reset() does the reset first and then cancels the
aiocb. Maybe it's already enough to switch those around?

Best Regards,
Fiona


