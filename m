Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1767380FA
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:10:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvjM-0004uo-EO; Wed, 21 Jun 2023 07:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBvjG-0004oE-IF
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBvjD-0000jn-M9
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687345822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+PPJcZwVybRKqB+oePB3oQpC+QICYQE72Fmc4NGzUQ0=;
 b=SIQrlfeuVOu7TRefREFEPi2LMYyM0sSbk3rtvMtdZ2dP4dqkcru5nByaBVqubXYAXXX/fE
 akY7/SlHS/LEUJ/+xP7iKBKSZqyn1zixouKNUQDVpkxMNshZYrGZTMeSRqXD9ZXKBIS1A7
 6u29q46k+K46RsPrAsMRf4pwleEfYbw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-pbgDk5ZaPtCUOKJJNj-yAg-1; Wed, 21 Jun 2023 07:10:21 -0400
X-MC-Unique: pbgDk5ZaPtCUOKJJNj-yAg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4ec817fb123so3914852e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 04:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687345819; x=1689937819;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+PPJcZwVybRKqB+oePB3oQpC+QICYQE72Fmc4NGzUQ0=;
 b=JE9uc190ItJfEut5dr444FLT2S1548r3fkSFy8guI+0B83xVSycFWTrTtaI9j8gYbh
 B59N06sjgG7TfNNcWMRrFw29bTt7nQcSsd5mn/LEmFw7rBOv5SFBN4+cPAVB+39tfmcH
 x5eyAFIIjlwVpuzB/E0VEy1nr7GO0aSERugzSrpfw3hhHGKElKaYvY0q0hilTd83z2yk
 M31v+v0Ml4epledPzFqBV79XixpWntjGa7wrixr5XAh6Z65SrMIFX8BWFnXQdIyIztm0
 yNFkbOwWJSUDOTNXobE0D9oUWTOBGq5iH/dRYF/a2kGa6k9HbX/Omvpt9J2yaWHeE7NP
 gZjg==
X-Gm-Message-State: AC+VfDzy698B4sgUh13lZR/+3XltxTyy8sYlPZbeKvhOTHfxU66QO6Nb
 K1XbwqzJhLNCSIUmRW7qAIyxm6FzgEPzubPG/cHU+Iyu0+yFBLT/wRoEU8moMQjKH3hHmtNlFVE
 UCBdMc/39NAlmQ6U=
X-Received: by 2002:a19:5f5e:0:b0:4f8:554f:36aa with SMTP id
 a30-20020a195f5e000000b004f8554f36aamr8695665lfj.29.1687345819122; 
 Wed, 21 Jun 2023 04:10:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dPOiwWjMrFeux8c7Yxb3pQd32Zv1F1r4CL1oEYE69e28hwJuZI9LmzmivR8K/k43R01PkHg==
X-Received: by 2002:a19:5f5e:0:b0:4f8:554f:36aa with SMTP id
 a30-20020a195f5e000000b004f8554f36aamr8695649lfj.29.1687345818759; 
 Wed, 21 Jun 2023 04:10:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:9c00:7978:3030:9d9a:1aef?
 (p200300cbc70b9c00797830309d9a1aef.dip0.t-ipconnect.de.
 [2003:cb:c70b:9c00:7978:3030:9d9a:1aef])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a05600c294600b003f7e4639aabsm15838957wmd.10.2023.06.21.04.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 04:10:18 -0700 (PDT)
Message-ID: <02b6a8a8-2da7-2864-0c0e-5ed81a560355@redhat.com>
Date: Wed, 21 Jun 2023 13:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/1] Q35 Support
Content-Language: en-US
To: Joel Upham <jupham125@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <cover.1687127946.git.jupham125@gmail.com>
 <272947b9494f00bb4ad3e27c050e99f8b61905b3.1687127946.git.jupham125@gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <272947b9494f00bb4ad3e27c050e99f8b61905b3.1687127946.git.jupham125@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 20.06.23 19:24, Joel Upham wrote:

Inexpressive patch subject and non-existant patch desciption. I have no 
clue what this is supposed to do, except that it involes q35 and xen ()I 
guess ?.

> ---
>   hw/acpi/ich9.c                |   22 +-
>   hw/acpi/pcihp.c               |    6 +-
>   hw/core/machine.c             |   19 +
>   hw/i386/pc_piix.c             |    3 +-
>   hw/i386/pc_q35.c              |   39 +-
>   hw/i386/xen/xen-hvm.c         |    7 +-
>   hw/i386/xen/xen_platform.c    |   19 +-
>   hw/isa/lpc_ich9.c             |   53 +-
>   hw/isa/piix3.c                |    2 +-
>   hw/pci-host/q35.c             |   28 +-
>   hw/pci/pci.c                  |   17 +
>   hw/xen/xen-host-pci-device.c  |  106 +++-
>   hw/xen/xen-host-pci-device.h  |    6 +-
>   hw/xen/xen_pt.c               |   49 +-
>   hw/xen/xen_pt.h               |   19 +-
>   hw/xen/xen_pt_config_init.c   | 1103 ++++++++++++++++++++++++++++++---
>   include/hw/acpi/ich9.h        |    1 +
>   include/hw/acpi/pcihp.h       |    2 +
>   include/hw/boards.h           |    1 +
>   include/hw/i386/pc.h          |    3 +
>   include/hw/pci-host/q35.h     |    4 +-
>   include/hw/pci/pci.h          |    3 +
>   include/hw/southbridge/ich9.h |    1 +
>   include/hw/xen/xen.h          |    4 +-
>   qemu-options.hx               |    1 +
>   softmmu/datadir.c             |    1 -
>   softmmu/qdev-monitor.c        |    3 +-
>   stubs/xen-hw-stub.c           |    4 +-
>   28 files changed, 1395 insertions(+), 131 deletions(-)
> 

Usually people refrain from reviewing such massive patches. Most 
probably this can be broken up into reviewable pieces.

Was this supposed to be an RFC?

-- 
Cheers,

David / dhildenb


