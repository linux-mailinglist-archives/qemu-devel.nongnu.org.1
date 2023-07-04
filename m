Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB118746BC2
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:21:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbHP-0004nu-FM; Tue, 04 Jul 2023 04:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGbHM-0004nY-AP
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGbHK-0003o9-Hj
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688458854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfhWrt0MMjVPIwMsRCtGgtLrTQDdE5dEhiAHt7q5H8g=;
 b=U9+yCEOyWDh7vHFjzNAmkFwzOUsk1AOI+8c8X6NPEpUwaI7q9wnFsPk530lKpHF/Fp0yuh
 sS6GQPj6sq8wVKnUUmQgSXJ/Ug/PLxhoCYMLOJ0fZ7HmAl5W7HlLIpRvNveqqLLChOnE5C
 piM9XrVu6uldQLubDanD5In/bqLxrHc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-90ObNouGNB2y9PK7T--EPw-1; Tue, 04 Jul 2023 04:20:52 -0400
X-MC-Unique: 90ObNouGNB2y9PK7T--EPw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fb40ec952bso33799765e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688458851; x=1691050851;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SfhWrt0MMjVPIwMsRCtGgtLrTQDdE5dEhiAHt7q5H8g=;
 b=bs3iQ4UQHjKk2rwWNGispPL/I6FSca9dOm7/2pmPMU2Umj7U4Usqm0co5NKopZQAK3
 rPAOyOgykA6FwAIxYt5e8P5MIeabQvOgMmxJSsWN66TEmASCDjcuCc8i04nzqq2Beh9c
 Y30xJqOofzCtcpAS/9jX7kJEbJBtSuAes4fNV98G4uN5Zk7cpAiIQ1ZhlAZQ28qSvlG9
 E2nilj8JxDb5GvRuLqQle0F9/8SB6GVm3msiddxWw75pDH4XPDyeZkq3mhNeJNaDIBrb
 vy4DKFctIauTRvh1pIJ2U0eyTO/oARV+TNsvt2TbSyOG+bApjGej9qRMRE1m42IlLDKy
 rHbQ==
X-Gm-Message-State: AC+VfDxjhVelAckHoaZCPoJpU088gDU27LHF4eLxXE4Qxu7X0AXvMdTF
 qq5zzzDoLd2USsfOMhAMdW4ieA8LM5hHByoKArAUn5dJMNWIZabkW8rvce69yR0HCtMEgcsbo3O
 Hb3EKzaV2iX30IFY=
X-Received: by 2002:a7b:c5d7:0:b0:3f8:2777:15e with SMTP id
 n23-20020a7bc5d7000000b003f82777015emr10871221wmk.31.1688458851622; 
 Tue, 04 Jul 2023 01:20:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4DZWSDqbr8yd3WT44bwzrWqaFytalh/Fd+2Hyo/r+VmGfs9K/XC50FZzKHwm6qIvnsW3jKmg==
X-Received: by 2002:a7b:c5d7:0:b0:3f8:2777:15e with SMTP id
 n23-20020a7bc5d7000000b003f82777015emr10871211wmk.31.1688458851281; 
 Tue, 04 Jul 2023 01:20:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a7bc398000000b003fb9ebb6b88sm20991926wmj.39.2023.07.04.01.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:20:50 -0700 (PDT)
Message-ID: <f4e6d2d0-d9e7-8779-8159-7b61546fd210@redhat.com>
Date: Tue, 4 Jul 2023 10:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] Support message-based DMA in vfio-user server
Content-Language: en-US
To: Mattias Nissler <mnissler@rivosinc.com>, qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 stefanha@redhat.com, john.levon@nutanix.com
References: <20230704080628.852525-1-mnissler@rivosinc.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230704080628.852525-1-mnissler@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

On 04.07.23 10:06, Mattias Nissler wrote:
> This series adds basic support for message-based DMA in qemu's vfio-user
> server. This is useful for cases where the client does not provide file
> descriptors for accessing system memory via memory mappings. My motivating use
> case is to hook up device models as PCIe endpoints to a hardware design. This
> works by bridging the PCIe transaction layer to vfio-user, and the endpoint
> does not access memory directly, but sends memory requests TLPs to the hardware
> design in order to perform DMA.
> 
> Note that in addition to the 3 commits included, we also need a
> subprojects/libvfio-user roll to bring in this bugfix:
> https://github.com/nutanix/libvfio-user/commit/bb308a2e8ee9486a4c8b53d8d773f7c8faaeba08
> Stefan, can I ask you to kindly update the
> https://gitlab.com/qemu-project/libvfio-user mirror? I'll be happy to include
> an update to subprojects/libvfio-user.wrap in this series.
> 
> Finally, there is some more work required on top of this series to get
> message-based DMA to really work well:
> 
> * libvfio-user has a long-standing issue where socket communication gets messed
>    up when messages are sent from both ends at the same time. See
>    https://github.com/nutanix/libvfio-user/issues/279 for more details. I've
>    been engaging there and plan to contribute a fix.
> 
> * qemu currently breaks down DMA accesses into chunks of size 8 bytes at
>    maximum, each of which will be handled in a separate vfio-user DMA request
>    message. This is quite terrible for large DMA acceses, such as when nvme
>    reads and writes page-sized blocks for example. Thus, I would like to improve
>    qemu to be able to perform larger accesses, at least for indirect memory
>    regions. I have something working locally, but since this will likely result
>    in more involved surgery and discussion, I am leaving this to be addressed in
>    a separate patch.
> 

I remember asking Stefan in the past if there wouldn't be a way to avoid 
that mmap dance (and also handle uffd etc. easier) for vhost-user 
(especially, virtiofsd) by only making QEMU access guest memory.

That could make memory-backend-ram support something like vhost-user, 
avoiding shared memory and everything that comes with that (e.g., no 
KSM, no shared zeropage).

So this series tackles vfio-user, does anybody know what it would take 
to get something similar running for vhost-user?

-- 
Cheers,

David / dhildenb


