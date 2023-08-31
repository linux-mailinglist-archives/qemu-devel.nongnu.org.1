Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7280178E705
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:14:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbbrk-0007tp-7s; Thu, 31 Aug 2023 03:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbbrg-0007tA-Ho
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbbrd-0001ag-Vh
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693465993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PatgOm06oEEH+r6yghFhH0iGye/QQepnx9CJYKrngA=;
 b=JDEnfO9KqI9mlOvFKuDWw5lRbME0R8XdbMacq2AcdNZKlwed/a63kL9ovXCB/72e8dhFhE
 a9byP83Rl24KCh2WzPRMxkO9CPTWL/Ix2x/aJhJJavKu0oJVPC5OuQcvwfOZrHOZ6De6Ze
 x0OoxipQB6gAKsVqWkcFIZ7NnKHzQ8M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-5rcgLYKwO2GLCP9ve2Qb2A-1; Thu, 31 Aug 2023 03:13:11 -0400
X-MC-Unique: 5rcgLYKwO2GLCP9ve2Qb2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00C973803908;
 Thu, 31 Aug 2023 07:13:11 +0000 (UTC)
Received: from [10.39.193.141] (unknown [10.39.193.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91770C15BB8;
 Thu, 31 Aug 2023 07:13:09 +0000 (UTC)
Message-ID: <ce2b4c96-8a6b-247c-14eb-b3a6c81973f0@redhat.com>
Date: Thu, 31 Aug 2023 09:13:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/7] vhost-user: strip superfluous whitespace
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230830134055.106812-1-lersek@redhat.com>
 <20230830134055.106812-2-lersek@redhat.com>
Content-Language: en-US
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20230830134055.106812-2-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
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
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This has been

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

under the (identical) v1 posting:

http://mid.mail-archive.com/cd0604a1-6826-ac6c-6c47-dcb6def64b28@linaro.org

Thanks, Phil! (and sorry that I posted v2 too quickly -- I forgot that
sometimes reviewers split a review over multiple days.)

Laszlo

> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 8dcf049d422b..b4b677c1ce66 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -398,7 +398,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
>       * operations such as configuring device memory mappings or issuing device
>       * resets, which affect the whole device instead of individual VQs,
>       * vhost-user messages should only be sent once.
> -     * 
> +     *
>       * Devices with multiple vhost_devs are given an associated dev->vq_index
>       * so per_device requests are only sent if vq_index is 0.
>       */
> 


