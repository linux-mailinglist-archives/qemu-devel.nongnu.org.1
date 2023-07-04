Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E05F746D07
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:18:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGc9u-0002En-JC; Tue, 04 Jul 2023 05:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qGc9o-0002EE-D6
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qGc9m-0002nO-PQ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688462229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UAtcpfjIhGghN+hoXzP2DX/eD2bDJw9VvAHsF2obYOk=;
 b=GiK55kl4RM/3uxQDxB3ZLfktLXW9D5czKitix9uMNeB+WPuD9cXM6EO4PPZnwhKOdPltTr
 JF3Z7lz0fJoFVmbWaImklv4P5J8KJH8CWS1Sd2j6YxIST+XhPbXrKc+QNTOctB61MWQIIJ
 R7wRhsCyJaXEw0P0zzb34us+JSWLMqQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-JT4m3KhFMMmM2X2pJEGL2A-1; Tue, 04 Jul 2023 05:17:05 -0400
X-MC-Unique: JT4m3KhFMMmM2X2pJEGL2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34C622834778;
 Tue,  4 Jul 2023 09:17:05 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 978C8492C13;
 Tue,  4 Jul 2023 09:17:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: oliver.upton@linux.dev, salil.mehta@huawei.com, james.morse@arm.com,
 gshan@redhat.com, Shaoqin Huang <shahuang@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH v1 4/5] arm/kvm: add skeleton implementation for
 userspace SMCCC call handling
In-Reply-To: <20230626064910.1787255-5-shahuang@redhat.com>
Organization: Red Hat GmbH
References: <20230626064910.1787255-1-shahuang@redhat.com>
 <20230626064910.1787255-5-shahuang@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 04 Jul 2023 11:17:03 +0200
Message-ID: <877crghw8g.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 26 2023, Shaoqin Huang <shahuang@redhat.com> wrote:

> The SMCCC call filtering provide the ability to forward the SMCCC call
> to userspace, so we provide a new option `user-smccc` to enable handling
> SMCCC call in userspace, the default value is off.
>
> And add the skeleton implementation for userspace SMCCC call
> initialization and handling.
>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  docs/system/arm/virt.rst |  4 +++
>  hw/arm/virt.c            | 21 ++++++++++++++++
>  include/hw/arm/virt.h    |  1 +
>  target/arm/kvm.c         | 54 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 80 insertions(+)
>
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index 1cab33f02e..ff43d52f04 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -155,6 +155,10 @@ dtb-randomness
>    DTB to be non-deterministic. It would be the responsibility of
>    the firmware to come up with a seed and pass it on if it wants to.
>  
> +user-smccc
> +  Set ``on``/``off`` to enable/disable handling smccc call in userspace
> +  instead of kernel.
> +
>  dtb-kaslr-seed
>    A deprecated synonym for dtb-randomness.
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9b9f7d9c68..767720321c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -42,6 +42,7 @@
>  #include "hw/vfio/vfio-amd-xgbe.h"
>  #include "hw/display/ramfb.h"
>  #include "net/net.h"
> +#include "qom/object.h"
>  #include "sysemu/device_tree.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/runstate.h"
> @@ -2511,6 +2512,19 @@ static void virt_set_oem_table_id(Object *obj, const char *value,
>      strncpy(vms->oem_table_id, value, 8);
>  }
>  
> +static bool virt_get_user_smccc(Object *obj, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    return vms->user_smccc;
> +}
> +
> +static void virt_set_user_smccc(Object *obj, bool value, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    vms->user_smccc = value;
> +}
>  
>  bool virt_is_acpi_enabled(VirtMachineState *vms)
>  {
> @@ -3155,6 +3169,13 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>                                            "in ACPI table header."
>                                            "The string may be up to 8 bytes in size");
>  
> +    object_class_property_add_bool(oc, "user-smccc",
> +                                   virt_get_user_smccc,
> +                                   virt_set_user_smccc);
> +    object_class_property_set_description(oc, "user-smccc",
> +                                          "Set on/off to enable/disable "
> +                                          "handling smccc call in userspace");
> +
>  }
>  
>  static void virt_instance_init(Object *obj)

This knob pretty much only makes sense for KVM guests, and we'll ignore
it with tcg -- would it make sense to check that we are actually using
KVM before we proceed (like we do for the tcg-only props?)


