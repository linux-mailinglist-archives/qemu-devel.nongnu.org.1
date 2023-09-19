Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4246E7A5FFA
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiYFp-0008Od-37; Tue, 19 Sep 2023 06:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiYFh-0008Nr-V5
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiYFf-0005sa-4t
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695120402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ab9bLQH0Tx3APO9rCPNTfvxvFdTE+ptFH/kSz5VNmRI=;
 b=AzLOGD0TljOGhaEkCami9yXROVS9ZDuY9vlE9mkA8upvQPqLt4SqJ5PAmkaQ2TH+H4CiUC
 IpsZh6hQDdpnQyhSUqf3tVZqc/4NoVjBldw6dXVpXy1qtqJgwhUX+lCkXGgFqHs2485Z41
 +0PuEdCpY2KJDULhJxeZbb6tRH0JgR8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-LFhUkJa8PkezmAyp0Oc3Fw-1; Tue, 19 Sep 2023 06:46:41 -0400
X-MC-Unique: LFhUkJa8PkezmAyp0Oc3Fw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a9f282713fso394917266b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 03:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695120400; x=1695725200;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ab9bLQH0Tx3APO9rCPNTfvxvFdTE+ptFH/kSz5VNmRI=;
 b=O6hdiMosOAZcLTO9i8jwp1N60rrvZIvi93j896FWfEdO1hZG7gugzT4bB2TMYqxQV3
 F3C/6PwH4/QAFxIayl0RWmb+hUoYNhkjSWZXxejboJi/nqCQ+OEwKRUHl+B8EMQE/Z3F
 2a7VU77kzyGWh2UufMQlH605BUYBvEHz1OZ9xpH4hS3fhujdUwCYtyRSTDgJmB8n78Zb
 JkERs4CAehURbo1yrAvkTvLB98E97nuWb3sMM6Zg0TgAoKZQ8aqF8wEPApcmKUhherYk
 ldMmnoqD7W2yi2eqsJj45fMNFiPSmLXaXbpGNFFRMl6eyWYKn2Dngbj1488ZfqIfQXhk
 +SvA==
X-Gm-Message-State: AOJu0YyeDjqV/nBFZqRwtrbZi05l+u0PAGxXXpYUI/CTh9wxZj4cpJ5J
 vFFZDb5ryNNOxKuFm0R3bTYZn3k2t4APKOzymDydHoiljuLgKGoSaVM8nEBMI8JBhF0h6x2tuaA
 373luucfrYarkIEc=
X-Received: by 2002:a17:906:74d5:b0:9a1:8ee9:cc0b with SMTP id
 z21-20020a17090674d500b009a18ee9cc0bmr10741946ejl.21.1695120399862; 
 Tue, 19 Sep 2023 03:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa1FnjSRqBXh928ZaKf3n8RQVtcMdKvHdfBZb/kd/83nUmb4Mjt9dA29wmhblqJ3uGn7w4NA==
X-Received: by 2002:a17:906:74d5:b0:9a1:8ee9:cc0b with SMTP id
 z21-20020a17090674d500b009a18ee9cc0bmr10741922ejl.21.1695120399501; 
 Tue, 19 Sep 2023 03:46:39 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a170906411300b009930308425csm7583389ejk.31.2023.09.19.03.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 03:46:38 -0700 (PDT)
Message-ID: <2ec20eaa-2d56-a5b2-67c2-3798d1910f4b@redhat.com>
Date: Tue, 19 Sep 2023 12:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/8] qemu-img: rebase: avoid unnecessary COW operations
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-6-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230915162016.141771-6-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> When rebasing an image from one backing file to another, we need to
> compare data from old and new backings.  If the diff between that data
> happens to be unaligned to the target cluster size, we might end up
> doing partial writes, which would lead to copy-on-write and additional IO.
>
> Consider the following simple case (virtual_size == cluster_size == 64K):
>
> base <-- inc1 <-- inc2
>
> qemu-io -c "write -P 0xaa 0 32K" base.qcow2
> qemu-io -c "write -P 0xcc 32K 32K" base.qcow2
> qemu-io -c "write -P 0xbb 0 32K" inc1.qcow2
> qemu-io -c "write -P 0xcc 32K 32K" inc1.qcow2
> qemu-img rebase -f qcow2 -b base.qcow2 -F qcow2 inc2.qcow2
>
> While doing rebase, we'll write a half of the cluster to inc2, and block
> layer will have to read the 2nd half of the same cluster from the base image
> inc1 while doing this write operation, although the whole cluster is already
> read earlier to perform data comparison.
>
> In order to avoid these unnecessary IO cycles, let's make sure every
> write request is aligned to the overlay subcluster boundaries.  Using
> subcluster size is universal as for the images which don't have them
> this size equals to the cluster size, so in any case we end up aligning
> to the smallest unit of allocation.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qemu-img.c | 76 ++++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 56 insertions(+), 20 deletions(-)

Looks good, I like the changes from v1!  Two minor things:

> diff --git a/qemu-img.c b/qemu-img.c
> index fcd31d7b5b..83950af42b 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -3844,33 +3861,48 @@ static int img_rebase(int argc, char **argv)
>                   }
>               }
>   
> +            /*
> +             * At this point we know that the region [offset; offset + n)
> +             * is unallocated within the target image.  This region might be
> +             * unaligned to the target image's (sub)cluster boundaries, as
> +             * old backing may have smaller clusters (or have subclusters).
> +             * We extend it to the aligned boundaries to avoid CoW on
> +             * partial writes in blk_pwrite(),
> +             */
> +            n += offset - QEMU_ALIGN_DOWN(offset, write_align);
> +            offset = QEMU_ALIGN_DOWN(offset, write_align);
> +            n += QEMU_ALIGN_UP(offset + n, write_align) - (offset + n);
> +            n = MIN(n, size - offset);
> +            assert(!bdrv_is_allocated(unfiltered_bs, offset, n, &n_alloc) &&
> +                   n_alloc == n);
> +
> +            /*
> +             * Much like the with the target image, we'll try to read as much

s/the with the/with the/

> +             * of the old and new backings as we can.
> +             */
> +            n_old = MIN(n, MAX(0, old_backing_size - (int64_t) offset));
> +            if (blk_new_backing) {
> +                n_new = MIN(n, MAX(0, new_backing_size - (int64_t) offset));
> +            }

If we don’t have a check for blk_old_backing (old_backing_size is 0 if 
blk_old_backing is NULL), why do we have a check for blk_new_backing 
(new_backing_size is 0 if blk_new_backing is NULL)?

(Perhaps because the previous check was `offset >= new_backing_size || 
!blk_new_backing`, i.e. included exactly such a check – but I don’t 
think it’s necessary, new_backing_size will be 0 if blk_new_backing is 
NULL.)

> +
>               /*
>                * Read old and new backing file and take into consideration that
>                * backing files may be smaller than the COW image.
>                */
> -            if (offset >= old_backing_size) {
> -                memset(buf_old, 0, n);
> -                buf_old_is_zero = true;
> +            memset(buf_old + n_old, 0, n - n_old);
> +            if (!n_old) {
> +                old_backing_eof = true;
>               } else {
> -                if (offset + n > old_backing_size) {
> -                    n = old_backing_size - offset;
> -                }
> -
> -                ret = blk_pread(blk_old_backing, offset, n, buf_old, 0);
> +                ret = blk_pread(blk_old_backing, offset, n_old, buf_old, 0);
>                   if (ret < 0) {
>                       error_report("error while reading from old backing file");
>                       goto out;
>                   }
>               }
>   
> -            if (offset >= new_backing_size || !blk_new_backing) {
> -                memset(buf_new, 0, n);
> -            } else {
> -                if (offset + n > new_backing_size) {
> -                    n = new_backing_size - offset;
> -                }
> -
> -                ret = blk_pread(blk_new_backing, offset, n, buf_new, 0);
> +            memset(buf_new + n_new, 0, n - n_new);
> +            if (blk_new_backing && n_new) {

Same as above, I think we can drop the blk_new_backing check, just so 
that both blocks (for old and new) look the same.

(Also, the memset() already has to trust that n_new is 0 if 
blk_new_backing is NULL, so the check doesn’t make much sense from that 
perspective either, and makes the memset() look wrong.)

> +                ret = blk_pread(blk_new_backing, offset, n_new, buf_new, 0);
>                   if (ret < 0) {
>                       error_report("error while reading from new backing file");
>                       goto out;


