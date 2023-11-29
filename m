Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 681BD7FD338
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 10:49:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8HBz-0003LT-6R; Wed, 29 Nov 2023 04:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r8HBx-0003Kw-33; Wed, 29 Nov 2023 04:49:13 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r8HBt-00083G-DF; Wed, 29 Nov 2023 04:49:12 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:b5a4:0:640:2bd1:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id F1B7261680;
 Wed, 29 Nov 2023 12:49:03 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:27::1:23] (unknown [2a02:6b8:b081:27::1:23])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2nRqQY0i2a60-hg2IrGzQ; Wed, 29 Nov 2023 12:49:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1701251343;
 bh=8YfOF4JcRMVC2WFKXkwPHIIEl3/IRZg3Tbnyd9qai+U=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vFHqEsMV+BAeCmRtF7rE4zjp9f4eOVl0hnYJ2iFYLYBQeBdEn3XTq7GAAXbYzuxT7
 TbY+9SvlseUb5oIKrrvfijVtw8JL0eL54lVQQJi3olgWkGuRWMO2unSkc5M2GaPj/W
 h5V82czInYDwEkLVbsYZCHY4G3NioRwRtQSEpS/w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ca2bf5a4-06c3-4e7d-afc1-39b5ebe27afb@yandex-team.ru>
Date: Wed, 29 Nov 2023 12:49:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: commit: Allow users to request only format
 driver names in backing file format
Content-Language: en-US
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
References: <cover.1700837066.git.pkrempa@redhat.com>
 <8593619407b16a578896e1e9fcc77a18fe8d80fa.1700837066.git.pkrempa@redhat.com>
 <632957d1-219d-4bbb-a0fc-b510c8b936ca@yandex-team.ru>
 <ZWZikXhpevsA2ik2@angien.pipo.sk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ZWZikXhpevsA2ik2@angien.pipo.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29.11.23 00:58, Peter Krempa wrote:
> On Tue, Nov 28, 2023 at 20:10:10 +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 24.11.23 17:52, Peter Krempa wrote:
>>> Introduce a new flag 'backing_file_format_no_protocol' for the
>>> block-commit QMP command which instructs the internals to use 'raw'
>>> instead of the protocol driver in case when a image is used without a
>>> dummy 'raw' wrapper.
>>>
>>> The flag is designed such that it can be always asserted by management
>>> tools even when there isn't any update to backing files.
>>>
>>> The flag will be used by libvirt so that the backing images still
>>> reference the proper format even when libvirt will stop using the dummy
>>> raw driver (raw driver with no other config). Libvirt needs this so that
>>> the images stay compatible with older libvirt versions which didn't
>>> expect that a protocol driver name can appear in the backing file format
>>> field.
>>>
>>> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
>>> ---
> 
> [...]
> 
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index ca390c5700..367e896905 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -1810,6 +1810,14 @@
>>>    #     Care should be taken when specifying the string, to specify a
>>>    #     valid filename or protocol.  (Since 2.1)
>>>    #
>>> +# @backing-file-format-no-protocol: If true always use a 'format' driver name
>>> +#     for the 'backing file format' field if updating the image header of the
>>> +#     overlay of 'top'. Otherwise the real name of the driver of the backing
>>> +#     image may be used which may be a protocol driver.
>>> +#
>>> +#     Can be used also when no image header will be updated.
>>> +#     (default: false; since: 8.2)
>>> +#
>>
>> Hi Peter.
> 
> Hi,
> 
> Firstly to be honest, I consider the fact that qemu can put a protocol
> driver into the header field named "backing file format" to be a bug.
> After discussion with Kevin I understand the rationale of doing so, but
> nevertheless, a backing protocol name is not a format and should have
> had it's own header field.
> 
>> Hmm. Could this just be @backing-file-format ?
> 
> I don't really care too deeply about the name.
> 
> Calling it just @backing-file-format though would imply (as you write
> below) that as argument the string to write into the metadata. More on
> that below.
> 
>> As I understand, finally, that's just a string which we are going to put into qcow2 metadata.
> 
> Yes.
> 
>> And from qcow2 point of view, it's rather strange to set backing_file_format="raw" for backing image which is actually "qcow2".
> 
> Indeed, that would be wrong, but this is _NOT_ what this patch
> actually does.

Oh, right. Somehow I was confused. That was bad idea to review in the evening(

> 
> This patch ensures that only a *format* driver name is ever written to
> the backing image. It overrides the fact that a *protocol* driver name
> would be written into the field if the tail of the backing chain is a
> raw image, which was instantiated in qemu without the dummy 'raw' driver
> on top.

Yes, right, I understand. How could I think that we are going to write "raw" instead of "qcow2", I can't say now)

> 
> Since a raw driver with no configuration simply passes request to the
> *protocol* driver below it it's not needed in most configs. In fact as
> stefanha figured out a long time ago it's just simpy overhead.

I have always keep that in mind, but never really care. Cool that you rework it.

> 
> We need a format name in the backing file format field as libvirt
> assumed for a very long time that such a field would contain only format
> drivers, and since I want to remove the overhead of the 'raw' driver I
> need to ensure that images won't break for older libvirt.
> 
>> "raw" say nothing to the reader and may be even misleading. Same for qemu, this seems just a strange thing.
>>
>> Also, what I dislike, that new feature sounds like hardcoded "raw" is the only format driver. If go this way, more honest name would be @backing-file-raw.
> 
> Once again, that is not what's happening here. The field enables that
> only a *format* driver is used. This is only a problem when the final
> image is raw, but without the dummy 'raw' driver on top of it. Thus
> that's the reason the workaround only ever writes 'raw' into it.
> Otherwise the proper format name is in the 'driver' field already and is
> not overwritten.

OK

> 
>> And, if we allow user to give any backing-file name to be written into qcow2 metadata after the operation, why not just allow to set any backing-file-name as well?
> 
> This IMO makes no sense to allow, but based on the reimagined design of
> the 'backing file /format/' field it might appear that it does.
> 
> 'block-commit' and 'block-stream, can't change the format of any of the
> images, they simply move data, thus for any non-raw image in a chain it
> must still use actual format name. Only place it makes sense is in the
> same cases when the code in this patch triggers.
> 
> And then it still doesn't make sense to write anything besides:
> 1) The actual *format* of the image (thus 'raw')
> 2) The protocol driver of the last image (e.g. NBD)
> 
> But since 'block-stream'/'block-commit' don't move the image to any
> other storage, allowing the user to write any other protocol also
> doesn't make any sense to write any other protocol.
> 
> Thus the two cases above are the only sane, this patch allows that 1) is
> written into the image.
> 
>> So, I think simple @backing-file-format argument, allowing to set any string as backing format is a better concept.
> 
> While libvirt certainly has the data to do so, as noted in the paragraph
> above it doesn't IMO make sense to allow write any arbitrary driver name
> there.
> 
> And with design like this it allows libvirt to unconditionally use the
> flag without thinking too much about what is the correct value.
> 
>> Moreover: in BlockdevCreateOptionsQcow2 we have backing-file and backing-fmt options. So I think, we should follow this and name the new option for block-job @backing-fmt.
> 
> This is different, you are creating an image and declaring it's backing
> image format. With 'block-stream' and 'block-commit' the format of the
> backing image won't change, just data will be shuffled around.
> 

OK, right, I understand now, thanks for comprehensive explanation.

-- 
Best regards,
Vladimir


