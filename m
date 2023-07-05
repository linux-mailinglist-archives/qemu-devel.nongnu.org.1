Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8072C7489D3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 19:05:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5ve-0006hF-Hv; Wed, 05 Jul 2023 13:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qH5vb-0006gX-9R; Wed, 05 Jul 2023 13:04:31 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qH5vZ-0000WC-Gi; Wed, 05 Jul 2023 13:04:30 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b867acbf6dso571492a34.0; 
 Wed, 05 Jul 2023 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688576663; x=1691168663;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vqSFZPOi6iPo5Zc+TQGReXvriGJnZTPZ5ZbZmmY1Jt4=;
 b=bYfMl71+XxJbwSocJb40hS2Wg/YE71nlk5FlP2rdNk68raCXZ9JlQvWFqzdkLZjXHy
 tbLvFh05ZTuEE51fUQ5u7ZUtvcuaB94OIq3ZPFazfx3KcwxW1ZOTI51ytDHHhZSvnNGu
 CK9faZemY7UpX/CZXObjBlcqJEvSA4i0WlnM22Gd87od7ur10XPwmMJ8T7QNibM48y0W
 bhoO/zHboIwPVwhM2WKiKNmorRES8PR3djPEAVjCXqlu123egNPeEGhTXp4z1TTZgxSr
 fl56+0hRStivGroc+np++e0igGU3pmg3ERkJVz6D+Z4PRXHzFTGSCLSvRoyN8SheJLi/
 UUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688576663; x=1691168663;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vqSFZPOi6iPo5Zc+TQGReXvriGJnZTPZ5ZbZmmY1Jt4=;
 b=EuKCL5ybX/lPrFXQSRmf49Tqng+ihvs697eW7XbcUAFZbSLkckkmPtTfpxfvJ13Goy
 ZImK7MDNWst+25E5rHP3lFixVtJAJvq2XCbS44+gZKmXPmckZc2GgwkSfwPOXjOZf4Zb
 zdrC6o1otbMIi0IwY3CM2PavjmKkK8t9si+NlwRWKHr9oqyUQcHzcD1yKclNc7unvZJ1
 bilQeL9MLEpeIhUqbDTnyEN5SpP4yU5RWOEbnSORbjP8H0xppA2sy7ynEfuoQIr/kqte
 ymLoN9xxj538iPYjlAwFOAHxVvvVmz8HQsY/efWhQgOPfIsevxWtLqPJVdH9ppbcnB8r
 7Ttg==
X-Gm-Message-State: ABy/qLZRgGrbMgrUwAcIEvhv7uDsuCFq+2gZtNQBSJKPUIUE258VhgpD
 dPx+n5mQJk/DKqYC/r/sJYk=
X-Google-Smtp-Source: APBJJlFdZgQ3uQgNk/ngKaKOpWX4WBDS2lHInvKZis7wheR9dzB21kpwicF22++f36Wdm+k0qJndGw==
X-Received: by 2002:a9d:65c2:0:b0:6b7:4bea:558b with SMTP id
 z2-20020a9d65c2000000b006b74bea558bmr1392441oth.7.1688576663230; 
 Wed, 05 Jul 2023 10:04:23 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 e2-20020a9d63c2000000b006b8850ad193sm6987468otl.56.2023.07.05.10.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 10:04:22 -0700 (PDT)
Message-ID: <71ebf920-3614-b19d-1623-1dee4a9d716e@gmail.com>
Date: Wed, 5 Jul 2023 14:04:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive: Print CPU target in all TIMA traces
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230705110039.231148-1-fbarrat@linux.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230705110039.231148-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.089,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 7/5/23 08:00, Frederic Barrat wrote:
> Add the CPU target in the trace when reading/writing the TIMA
> space. It was already done for other TIMA ops (notify, accept, ...),
> only missing for those 2. Useful for debug and even more now that we
> experiment with SMT.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>   hw/intc/trace-events | 4 ++--
>   hw/intc/xive.c       | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 5c6094c457..36ff71f947 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -265,8 +265,8 @@ xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64
>   xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
>   xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
>   xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate END 0x%02x/0x%04x data 0x%08x"
> -xive_tctx_tm_write(uint64_t offset, unsigned int size, uint64_t value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
> -xive_tctx_tm_read(uint64_t offset, unsigned int size, uint64_t value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
> +xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
> +xive_tctx_tm_read(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
>   xive_presenter_notify(uint8_t nvt_blk, uint32_t nvt_idx, uint8_t ring) "found NVT 0x%x/0x%x ring=0x%x"
>   xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "END 0x%x/0x%x @0x%"PRIx64
>   
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index c014e961a4..56670b2cac 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -566,7 +566,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>   {
>       const XiveTmOp *xto;
>   
> -    trace_xive_tctx_tm_write(offset, size, value);
> +    trace_xive_tctx_tm_write(tctx->cs->cpu_index, offset, size, value);
>   
>       /*
>        * TODO: check V bit in Q[0-3]W2
> @@ -639,7 +639,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>        */
>       ret = xive_tm_raw_read(tctx, offset, size);
>   out:
> -    trace_xive_tctx_tm_read(offset, size, ret);
> +    trace_xive_tctx_tm_read(tctx->cs->cpu_index, offset, size, ret);
>       return ret;
>   }
>   

