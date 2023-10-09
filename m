Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEAA7BD2FF
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjLc-00046g-L3; Mon, 09 Oct 2023 02:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpjLZ-00046D-IZ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpjLU-0007It-M1
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696831343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A49hkj4iH4M3cdIFcvi7sUJ79wl/wVgoa2Ki1/b2gvk=;
 b=U3wMD2puVAOet82FBE65vzjIRpyZao6VNTrWsulplAFs7uIV7KjePRYdfHFQNjC8Dnk2sr
 r/0aCjWbjn0+Pc7Q9DwIA3+LYvcf1zER2yu6clW20e9pM3hvcsm0a0pae1hs4/9GDQz8QW
 +1vj04+WppM+iTHKCCcIkGX73rjHHq8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-WSH3PzFkNNebcuWKao3A9A-1; Mon, 09 Oct 2023 02:02:14 -0400
X-MC-Unique: WSH3PzFkNNebcuWKao3A9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 901CB3800E9A;
 Mon,  9 Oct 2023 06:02:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9EFE63F53;
 Mon,  9 Oct 2023 06:02:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C480621E6904; Mon,  9 Oct 2023 08:02:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/virtio/vhost: Silence compiler warnings in vhost
 code when using -Wshadow
References: <20231004114809.105672-1-thuth@redhat.com>
 <18f1faab-71f4-4dbd-a319-fcd65721f58b@tls.msk.ru>
 <87h6n4p1ts.fsf@pond.sub.org>
 <29a2a188-ec5b-452f-be63-92e8f0ec7110@tls.msk.ru>
 <20231006072416-mutt-send-email-mst@kernel.org>
 <88329105-bec2-461e-8c40-bbb5b66636b1@tls.msk.ru>
Date: Mon, 09 Oct 2023 08:02:12 +0200
In-Reply-To: <88329105-bec2-461e-8c40-bbb5b66636b1@tls.msk.ru> (Michael
 Tokarev's message of "Sat, 7 Oct 2023 12:28:26 +0300")
Message-ID: <87fs2k72qj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 06.10.2023 14:24, Michael S. Tsirkin:
>> On Fri, Oct 06, 2023 at 01:45:51PM +0300, Michael Tokarev wrote:
>>> 06.10.2023 11:55, Markus Armbruster =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> Michael Tokarev <mjt@tls.msk.ru> writes:
>>>>
>>>>> Applied to my trivial-patches tree, thanks!
>>>>>
>>>>> Marcus, you picked up previous patches of this theme, --
>>>>> you can continue this tradition if you like :)
>>>>
>>>> I intend to post a pull request for the -Wshadow patches that have
>>>> R-bys.  I'm also tracking the unreviewed ones, and hope they get
>>>> reviewed.
>>>
>>> Ahh, ok.
>>>
>>> I've added my own R-bys for the ones I picked up, and for this one
>>> by Thomas too:
>>>
>>> Reviewed-By: Michael Tokarev <mjt@tls.msk.ru>
>>
>> it would be better to deal with all of them in one place tbh.
>
> This is exactly why I asked Marcus about this in the first place,
> being confused a bit with the stuff being especially sent to
> qemu-trivial@ :)

This patch is in my latest PR[*], along with all the other shadow
patches that were ready at the time.  A few more are coming down the
pipe, which I can take through my tree, too.


[*] [PULL 00/32] -Wshadow=3Dlocal patches patches for 2023-10-06
Message-ID: <20231006113657.3803180-1-armbru@redhat.com>


