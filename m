Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 954FD81B01B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:16:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGECq-0004IR-6T; Thu, 21 Dec 2023 03:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGECf-0004GK-RN
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGECe-0006Vl-60
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703146486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLUbq2t+UOwXRF5rqqfNBfoW7xf+NBnH3GttdN0Xe4M=;
 b=ZFecfQhunmGGIzX6Xg5LJbyBwC3UFY6wV5AIlhkDU3EgvCkCz4oR37R2X5JsQCncWT9SJo
 NBbol3rBI2w6U37UZ0nrr8xQD6eCfESR7HulUMxg2zXFqmSg0U+PZLLAp2+HwoYfJpnGJT
 OjIGJEQYaneMn+QjjCn11f0CUn37nXw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-ry1OvdgqNEqLqGV9WBJUTQ-1; Thu, 21 Dec 2023 03:14:44 -0500
X-MC-Unique: ry1OvdgqNEqLqGV9WBJUTQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-781146b7adfso70466685a.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 00:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703146483; x=1703751283;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YLUbq2t+UOwXRF5rqqfNBfoW7xf+NBnH3GttdN0Xe4M=;
 b=goXrEL9kNcD5EKM9ryAdWA4B4oRKHL+WnKqlENz2vjuTUiKbRcrO853Ko6ed7DHq4X
 qMHh4TpmwArReJU1JuBfszKmQyFmxjlaTd7b6waFodhpSGwYyxRmqiLX3FWeUyG6XJmP
 ijVCq3aEvEhjffq9Om/UBzkFZjMtmDdQAabWjVoKj265+n3GgqqEVXrQRL2Uu4YRgTsx
 UGcAlKxDnnA/TJI9u8YlCE5EilIXUg4UifbOfaeyWnGjHz9flmo9urA/wIU3/q+QC1g8
 tBrRKWkrIBmCoaYsI988tthRsHI0ql+/OUg+tIeV2XR+Td01BhVS2F0zKfDiSaubbRu5
 PIDw==
X-Gm-Message-State: AOJu0Ywun0+CNICUojxBlY5l/uW4ONotq0iv1xjYHlr93hls3qD6KNWs
 iGmxWurBYnfA6ir6jhlvhrlUweFe8uKseIwTjXH8XSvwiHHQSwSgDUR4+JuY3q8Lw9m4tRjNV6A
 2imQDrtXLiXODJo3bpqiOxOo=
X-Received: by 2002:ad4:5bc7:0:b0:67f:195d:cc62 with SMTP id
 t7-20020ad45bc7000000b0067f195dcc62mr17133736qvt.84.1703146483433; 
 Thu, 21 Dec 2023 00:14:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZq1UgTENlfpfT370v5JPJn7WwZ468Dh4rWl3I4sqMzjJ3rmO6bMzuEmEZYREIbDVNJfb0kA==
X-Received: by 2002:ad4:5bc7:0:b0:67f:195d:cc62 with SMTP id
 t7-20020ad45bc7000000b0067f195dcc62mr17133733qvt.84.1703146483193; 
 Thu, 21 Dec 2023 00:14:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a0cebcd000000b0067f610329a8sm483126qvq.31.2023.12.21.00.14.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 00:14:42 -0800 (PST)
Message-ID: <b01d196e-4a5e-4281-a5dc-c4ea6d5bb81c@redhat.com>
Date: Thu, 21 Dec 2023 09:14:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 59/71] hw/vfio: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231221031652.119827-1-richard.henderson@linaro.org>
 <20231221031652.119827-60-richard.henderson@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231221031652.119827-60-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/21/23 04:16, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

I suppose you will include the patch in :

   https://lore.kernel.org/qemu-devel/20231221031652.119827-1-richard.henderson@linaro.org/


Thanks,

C.



> ---
>   hw/vfio/display.c | 2 +-
>   hw/vfio/pci.c     | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 7a10fa8604..1aa440c663 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -560,7 +560,7 @@ const VMStateDescription vfio_display_vmstate = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .needed = migrate_needed,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAMFBState),
>           VMSTATE_END_OF_LIST(),
>       }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1874ec1aba..9f838978be 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2561,7 +2561,7 @@ const VMStateDescription vmstate_vfio_display = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .needed = vfio_display_migration_needed,
> -    .fields = (VMStateField[]){
> +    .fields = (const VMStateField[]){
>           VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstate,
>                                  VFIODisplay),
>           VMSTATE_END_OF_LIST()
> @@ -2572,12 +2572,12 @@ const VMStateDescription vmstate_vfio_pci_config = {
>       .name = "VFIOPCIDevice",
>       .version_id = 1,
>       .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>           VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>           VMSTATE_END_OF_LIST()
>       },
> -    .subsections = (const VMStateDescription * []) {
> +    .subsections = (const VMStateDescription * const []) {
>           &vmstate_vfio_display,
>           NULL
>       }


