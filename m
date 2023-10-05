Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C9C7BA2C5
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:46:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQWh-00055s-Fd; Thu, 05 Oct 2023 11:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qoQWf-00055e-Ix
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qoQWd-0002XB-Tz
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696520670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrSTIAYHe9JX3y6A4fjlSHge8xK+0tj0NutYwwWOBqQ=;
 b=hUBMHqi67xNdK+mg0M6jFkaU/LQ4+3ziQtX91xm9jX30aJmayZ0O7TK/+YDnNNobcJTBT8
 AbzlDdG6uLg+YxwawVXf1jpjGXce0rMRQrYtnAVa7tygHiUnpW7jbnRuA+Nf4zcrwlMclS
 bUk4FVeNR34HKI2+75qDUtR/klDXZWA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-V3Lww3SPMzSwqd96SWc7TA-1; Thu, 05 Oct 2023 11:44:14 -0400
X-MC-Unique: V3Lww3SPMzSwqd96SWc7TA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7740c35073bso155692985a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 08:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696520653; x=1697125453;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrSTIAYHe9JX3y6A4fjlSHge8xK+0tj0NutYwwWOBqQ=;
 b=RF9ZURDGfRSF+updYdKkNB5BM+3F/J/6bUEDDWKUlOaSwuAJ+NzwKnBJYzq9ulkloL
 2J7QNlM5jFiBLL4KAnrjmS4lAS9yzd8x3yGCecucu+F1TpKZi9dqnMplYUUOmPtC2c51
 39IAGKl2xgaf4phMdWjyLOXkPFCO7+6p+zcwh7dMTa0KJ7Wc83WifnW3sFRbxJrC2eTv
 moFJhkSgIzR/nroMZ8wCFaoJ1bavmOPvgZWEwv0Ap7ShQsPj0BY4L8/AnNuwR45ZNM/d
 FQXZQFNdHkhFj7SfCwMB9z8odDGEx+K3SGQmR+JfIjH3so6UPxOKtaJVndgbbHCGsRR1
 Hejw==
X-Gm-Message-State: AOJu0Yw9pLzyEMHT3EZhxMxWmWVmSV/VqbfeXCAwq1PtxrFqTyGqIzk2
 XdiuqWPQJujG7NjgTnkvy35MrjRp+xqS7kltFjWY8RhzJ8EkAHtCcAaXBo39K7KUv0PAwrsJWPc
 xquBVlX8YaSMIVck=
X-Received: by 2002:a05:620a:2846:b0:775:c5bb:1df9 with SMTP id
 h6-20020a05620a284600b00775c5bb1df9mr6189314qkp.60.1696520653690; 
 Thu, 05 Oct 2023 08:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd6R1Xc09bYKXpvnfC8BgUk7P9OBJJB6l7XCAfleVWx1C78JVVqTQrhxxjai7WL+LqeswFgQ==
X-Received: by 2002:a05:620a:2846:b0:775:c5bb:1df9 with SMTP id
 h6-20020a05620a284600b00775c5bb1df9mr6189300qkp.60.1696520653421; 
 Thu, 05 Oct 2023 08:44:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a05620a15aa00b007659935ce64sm567861qkk.71.2023.10.05.08.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 08:44:13 -0700 (PDT)
Message-ID: <488abf8d-fc10-45f9-f321-4e3f28208533@redhat.com>
Date: Thu, 5 Oct 2023 17:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 0/3] WIP: ramfb: migration support
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, lersek@redhat.com
References: <20231005113027.1827078-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231005113027.1827078-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 10/5/23 13:30, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> Implement RAMFB migration, and add properties to enable it only on >= 8.2
> machines, + a few related cleanups.
> 
> Cedric, did you get the chance to test the VFIO display/ramfb code?

Done with a :

GPU 00000000:00:03.0
     Product Name                          : GRID RTX6000-1Q
     Product Brand                         : NVIDIA RTX Virtual Workstation


rhle9+gdm was running and it looks pretty good after migration.

I would like to go through the models now (I really don't like the
VFIODisplay attributes being in VFIOPCIDevice, it's ugly)

Thanks,

C.


> 
> thanks
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
>   hw/core/machine.c             |  5 +++-
>   hw/display/ramfb-standalone.c | 27 +++++++++++++++++++++
>   hw/display/ramfb.c            | 19 +++++++++++++++
>   hw/vfio/display.c             | 20 ++++++++++++++++
>   hw/vfio/pci.c                 | 44 +++++++++++++++++++++++++++++++++++
>   stubs/ramfb.c                 |  2 ++
>   8 files changed, 123 insertions(+), 1 deletion(-)
> 


