Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA77AEB1C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:12:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5yw-00076M-V3; Tue, 26 Sep 2023 07:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5yq-000740-Bb
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:11:52 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5yo-0000vk-0Z
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:11:52 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533c4d20b33so11655136a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 04:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695726708; x=1696331508; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vyGQyO4JRmPkCQicAh0jedKXfzwuqcfFcqxg7axswD0=;
 b=OLs0gtzRLiYkgLUwod2WIINlyJP7m0x6TU/i3WbEg2WRIWiz81BPCVrwiXmcjoa6hO
 9nI7TuuZhkuqbv7G40uLHJcTRZC59IiBkcm9kv8mQoeoCYMvjc5RA95DsgVF6DCvz4BA
 AnRtr4959OFKKBI9mZvWx6ei8iiJEjnavGL36wl37Ms5MlTziTUDr118544Wiggb2QLu
 jat7e3hbYGu0P1kgp1+ISCjwrvwqy+zOpu2XVVEzuyZMwaXM/EQGtBvI3l2/uaNtpozt
 g4pczpzrGHSmUz0pp2vp2sgqeSjOZjVC0H24wThThbZ84+zTmyj+0kRnu679Ox/WhwGG
 YYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695726708; x=1696331508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vyGQyO4JRmPkCQicAh0jedKXfzwuqcfFcqxg7axswD0=;
 b=jmjZmIIZK5ktjroL9dIwtXO/7ZZ3eYyxx5LFT+YEmNjlmcJT7kUTXu3hh64UPsOyjU
 Pssy62kvaqTp08zpM4PrF5dxqey5UF0gA8SXt/eNRgJ31mzAxEn58UvlHqwyOJZSAr2A
 wED4aRMq0tpAbXv9Y5pmzTe0e4shXsc3fwIoQDoSrRYx9PEzZAxWDklDWIywCiXbnlDJ
 pEwxZZ1d3sE1H/qEJDm+wsnnokDOeo/HbpXNaco4l0LYPA0xsFB8q9mHuUuzzocRPMR0
 Wv3fkS13YaCxwAZ9jlFYNDsK3MVVsHHcxNQ1OW40TKpP6zDIUqhvmvdAAowMjPgbdHnq
 YtCg==
X-Gm-Message-State: AOJu0YxxFqVG3R2sCoI2PIXXO0zZkhLTAqovWA4A4YOg5EPOLcX2uqkd
 vib3BsfxjAarQ/SBhEZVudMP3AVTQAYShe4QSS1hIA==
X-Google-Smtp-Source: AGHT+IEYN2TKErigFw8DLK8c0cuZ/X4uC6DTAZFMFMVpq69CPRF++6/kqJbM+OihjZKS/nUu+HA8BkxZHDXshrW8dpo=
X-Received: by 2002:a05:6402:1e93:b0:534:2ee8:fd52 with SMTP id
 f19-20020a0564021e9300b005342ee8fd52mr3551007edf.12.1695726707825; Tue, 26
 Sep 2023 04:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-12-vsementsov@yandex-team.ru>
In-Reply-To: <20230925194040.68592-12-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 12:11:29 +0100
Message-ID: <CAFEAcA9Ji=kC3TxV3BiYcPFGvAp+Jx3bAO1k2_S01wWVVMoUkQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] hw/core/loader: read_targphys(): add upper bound
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Ard Biesheuvel <ardb@kernel.org>
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

On Mon, 25 Sept 2023 at 20:41, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Coverity doesn't like using "untrusted" values, coming from buffers and
> fd-s as length to do IO and allocations. And that's make sense. The
> function is used three times with "untrusted" nbytes parameter. Let's
> introduce at least empirical limit of 1G for it.
>
> While being here make the function static, as it's used only here.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/core/loader.c    | 13 ++++++++++---
>  include/hw/loader.h |  2 --
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index aa02b27089..48cff6f59e 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -101,17 +101,24 @@ ssize_t load_image_size(const char *filename, void *addr, size_t size)
>      return actsize < 0 ? -1 : l;
>  }
>
> +#define READ_TARGPHYS_MAX_BYTES (1024 * 1024 * 1024)
>  /* read()-like version */
> -ssize_t read_targphys(const char *name,
> -                      int fd, hwaddr dst_addr, size_t nbytes)
> +static ssize_t read_targphys(const char *name,
> +                             int fd, hwaddr dst_addr, size_t nbytes)
>  {
>      uint8_t *buf;
>      ssize_t did;
>
> +    if (nbytes > READ_TARGPHYS_MAX_BYTES) {
> +        return -1;
> +    }
> +
>      buf = g_malloc(nbytes);
>      did = read(fd, buf, nbytes);
> -    if (did > 0)
> +    if (did > 0) {
>          rom_add_blob_fixed("read", buf, did, dst_addr);
> +    }
> +
>      g_free(buf);
>      return did;
>  }

This is called only from load_aout(). load_aout() is
passed a max size that it can write. So we shouldn't
be imposing a different maximum size in this utility function,
in the same way that the standard library read() does not
say "I'm going to impose a 1GB limit on how much you can read".
If the limit checks in load_aout() are wrong we should fix them.

(In any case load_aout() is used only for loading the initial
kernel on PPC and SPARC, so it's not very important.)

thanks
-- PMM

