Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE0C727BF1
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 11:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7CKB-0005QT-RJ; Thu, 08 Jun 2023 05:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7CK9-0005Pf-HM
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 05:52:57 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7CK7-0005Jt-UO
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 05:52:57 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51491b87565so697871a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686217974; x=1688809974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KERFQfa37mFnQ04q3D06EDqcTBtD4KjLYMASEpuVMiI=;
 b=LB5Xss9OwIqaKjNjE9JGuL/KL6RcDixWZbvR7UHOXF/LbkqunVxbDcJ+wi4HGA7Jxt
 ldS5nydQd8KDcUE+tL1ySlOZJtNx9K75TDU/1FQeSU+SK95IeJjQAwct7uyJkqGYJwz9
 1ew4ggflYvkORnY53CCAC4WQAqXS1wRWBgG9EqP4ZyWA3Tv6DnF0tKSeeX75Mcjqo/y7
 NH8RZ8o0+mXq6u+hhU1He56ZvcwkqOT+H25qnyaaxN/c8WG/719yZUl/Bj/SSP73JaHt
 n7ppROC7Kx4EvfPGJzN5yGFLcZdzdAju7NZHa8/vsyTAiHX/XxUQdqurmlDDPveBYkOi
 hr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686217974; x=1688809974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KERFQfa37mFnQ04q3D06EDqcTBtD4KjLYMASEpuVMiI=;
 b=Y3tH4AKIIA36cikFyi8W1IR0B13mbmamM1IkJ687f9uDf8U39k4rytx1OikMfGSvbg
 sMbN85XvzbNJo9TpzH77x3MyuwyBdv32dzHKVURPyidiRPMPe3IJuMsFZHRgs879wok7
 Ij1Or3DiYr3lC7PbHlkjBGw6rWutDTkCOUKbQUyGGvX7ckmROBtZT5e46J9LPruzQhbX
 T+wEUfejmswpzBarEqShi2qAPsrKUK18mfugMq1e7Pz+5lvqdCFebpDZ83Hfwr/gyF4v
 fHbGSiwrzSEbRFWD5EyDPyCJDWOBoqMi56HTLkg+QEYJ7Sf1UwGlvskCwrmMPHiHzdvk
 BJsA==
X-Gm-Message-State: AC+VfDwfAZ55uyVGBER3r4En1pZRf8KLou6qCS+4ns/J16askjtuBytB
 yzWOmLnUZexRxdpvlunMgTjlwC7FRgwHXGDN2Uz/5w==
X-Google-Smtp-Source: ACHHUZ4FPY7Z9XgzRaFG2Kdp8R1K+TlArhzQrRWf+foHTsimCMO6CLRDkN4N5QITeBaeHQ/kZFi9a2RSLjFhAviZ8uY=
X-Received: by 2002:aa7:c60d:0:b0:516:a277:48ce with SMTP id
 h13-20020aa7c60d000000b00516a27748cemr2100116edq.4.1686217974269; Thu, 08 Jun
 2023 02:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230605154541.1043261-1-hreitz@redhat.com>
 <20230605154541.1043261-3-hreitz@redhat.com>
In-Reply-To: <20230605154541.1043261-3-hreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 10:52:43 +0100
Message-ID: <CAFEAcA_9pFYxttbp57QO-diMzqdmE8GdoyGMtMk_L4_a-TXyKA@mail.gmail.com>
Subject: Re: [PULL 02/17] block: Collapse padded I/O vecs exceeding IOV_MAX
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 5 Jun 2023 at 16:48, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> When processing vectored guest requests that are not aligned to the
> storage request alignment, we pad them by adding head and/or tail
> buffers for a read-modify-write cycle.

Hi; Coverity complains (CID 1512819) that the assert added
in this commit is always true:

> @@ -1573,26 +1701,34 @@ static void bdrv_padding_destroy(BdrvRequestPadding *pad)
>  static int bdrv_pad_request(BlockDriverState *bs,
>                              QEMUIOVector **qiov, size_t *qiov_offset,
>                              int64_t *offset, int64_t *bytes,
> +                            bool write,
>                              BdrvRequestPadding *pad, bool *padded,
>                              BdrvRequestFlags *flags)
>  {
>      int ret;
> +    struct iovec *sliced_iov;
> +    int sliced_niov;
> +    size_t sliced_head, sliced_tail;
>
>      bdrv_check_qiov_request(*offset, *bytes, *qiov, *qiov_offset, &error_abort);
>
> -    if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {
> +    if (!bdrv_init_padding(bs, *offset, *bytes, write, pad)) {
>          if (padded) {
>              *padded = false;
>          }
>          return 0;
>      }
>
> -    ret = qemu_iovec_init_extended(&pad->local_qiov, pad->buf, pad->head,
> -                                   *qiov, *qiov_offset, *bytes,
> -                                   pad->buf + pad->buf_len - pad->tail,
> -                                   pad->tail);
> +    sliced_iov = qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
> +                                  &sliced_head, &sliced_tail,
> +                                  &sliced_niov);
> +
> +    /* Guaranteed by bdrv_check_qiov_request() */
> +    assert(*bytes <= SIZE_MAX);

This one. (The Coverity complaint is because SIZE_MAX for it is
UINT64_MAX and an int64_t can't possibly be bigger than that.)

Is this because the assert() is deliberately handling the case
of a 32-bit host where SIZE_MAX might not be UINT64_MAX ? Or was
the bound supposed to be SSIZE_MAX or INT64_MAX ?

Looking at bdrv_check_qiov_request(), it seems to check bytes
against BDRV_MAX_LENGTH, which is defined as something somewhere
near INT64_MAX. So on a 32-bit host I'm not sure that function
does guarantee that the bytes count is going to be less than
SIZE_MAX...

(CID 1512819)

thanks
-- PMM

