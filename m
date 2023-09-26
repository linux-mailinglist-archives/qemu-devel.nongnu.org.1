Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E907AEA6F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:34:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5OB-0002mw-H5; Tue, 26 Sep 2023 06:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5O9-0002md-P2
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:33:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5O8-000152-4N
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:33:57 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-533c92e65c9so6332619a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695724434; x=1696329234; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TZCA/vcyZCNs1bt3092DVYQhUUzrnHflqSxCPDaS+94=;
 b=DsU1VAlV8/sDAzhrwkb0l5jxchw7jtk9xvpgDqyl/O89PRYlZ3Kg8BwKcbIgyeM+I9
 jn5RdSsCKKHEVYwqchYeH+8W4AjTKnbqrhdxeXqG7Zcym5LlW0pTClGuKHIroZPkPh/h
 p72bwZbcMzclGXkcImZ0HpdF2R9tEDflIURV1CoNqFbx8qCSqpdzlLPeMqJDNTYVsShq
 zARsGFhfx1CEScZnwnHuxwCy8mUwUZX5yvb49y9J+6D7B24MqX0BQDfcQD90LlMoHzdG
 b5pfM2FReZLPpNaG5Vubn0TOTdO25hd1+6t5/bvShS3MTJbgX8FVh4Q46BHhofKxDs1F
 5aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695724434; x=1696329234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZCA/vcyZCNs1bt3092DVYQhUUzrnHflqSxCPDaS+94=;
 b=wkawhM4Zxfu66IWRsZBDRmxqfbJMiBsGVIiOFYzVDBffogbGCQqF3yWeZad1ViuO30
 VfCCDcp9EBEzKD0rnSsfkNHMtX72Knr2uh6eSsY8kVdEsee6JM8Vs30IR8exXdeKIqAA
 N1pVEUmhtt8TTSyQ5F2hprM3+0stq7aZxiTGk95eEj0AhNoU7OrYJuZrwidCy0cBoQQF
 o6bzjVyQbWflhomRsJ4G38LXO8W/FKNOk0LuhZKhDcVIZHxqvifH/ohAt6eEONTVlTza
 IFBIrH0u273ttabKBSCbQO+cSSt6SatWbWqk8V80okxan0MD5qrLokHmrsVJrJ3r9C0q
 aqRA==
X-Gm-Message-State: AOJu0YwpddtzADU1NB/zVyaGQ2b+mXZwl6KMxRBC0129w9tiUo6JqM3H
 dEwXjeAIwHLYc3tLq2/colxw0Rn8y9o+TxPKnDvPrg==
X-Google-Smtp-Source: AGHT+IHhg9pUBhIS7hYAzO7v/GFMR3Qss9jJfLKYe0K9ECJRKsHe0jio9XmusdkYyFEz541lDtb65XpLCqbSTz11Ppk=
X-Received: by 2002:aa7:d44e:0:b0:52b:d169:b374 with SMTP id
 q14-20020aa7d44e000000b0052bd169b374mr8142078edr.3.1695724434087; Tue, 26 Sep
 2023 03:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-2-vsementsov@yandex-team.ru>
In-Reply-To: <20230925194040.68592-2-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 11:33:35 +0100
Message-ID: <CAFEAcA8MeLs5fz+PjLsL351OHv3vr8+4_tnD97guZHXs76iTog@mail.gmail.com>
Subject: Re: [PATCH 01/12] hw/core/loader: load_at(): check size
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 25 Sept 2023 at 20:41, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> This @size parameter often comes from fd. We'd better check it before
> doing read and allocation.
>
> Chose 1G as high enough empiric bound.

Empirical for who?

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/core/loader.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 4dd5a71fb7..4b67543046 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -281,11 +281,26 @@ ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
>
>  /* ELF loader */
>
> +#define ELF_LOAD_MAX (1024 * 1024 * 1024)
> +
>  static void *load_at(int fd, off_t offset, size_t size)
>  {
>      void *ptr;
> -    if (lseek(fd, offset, SEEK_SET) < 0)
> +
> +    /*
> +     * We often come here with @size, which was previously read from file
> +     * descriptor too. That's not good to read and allocate for unchecked
> +     * number of bytes. Coverity also doesn't like it and generate problems.
> +     * So, let's limit all load_at() calls to ELF_LOAD_MAX at least.
> +     */
> +    if (size > ELF_LOAD_MAX) {
>          return NULL;
> +    }
> +
> +    if (lseek(fd, offset, SEEK_SET) < 0) {
> +        return NULL;
> +    }
> +
>      ptr = g_malloc(size);
>      if (read(fd, ptr, size) != size) {
>          g_free(ptr);

This doesn't really help anything:
 (1) if the value is really big, it doesn't cause any terrible
consequences -- QEMU will just exit because the allocation
fails, which is fine because this will be at QEMU startup
and only happens if the user running QEMU gives us a silly file
 (2) we do a lot of other "allocate and abort on failure"
elsewhere in the ELF loader, for instance the allocations of
the symbol table and relocs in the load_symbols and
elf_reloc functions, and then on a bigger scale when we
work with the actual data in the ELF file

thanks
-- PMM

