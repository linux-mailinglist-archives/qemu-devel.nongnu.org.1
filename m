Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDE713601
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 20:06:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2yIR-0003l3-AT; Sat, 27 May 2023 14:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q2yIP-0003kY-9s; Sat, 27 May 2023 14:05:41 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q2yIN-00064i-Lw; Sat, 27 May 2023 14:05:41 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-546ee6030e5so970413eaf.3; 
 Sat, 27 May 2023 11:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685210738; x=1687802738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=USOBuNTApRc1YMh5moY8BsHImml+HHWm9FcW15mJbrM=;
 b=Jxtqnk3P+cWxvV89oW+4swH67Lbq++B8vUjxIt/kEMRJgAMgwL+QfWCVgC7VKEZbJW
 +PkKsc6onF5Fq9oJG6nvhzKLvT0CTkMbooWjqHz992i/xTbTndhYD8/R0wg1lUAsxMLv
 2rtZPHnYWBAq0MpzDYOQdYwUSgG/QexkVhxcWhJst8PT6A8eXBygX3GL3S6F34A9NwY0
 7EIStzLTT9q0FYI9bjuPc36t7SCegtvD7GtP5jKiECqv0qLJKWfAYe/s544Gr9vLxuRu
 YxM9Z0CTuyOqgi2uhYTQehiyVcuwXw2TJSeKjnQnWlvgSX5rjsVeHjUHBmGjo+kkMv/+
 DAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685210738; x=1687802738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USOBuNTApRc1YMh5moY8BsHImml+HHWm9FcW15mJbrM=;
 b=ClS393DJy0OL2CrYesuFlMU+lUatOl2d0tYqK1WyuQzYwYVqS37t9mLTwAaOWW1wgg
 CSfcCscka9+3a4AlFQi6ecG9Lq9V5DyZps5mZx1NqZvImTd1SObeWF92FvxQb4G1aP4m
 CgR1bGDAObf0/yR8GRouQgWuOU8BZGTQsio/JBpeQTjLnainSiynCpYfa6Zh7hqyzEJS
 bm2ggi3vyuzLLm89CnuERg7D8UUebKzvv2CoavsbvMEDJDV8nnw7esxzXqUN+nUYJxC9
 el0lpYhIx6LWQdecnPLUddRuJZj/AzECVMUtJKH5CJfTTW9gqzYjzrGoWjD42oTWL3NH
 b1KQ==
X-Gm-Message-State: AC+VfDwoBysSHvewyJTUW4zSwrGzMUuij4jvW+r/5oSqDXrnQOmrvOFY
 bW6/kTPN5RDr2tzUX9G0Y2phLLNPcWw=
X-Google-Smtp-Source: ACHHUZ7wliH6+jijdmBcZGNScDI3B+K47pWhXoXL67oVunuEiJtmWbnibv42oMIiw2lALqS7zQMRkQ==
X-Received: by 2002:a05:6808:2a4e:b0:398:4409:52f9 with SMTP id
 fa14-20020a0568082a4e00b00398440952f9mr3040882oib.33.1685210738043; 
 Sat, 27 May 2023 11:05:38 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 y9-20020acae109000000b003985cac8820sm3003346oig.16.2023.05.27.11.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 May 2023 11:05:37 -0700 (PDT)
Message-ID: <dee25aee-5d4f-fb49-250d-b752e64cd9da@gmail.com>
Date: Sat, 27 May 2023 15:05:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/9] target/ppc: Assorted ppc target fixes
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230515092655.171206-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230515092655.171206-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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



On 5/15/23 06:26, Nicholas Piggin wrote:
> Hopefully these are getting close to ready now. There is still the
> question about doing better with adding test cases for all this, I
> haven't exactly got a good answer yet but I do have kvm-unit-tests
> for most at least.

Patches 1 and 4 queued to ppc-next. Thanks,


Daniel

> 
> Thanks,
> Nick
> 
> Nicholas Piggin (9):
>    target/ppc: Fix width of some 32-bit SPRs
>    target/ppc: Fix PMU MMCR0[PMCjCE] bit in hflags calculation
>    target/ppc: Fix instruction loading endianness in alignment interrupt
>    target/ppc: Alignment faults do not set DSISR in ISA v3.0 onward
>    target/ppc: Change partition-scope translate interface
>    target/ppc: Add SRR1 prefix indication to interrupt handlers
>    target/ppc: Implement HEIR SPR
>    target/ppc: Add ISA v3.1 LEV indication in SRR1 for system call
>      interrupts
>    target/ppc: Better CTRL SPR implementation
> 
>   target/ppc/cpu.h         |  1 +
>   target/ppc/cpu_init.c    | 41 +++++++++++++----
>   target/ppc/excp_helper.c | 98 ++++++++++++++++++++++++++++++++++++----
>   target/ppc/helper_regs.c |  2 +-
>   target/ppc/misc_helper.c |  4 +-
>   target/ppc/mmu-radix64.c | 38 +++++++++++-----
>   target/ppc/power8-pmu.c  |  6 ++-
>   target/ppc/translate.c   |  9 +++-
>   8 files changed, 164 insertions(+), 35 deletions(-)
> 

