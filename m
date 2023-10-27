Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE5C7D942C
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJTg-0006bj-C1; Fri, 27 Oct 2023 05:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qwJTe-0006Z0-03
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qwJTb-0006d0-W7
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698400198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNaEt2BTukgKlopUjEx1qdv6jAKiWUb/31/G5B3ByKQ=;
 b=Odb0kMxmaAG+lXMf7KqhtI6Tpq1IH+DTlHgRJm6UTgGGSkn8Eq5uFRHRX/NBKjtmQnFLKN
 hK6HF0/H0x2HyqMxjmNWgfkaQXxO2gZ3iu24dTy790kDFUFYYxYyqzJov6h62f0yNvNwIs
 AUZELJ5EMiY14R4RboeKkySbNLUyvks=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-zwBvbm_uMWGCs0QDnZWwQw-1; Fri, 27 Oct 2023 05:49:42 -0400
X-MC-Unique: zwBvbm_uMWGCs0QDnZWwQw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4083717431eso14311325e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 02:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698400181; x=1699004981;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MNaEt2BTukgKlopUjEx1qdv6jAKiWUb/31/G5B3ByKQ=;
 b=GR8nvKAxN0taG2BeEXJv90E/YK8CXw5imoc70QV8KBaDhedtOoz6nfLIigzNzllbY+
 ngd8151kRR48Foq6oEsnF0IawwKd0MT8gY3dweaFP4KkjwzhTFUI0Ojx2WTHNn0A/U4q
 jVgG1Is7DZm6eABK7AszxhQCQvD9BYMUoPFKueOmbxDD8h+OsY/v5nDzfz2wZ6rf4nF8
 6vLp4iQL0gfSwMAk/QT9ALtV2Sg8Oe4VwapnloBH924P44/kuLFFjkL42+AU9xMZIH/X
 mQp3L4BG3J+jV24R7l2Hzy8qyW/MTKFYYv2EgVWJULIkPWJUHyyiNjuCiLaHh1jrixcb
 t5HA==
X-Gm-Message-State: AOJu0YzgIwDpqfHiWMHsnFVBrVFnZnWAors6Q/hLWwlw1ynMSd3tXnIY
 S/hqeHN9M7Sg6GecfMyYIEnpkVAtBMRfGtFNYUHTxBPRi/WHFTstPHyDUl188fnE3xKcj0ZqGjd
 lwb0BFex/n9ZembE=
X-Received: by 2002:adf:e401:0:b0:32d:9fc9:d14c with SMTP id
 g1-20020adfe401000000b0032d9fc9d14cmr2133650wrm.47.1698400181115; 
 Fri, 27 Oct 2023 02:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAuTUtozi6uqsupO99cNXmUBsvf2MYIPHs+LcZ/5BR/zDiInBc80RtwCNW8qDujDcgKAfjIQ==
X-Received: by 2002:adf:e401:0:b0:32d:9fc9:d14c with SMTP id
 g1-20020adfe401000000b0032d9fc9d14cmr2133637wrm.47.1698400180750; 
 Fri, 27 Oct 2023 02:49:40 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 r17-20020a5d4e51000000b0032daf848f68sm1389015wrt.59.2023.10.27.02.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:49:40 -0700 (PDT)
Message-ID: <9b6735e5-3ce2-448e-a347-70fd5cf169f2@redhat.com>
Date: Fri, 27 Oct 2023 11:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] qcow2: keep reference on zeroize with discard-no-unref
 enabled
Content-Language: en-US
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
References: <20231003125236.216473-2-jean-louis@dupond.be>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231003125236.216473-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 89751d81f2..9836195850 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3476,15 +3476,16 @@
>   #     should be issued on other occasions where a cluster gets freed
>   #
>   # @discard-no-unref: when enabled, discards from the guest will not
> -#     cause cluster allocations to be relinquished.  This prevents
> +#     cause cluster allocations to be relinquished. The same will
> +#     happen for discards triggered by zeroize. This prevents

I don’t think “zeroize” has any meaning outside of qemu’s qcow2 code.  
I’d write “when enabled, data clusters will remain preallocated when 
they are no longer used, e.g. because they are discarded or converted to 
zero clusters.  As usual, whether the old data is discarded or kept on 
the protocol level (i.e. in the image file) depends on the setting of 
the pass-discard-request option. Keeping the clusters preallocated 
prevents qcow2 fragmentation that would otherwise be caused by freeing 
and re-allocating them later. Besides potential performance degradation, 
[...]”

If you’re OK with that, I can change that (here and in qemu-options.hx) 
when taking the patch.

>   #     qcow2 fragmentation that would be caused by such discards.
>   #     Besides potential performance degradation, such fragmentation
>   #     can lead to increased allocation of clusters past the end of the
>   #     image file, resulting in image files whose file length can grow
> -#     much larger than their guest disk size would suggest.  If image
> +#     much larger than their guest disk size would suggest. If image
>   #     file length is of concern (e.g. when storing qcow2 images
>   #     directly on block devices), you should consider enabling this
> -#     option.  (since 8.1)
> +#     option. (since 8.1)

These two changes don’t seem related, I’d remove them, too. 
(Double-space after '.' is fairly common in block-core.json, and in my 
emails, too. :))

Hanna


