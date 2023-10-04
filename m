Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6AC7B86E9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:46:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5x8-0005ci-75; Wed, 04 Oct 2023 13:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo5x6-0005cX-7i
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo5x3-0006Jb-PX
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696441584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jDh/brGzyB4s1Mn15sI42yXz9KpQIGpZ1IJQuQa21I=;
 b=C/7//Xg6jqiafc372N2RFQn4Ig+sjvpaDbiadQrhyL0E1CsTyXmgfH/XvnRoa0JmkVpRyf
 Q1T6oD1tvwJwHmksNkefRStsR7/IhhlaUFwqOAnSGFhM5koLLzKRZ7oUZcH1gECUMMHMKM
 pvRE7bq/m1BDDFOdtgRILQZ2wwP+Qrk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Q687kRZeMLKfTw5ghudRcA-1; Wed, 04 Oct 2023 13:46:23 -0400
X-MC-Unique: Q687kRZeMLKfTw5ghudRcA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-418099ca1c2so3049011cf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696441583; x=1697046383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6jDh/brGzyB4s1Mn15sI42yXz9KpQIGpZ1IJQuQa21I=;
 b=Ax7/0cPDjLAXOPg0iSZag7KgcL0aFI4VVGt+P3IwubvrG7oHa6pc47kTMA4TCDbrQ3
 /XUtCKa+pUNUegZ4oEwTv/cadtkTWBvr2zSirScmbd8Mlj4EUXpjvt7mnNkpps+ra9QK
 WigSqoTZA8nxzN8ThAIACnfUt+ZMpmQ5YdW+YSK24RcggIJOvnPD9L9zdlbv0GZACfmU
 xEdu3L9Hy8GLpO++0292OKXojgnMUs5r0EgAbsqYk3buQ+gOuMnVm5XXfPrZN40JSG/G
 dBzwzYJUSTm8yDIUy2ClmLqiSSsMsjJpz2a6q9zZr7h+JaO7xvmNKjlA3eiUFxMj0mVw
 4yiw==
X-Gm-Message-State: AOJu0YwcQyfL2tF//KaXk02nYk9HzGPwOMDtjm7kvkE2qq8FJLimqxrj
 tSTOCC/ldf2GEoiT0Lzpgfpab4+aK5HaE9c9YCToj4XLzdwV7Lg0toIoGMMIslnvIx4i5HUDhtq
 oiiI+x8P0faTILpI=
X-Received: by 2002:a05:622a:15c2:b0:418:d3d:30e1 with SMTP id
 d2-20020a05622a15c200b004180d3d30e1mr3662386qty.4.1696441583015; 
 Wed, 04 Oct 2023 10:46:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwb5d/AfRA7j5CU2NnYXTnBwP7ts3pHwaA1OYacYzyQStW6c/sttHH9mMb0Os56aEYWY9e0w==
X-Received: by 2002:a05:622a:15c2:b0:418:d3d:30e1 with SMTP id
 d2-20020a05622a15c200b004180d3d30e1mr3662376qty.4.1696441582778; 
 Wed, 04 Oct 2023 10:46:22 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 h23-20020ac846d7000000b004195faf1e2csm1350423qto.97.2023.10.04.10.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:46:22 -0700 (PDT)
Message-ID: <f563aba2-2261-d4e7-dbe7-92396a595ea4@redhat.com>
Date: Wed, 4 Oct 2023 19:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 33/63] hw/cxl: Add QTG _DSM support for ACPI0017 device
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Dave Jiang <dave.jiang@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1696408966.git.mst@redhat.com>
 <0bae0aebf44ac89b47ef11c5d101323dd5540951.1696408966.git.mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <0bae0aebf44ac89b47ef11c5d101323dd5540951.1696408966.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/10/2023 10.44, Michael S. Tsirkin wrote:
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
>      Name (_HID, "ACPI0017")  // _HID: Hardware ID
> ...
>      Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>      {
>          If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
>          {
>              If ((Arg2 == Zero))
>              {
>                  Return (Buffer (One) { 0x01 })
>              }
> 
>              If ((Arg2 == One))
>              {
>                  Return (Package (0x02)
>                  {
>                      Buffer (0x02)
>                      { 0x01, 0x00 },
>                      Package (0x01)
>                      {
>                          Buffer (0x02)
>                          { 0x00, 0x00 }
>                      }
>                  })
>              }
>          }
>      }
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --
> v2: Minor edit to drop reference to switches in patch description.
> Message-Id: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/hw/acpi/cxl.h |  1 +
>   hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c  |  1 +
>   3 files changed, 59 insertions(+)
> 
> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> index acf4418886..8f22c71530 100644
> --- a/include/hw/acpi/cxl.h
> +++ b/include/hw/acpi/cxl.h
> @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
>                       BIOSLinker *linker, const char *oem_id,
>                       const char *oem_table_id, CXLState *cxl_state);
>   void build_cxl_osc_method(Aml *dev);
> +void build_cxl_dsm_method(Aml *dev);
>   
>   #endif
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index 92b46bc932..5e9039785a 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -30,6 +30,63 @@
>   #include "qapi/error.h"
>   #include "qemu/uuid.h"
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

This looks fishy ... first declaring a uint16_t array in host endian order, 
then casting it to an uint8_t* byte array for code that likely expects 
little endian byte order in the guest ... I assume that this won't work and 
needs some more love for big endian hosts?

  Thomas


> +            aml_append(ifctx2, aml_return(pak));
> +        }
> +        aml_append(ifctx, ifctx2);
> +    }
> +    aml_append(method, ifctx);
> +    aml_append(dev, method);
> +}



