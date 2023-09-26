Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F47AEAC4
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5fE-0006Y8-BS; Tue, 26 Sep 2023 06:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5fB-0006Xm-Bh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:51:33 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5f9-0004Qp-MJ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:51:33 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so9877706a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 03:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695725489; x=1696330289; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FCXAda4V9IINj/yMYsuJgNFPCZhviyhow+JfF7H4PFs=;
 b=f0Nq8RrifBllJjZySHyoNmFxQg8+myqiHx5KjEl4oQ4R/4R8oXgLKgafk2bJ37l/0i
 TyCi3w554OE0JUNnuYUqV86YWAe/ZnKNH1+y9dbXjp8m7RFuDJ5vwYUB8vvojkOCQrAa
 YEYOs70jVubnb/k5z/PH5iTjWCK46Ee12c2rvwcNgxd934t8Y4IvAh/JSGurQUx7lxeN
 CS34I7uJ6YKTqZiJqCLq0l4ybYNEPdXzZVNQu9E4wEvBP+gRCoZ98LfizaT7BsySozlA
 qCmr6h04ozmFRG7zLMnJiNiynocKQ5+c5rovweUPLg6HE1MeRVbcmkRh67sJZP5VfoDq
 4v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695725489; x=1696330289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FCXAda4V9IINj/yMYsuJgNFPCZhviyhow+JfF7H4PFs=;
 b=JjSa5PVgxwhgf/kMS+FvgPAzNdKVyDlrE7DP9JZzdpXFXEHhdHowOqp8mgo1Dm7jmb
 ZQ/XZ12oeSUzNC3FxZ7nzhgCWSVAu2qvkh2ZvxPGiV1Q4owH6NeScsLqDimlqwwtxC0X
 wvsXzOnP/DB5Op3g9pMzs5khLSNTK0FuRJVcyTCsV3lkXjte7C1D9/HhPepZAetcEKk9
 JUKqPSlKPgMgm2/hJws3/qFNaQac+y5oa35Je0h/8Hol3aIB91Afj2XgWZJR658yt+xf
 /bneP/lOG9HGUTh28cLMLS6tAQcPHCeizR6sTvPFgqgoPO0mphfl43y7ji7U7doB+sx4
 W0IA==
X-Gm-Message-State: AOJu0Yx0YHxpRT4VVR8OZ0sRbrlvJ+/GE8ZdCVCmijknRcciBfroGHyM
 EiYMdMgEnqnQI+v5p9tSl0v/tSWmBKM4MY0A6R20aQ==
X-Google-Smtp-Source: AGHT+IEwzstsgKUa6tj3B3gXXnUKsWs4WZMYFi+16tg21/DMHptUsM0uHOvDsSqIu+s2J79Oi9LP817lLMoZr7y+Odc=
X-Received: by 2002:aa7:cfc5:0:b0:530:c880:9171 with SMTP id
 r5-20020aa7cfc5000000b00530c8809171mr7929423edy.27.1695725489473; Tue, 26 Sep
 2023 03:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-6-vsementsov@yandex-team.ru>
In-Reply-To: <20230925194040.68592-6-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 11:51:11 +0100
Message-ID: <CAFEAcA9TjB7OJ-j+Cnst8pt3CjVADvyvG07ZvykQKRoowgMe3g@mail.gmail.com>
Subject: Re: [PATCH 05/12] device_tree: qmp_dumpdtb(): stronger assertion
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 25 Sept 2023 at 20:42, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Coverity mark this size, got from the buffer as untrasted value, it's
> not good to use it as length when writing to file. Make the assertion
> more strict to also check upper bound.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  softmmu/device_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/softmmu/device_tree.c b/softmmu/device_tree.c
> index 30aa3aea9f..adc4236e21 100644
> --- a/softmmu/device_tree.c
> +++ b/softmmu/device_tree.c
> @@ -660,7 +660,7 @@ void qmp_dumpdtb(const char *filename, Error **errp)
>
>      size = fdt_totalsize(current_machine->fdt);
>
> -    g_assert(size > 0);
> +    g_assert(size > 0 && size <= FDT_MAX_SIZE);

FDT_MAX_SIZE is not "this is as big as an FDT can ever be". It's
only the internal sizing of device trees that we create ourselves
in the machine models (and which we will bump up if for some
reason we ever find ourselves needing to create bigger device
trees). So it's not really a suitable upper bound.

>      if (!g_file_set_contents(filename, current_machine->fdt, size, &err)) {
>          error_setg(errp, "Error saving FDT to file %s: %s",

Nothing bad happens if we pass g_file_set_contents() a very
large size -- we'll just create a large file. The user already
has lots of ways to fill up their disk if they want to, and
we don't have any idea how much disk space they might or might
not have.

I would just mark this as a false positive.

thanks
-- PMM

