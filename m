Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A99B75F2A7
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:17:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsc1-0007EG-Tw; Mon, 24 Jul 2023 06:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNsby-0007CC-2K
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNsbw-0001w8-Dv
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690193775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UoFCc3Ynvml8yhPIc5IYDX+TKQVQRfGTwKLJIqqHKA0=;
 b=cd8dqqSRjhKE4Qcp2lBgLFSndhyNEDaqvs5y9OyK1G/2ianlwekvd5H6NNpAtiUsLcpBxl
 nzBADurn63ZKLFywKl+vhu4dV5NPfPPe02aHbgWg2opBuBc5Wk791coFuvVI8mQEXnVJ6t
 JFZx86mBY/bcIXBKXgROTSMdntHkmao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-UfUdY5AHMTKkJSwmELxO2w-1; Mon, 24 Jul 2023 06:16:14 -0400
X-MC-Unique: UfUdY5AHMTKkJSwmELxO2w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fd2e59bc53so7410045e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193773; x=1690798573;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UoFCc3Ynvml8yhPIc5IYDX+TKQVQRfGTwKLJIqqHKA0=;
 b=kYg7LXhBKfiWCFy70XDB+YsoR0buuGQRoCdJqy3G7kmq84L5BiFMPlCpf+33F4YzEQ
 47XcX0tC2YBdkXPRaTBLAGN5e7QinYvJ1SuVO0mCdhvYyCNWz0ckA2pchxK5N+Yrzj7E
 flM6bCUqz6pzc3C7lKrnxIqpzYssdjyNYtCBSmAvdQuqYttX1ry5mxry5MFuwOKGAzKT
 ZxbhoxBEFpg3X0gcIu/iZC2ZRVUO7fGwx1wduCWdLOT54nl7Vky8bj2ZcE/qSbxWaSaj
 eVVHfzPLF7YDsBIn7pVBmAxJeO1EDqacxzUi7smS9mMYzZ3CsFdewKxJBIk1MkIS0YaE
 Kgfg==
X-Gm-Message-State: ABy/qLYQ3oHmnQHFnP42w/aAT2yNLHKfj42xHRh8P2/v3J7WeVuYp3gv
 6qYXqThU77Yxc6si6oKgvl6M/tuiq/3URLxDcRQQ2spiDJkH2p3z3GSXUiWZzAaQGm1ODgCEv6g
 G2/4+ZOs9f92Aoj8=
X-Received: by 2002:a05:600c:228d:b0:3f5:878:c0c2 with SMTP id
 13-20020a05600c228d00b003f50878c0c2mr5774189wmf.3.1690193773145; 
 Mon, 24 Jul 2023 03:16:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFmLwQr1v4x5ncMd/moQSP2H5QPt7WjbsS8U9sfTWt7IvFpBMq2q4dmUsAx08VSpEcqIqL0RA==
X-Received: by 2002:a05:600c:228d:b0:3f5:878:c0c2 with SMTP id
 13-20020a05600c228d00b003f50878c0c2mr5774166wmf.3.1690193772871; 
 Mon, 24 Jul 2023 03:16:12 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-165.web.vodafone.de.
 [109.43.177.165]) by smtp.gmail.com with ESMTPSA id
 e22-20020a5d5956000000b003063db8f45bsm12431554wri.23.2023.07.24.03.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 03:16:12 -0700 (PDT)
Message-ID: <5a8e9611-2384-f4b3-193a-f579aa4b5409@redhat.com>
Date: Mon, 24 Jul 2023 12:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw: Add compat machines for 8.2
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230718142235.135319-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230718142235.135319-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 18/07/2023 16.22, Cornelia Huck wrote:
> Add 8.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/arm/virt.c              |  9 ++++++++-
>   hw/core/machine.c          |  3 +++
>   hw/i386/pc.c               |  3 +++
>   hw/i386/pc_piix.c          | 16 +++++++++++++---
>   hw/i386/pc_q35.c           | 14 ++++++++++++--
>   hw/m68k/virt.c             |  9 ++++++++-
>   hw/ppc/spapr.c             | 15 +++++++++++++--
>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>   include/hw/boards.h        |  3 +++
>   include/hw/i386/pc.h       |  3 +++
>   10 files changed, 79 insertions(+), 10 deletions(-)
...
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4516d73ff5fc..c52a1fcf6700 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -828,14 +828,26 @@ bool css_migration_enabled(void)
>       }                                                                         \
>       type_init(ccw_machine_register_##suffix)
>   
> +static void ccw_machine_8_2_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_8_2_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(8_2, "8.2", true);
> +
>   static void ccw_machine_8_1_instance_options(MachineState *machine)
>   {
> +    ccw_machine_8_2_instance_options(machine);
>   }
>   
>   static void ccw_machine_8_1_class_options(MachineClass *mc)
>   {
> +    ccw_machine_8_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>   }
> -DEFINE_CCW_MACHINE(8_1, "8.1", true);
> +DEFINE_CCW_MACHINE(8_1, "8.1", false);
>   
>   static void ccw_machine_8_0_instance_options(MachineState *machine)
>   {

s390 part:
Reviewed-by: Thomas Huth <thuth@redhat.com>


