Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1FA7B7CDC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:09:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnyoS-00077F-By; Wed, 04 Oct 2023 06:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnyoQ-00074E-CN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnyoO-0002wt-LN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696414138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zp8Vx8qLtKCkz9R7nfpvZ9c8UyyzNXafq7mH9o03QVc=;
 b=RMwX2xMvzuEzTUDZE3HZ9nG3nQJbtD11KIAcnEJG0N5v2WWOxlz8qlJrgDfMocts9vUoDQ
 PCV0Ssw66Bpxse9R5qq1tirEVTj2erZvwTuhY9bVtyk3somcFUw6bKah8s4+0j+sSteUrS
 KSdDnf1BHeuS3KA0JoLNEn8Zd4UYfZo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-Oi7WJngzMj-RPviSRmQbTQ-1; Wed, 04 Oct 2023 06:08:54 -0400
X-MC-Unique: Oi7WJngzMj-RPviSRmQbTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 786501C068CE;
 Wed,  4 Oct 2023 10:08:54 +0000 (UTC)
Received: from [10.39.195.2] (unknown [10.39.195.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48A7010CD7C3;
 Wed,  4 Oct 2023 10:08:53 +0000 (UTC)
Message-ID: <5f265558-71ae-7371-9fbb-dd0cfe1c69fd@redhat.com>
Date: Wed, 4 Oct 2023 12:08:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/7] vhost-user: strip superfluous whitespace
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20231002203221.17241-1-lersek@redhat.com>
 <20231002203221.17241-2-lersek@redhat.com>
 <20231004050519-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231004050519-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

On 10/4/23 11:06, Michael S. Tsirkin wrote:
> On Mon, Oct 02, 2023 at 10:32:15PM +0200, Laszlo Ersek wrote:
>> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> 
> why the (supporter:vhost) part? not all scripts will cope
> well with text after the mail. If you really want to keep
> it around, I think you should add a hash tag # before that -
> more tools know to ignore that.

It looked too tiresome to strip all these comments, plus I expected
that, if the get_maintainer.pl script output these lines, they were fit
for inclusion in "Cc:" tags in the commit message.

If they're not, then the tool should indeed insert a # in-between, or
else provide the explanation for each name+email printed on separate
(preceding) lines, potentially prefixed with "#". That makes for easy
human reading and also for easy machine reading (filtering them out).

Laszlo

> 
> 
>> Cc: Eugenio Perez Martin <eperezma@redhat.com>
>> Cc: German Maglione <gmaglione@redhat.com>
>> Cc: Liu Jiang <gerry@linux.alibaba.com>
>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Albert Esteve <aesteve@redhat.com>
>> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>> ---
>>
>> Notes:
>>     v3:
>>     
>>     - pick up R-b from Phil and Eugenio, T-b from Albert
>>     
>>     v2:
>>     
>>     - pick up Stefano's R-b
>>
>>  hw/virtio/vhost-user.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 8dcf049d422b..b4b677c1ce66 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -398,7 +398,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
>>       * operations such as configuring device memory mappings or issuing device
>>       * resets, which affect the whole device instead of individual VQs,
>>       * vhost-user messages should only be sent once.
>> -     * 
>> +     *
>>       * Devices with multiple vhost_devs are given an associated dev->vq_index
>>       * so per_device requests are only sent if vq_index is 0.
>>       */
>>
> 


