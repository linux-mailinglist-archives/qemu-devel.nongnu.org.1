Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375885E150
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 16:35:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoUE-0000yq-91; Wed, 21 Feb 2024 10:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoNJ-0003Wj-GH
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rchwJ-0003Cq-DW
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708504009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noNMRoIaLd7hMdQmpScQDHZVhCVK1JsXEgZn4ucahco=;
 b=VEA4thXowZyUcwmFIswVVp14D+k4PM/fCJG+OZsvvB4E1IXKTPyNUY3OY7zqIuU08/3i+h
 uGTPI8a7UGOeHQUKAYVvySXQL9IsHJnlsZghdRUfCPdylNnN7bATUC4yOirrRYxdBS6YTx
 JltHNIC8A7B5JQQ+6aRgxFSRJN2Huz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-QjE2vVA2O_atV9VVIVQPCQ-1; Wed, 21 Feb 2024 03:26:46 -0500
X-MC-Unique: QjE2vVA2O_atV9VVIVQPCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A0BC185A786;
 Wed, 21 Feb 2024 08:26:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 885B4C185C0;
 Wed, 21 Feb 2024 08:26:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 583B521E66D5; Wed, 21 Feb 2024 09:26:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Kevin
 Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH] qapi: Craft the BlockdevCreateOptionsLUKS comment
In-Reply-To: <CAK9dgmZkLZiT_W0UjB+=EN9_vAK5Qy5XKRMBhHBQ98sRBbiAQw@mail.gmail.com>
 (Yong Huang's message of "Wed, 21 Feb 2024 15:08:04 +0800")
References: <91c52e03e46ff0a96559b4e7d66ded582b2ec4e1.1708486450.git.yong.huang@smartx.com>
 <874je22u83.fsf@pond.sub.org>
 <CAK9dgmZkLZiT_W0UjB+=EN9_vAK5Qy5XKRMBhHBQ98sRBbiAQw@mail.gmail.com>
Date: Wed, 21 Feb 2024 09:26:43 +0100
Message-ID: <875xyiz0ho.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Yong Huang <yong.huang@smartx.com> writes:

> On Wed, Feb 21, 2024 at 2:43=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> Hyman Huang <yong.huang@smartx.com> writes:
>>
>> > Add comment in detail for commit 433957bb7f (qapi:
>> > Make parameter 'file' optional for
>> > BlockdevCreateOptionsLUKS).
>> >
>> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>> > ---
>> >  qapi/block-core.json | 20 +++++++++++++++++++-
>> >  1 file changed, 19 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index ab5a93a966..42b0840d43 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -4973,7 +4973,25 @@
>> >  ##
>> >  # @BlockdevCreateOptionsLUKS:
>> >  #
>> > -# Driver specific image creation options for LUKS.
>> > +# Driver specific image creation options for LUKS. Note that
>> > +# @file is required if @preallocation is specified and equals
>> > +# PREALLOC_MODE_ON. The following three scenarios determine how
>> > +# creation logic behaves when @preallocation is either equal to
>> > +# PREALLOC_MODE_OFF or is not given:
>> > +#
>> > +#  1) When @file is given only, format the block device referenced
>> > +#     by @file as the LUKS specification and trunk it to the @size.
>>
>> Do you mean "truncate it to @size"?
>>
> Yes, :( sorry for the spelling mistake.

Writing good documentation in a second language is *hard*.  All we can
reasonably expect from contributors to try their best.  And then we
improve the text together in review.  Just like we do for code :)

>> > +#     In this case, the @size should reflect amount of space made
>> > +#     available to the guest, so the trunk size must take account
>> > +#     of that which will be used by the crypto header.
>> > +#
>> > +#  2) When @header is given only, just format the block device
>> > +#     referenced by @header as the LUKS specification.
>> > +#
>> > +#  3) When both @file and @header are given, block device
>> > +#     referenced by @file should be trunked to @size, and block
>> > +#     device referenced by @header should be formatted as the LUKS
>> > +#     specification.
>> >  #
>> >  # @file: Node to create the image format on, mandatory except when
>> >  #        'preallocation' is not requested
>>
>> Let's see whether I understand.
>>
>> blockdev-create with "driver": "luks" can work in three different ways:
>>
>> 1. Create an image with a LUKS header
>>
>> 2. Create just a detached LUKS header
>>
>> 3. Create an image and a detached LUKS header
>>
>> Correct?
>>
>
> Yes
>
>
>> @file and @header are BlockdevRef, which means they refer to existing
>> images with arbitrary driver.  Could be "file", "qcow2", or anything.
>>
>> Correct?
>>
> Yes
>
>
>>
>> To get 1., specify @file, but not @header.
>>
>> To get 2., specify @header, but not @file.
>>
>> To get 3., specify both.
>>
>> Specifying neither is an error.
>>
>> Correct?
>>
>
> Yes
>
>
>> In any case, @size is the logical size of the image (how much data it
>> can hold).
>>
>
> Yes
>
>
>>
>> With 1., the actual image size is a bit larger due to the LUKS header.
>> The @file image is resized to that size: if it's shorter, it's grown, if
>> it's longer, it's truncated.
>>
>
> Yes
>
>
>> With 2., @size is merely recorded in the detached LUKS header.
>>
>
> In LUKS1 specification, payload data size is not contained in the header,
> so in this case, @size is not recorded in the detached LUKS header.
> The creation logic just does the LUKS header formatting only.

Is @size unused then?

>> With 3., @size is recorded in the detached LUKS header, and the @file
>> image is resized as with 1.
>>
>
> Same reason as above, @size is not recorded and @file image is
> resized to @size exactly.
>
>
>>
>> Correct?
>>
>>
> Thanks for the comment,
>
> Yong


