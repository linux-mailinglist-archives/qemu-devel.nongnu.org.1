Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0012E7B5562
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:42:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnK7j-00008H-2k; Mon, 02 Oct 2023 10:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnK7e-0008W5-7s
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnK7P-0001PA-3H
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696257713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xcwJ0WHxs3HcvGlWRXFcZ/HNFTvgsbEjrmN6cuOHk9E=;
 b=Wj3rfiGeAXB6CAmZsLJjj0UrlnvyX7717lvvA5ecNQD1oMnKcwzbBZJTR9wELfrxvSxLD4
 Chw9m28qk3I9Eo0uEwO0GIe7kj1B6/NI9tbLrB5qtOtGuQZr7dmvq95mreE2sYyPsvMend
 1Qovx+8ieXPCXO0WHgpeRU3NmmiGWEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-wEYW5_mOPhSXirvxU5BlpA-1; Mon, 02 Oct 2023 10:41:52 -0400
X-MC-Unique: wEYW5_mOPhSXirvxU5BlpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7E2B1818E4E;
 Mon,  2 Oct 2023 14:41:51 +0000 (UTC)
Received: from [10.39.194.43] (unknown [10.39.194.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7036140E950;
 Mon,  2 Oct 2023 14:41:50 +0000 (UTC)
Message-ID: <13a03916-b4a3-253e-011d-12b9bfab9fe3@redhat.com>
Date: Mon, 2 Oct 2023 16:41:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/5] hw: remove needless includes
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-2-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231002111154.1002655-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> The include list is large, make it smaller.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/machine.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index cb38b8cf4c..68cb556197 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -11,32 +11,22 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/option.h"
>  #include "qemu/accel.h"
>  #include "sysemu/replay.h"
> -#include "qemu/units.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-visit-common.h"
>  #include "qapi/qapi-visit-machine.h"
> -#include "qapi/visitor.h"
>  #include "qom/object_interfaces.h"
> -#include "hw/sysbus.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
> -#include "sysemu/numa.h"
>  #include "sysemu/xen.h"
> -#include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> -#include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
>  #include "migration/global_state.h"
> -#include "migration/vmstate.h"
>  #include "exec/confidential-guest-support.h"
> -#include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
>  

Acked-by: Laszlo Ersek <lersek@redhat.com>


