Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2364674000B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEAvE-0000IM-B2; Tue, 27 Jun 2023 11:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEAvC-0000GJ-2r
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEAvA-0007ao-Bv
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687880877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7kj9vriGLxM9EGYgOi+U7/NpP+xrnlS9zuBzhIIV4co=;
 b=gvqKd1NITLg+ZHPXtz6lqfjcnDd0SspqwpjO7NxVHKbZSA1eb+qOR5lFU++LGNmthSo5O1
 VkZv7yvexBT/8K/R2ZJFJxU+hcfXcYDQIoH9mPrBYysseaswUwP7fxHY0Quhcla3MyWbVG
 sI/UDsf5CesMqGJAnQlbKvH5emwPLh8=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-HwHXZ2MZPaSX7xmgFUDVeQ-1; Tue, 27 Jun 2023 11:47:55 -0400
X-MC-Unique: HwHXZ2MZPaSX7xmgFUDVeQ-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-4409a468a30so502269137.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 08:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687880875; x=1690472875;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7kj9vriGLxM9EGYgOi+U7/NpP+xrnlS9zuBzhIIV4co=;
 b=Ni5ZAVV2M7s38uf9uj+AW+jBWOdyAAyfL0MfCHnwHcw8bC0eAXSOoEam6nKRbyyOaI
 AJEh9wRZMKf4+8e+0WZmnXiMRumvm6uLFjWTTEq8ZqybyUVQJr8o4r0MCftUgmdle9if
 IBqAkOh44DEoRnY9A3KJo+nkLg3AvBgkB71eDD8HbCZBXG23fJTdYAmCuvTrsYHI4oAj
 19QQkvAu/IZiWa3SufgPyrCPD71hpR2P8CnatWapLDoI4+hThuZOfBNRaK1U9fS+gXDj
 2N/RNu4L4aRCi+Qp3mx1JJXgEE/dDSXvUQBYG3d7MP5/O+OofW0QirCkEVmjI9DXsZIX
 4rmQ==
X-Gm-Message-State: AC+VfDw7zydGkc6mt+RSPHnNvL6ZV0BxDGfOu/S7Il6ta1BnYqfAWW9y
 RYT3Bee9afvNgc8adyKNSx3mQQoSlS5yo5v/tED6U5zLKU1Vgmvyum2mH2V/A84CI3k2rqwqvWR
 zwTEp+qleW74EuFY96Yn6Qcr7elmxBGb3OhKp/qikJi0CHIbnU1rvnCY5Q9ogMqIkQ97u8Ng=
X-Received: by 2002:a67:ea8f:0:b0:443:6b64:aed4 with SMTP id
 f15-20020a67ea8f000000b004436b64aed4mr3209798vso.26.1687880874914; 
 Tue, 27 Jun 2023 08:47:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6amZi7jdPz1smVfMSDUGUBdkiJgHwmCirs1KXmqhfJjOcjDVdp/CyElO+C68Tp83quRoSTRw==
X-Received: by 2002:a67:ea8f:0:b0:443:6b64:aed4 with SMTP id
 f15-20020a67ea8f000000b004436b64aed4mr3209771vso.26.1687880874481; 
 Tue, 27 Jun 2023 08:47:54 -0700 (PDT)
Received: from [192.168.8.100] (tmo-097-60.customers.d1-online.com.
 [80.187.97.60]) by smtp.gmail.com with ESMTPSA id
 dz11-20020ad4588b000000b006263a9e7c63sm4572042qvb.104.2023.06.27.08.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 08:47:53 -0700 (PDT)
Message-ID: <12762727-f870-64c3-e39a-8be2187382ba@redhat.com>
Date: Tue, 27 Jun 2023 17:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] pc-bios/s390-ccw: Move the stack array into start.S
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-4-thuth@redhat.com>
Content-Language: en-US
In-Reply-To: <20230627074703.99608-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 27/06/2023 09.47, Thomas Huth wrote:
> The stack array is only referenced from the start-up code (which is
> shared between the s390-ccw.img and the s390-netboot.img), but it is
> currently declared twice, once in main.c and once in netmain.c.
> It makes more sense to declare this in start.S instead - which will
> also be helpful in the next patch, since we need to mention the .bss
> section in start.S in that patch.
> 
> While we're at it, let's also drop the huge alignment of the stack,
> since there is no technical requirement for aligning it to page
> boundaries.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/s390-ccw.h | 1 -
>   pc-bios/s390-ccw/main.c     | 1 -
>   pc-bios/s390-ccw/netmain.c  | 1 -
>   pc-bios/s390-ccw/start.S    | 6 ++++++
>   4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index b88e0550ab..91afcbbca9 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -55,7 +55,6 @@ void consume_io_int(void);
>   /* main.c */
>   void write_subsystem_identification(void);
>   void write_iplb_location(void);
> -extern char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>   unsigned int get_loadparm_index(void);
>   void main(void);
>   
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index a2def83e82..5506798098 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -17,7 +17,6 @@
>   #include "virtio-scsi.h"
>   #include "dasd-ipl.h"
>   
> -char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>   static SubChannelId blk_schid = { .one = 1 };
>   static char loadparm_str[LOADPARM_LEN + 1];
>   QemuIplParameters qipl;
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 056e93a818..5cd619b2d6 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -50,7 +50,6 @@ void write_iplb_location(void) {}
>   /* STSI 3.2.2 offset of first vmdb + offset of uuid inside vmdb */
>   #define STSI322_VMDB_UUID_OFFSET ((8 + 12) * 4)
>   
> -char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SIZE)));
>   IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
>   static char cfgbuf[2048];
>   
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index 29b0a9ece0..111dea261b 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -120,3 +120,9 @@ external_new_mask:
>       .quad   0x0000000180000000
>   io_new_mask:
>       .quad   0x0000000180000000
> +
> +.bss
> +    .align  8
> +stack:
> +    .space  STACK_SIZE
> +    .size   stack,STACK_SIZE

Sigh, I missed that one of the tcg tests includes start.S ...
I'll include this hunk on top of this patch to get it fixed:

diff --git a/tests/tcg/s390x/head64.S b/tests/tcg/s390x/head64.S
--- a/tests/tcg/s390x/head64.S
+++ b/tests/tcg/s390x/head64.S
@@ -8,6 +8,8 @@
  #include "../../../pc-bios/s390-ccw/start.S"
  #undef main
  
+.text
+
  main_pre:
      aghi %r15,-160                     /* reserve stack for C code */
      brasl %r14,sclp_setup
@@ -24,8 +26,3 @@ success_psw:
      .quad 0x2000180000000,0xfff        /* see is_special_wait_psw() */
  failure_psw:
      .quad 0x2000180000000,0            /* disabled wait */
-
-    .section .bss
-    .align 0x1000
-stack:
-    .skip 0x8000

  Thomas


