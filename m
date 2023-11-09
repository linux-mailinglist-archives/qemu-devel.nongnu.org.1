Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 090977E6CAC
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:53:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16Nt-0003G6-Bg; Thu, 09 Nov 2023 09:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16Nj-0003Ez-LX
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:51:44 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16Nf-0002Y5-99
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:51:43 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9d224dca585so162871766b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 06:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699541496; x=1700146296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3HrX/KWJeBvteFE5NUd0xkIf6TT9VRyzGmL269aXGZE=;
 b=tBFVi0X08/7++01K83+Rr6yGREX7guPJdy1QEWRLIFDYVALRP1+TI45rP0sqnM7+aQ
 wiArFgq3tYYtN+2Im+ZsBGNn8zaZSe8uvcOPV55t/HFhzyOF/+r2C6moZ1Kmve46CnV5
 zIlm6PJn2WrPPRmUCeIm84aeSZVWYzJJyo2huVQDUG5DOdaoSzxPpNNxdgyQ4S/0a8hf
 KhBKicI8LpyW7x99M+95rlG94GZz8gvF4VU1X6UcQ4OhRiNQzLHUVRY1wHneuX+2g1u+
 kwAslrFrFFsZboKt88C+gwF++O/RrzRJLPSDYelrvizD8ba6X8N0mM7WuhtsONr541nZ
 G5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699541496; x=1700146296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HrX/KWJeBvteFE5NUd0xkIf6TT9VRyzGmL269aXGZE=;
 b=TpFZZEpv/Fdr3OPomXjEPdOaH/hz7ftY/FNvYAPxdHaRaMfQuZjl2wViPp+JinjdEs
 L7bxSYlR4PRa8S98BnondPmBAdt/AbrMjsIY8F/vzSPkEQAlm2rJw9f4pE+NGY0m4KQ5
 AGWQRX1g+8x/rP+vLIjYZO2lT3KCwzJOyg+vzzICWZKsD5r40BbVolFZVY4PlEFBB5fr
 AzGGvUg3yTaEfUTutFdMfsYH6/YcHSlRHswq4vZD4FeDzOfhoRLuXsw9eB2Kx9otrXDO
 NIDuTGjuaflWHJqAaGzmYxsVHgGwI7D+DoAWuchpFW49Xz9o8yY+GVdP2K2LlIPH3zbp
 Q3ag==
X-Gm-Message-State: AOJu0YwbDaVnPe+1/DL0YDLbpMXpADYRhzXSvMawtcH+CLIVYMFD0/Oy
 5VYXxVj38tJN/zw7ZZuOaB6Qchvl1pD/8fKKSzQM2w==
X-Google-Smtp-Source: AGHT+IE8rIT8+Zg2ZUy/fWqAiGeSOrNouv4vIHBu6O5f0aXqs2GyTlKscnVxF/o67k1rJfAA6wqvPDphkzFEmlR57cM=
X-Received: by 2002:a17:907:74a:b0:9a5:cbb2:3fab with SMTP id
 xc10-20020a170907074a00b009a5cbb23fabmr4374456ejb.2.1699541496207; Thu, 09
 Nov 2023 06:51:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699279190.git.maciej.szmigiero@oracle.com>
 <99a4706ae81efa51b21871af643626730a6719d4.1699279190.git.maciej.szmigiero@oracle.com>
In-Reply-To: <99a4706ae81efa51b21871af643626730a6719d4.1699279190.git.maciej.szmigiero@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 14:51:24 +0000
Message-ID: <CAFEAcA_3viOU99xTUEj1VCd7whUr6ixxpriNjxSrSJejLQx_nw@mail.gmail.com>
Subject: Re: [PULL 06/10] Add Hyper-V Dynamic Memory Protocol driver
 (hv-balloon) hot-add support
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Mon, 6 Nov 2023 at 14:23, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> One of advantages of using this protocol over ACPI-based PC DIMM hotplug is
> that it allows hot-adding memory in much smaller granularity because the
> ACPI DIMM slot limit does not apply.
>
> In order to enable this functionality a new memory backend needs to be
> created and provided to the driver via the "memdev" parameter.
>
> This can be achieved by, for example, adding
> "-object memory-backend-ram,id=mem1,size=32G" to the QEMU command line and
> then instantiating the driver with "memdev=mem1" parameter.
>
> The device will try to use multiple memslots to cover the memory backend in
> order to reduce the size of metadata for the not-yet-hot-added part of the
> memory backend.
>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Hi; I was looking at this code because Coverity reported an
issue in it. I think that's because Coverity has got confused
about the way you're doing memory allocation here. But
in looking at the code I see that you're using alloca() in
this function.

Please could you rewrite this not to do that -- we don't use
alloca() or variable-length-arrays in QEMU except in a few
cases which we're trying to get rid of, so we'd like not to
add new uses to the code base.

> +static void hv_balloon_hot_add_posting(HvBalloon *balloon, StateDesc *stdesc)
> +{
> +    PageRange *hot_add_range = &balloon->hot_add_range;
> +    uint64_t *current_count = &balloon->ha_current_count;
> +    VMBusChannel *chan = hv_balloon_get_channel(balloon);
> +    struct dm_hot_add *ha;
> +    size_t ha_size = sizeof(*ha) + sizeof(ha->range);
> +    union dm_mem_page_range *ha_region;
> +    uint64_t align, chunk_max_size;
> +    ssize_t ret;
> +
> +    assert(balloon->state == S_HOT_ADD_POSTING);
> +    assert(hot_add_range->count > 0);
> +
> +    align = (1 << balloon->caps.cap_bits.hot_add_alignment) *
> +        (MiB / HV_BALLOON_PAGE_SIZE);
> +    if (align >= HV_BALLOON_HA_CHUNK_PAGES) {
> +        /*
> +         * If the required alignment is higher than the chunk size we let it
> +         * override that size.
> +         */
> +        chunk_max_size = align;
> +    } else {
> +        chunk_max_size = QEMU_ALIGN_DOWN(HV_BALLOON_HA_CHUNK_PAGES, align);
> +    }
> +
> +    /*
> +     * hot_add_range->count starts aligned in hv_balloon_hot_add_setup(),
> +     * then it is either reduced by subtracting aligned current_count or
> +     * further hot-adds are prevented by marking the whole remaining our range
> +     * as unusable in hv_balloon_handle_hot_add_response().
> +     */
> +    *current_count = MIN(hot_add_range->count, chunk_max_size);
> +
> +    ha = alloca(ha_size);
> +    ha_region = &(&ha->range)[1];
> +    memset(ha, 0, ha_size);
> +    ha->hdr.type = DM_MEM_HOT_ADD_REQUEST;
> +    ha->hdr.size = ha_size;
> +    ha->hdr.trans_id = balloon->trans_id;
> +
> +    ha->range.finfo.start_page = hot_add_range->start;
> +    ha->range.finfo.page_cnt = *current_count;
> +    ha_region->finfo.start_page = hot_add_range->start;
> +    ha_region->finfo.page_cnt = ha->range.finfo.page_cnt;
> +
> +    trace_hv_balloon_outgoing_hot_add(ha->hdr.trans_id,
> +                                      *current_count, hot_add_range->start);
> +
> +    ret = vmbus_channel_send(chan, VMBUS_PACKET_DATA_INBAND,
> +                             NULL, 0, ha, ha_size, false,
> +                             ha->hdr.trans_id);
> +    if (ret <= 0) {
> +        error_report("error %zd when posting hot add msg, expect problems",
> +                     ret);
> +    }
> +
> +    HV_BALLOON_STATE_DESC_SET(stdesc, S_HOT_ADD_REPLY_WAIT);
> +}

thanks
-- PMM

