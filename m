Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3DF7BFBC4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:49:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCAi-00078H-Tl; Tue, 10 Oct 2023 08:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qqCAh-000785-0d
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qqCAf-0003GI-DB
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696942148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vUX3D4lnkFoiSeFq9EfLM/GFHmdC35xufw4b+4zq1yM=;
 b=E3SzilQuLjIxcLRgo12e6Wy730FQ8DfLbpVZAZ7vWKt6onXjS/wYeMKzxvxLcdZl3JzQhi
 vqxiCp/Q4M0G7vkw8ib3m8TAyNpMNEKB03G6A0+awHyBTk29ktK5wlbvBeXI8FoxOf8zg7
 hBX+ZHY7pgnlAsT0cMSxzHtbjhskdXI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-_g6Wx9jZN-avhPOcZHy39A-1; Tue, 10 Oct 2023 08:48:57 -0400
X-MC-Unique: _g6Wx9jZN-avhPOcZHy39A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66acad63d74so70512216d6.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942137; x=1697546937;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vUX3D4lnkFoiSeFq9EfLM/GFHmdC35xufw4b+4zq1yM=;
 b=BYuuEkaYu6GDFaLPuCyvosTDpGD4nsOm/eclJ0SBxqqtqr9cXlm5kqZ4N1wnjhPhbV
 4m7vB31xOuj3azVs/PU2PvqNdrZ7gI1Lw7L+0WKo3AbjgNFrjkT+zoBiLnZpXtH9a6Ry
 rKKN9Yf1Z254uZeZ4HehLS7zRMwxrWOy6N5kAa0MIzzYQfkmw+swVINm3gbyvtsehDzA
 L9o8pzsX4VFi3CnlO1h9MZKnvV4nPCzUNotxob4mdAxNPS8BnGhq0I72z3i6mALr1CEP
 psix3tdWcUm0JVXW5U901mTRa7+YKropDtesRZhQ8fS4tkbJes+9M1BpcrjXEsgYl8Z/
 DBhQ==
X-Gm-Message-State: AOJu0Ywk8Uftks6Q4ZLaZ5ZB0FZW10pBDsh+RoMqAmfAqLI5BwFmcH6D
 csl0rasAuVEXWx8bpMcZUJ3sZWDP2YEh3JBxKcoPN3pThg42rokOnRDxMD4OzG/cA1xPENWNpvP
 Z3tNd7dj+o4JRxlY=
X-Received: by 2002:a0c:bf09:0:b0:656:3fa4:6016 with SMTP id
 m9-20020a0cbf09000000b006563fa46016mr16886011qvi.62.1696942136796; 
 Tue, 10 Oct 2023 05:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/oRTybuMxd4EGyLg5UXDIqB3jdsux1uLkGBo45rDsY9jx0i9YV5WejSEh2/M4Ag/NVe/7Jg==
X-Received: by 2002:a0c:bf09:0:b0:656:3fa4:6016 with SMTP id
 m9-20020a0cbf09000000b006563fa46016mr16885997qvi.62.1696942136554; 
 Tue, 10 Oct 2023 05:48:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a05620a100700b0076f19b9e96fsm4310534qkj.107.2023.10.10.05.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:48:56 -0700 (PDT)
Message-ID: <0cdcd25f-9ed5-cbfe-1633-213bd6a2c82f@redhat.com>
Date: Tue, 10 Oct 2023 14:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/3] ramfb: migration support
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: lersek@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
References: <20231009063247.119333-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231009063247.119333-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On 10/9/23 08:32, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> Implement RAMFB migration, and add properties to enable it only on >= 8.2
> machines, + a few related cleanups.

Should this series go in vfio-next ?

Thanks,

C.

> 
> thanks
> 
> v5:
> - add missing VMSTATE_END_OF_LIST
> - changed ramfb=off & x-mig=on user config error to a warning
> - add r-b tags
> 
> v4: (Laszlo review and suggestions)
> - change migrate_needed() to assert(ramfb_exists)
> - rename vfio_display_needed() to vfio_display_migration_needed(),
>    update the condition and associated comment
> - move the ramfb-migrate option check and add a check for ramfb=on
> - add a stub to fix compilation on some architectures
> 
> v3:
> - add a "x-" prefix to properties, as they are not meant for users.
> - RAMFB now exports a ramfb_vmstate for actual devices to include
> - VFIOPCIDevice now has a VFIODisplay optional subsection whenever ramfb
>    migration is required (untested)
> 
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=1859424
> 
> Marc-André Lureau (3):
>    ramfb: add migration support
>    ramfb-standalone: add migration support
>    hw/vfio: add ramfb migration support
> 
>   hw/vfio/pci.h                 |  3 +++
>   include/hw/display/ramfb.h    |  4 ++++
>   hw/core/machine.c             |  2 ++
>   hw/display/ramfb-standalone.c | 27 +++++++++++++++++++++
>   hw/display/ramfb.c            | 19 +++++++++++++++
>   hw/vfio/display.c             | 21 +++++++++++++++++
>   hw/vfio/pci.c                 | 44 +++++++++++++++++++++++++++++++++++
>   stubs/ramfb.c                 |  2 ++
>   8 files changed, 122 insertions(+)
> 


