Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3B680CB12
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:32:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgNv-0007p1-CI; Mon, 11 Dec 2023 08:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rCgNR-0007W1-F3
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:31:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rCgNP-00023p-Mc
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702301473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fSGa+5i1uNXr7nnTylYsl41Odsjo0hFQ2bfEIYNPiU=;
 b=DhkddSvWDGMtPuzYlzXy1vfInDDOVqq/pbtHab0c0flZoo+/4uqijaasou/Df0WWCZ/oqC
 dFLg5oZB8JoRYbKE+LqJk84/bJoccadgYHY2NJvcyD8Atlgfw66bvxffohzOyq2+sQikgm
 38md3Xboz1ZW7igmCvrMsBEeTOq8qSM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-UIEPRebVPxar6P38Rt_HZg-1; Mon, 11 Dec 2023 08:31:12 -0500
X-MC-Unique: UIEPRebVPxar6P38Rt_HZg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-67ac7372fd8so56965076d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702301472; x=1702906272;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9fSGa+5i1uNXr7nnTylYsl41Odsjo0hFQ2bfEIYNPiU=;
 b=YrptY2iNXH/42DGuAWx4VA9lN5vGfpNTN8pdV/rH+L1/Onxaegh+N+T+H6ESz/J9d5
 gHdz5DySe52vg/kmeQEOtjNZzlNy7qisDAT/DK2MuYQm9sAdtqq/K5ziOp2KhRlCQY0L
 d0Eb8oSxVt6xw9pd3U2mfsI6XwNpMYf1Yo35pQNHykNabVrJxKKX2O8B3yxNCldHnBIL
 m3bdD3YoYQ2YT53yhbjtZfWKUReOrINu8d23z+aGYbIcZOl+AkZXada2pn1/Ovws6AjR
 CfIDES8I8dQVj0iTmYkhq6ntHcNINUJTGXZlttKwI3oggxZXVxMYu6SP1S3rgLicFDe2
 dACA==
X-Gm-Message-State: AOJu0YwqybN3FEwBtCKlNYdIPc7fKCc7lyR5Y38odjWQaDstwS+FwCim
 /vdp7Dga0UP6JX00pj4/IjhAdTVrh7Gs9+OOU0ArNaZ2cLgQ1w6wDlJLfo6XvJ9/bjkZoAsDOYQ
 o3pny8Mi8DdJIswk=
X-Received: by 2002:a0c:ee84:0:b0:67a:a721:7824 with SMTP id
 u4-20020a0cee84000000b0067aa7217824mr5084272qvr.73.1702301471862; 
 Mon, 11 Dec 2023 05:31:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED36wjXTiwTvTlXSlI+sJqhhRNaCZ8HhnC5vmJGdMsOdKJzBgGybPnt3xKZN9E7OE1HIR5ZA==
X-Received: by 2002:a0c:ee84:0:b0:67a:a721:7824 with SMTP id
 u4-20020a0cee84000000b0067aa7217824mr5084266qvr.73.1702301471600; 
 Mon, 11 Dec 2023 05:31:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 mg20-20020a056214561400b0067a41ed5541sm3250424qvb.64.2023.12.11.05.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 05:31:11 -0800 (PST)
Message-ID: <0d11ec9c-ca9f-4135-b723-8155d7d7279c@redhat.com>
Date: Mon, 11 Dec 2023 14:31:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/memory.c: support unaligned access
Content-Language: en-US
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <20231211071204.30156-2-tomoyuki.hirose@igel.co.jp>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231211071204.30156-2-tomoyuki.hirose@igel.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello,

On 12/11/23 08:12, Tomoyuki HIROSE wrote:
> The previous code ignored 'impl.unaligned' and handled unaligned accesses
> as is. But this implementation cannot emulate specific registers of some
> devices that allow unaligned access such as xHCI Host Controller Capability
> Registers.
> This commit checks 'impl.unaligned' and if it is false, QEMU emulates
> unaligned access with multiple aligned access.
> 
> Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>

FWIW, there has been a previous proposal for unaligned accesses support [1].

Thanks,

C.

[1] https://lore.kernel.org/qemu-devel/20170630030058.28943-1-andrew@aj.id.au/


> ---
>   system/memory.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 798b6c0a17..b0caa90fef 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -539,6 +539,9 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>       unsigned i;
>       MemTxResult r = MEMTX_OK;
>       bool reentrancy_guard_applied = false;
> +    hwaddr aligned_addr;
> +    unsigned corrected_size = size;
> +    signed align_diff = 0;
>   
>       if (!access_size_min) {
>           access_size_min = 1;
> @@ -560,18 +563,25 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>           reentrancy_guard_applied = true;
>       }
>   
> -    /* FIXME: support unaligned access? */
>       access_size = MAX(MIN(size, access_size_max), access_size_min);
>       access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> +    if (!mr->ops->impl.unaligned) {
> +        aligned_addr = addr & ~(access_size - 1);
> +        align_diff = addr - aligned_addr;
> +        corrected_size = size < access_size ? access_size :
> +                            size + (align_diff > 0 ? access_size : 0);
> +        addr = aligned_addr;
> +    }
>       if (memory_region_big_endian(mr)) {
> -        for (i = 0; i < size; i += access_size) {
> +        for (i = 0; i < corrected_size; i += access_size) {
>               r |= access_fn(mr, addr + i, value, access_size,
> -                        (size - access_size - i) * 8, access_mask, attrs);
> +                        (size - access_size - i + align_diff) * 8,
> +                        access_mask, attrs);
>           }
>       } else {
> -        for (i = 0; i < size; i += access_size) {
> -            r |= access_fn(mr, addr + i, value, access_size, i * 8,
> -                        access_mask, attrs);
> +        for (i = 0; i < corrected_size; i += access_size) {
> +            r |= access_fn(mr, addr + i, value, access_size,
> +                        ((signed)i - align_diff) * 8, access_mask, attrs);
>           }
>       }
>       if (mr->dev && reentrancy_guard_applied) {


