Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D217EEFEB
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 11:17:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3vsz-0006bC-L5; Fri, 17 Nov 2023 05:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r3vsj-0006T9-5O
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:15:27 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r3vsf-00022j-9N
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:15:24 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ce28faa92dso16185595ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 02:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700216108; x=1700820908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BYYmNehUUhi33mj3OOW7nG7/+uUkFUiFSW8Tj2ElYyk=;
 b=j5mFwzP/j5VhLZgYsU8onOALZdg7ZimkneAjoi00Izn8JACB5YGX/r/T8aLKHT2Szm
 P5UzHfUBVQnd9RstUhqXxmm/3PDb8VAG5aVf4PcN29OyKRky3DUVwCg0MGEQdsqHBQvw
 GK9IzZEJDY29QtZxdNnJAxwsZil2EaN46Li8tsVxl32tdw60A7hZ9UfwsOQ7ouJ7lm36
 T++xTjCq9zDL9OnzZ0F4vjC3/pzPNTH+/7ZxAjoqXX/qS57DhE26+t5MjKFa78JAJalp
 6Oq6vaJcOBb2mDatqSkb5hgNPRho5KoMaPuhLV8kHcYGh41k0CO1O17dACj5tuTAJ4zb
 uSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700216108; x=1700820908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYYmNehUUhi33mj3OOW7nG7/+uUkFUiFSW8Tj2ElYyk=;
 b=To0jsPoi21D0JVNy0nHUK0AFZWVZmBzf59vyGPaB94mntG3Sq036N76VIFSAiqS0Zq
 t9c7HKh2iDkZuFiBuoYPz57109KVBIw92tPgCnTC2bT7Egt4uw0lp4xcm5CibpKdHhw2
 74yGbGeHWw213Bg23rXMvpBqFaJKYDuFeBQxfq1xsSHjihGWgTA2q8iBOwY70fnmOSji
 lFe4eQt9S30FV7GZItoZojGCuo1g5mc5OaGLnCQ38pq4XrGO0UJWyXTIP0P6TaH22WYA
 FgdzCia02MrG3ZzMDV0LE5DBbGSl1l8pN3pTHJth/nGrwmszZ7c6OIUduw+OPuC4dsRo
 HwaA==
X-Gm-Message-State: AOJu0YwSaia0NyPJfZTl0c7uSODeWTBXcKSDtsSsEXRjCSi+RUjLYoV1
 s8JqCa2qGx1JQT0nyyf22f+6LA==
X-Google-Smtp-Source: AGHT+IGvP54bSMrkyjknLOhepa7O/vqrMa1t+9/Zu6ERJWD5vMzDQI5kISuWp7dGl5IBec1Akb4SNQ==
X-Received: by 2002:a17:902:9894:b0:1cc:e66:3732 with SMTP id
 s20-20020a170902989400b001cc0e663732mr11523276plp.19.1700216108017; 
 Fri, 17 Nov 2023 02:15:08 -0800 (PST)
Received: from [192.168.68.109] ([152.250.131.148])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a170902f68e00b001ca4ad86357sm1051036plg.227.2023.11.17.02.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 02:15:07 -0800 (PST)
Message-ID: <62bcbb0c-7d24-4363-b068-51fb12aa96d0@ventanamicro.com>
Date: Fri, 17 Nov 2023 07:15:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix SiFive E CLINT clock frequency
Content-Language: en-US
To: =?UTF-8?Q?Rom=C3=A1n_C=C3=A1rdenas?= <rcardenas.rod@gmail.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Alistair.Francis@wdc.com,
 bin.meng@windriver.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
References: <20231117082840.55705-1-rcardenas.rod@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231117082840.55705-1-rcardenas.rod@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 11/17/23 05:28, Román Cárdenas wrote:
> If you check the manual of SiFive E310 (https://cdn.sparkfun.com/assets/7/f/0/2/7/fe310-g002-manual-v19p05.pdf),
> you can see in Figure 1 that the CLINT is connected to the real time clock, which also feeds the AON peripheral (they share the same clock).
> In page 43, the docs also say that the timer registers of the CLINT count ticks from the rtcclk.
> 
> I am currently playing with bare metal applications both in QEMU and a physical SiFive E310 board and
> I confirm that the CLINT clock in the physical board runs at 32.768 kHz.
> In QEMU, the same app produces a completely different outcome, as sometimes a new CLINT interrupt is triggered before finishing other tasks.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1978
> 
> Signed-off-by: Román Cárdenas <rcardenas.rod@gmail.com>
> ---


As I said in an earlier version, it would be nice if someone from Sifive could give
an ACK/NACK for this change.

For now:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>




>   hw/riscv/sifive_e.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 0d37adc542..87d9602383 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -225,7 +225,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>               RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> -        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
> +        SIFIVE_E_LFCLK_DEFAULT_FREQ, false);
>       sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
>   
>       /* AON */

