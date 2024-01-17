Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1534783048C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 12:30:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ47H-0001wp-0a; Wed, 17 Jan 2024 06:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQ47F-0001wd-Pb; Wed, 17 Jan 2024 06:29:53 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQ47E-0004aT-1k; Wed, 17 Jan 2024 06:29:53 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0A88649192;
 Wed, 17 Jan 2024 12:29:48 +0100 (CET)
Message-ID: <4d6f1a47-3311-4a44-b47c-19035d6cfee0@proxmox.com>
Date: Wed, 17 Jan 2024 12:29:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ui/clipboard: ensure data is available or request
 callback is set upon update
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com,
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
References: <20240117110109.287430-1-f.ebner@proxmox.com>
 <CAMxuvayHZiXp=VRm=e=HT8u91p3MTut1KXyWOaooEUv7=wZwFg@mail.gmail.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAMxuvayHZiXp=VRm=e=HT8u91p3MTut1KXyWOaooEUv7=wZwFg@mail.gmail.com>
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

Am 17.01.24 um 12:11 schrieb Marc-André Lureau:
> Hi
> 
> On Wed, Jan 17, 2024 at 3:01 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>
>> +    for (type = 0; type < QEMU_CLIPBOARD_TYPE__COUNT && !missing_data; type++) {
>> +        if (!info->types[type].data) {
>> +            missing_data = true;
>> +        }
>> +    }
>> +    /*
>> +     * If data is missing, the clipboard owner's 'request' callback needs to be
>> +     * set. Otherwise, there is no way to get the clipboard data and
>> +     * qemu_clipboard_request() cannot be called.
>> +     */
>> +    if (missing_data && info->owner && !info->owner->request) {
>> +        return;
>> +    }
> 
> It needs to check whether the type is "available". If not data is
> provided, owner should be set as well, it should assert() that.
> 
> That should do the job:
> 
> for (type = 0; type < QEMU_CLIPBOARD_TYPE__COUNT; type++) {
>     /*
>      * If data is missing, the clipboard owner's 'request' callback needs to
>      * be set. Otherwise, there is no way to get the clipboard data and
>      * qemu_clipboard_request() cannot be called.
>      */
>     if (info->types[type].available && !info->types[type].data) {
>         assert(info->owner && info->owner->request);
>     }
> }
> 

Okay, thanks! But we can't assert, because that doesn't resolve the CVE
as it would still crash. The VNC client might not have the
VNC_FEATURE_CLIPBOARD_EXT feature, and the request callback is currently
only set in that case. But we can return instead of assert to just avoid
clipboard update. I'll send a v3.

Best Regards,
Fiona


