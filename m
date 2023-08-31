Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6AD78E709
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:15:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbbt4-0000EF-7U; Thu, 31 Aug 2023 03:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbbt0-0000CG-Ho
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:14:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbbsy-0001jC-04
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693466074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJJighe1aMiLVlefMWnyEOG4K3n7cJWXdy3bai6re34=;
 b=MLOlL7C5wEZ4gd99SYRwR9rBagwxqyCDXh3QHJj5t1IJqKYiC4/JgKXTXh8pmt0MI1eTAL
 2CMHXThm/v5lJJ3q6EKnO5te/x4ngnpKqDBar2DX0to0J5yusM662co9tp34y6I6s2zTQl
 nR/0brHGGYDBceaytzDmROF1iD6IN8U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-0lLt2bNXMSCwmif_S-6-1g-1; Thu, 31 Aug 2023 03:14:31 -0400
X-MC-Unique: 0lLt2bNXMSCwmif_S-6-1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DEEC3811F50;
 Thu, 31 Aug 2023 07:14:31 +0000 (UTC)
Received: from [10.39.193.141] (unknown [10.39.193.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC52F2166B25;
 Thu, 31 Aug 2023 07:14:29 +0000 (UTC)
Message-ID: <a6fe707c-b110-b34d-bb48-46e4e4a3606d@redhat.com>
Date: Thu, 31 Aug 2023 09:14:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/7] vhost-user: tighten "reply_supported" scope in
 "set_vring_addr"
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230830134055.106812-1-lersek@redhat.com>
 <20230830134055.106812-3-lersek@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20230830134055.106812-3-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On 8/30/23 15:40, Laszlo Ersek wrote:
> In the vhost_user_set_vring_addr() function, we calculate
> "reply_supported" unconditionally, even though we'll only need it if
> "wait_for_reply" is also true.
> 
> Restrict the scope of "reply_supported" to the minimum.
> 
> This is purely refactoring -- no observable change.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Liu Jiang <gerry@linux.alibaba.com>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> 
> Notes:
>     v2:
>     
>     - pick up Stefano's R-b
> 
>  hw/virtio/vhost-user.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

identical to v1, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

from
<http://mid.mail-archive.com/6c12069e-da31-9758-4972-7121ab5ffdee@linaro.org>.

Laszlo

> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index b4b677c1ce66..64eac317bfb2 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1331,17 +1331,18 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
>          .hdr.size = sizeof(msg.payload.addr),
>      };
>  
> -    bool reply_supported = virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
> -
>      /*
>       * wait for a reply if logging is enabled to make sure
>       * backend is actually logging changes
>       */
>      bool wait_for_reply = addr->flags & (1 << VHOST_VRING_F_LOG);
>  
> -    if (reply_supported && wait_for_reply) {
> -        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> +    if (wait_for_reply) {
> +        bool reply_supported = virtio_has_feature(dev->protocol_features,
> +                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
> +        if (reply_supported) {
> +            msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> +        }
>      }
>  
>      ret = vhost_user_write(dev, &msg, NULL, 0);
> 


