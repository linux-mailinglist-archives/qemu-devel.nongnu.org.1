Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B05F7C56D2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaCx-0002UL-SL; Wed, 11 Oct 2023 10:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaCp-0002Lx-3A
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaCm-0003XS-TO
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034536;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SGTiz0H+3s8sBsmEOUZ09sGIOOEhyppjQL+3OgyhDyY=;
 b=cb968RUxAxoHhxGOH4pYNp0VaeMrujZjQGaxYfzqGaHSOWakXPyaDTDmc6P7fIUNH13l1b
 pKEyfz6cNObkZs9JFXoDA46KlhX5L86LPpLFEnvv4lWKyGdKoeNa3sR+XepCezjPsdq3AY
 7J3CCAFWstwi96+4AByTwPjlwaSb1pQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-bGLls2LiPlqZ3CZldLJNpg-1; Wed, 11 Oct 2023 10:28:43 -0400
X-MC-Unique: bGLls2LiPlqZ3CZldLJNpg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4066e59840eso42821025e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034522; x=1697639322;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGTiz0H+3s8sBsmEOUZ09sGIOOEhyppjQL+3OgyhDyY=;
 b=byS4rtNBuaeB9BEHMTgW0zfwYHsR2+xqleWm3bdQNs5txufLa2vri04ltPrSkc1VTY
 l7ddryXtuDBgtqp75suovTwfu21jwChZsymWlatm249jxTcdrUE9g+CR76QfIlBYnv9R
 T+IN1d/udT54KvFNNBMAZ/6+i9GbifkJ+3Sr49ArtCwJtjaHiVoKCkQctKNuwZ3T75/t
 AKDoz/ig2ae0Ap6jR1Tq1hXK4L+kMkPebhWat2OtCKRlH9mreQjmcPKLEuQlknIJztUQ
 AWzC2No2JyUxqTwY9IAOR6mzHpH3Xl0V6TmZoiGDJoHMklPOBytIg/JsQ3pMLP8LuCuf
 HDBw==
X-Gm-Message-State: AOJu0YzmEkHSv45YLaF9g+51+yefqqmTMs0aRrYPs9DdF63kplmJmljv
 NzWXxtB8Wy1MvDdPImfYXk8h4xVqVyhcThds8HnVq28Dr4XUmMOvf8r8I7oKN9Z596s9x3y57Oc
 Fb4Hqa+gUtagOmaI=
X-Received: by 2002:a7b:cbd5:0:b0:3ff:ca80:eda3 with SMTP id
 n21-20020a7bcbd5000000b003ffca80eda3mr19026253wmi.10.1697034522734; 
 Wed, 11 Oct 2023 07:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1cRGvDVUnVl84S8cu5L2/TQjrnO9sRVjaoZs+wLoEzj4IWESL8MQSfenIrFMChgmSUaCODA==
X-Received: by 2002:a7b:cbd5:0:b0:3ff:ca80:eda3 with SMTP id
 n21-20020a7bcbd5000000b003ffca80eda3mr19026234wmi.10.1697034522393; 
 Wed, 11 Oct 2023 07:28:42 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m7-20020a7bce07000000b003fc16ee2864sm17018325wmc.48.2023.10.11.07.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:28:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 7/9] tests/qtest/migration: Define a machine for all
 architectures
In-Reply-To: <20231006123910.17759-8-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 6 Oct 2023 09:39:08 -0300")
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-8-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:28:41 +0200
Message-ID: <87h6mx8c86.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Stop relying on defaults and select a machine explicitly for every
> architecture.
>
> This is a prerequisite for being able to select machine types for
> migration using different QEMU binaries for source and destination.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 46f1c275a2..7c10ac925b 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -746,6 +746,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      const char *kvm_opts = NULL;
>      const char *arch = qtest_get_arch();
>      const char *memory_size;
> +    const char *machine;
>  
>      if (args->use_shmem) {
>          if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> @@ -758,11 +759,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      got_dst_resume = false;
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          memory_size = "150M";
> +        machine = "pc";

I would suggest:

      if (strcmp(arch, "i386")) {
          machine = "pc";
      } else {
          machine = "q35";
      }

New development is happening in q35, so I think this should be the more tested.

> @@ -774,10 +777,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                        "'nvramrc=hex .\" _\" begin %x %x "
>                                        "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
>                                        "until'", end_address, start_address);
> +        machine = "pseries";
>          arch_opts = g_strdup("-nodefaults -machine vsmt=8");
>      } else if (strcmp(arch, "aarch64") == 0) {
>          memory_size = "150M";
> -        arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
> +        machine = "virt";
> +        arch_opts = g_strdup_printf("-machine gic-version=max -cpu max "

Does this double -machine command line works?

I expect yes, but who knows.

Later, Juan.


