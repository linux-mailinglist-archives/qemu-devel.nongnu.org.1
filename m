Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6807E287F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:17:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01LW-0002Y4-UL; Mon, 06 Nov 2023 10:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r01LT-0002Xc-Dh
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r01LQ-0001Dr-I5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699283812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmLsRaB8PRcua37YUV7M8AZpBFx0/KnHp+IpCnbemPE=;
 b=icYNDRDOd+Q/rzUa9k4rARETfp/Quaa7TEHua2aofqQmOTraELBkPjNF5ZNGv+H0fnuiNp
 WkmpybHu+VS7GsTCJURIWD/Mzz7nLGNSdI8ZRFVOhmmodwUQIxzOWWJ6Lhz2Oo0k4NdPKi
 vftIgVCOHhdlCwiEmg70/p1P7iPbTeo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-Iah9-0FwOBuW4rGRKarXEQ-1; Mon, 06 Nov 2023 10:16:33 -0500
X-MC-Unique: Iah9-0FwOBuW4rGRKarXEQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c6ed315cc3so47173811fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699283790; x=1699888590;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FmLsRaB8PRcua37YUV7M8AZpBFx0/KnHp+IpCnbemPE=;
 b=feMzjsJW/Cb5DNnFojJMsZWbG9LMLJfdwWRTaKFxf9tFiCvDG3o0uq3J5QL/nE8TNC
 XFIJGHc+TMrEJt+ELF/sCOj0kZ/kmcXLePFbv1HzyQBcEEFeiqMKo9pki9Yb5zJe31BO
 IGc6NIt5IJmEy4Dbu+fZA+4ziSL5BpRRZRo2EPOeRtFH32yIhsekExpdQmpYTjkypof8
 jUyxNDRQi8Vl69f/jqfFZ7Mk25VecEnxkIbRGvY6BNI8ndB8z8Me7njnwOKOGd+95plb
 LyrwXcQEaI1tHswBJB7Ujm2qJUex8dYi8uLoOf3/SuJQQxfTeQ1saX4vRHh/q+/fMM3d
 ez0A==
X-Gm-Message-State: AOJu0YwNzZrslDGQKVMShMCOLjbIz2dZA0bHkevpBTVmK5DwHhwFGh4m
 G19vgaq/hfaxvzbZ5v7LJeHEOlrirTpqVBOtvwYQGFlP/wnAuHt/H3wSdF3wDaQ71xemSFlYww0
 t1jk7/A0siL6RcjI=
X-Received: by 2002:a2e:ba9e:0:b0:2c5:1867:b0bd with SMTP id
 a30-20020a2eba9e000000b002c51867b0bdmr19143025ljf.23.1699283790465; 
 Mon, 06 Nov 2023 07:16:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXfIl/s5zC4BwTf0z0nmIwP//dqD1HqGr5gLyKphPMRKYrUigv9aCTugGquwKODJj8NlkG7w==
X-Received: by 2002:a2e:ba9e:0:b0:2c5:1867:b0bd with SMTP id
 a30-20020a2eba9e000000b002c51867b0bdmr19143009ljf.23.1699283790168; 
 Mon, 06 Nov 2023 07:16:30 -0800 (PST)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 az25-20020a05600c601900b004095874f6d3sm12888971wmb.28.2023.11.06.07.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:16:29 -0800 (PST)
Message-ID: <499f3f71-5c3e-4a82-a89c-f6d32aaa837b@redhat.com>
Date: Mon, 6 Nov 2023 16:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] file-posix: fix over-writing of returning zone_append
 offset
Content-Language: en-US
To: Naohiro Aota <nao.aota@gmail.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Naohiro Aota <naohiro.aota@wdc.com>
References: <20231030073853.2601162-1-naohiro.aota@wdc.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231030073853.2601162-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30.10.23 08:38, Naohiro Aota wrote:
> raw_co_zone_append() sets "s->offset" where "BDRVRawState *s". This pointer
> is used later at raw_co_prw() to save the block address where the data is
> written.
>
> When multiple IOs are on-going at the same time, a later IO's
> raw_co_zone_append() call over-writes a former IO's offset address before
> raw_co_prw() completes. As a result, the former zone append IO returns the
> initial value (= the start address of the writing zone), instead of the
> proper address.
>
> Fix the issue by passing the offset pointer to raw_co_prw() instead of
> passing it through s->offset. Also, remove "offset" from BDRVRawState as
> there is no usage anymore.
>
> Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   block/file-posix.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)

Thanks, applied to my block branch:

https://gitlab.com/hreitz/qemu/-/commits/block

Hanna


