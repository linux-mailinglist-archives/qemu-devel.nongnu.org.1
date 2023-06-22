Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD612739F33
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:03:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCI5F-000404-EJ; Thu, 22 Jun 2023 07:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCI53-0003n7-7w
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCI50-0007GE-2w
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687431698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMlN3CcH4gZEYqSTM0FTk1ORtB9CYJFiWz/USdnkj2g=;
 b=XWmXCExELSum0SNOdiU9sAyfJgt/cNGhE6mHXNH0cKmNw81EYFljNg7OSVjxYzlcl+A1Y4
 Kh1ujz+V9GMPWp4F3HAyUKhyK95Sn5xKsOs+5+Fq3hR3XNIABMvsemPKUrTJ8eK3F3xgir
 g0sL+WbbelEdWiUZ0xhtoNXBWYpjBEA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-UqC_X55NP6WiLeAef6_yeA-1; Thu, 22 Jun 2023 07:01:37 -0400
X-MC-Unique: UqC_X55NP6WiLeAef6_yeA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3112e243c68so3238556f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 04:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687431696; x=1690023696;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bMlN3CcH4gZEYqSTM0FTk1ORtB9CYJFiWz/USdnkj2g=;
 b=Lzoe+Bi2kgjicsgdkDDvKioCMrC4o2dDTmAgM1CNtQAXxAgA4W6J8pr6pY6SgPtQn9
 VxBaXmpEiyJt9CWHgmXNT5PQEkWaStVfTEXVu8zu+ABzqtL6mbGEVJNyyDvUrky3KFTD
 I+Z+2UrKjHwf0yLk56wQGaoJ+wXn0HaWkvqilVtSAvgtn3LIflRBpFYNmlfzSOcODyb8
 2wnjTlVQjwFLOZyDslaGNJvYXqZ5x17Woib6nM4innTRNeDi1pZshSvog7WvVlCGVfIA
 7zM4GdsQdSyLgXdHhlVBXriRcJOOSxer5mcf0ohLEPfULlgIpSbEtgF7Bsuitlz0UnmV
 9DGQ==
X-Gm-Message-State: AC+VfDy/P8A4sex6EVLhFS8dhoem8ti2oYzZmlVWSCwGX7/mcZdBLIg5
 7qoSScy0Px0u6CpywKMaqa5AKmchWIQVRvXD7bxaLvS3HsktcxIKEnZr33/iiiFijDCQErqxZuM
 jtoSrWEXnxPcAlxE=
X-Received: by 2002:a5d:45c4:0:b0:311:822:9c51 with SMTP id
 b4-20020a5d45c4000000b0031108229c51mr15512983wrs.43.1687431696372; 
 Thu, 22 Jun 2023 04:01:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4coAVKMtnH2kguIZBTr18tfN46CZSBkgYxikOK+kPC5tlX/JD/nhTGMuzKHWtvzhvHUE+gcA==
X-Received: by 2002:a5d:45c4:0:b0:311:822:9c51 with SMTP id
 b4-20020a5d45c4000000b0031108229c51mr15512955wrs.43.1687431695945; 
 Thu, 22 Jun 2023 04:01:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:c00:a3d3:85e8:742c:2e9?
 (p200300cbc71a0c00a3d385e8742c02e9.dip0.t-ipconnect.de.
 [2003:cb:c71a:c00:a3d3:85e8:742c:2e9])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a5d58e4000000b00311299df211sm6813111wrd.77.2023.06.22.04.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 04:01:35 -0700 (PDT)
Message-ID: <aa78a4fc-9c88-b6c1-98f8-d22348927df4@redhat.com>
Date: Thu, 22 Jun 2023 13:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1686577753.git.maciej.szmigiero@oracle.com>
 <896327748bde906826e24ce7cc45301e325e14a7.1686577753.git.maciej.szmigiero@oracle.com>
 <f54e55d0-b8dd-a431-7634-02fdec0611bb@redhat.com>
 <1b107fba-38e0-cced-e19f-b62684072bfd@maciej.szmigiero.name>
 <008fced2-1bcf-7a89-d642-bb724eb63ddf@redhat.com>
 <987af80f-9636-42da-26de-e2d07dc25ce3@maciej.szmigiero.name>
 <acf9402f-3baf-6c07-6662-7e0638f78263@redhat.com>
 <0a7cc359-f308-21a1-6c6d-7bcb51051f7e@maciej.szmigiero.name>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH][RESEND v5 3/3] Add a Hyper-V Dynamic Memory Protocol
 driver (hv-balloon)
In-Reply-To: <0a7cc359-f308-21a1-6c6d-7bcb51051f7e@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

[...]

>>>> We'd use a memory region container as device memory region (like [1]) and would have to handle the !memdev case (I can help with that). > Into that, you can map the RAM memory region on demand (and eventually even using multiple slots like [1]).
>>>>
>>>> (2) Use a single virtual DIMM and (un)plug that on demand. Let the machine code handle (un)plugging of the device.
>>>>
>>>>
>>>> (1) feels cleanest to me, although it will require a bit more work.
>>>>
>>>
>>> I also think approach (1) makes more sense as it avoids memslot metadata
>>> overhead for not-yet-hot-added parts of the memory backing device.
>>>
>>> Not sure what you mean that the !memdev case would be problematic in this
>>> case - it is working in the current driver shape so why would adding
>>> potential memory subregions (used in the memdev case) change that?
>>
>> I'm thinking about the case where you have a hv-balloon device without a memdev.
>>
>> Without -m X,maxmem=y we don't currently expect to have memory devices around
>> (and especially them getting (un)plugged. But why should we "force" to set the
>> "maxmem" option
> 
> I guess it's only a small change to QEMU to allow having hv-balloon
> device (without a memdev) even in the case where there's no "maxmem"
> option given on the QEMU command line.
> 
>>
>> I hope I'll find some time soonish to prototype what I have in mind, to see
>> if it could be made working.
>>
> 
> Okay, so I'll wait for your prototype before commencing further work on
> the next version of this driver.

About to have something simplistic running -- I think. Want to test with 
a Linux VM, but I don't seem to get it working (also without my changes).


#!/bin/bash

build/qemu-system-x86_64 \
     --enable-kvm \
     -m 4G,maxmem=36G \
     -cpu host,hv-syndbg=on,hv-synic,hv-relaxed,hv-vpindex \
     -smp 16 \
     -nographic \
     -nodefaults \
     -net nic -net user \
     -chardev stdio,nosignal,id=serial \
     -hda Fedora-Cloud-Base-37-1.7.x86_64.qcow2 \
     -cdrom /home/dhildenb/git/cloud-init/cloud-init.iso \
     -device isa-serial,chardev=serial \
     -chardev socket,id=monitor,path=/var/tmp/mon_src,server,nowait \
     -mon chardev=monitor,mode=readline \
     -device vmbus-bridge \
     -object memory-backend-ram,size=2G,id=mem0 \
     -device hv-balloon,id=hv1,memdev=mem0



[root@vm-0 ~]# uname -r
6.3.5-100.fc37.x86_64
[root@vm-0 ~]# modprobe hv_balloon
modprobe: ERROR: could not insert 'hv_balloon': No such device


Any magic flag I am missing? Or is there something preventing this to 
work with Linux VMs?

-- 
Cheers,

David / dhildenb


