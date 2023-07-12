Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6EC750718
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJYMh-0000KV-VR; Wed, 12 Jul 2023 07:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qJYMg-0000KG-EE
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:50:38 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qJYMe-0002PG-MS
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:50:38 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b0719dd966so6226584fac.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689162635; x=1691754635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AHg0UMbJ3dJmTdgblzro2RfS4qjVNY2sbZw1yCj4LLk=;
 b=hAYhzVjZMIW1A0dCcr0j2k5H80+Sxz7aAZ8VhW849kV/2RJLvBXZOmWhp7DyjO8asw
 MjVhVSHJZiNWgwzOOqIjYh5Pe2rBXPVvcNV4iwJNixRNxWhfBOUTybJWL4jb3R9dLbHB
 DT0u80ia3W6jvkqwNRAUk24bGDtLbE5nrpl8T+085gh1E/+2iNo9RlZTBybNZNsDQLll
 CFnNeOx+ZK/DMrO7VwcdnH7n7vO5VOOchJGkcPuVM/0r2gzcDqM6LmoSxzjlUq7T3ohb
 xULrUAknth5YbGWa54/2xO7Qj2YhmnuZ6h4BJ/m/gX5TfNvOedITg4x+/GMCyPm+HgkN
 iVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689162635; x=1691754635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AHg0UMbJ3dJmTdgblzro2RfS4qjVNY2sbZw1yCj4LLk=;
 b=MXv/zOQ0bDRINnUyUiKIR7gJ/yvaG9tkDsyKXeUhOIy8bphi9Sczn5tbcpVcGGergA
 Zl+OFM5UDQ7tm4E9g8romRtAjnyAK8uQiCFcPxzXeSWrph/DTsXgynnGI77hDaWjFr1s
 xrgIo4QJmtm35PW9FDNwhrBbDUcyXd4JPZe3xxst/ArLSWpBKKVYiCJhuLk0g3uQx8l3
 5BaPNdOgJOBYQaZBUtPMEsCkjxGaIxebLWT7FjxELJgFUSdYsX7eZUfE93sbz9sy8kRi
 htE5RN3hY7sw9BoF5rbngGUoIHpLk/mA8EfoG3w1bgwreWlvxZozYJGVcL+uXEyeftiP
 I3Tw==
X-Gm-Message-State: ABy/qLZbQ8KgJYbKmblEO6hJgsHuGXYSJjDxkwwJ1x7pcj2JvyyKUwS3
 ZD1S7YPFTNToql7+FaUg1AzbKg==
X-Google-Smtp-Source: APBJJlHfd4RCYvOrmX2FSJKox6arzRU4C8Y15/FUrxnJ0CA9WRabIeCHLxJjQP/rPnzQvqyzc3xKiw==
X-Received: by 2002:a05:6870:c142:b0:1b0:60ff:b73f with SMTP id
 g2-20020a056870c14200b001b060ffb73fmr18912013oad.8.1689162635151; 
 Wed, 12 Jul 2023 04:50:35 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a170902b68c00b001b87c1c762fsm3580488pls.123.2023.07.12.04.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 04:50:34 -0700 (PDT)
Message-ID: <e8be9581-2308-7fe6-f407-2ce54557dbd0@daynix.com>
Date: Wed, 12 Jul 2023 20:50:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/pci: Warn when ARI/SR-IOV device has non-zero Function
 number
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230712112732.18617-1-akihiko.odaki@daynix.com>
 <20230712073523-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230712073523-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/07/12 20:46, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2023 at 08:27:32PM +0900, Akihiko Odaki wrote:
>> Current SR/IOV implementations assume that hardcoded Function numbers
>> are always available and will not conflict. It is somewhat non-trivial
>> to make the Function numbers to use controllable to avoid Function
>> number conflicts so ensure there is only one PF to make the assumption
>> hold true.
>> Also warn when non-SR/IOV multifunction was attempted with ARI enabled;
>> ARI has the next Function number field register, and currently it's
>> hardcoded to 0, which prevents non-SR/IOV multifunction. It is
>> certainly possible to add a logic to determine the correct next Function
>> number according to the configuration, but it's not worth since all
>> ARI-capable devices are also SR/IOV devices, which do not support
>> multiple PFs as stated above.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> I am not really interested in adding this stuff.
> The real thing to focus on is fixing ARI emulation, not
> warning users about ways in which it's broken.

What do you think about multiple SR/IOV PFs? Do you think it's 
worth/easy enough to fix SR/IOV code to support it? Otherwise it's not 
worth fixing ARI since currently only SR/IOV devices implement it.

> 
>> ---
>>   hw/pci/pci.c | 59 +++++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 42 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 784c02a182..50359a0f3a 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2124,23 +2124,48 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>           }
>>       }
>>   
>> -    /*
>> -     * A PCIe Downstream Port that do not have ARI Forwarding enabled must
>> -     * associate only Device 0 with the device attached to the bus
>> -     * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
>> -     * sec 7.3.1).
>> -     * With ARI, PCI_SLOT() can return non-zero value as the traditional
>> -     * 5-bit Device Number and 3-bit Function Number fields in its associated
>> -     * Routing IDs, Requester IDs and Completer IDs are interpreted as a
>> -     * single 8-bit Function Number. Hence, ignore ARI capable devices.
>> -     */
>> -    if (pci_is_express(pci_dev) &&
>> -        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>> -        pcie_has_upstream_port(pci_dev) &&
>> -        PCI_SLOT(pci_dev->devfn)) {
>> -        warn_report("PCI: slot %d is not valid for %s,"
>> -                    " parent device only allows plugging into slot 0.",
>> -                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
>> +    if (pci_is_express(pci_dev)) {
>> +        /*
>> +         * A PCIe Downstream Port that do not have ARI Forwarding enabled must
>> +         * associate only Device 0 with the device attached to the bus
>> +         * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
>> +         * sec 7.3.1).
>> +         * With ARI, PCI_SLOT() can return non-zero value as the traditional
>> +         * 5-bit Device Number and 3-bit Function Number fields in its
>> +         * associated Routing IDs, Requester IDs and Completer IDs are
>> +         * interpreted as a single 8-bit Function Number. Hence, ignore ARI
>> +         * capable devices.
>> +         */
>> +        if (!pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>> +            pcie_has_upstream_port(pci_dev) &&
>> +            PCI_SLOT(pci_dev->devfn)) {
>> +            warn_report("PCI: slot %d is not valid for %s,"
>> +                        " parent device only allows plugging into slot 0.",
>> +                        PCI_SLOT(pci_dev->devfn), pci_dev->name);
>> +        }
>> +
>> +        /*
>> +         * Current SR/IOV implementations assume that hardcoded Function numbers
>> +         * are always available. Ensure there is only one PF to make the
>> +         * assumption hold true.
>> +         */
>> +        if (pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV) &&
>> +            PCI_FUNC(pci_dev->devfn)) {
>> +            warn_report("PCI: function %d is not valid for %s,"
>> +                        " currently PF can only be assigned to function 0.",
>> +                        PCI_FUNC(pci_dev->devfn), pci_dev->name);
>> +        }
>> +
>> +        /*
>> +         * ARI has the next Function number field register, and currently it's
>> +         * hardcoded to 0, which prevents non-SR/IOV multifunction.
>> +         */
>> +        if (pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>> +            !pci_is_vf(pci_dev) && (pci_dev->devfn & 0xff)) {
>> +            warn_report("PCI: function %d is not valid for %s,"
>> +                        " non-SR/IOV multifunction is not supported with ARI enabled.",
>> +                        pci_dev->devfn & 0xff, pci_dev->name);
>> +        }
>>       }
>>   
>>       if (pci_dev->failover_pair_id) {
>> -- 
>> 2.41.0
> 

