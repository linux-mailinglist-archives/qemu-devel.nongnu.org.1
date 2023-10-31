Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E799F7DD85F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:34:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxxJa-0001ch-PP; Tue, 31 Oct 2023 18:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxxJT-0001cV-2N
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxxJQ-000246-Uo
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698791656;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=h9lI0tNtG70/pP2m5ifCqCThdb1rlZhL1ckVHOg3/R8=;
 b=dM9eWoVNmrYaqkyWX2quTl7gL0wgWQcB2mRa16azo4ZMvX3V1sKJ9VrEfpPL2Z3eSm79E+
 3chycHy0jaY0TXwJDBDdEtG3xU/4Ao36QClXeaVbTObZPbzoJLZaLOZLTwMTdfvG79Nk1i
 i3giMTXzVBIM6y1BNFARnw8IhyzMMW8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-St67xmyGONmNFDgPXSkRlA-1; Tue, 31 Oct 2023 18:34:14 -0400
X-MC-Unique: St67xmyGONmNFDgPXSkRlA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c520e0a9a7so69220421fa.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698791653; x=1699396453;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9lI0tNtG70/pP2m5ifCqCThdb1rlZhL1ckVHOg3/R8=;
 b=J7HaWQLeLEHSdUNRjebO5G98b3frdpxvOnjm+X9961H0kDrJZbDwVvrdzgEu/+5Kdr
 cFJsy2qYnxlkbHGXkJ4eqAfpVsXFQxaVLcj68ScD0pmDJq3wEDeMUTc2d65r/CCExG2P
 HG1ju+uvCPs87HCa7bmPWYEuZmiI/YahXL+5/FFdmSuY/HzYXZIhfF2p+ddHf9e3RvcP
 PxbMhUx2o4FlCmKTvXmWogjDCl1I4HnXvl4GmVHTqW5SBwPpnNSETw6ohDSxmRROoq2c
 IwAhWjwcqcTjiwD9hp0q33R7JicL+aGYXPraEx6+gEWG7K6zvnQ7q7Ep8bV3rYnoVTP2
 10TA==
X-Gm-Message-State: AOJu0Yw3CHqF4wrs3zPuUCeNxg1QmvVUoT5Kz0Sto/+v03gUKo5D7nDJ
 Q0AFEzp6FDAAxP3KApvBeECFibQN9DdxroNc96beutV2xHZhXvww7qU/i8c/GhsjwvUjwdgbHfj
 WWsbywCtMdHgvMm0=
X-Received: by 2002:a05:651c:10b:b0:2c5:24a8:c22d with SMTP id
 a11-20020a05651c010b00b002c524a8c22dmr11230604ljb.3.1698791652880; 
 Tue, 31 Oct 2023 15:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC1fX6hBr0UiQVOXtCsr/fuhiU3yx2nT2zaqqRDuMziM5wbQQqsGWJigt5rRDx3teCZsfNCg==
X-Received: by 2002:a05:651c:10b:b0:2c5:24a8:c22d with SMTP id
 a11-20020a05651c010b00b002c524a8c22dmr11230597ljb.3.1698791652477; 
 Tue, 31 Oct 2023 15:34:12 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 ha15-20020a05600c860f00b004053a6b8c41sm2824037wmb.12.2023.10.31.15.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 15:34:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 3/5] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
In-Reply-To: <87o7gecuzl.fsf@suse.de> (Fabiano Rosas's message of "Tue, 31 Oct
 2023 19:01:02 -0300")
References: <20231017202633.296756-1-peterx@redhat.com>
 <20231017202633.296756-4-peterx@redhat.com> <87o7gecuzl.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 23:34:11 +0100
Message-ID: <87edha4e1o.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Peter Xu <peterx@redhat.com> writes:
>
>> From: Fabiano Rosas <farosas@suse.de>
>>
>> To do so, create two paired sockets, but make them not providing real data.
>> Feed those fake sockets to src/dst QEMUs for recovery to let them go into
>> RECOVER stage without going out.  Test that we can always kick it out and
>> recover again with the right ports.
>>
>> This patch is based on Fabiano's version here:
>>
>> https://lore.kernel.org/r/877cowmdu0.fsf@suse.de
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> [peterx: write commit message, remove case 1, fix bugs, and more]
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>
> This patch breaks the windows build. We need this:

I was doing this O:-)

migration-next

hit the exact problem that you mention.

Thanks, Juan.

> -->8--
> From 96fee99f2a3c8e11951100d94159eba02dd98540 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Tue, 31 Oct 2023 17:41:56 -0300
> Subject: [PATCH] fixup! tests/migration-test: Add a test for postcopy hangs
>  during RECOVER
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 2359d349cf..604ffe7746 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1417,6 +1417,7 @@ static void wait_for_postcopy_status(QTestState *one, const char *status)
>                                                    "completed", NULL });
>  }
>  
> +#ifndef _WIN32
>  static void postcopy_recover_fail(QTestState *from, QTestState *to)
>  {
>      int ret, pair1[2], pair2[2];
> @@ -1481,6 +1482,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
>      close(pair2[0]);
>      close(pair2[1]);
>  }
> +#endif
>  
>  static void test_postcopy_recovery_common(MigrateCommon *args)
>  {
> @@ -1520,6 +1522,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
>      wait_for_postcopy_status(to, "postcopy-paused");
>      wait_for_postcopy_status(from, "postcopy-paused");
>  
> +#ifndef _WIN32
>      if (args->postcopy_recovery_test_fail) {
>          /*
>           * Test when a wrong socket specified for recover, and then the
> @@ -1528,6 +1531,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
>          postcopy_recover_fail(from, to);
>          /* continue with a good recovery */
>      }
> +#endif
>  
>      /*
>       * Create a new socket to emulate a new channel that is different
> @@ -1565,6 +1569,7 @@ static void test_postcopy_recovery_compress(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +#ifndef _WIN32
>  static void test_postcopy_recovery_double_fail(void)
>  {
>      MigrateCommon args = {
> @@ -1573,6 +1578,7 @@ static void test_postcopy_recovery_double_fail(void)
>  
>      test_postcopy_recovery_common(&args);
>  }
> +#endif
>  
>  #ifdef CONFIG_GNUTLS
>  static void test_postcopy_recovery_tls_psk(void)
> @@ -3185,9 +3191,10 @@ int main(int argc, char **argv)
>              qtest_add_func("/migration/postcopy/recovery/compress/plain",
>                             test_postcopy_recovery_compress);
>          }
> +#ifndef _WIN32
>          qtest_add_func("/migration/postcopy/recovery/double-failures",
>                         test_postcopy_recovery_double_fail);
> -
> +#endif
>      }
>  
>      qtest_add_func("/migration/bad_dest", test_baddest);


