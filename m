Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 935D07154B0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 07:03:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3rVz-00009h-CT; Tue, 30 May 2023 01:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3rVL-0008MD-Cn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 01:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3rVJ-0004wG-Oz
 for qemu-devel@nongnu.org; Tue, 30 May 2023 01:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685422959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rz1/VX8LbJX2HFP5XvUBJdPtpXKxpHMH1CsGpT0GJCA=;
 b=SJp+epc5n96/5W7YDKl3njOgAa4kdNmVbSTea6aIeczs4v8SMH4o/N0fZUSXHGOr1+vujz
 EelSALgRYOzdQ0qyBrKqkThi3CvVYTYmqNP2WzhLcFXJpIyvzgO5i4MgBe5iv6h6FXjXM1
 3SeVVVAUz5s9hHuIZjl3P2M59NyD8M4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-NH1i4ZBtMiGoTw6W-cbU4A-1; Tue, 30 May 2023 01:02:37 -0400
X-MC-Unique: NH1i4ZBtMiGoTw6W-cbU4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08EF2101A531;
 Tue, 30 May 2023 05:02:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC47840CF8F6;
 Tue, 30 May 2023 05:02:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1D4321E692E; Tue, 30 May 2023 07:02:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,  Hanna Reitz <hreitz@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Jonathon Jongsma
 <jjongsma@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 2/2] qapi: add '@fdset' feature for
 BlockdevOptionsVirtioBlkVhostVdpa
References: <20230526150304.158206-1-sgarzare@redhat.com>
 <20230526150304.158206-3-sgarzare@redhat.com>
 <87o7m648si.fsf@pond.sub.org>
 <igbvuv35h2xfcsozeefsauaxf3iudv75hejc6rrnunx4jfxfgt@otkhmxnupgrl>
Date: Tue, 30 May 2023 07:02:35 +0200
In-Reply-To: <igbvuv35h2xfcsozeefsauaxf3iudv75hejc6rrnunx4jfxfgt@otkhmxnupgrl>
 (Stefano Garzarella's message of "Mon, 29 May 2023 09:36:20 +0200")
Message-ID: <875y8awgwk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Stefano Garzarella <sgarzare@redhat.com> writes:

> On Sat, May 27, 2023 at 07:56:13AM +0200, Markus Armbruster wrote:
>>Stefano Garzarella <sgarzare@redhat.com> writes:
>>
>>> The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the fd
>>> passing through the new 'fd' property.
>>>
>>> Since now we are using qemu_open() on '@path' if the virtio-blk driver
>>> supports the fd passing, let's announce it.
>>> In this way, the management layer can pass the file descriptor of an
>>> already opened vhost-vdpa character device. This is useful especially
>>> when the device can only be accessed with certain privileges.
>>>
>>> Add the '@fdset' feature only when the virtio-blk-vhost-vdpa driver
>>> in libblkio supports it.
>>>
>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

[...]

>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 98d9116dae..1538d84ef4 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -3955,10 +3955,16 @@
>>>  #
>>>  # @path: path to the vhost-vdpa character device.
>>>  #
>>> +# Features:
>>> +# @fdset: Member @path supports the special "/dev/fdset/N" path (since 8.1)
>>
>>Slightly long line, break it like this:
>>
>>   # @fdset: Member @path supports the special "/dev/fdset/N" path
>>   #     since 8.1)
>>
>
> Sure, I'll fix it!
> For the future, what is the maximum column?

70.  Going over is okay if it improves legibility.  However, when I
reformatted the doc comments, I did not need to even once.

[...]


