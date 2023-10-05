Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FAA7B9CE0
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:02:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoN31-00018e-IB; Thu, 05 Oct 2023 08:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qoN2r-00012n-ED
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qoN2d-0003l2-O6
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696507278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jexq7gQh3FaGSrn3SYANGNmFTKn/QgwixVvTCWC0WoU=;
 b=FuWdh8C0D5oz32TucJS6czJ/MUSFkE/pvYGB2tkmZT/e+g73eMcYOFi9UZWsA18APtXXOb
 9saIBudAfOaxWgwfb4o47Dd1g3cQvUcDeuNRJVQ4+myLfpEoKYv8flnuVngvHHk5Nyc0QR
 VWrOtlnxAP+FtH+QrDIpoYxPnyUnjh8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-a-UW02DtPfeCgJlhv2xKRA-1; Thu, 05 Oct 2023 08:01:12 -0400
X-MC-Unique: a-UW02DtPfeCgJlhv2xKRA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65d3df97d7fso8043756d6.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696507271; x=1697112071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jexq7gQh3FaGSrn3SYANGNmFTKn/QgwixVvTCWC0WoU=;
 b=evNO2IL4PeUtnUpFNTUIjOBd4EBw2QY5e16+nScHT+iyzkCHVUmpwYGB/A1p8RtaBB
 GyPvt2ih411u21TsJ6JrEvlRoVfm5JC2dM4doxhlSfKx/aBRk/k4mdkIxu2N9/Cfm+Xz
 GSd0XPK0EvUocQ8bLVvKXQTFOhwfzDtGh4poXGYdgdLFM7jmvuUkIu6BQRCfTSOnNBp1
 LJMIcSusi9rqYsBY4i8G58J/ilQsuFYj07VLZJLPvH6as5ELVp60l0pyn/Vv2J2i7Rl6
 hckVUI+DyKbkevKGy5RNH2xQi8nUlJFtuwdsFwq8/zn5sJYitPKFId1iwVx7bwLupFim
 Dq1Q==
X-Gm-Message-State: AOJu0Yw/2l8P8nVNeX5x09AwhUvjZwZmX8K4YEUQUdDY94/0KTEvp86V
 Mh0K/kXyVk4CLXZYriDN/Y2FKIZihF3QUL32DObJnX+RmQjhLssQ0/+NMaxo4rwgDIFQN+w6HtL
 c4NefLEy9p/4OBxQ=
X-Received: by 2002:a0c:e054:0:b0:65b:1b3d:74b7 with SMTP id
 y20-20020a0ce054000000b0065b1b3d74b7mr4868439qvk.0.1696507271494; 
 Thu, 05 Oct 2023 05:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaiblUC88ZwsDfiwqbnJgPhLMXDX9ySdZPD1GF5FGGRc0XfTsm+XdwN2ox8cKZLXHDoHahvQ==
X-Received: by 2002:a0c:e054:0:b0:65b:1b3d:74b7 with SMTP id
 y20-20020a0ce054000000b0065b1b3d74b7mr4868418qvk.0.1696507271143; 
 Thu, 05 Oct 2023 05:01:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a0ca68a000000b00668eb252523sm444151qva.63.2023.10.05.05.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 05:01:10 -0700 (PDT)
Message-ID: <2907c142-13c1-01ad-f603-e39983d65859@redhat.com>
Date: Thu, 5 Oct 2023 14:01:08 +0200
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

Nope. I was busy with VFIO stuff. I haven't even read Laszlo's
email yet. I will try this or next week.

That said, could we avoid adding another migration property in
VFIOPCIDevice and use the available "enable-migration" ?

C.


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


