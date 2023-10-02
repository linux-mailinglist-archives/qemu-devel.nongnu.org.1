Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 023EF7B4AAE
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 04:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn8H1-0006XI-Kv; Sun, 01 Oct 2023 22:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qn8H0-0006Wr-0F
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 22:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qn8Gy-00017X-AM
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 22:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696212179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUkDpoKO9J3VYxxUl0ZEb7qBeFLWn0U0G/8bpLK53zg=;
 b=Lcb2elMtFXlBmL8qmdH0QyiKIiSDg5Je8qXuCl2BjDTkjBAzVyMl4YIc4dSnQgDV6kJpxt
 2GCUxpYLYgCtClD8lO0q2tNNy9bJgEwMYqbjxe4ftXKNPyTn2Df/j0W3BR9CrGrJ/yGCHR
 miSnXdxC6SiOPuqqa5kvpOF7qS1ynz4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-tMO2e-qyM3WOcry0J-hh2A-1; Sun, 01 Oct 2023 22:02:48 -0400
X-MC-Unique: tMO2e-qyM3WOcry0J-hh2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D90D61C06510;
 Mon,  2 Oct 2023 02:02:47 +0000 (UTC)
Received: from [10.39.192.60] (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0828440C2064;
 Mon,  2 Oct 2023 02:02:46 +0000 (UTC)
Message-ID: <999ac827-708d-4e5d-b531-ed7076f7a75c@redhat.com>
Date: Mon, 2 Oct 2023 04:02:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] hw/display/ramfb: plug slight guest-triggerable leak on
 mode setting
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
References: <20230919131955.27223-1-lersek@redhat.com>
 <7ee37181-526e-2b6a-6b42-09340a9e70a9@redhat.com>
 <CAJ+F1CK0FaMfm-ZUz7KB0erFRLBWTa7yHMxhiX0+J0ZxNp34bw@mail.gmail.com>
 <4da39e48-c916-ed62-70ae-f0306845f01b@redhat.com>
 <d5358711-c6ad-2f4c-ad33-9227503f53b1@redhat.com>
 <CAJ+F1CLgHYbdu+KJzgbRZ7Ej1wkNAj9=hLd-zCpp+vACmDmEtA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CAJ+F1CLgHYbdu+KJzgbRZ7Ej1wkNAj9=hLd-zCpp+vACmDmEtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/1/23 18:07, Marc-André Lureau wrote:
> Hi Laszlo
> 
> On Sun, Oct 1, 2023 at 4:20 AM Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> On 10/1/23 00:14, Laszlo Ersek wrote:
>>> On 9/29/23 13:17, Marc-André Lureau wrote:
> [..]
>>>> fwiw, my migration support patch is still unreviewed:
>>>> https://patchew.org/QEMU/20230920082651.3349712-1-marcandre.lureau@redhat.com/
>>>>
>>>
>>> I don't have a copy of that patch (not subscribed, sorry...), but how
>>> simply you did it surprises me. I did expect to simulate an fw_cfg write
>>> in post_load, but I thought we'd approach the device (for the sake of
>>> including it in the migration stream) from the higher level device's
>>> vmstate descriptors (dc->vmsd) that set up / depend on ramfb in the
>>> first place. I didn't know that raw vmstate_register() was still accepted.
>>>
>>> If it is, then, for that patch (with Gerd's comment addressed):
>>>
>>> Acked-by: Laszlo Ersek <lersek@redhat.com>
>>
>> I think I may have found one issue with that patch.
>>
>> The fields that we save into the migration stream are integer members of
>> the RAMFBCfg structure that lives directly in the fw_cfg file. The ramfb
>> device specifies those fields for the guest as big endian. This means
>> that when ramfb_fw_cfg_write() runs, triggered by the guest, then on big
>> endian hosts, be32_to_cpu() and be64_to_cpu() will be no-ops, as the
>> integer representation inside the fw_cfg file will match the host CPU at
>> once. And on little endian hosts, these functions will byte swap. In
>> both cases, ramfb_create_display_surface() will have to be called with
>> identical host-side integers. This means that *before* the be32_to_cpu()
>> and be64_to_cpu() calls, the host side *values* read out from the fw_cfg
>> file members *differ* between big endian and little endian hosts.
>>
>> And the problem is that we write precisely those values into the
>> migration stream, via "vmstate_ramfb_cfg". The migration stream
>> represents integers in big endian regardless of host endianness, but the
>> question is the *values* that we encode in BE for the stream. And the
>> values (from fw_cg) will differ between little endian and big endian hosts.
>>
>> Thus, I think we should just use
>>
>>   VMSTATE_BUFFER(cfg, RAMFBState)
>>
>> in "vmstate_ramfb", and remove "vmstate_ramfb_cfg". For migration
>> purposes, we should treat the fw_cfg file as an opaque blob.
> 
> I think I see your point. Using VMSTATE_BUFFER like that doesn't work
> though.

Why not?

(I mean -- does it compile but misbehave, or it doesn't even compile (an
invalid use of the VMSTATE_BUFFER macro)?)

> It's also more error-prone if fields are added in the struct,
> imho.

The structure is effectively the guest-visible register block for the
device. We probably can't add any fields, and even if we do, the new
fields are going to be part of the fw_cfg blob (writeable file), so they
should be covered by VMSTATE_BUFFER just the same.

> 
> However, we could simply have a post-load to convert the values to BE.

post_load itself is not enough; if we want to go this route, then we
need pre_save too. Without a pre_save, the host endianness influences
the data serialized to the migration stream, and there's no way to know
how to recover (the source host's endianness is unknown at load time).

pre_save could work though, if it performed the same BE to host
conversions (to a separate buffer I guess!) as the fw_cfg write callback
does.

> I wonder if new macros couldn't be introduced too.
> 
>>>
>>> BTW: can you please assign
>>> <https://bugzilla.redhat.com/show_bug.cgi?id=1859424> to yourself and
>>> link your patch into it? The reason we ended up duplicating work here is
>>> that noone took RHBZ 1859424 before.
> 
> I thought I did that.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1859424#c17

Ouch, sorry. That must have happened since I last looked, and I was
foolish enough not to CC myself on the BZ early on. My mistake!

> 
>>>
>>> ... Well, the ticket is RHEL-7478 in JIRA now, in fact. :/
> 
> :/
> 
> 

Laszlo


