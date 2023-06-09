Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694A729176
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:46:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7WoR-00042I-Ew; Fri, 09 Jun 2023 03:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q7WoP-00041q-1O
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q7WoM-00074L-GC
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686296728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBmljamOsE0cdGnuc9TvxYue+A1bf4xrx9K3dxaWkMs=;
 b=Zf+G5018zboOrkPVrzeNUZ74uurNWRjAVaiQy5qU2jnqrbPHbCtgt9X7twIKwWx7/mklTK
 KuDLgg3sXIqgMDQPT1wGjcQ6VZZggvbc2eM5EAY5pAKKe2F7eVW6kwH+bkgpE0qzOuZFgA
 0n8lalCO64jSiJBw/BnBMultqMG1p0w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-HyuDRM1vOmeRfOxpM6QLlQ-1; Fri, 09 Jun 2023 03:45:26 -0400
X-MC-Unique: HyuDRM1vOmeRfOxpM6QLlQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5142da822cbso1704209a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 00:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686296724; x=1688888724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bBmljamOsE0cdGnuc9TvxYue+A1bf4xrx9K3dxaWkMs=;
 b=QF1cPgsOs4M5rJLrKXS5lZ6G0L5KVOZJSh6duP7+NjA/kWXgByUbzTPPaq+aJm1YHt
 bGhLRqmZ2+t4OP9X/rvja5tMPlZFAVTRAM+cz/I5CpMltnCDW45q6Jog7k9IuoQciUvr
 +83ij9s3dxPU3vRrTcMPeu/aK/rqLe6u9CYEirhoT/VYof1R+JyCwWYiffQd8dSBaMEG
 ozS6P0cuzPSSpBEBynhzNU4ofeVOBFMVMSQY9O4res8NYTTPLBqThYFRTLC0ini1HPy6
 xTlT4ucc0sg8CcUp+U9lxJYfPs3bjMl6o2CSiGt++4iiIPeeJ8vgt+4SHQjvdZ1YA7Wx
 7ArQ==
X-Gm-Message-State: AC+VfDwq+G7GPH+SV7RfFniUSfU28JcLlTBedy7T3NuB0Li+gvpGBAf0
 pLQ1FmabFtA00g1OPzqznotQAYxA8Prp4TGEUZpMcUKQGic3mSm0jYsym985vJWaNLlIT4C55VE
 70gICLZNxdUpgNceg8IZlAJQ=
X-Received: by 2002:a17:907:96aa:b0:96f:d8a9:d045 with SMTP id
 hd42-20020a17090796aa00b0096fd8a9d045mr1280173ejc.59.1686296724666; 
 Fri, 09 Jun 2023 00:45:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5XXcSEJfHm/PQvs6+VaWWYQ2DJ7giu3dlfhzFhdza6f6CrmU2xPTwOAgURg9jCRfDOLbobjw==
X-Received: by 2002:a17:907:96aa:b0:96f:d8a9:d045 with SMTP id
 hd42-20020a17090796aa00b0096fd8a9d045mr1280155ejc.59.1686296724340; 
 Fri, 09 Jun 2023 00:45:24 -0700 (PDT)
Received: from ?IPV6:2003:cf:d727:f67d:a473:8b17:9e70:3186?
 (p200300cfd727f67da4738b179e703186.dip0.t-ipconnect.de.
 [2003:cf:d727:f67d:a473:8b17:9e70:3186])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a1709061c0e00b0096f6e2f4d9esm936631ejg.83.2023.06.09.00.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 00:45:23 -0700 (PDT)
Message-ID: <b84ee45c-7120-3bdc-ae8a-11a363f7f6be@redhat.com>
Date: Fri, 9 Jun 2023 09:45:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 02/17] block: Collapse padded I/O vecs exceeding IOV_MAX
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230605154541.1043261-1-hreitz@redhat.com>
 <20230605154541.1043261-3-hreitz@redhat.com>
 <CAFEAcA_9pFYxttbp57QO-diMzqdmE8GdoyGMtMk_L4_a-TXyKA@mail.gmail.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAFEAcA_9pFYxttbp57QO-diMzqdmE8GdoyGMtMk_L4_a-TXyKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 08.06.23 11:52, Peter Maydell wrote:
> On Mon, 5 Jun 2023 at 16:48, Hanna Czenczek <hreitz@redhat.com> wrote:
>> When processing vectored guest requests that are not aligned to the
>> storage request alignment, we pad them by adding head and/or tail
>> buffers for a read-modify-write cycle.
> Hi; Coverity complains (CID 1512819) that the assert added
> in this commit is always true:
>
>> @@ -1573,26 +1701,34 @@ static void bdrv_padding_destroy(BdrvRequestPadding *pad)
>>   static int bdrv_pad_request(BlockDriverState *bs,
>>                               QEMUIOVector **qiov, size_t *qiov_offset,
>>                               int64_t *offset, int64_t *bytes,
>> +                            bool write,
>>                               BdrvRequestPadding *pad, bool *padded,
>>                               BdrvRequestFlags *flags)
>>   {
>>       int ret;
>> +    struct iovec *sliced_iov;
>> +    int sliced_niov;
>> +    size_t sliced_head, sliced_tail;
>>
>>       bdrv_check_qiov_request(*offset, *bytes, *qiov, *qiov_offset, &error_abort);
>>
>> -    if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {
>> +    if (!bdrv_init_padding(bs, *offset, *bytes, write, pad)) {
>>           if (padded) {
>>               *padded = false;
>>           }
>>           return 0;
>>       }
>>
>> -    ret = qemu_iovec_init_extended(&pad->local_qiov, pad->buf, pad->head,
>> -                                   *qiov, *qiov_offset, *bytes,
>> -                                   pad->buf + pad->buf_len - pad->tail,
>> -                                   pad->tail);
>> +    sliced_iov = qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
>> +                                  &sliced_head, &sliced_tail,
>> +                                  &sliced_niov);
>> +
>> +    /* Guaranteed by bdrv_check_qiov_request() */
>> +    assert(*bytes <= SIZE_MAX);
> This one. (The Coverity complaint is because SIZE_MAX for it is
> UINT64_MAX and an int64_t can't possibly be bigger than that.)
>
> Is this because the assert() is deliberately handling the case
> of a 32-bit host where SIZE_MAX might not be UINT64_MAX ? Or was
> the bound supposed to be SSIZE_MAX or INT64_MAX ?

It’s supposed to be SIZE_MAX, because of the subsequent 
bdrv_created_padded_qiov() call that takes a size_t.  So it is for a 
case where SIZE_MAX < UINT64_MAX, i.e. 32-bit hosts, yes.

> Looking at bdrv_check_qiov_request(), it seems to check bytes
> against BDRV_MAX_LENGTH, which is defined as something somewhere
> near INT64_MAX. So on a 32-bit host I'm not sure that function
> does guarantee that the bytes count is going to be less than
> SIZE_MAX...

Ah, crap.  I was thinking of BDRV_REQUEST_MAX_BYTES, which is checked by 
bdrv_check_request32(), which both callers of bdrv_pad_request() 
run/check before calling bdrv_pad_request().  So bdrv_pad_request() 
should use the same function.

I’ll send a patch to change the bdrv_check_qiov_request() to 
bdrv_check_request32().  Because both callers (bdrv_co_preadv_part(), 
bdrv_co_pwritev_part()) already call it (the latter only for non-zero 
writes, but bdrv_pad_request() similarly is called only for non-zero 
writes), there should be no change in behavior, and the asserted 
condition should in practice already be always fulfilled (because of the 
callers checking).

Hanna


