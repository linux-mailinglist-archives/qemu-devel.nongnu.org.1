Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E627B9A3A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFAz-00080m-Bj; Wed, 04 Oct 2023 23:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFAx-00080I-84
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFAi-0005mw-Sz
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w0KjJKQ6tTKlfhW8tx4EC92XLUKfHv/r0j5hg4HmuUY=;
 b=jUVJnFROYErFXMMbfEUod6jZY9qjNo/B6N3G1dY3j6BPnrt01itazozdn/LssLO3Ou6C2J
 8WO8s3Qw6aCt2aALREGJD3rk52CZzHIy9U/9DodFdEALV1ikm6MDGL+/VoYPd4wti7piTj
 yOeP7caGQqa5/sgaEmmHARKosFiCRM0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-FMx_9uPRO3eOUWygZaO-6g-1; Wed, 04 Oct 2023 23:37:00 -0400
X-MC-Unique: FMx_9uPRO3eOUWygZaO-6g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso459777f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477019; x=1697081819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0KjJKQ6tTKlfhW8tx4EC92XLUKfHv/r0j5hg4HmuUY=;
 b=L7uOjhr+wX7L0ysTCf5VOQzpt4YB4TuaZnR9FpX9mHQ0qruAum2AUkb7+yeuIv/0o7
 7S5xEyoeug2yVDJXDenHraf2MeqMIDvFQu3boNnCAKWz5dT5HdarLBdwdBYiKdLCRUlF
 o7qZscWVCYXAg+/z8ykva4dVeJcmtcOGCEcuj1zd5tNW9+Gh81ChAvtrsZzZd++e46B2
 uSwWq37TfriipItubK6CNMEUP1TOMIslijCP7mzTKlPMU6JfWQ3sTVUt28ZAJ/x1NvHk
 CgZBGH3U+/FG4RaiC2/0VA0oSiZ7Z8eeOlyZiwIR7kbGaKWM/jIOT9VGNcltUqtepWPb
 FbAg==
X-Gm-Message-State: AOJu0Yx3SO+4N7BMP/6g7cJ5Kup258TyjeZ0fFhb5dffB8fCkm4kYo5T
 VnfN8kV3E/94dsaZerH5xpk44w8w+E7glU0mF/IRYuUt5ExcWxzpLrMciUV52xJBo0o2Lz4BFcm
 aaDh3RoyUHa1YF04=
X-Received: by 2002:adf:fac8:0:b0:319:6c90:5274 with SMTP id
 a8-20020adffac8000000b003196c905274mr3671684wrs.30.1696477018918; 
 Wed, 04 Oct 2023 20:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoKuXgVoRz7UmZmv/oJUyOE4WHy1G/G0MVOMimexjLWb7u9knOD2ddrJV5Ez4xdmUX05Tw3w==
X-Received: by 2002:adf:fac8:0:b0:319:6c90:5274 with SMTP id
 a8-20020adffac8000000b003196c905274mr3671673wrs.30.1696477018554; 
 Wed, 04 Oct 2023 20:36:58 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 k8-20020a5d5188000000b003197869bcd7sm622435wrv.13.2023.10.04.20.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:36:57 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:36:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: thuth@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Jonathan.Cameron@huawei.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net
Subject: Re: [PATCH v3] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <20231004230132-mutt-send-email-mst@kernel.org>
References: <20231004180529-mutt-send-email-mst@kernel.org>
 <169646094762.643966.16021192876985391476.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169646094762.643966.16021192876985391476.stgit@djiang5-mobl3>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On Wed, Oct 04, 2023 at 04:09:07PM -0700, Dave Jiang wrote:
> Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
> ID value of 0 in all cases. The enabling is for _DSM plumbing testing
> from the OS.


the enabling -> this

> 
> Following edited for readbility only

readbility only -> readability


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
> v3: Fix output assignment to be BE host friendly. Fix typo in comment.
> According to the CXL spec, the DSM output should be 1 WORD to indicate
> the max suppoted QTG ID and a package of 0 or more WORDs for the QTG IDs.
> In this dummy impementation, we have first WORD with a 1 to indcate max
> supprted QTG ID of 1. And second WORD in a package to indicate the QTG
> ID of 0.
> 
> v2: Minor edit to drop reference to switches in patch description.
> Message-Id: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/acpi/cxl.c         |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c  |    1 +
>  include/hw/acpi/cxl.h |    1 +
>  3 files changed, 57 insertions(+)
> 
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index 92b46bc9323b..cce12d5bc81c 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -30,6 +30,61 @@
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
> +        /* CXL spec v3.0 9.17.3.1 *


drop this * please

>, QTG ID _DSM


this is not the name of this paragraph. pls make it match
exactly so people can search

> */
> +        ifctx = aml_if(aml_equal(
> +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
> +
> +        /* Function 0, standard DSM query function */
> +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
> +        {
> +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */

function 1?

> +
> +            aml_append(ifctx2,
> +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
> +        }
> +        aml_append(ifctx, ifctx2);
> +
> +        /*
> +         * Function 1
> +         * A return value of {1, {0}} indicates that
> +         * max supported QTG ID of 1 and recommended QTG is 0.
> +         * The values here are faked to simplify emulation.

again pls quote spec directly do not paraphrase

> +         */
> +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
> +        {
> +            uint16_t word_list = cpu_to_le16(1);
> +            uint16_t word_list2 = 0;
> +            Aml *pak, *pak1;
> +
> +            /*
> +             * The return package is a package of a WORD
> and another package.
> +             * The embedded package contains 0 or more WORDs for the
> +             * recommended QTG IDs.



pls quote the spec directly

what does "a WORD" mean is unclear - do you match what hardware does
when you use aml_buffer? pls mention this in commit log, and
show actual hardware dump for comparison.


> +             */
> +            pak1 = aml_package(1);
> +            aml_append(pak1, aml_buffer(sizeof(uint16_t), word_list2));
> +            pak = aml_package(2);
> +            aml_append(pak, aml_buffer(sizeof(uint16_t), word_list));


It does not look like this patch compiles.

So how did you test it?

Please do not post untested patches.

If you do at least minimal testing
you would also see failures in bios table test
and would follow the procedure described there to
post it.


When you post next version please also document how the patch
was tested: which guests, what tests, what were the results.

thanks!

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
> index 95199c89008a..692af40b1a75 100644
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
> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> index acf441888683..8f22c71530d8 100644
> --- a/include/hw/acpi/cxl.h
> +++ b/include/hw/acpi/cxl.h
> @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
>                      BIOSLinker *linker, const char *oem_id,
>                      const char *oem_table_id, CXLState *cxl_state);
>  void build_cxl_osc_method(Aml *dev);
> +void build_cxl_dsm_method(Aml *dev);
>  
>  #endif
> 


