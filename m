Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F31FD7F73DF
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:33:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6VMR-0004GX-IG; Fri, 24 Nov 2023 07:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r6VMP-0004F7-4u
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:32:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r6VMN-0000fR-Rf
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700829159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eOcomTfZBQ4nvsXW/zcq1lPG/Id869j8Lw3+l6hKWU=;
 b=aSjiv+oDFqFzrY71CelkJQZ3aRLtSOwwDK9TZ0g2ef3AykCSvTF1N9OtdthLhBSXrk4Z84
 ra6APol1KJ1tDcXQf4GVn1sjCNmpGtT+gJqebADP1R2dn2vp66sisKM0xFn5zqZk5OqnU0
 oS1JQea551+zXVG82HYbSkyarTF/nTo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-oG-DW7arPlmALjdtwudQ5w-1; Fri, 24 Nov 2023 07:32:37 -0500
X-MC-Unique: oG-DW7arPlmALjdtwudQ5w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67a16e9eedbso5670916d6.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 04:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700829156; x=1701433956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5eOcomTfZBQ4nvsXW/zcq1lPG/Id869j8Lw3+l6hKWU=;
 b=Tz1c1yhw0AFiBRkqouaBhvbguYfszQ0vFcZwTdrQFQRMZOnAhu2iY6mFw0gv+ZKiHN
 80hMnINXflfpfY94fc/VZPCew9JrqA+/C01GfzsIKVIi/MiFAAwZTDaiujpH+U8LQGBD
 X1X8jyBjkAggjSNm/ksqg/jVeq3UzxKxkKrSbs6RPic1ZJtDFqUjQFTM0LV2m9bOdTqm
 Pxy1w0Q8xrFTtMFwHEXhywVdti5fzt2XBW1SwmhLwFYaX30qwicKMbUDztDFi2C0YaTJ
 2wPTmL+efYMl1uhMSEfGx053qNV1GUhVM5v6YXYN1X4OJ3ItxVYCuutkcr7tgdCwfqtM
 4PWQ==
X-Gm-Message-State: AOJu0YxQ+44zBKBdj0D70V2kX98fEpUSj79A0qcMyGD1b2pYl8lUQKxX
 PcbJsqjFOkMgzQrebvSly/oe5g1k9QV0uVtmGTJxy/1i4RY0dkCIgADGwzJ7mLVwKXVScvffPix
 n3TBp1KSW4eBVLzQ=
X-Received: by 2002:a05:6214:5ecb:b0:67a:198c:a84 with SMTP id
 mn11-20020a0562145ecb00b0067a198c0a84mr1188664qvb.61.1700829156425; 
 Fri, 24 Nov 2023 04:32:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwv3x8qkVc7oXMqpfVKauQfbx4xlqpk0c/+TYrL4KgLUnCDhymJwpjEygwKOR86SA6xLZJjg==
X-Received: by 2002:a05:6214:5ecb:b0:67a:198c:a84 with SMTP id
 mn11-20020a0562145ecb00b0067a198c0a84mr1188648qvb.61.1700829156174; 
 Fri, 24 Nov 2023 04:32:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a0ce48c000000b0066d23395d27sm1345633qvl.123.2023.11.24.04.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 04:32:35 -0800 (PST)
Message-ID: <9b97cd8f-3459-4bd8-aa6f-e1539bfd9bea@redhat.com>
Date: Fri, 24 Nov 2023 13:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/Kconfig: Imply VFIO_PCI
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20231124080658.893770-1-clg@redhat.com>
 <f77896fc-18b5-4f85-b621-89b84dc26b63@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <f77896fc-18b5-4f85-b621-89b84dc26b63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/24/23 11:10, Philippe Mathieu-Daudé wrote:
> On 24/11/23 09:06, Cédric Le Goater wrote:
>> When the legacy and iommufd backends were introduced, a set of common
>> vfio-pci routines were exported in pci.c for both backends to use :
>>
>>    vfio_pci_pre_reset
>>    vfio_pci_get_pci_hot_reset_info
>>    vfio_pci_host_match
>>    vfio_pci_post_reset
>>
>> This introduced a build failure on PPC when --without-default-devices
>> is use because VFIO is always selected in ppc/Kconfig but VFIO_PCI is
>> not.
>>
>> Use an 'imply VFIO_PCI' in ppc/Kconfig and bypass compilation of the
>> VFIO EEH hooks routines defined in hw/ppc/spapr_pci_vfio.c with
>> CONFIG_VFIO_PCI.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/ppc/spapr_pci_vfio.c | 36 ++++++++++++++++++++++++++++++++++++
>>   hw/ppc/Kconfig          |  2 +-
>>   2 files changed, 37 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks for reworking it without adding more stubs :)

yeah. no problem. It is simpler that way.

Thanks,

C.




