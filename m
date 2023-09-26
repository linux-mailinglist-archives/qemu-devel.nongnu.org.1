Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0CA7AEB04
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:03:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5q2-0006e1-MN; Tue, 26 Sep 2023 07:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql5pp-0006WY-M7
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql5pn-0006im-QI
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695726148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rNBMEgzVfYe+5R3ihfL427VL9Lc9meOuBxoZ1HI6mok=;
 b=HymifnGawKrIvwMmmsNFNorz81WBtvrZKYmox/gLSo7L6AYf1M+nYi9BpcHVADLinUQhJX
 Fg53E5Ew5NxZ1f7ep1Nq0g9QbmFOwvqxr7kzodMA8VnvsJKwb9qjai/f+Z0WR1ZA8Q0vy8
 MJU6p3DxkC6q0opQyBQU5ASfkXfEqGM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-zdQXD8XkMferw3SRDWySnw-1; Tue, 26 Sep 2023 07:02:26 -0400
X-MC-Unique: zdQXD8XkMferw3SRDWySnw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c032e30083so118984111fa.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 04:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695726145; x=1696330945;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNBMEgzVfYe+5R3ihfL427VL9Lc9meOuBxoZ1HI6mok=;
 b=J4+dCMGkvNfD1Bmz12Q7y+79A+KDcfSA1ipvVvmDNfVcPSpb/nOwrDYNpF9KNaCBD9
 T3r5f2fMmnn2Ug48TWDzkiu3bl4dzmy01qyTwZ8muzyWLti+A/s4VJXR3Ry/KUZLIb7x
 RFv32w3Fr+gvvNr8lD9j+rarOFAo+plDb2jywv6uNapkHHQAeRM6p9tWFSPZm5/rnYNu
 v0cuYTntAhmo49vq3DaiTAQSKFNFn4EQ7SR/afQNTK0x3dCeNH7BSIT3otM5d0N1kQ0K
 qTnT+mqv6mHdcF2wTa+UFqgzfy5hLYlEPfLgVqeaSTPCh+g2t0Bss20ApaH/8hY9UPo2
 lNxA==
X-Gm-Message-State: AOJu0Yzj67YsdvKr4ROVr2xRWfOX3lFI+rzX5U2OTDkujrMKj9Un1plR
 WBOGNh+Cn7s7luBshtLNfitrnnE62/n7aC3r23hjXFf9jT4CnaoyBcPp4F9QOvosRG8lsITGe35
 euDg0mNIE8YvVUMs=
X-Received: by 2002:a2e:9a92:0:b0:2c0:28ca:940b with SMTP id
 p18-20020a2e9a92000000b002c028ca940bmr8648882lji.6.1695726145413; 
 Tue, 26 Sep 2023 04:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfYj+036EvhMXMAx9dwx7hX9Gew78HBVW3ZzYXDjGhDbcSeLG0UHdamJJEwmEaPWQoNKngBg==
X-Received: by 2002:a2e:9a92:0:b0:2c0:28ca:940b with SMTP id
 p18-20020a2e9a92000000b002c028ca940bmr8648865lji.6.1695726145038; 
 Tue, 26 Sep 2023 04:02:25 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 j17-20020a170906051100b0098e2969ed44sm7608267eja.45.2023.09.26.04.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 04:02:24 -0700 (PDT)
Date: Tue, 26 Sep 2023 07:02:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn
Subject: Re: [PATCH RFC V2 24/37] hw/acpi: Update ACPI GED framework to
 support vCPU Hotplug
Message-ID: <20230926070112-mutt-send-email-mst@kernel.org>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-25-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926100436.28284-25-salil.mehta@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Sep 26, 2023 at 11:04:23AM +0100, Salil Mehta wrote:
> ACPI GED shall be used to convey to the guest kernel about any CPU hot-(un)plug
> events. Therefore, existing ACPI GED framework inside QEMU needs to be enhanced
> to support CPU hotplug state and events.
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>

Co-developed with yourself?

didn't you co-develop this with xianglai li?

Just include his S.O.B then, and drop the non-standard Co-developed-by.



> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>



> ---
>  hw/acpi/generic_event_device.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index ad252e6a91..0266733a54 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -12,6 +12,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/cpu.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/irq.h"
>  #include "hw/mem/pc-dimm.h"
> @@ -239,6 +240,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>          } else {
>              acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>          }
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -253,6 +256,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
>      if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>                         !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))) {
>          acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -266,6 +271,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -277,6 +284,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
>      AcpiGedState *s = ACPI_GED(adev);
>  
>      acpi_memory_ospm_status(&s->memhp_state, list);
> +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
>  }
>  
>  static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> @@ -291,6 +299,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_PWR_DOWN_EVT;
>      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
> +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_CPU_HOTPLUG_EVT;
>      } else {
>          /* Unknown event. Return without generating interrupt. */
>          warn_report("GED: Unsupported event %d. No irq injected", ev);
> -- 
> 2.34.1


