Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6482178E71C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:20:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbbyU-0004Vt-KE; Thu, 31 Aug 2023 03:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbbyR-0004Rq-Ka
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbbyO-0003IB-UM
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693466411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZFuZh4xHtH3m5IaBiV3nypBOBeRdHRwvM/CFE7p6Xs=;
 b=S5i0N6Qmno/L4AESNiWdh+M1zVu9L0KfTASOwM/zNjrQ8bxRyG89SUsY1Aigfm/S9dGryq
 5yR1z7qgILLPjRn/6/OnWf4GIHN9pykfZuuQd3fOvjJa/WilYZFqKG09JPD3CQsk3QsIUi
 H7Gwet3Gp6rf17eWzjKSdho45w0i0yc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141--MIBpEOQOC-Q_iNsqqFUYA-1; Thu, 31 Aug 2023 03:20:05 -0400
X-MC-Unique: -MIBpEOQOC-Q_iNsqqFUYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F25E856F67;
 Thu, 31 Aug 2023 07:20:05 +0000 (UTC)
Received: from [10.39.193.141] (unknown [10.39.193.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9C5C2026D35;
 Thu, 31 Aug 2023 07:20:03 +0000 (UTC)
Message-ID: <406fe376-b432-db47-9642-04d6254faf37@redhat.com>
Date: Thu, 31 Aug 2023 09:20:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/7] vhost-user: hoist "write_sync", "get_features",
 "get_u64"
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230830134055.106812-1-lersek@redhat.com>
 <20230830134055.106812-6-lersek@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20230830134055.106812-6-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
> In order to avoid a forward-declaration for "vhost_user_write_sync" in a
> subsequent patch, hoist "vhost_user_write_sync" ->
> "vhost_user_get_features" -> "vhost_user_get_u64" just above
> "vhost_set_vring".
> 
> This is purely code movement -- no observable change.
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
>     - pick up R-b from Stefano
>     
>     - rename "vhost_user_write_msg" to "vhost_user_write_sync" (in code and
>       commit message) [Stefano]
> 
>  hw/virtio/vhost-user.c | 170 ++++++++++----------
>  1 file changed, 85 insertions(+), 85 deletions(-)

Phil reviewed v1:

http://mid.mail-archive.com/98150923-39ef-7581-6144-8d0ad8d4dd52@linaro.org

and I would've kept his R-b (similar to Stefano's) across the
vhost_user_write_msg->vhost_user_write_sync rename in v2; so I'm copying
it here:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Hope that's OK.

Laszlo

> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 4129ba72e408..c79b6f77cdca 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1083,6 +1083,91 @@ static int vhost_user_set_vring_endian(struct vhost_dev *dev,
>      return vhost_user_write(dev, &msg, NULL, 0);
>  }
>  
> +static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
> +{
> +    int ret;
> +    VhostUserMsg msg = {
> +        .hdr.request = request,
> +        .hdr.flags = VHOST_USER_VERSION,
> +    };
> +
> +    if (vhost_user_per_device_request(request) && dev->vq_index != 0) {
> +        return 0;
> +    }
> +
> +    ret = vhost_user_write(dev, &msg, NULL, 0);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = vhost_user_read(dev, &msg);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (msg.hdr.request != request) {
> +        error_report("Received unexpected msg type. Expected %d received %d",
> +                     request, msg.hdr.request);
> +        return -EPROTO;
> +    }
> +
> +    if (msg.hdr.size != sizeof(msg.payload.u64)) {
> +        error_report("Received bad msg size.");
> +        return -EPROTO;
> +    }
> +
> +    *u64 = msg.payload.u64;
> +
> +    return 0;
> +}
> +
> +static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *features)
> +{
> +    if (vhost_user_get_u64(dev, VHOST_USER_GET_FEATURES, features) < 0) {
> +        return -EPROTO;
> +    }
> +
> +    return 0;
> +}
> +
> +/* Note: "msg->hdr.flags" may be modified. */
> +static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
> +                                 bool wait_for_reply)
> +{
> +    int ret;
> +
> +    if (wait_for_reply) {
> +        bool reply_supported = virtio_has_feature(dev->protocol_features,
> +                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
> +        if (reply_supported) {
> +            msg->hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> +        }
> +    }
> +
> +    ret = vhost_user_write(dev, msg, NULL, 0);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (wait_for_reply) {
> +        uint64_t dummy;
> +
> +        if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> +            return process_message_reply(dev, msg);
> +        }
> +
> +       /*
> +        * We need to wait for a reply but the backend does not
> +        * support replies for the command we just sent.
> +        * Send VHOST_USER_GET_FEATURES which makes all backends
> +        * send a reply.
> +        */
> +        return vhost_user_get_features(dev, &dummy);
> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_set_vring(struct vhost_dev *dev,
>                             unsigned long int request,
>                             struct vhost_vring_state *ring)
> @@ -1255,91 +1340,6 @@ static int vhost_user_set_vring_err(struct vhost_dev *dev,
>      return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_ERR, file);
>  }
>  
> -static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
> -{
> -    int ret;
> -    VhostUserMsg msg = {
> -        .hdr.request = request,
> -        .hdr.flags = VHOST_USER_VERSION,
> -    };
> -
> -    if (vhost_user_per_device_request(request) && dev->vq_index != 0) {
> -        return 0;
> -    }
> -
> -    ret = vhost_user_write(dev, &msg, NULL, 0);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
> -    ret = vhost_user_read(dev, &msg);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
> -    if (msg.hdr.request != request) {
> -        error_report("Received unexpected msg type. Expected %d received %d",
> -                     request, msg.hdr.request);
> -        return -EPROTO;
> -    }
> -
> -    if (msg.hdr.size != sizeof(msg.payload.u64)) {
> -        error_report("Received bad msg size.");
> -        return -EPROTO;
> -    }
> -
> -    *u64 = msg.payload.u64;
> -
> -    return 0;
> -}
> -
> -static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *features)
> -{
> -    if (vhost_user_get_u64(dev, VHOST_USER_GET_FEATURES, features) < 0) {
> -        return -EPROTO;
> -    }
> -
> -    return 0;
> -}
> -
> -/* Note: "msg->hdr.flags" may be modified. */
> -static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
> -                                 bool wait_for_reply)
> -{
> -    int ret;
> -
> -    if (wait_for_reply) {
> -        bool reply_supported = virtio_has_feature(dev->protocol_features,
> -                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
> -        if (reply_supported) {
> -            msg->hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> -        }
> -    }
> -
> -    ret = vhost_user_write(dev, msg, NULL, 0);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
> -    if (wait_for_reply) {
> -        uint64_t dummy;
> -
> -        if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> -            return process_message_reply(dev, msg);
> -        }
> -
> -       /*
> -        * We need to wait for a reply but the backend does not
> -        * support replies for the command we just sent.
> -        * Send VHOST_USER_GET_FEATURES which makes all backends
> -        * send a reply.
> -        */
> -        return vhost_user_get_features(dev, &dummy);
> -    }
> -
> -    return 0;
> -}
> -
>  static int vhost_user_set_vring_addr(struct vhost_dev *dev,
>                                       struct vhost_vring_addr *addr)
>  {
> 


