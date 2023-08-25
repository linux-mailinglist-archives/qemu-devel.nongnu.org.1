Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F9A788C10
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 17:02:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZYJB-0002jH-B0; Fri, 25 Aug 2023 11:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZYJA-0002j0-4C
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZYJ7-00038t-5r
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692975664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKkXnsFewUh+yTiPXBoz1olQM93vhIjV1iWEqWgTH+Q=;
 b=S071FsTt4spo+e/riXUfNa+/EsRijy1IqpY9urQyFaNIxcfqzumFyTTcgr5QJRmCWSdJKq
 d0ma5+AikKfqwMYghDr8NX25iNScP1PPMshJq6i9cwJ7BB4csbJE9RfDENCc/WIIu6g3VL
 WJ5M/QtQdfkhEe+6LLxIpT2+xViAqng=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-noMR1A0vMiaFnns_mBounw-1; Fri, 25 Aug 2023 11:01:02 -0400
X-MC-Unique: noMR1A0vMiaFnns_mBounw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bfe6a531bso76244766b.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 08:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692975661; x=1693580461;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xKkXnsFewUh+yTiPXBoz1olQM93vhIjV1iWEqWgTH+Q=;
 b=TDwm1Ez/tuXsPk9BHlSfSaa1WmxWCoKzR+T3aRRnhEKTVGCe8fgkTVfXJJSRsuWOQT
 FXfhXLNt7ye7dfac9/NyJmFqjC9B/BwHdDayW6+QzuA4VWapo2tSRtfd6m5sSJtGkJDT
 zqorbu0QJFe4upZPBUaBR25AOLn5pnHXlWyl7h6CuB61wXwyzA2O77ZdnppR+/4+C99T
 ElpocAxG8bGOGRob2GVPzsyUMrE51eKCtbt4oQT3Zq7Z3NNMijSMPYERYxCXS4rx8YsE
 /CJi/Id0QzuIAzuuXh8G+q90o/mtpXOJAQ17euuSZdFoJPOpNj728UTY0bSAMfsMfZzm
 Q3Dg==
X-Gm-Message-State: AOJu0YyxakdaZxtkBkc7n1SnQLducyeMXK2ro48aPBqwRpBGJ1q76wqd
 kr2kwBFIiG7dkHSir5I1QVmd6m2e+BHDTE7osQ7HC8hTPNsgpaFct7bh1ZbmtSOrNgomfDDYG9D
 EG7JXa0kijrFsu28=
X-Received: by 2002:a17:906:53d3:b0:9a2:5bf:8b18 with SMTP id
 p19-20020a17090653d300b009a205bf8b18mr3991226ejo.14.1692975660970; 
 Fri, 25 Aug 2023 08:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPY/4nOHS/fjS4H7XHpiRZqVV64QX8KREagr4Tw5r46WSrsN4JHrLXlNiEm3ZrjcoG6V/u8Q==
X-Received: by 2002:a17:906:53d3:b0:9a2:5bf:8b18 with SMTP id
 p19-20020a17090653d300b009a205bf8b18mr3991209ejo.14.1692975660487; 
 Fri, 25 Aug 2023 08:01:00 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a170906490a00b009a1fef32ce6sm1052415ejq.177.2023.08.25.08.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 08:01:00 -0700 (PDT)
Message-ID: <9413d571-2334-7cf2-8959-99ccf81afe77@redhat.com>
Date: Fri, 25 Aug 2023 17:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] qemu-img: rebase: avoid unnecessary COW operations
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-5-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230601192836.598602-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.57, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 01.06.23 21:28, Andrey Drobyshev via wrote:
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
> write request is aligned to the overlay cluster size.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qemu-img.c | 72 +++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 52 insertions(+), 20 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 60f4c06487..9a469cd609 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3513,6 +3513,7 @@ static int img_rebase(int argc, char **argv)
>       uint8_t *buf_new = NULL;
>       BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
>       BlockDriverState *unfiltered_bs;
> +    BlockDriverInfo bdi = {0};
>       char *filename;
>       const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
>       int c, flags, src_flags, ret;
> @@ -3646,6 +3647,15 @@ static int img_rebase(int argc, char **argv)
>           }
>       }
>   
> +    /* We need overlay cluster size to make sure write requests are aligned */
> +    ret = bdrv_get_info(unfiltered_bs, &bdi);
> +    if (ret < 0) {
> +        error_report("could not get block driver info");
> +        goto out;
> +    } else if (bdi.cluster_size == 0) {
> +        bdi.cluster_size = 1;
> +    }
> +
>       /* For safe rebasing we need to compare old and new backing file */
>       if (!unsafe) {
>           QDict *options = NULL;
> @@ -3744,6 +3754,7 @@ static int img_rebase(int argc, char **argv)
>           int64_t new_backing_size = 0;
>           uint64_t offset;
>           int64_t n;
> +        int64_t n_old = 0, n_new = 0;
>           float local_progress = 0;
>   
>           buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
> @@ -3784,7 +3795,7 @@ static int img_rebase(int argc, char **argv)
>           }
>   
>           for (offset = 0; offset < size; offset += n) {
> -            bool buf_old_is_zero = false;
> +            bool old_backing_eof = false;
>   
>               /* How many bytes can we handle with the next read? */
>               n = MIN(IO_BUF_SIZE, size - offset);
> @@ -3829,33 +3840,38 @@ static int img_rebase(int argc, char **argv)
>                   }
>               }
>   
> +            /* At this point n must be aligned to the target cluster size. */
> +            if (offset + n < size) {
> +                assert(n % bdi.cluster_size == 0);

This is not correct.  First, bdrv_is_allocated_above() operates not on 
the top image, but on images in the backing chain, which may have 
different cluster sizes and so may lead to `n`s that are not aligned to 
the top image’s cluster size:

$ ./qemu-img create -f qcow2 base.qcow2 64M
$ ./qemu-img create -f qcow2 -b base.qcow2 -F qcow2 mid.qcow2 64M
$ ./qemu-img create -f qcow2 -o cluster_size=2M -b mid.qcow2 -F qcow2 
top.qcow2 64M
$ ./qemu-io -c 'write 64k 64k' mid.qcow2
$ ./qemu-img rebase -b base.qcow2 top.qcow2
qemu-img: ../qemu-img.c:3845: img_rebase: Assertion `n % 
bdi.cluster_size == 0' failed.
[1]    636690 IOT instruction (core dumped)  ./qemu-img rebase -b 
base.qcow2 top.qcow2

Second, and this is a more theoretical thing, it would also be broken 
for images with cluster sizes greater than IO_BUF_SIZE.  Now, 
IO_BUF_SIZE is 2 MB, which happens to be precisely the maximum cluster 
size we support for qcow2, and for vmdk we always create images with 64 
kB clusters (I believe), but the vmdk code seems happy to open 
pre-existing images with cluster sizes up to 512 MB. Still, even for 
qcow2, we could easily increase the limit from 2 MB at any point, and 
there is no explicit correlation why IO_BUF_SIZE happens to be exactly 
what the current maximum cluster size for qcow2 is.  One way to get 
around this would be to use MAX(IO_BUF_SIZE, bdi.cluster_size) for the 
buffer size, which would give such an explicit correlation.

> +            }
> +
> +            /*
> +             * Much like the with the target image, we'll try to read as much
> +             * of the old and new backings as we can.
> +             */
> +            n_old = MIN(n, MAX(0, old_backing_size - (int64_t) offset));
> +            if (blk_new_backing) {
> +                n_new = MIN(n, MAX(0, new_backing_size - (int64_t) offset));
> +            }
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
> +                ret = blk_pread(blk_new_backing, offset, n_new, buf_new, 0);
>                   if (ret < 0) {
>                       error_report("error while reading from new backing file");
>                       goto out;
> @@ -3867,15 +3883,28 @@ static int img_rebase(int argc, char **argv)
>   
>               while (written < n) {
>                   int64_t pnum;
> +                int64_t start, end;
>   
>                   if (compare_buffers(buf_old + written, buf_new + written,
>                                       n - written, &pnum))
>                   {
> -                    if (buf_old_is_zero) {
> +                    if (old_backing_eof) {
>                           ret = blk_pwrite_zeroes(blk, offset + written, pnum, 0);
>                       } else {
> -                        ret = blk_pwrite(blk, offset + written, pnum,
> -                                         buf_old + written, 0);
> +                        /*
> +                         * If we've got to this point, it means the cluster
> +                         * we're dealing with is unallocated, and any partial
> +                         * write will cause COW.  To avoid that, we make sure
> +                         * request is aligned to cluster size.
> +                         */
> +                        start = QEMU_ALIGN_DOWN(offset + written,
> +                                                bdi.cluster_size);

Please add an assertion here that `start >= offset`.  I would rather 
have qemu-img crash than to write out-of-bounds memory data to disk.

I understand the idea is that this is given anyway because `offset` 
starts at 0 and we always check that `n`, by which we increment 
`offset`, is aligned, but it is absolutely critical that we don’t do an 
out-of-bounds access, so I feel an explicit assertion here is warranted.

> +                        end = QEMU_ALIGN_UP(offset + written + pnum,
> +                                            bdi.cluster_size);

Similarly here, please assert that `end - offset` this does not exceed 
the buffer’s bounds.  I know the reasoning is the same, we ensured that 
`n` is aligned, so we can always safely align up `written + pnum`, but 
still.

Hanna

> +                        end = end > size ? size : end;
> +                        ret = blk_pwrite(blk, start, end - start,
> +                                         buf_old + (start - offset), 0);
> +                        pnum = end - (offset + written);
>                       }
>                       if (ret < 0) {
>                           error_report("Error while writing to COW image: %s",
> @@ -3885,6 +3914,9 @@ static int img_rebase(int argc, char **argv)
>                   }
>   
>                   written += pnum;
> +                if (offset + written >= old_backing_size) {
> +                    old_backing_eof = true;
> +                }
>               }
>               qemu_progress_print(local_progress, 100);
>           }


