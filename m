Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7797B7B1C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:06:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxoW-0003Zc-Nr; Wed, 04 Oct 2023 05:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxo9-0003U0-Sy
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxo8-0004Xz-4I
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696410279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T81o7u6roDikZ5081lQAPabhuuZXQf4PW3FoSRj/fyI=;
 b=Y9SM38Tfx2dFXLBn7lXAftBQc0yFBMm90172EN7LniCTN2sph+zt0tP9YXol/Mjfz+qHxl
 k+jl/XG8dXWSK3xPtGBuhzAdykklYMsNYytWpz+jm4X4nLDKhjjMxiEgisKMB6uT4v3Xt+
 nT3vWLBXnDkqmgvJI0CVBpyCJ1rUqxw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-86WzQm_bMzeGSBxBGZGyVw-1; Wed, 04 Oct 2023 05:04:38 -0400
X-MC-Unique: 86WzQm_bMzeGSBxBGZGyVw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32339eee4c4so1433790f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696410276; x=1697015076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T81o7u6roDikZ5081lQAPabhuuZXQf4PW3FoSRj/fyI=;
 b=r+2vccdD1iGxI3dUlT5ONZ1QR5w2vLWpyA9BA63UK6oYdxJE5raZ9gvJkc6L8V84XZ
 HT3K7vxpcZz/gSVMYGIhrU7mpAD41xW9VD2BKEoE9PRVbavo86zmqqy0FcgeUWY9e04/
 5fUYsWmzhQd7Z0XhI5S1W9jITH++9duXZorqBshewy6TAM+aqHku77w2YbwCxQT4BXRt
 u2YbGvZ+Cr/z6w64TZpWtftyd+TUd+i7A2xY7mmeqKG5bSlLcTf2KRd0iqbsqRCq0EUe
 ETuOkmL0B8cZB/tuiriZb7E9BUsWj2/v4Ccmbqufm5GgCUVwqvKrg+0n97TDTJfsP2c+
 ATNw==
X-Gm-Message-State: AOJu0Yw5bu5RxzVdUqCwizuV4TTn2i20g705orLlH1+O0RbCHpuMvRPy
 hLhFtAUqWcrS7ohkEahH9W3B5ICvSOBqYuHMAAlUG580I9CYtJ7ZfBMneKhDHq0sYATHFa6UNeu
 1DujVPOnfbFeCw/8gnZGh/M4=
X-Received: by 2002:adf:fd46:0:b0:326:d915:d1c0 with SMTP id
 h6-20020adffd46000000b00326d915d1c0mr1523499wrs.56.1696410276544; 
 Wed, 04 Oct 2023 02:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXDHzAFvi4HF4IACUBVzNE77xngOMGptwBEIPi9Uz6ff3bomvgHzMKZB1NiJClodmZiva4XQ==
X-Received: by 2002:adf:fd46:0:b0:326:d915:d1c0 with SMTP id
 h6-20020adffd46000000b00326d915d1c0mr1523474wrs.56.1696410276115; 
 Wed, 04 Oct 2023 02:04:36 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 a8-20020a5d4d48000000b00324ae863ac1sm3473195wru.35.2023.10.04.02.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 02:04:35 -0700 (PDT)
Date: Wed, 4 Oct 2023 05:04:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 linuxarm@huawei.com
Subject: Re: [PATCH v2 2/3] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <20231004045943-mutt-send-email-mst@kernel.org>
References: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
 <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
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

On Mon, Sep 04, 2023 at 05:18:46PM +0100, Jonathan Cameron wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
> ID value of 0 in all cases. The enabling is for _DSM plumbing testing
> from the OS.
> 
> Following edited for readbility only
> 
> Device (CXLM)
> {
>     Name (_HID, "ACPI0017")  // _HID: Hardware ID
> ...
>     Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>     {
>         If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
>         {
>             If ((Arg2 == Zero))
>             {
>                 Return (Buffer (One) { 0x01 })
>             }
> 
>             If ((Arg2 == One))
>             {
>                 Return (Package (0x02)
>                 {
>                     Buffer (0x02)
>                     { 0x01, 0x00 },
>                     Package (0x01)
>                     {
>                         Buffer (0x02)
>                         { 0x00, 0x00 }
>                     }
>                 })
>             }
>         }
>     }
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --
> v2: Minor edit to drop reference to switches in patch description.
> ---

>  include/hw/acpi/cxl.h |  1 +
>  hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c  |  1 +
>  3 files changed, 59 insertions(+)


This is not the right way to format it. The correct way is:

---
v2: Minor edit to drop reference to switches in patch description.

 include/hw/acpi/cxl.h |  1 +
 hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  |  1 +
 3 files changed, 59 insertions(+)

The way you do it breaks b4 and a bunch of other tools.  signatures must
come last before ---, then versioning info (which generally does not
need to be in git because readers of git have no access to older
versions, though there could be exceptions. If there's anything relevant
in this versioning history, such as some design directions which were
tried and discarded, then put it above ---). Then the diff.


> 
> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> index acf4418886..8f22c71530 100644
> --- a/include/hw/acpi/cxl.h
> +++ b/include/hw/acpi/cxl.h
> @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
>                      BIOSLinker *linker, const char *oem_id,
>                      const char *oem_table_id, CXLState *cxl_state);
>  void build_cxl_osc_method(Aml *dev);
> +void build_cxl_dsm_method(Aml *dev);
>  
>  #endif
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index 92b46bc932..5e9039785a 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -30,6 +30,63 @@
>  #include "qapi/error.h"
>  #include "qemu/uuid.h"
>  
> +void build_cxl_dsm_method(Aml *dev)
> +{
> +    Aml *method, *ifctx, *ifctx2;
> +
> +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> +    {
> +        Aml *function, *uuid;
> +
> +        uuid = aml_arg(0);
> +        function = aml_arg(2);
> +        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
> +        ifctx = aml_if(aml_equal(
> +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
> +
> +        /* Function 0, standard DSM query function */
> +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
> +        {
> +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
> +
> +            aml_append(ifctx2,
> +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
> +        }
> +        aml_append(ifctx, ifctx2);
> +
> +        /*
> +         * Function 1
> +         * A return value of {1, {0}} inciate that
> +         * max supported QTG ID of 1 and recommended QTG is 0.
> +         * The values here are faked to simplify emulation.
> +         */
> +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
> +        {
> +            uint16_t word_list[1] = { 0x01 };
> +            uint16_t word_list2[1] = { 0 };
> +            uint8_t *byte_list = (uint8_t *)word_list;
> +            uint8_t *byte_list2 = (uint8_t *)word_list2;
> +            Aml *pak, *pak1;
> +
> +            /*
> +             * The return package is a package of a WORD and another package.
> +             * The embedded package contains 0 or more WORDs for the
> +             * recommended QTG IDs.
> +             */
> +            pak1 = aml_package(1);
> +            aml_append(pak1, aml_buffer(sizeof(uint16_t), byte_list2));
> +            pak = aml_package(2);
> +            aml_append(pak, aml_buffer(sizeof(uint16_t), byte_list));
> +            aml_append(pak, pak1);
> +
> +            aml_append(ifctx2, aml_return(pak));
> +        }
> +        aml_append(ifctx, ifctx2);
> +    }
> +    aml_append(method, ifctx);
> +    aml_append(dev, method);
> +}
> +
>  static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
>  {
>      PXBDev *pxb = PXB_DEV(cxl);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index bb12b0ad43..d3bc5875eb 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1422,6 +1422,7 @@ static void build_acpi0017(Aml *table)
>      method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>      aml_append(method, aml_return(aml_int(0x01)));
>      aml_append(dev, method);
> +    build_cxl_dsm_method(dev);
>  
>      aml_append(scope, dev);
>      aml_append(table, scope);
> -- 
> 2.39.2


