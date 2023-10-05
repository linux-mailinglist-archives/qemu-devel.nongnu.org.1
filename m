Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 797B87BA1EF
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:05:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoPtr-0004z5-Ms; Thu, 05 Oct 2023 11:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qoPtf-0004vI-RN
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qoPtd-0006OT-3M
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696518252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4P9r15dJ+g7RPbgoxA7XA8hIFp1GWX9GztGBopoN2sk=;
 b=hPkIa9GeThJau+XVkUfd39kZag3iKyDs+R6FaEslnEEpn6F4pkRc6VPK5TSRyf4F2CWkso
 CPBh0lxSuZFwMcZ4Xx3CYrfbknAkj5hA+vragIDnlSa8jGfroAcCPUZKyghm6pGMoUenBn
 NV8z0rPSnX6w24C9s2nsOJSidqr8XCQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-nvKuwOFDOjmZTGLmvlxAzA-1; Thu, 05 Oct 2023 11:04:11 -0400
X-MC-Unique: nvKuwOFDOjmZTGLmvlxAzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EDAE855339;
 Thu,  5 Oct 2023 15:03:48 +0000 (UTC)
Received: from [10.39.194.153] (unknown [10.39.194.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D18E2156711;
 Thu,  5 Oct 2023 15:03:46 +0000 (UTC)
Message-ID: <e3939490-a79d-9c44-0a4a-ca91c27c9bf7@redhat.com>
Date: Thu, 5 Oct 2023 17:03:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] ramfb-standalone: add migration support
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, kraxel@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20231005113027.1827078-1-marcandre.lureau@redhat.com>
 <20231005113027.1827078-3-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231005113027.1827078-3-marcandre.lureau@redhat.com>
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

On 10/5/23 13:30, marcandre.lureau@redhat.com wrote:
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
> index 281ef0dccd..e4361e3d48 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -31,7 +31,9 @@
>  #include "hw/virtio/virtio-net.h"
>  #include "audio/audio.h"
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

Identical to v3, which I reviewed, so:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


