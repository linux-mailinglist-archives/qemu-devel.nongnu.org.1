Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B6A910EDA
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jun 2024 19:35:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKLg4-0006z9-Pz; Thu, 20 Jun 2024 13:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKLfp-0006p3-Km
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKLfi-0000AH-JU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718904845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JSOwfNu+nTkhUY1sTluCY+7F6Z5c4YIiIQfEmoTmHHg=;
 b=byCF8b82UlnPovU27x4+He6ijXjD8QAvUtIch4nh9nHo6QFLVVZ56e9zesgKKML/AM2hec
 vytq5bS3IPNIrGQqCMIGGzBelMZtEyBYJ0YlfgTYqhBRuc7Z5P3Ldu+C5P5PbU3uNQ+7Ir
 r5QzTLsudKJpwLdE+wi5iCelecVqOgo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-RsCUT6i1ND-V0ULtkL49YQ-1; Thu, 20 Jun 2024 13:34:04 -0400
X-MC-Unique: RsCUT6i1ND-V0ULtkL49YQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6ef729b465so55702166b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 10:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718904843; x=1719509643;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JSOwfNu+nTkhUY1sTluCY+7F6Z5c4YIiIQfEmoTmHHg=;
 b=uDLTx49bFifJ649rStYe7JdQ+XUvOwOtzJVsgzImGRZe95jgt48miWKqRMl7sWlVX4
 kG22rHcEp6U0sEK/hxqHqcqpy0J8ALJmxPZL7VQ6kn5hqJF8Nk0ACPPnxW38wZEEXEtC
 mkbp5QAvEIvDEkanaordviU5i06SbmCcb6L8ZdUueRQndORbDI5tKiWm4Orl+vhF25A4
 OaIVSFoyx2x/YFdPpm9rujvEZnYjH+W3q1F2qnBTnS0OhFz5srjCA/3saV5dYfn/ED0e
 0s208eQBWpCwFsy4UGbGtSo/8lU/IgxEkxufJcaG8uI4jOnEqZ4T4nE1U8OnlCOJoRfV
 ygFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK9rwvMbG/zjJ3gKp922F9dezbMlR4VZooJ6AIFORNo+TcPKZgXf6TV9OIhDk/Jzjgi8PWkxnc84W2i1Fkp50MTAAcvVI=
X-Gm-Message-State: AOJu0YxjxPy/xGzw1M+3ZVn4E9bcJaGIUxKmy2dUiNCJr/ySOILoCux8
 pyNht3NSrwosVKmKUQ/docxzJMpDgUu/v/+A6RjbKffXPxhpoGAfkzgG7iPk/z+HNrDRsb1lzx9
 l5ucNc1wtx4M/a3Xk9Ve+a9l2ZfVCnS8FXFmWg7IivrZTlrHOcL72
X-Received: by 2002:a17:907:a4c5:b0:a6f:b5ff:a6fd with SMTP id
 a640c23a62f3a-a6fb5ffab3cmr377264666b.12.1718904842870; 
 Thu, 20 Jun 2024 10:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9gSWZIuvo9fjB5Wxq+l+RAcUI8J1ntqQr6sSEiB5xalUOAPdL5VkhOU/z+tW6rUYwIUkkjQ==
X-Received: by 2002:a17:907:a4c5:b0:a6f:b5ff:a6fd with SMTP id
 a640c23a62f3a-a6fb5ffab3cmr377262766b.12.1718904842534; 
 Thu, 20 Jun 2024 10:34:02 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-117.web.vodafone.de.
 [109.43.178.117]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fb508211csm144940766b.19.2024.06.20.10.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 10:34:02 -0700 (PDT)
Message-ID: <6b1daa9c-6f37-4edb-86d4-782941f1bcca@redhat.com>
Date: Thu, 20 Jun 2024 19:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to use designware-root-port and designware-root-host devices ?
To: Arthur Tumanyan <arthurtumanyan@gmail.com>, qemu-devel@nongnu.org
References: <CADueUgQh-=vmoO9kqL589Xeuf_LOM_K2Rr-rBxwe8iArdNdzsA@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CADueUgQh-=vmoO9kqL589Xeuf_LOM_K2Rr-rBxwe8iArdNdzsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

On 20/06/2024 10.28, Arthur Tumanyan wrote:
> Hi all,
> 
> My question may sound stupid, however...

  Hi Arthur,

no worries, the question how to use which device in QEMU can be quite tricky ;-)

> Currently I'm trying to make 
> available designware-root-{port,host} devices  in linux when I run it in qemu.
> 
> I try the following way to run:
> 
> qemu-system-arm -M virt -m 2G \
>       -kernel images/Image \
>       -append "rootwait root=/dev/vda ro" \
>       -drive file=images/rootfs.ext2,format=raw,id=hd0 \
>       -device designware-root-port,id=rp0,chassis=1,slot=0,bus=pcie.0,addr=1 \
>       -device e1000,netdev=net0,mac=52:54:00:12:34:56,bus=rp0,addr=0 \
>       -netdev user,id=net0
> 
> but it seems designware device is not enabled by default: qemu-system-arm: 
> -device designware-root-port,id=rp0,chassis=1,slot=0,bus=pcie.0,addr=1: 
> 'designware-root-port' is not a valid device model name

Are you sure about the names?

$ grep -r 'designware' *
...
include/hw/pci-host/designware.h:#define TYPE_DESIGNWARE_PCIE_HOST 
"designware-pcie-host"
include/hw/pci-host/designware.h:#define TYPE_DESIGNWARE_PCIE_ROOT 
"designware-pcie-root"

> when I enable it from Kconfig/meson.build it says the device is already 
> registered and exits with abort().
> 
>  From the other hand the device is declared as non pluggable: 
> dc->user_creatable = false;

Well, that means that you cannot use those with "-device". They can only be 
instantiated via the code that creates the machine.

> Can you please help me to use designware-root-host/port devices ?

It seems like the i.MX7 SABRE machine is using this device, so instead of 
"-M virt", you could have a try with "-M mcimx7d-sabre" (and a kernel that 
supports this machine) instead.

  HTH,
   Thomas


