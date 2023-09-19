Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D96D7A5C5A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:19:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVwq-0002ZP-Bk; Tue, 19 Sep 2023 04:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiVwi-0002YS-K6
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiVwf-00007V-Co
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695111536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMdVI4dzQfawyhkk7jP1fznrE0nHhNEz2SquzMeSk48=;
 b=Tbwajek2+THhEmLJQXoIvJF6pNwKEcWO5IsZW5OXb99CZ/lBL1PxJK8jHm4X3n0lKEXfCe
 GJAKtKSV5956/KEGd2CT2xiXVeedGUrWEXAncnVnoYJ6KgryYHb0MEwJi5aBiUpwGTWXXU
 7jZCZ60n1hPJohffUgxPBbAVYa0CQsw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-3C4ld2KaNMaWdMSdInabLQ-1; Tue, 19 Sep 2023 04:18:55 -0400
X-MC-Unique: 3C4ld2KaNMaWdMSdInabLQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae2b98729dso33633266b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 01:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695111533; x=1695716333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NMdVI4dzQfawyhkk7jP1fznrE0nHhNEz2SquzMeSk48=;
 b=nW3BxbEO42I+g8KgmsaRGOSV5lN79f61EGW0+ptJGWvNuj+/UghZb5LzfoHIVmYihy
 8b0d9Vc6Vwa9ggi4JH3indEXZJH1fBkRO/GpFBzRNWLZ5T1qNOW8dBjyDgPEenNG5CwJ
 P5R1eNfUAt4i308Lgd1G9C828ioOf1yAAfsukRDs6imBmGCMTQQAOmI+RoOjwfyB2iN/
 XKVVRGjBqRN0aQla/0ttgSeeAPmJo6XRCglmyp+yss9vx0dEnx7KPmA+VkAS2kZEA+et
 Gp8xVXNxIHXcpKH0fzmG5LLPzpuzp9wCBt9IMkdrZRKaQ71rVKHwahwJpiZjoBAuc2OM
 mziA==
X-Gm-Message-State: AOJu0Yzjh0yWPvk2ndn5fA0jtiQU1RGis7oz61ZEQaRAELClS+8Q9QZm
 oy1Sm/iMXl3XZS8DeDYNDXhBJeaD/eijWEShRZYgxcWlu5VHk4O1Ka6zrQnORYIiRw8m6qNn688
 j6xGV4e1LeFLL/g+0v7MI8f8=
X-Received: by 2002:a17:907:a0c6:b0:9a2:28dc:4166 with SMTP id
 hw6-20020a170907a0c600b009a228dc4166mr8579120ejc.75.1695111533700; 
 Tue, 19 Sep 2023 01:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Sl3aV026Blxwu4FPOnSYCFzAeLVBgbzdINse6qPCxUsL6Jq99gRpa7d8gaXGPu9jX1RbXA==
X-Received: by 2002:a17:907:a0c6:b0:9a2:28dc:4166 with SMTP id
 hw6-20020a170907a0c600b009a228dc4166mr8579106ejc.75.1695111533420; 
 Tue, 19 Sep 2023 01:18:53 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a170906390d00b00982a92a849asm7446974eje.91.2023.09.19.01.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 01:18:52 -0700 (PDT)
Message-ID: <a4836464-22c3-2a49-0128-2dc4a98b5092@redhat.com>
Date: Tue, 19 Sep 2023 10:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/8] qemu-img: rebase: use backing files' BlockBackend
 for buffer alignment
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-4-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230915162016.141771-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
> Since commit bb1c05973cf ("qemu-img: Use qemu_blockalign"), buffers for
> the data read from the old and new backing files are aligned using
> BlockDriverState (or BlockBackend later on) referring to the target image.
> However, this isn't quite right, because buf_new is only being used for
> reading from the new backing, while buf_old is being used for both reading
> from the old backing and writing to the target.  Let's take that into account
> and use more appropriate values as alignments.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qemu-img.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 50660ba920..d12e4a4753 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3750,8 +3750,13 @@ static int img_rebase(int argc, char **argv)
>           int64_t n;
>           float local_progress = 0;
>   
> -        buf_old = blk_blockalign(blk, IO_BUF_SIZE);
> -        buf_new = blk_blockalign(blk, IO_BUF_SIZE);
> +        if (blk_old_backing && bdrv_opt_mem_align(blk_bs(blk)) >
> +            bdrv_opt_mem_align(blk_bs(blk_old_backing))) {
> +            buf_old = blk_blockalign(blk, IO_BUF_SIZE);
> +        } else {
> +            buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
> +        }

As I read this, if blk_old_backing is NULL, we will go to the 
blk_blockalign(blk_old_backing, IO_BUF_SIZE) path.  I think if it is 
NULL, we should align on blk instead.

Hanna

> +        buf_new = blk_blockalign(blk_new_backing, IO_BUF_SIZE);
>   
>           size = blk_getlength(blk);
>           if (size < 0) {


