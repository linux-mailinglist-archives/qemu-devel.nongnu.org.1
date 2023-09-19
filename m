Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A37A5C9C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:33:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiW9z-0007PX-TY; Tue, 19 Sep 2023 04:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiW9y-0007NY-3u
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiW9w-0003uH-LJ
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695112360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63ZczgcaSGCgUP2wEYQgRDSu3izo/TIE6nir/nxLkcI=;
 b=gFUc811J24JP3UQvSI+OMZYXYYJw7cb7f4IfTynWt2EU2MHuJoJ6IMvU22lfXXcoZEVPSe
 PBuGmnKZQLUJs4Do4Vj2jnx1QDDQcLw2tjmzBKgiFb4/GJMSmTFJFqFiHXlN/36gWLiTcp
 Xkw+b/3b0s31WgakdRy07T8ei3dHKN4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-CkkVSVUSNQyeaeB19dnbLQ-1; Tue, 19 Sep 2023 04:32:38 -0400
X-MC-Unique: CkkVSVUSNQyeaeB19dnbLQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bcb0f9fe3bso67223281fa.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 01:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695112356; x=1695717156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=63ZczgcaSGCgUP2wEYQgRDSu3izo/TIE6nir/nxLkcI=;
 b=c1ffPJ1xaFIdcartVO9SwvlWdZ+XmxtT/5x5jC9m2tJxsJ3aeiXCAzkmeI7qAWrLRm
 DM4iJatudgkuZ6tnj07fOa9FVIGab+Yuy6ahJFB6SpblKpptjlIPDmeoGnjsMT4LbhW+
 vhGTUqpaXGplYS2DOtxF1lPJBf45jmbgA9kP8wxn8rFKUV7F7R1Qv/vlJu/dmjMlwmbh
 hmxS/XpzbjlAjZdmpbbqjEKUFuyS0H4FNoIsVxRMVxP/gjFqm/gnuYSX8eqYxvt2eB/b
 m5LRvBD7Q5XlrQuOborWPCI/JDVSVJmyOt9XNU8LzhPI8HAvoBO7rptHgaWDOrHcZAd3
 nrAg==
X-Gm-Message-State: AOJu0YwsyBoi4P9R1JZu3A/aSH/CsHaIXOcs48AmvLMxiyLeTitC5D6H
 x7+TssyYbH6oO0h8N10naDA2uoDBirg2FOFIVPcBmmtCNgskiYWytwvqLM4UbSYhs90eMYEVRNc
 YfaeBeX0kuRfmkU0suTwQPEc=
X-Received: by 2002:a2e:b0c4:0:b0:2bc:c2cb:cd3f with SMTP id
 g4-20020a2eb0c4000000b002bcc2cbcd3fmr9694642ljl.32.1695112356482; 
 Tue, 19 Sep 2023 01:32:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnjkJE/03yTczosAyy29WLF3oj268PQp6mCRVzzOmvL2LM8uR2DRMm4Qz+EVtBTog7tT0KUQ==
X-Received: by 2002:a2e:b0c4:0:b0:2bc:c2cb:cd3f with SMTP id
 g4-20020a2eb0c4000000b002bcc2cbcd3fmr9694626ljl.32.1695112356107; 
 Tue, 19 Sep 2023 01:32:36 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 q21-20020a1709066b1500b0098921e1b064sm7409445ejr.181.2023.09.19.01.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 01:32:35 -0700 (PDT)
Message-ID: <e6492eda-e09d-13ea-93b5-c824b3b3e9cd@redhat.com>
Date: Tue, 19 Sep 2023 10:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/8] qemu-img: add chunk size parameter to
 compare_buffers()
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-5-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230915162016.141771-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15.09.23 18:20, Andrey Drobyshev wrote:
> Add @chsize param to the function which, if non-zero, would represent
> the chunk size to be used for comparison.  If it's zero, then
> BDRV_SECTOR_SIZE is used as default chunk size, which is the previous
> behaviour.
>
> In particular, we're going to use this param in img_rebase() to make the
> write requests aligned to a predefined alignment value.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qemu-img.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)

With the comment fix Eric has suggested:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


