Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D13037DBE79
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:04:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVfu-0000cs-Is; Mon, 30 Oct 2023 13:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxVfs-0000cb-So
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxVfq-00015V-MA
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698685411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRDj9tqHxeQiugstX1kkDqexdRk+VlscXIKnpZGwkgs=;
 b=i3aVT4hjzIf/klLeaYue9gfL2x5LS90qeF9sxSI91Fi7ZRe/RGAz08BcqFEZVM1hxTSk76
 5cslh6EzDuT/lAM9l6qaIo64RI4ljvZ9UGe1fee1hg8XypKXCz4S08yXwS2hNgayXkYrv7
 Mm8wA2fz34U7bwyHtTeENC0X9XhFoUE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-mRSrAqt6PfqL71-AJc6ofw-1; Mon, 30 Oct 2023 13:03:28 -0400
X-MC-Unique: mRSrAqt6PfqL71-AJc6ofw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c515541a25so47522421fa.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 10:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698685407; x=1699290207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BRDj9tqHxeQiugstX1kkDqexdRk+VlscXIKnpZGwkgs=;
 b=w23wmu2kHU1nT91jsWtVSUR8pSW0z8VXB/hNkPXhDLmcq0LvufxbWessOm7KVdZ1M+
 EjC6rmL72rvho78Pc4bfaYac6ba6wPer0rJORXALPeZ47KS7XqBk2ae9slxAW3VeJ1Mc
 JjJ9z4K5GBC94K4Jt8pWDp00pQMCDBkv3hNCY5hIGc9uiluPEgcYipZ2y0c4QGhYq6Te
 T8YUZxGvKeNER/yK7ckjFiapqlvYxsWwwTe7YBe4pRU/11Qcrf0g492YN39dGsQ4OIDn
 JtNE71C/3pWnLz7gb+bJ6/S9Sr6v2d7Jmex5mCtHizQbmYipzg5Aq7kBxWZlZlaxOVmO
 N2bg==
X-Gm-Message-State: AOJu0YxPXzllzULqABRhxSxTfU8lwUcOQGZVD8YMi4zIYlNyVgmxuZKp
 LXnIR1XFdNFf5sBhRgPra/RQJcH/Gmr4FtyKz7e7GmbgkFfRdJT4zDdUzbVVTXsHVBZfZbMgu08
 cPvq4Jo2ljYEsiH3nbBTXTqw=
X-Received: by 2002:a2e:9f08:0:b0:2bc:dab2:c7dc with SMTP id
 u8-20020a2e9f08000000b002bcdab2c7dcmr7890118ljk.47.1698685406884; 
 Mon, 30 Oct 2023 10:03:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGdVWuNhKrrKOdgu8AoSP0DdcP+s8isIMBnseHtsQXeTicuBQuQBFoZkKGRyJwPPhmRG1etA==
X-Received: by 2002:a2e:9f08:0:b0:2bc:dab2:c7dc with SMTP id
 u8-20020a2e9f08000000b002bcdab2c7dcmr7890103ljk.47.1698685406547; 
 Mon, 30 Oct 2023 10:03:26 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a5d5950000000b0032f7d1e2c7csm5845020wri.95.2023.10.30.10.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 10:03:25 -0700 (PDT)
Message-ID: <69296a7b-5a65-4ae6-a021-eab3361fbe35@redhat.com>
Date: Mon, 30 Oct 2023 18:03:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] qcow2: keep reference on zeroize with discard-no-unref
 enabled
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
References: <20231003125236.216473-2-jean-louis@dupond.be>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231003125236.216473-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03.10.23 14:52, Jean-Louis Dupond wrote:
> When the discard-no-unref flag is enabled, we keep the reference for
> normal discard requests.
> But when a discard is executed on a snapshot/qcow2 image with backing,
> the discards are saved as zero clusters in the snapshot image.
>
> When committing the snapshot to the backing file, not
> discard_in_l2_slice is called but zero_in_l2_slice. Which did not had
> any logic to keep the reference when discard-no-unref is enabled.
>
> Therefor we add logic in the zero_in_l2_slice call to keep the reference
> on commit.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2-cluster.c | 22 ++++++++++++++++++----
>   qapi/block-core.json  |  7 ++++---
>   qemu-options.hx       |  3 ++-
>   3 files changed, 24 insertions(+), 8 deletions(-)

Thanks, applied to my block branch:

https://gitlab.com/hreitz/qemu/-/commits/block

Hanna


