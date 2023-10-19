Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0AD7CF930
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:41:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSKU-0008JY-44; Thu, 19 Oct 2023 08:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtSKS-0008Im-0q
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:40:44 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtSKQ-0002tH-CF
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:40:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso12434022a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697719240; x=1698324040; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CIct3ewjP1yj7ohmeMlgBxA2sPXB2y8/9mQnfFKm5uA=;
 b=eC1VdhRSy1C1eC6IanxT4pT2ICnMlLnOD7r+GXMkxrxzjCcO+7OZFjh+hYlnN8bMFD
 FU8yNd1ounnbvMoIKm1JjI/zraZUhMEWsUkVO/sG33asawqN7EKVZfSlGt7PqymUYERm
 CXH+Nl2R5CnGpEML/kkjusGk91skh4wUTCBQfwanJFu8XNp8AzKjRWXjw2KylMrKOsgM
 NrGl37ropcEDydQZb0YS0JRO9TXdVJz5PFenmPbXRcnk/K+sXGZwaD4D0ayOWmjqJ/6I
 QObs0wu9///54QSWJZ1pxo9cL6Hhv6pATHVoovODShyKWbph67nNY/R58Y70kVeH/7zh
 AL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697719240; x=1698324040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CIct3ewjP1yj7ohmeMlgBxA2sPXB2y8/9mQnfFKm5uA=;
 b=sVVMAaEtBIRrwA27sm+wjgqdpegFfXSWebjJEdjEYQASUvRt8UaelfekYUJY9HyfM4
 KG+jxHHME/4Z591dgnPOmiIAHuz2VM1HMet+wY5edS5a+pgbx07dWjSHZhB+s2zKil9W
 /u+mKuov44IhTic9adjlTsvJcY2dEZBkPQORXh0HJafXLnaxCNyw7PFYC+wfZOeW9h3h
 iPPCZYFgiAkXvGpJo9vnudNNXdZGCP6fKVVOmDXPIyrgUw8jb+VOcQytZ/+218HyLfWK
 sAg+hkx/kTcKsqG8QsD+kjaijw4Nt9CVgWpF2XXz4vrQGwQN1w6fu+8ihjoYfHlTxqfv
 PMrw==
X-Gm-Message-State: AOJu0YwI8m8Q6b44cH3e/wRsobGSyqlhp92vjWMaktAnqO0G60NGr7rq
 oMb1lCltQgeTnINmXdQ3Tibhjgfx31blwI+4d7+pHA==
X-Google-Smtp-Source: AGHT+IFPWBX062KyFQZ4i2TqC5Am8/Q2mnlwtvQkLNV931Z5Oq8jUy53s7MwXmsAPtU4i3qMC75lGgDslLTzntSnbTg=
X-Received: by 2002:a50:bb44:0:b0:53e:3d9f:3c72 with SMTP id
 y62-20020a50bb44000000b0053e3d9f3c72mr1527629ede.18.1697719240322; Thu, 19
 Oct 2023 05:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231017203855.298260-1-peterx@redhat.com>
In-Reply-To: <20231017203855.298260-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2023 13:40:29 +0100
Message-ID: <CAFEAcA-xOf+TLL9jbjQvdaqOK0ew_xbjnoajTzaxLbkhEz9Vig@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix parse_ramblock() on overwritten retvals
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 17 Oct 2023 at 21:40, Peter Xu <peterx@redhat.com> wrote:
>
> It's possible that some errors can be overwritten with success retval later
> on, and then ignored.  Always capture all errors and report.
>
> Reported by Coverity 1522861, but actually I spot one more in the same
> function.

The other one is CID 1522862, I think.

> Fixes: CID 1522861
> Signed-off-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/ram.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index c844151ee9..d8bdb53a8f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3888,6 +3888,8 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>          ret = qemu_ram_resize(block, length, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
> +            assert(ret < 0);

We usually don't bother asserting for this kind of "function
reports errors two ways" code.

> +            return ret;
>          }

thanks
-- PMM

