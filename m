Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C973B3A1
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCd9K-0006oO-1J; Fri, 23 Jun 2023 05:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qCd9H-0006nW-UE
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qCd9F-00005a-7j
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687512727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFQzJZT9dfLhkv8tshjg5AUmTRtR9P8OSw6i8S3caBo=;
 b=bHL1hKZcpa2uSFXVBupdEfdSl5KcD4iTWno31kZC6Fpnc/v58U2KhXuJEPsCs2WdOQAIFL
 HjhvcDo5S16GtuoGwfEnCPJPKn3iNBPwvaAkLjnsN983eRKvWuHCcc/F5ZRF/3GVnKrvEq
 OoN5bRkEA4s07fEGv7ndG9HRif5EvfA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-ubOOAybwM26Tq6EqcEugHQ-1; Fri, 23 Jun 2023 05:32:04 -0400
X-MC-Unique: ubOOAybwM26Tq6EqcEugHQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3111e2620ebso249979f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 02:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687512723; x=1690104723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFQzJZT9dfLhkv8tshjg5AUmTRtR9P8OSw6i8S3caBo=;
 b=HbjrR6OspM79JlS1PIUFuteaGfoLJAVUygA/eUxIplVAWuDrgUL23IoPy3JGYc4CL/
 +mxa5aUqqWxwwrqXo3Q73PDIYA5Tj6dM90gtS7WV2t/Zu6s/aZsrLOlfoy+f3ETQ3IBa
 TeovBVqCzfOhgA1lrqm8ytP4c3Ljqr84fPsoiCe3+D69k2Z8rCWt6+n7sEFq7+sfvd36
 lY4N+9tJBlSB37l0femVCX1oXIt1uj82vzXWBlpT8NssI1Y1nGbHZWdg1KqqS6YeTbLf
 9d1M6uJ+h4KEMnUUSiK1xZ97f8ETS3ChckLZbh+x6bLV4hktjvAhdPdSb7/WwQN0bKTn
 lG4A==
X-Gm-Message-State: AC+VfDxpj+dlZn4VsZQvbEdAmcnGuGJz9ouqxat8sqvqARgm6uxuX/R7
 QPaCHFSCLCxlx9VkU/8d/MrK7HGr4x1OqTuHWt5zPIrQ+Q76bx/L6R8I+vY+qHNYDiEI3OVVXmS
 UmPbZ3dLTMXCeDCQ=
X-Received: by 2002:a5d:4706:0:b0:30f:d0dd:14a2 with SMTP id
 y6-20020a5d4706000000b0030fd0dd14a2mr3262507wrq.30.1687512723301; 
 Fri, 23 Jun 2023 02:32:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7B5iUidcaSOaL2ZPS2f+QiWUJAw/n5n/aqWwBp79KrQFZQjeXhDcTctK7EfTJHM/y3o7+s9w==
X-Received: by 2002:a5d:4706:0:b0:30f:d0dd:14a2 with SMTP id
 y6-20020a5d4706000000b0030fd0dd14a2mr3262489wrq.30.1687512722988; 
 Fri, 23 Jun 2023 02:32:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a05600012d100b002c71b4d476asm9005051wrx.106.2023.06.23.02.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 02:32:02 -0700 (PDT)
Message-ID: <23c41d54-187e-4ef8-d4b7-e5dde8950933@redhat.com>
Date: Fri, 23 Jun 2023 11:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/ppc: Add ISA v3.1 LEV indication in SRR1 for
 system call interrupts
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230620131321.169261-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230620131321.169261-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/20/23 15:13, Nicholas Piggin wrote:
> System call interrupts in ISA v3.1 CPUs add a LEV indication in SRR1
> that corresponds with the LEV field of the instruction that caused the
> interrupt.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Applied to ppc-next.

Thanks,

C.



> ---
> This is unchanged, just taken out of the bigger series since it is
> independent.
> 
> Thanks,
> Nick
> 
>   target/ppc/excp_helper.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 77bfc18734..c7550fea13 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1591,6 +1591,10 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>               vhc->hypercall(cpu->vhyp, cpu);
>               return;
>           }
> +        if (env->insns_flags2 & PPC2_ISA310) {
> +            /* ISAv3.1 puts LEV into SRR1 */
> +            msr |= lev << 20;
> +        }
>           if (lev == 1) {
>               new_msr |= (target_ulong)MSR_HVB;
>           }


