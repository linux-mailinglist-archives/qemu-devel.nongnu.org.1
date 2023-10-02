Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0697B555E
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:42:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnK7N-0008CY-Ou; Mon, 02 Oct 2023 10:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnK7M-0008CQ-D7
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnK79-0001O0-TO
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696257698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZfNAZk/9T3QTQgqBKK0JW0B7ZXLB3sjejTmp7bFb/c=;
 b=Azl7iM0+yOVIQxdyWuYT/Cuxgwt9YKj3ibjfOOxG1fbazd6AfgsR86z9qXzcoYRSoYn+Pp
 EchH6U7/L92rtpCjjEbgtXcDhpx+LzQM7lBLXvMVoybkWqrhst28VlbL7hyOCnKDVADBS4
 Ug7K/o161RqJn6kEDAWebjrYJ+woMdM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-jCFyHzPBM2a1n_ydXhrkTQ-1; Mon, 02 Oct 2023 10:41:34 -0400
X-MC-Unique: jCFyHzPBM2a1n_ydXhrkTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28BE8185A797;
 Mon,  2 Oct 2023 14:41:34 +0000 (UTC)
Received: from [10.39.194.43] (unknown [10.39.194.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB6262156701;
 Mon,  2 Oct 2023 14:41:32 +0000 (UTC)
Message-ID: <33b5425f-8e8c-5bde-99ed-41f28097e4e4@redhat.com>
Date: Mon, 2 Oct 2023 16:41:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/5] hw: turn off ramfb migration for machines <= 8.1
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-6-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231002111154.1002655-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/2/23 13:11, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> For compatibility reasons.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/machine.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 68cb556197..2fa7647422 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -30,7 +30,10 @@
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
>  
> -GlobalProperty hw_compat_8_1[] = {};
> +GlobalProperty hw_compat_8_1[] = {
> +    { "ramfb", "migrate", "off" },
> +    { "vfio-pci-nohotplug", "ramfb-migrate", "off" }
> +};
>  const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>  
>  GlobalProperty hw_compat_8_0[] = {

In the other discussion, you mentioned the concrete reason for this -- I
think if we don't do this, then the ramfb vmstate blocks backward
migration? Can you document the reason here explicitly (commit message,
I mean, doesn't have to be a code comment)?

Thanks!
Laszlo


