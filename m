Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5267BFAD6
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBY3-0000to-B1; Tue, 10 Oct 2023 08:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qqBXr-0000t0-1d; Tue, 10 Oct 2023 08:09:03 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qqBXo-0003DJ-Ke; Tue, 10 Oct 2023 08:09:02 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9b98a699f45so938936066b.3; 
 Tue, 10 Oct 2023 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1696939730; x=1697544530; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dtl31oo8Wia0+HlYi66ypyuAZ6FNY5PjhpiPOpWNmkk=;
 b=lftGqyqs9JGZZUDjgwC0InoIumxfJQemqT5AaSnAlymudQOeSLwkmO7+FGWG6pRAVn
 JHodUk3L0MQrJLwB9ZUktkgPHszXMshysdv1IYv0jIB6whNJ3qro0mQxqDpnG8dWhYVI
 kDTIgwOCVDvHNRj38cMZONyBneTDQMmyuz4Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696939730; x=1697544530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dtl31oo8Wia0+HlYi66ypyuAZ6FNY5PjhpiPOpWNmkk=;
 b=Ozg5deibdCdSjGLaNErmW3KIRqGnbhFinEHiTjhLu3KZ+Pukz1WmZ7cpn5EKeZbneE
 4Y2JA0rCPNvVNmA1t866ZFcYeWJ+znPGZX61jSA0I+u79txkQ42pIS9gNmPJDys5WmWw
 yFi5Wz3/1xcetf6Oq0NF+U8vKvkjpvb2GUelQu8z8j3nX4UYTQAfwl4gmO54ZfmS5Wqu
 3nZP94nvRSU6M1kK/nVz+hkZC/9jtxmCTOyrcp6GUD5o8BUURAt6lVxGy5thQ+gRn7rq
 876dTe9Ev6YykyxZdUAAiZFyOKvdao5lQ5y+cdfKv2QOIqCl0/iRskV7F+NO2LA5OIQs
 EPJQ==
X-Gm-Message-State: AOJu0Yy8T1Eo8WWa4NPVQJMUqj2Mk/jbBP5VAE5nR8cH4xbrOrslNoDP
 sdfuCpgdoFsCd/ErF/I+qX87MtUvjTZ5y4CIhEk=
X-Google-Smtp-Source: AGHT+IGRjS8574QtF1QCnOit5VboLfAbkJSQpa0zuePhX/qn6wEv6uZQE9rkjagzouy0I16TC+KGcrERhXNxqdSbS0M=
X-Received: by 2002:a17:906:2189:b0:9ae:6ad0:f6db with SMTP id
 9-20020a170906218900b009ae6ad0f6dbmr15547849eju.71.1696939729680; Tue, 10 Oct
 2023 05:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-11-npiggin@gmail.com>
In-Reply-To: <20231010075238.95646-11-npiggin@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 10 Oct 2023 22:38:38 +1030
Message-ID: <CACPK8XfXmMGuKzUxjM7HK9m7PVNUk9SE0WtkPN6B+EP8Sov=Rw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] ppc/spapr: change pseries machine default to
 POWER10 CPU
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 10 Oct 2023 at 18:25, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> POWER10 is the latest pseries CPU.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d4230d3647..9d3475d64b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4661,7 +4661,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>
>      smc->dr_lmb_enabled = true;
>      smc->update_dt_enabled = true;
> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>      mc->has_hotpluggable_cpus = true;
>      mc->nvdimm_supported = true;
>      smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
> --
> 2.42.0
>
>

