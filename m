Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A31F67B65E9
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 11:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnc3M-0002w1-09; Tue, 03 Oct 2023 05:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnc3B-0002pK-Ih
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 05:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnc38-00008u-Hs
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 05:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696326626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCNBLwpnPmiLh1gLqj+wQdcDxy37fiyjSOK51cxe0PY=;
 b=WmAEpcNuuPf8GvuoRiv37rpc5H/ImGtlldamZ2mzXl9/pVkzgjwzPfXGWtEu2uZLAoDTWv
 QyhaDWW5CjSym/FKcEhYBB2tRZHgTD6DS0MW7Y2if3qAIBl/qG8uakyNOARlnMTcmHoKM8
 /iS3z7i9CMyXeyS0nw1WirkVdWoKL5s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-EwZKTfSGMbmFptsBuf3-kQ-1; Tue, 03 Oct 2023 05:50:22 -0400
X-MC-Unique: EwZKTfSGMbmFptsBuf3-kQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78EED1019C8C;
 Tue,  3 Oct 2023 09:50:21 +0000 (UTC)
Received: from [10.39.192.186] (unknown [10.39.192.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9317400E89;
 Tue,  3 Oct 2023 09:50:19 +0000 (UTC)
Message-ID: <c729f272-23a5-cc08-5ab2-7bc0d900b5f9@redhat.com>
Date: Tue, 3 Oct 2023 11:50:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/5] ramfb-standalone: add migration support
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, kraxel@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
 <20231003085644.1220326-5-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231003085644.1220326-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On 10/3/23 10:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Add a "ramfb-dev" section whenever "x-migrate" is turned on. Turn it off
> by default on machines <= 8.1 for compatibility reasons.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/machine.c             |  4 +++-
>  hw/display/ramfb-standalone.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index df40f10dfa..47a07d1d9b 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -30,7 +30,9 @@
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
>  
> -GlobalProperty hw_compat_8_1[] = {};
> +GlobalProperty hw_compat_8_1[] = {
> +    { "ramfb", "x-migrate", "off" },
> +};
>  const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>  
>  GlobalProperty hw_compat_8_0[] = {
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index 8c0094397f..a96e7ebcd9 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -1,4 +1,5 @@
>  #include "qemu/osdep.h"
> +#include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "hw/loader.h"
> @@ -15,6 +16,7 @@ struct RAMFBStandaloneState {
>      SysBusDevice parent_obj;
>      QemuConsole *con;
>      RAMFBState *state;
> +    bool migrate;
>  };
>  
>  static void display_update_wrapper(void *dev)
> @@ -40,14 +42,39 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
>      ramfb->state = ramfb_setup(errp);
>  }
>  
> +static bool migrate_needed(void *opaque)
> +{
> +    RAMFBStandaloneState *ramfb = RAMFB(opaque);
> +
> +    return ramfb->migrate;
> +}
> +
> +static const VMStateDescription ramfb_dev_vmstate = {
> +    .name = "ramfb-dev",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = migrate_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT_POINTER(state, RAMFBStandaloneState, ramfb_vmstate, RAMFBState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static Property ramfb_properties[] = {
> +    DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void ramfb_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    dc->vmsd = &ramfb_dev_vmstate;
>      dc->realize = ramfb_realizefn;
>      dc->desc = "ram framebuffer standalone device";
>      dc->user_creatable = true;
> +    device_class_set_props(dc, ramfb_properties);
>  }
>  
>  static const TypeInfo ramfb_info = {

This patch (and patch #3) is *exactly* what I had in mind, when I was
racking my brain about RHBZ 1859424 a week (or a few weeks?) ago.
Specifically the VMSTATE_STRUCT_POINTER + VMSTATE_BUFFER_UNSAFE chain.

That's not to say I could have *completed* the patch myself, of course.
:) (From the many things, I didn't know that it was
VMSTATE_BUFFER_UNSAFE that we'd need -- but I certainly thought of
VMSTATE_STRUCT_POINTER for the higher-level devices.)

It's interesting that we don't have to do this in a "subsection" here --
this device used to have no VMStateDescription at all!

FWIW (patches #3 and #4):

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Laszlo


