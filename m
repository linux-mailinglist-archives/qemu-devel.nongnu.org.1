Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 354A272FEF8
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:46:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9PkX-0002FX-I5; Wed, 14 Jun 2023 08:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q9PkV-0002FE-D3
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q9PkT-0002FS-IH
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686746233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN2CjyMQXVXDhLmrfqDCTfKnhRpyeY8B4+BNkaAIqxE=;
 b=ECo8rNACBfkgYJxsalNj/xUCcU0KRX4FTp4Lm+ejXjtGCu1TIUSe0UKGLXvrLMmywOGIhO
 ZMoa8FlTkFSpl4Lu8q0nmxloKcCdgUk3AuxEKJ7vHX9uScsSFZC1Uzh0jbkSPngAaoPlR/
 S6to5Ll8NnJfSaB8fmMN4DNMG5DTXYM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-ml0ddOYLPd-zl0qJFlTubQ-1; Wed, 14 Jun 2023 08:37:12 -0400
X-MC-Unique: ml0ddOYLPd-zl0qJFlTubQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7607b00a93eso287902085a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 05:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686746231; x=1689338231;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HN2CjyMQXVXDhLmrfqDCTfKnhRpyeY8B4+BNkaAIqxE=;
 b=HYFrIC+F6IKKQrIt2FMwiWD9Lipvzc7nyKrvTjxnlUQBkZhZ0fXBcuIELt18UyVUHl
 P15W+KSyEmCF0XgxkDOwUWdlhnBy2zkrEsMLRhxfk076rJPbfi++rDAoU8NKwPXSBVNd
 fI8zOkGOp5G+uyYoBc2zHiv8c6t9iAnNcHEheE3h2hF04dns4Gehi+XU0o3uBOqLQO5t
 /1dVQalFA5RbNmG3FbinqCRuONib+s+G7rI4OgfEucuqT41c3/0Ig6Mop8oqXLZso04K
 kpL4TEqi2s/hrcOWBdRaJAaTk+jTrDrKBtdFOqSLtMaj0tMwkLBMruzeVIRZTzsDSvOo
 WDGQ==
X-Gm-Message-State: AC+VfDwpvDIDwlzhEbsFUM3uKksihcD1GF9mOE5mNMxZARSxgN0KxNRS
 +kGfzTh5jxaLK3FeDfQFCkDdvDC61mk4pK7RoU97IxuY3q6XDDcW71Nw79IrzUYmRKL9u1hkJSr
 Pm/qrONls4sWYFhqUQZi3JTE=
X-Received: by 2002:a05:620a:24ca:b0:75e:c383:18a1 with SMTP id
 m10-20020a05620a24ca00b0075ec38318a1mr20323763qkn.7.1686746231489; 
 Wed, 14 Jun 2023 05:37:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FfnvAH+LCQAZcQISqO+5JZ22cBI52A7XgqzgnJueEAo/dyRQFbTVwuduZevw0f7otN7VOtw==
X-Received: by 2002:a05:620a:24ca:b0:75e:c383:18a1 with SMTP id
 m10-20020a05620a24ca00b0075ec38318a1mr20323747qkn.7.1686746231217; 
 Wed, 14 Jun 2023 05:37:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a05620a01f000b0075783f6c2b4sm4241928qkn.128.2023.06.14.05.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 05:37:10 -0700 (PDT)
Message-ID: <41b86f7c-6d9d-8e05-fb26-2b613dca9c4a@redhat.com>
Date: Wed, 14 Jun 2023 14:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] hw/vfio/pci-quirks: Support alternate offset for
 GPUDirect Cliques
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20230608174211.3227138-1-alex.williamson@redhat.com>
 <20230608180507.3229259-1-alex.williamson@redhat.com>
 <a44455cc-1eca-c50d-9394-8faab699c804@redhat.com>
 <20230612090511.17ac3557.alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230612090511.17ac3557.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/12/23 17:05, Alex Williamson wrote:
> On Mon, 12 Jun 2023 16:07:33 +0200
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> On 6/8/23 20:05, Alex Williamson wrote:
>>> NVIDIA Turing and newer GPUs implement the MSI-X capability at the offset
>>> previously reserved for use by hypervisors to implement the GPUDirect
>>> Cliques capability.  A revised specification provides an alternate
>>> location.  Add a config space walk to the quirk to check for conflicts,
>>> allowing us to fall back to the new location or generate an error at the
>>> quirk setup rather than when the real conflicting capability is added
>>> should there be no available location.
>>>
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>>    hw/vfio/pci-quirks.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 40 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>>> index f0147a050aaa..0ed2fcd53152 100644
>>> --- a/hw/vfio/pci-quirks.c
>>> +++ b/hw/vfio/pci-quirks.c
>>> @@ -1490,6 +1490,9 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev)
>>>     * +---------------------------------+---------------------------------+
>>>     *
>>>     * https://lists.gnu.org/archive/html/qemu-devel/2017-08/pdfUda5iEpgOS.pdf
>>> + *
>>> + * Specification for Turning and later GPU architectures:
>>
>> s/Turning/Turing/
>>
>> I will fix that.
> 
> Yes, thanks!
>   
>>> + * https://lists.gnu.org/archive/html/qemu-devel/2023-06/pdf142OR4O4c2.pdf
>>>     */
>>>    static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
>>>                                           const char *name, void *opaque,
>>> @@ -1530,7 +1533,9 @@ const PropertyInfo qdev_prop_nv_gpudirect_clique = {
>>>    static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>>>    {
>>>        PCIDevice *pdev = &vdev->pdev;
>>> -    int ret, pos = 0xC8;
>>> +    int ret, pos;
>>> +    bool c8_conflict = false, d4_conflict = false;
>>> +    uint8_t tmp;
>>>    
>>>        if (vdev->nv_gpudirect_clique == 0xFF) {
>>>            return 0;
>>> @@ -1547,6 +1552,40 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>>>            return -EINVAL;
>>>        }
>>>    
>>> +    /*
>>> +     * Per the updated specification above, it's recommended to use offset
>>> +     * D4h for Turing and later GPU architectures due to a conflict of the
>>> +     * MSI-X capability at C8h.  We don't know how to determine the GPU
>>
>> There is a way :
>>
>>     # nvidia-smi -q | grep Architecture
>>         Product Architecture                  : Turing
> 
> There are a few problems with that:
> 
>   1) nvidia-smi is a proprietary tool.
> 
>   2) Using nvidia-smi, or even the PCI IDs database, would require
>      ongoing maintenance to update the string or IDs for future
>      architectures.
> 
>   3) nvidia-smi requires the device to be managed by the nvidia driver,
>      which becomes and chicken and egg problem when we require the
>      device to be managed by a vfio compatible driver by this point.

For my education, could such information be exposed in a PCI vendor
specific capability ? May be it is ?

Thanks,

C.


> 
>> but it must be vendor specific and the proposed solution is as good.
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks!
> 
> Alex
> 
>>> +     * architecture, instead we walk the capability chain to mark conflicts
>>> +     * and choose one or error based on the result.
>>> +     *
>>> +     * NB. Cap list head in pdev->config is already cleared, read from device.
>>> +     */
>>> +    ret = pread(vdev->vbasedev.fd, &tmp, 1,
>>> +                vdev->config_offset + PCI_CAPABILITY_LIST);
>>> +    if (ret != 1 || !tmp) {
>>> +        error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting cap list");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    do {
>>> +        if (tmp == 0xC8) {
>>> +            c8_conflict = true;
>>> +        } else if (tmp == 0xD4) {
>>> +            d4_conflict = true;
>>> +        }
>>> +        tmp = pdev->config[tmp + PCI_CAP_LIST_NEXT];
>>> +    } while (tmp);
>>> +
>>> +    if (!c8_conflict) {
>>> +        pos = 0xC8;
>>> +    } else if (!d4_conflict) {
>>> +        pos = 0xD4;
>>> +    } else {
>>> +        error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid config space");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>        ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, 8, errp);
>>>        if (ret < 0) {
>>>            error_prepend(errp, "Failed to add NVIDIA GPUDirect cap: ");
>>
> 


