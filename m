Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB5778D4F8
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHuN-0005d2-L9; Wed, 30 Aug 2023 05:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbHuL-0005a3-2r
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbHuI-0004KO-Td
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693389278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wi/eDvU6j804U3lCw5Vz9pX3ABCPZjwS6Y8F0yso8PQ=;
 b=MFcnlh8B2PySUjxubzMGlwyoKdiee/qA9sgyo3g9nI9rpdn52qJMxsjw3EDeb4bnUL7yhP
 Txw3AuM8kYO4N5nKO8rWsSiDni2Wz4ZKidpdlblgiTsRCAM4oiaQSfUIkXyFxK+I6XywJ+
 4CM9E+ytArmy0N5UYC+QxcOv6uR2rBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-3_oUr3QCPle-usmdKS3Z_A-1; Wed, 30 Aug 2023 05:54:36 -0400
X-MC-Unique: 3_oUr3QCPle-usmdKS3Z_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0271101A528;
 Wed, 30 Aug 2023 09:54:35 +0000 (UTC)
Received: from [10.39.192.65] (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84F136466B;
 Wed, 30 Aug 2023 09:54:34 +0000 (UTC)
Message-ID: <4d3d247c-1790-679c-0e8a-d9e742b019d2@redhat.com>
Date: Wed, 30 Aug 2023 11:54:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] vhost-user: factor out "vhost_user_write_msg"
Content-Language: en-US
From: Laszlo Ersek <lersek@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-4-lersek@redhat.com>
 <ddnrsg2yifpwtnso37ob5sw2o4ysi7ohgexq2xolgacubpytl4@2wxnq5knlbzs>
 <7d0a1750-1a2f-1201-3cff-7c8dc932b830@redhat.com>
In-Reply-To: <7d0a1750-1a2f-1201-3cff-7c8dc932b830@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On 8/30/23 11:14, Laszlo Ersek wrote:
> On 8/30/23 10:31, Stefano Garzarella wrote:
>> On Sun, Aug 27, 2023 at 08:29:33PM +0200, Laszlo Ersek wrote:
>>> The tails of the "vhost_user_set_vring_addr" and "vhost_user_set_u64"
>>> functions are now byte-for-byte identical. Factor the common tail out
>>> to a
>>> new function called "vhost_user_write_msg".
>>>
>>> This is purely refactoring -- no observable change.
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>>> Cc: Eugenio Perez Martin <eperezma@redhat.com>
>>> Cc: German Maglione <gmaglione@redhat.com>
>>> Cc: Liu Jiang <gerry@linux.alibaba.com>
>>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>> ---
>>> hw/virtio/vhost-user.c | 66 +++++++++-----------
>>> 1 file changed, 28 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>> index 64eac317bfb2..36f99b66a644 100644
>>> --- a/hw/virtio/vhost-user.c
>>> +++ b/hw/virtio/vhost-user.c
>>> @@ -1320,10 +1320,35 @@ static int enforce_reply(struct vhost_dev *dev,
>>>     return vhost_user_get_features(dev, &dummy);
>>> }
>>>
>>> +/* Note: "msg->hdr.flags" may be modified. */
>>> +static int vhost_user_write_msg(struct vhost_dev *dev, VhostUserMsg
>>> *msg,
>>> +                                bool wait_for_reply)
>>
>> The difference between vhost_user_write() and vhost_user_write_msg() is
>> not immediately obvious from the function name, so I would propose
>> something different, like vhost_user_write_sync() or
>> vhost_user_write_wait().
> 
> I'm mostly OK with either variant; I think I may have thought of _sync
> myself, but didn't like it because the wait would be *optional*,
> dependent on caller choice. And I didn't like
> vhost_user_write_maybe_wait() either; that one seemed awkward / too verbose.
> 
> Let's see what others prefer. :)

... I went with vhost_user_write_sync.

> 
>>
>> Anyway, I'm not good with names and don't have a strong opinion, so this
>> version is fine with me as well :-)
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
> 
> Thanks!


