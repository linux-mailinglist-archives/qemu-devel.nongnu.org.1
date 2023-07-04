Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA6747169
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfCn-0000aI-Fy; Tue, 04 Jul 2023 08:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGfCW-0000Ti-Qg
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGfCV-0001fR-1i
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688473929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JKtW7kRUEvy5PmBA4Kqa9fvH0lf22P7uCV0jT+myaU=;
 b=Pqd117xtci8VkaifmDAJUhm9PZfeqXGsrlfxvDFr40vdwwaeTevOoX4oNffA/kynVnXsNQ
 CajOtAuH5LS+dtrWCMjYxovT6LsT3GGXHNT5Lob9HKB386DmNPqIkNa9jXmVFv5FRUkEb5
 M6RKgtZsxKQAzGXFTxub4b9S5CZZIq4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-TCJ8yxt4M_K9RYkUEj5Vlw-1; Tue, 04 Jul 2023 08:32:08 -0400
X-MC-Unique: TCJ8yxt4M_K9RYkUEj5Vlw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7623a751435so469960885a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688473928; x=1691065928;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9JKtW7kRUEvy5PmBA4Kqa9fvH0lf22P7uCV0jT+myaU=;
 b=hMGq2IZJ6snCE6+JFwEOBT/D3wPIkku1E/gXKRdaiLsnP36xi5MIvJz2X1FnCoMOpt
 Pl8VlB92tAAGa6GqXu7BZMybHtgTcH2MvOGeht+vmrSGI7SfJt9SJ0AP3Xtj2ueY8Mp6
 Xpq1eTF41ZBnlukTZAUQXpnOPnpHMyF/e/EubNkkmlaM1fxFj5B1yb9hYPsnQy4r+RJH
 i53dfrV9mddjWXLlki6refX1NpHq/EMU2de9ZfVaxIm7YH/hfUekGY7AhdC58Qj8tTxS
 KADu8139UyLxM93DORq4LJFYbF8FP+4l7KPA1VVDcRAymLUMpGI7jvvQusbKjyWxRs2m
 kpaw==
X-Gm-Message-State: ABy/qLa6MmdyfbPcQ4lqdboG8o+O7v3xA2Xwkgit5g76Kb8UjgWJ0Ek4
 ujy17FmBEGJVgmH/0E3vBs1fEnqJ4md22wuLkQM/XUP2tZaJo1luQozAyJZBk/gILSzpGZAQBbN
 TH6/i+q144jImK20=
X-Received: by 2002:a05:620a:2482:b0:766:a495:63f1 with SMTP id
 i2-20020a05620a248200b00766a49563f1mr13414307qkn.59.1688473927983; 
 Tue, 04 Jul 2023 05:32:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEO7jvuYMkiIvrggdUV2TFKmkYLpT/Cfm4XV+aOp/hFKdokiU0dx4Zi8soEEEcnjEHZttispw==
X-Received: by 2002:a05:620a:2482:b0:766:a495:63f1 with SMTP id
 i2-20020a05620a248200b00766a49563f1mr13414289qkn.59.1688473927725; 
 Tue, 04 Jul 2023 05:32:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a05620a103700b007678825c19esm168407qkk.119.2023.07.04.05.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 05:32:07 -0700 (PDT)
Message-ID: <149fdc25-f88d-67f5-f409-8ea2299e41ef@redhat.com>
Date: Tue, 4 Jul 2023 14:32:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20230704120137.2604646-1-clg@redhat.com>
 <6fb9e146-7ace-0db6-305b-f6fc135878c1@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <6fb9e146-7ace-0db6-305b-f6fc135878c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/4/23 14:09, Philippe Mathieu-Daudé wrote:
> On 4/7/23 14:01, Cédric Le Goater wrote:
>> It is useful to extend the number of available PCI devices to KVM guests
>> for passthrough scenarios and also to expose these models to a different
>> (big endian) architecture. Include models for Intel Ethernet adapters
>> and one USB controller, which all support MSI-X. Devices only supporting
>> INTx won't work on s390x.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Tested under KVM as a machine device, under KVM nested as a passthrough
>>   device
>>
>>   hw/s390x/Kconfig | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
>> index 5e7d8a2bae8b..7a82c58cdf6e 100644
>> --- a/hw/s390x/Kconfig
>> +++ b/hw/s390x/Kconfig
>> @@ -10,3 +10,7 @@ config S390_CCW_VIRTIO
>>       select SCLPCONSOLE
>>       select VIRTIO_CCW
>>       select MSI_NONBROKEN
>> +    imply PCI_EXPRESS
> 
> No, PCIe is a bus, which is implemented in s390-pci-bus.c;
> S390_CCW_VIRTIO exposes this bus, so we Kconfig SELECT it.
> 
>> +    imply E1000E_PCI_EXPRESS
>> +    imply IGB_PCI_EXPRESS
>> +    imply USB_XHCI_PCI
> 
> These are devices you can plug on a PCIe bus, so Kconfig
> IMPLY is correct.

If I understand correctly, this should be ?

@@ -5,8 +5,11 @@ config S390_CCW_VIRTIO
      imply VFIO_AP
      imply VFIO_CCW
      imply WDT_DIAG288
-    select PCI
+    select PCI_EXPRESS
      select S390_FLIC
      select SCLPCONSOLE
      select VIRTIO_CCW
      select MSI_NONBROKEN
+    imply E1000E_PCI_EXPRESS
+    imply IGB_PCI_EXPRESS
+    imply USB_XHCI_PCI


