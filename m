Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EF978D485
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:16:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHHZ-0005As-U6; Wed, 30 Aug 2023 05:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbHHY-0005Aa-1j
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbHHV-0004mf-NJ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693386872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqdGV+xPe0WUhJuCwgMRfeINaLeiVezZuHoFrx4ADQk=;
 b=V5VKZAnllwWDqnO6Y9jxIHLMCf0JU8y76W+ozflCJCcmbg1xK1fG+UxrDuT6QC4gadTroV
 tNdGwnLSop+aOcI9OJOt/U/U0SU5kEW5+Bt2/4tvwaaqjY2jzb4HKEG1QowzWltFafkd8c
 38DKV5X5J2luq3fu6zmks2fzp5aAgsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-pVCp59MTObmsJ3s5ZJc1Jg-1; Wed, 30 Aug 2023 05:14:31 -0400
X-MC-Unique: pVCp59MTObmsJ3s5ZJc1Jg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D44FF185A78F;
 Wed, 30 Aug 2023 09:14:30 +0000 (UTC)
Received: from [10.39.192.65] (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BD7F403168;
 Wed, 30 Aug 2023 09:14:29 +0000 (UTC)
Message-ID: <7d0a1750-1a2f-1201-3cff-7c8dc932b830@redhat.com>
Date: Wed, 30 Aug 2023 11:14:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] vhost-user: factor out "vhost_user_write_msg"
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-4-lersek@redhat.com>
 <ddnrsg2yifpwtnso37ob5sw2o4ysi7ohgexq2xolgacubpytl4@2wxnq5knlbzs>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <ddnrsg2yifpwtnso37ob5sw2o4ysi7ohgexq2xolgacubpytl4@2wxnq5knlbzs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/30/23 10:31, Stefano Garzarella wrote:
> On Sun, Aug 27, 2023 at 08:29:33PM +0200, Laszlo Ersek wrote:
>> The tails of the "vhost_user_set_vring_addr" and "vhost_user_set_u64"
>> functions are now byte-for-byte identical. Factor the common tail out
>> to a
>> new function called "vhost_user_write_msg".
>>
>> This is purely refactoring -- no observable change.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>> Cc: Eugenio Perez Martin <eperezma@redhat.com>
>> Cc: German Maglione <gmaglione@redhat.com>
>> Cc: Liu Jiang <gerry@linux.alibaba.com>
>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>> hw/virtio/vhost-user.c | 66 +++++++++-----------
>> 1 file changed, 28 insertions(+), 38 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 64eac317bfb2..36f99b66a644 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -1320,10 +1320,35 @@ static int enforce_reply(struct vhost_dev *dev,
>>     return vhost_user_get_features(dev, &dummy);
>> }
>>
>> +/* Note: "msg->hdr.flags" may be modified. */
>> +static int vhost_user_write_msg(struct vhost_dev *dev, VhostUserMsg
>> *msg,
>> +                                bool wait_for_reply)
> 
> The difference between vhost_user_write() and vhost_user_write_msg() is
> not immediately obvious from the function name, so I would propose
> something different, like vhost_user_write_sync() or
> vhost_user_write_wait().

I'm mostly OK with either variant; I think I may have thought of _sync
myself, but didn't like it because the wait would be *optional*,
dependent on caller choice. And I didn't like
vhost_user_write_maybe_wait() either; that one seemed awkward / too verbose.

Let's see what others prefer. :)

> 
> Anyway, I'm not good with names and don't have a strong opinion, so this
> version is fine with me as well :-)
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 

Thanks!


