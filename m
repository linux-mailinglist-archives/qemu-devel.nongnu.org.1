Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD747E27B3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:52:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00y4-0005UI-NX; Mon, 06 Nov 2023 09:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r00y0-0005T5-E3
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:52:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r00xy-0004Yc-Ur
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699282358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIxDyJxQEl/51TgOkZ2ol4/HRLZAgmTZ/bWBCwyZYiU=;
 b=NH2tuUnZkO80vHIjUnx9FB9RyURgZ2+h5oz8k1GBTJyRSw75ZomruKxcR5d4izHOYJ8ELq
 rt+Ot3QqV/8Wkj2/vx7pCafZj4/qv3eYN1YDR5KePP8IL5Z6qlolLQzEHCgO1cRb4wsg2K
 iLXeXcw9nZIPOwkhUr1SZG8PvLKUoI0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-CchvNQb2PNenOFiHPjzHxw-1; Mon, 06 Nov 2023 09:52:36 -0500
X-MC-Unique: CchvNQb2PNenOFiHPjzHxw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40837aa4a58so29418385e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699282355; x=1699887155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cIxDyJxQEl/51TgOkZ2ol4/HRLZAgmTZ/bWBCwyZYiU=;
 b=N+YBTCnRaJbBJrSPVZAAzgSJK90WQzjb4zAagziIFN/97uASYB6ThlZnctrqV0wCLV
 gUEoaYSzi9jQvfeh3Wi3M20dhI3gQAMC8ouN0J+Fq/uihT/y/SElF+nhGNqkox/VPhrR
 hg9LYfRDL0qmEOaJSzEXDQmr4ocQPw1EF3p5P8QbCNsuq6C6AWFIYs+zVfC90e6d68E4
 7Qb/BFth1dm1H3Zmsd4keuEAHGJHWcmAi6he7VdxRdlckTytwbQpHf5MXmqE9ccrbd1D
 qqK+3YthkilHnDthClUUXcdXUniFpolAXbLZd3bWFOfO90rKm7kEzMH2b/p7o46Y89+Z
 1t9Q==
X-Gm-Message-State: AOJu0Yy6r+zr6oER4jb/pw6/roBdzr6mIHvg0Fu43tBa/vekbUEeWn/8
 yckn2wimZgKYZANW9wEbvJZx51phkZcg2w6LaO5aNhmeT9pSTmnNeRgCrAC4Lz0vNRFRl34380g
 fQ/uo7rYCLWmFCK0=
X-Received: by 2002:a05:600c:a293:b0:405:29ba:9b5c with SMTP id
 hu19-20020a05600ca29300b0040529ba9b5cmr12375918wmb.16.1699282355590; 
 Mon, 06 Nov 2023 06:52:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE86ibeFFYAuTyq6Tj4cfQ9/uRckNQ1rUnuMdjjEWQQVptHX8B0KSU4u26WSHObEzCjwUXgdA==
X-Received: by 2002:a05:600c:a293:b0:405:29ba:9b5c with SMTP id
 hu19-20020a05600ca29300b0040529ba9b5cmr12375892wmb.16.1699282355265; 
 Mon, 06 Nov 2023 06:52:35 -0800 (PST)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 r7-20020adff107000000b0032db8f7f378sm9754540wro.71.2023.11.06.06.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:52:34 -0800 (PST)
Message-ID: <9b4a3b85-9c5a-4a8f-9482-79bb7607aae0@redhat.com>
Date: Mon, 6 Nov 2023 15:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] block: Convert bdrv_query_block_graph_info to
 coroutine
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Jo=C3=A3o_Silva?=
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-6-farosas@suse.de>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230609201910.12100-6-farosas@suse.de>
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

On 09.06.23 22:19, Fabiano Rosas wrote:
> We're converting callers of bdrv_get_allocated_file_size() to run in
> coroutines because that function will be made asynchronous when called
> (indirectly) from the QMP dispatcher.
>
> This function is a candidate because it calls bdrv_do_query_node_info(),
> which in turn calls bdrv_get_allocated_file_size().
>
> All the functions called from bdrv_do_query_node_info() onwards are
> coroutine-safe, either have a coroutine version themselves[1] or are
> mostly simple code/string manipulation[2].
>
> 1) bdrv_getlength(), bdrv_get_allocated_file_size(), bdrv_get_info(),
>     bdrv_get_specific_info();
>
> 2) bdrv_refresh_filename(), bdrv_get_format_name(),
>     bdrv_get_full_backing_filename(), bdrv_query_snapshot_info_list();
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   block/qapi.c         | 12 +++++++-----
>   include/block/qapi.h |  6 +++++-
>   qemu-img.c           |  2 --
>   3 files changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


