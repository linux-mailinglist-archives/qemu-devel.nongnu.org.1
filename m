Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFC473B3A3
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:33:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCdAB-0007Wy-3h; Fri, 23 Jun 2023 05:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qCdA8-0007WO-UU
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qCdA7-0000Yx-Hi
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687512782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzVk8n55qnQZ6xdIFDsAKSnJgIGSLauyw5E4sjo0gSY=;
 b=PQNv/cZUdc3VguhHMscss2X8sqsyJEwFY1OKi2GJTGpaxkgnUV0v/Ok3e6rd9NefzETbtT
 EVdE0qepMR/X7HxjhOtoGV136GQFMwtehqp05rnwvJXnqb8s5F224DK1LWCwkrHPQK97rA
 +suhmSWqeyIZv5HJm+U+dHyH6Kz2iH0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-oq5ji4jhPAK0HYEEc5sx-w-1; Fri, 23 Jun 2023 05:33:00 -0400
X-MC-Unique: oq5ji4jhPAK0HYEEc5sx-w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b58ff05fcbso5071031fa.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 02:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687512779; x=1690104779;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vzVk8n55qnQZ6xdIFDsAKSnJgIGSLauyw5E4sjo0gSY=;
 b=dKHkmDqO8jkFi4PDr7Z2clQR/aLAylwtc/0bxoXuosoU/sQ6O1mvPedpKTwRwDlF6F
 vjPj3+cDrejBDhqe2ERz4he6nd8tcwPMC+9I90zOqFzZ4EFW9YC1gArgM59zAcF7cpWL
 0gdlMzr6ApWqmz0Wzf1ombcaaEoCYeI1oVo6z3OItZJjCZ5lLUhHPfn9jhRTutO9ckq5
 6h345v0724t4a+P0fZQteP44A21LRUD6plTf+ObLjO9Qkn5/HdDP4gUpfPW4OQo8cHi5
 QZWf5wqqvdjZ88gEnknFmhkCDUT1NpJQVK3HRZMSgTXdC3KvzYIMJvCuyCMj24lXcOfl
 GZOg==
X-Gm-Message-State: AC+VfDxDKl1RPJAbzJLHjyCTgxJUmLLHFCptV+rnsQ3gHiURiOwgr6Mc
 m9Gjhp4jyRYEcDPx20o/M386A9SLdIiYprzIJI4ArkZ8c4WYLOiM0CZDZNVK6HVsofgcLfLMgoi
 xsLiA6i8cJEqWCDo=
X-Received: by 2002:a2e:8705:0:b0:2b5:947f:501 with SMTP id
 m5-20020a2e8705000000b002b5947f0501mr2785151lji.30.1687512779511; 
 Fri, 23 Jun 2023 02:32:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Sjn91sEK8J+TUXGmCDfrRb3CA7K7huUYjYO5pGS7QCzPHv6rrzBLB0W84mBCJ9fgrlGETAA==
X-Received: by 2002:a2e:8705:0:b0:2b5:947f:501 with SMTP id
 m5-20020a2e8705000000b002b5947f0501mr2785137lji.30.1687512779198; 
 Fri, 23 Jun 2023 02:32:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a1c720c000000b003f90b58df65sm1783541wmc.29.2023.06.23.02.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 02:32:58 -0700 (PDT)
Message-ID: <e2af1fa6-75f2-0df3-19e7-44432cc6d672@redhat.com>
Date: Fri, 23 Jun 2023 11:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/ppc: Better CTRL SPR implementation
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230620131523.169340-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230620131523.169340-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
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

On 6/20/23 15:15, Nicholas Piggin wrote:
> The CTRL register is able to write the bit in the RUN field, which gets
> reflected into the TS field which is read-only and contains the state of
> the RUN field for all threads in the core.
> 
> TCG does not implement SMT, so the correct implementation just requires
> mirroring the RUN bit into the first bit of the TS field.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Applied to ppc-next.

Thanks,

C.



> ---
> This is also unchanged from last posting except improved changelog.
> The pseries TCG SMT patches depend on this one, but it is good to go
> by itself too (this is what CTRL appears like to hardware KVM guest).
> 
> Thanks,
> Nick
> 
>   target/ppc/translate.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b591f2e496..1ade063616 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -418,7 +418,14 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
>   
>   void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
>   {
> -    spr_write_generic32(ctx, sprn, gprn);
> +    /* This does not implement >1 thread */
> +    TCGv t0 = tcg_temp_new();
> +    TCGv t1 = tcg_temp_new();
> +    tcg_gen_extract_tl(t0, cpu_gpr[gprn], 0, 1); /* Extract RUN field */
> +    tcg_gen_shli_tl(t1, t0, 8); /* Duplicate the bit in TS */
> +    tcg_gen_or_tl(t1, t1, t0);
> +    gen_store_spr(sprn, t1);
> +    spr_store_dump_spr(sprn);
>   
>       /*
>        * SPR_CTRL writes must force a new translation block,


