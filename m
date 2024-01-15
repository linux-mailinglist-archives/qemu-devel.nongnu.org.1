Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB08582D84D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:27:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPL6q-0003fC-U1; Mon, 15 Jan 2024 06:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rPL6i-0003YO-6S; Mon, 15 Jan 2024 06:26:20 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rPL6f-0006bL-Kj; Mon, 15 Jan 2024 06:26:19 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6C57A490C5;
 Mon, 15 Jan 2024 12:26:14 +0100 (CET)
Message-ID: <ccd23263-f19f-401e-b476-a7eb1fd22571@proxmox.com>
Date: Mon, 15 Jan 2024 12:26:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/clipboard: avoid crash upon request when clipboard
 peer is not initialized
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com,
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
References: <20240112135527.57212-1-f.ebner@proxmox.com>
 <CAJ+F1C+JXE9hSQ_oDNZvhpYDqPeeKayopB3x2L2YyJTxM8t+Yg@mail.gmail.com>
 <2150aa28-3eba-4e95-a301-d87377ba40a4@proxmox.com>
 <CAJ+F1CKQkXUiuQH+mNC7p00wWrznsgWJD4xjR-AzjJGPnsF8gw@mail.gmail.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAJ+F1CKQkXUiuQH+mNC7p00wWrznsgWJD4xjR-AzjJGPnsF8gw@mail.gmail.com>
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

Am 15.01.24 um 12:15 schrieb Marc-André Lureau:
> Hi
> 
> On Mon, Jan 15, 2024 at 2:45 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>
>> Am 14.01.24 um 14:51 schrieb Marc-André Lureau:
>>>>
>>>> diff --git a/ui/clipboard.c b/ui/clipboard.c
>>>> index 3d14bffaf8..c13b54d2e9 100644
>>>> --- a/ui/clipboard.c
>>>> +++ b/ui/clipboard.c
>>>> @@ -129,7 +129,8 @@ void qemu_clipboard_request(QemuClipboardInfo *info,
>>>>      if (info->types[type].data ||
>>>>          info->types[type].requested ||
>>>>          !info->types[type].available ||
>>>> -        !info->owner)
>>>> +        !info->owner ||
>>>> +        !info->owner->request)
>>>>          return;
>>>
>>> While that fixes the crash, I think we should handle the situation
>>> earlier. A clipboard peer shouldn't be allowed to hold the clipboard
>>> if it doesn't have the data available or a "request" callback set.
>>>
>>
>> Where should initialization of the cbpeer happen so that we are
>> guaranteed to do it also for clients that do not set the
>> VNC_FEATURE_CLIPBOARD_EXT feature? Can the vnc_clipboard_request
>> function be re-used for clients without that feature or will it be
>> necessary to add some kind of "dummy" request callback for those clients?
> 
> qemu_clipboard_update() shouldn't accept info as current clipboard if
> the owner doesn't have the data available or a "request" callback set.
> This should also be assert() somehow and handled earlier.
> 

The request callback is only initialized in vnc_server_cut_text_caps()
when the VNC_FEATURE_CLIPBOARD_EXT is enabled. AFAIU, it's perfectly
fine for clients to use the clipboard with non-extended messages and
qemu_clipboard_update() should (and currently does) accept those.

> In vnc_client_cut_text_ext() we could detect that situation, but with
> Daniel's "[PATCH] ui: reject extended clipboard message if not
> activated", this shouldn't happen anymore iiuc.
> 

Daniel's patch doesn't change the behavior for non-extended messages.
The problem can still happen with two VNC clients. This is the scenario
described in the lower half of my commit message (and why Daniel
mentions in his patch that it's not sufficient to fix the CVE).

In short: client A does not set the VNC_FEATURE_CLIPBOARD_EXT feature
and then uses a non-extended VNC_MSG_CLIENT_CUT_TEXT message. This leads
to vnc_client_cut_text() being called and setting the clipboard info
referencing that client. But here, no request callback is initialized,
that only happens in vnc_server_cut_text_caps() when the
VNC_FEATURE_CLIPBOARD_EXT is enabled.

When client B does set the VNC_FEATURE_CLIPBOARD_EXT feature and does
send an extended VNC_MSG_CLIENT_CUT_TEXT message, the request callback
will be attempted but it isn't set.

Best Regards,
Fiona


