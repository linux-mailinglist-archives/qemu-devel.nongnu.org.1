Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B77E3CF2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:23:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0L6F-0002Xy-7S; Tue, 07 Nov 2023 07:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r0L5i-0002Sz-At
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:22:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r0L5f-0004Gl-QM
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699359708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ft8/+OhdFAlexlrqTj1GsnM1fV1k/4O9ZvzxhSLvN1Y=;
 b=iNJhEOmJ+flQh7Cry0guz+N95j9uCNyf0CxETzH9mwfCbPbRsdomWSyK8o35MMM9CIx6Gm
 BXqIkYXvEXu/HDyuNiX7c7MaHFzFk3Hpd5EyTHy1nIzYIdw5cWfinWroapemmCf68z4bih
 gmtUf6my/vSK6k/k0/K1Er+/9ZZvhC4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-488F59YTOMy_gBnchuTRqw-1; Tue, 07 Nov 2023 07:21:47 -0500
X-MC-Unique: 488F59YTOMy_gBnchuTRqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 399F785A58B;
 Tue,  7 Nov 2023 12:21:47 +0000 (UTC)
Received: from [10.39.193.64] (unknown [10.39.193.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F39BF2166B26;
 Tue,  7 Nov 2023 12:21:45 +0000 (UTC)
Message-ID: <9efd7465-7277-9012-4c7b-8f6cc02476c2@redhat.com>
Date: Tue, 7 Nov 2023 13:21:44 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] virtio-gpu: add blob migration support
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
References: <20230907130936.767722-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLUM+XRZppN2P6Z_c107HEKOGNE3r_ivfMqcOz2oOO6ag@mail.gmail.com>
 <ZQm5sWdhN8S7s95x@x1n>
 <CAJ+F1CK3Jw0GKo_So3JyOFc=RuONHx8JUF-KLHrSHYPY2OE6dg@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CAJ+F1CK3Jw0GKo_So3JyOFc=RuONHx8JUF-KLHrSHYPY2OE6dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/6/23 11:44, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Sep 19, 2023 at 7:09 PM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Tue, Sep 19, 2023 at 04:51:21PM +0400, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Thu, Sep 7, 2023 at 5:15 PM <marcandre.lureau@redhat.com> wrote:
>>>>
>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>
>>>> Hi,
>>>>
>>>> This is a follow-up of the previous patch "[PATCH] virtio-gpu: block migration
>>>> of VMs with blob=true". Now that migration support is implemented, we can decide
>>>> to drop the migration blocker patch, or apply and revert it, so that
>>>> backporting of a quick fix is made easier.
>>>>
>>>> Fixes:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2236353
>>>>
>>>> Marc-André Lureau (5):
>>>>   virtio-gpu: block migration of VMs with blob=true
>>>>   virtio-gpu: factor out restore mapping
>>>>   virtio-gpu: move scanout restoration to post_load
>>>>   virtio-gpu: add virtio-gpu/blob vmstate subsection
>>>>   Revert "virtio-gpu: block migration of VMs with blob=true"
>>>>
>>>>  hw/display/virtio-gpu.c | 174 +++++++++++++++++++++++++++++++++-------
>>>>  1 file changed, 146 insertions(+), 28 deletions(-)
>>
>> For migration:
>>
>> Acked-by: Peter Xu <peterx@redhat.com>
>>
> 
> Anyone else to check this series? Laszlo perhaps?

Sorry, I don't have the patches, plus I'm already loaded with other
reviews elsehwere :/

> Or should I just send it as part of the next gpu-stuff PR?

You appear to have an ACK from Peter; I'd say run with it. Gerd is on CC
so I'm comfortable saying this.

Laszlo


