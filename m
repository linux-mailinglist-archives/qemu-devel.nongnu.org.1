Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B94A770720
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 19:31:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRydh-0002Eh-19; Fri, 04 Aug 2023 13:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRydc-0002EB-W5
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:30:57 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRydb-00050V-Bk
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:30:56 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51d95aed33aso2997204a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691170253; x=1691775053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bOuiU5ZW9zz11e1BN38bNRgIGGHRKtNMy6IPjUjXKW0=;
 b=PqvfCAUqZ/yw+E8zVoC9Gk9O+qIOI1NY/1YUg20y7OJ4nfTcXt6ycNgcLHla4XleNK
 6m0SrN+hOPreYYRKwR8MHNwrDJonxAmD3JscZ38NCZTsf2FC6uw/K+eFPu5WgEngnXb2
 LaUsnpwLtMoBWUSibkX727TWrarzFFhp8KzKEsIa7XJyRM3O4oLyL1bReyz+FWnVPKed
 IJzF/idyPvgmDiTKQMXWdUHWhE4IdGBj2c3K2iUYO+FppmxZdmVOcl47kulmVYyOgxfx
 /ZPg0GP/Jmw02bMcs8BwUTuQvFSMgCBwyW6euHvpDmhDcLJn22MFeNrhVFEk6VE3o0WX
 P29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691170253; x=1691775053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bOuiU5ZW9zz11e1BN38bNRgIGGHRKtNMy6IPjUjXKW0=;
 b=GQOMCBNC+i4DRBPL0dF6Do+02nK1ojEmiCzmPHQeZj+jXYIBiWHXMe0U0kFkZjeFpg
 Fm2wPF7ZzwkvPa92CFYMK3b8sHIxM0OYZPGYaRYT1m88eIYovS3d8jRaOU/LrhUFMGF2
 zLNKI9HXvKo6/0xV9RkSQYICLf3Z3zpcyqwt80Ec25hGYc3Zz00E5i1LNvz1Z51+b4Ub
 i4mo6tuWKkKYEjHUbUPMBJ7ycCIQePvhY8rTwsjPEW14JJOkAsQKeAHjsbYDWJ/0+djs
 FcWIb3u5D1ChiScZKxaRvSz7aqLIEZTRsmHzCJ50KyYDOrqwzh/u8gwivnMBd4ZM4LxR
 5lbw==
X-Gm-Message-State: AOJu0YyzXw2JWA3ndfrEw2iynioVqUIzOA4xdf8w/VgSMDc+KPqaAL7T
 15nLBFd5hDziOQ/6Oie1k9nJ1bd9zaung2rhRLq8+w==
X-Google-Smtp-Source: AGHT+IEjMkRcGehepByb1/0uIJtXrPzN/P0x8pr6Y4Jh+lrsYz8/dyTuNk8fS1C5nmXp98IbbzLSJbdVjLoevKcsBYM=
X-Received: by 2002:aa7:c1d1:0:b0:522:38f9:4d5b with SMTP id
 d17-20020aa7c1d1000000b0052238f94d5bmr1982492edp.18.1691170252565; Fri, 04
 Aug 2023 10:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-6-akihiko.odaki@daynix.com>
In-Reply-To: <20230727073134.134102-6-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 18:30:41 +0100
Message-ID: <CAFEAcA845sHzqVN_cZyvR69uhbfhTqsvWcdM4y9qFTv_pBmtnw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] accel/kvm: Free as when an error occurred
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 27 Jul 2023 at 08:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> An error may occur after s->as is allocated, for example while
> determining KVM type.

That's about the one example you don't want to cite, because
it makes it sound like this is only a problem because
of a bug in the previous patch. In fact we already have
lots of 'goto err' paths after the allocation of s->as,
such as the one when kvm_ioctl(KVM_CREATE_VM) fails.

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  accel/kvm/kvm-all.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 94a62efa3c..4591669d78 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2765,6 +2765,7 @@ err:
>      if (s->fd != -1) {
>          close(s->fd);
>      }
> +    g_free(s->as);
>      g_free(s->memory_listener.slots);
>
>      return ret;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

