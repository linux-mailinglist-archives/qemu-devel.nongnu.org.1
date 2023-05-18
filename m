Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8BF70855F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:53:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfwN-0002Wh-11; Thu, 18 May 2023 11:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzfwJ-0002OS-VG
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:53:16 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzfwI-0000XO-AI
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:53:15 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-510e419d701so1862111a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684425191; x=1687017191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HzAxjRWg6oAnaYwcIoiUlQTiEpqRX0Jn7vfdp876LBU=;
 b=ij58i4GVdwGSk1MiNfdawzDHH3ZZXTXD/WqbFjJta+fVDXjAawBMgmjEtum4qSYfsV
 5MRkU2vX0F3U9kV7WeWfmHauK08b5Q7gczO4Ib73AqUywy8DVRw8wFz573/FGORmW1f6
 Sgy9fIl9r3PbbI6Y4u12u57vNA4o8R9NzYAXrlP5JrNnWZ9iHe1gbz4wsMU6nr8gJNOJ
 cLQdOJRPhsfM/X4NwtsxH/upy+4nNaFjMJ5XmrRuin3j5qB+yppqACt4o8E6q3H5y3Fc
 tyRZxm0KyaWeIixgz0n+pkloKhp1CmNO9s4tMKGCGP0P1qpOWBPsi3CHxT8sN8Nbrd6v
 3cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684425191; x=1687017191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzAxjRWg6oAnaYwcIoiUlQTiEpqRX0Jn7vfdp876LBU=;
 b=Ywyv1tbNtUGDJqgiD7xabN4gobMOsOwUDC/eoE8WJNNQhgRp6w3w7RbkDCiGRPs/w1
 dZ+QdLiwrVW9i25C2sh92VF8ONj1FLXqFZ3hjD2Vfy5u6zVdUl93pcO0LqtR3MCF5hpR
 g97jNjj+o/+lGg6fOKYaaUW/oRNAzGvhakrNpZnXWfaMqrBh8vXe8K1nGrnPSRfA6ECK
 QP3S6QIuEeDi59JRq9pKxrGeiUT5FkTNh5aV/ftsSMQWuTLuW7BeqqmlAGVyOh+NSIVY
 K2qZbMQas1J6Jislf1o7JAdZBxpMfu93ZINU0RO1jYvqB6+elnY6Dhrebu0gUGDfmdfr
 5HDg==
X-Gm-Message-State: AC+VfDw2Dog7N162/BdVvYpKDQ5Jc8YAQjeyT48DssZgH7xi3W9iSjyg
 qDri/x2Arjjl1OySCd+3Z2YBN2J/fVRYoBbSmEyiE0rah7DayjNa
X-Google-Smtp-Source: ACHHUZ4k4ry0vqoUw7GWMsXJobhx86G1pHlhd7YOTrD2kWWHMmWCCspOCFXrYyy/lzBm4lDE+ciU3qaFUpnxNkbmnlc=
X-Received: by 2002:a05:6402:1a48:b0:50b:d23c:deb4 with SMTP id
 bf8-20020a0564021a4800b0050bd23cdeb4mr6353154edb.42.1684425191517; Thu, 18
 May 2023 08:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-5-richard.henderson@linaro.org>
In-Reply-To: <20230518044058.2777467-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 16:53:00 +0100
Message-ID: <CAFEAcA-bM_14e9pp2UY=wxyHqOKQZkjHrSzND8SLFcHG1bKtQg@mail.gmail.com>
Subject: Re: [PATCH 4/9] tcg/i386: Use cpuinfo.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 18 May 2023 at 05:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use the CPUINFO_* bits instead of the individual boolean
> variables that we had been using.  Remove all of the init
> code that was moved over to cpuinfo-i386.c.
>
> Note that have_avx512* check both AVX512{F,VL}, as we had
> previously done during tcg_target_init.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.h     |  28 +++++----
>  tcg/i386/tcg-target.c.inc | 123 ++------------------------------------
>  2 files changed, 22 insertions(+), 129 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

