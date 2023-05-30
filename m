Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60284715FD5
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yUn-0004i0-S3; Tue, 30 May 2023 08:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3yUa-0004Ky-JN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3yUZ-0001IF-2J
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wnzz1CytElnOU4X0O0KyuIsyMwK6ZAb8/ENyM1aFaeA=;
 b=bBxlbFbSC4EHeGKsFbLFtykP6fqm2CM/ck6sWnsQNz8PhZodNM4yuV/a0ikA3xL1SDqo5V
 Wfb7ZLld+IRXCKEwse12PiC7ZK82brvIeR3uR06U2cC8+vitQYPCs7VgxRD3jVzosPhNWf
 B98876SWbMx93def3YIBdEidHX/49oI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-LVCZ5u9wOmG6jm4tHTLiAw-1; Tue, 30 May 2023 08:30:19 -0400
X-MC-Unique: LVCZ5u9wOmG6jm4tHTLiAw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-75cb96abcb5so261038485a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449819; x=1688041819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wnzz1CytElnOU4X0O0KyuIsyMwK6ZAb8/ENyM1aFaeA=;
 b=R4DYJiX43x9Z8HQsUI6CD1IFc78QQDwBLxOdQ2kGwQgluGAwhnN27bB027l6QwB0JO
 4X2kxWaFXtRWw/hhXV9fXOCPnptGU9JxZ9d46AMuGmeF5AKe4lZzpf6FKeV9S5Vj0s/a
 tjPVBsLpOG04yjmLFJio3ik8R9/OyGpeLK/mGDD+o4v/56H5HbSzwddgT22F5xMbX10s
 0pBmNQZ7k0IWvPspNo4+2vrtxGfCiCOlg431PPh+paAraCfWJHRGUUWrKViwn1LR6SvI
 zuKaAVyy84lpbyERQBiVYAhhuGdyftDdX1EoEDyERHewwoqirKEN/jbxBWf90wMXMDKz
 lpng==
X-Gm-Message-State: AC+VfDynXcOONpEMajO9QnG5QvN5s4/dwduihzGKlFy993DNfEMfrqUJ
 +p1pgSbQFQl71qbXNAzZvRDkNRtvLxoi5B5P8KcmquR5xl9Kar2Zwqba3ZWYV/1vb7Hp0o956oV
 vTZxco0Zlzi11D8Q=
X-Received: by 2002:a05:620a:2151:b0:75b:23a0:e7a4 with SMTP id
 m17-20020a05620a215100b0075b23a0e7a4mr1696710qkm.5.1685449819339; 
 Tue, 30 May 2023 05:30:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qjPn9+FKbLPy2grR+zp0T5277HoqP4Dnv8SOwSH7BLRO+rQHMhnHFUbWOWsh5XZ1JemumcA==
X-Received: by 2002:a05:620a:2151:b0:75b:23a0:e7a4 with SMTP id
 m17-20020a05620a215100b0075b23a0e7a4mr1696693qkm.5.1685449819115; 
 Tue, 30 May 2023 05:30:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 et18-20020a056214177200b006212456fd8asm4485312qvb.100.2023.05.30.05.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:30:18 -0700 (PDT)
Message-ID: <e202dbe7-0e1d-e34d-3ea3-bb7b25ebb58e@redhat.com>
Date: Tue, 30 May 2023 14:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 3/4] pcie: Add a PCIe capability version helper
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, robin@streamhpc.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <20230526231558.1660396-4-alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230526231558.1660396-4-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/27/23 01:15, Alex Williamson wrote:
> Report the PCIe capability version for a device
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   hw/pci/pcie.c         | 7 +++++++
>   include/hw/pci/pcie.h | 1 +
>   2 files changed, 8 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index b8c24cf45f7e..b7f107ed8dd4 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -274,6 +274,13 @@ uint8_t pcie_cap_get_type(const PCIDevice *dev)
>               PCI_EXP_FLAGS_TYPE) >> PCI_EXP_FLAGS_TYPE_SHIFT;
>   }
>   
> +uint8_t pcie_cap_get_version(const PCIDevice *dev)
> +{
> +    uint32_t pos = dev->exp.exp_cap;
> +    assert(pos > 0);
> +    return pci_get_word(dev->config + pos + PCI_EXP_FLAGS) & PCI_EXP_FLAGS_VERS;
> +}
> +
>   /* MSI/MSI-X */
>   /* pci express interrupt message number */
>   /* 7.8.2 PCI Express Capabilities Register: Interrupt Message Number */
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 3cc2b159570f..51ab57bc3c50 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -93,6 +93,7 @@ void pcie_cap_exit(PCIDevice *dev);
>   int pcie_endpoint_cap_v1_init(PCIDevice *dev, uint8_t offset);
>   void pcie_cap_v1_exit(PCIDevice *dev);
>   uint8_t pcie_cap_get_type(const PCIDevice *dev);
> +uint8_t pcie_cap_get_version(const PCIDevice *dev);
>   void pcie_cap_flags_set_vector(PCIDevice *dev, uint8_t vector);
>   uint8_t pcie_cap_flags_get_vector(PCIDevice *dev);
>   


