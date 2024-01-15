Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6FB82D7AC
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:45:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKTJ-0008B4-1E; Mon, 15 Jan 2024 05:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rPKT5-00081c-Na; Mon, 15 Jan 2024 05:45:27 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rPKT2-00046Q-7W; Mon, 15 Jan 2024 05:45:23 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 82F4C441ED;
 Mon, 15 Jan 2024 11:45:07 +0100 (CET)
Message-ID: <2150aa28-3eba-4e95-a301-d87377ba40a4@proxmox.com>
Date: Mon, 15 Jan 2024 11:44:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/clipboard: avoid crash upon request when clipboard
 peer is not initialized
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com,
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
References: <20240112135527.57212-1-f.ebner@proxmox.com>
 <CAJ+F1C+JXE9hSQ_oDNZvhpYDqPeeKayopB3x2L2YyJTxM8t+Yg@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAJ+F1C+JXE9hSQ_oDNZvhpYDqPeeKayopB3x2L2YyJTxM8t+Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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

Am 14.01.24 um 14:51 schrieb Marc-André Lureau:
>>
>> diff --git a/ui/clipboard.c b/ui/clipboard.c
>> index 3d14bffaf8..c13b54d2e9 100644
>> --- a/ui/clipboard.c
>> +++ b/ui/clipboard.c
>> @@ -129,7 +129,8 @@ void qemu_clipboard_request(QemuClipboardInfo *info,
>>      if (info->types[type].data ||
>>          info->types[type].requested ||
>>          !info->types[type].available ||
>> -        !info->owner)
>> +        !info->owner ||
>> +        !info->owner->request)
>>          return;
> 
> While that fixes the crash, I think we should handle the situation
> earlier. A clipboard peer shouldn't be allowed to hold the clipboard
> if it doesn't have the data available or a "request" callback set.
> 

Where should initialization of the cbpeer happen so that we are
guaranteed to do it also for clients that do not set the
VNC_FEATURE_CLIPBOARD_EXT feature? Can the vnc_clipboard_request
function be re-used for clients without that feature or will it be
necessary to add some kind of "dummy" request callback for those clients?

> Iow, we should have an assert(info->owner->request != NULL) here instead.
>
Your choice of course, but it would be a crash again should the issue
ever re-appear. Would error message (so the issue gets noticed) + return
be an option too?

Best Regards,
Fiona


