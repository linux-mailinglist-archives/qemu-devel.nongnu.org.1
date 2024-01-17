Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C5B83084C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:42:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ76C-00069i-KB; Wed, 17 Jan 2024 09:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQ76A-00069C-H8; Wed, 17 Jan 2024 09:40:58 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQ768-0008IZ-7v; Wed, 17 Jan 2024 09:40:58 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6896D49194;
 Wed, 17 Jan 2024 15:40:46 +0100 (CET)
Message-ID: <3d1e41ba-efc4-4da3-acfb-419d461a5b7e@proxmox.com>
Date: Wed, 17 Jan 2024 15:40:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ui/clipboard: ensure data is available or request
 callback is set upon update
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com,
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
References: <20240117110109.287430-1-f.ebner@proxmox.com>
 <CAMxuvayHZiXp=VRm=e=HT8u91p3MTut1KXyWOaooEUv7=wZwFg@mail.gmail.com>
 <4d6f1a47-3311-4a44-b47c-19035d6cfee0@proxmox.com>
 <CAJ+F1CJ4gF=kx1xedYsnU9MYqTS24xobYrf4ObOAgDnSFGFrnA@mail.gmail.com>
 <a34df4a7-1948-4e65-bec1-c86c1ce54280@proxmox.com>
 <CAJ+F1CJ5ru_9EoenYLsEAc3jO5rvTbdvu15ocWy7nUT0AwOD+Q@mail.gmail.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAJ+F1CJ5ru_9EoenYLsEAc3jO5rvTbdvu15ocWy7nUT0AwOD+Q@mail.gmail.com>
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

Am 17.01.24 um 13:20 schrieb Marc-André Lureau:
> Hi
> 
> On Wed, Jan 17, 2024 at 3:56 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>
>> Am 17.01.24 um 12:33 schrieb Marc-André Lureau:
>>> Hi
>>>
>>> On Wed, Jan 17, 2024 at 3:30 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>>>
>>>> Am 17.01.24 um 12:11 schrieb Marc-André Lureau:
>>>>> Hi
>>>>>
>>>>> On Wed, Jan 17, 2024 at 3:01 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>>>>>
>>>>>> +    for (type = 0; type < QEMU_CLIPBOARD_TYPE__COUNT && !missing_data; type++) {
>>>>>> +        if (!info->types[type].data) {
>>>>>> +            missing_data = true;
>>>>>> +        }
>>>>>> +    }
>>>>>> +    /*
>>>>>> +     * If data is missing, the clipboard owner's 'request' callback needs to be
>>>>>> +     * set. Otherwise, there is no way to get the clipboard data and
>>>>>> +     * qemu_clipboard_request() cannot be called.
>>>>>> +     */
>>>>>> +    if (missing_data && info->owner && !info->owner->request) {
>>>>>> +        return;
>>>>>> +    }
>>>>>
>>>>> It needs to check whether the type is "available". If not data is
>>>>> provided, owner should be set as well, it should assert() that.
>>>>>
>>>>> That should do the job:
>>>>>
>>>>> for (type = 0; type < QEMU_CLIPBOARD_TYPE__COUNT; type++) {
>>>>>     /*
>>>>>      * If data is missing, the clipboard owner's 'request' callback needs to
>>>>>      * be set. Otherwise, there is no way to get the clipboard data and
>>>>>      * qemu_clipboard_request() cannot be called.
>>>>>      */
>>>>>     if (info->types[type].available && !info->types[type].data) {
>>>>>         assert(info->owner && info->owner->request);
>>>>>     }
>>>>> }
>>>>>
>>>>
>>>> Okay, thanks! But we can't assert, because that doesn't resolve the CVE
>>>> as it would still crash. The VNC client might not have the
>>>> VNC_FEATURE_CLIPBOARD_EXT feature, and the request callback is currently
>>>> only set in that case. But we can return instead of assert to just avoid
>>>> clipboard update. I'll send a v3.
>>>
>>> If it doesn't have VNC_FEATURE_CLIPBOARD_EXT, it shouldn't update the
>>> clipboard without data. (ClientCutText/ServerCutText always have data,
>>> even if 0-length)
>>>
>>
>> But a buggy client should not be able to crash QEMU. With a
>> VNC_MSG_CLIENT_CUT_TEXT message, when read_s32(data, 4) == 0,
>> vnc_client_cut_text() is called with zero length. Is that supposed to
> 
> Indeed. That case should be handled at the VNC server code level.. A
> 0-length text should set clipboard to "", not NULL.
> 

So have vnc_client_cut_text() call qemu_clipboard_set_data() with
data="" and size=1 in the 0-length case? I can see such a call with
noVNC as the client (which does use extended messages) when clearing the
clipboard.

But I suppose the call in vnc_client_cut_text_ext() also would need a
check before calling qemu_clipboard_set_data(). Or is there anything
guaranteeing the size read from the inflated buffer, i.e.
uint32_t tsize = read_u32(buf, 0);
which is passed to qemu_clipboard_set_data() is not zero?

> With Ext, there is an explicit description of data ending with \0:
> According to https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#user-content-7727extended-clipboard-pseudo-encoding
> "The text must be followed by a terminating null even though the
> length is also explicitly given."
> 
> But we should still handle 0-length data cases.
> >> happen? The branch for an extended message is only taken when
>> read_s32(data, 4) < 0 and Daniel's patch fixes that branch.
>>
>> I noticed in qemu_clipboard_set_data():
>>
>>> info->types[type].data = g_memdup(data, size);
>>
>> the g_memdup call will return NULL when size == 0 even if data is
>> non-NULL. Is that the actual problem in the above scenario?
> 
> Hmm, qemu_clipboard_set_data() shouldn't allow data == NULL, or size == 0.
> 
> When data is requested, the "peer" will call
> qemu_clipboard_set_data(). But I can't see a good way for the peer to
> return with no data, it should probably update the clipboard info with
> available=false.
> 

Oh, I guess my suggestion above isn't necessary if we set
available=false when size == 0. Sorry, is this what you mean by "no
data"? Or do you mean the case where data=""? Or both?

Best Regards,
Fiona


