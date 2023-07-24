Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2C75F54D
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 13:40:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNtun-0003F4-IT; Mon, 24 Jul 2023 07:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qNtuj-0003EY-0G
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qNtuh-0004aP-Hk
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690198782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Arw+tBVpWohbXWWfvKVW9xAtN5j9Po1FBAz2uH14XKs=;
 b=KJhbpEB7i84p0pZ/303mPrNRq9VVTIadhjr39wvWLXZ00oPJk/8CLyg0VB5zdYOypX1hXb
 DPgewSW4EnpBlOIbdBjBLGlfTHL0XeeQuqElTAepwZqFuh8Iq2jKLPlc/Yq3yw7LUCEyVz
 feKcfbqntzozqm0zeyzFWIv35i2g5zk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-PtxZ2W8XOrOv0iGIxCKp1w-1; Mon, 24 Jul 2023 07:39:41 -0400
X-MC-Unique: PtxZ2W8XOrOv0iGIxCKp1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE021802666;
 Mon, 24 Jul 2023 11:39:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AADBB1454143;
 Mon, 24 Jul 2023 11:39:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A9D9821E60F2; Mon, 24 Jul 2023 13:39:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Eric
 Blake <eblake@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v6 0/6] Hyper-V Dynamic Memory Protocol driver
 (hv-balloon =?utf-8?B?8J+OiO+4jyk=?=
References: <cover.1689786474.git.maciej.szmigiero@oracle.com>
 <87wmypo9wh.fsf@pond.sub.org>
 <d8f2654d-2464-7cd3-f890-95cd6b8fc2fe@maciej.szmigiero.name>
Date: Mon, 24 Jul 2023 13:39:39 +0200
In-Reply-To: <d8f2654d-2464-7cd3-f890-95cd6b8fc2fe@maciej.szmigiero.name>
 (Maciej S. Szmigiero's message of "Mon, 24 Jul 2023 13:04:55 +0200")
Message-ID: <87y1j5mtc4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> On 24.07.2023 12:56, Markus Armbruster wrote:
>> Doesn't apply to master.  Care to rebase?
>> 
>
> The series is now based on David's virtio-mem-memslots patches
> (specifically, commit 6769107d1a4f from [1]) since it depends
> on support for exposing device memory via multiple memslots
> provided by that series.
>
> I'm sorry if that wasn't clear from the cover letter.

Aha!  I just fetched David's branch, applied your patches on top, and
rebased to current master.

I recommend to list dependencies like

    Based-on: <message-id>

so Patchew applies them.


> Thanks,
> Maciej
>
> [1]: https://github.com/davidhildenbrand/qemu/tree/virtio-mem-memslots


