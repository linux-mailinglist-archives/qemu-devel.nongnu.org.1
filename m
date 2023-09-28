Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BF27B1AE4
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 13:24:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlp72-0006d6-AV; Thu, 28 Sep 2023 07:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qlp70-0006cf-M3; Thu, 28 Sep 2023 07:23:18 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qlp6x-0005kJ-Id; Thu, 28 Sep 2023 07:23:18 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2665A48E2F;
 Thu, 28 Sep 2023 13:23:12 +0200 (CEST)
Message-ID: <4a1a5f8a-6797-104b-4a91-b5fa24607fb4@proxmox.com>
Date: Thu, 28 Sep 2023 13:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
Content-Language: en-US
To: John Snow <jsnow@redhat.com>
Cc: Niklas Cassel <niklas.cassel@wdc.com>, qemu-devel
 <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Simon Rowe <simon.rowe@nutanix.com>, Felipe Franciosi <felipe@nutanix.com>
References: <20230921160712.99521-1-simon.rowe@nutanix.com>
 <20230921160712.99521-2-simon.rowe@nutanix.com>
 <CAFn=p-YL_hmnrFY9hhuMgMkV4hL3dojMMWUdG9=DBGYuxi_TUw@mail.gmail.com>
 <7658d927-1d05-8f2d-9739-d1db692bee72@proxmox.com>
 <CAFn=p-YkEJajV_YuOsK4KPL6T1erEhdkameN-XEEXrwY+XZZ6g@mail.gmail.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAFn=p-YkEJajV_YuOsK4KPL6T1erEhdkameN-XEEXrwY+XZZ6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

Am 26.09.23 um 16:45 schrieb John Snow:
> 
> 
> On Tue, Sep 26, 2023, 3:11 AM Fiona Ebner <f.ebner@proxmox.com
> <mailto:f.ebner@proxmox.com>> wrote:
> 
>     Am 25.09.23 um 21:53 schrieb John Snow:
>     > On Thu, Sep 21, 2023 at 12:07 PM Simon Rowe
>     <simon.rowe@nutanix.com <mailto:simon.rowe@nutanix.com>> wrote:
>     >>
>     >> When an IDE controller is reset, its internal state is being cleared
>     >> before any outstanding I/O is cancelled. If a response to DMA is
>     >> received in this window, the aio callback will incorrectly continue
>     >> with the next part of the transfer (now using sector 0 from
>     >> the cleared controller state).
>     >
>     > Eugh, yikes. It feels like we should fix the cancellation ...
>     Please note that there already is a patch for that on the list:
>     https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg01011.html <https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg01011.html>
> 
>     Best Regards,
>     Fiona
> 
> 
> Gotcha, thanks for the pointer. I wonder if that's sufficient to fix the
> CVE here? I don't have the reproducer in my hands (that I know of ...
> it's genuinely possible I missed it, apologies)
> 

AFAICT, yes, because the DMA callback is invoked before resetting the
state now. But not 100% sure if it can't be triggered in some other way,
maybe Simon knows more? I don't have a reproducer for the CVE either,
but the second patch after the one linked above adds a qtest for the
reset scenario.

Best Regards,
Fiona


