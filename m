Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB147A1B6F
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5YF-000634-MX; Fri, 15 Sep 2023 05:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qh5YC-00061m-Kh
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:55:49 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qh5YA-00052o-57
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:55:47 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52c9be5e6f0so2207234a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694771744; x=1695376544; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+e+xQ6W4IDIkD9Yc6XKgugLMqvXXlpeRmlY/za2vlOE=;
 b=C8X5QmTkChefYKS8VaW6/UoLLQJ4ujIFtoztAmZHKmbewkW1Rf+2ZUSu6O7+GE33Uh
 bmqIxTD7wKMqNpACLcPjaqA1gxrfwZezQ8D6HlvyJ8LHie0unvPfVOWpVc0uJZla37hk
 Wav1PyUlKAM7KPiFFyo44ACCrrXIiUAzQ2tF8PQ6IDu8uo1zKxcF+Lk8dBmrq2Btkhxm
 rYA5zvajJyCmKKIDoD+45Y5Naw8erUhNYNF4wQhQfXcLJHC1vsTq3RNZLZk/orBedYYm
 MJhXaXe6e38yw0rGuEWLsMY90A+sqGXSun7+NexBSGCmDn8w2ZlJRtscyz/Vu26k8e7H
 FfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694771744; x=1695376544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+e+xQ6W4IDIkD9Yc6XKgugLMqvXXlpeRmlY/za2vlOE=;
 b=l1RA5mTjEGh240zUMz78crWsbIzgcFisEFz4gD01+ev0bEKbVJvUka+dcCQOWWj2tQ
 Yob+FLC13WCn6Q+TCuHd5AAoIZOLVERTwx9x6QxBn1PZ4+oJBogNLVpOk6z/fQ6RCcsN
 TEV519WsZsuwDOxmyiNkxavuHL3RLCjhYAL7sBmIMRJ7VCmRMZVpepSby3CoY8IeXSRj
 YJeKXVe+XhS3sRHcd5tpyV4r6SqHuS45R+izbtnDtHXETwXHhwYbK0LBNKiDdqTZaP7O
 9TW6XMkf7im27XMuBeRs5GT4Fyn34vtQccskeB88k7cdaSwpUqN9/rXKLoLZSea1Mz5u
 /79Q==
X-Gm-Message-State: AOJu0YynjQm5twyAGnkvnLnQBWztlHpJVxOyCQuYhAuQPSL7Ig9pUzn7
 vNj41GLCze6iNwgaH0AoXTOg5jZWX2THVPOEuKYNFg==
X-Google-Smtp-Source: AGHT+IEILCIEtKrECo5CVQwTYFYrUFzdd+FdJsBCN1/8HXeNzarV6Ng/iaDoOMoM5Mqn7ICXBB0XOYIaBv9WbPRGe2M=
X-Received: by 2002:aa7:db86:0:b0:52f:b5c8:fa6a with SMTP id
 u6-20020aa7db86000000b0052fb5c8fa6amr985358edt.20.1694771744153; Fri, 15 Sep
 2023 02:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230914224211.2184828-1-komlodi@google.com>
 <20230914224211.2184828-2-komlodi@google.com>
In-Reply-To: <20230914224211.2184828-2-komlodi@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2023 10:55:24 +0100
Message-ID: <CAFEAcA-k=KZFd8Xm30LswYZW7ZgDwVe17H5xB4EaxTFwhm1vpw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/timer/sse-timer: Add CNTFRQ reset property
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 14 Sept 2023 at 23:42, Joe Komlodi <komlodi@google.com> wrote:
>
> This can have a non-zero reset value, and cause the kernel to complain
> about a CNTFRQ mismatch if TF-A (or firmware in general) does not
> initialize it (because it expects the value to be non-zero out of
> reset).
>
> To fix this, we'll just add an object property that people can use to
> initialize the CNTFRQ reset value.

I'm a bit confused -- you talk about TF-A, but as far as I'm
aware the only use of this timer device is in the ARMSSE,
which is used only on M-profile boards.

Also, since this device is a sysbus device, there's not much
point adding the property without also adding code in the
ARMSSE etc that sets the property appropriately. On its
own this patch will do nothing.

Plus, it is firmware's job to set the value of this register:
in real hardware it is always zero on reset. For the A-profile
in-core CNTFRQ we set a non-zero reset value because in a
lot of use cases QEMU is effectively emulating firmware
and then directly booting Linux. I'm not so sure those cases
apply for M-profile boards?

If we do want to follow a similar approach to the A-profile
CPU timer, rather than having a separate property that must
be set, it would be neater for the timer to ask the counter
for the frequency -- the SSE timer is run from the SSE counter,
and the counter has a Clock input and can call clock_get_hz()
to get its frequency.

thanks
-- PMM

