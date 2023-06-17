Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2709E734469
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 01:01:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAeuv-0002Jv-Uu; Sat, 17 Jun 2023 19:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAeuj-0002I5-PY
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 19:01:02 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAeuh-0006qu-W6
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 19:01:01 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9827bd8e0afso333445966b.1
 for <qemu-devel@nongnu.org>; Sat, 17 Jun 2023 16:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687042857; x=1689634857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cy27xGiAcRXfgBmx++aR1JaCOJvCFkxE3gynhdtYCfc=;
 b=PrG7Bi3XBvpMlIq5QBnkdgX6R1hmIJjyrlJriZfoJ7++qaFzyFGyQ9hNeVGX1CKCOU
 qgcheExMvAzDLmMbjZ/FbDcjAsSusjObfZdvlVT04QkiaJQP89AoUgPCyybWc88owhKN
 0HA+aRZudasXIUV2m73BQPdj3Pi8Z3QuSKh+afq71jnNUNjq94jYaaGGlcNoASP0RrjL
 wse1hRD3YDXbALsI1AQintkZrOZxgF7J47eApZxZj5U6jYIFcDzEkxJM3xJu+HHt0d3/
 HuRVL8yv/cUKOQjYRBL8JapV4/xscui1uzzhNevWE/msh4GJ1pJmz94QvMn7tXGR+yDx
 wC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687042857; x=1689634857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cy27xGiAcRXfgBmx++aR1JaCOJvCFkxE3gynhdtYCfc=;
 b=c0h4n3UzPFKAZ2UlikR5l6DdDEuuK1LlYv6EAqxZ1J97GdvwOzBfPAW6OkCnRukD2a
 UZILIbX8MO5sJb2+e0lJv/0RIb7aqHthGZomiB1Da99VSizAN6T/BeXy1+ouWw+qfSFL
 lNp5B47G1+EpPBLt6JvwLsfu7J0rA3h8zvr/cUKuL7Hu6fCoyee0XX85efkEaU/ABsMT
 AyrGbxxgB6rYMy/DGALc2CxzG6zhEV+BvvXqXi+KjhqtmY4k7yPIOiyTKyxoS/pyVJ0G
 KysWrdWJN7QCj1C5qUmVuyYvxaqEI4eS+1C0pfW9jviyUkSDrCbkcBf0QHPPfirTOw2O
 qTiQ==
X-Gm-Message-State: AC+VfDyVerDBxmna5pHAWL1Zt9yYkAQLnw/NbhIiMa8ghPjSnt/jdXmW
 1U6aB4/97ccuu12ajjyOqSK/Cw==
X-Google-Smtp-Source: ACHHUZ4+KKaB4KOO7YWhTgg76gHBaX0eo6R9EPi+m7re2GMxmcyiajmNTgjZ6YM/9EfPOSQghK8AbA==
X-Received: by 2002:a17:907:7e9f:b0:988:7ccc:3e11 with SMTP id
 qb31-20020a1709077e9f00b009887ccc3e11mr72762ejc.24.1687042856872; 
 Sat, 17 Jun 2023 16:00:56 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.220])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a5d43d2000000b0030ae93bd196sm27212824wrr.21.2023.06.17.16.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Jun 2023 16:00:56 -0700 (PDT)
Message-ID: <e3705cba-d57d-27f7-aa1e-ad4a3c0bfe52@linaro.org>
Date: Sun, 18 Jun 2023 01:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2] kvm: reuse per-vcpu stats fd to avoid vcpu interruption
Content-Language: en-US
To: Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>
References: <ZIiz8R3F76VqTmKO@tpad> <87h6rab8gv.fsf@pond.sub.org>
 <ZIyffW2qasdS4PVN@tpad>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZIyffW2qasdS4PVN@tpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Marcelo,

On 16/6/23 19:44, Marcelo Tosatti wrote:
> 
> A regression has been detected in latency testing of KVM guests.
> More specifically, it was observed that the cyclictest
> numbers inside of an isolated vcpu (running on isolated pcpu) are:
>                                              
> # Max Latencies: 00090 00096 00141
>    
> Where a maximum of 50us is acceptable.
>                     
> The implementation of KVM_GET_STATS_FD uses run_on_cpu to query
> per vcpu statistics, which interrupts the vcpu (and is unnecessary).
>                  
> To fix this, open the per vcpu stats fd on vcpu initialization,
> and read from that fd from QEMU's main thread.
>               
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>


>   static void query_stats(StatsResultList **result, StatsTarget target,
> -                        strList *names, int stats_fd, Error **errp)
> +                        strList *names, int stats_fd, CPUState *cpu,
> +                        Error **errp)
>   {
>       struct kvm_stats_desc *kvm_stats_desc;
>       struct kvm_stats_header *kvm_stats_header;
> @@ -4096,7 +4099,7 @@ static void query_stats(StatsResultList **result, StatsTarget target,
>           break;
>       case STATS_TARGET_VCPU:
>           add_stats_entry(result, STATS_PROVIDER_KVM,
> -                        current_cpu->parent_obj.canonical_path,
> +                        cpu->parent_obj.canonical_path,

Can we get a NULL deref here ...

>                           stats_list);
>           break;
>       default:


>   static void query_stats_cb(StatsResultList **result, StatsTarget target,
> @@ -4180,7 +4180,7 @@ static void query_stats_cb(StatsResultList **result, StatsTarget target,
>               error_setg_errno(errp, errno, "KVM stats: ioctl failed");
>               return;
>           }
> -        query_stats(result, target, names, stats_fd, errp);
> +        query_stats(result, target, names, stats_fd, NULL, errp);

... from here?

>           close(stats_fd);
>           break;
>       }


