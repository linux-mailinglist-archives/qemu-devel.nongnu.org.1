Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D7D7C56E6
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaFH-0004n1-Tg; Wed, 11 Oct 2023 10:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaFB-0004kN-H5
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaF9-0004LG-8I
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034680;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XoPr7kq4lTGoDJCeGPeHUS79QVFlvDkTG4LKHgUzEoY=;
 b=WeOdyogzYR8zktDJXKh2E3mqFKioSFFwKKsEWxeh/hGwR/00yNq1V5hQMn3DM1H7OtVFZm
 YGZsQ5sGB/NmL6uhmXoZZ7tfh2sLJ1elQ3Az8dLQkQQEpuvnRO8QJjFs7Nq5ENW7liZ7d6
 QUtZ+A3eCk2Sw26wVPfmGyuO3QzPP9g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-oCFjRe7MMgKm3I0KrlTzdg-1; Wed, 11 Oct 2023 10:31:18 -0400
X-MC-Unique: oCFjRe7MMgKm3I0KrlTzdg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d8ac3743eso119993f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034677; x=1697639477;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XoPr7kq4lTGoDJCeGPeHUS79QVFlvDkTG4LKHgUzEoY=;
 b=foljqBcL8Y/Qju7RSUA5DGRou3KX550Cke5v0k1lcgZg1ZZi6KXXRu9U+oJ1XQl3Pw
 N2UWjMT3Y8r8b3E+8HLSAARaGmeFy6qARgov+sNhITdOs2lkKcxFyVt+TbSP7D3XVLUn
 gpuKKaQf10Yfg3BbDaQT12T48UnA3bkwkkVv67t5O+nlU0YZGpN7E2/A03h7AnKPEiR/
 oqtZOpFVUxNtYCM/GnQ2z7SenghT4b519QPHPgJQiF2QF1CN8PcyrA41F7+hN2Tevbu/
 Jre2rMyxiSW5/FGs+pL9qbPysx6zc2n+wDxY5cTbRwOJB1DQM7x+nNcqaFGDHER8rLrk
 9nRw==
X-Gm-Message-State: AOJu0YxKGzR6O8smbo+N56nlZkCrUuZDPUMMJtVMlxMU2VQRMIBdmEHp
 bZ5D/SIIB/YozAie14kbHVBbefec2yn/N61zO6VOJ/VuV+BvepiJAHZsLmEpnoplLD/rWQlesny
 +7Y4+kdF0HyJnaaM=
X-Received: by 2002:adf:9bcd:0:b0:32d:31ee:94a4 with SMTP id
 e13-20020adf9bcd000000b0032d31ee94a4mr3618303wrc.67.1697034677395; 
 Wed, 11 Oct 2023 07:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWRuBbhqoUu8heifsxU4LSbnkaXIsSIg+nIAmQnH/d7KWGsHDEn2S3ln0RrL213+5AwB+7xg==
X-Received: by 2002:adf:9bcd:0:b0:32d:31ee:94a4 with SMTP id
 e13-20020adf9bcd000000b0032d31ee94a4mr3618289wrc.67.1697034677079; 
 Wed, 11 Oct 2023 07:31:17 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 d12-20020a5d538c000000b0032769103ae9sm15654773wrv.69.2023.10.11.07.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:31:16 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 8/9] tests/qtest/migration: Support more than one
 QEMU binary
In-Reply-To: <20231006123910.17759-9-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 6 Oct 2023 09:39:09 -0300")
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-9-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:31:15 +0200
Message-ID: <87cyxl8c3w.fsf@secure.mitica>
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
> We have strict rules around migration compatibility between different
> QEMU versions but no test to validate the migration state between
> different binaries.
>
> Add infrastructure to allow running the migration tests with two
> different QEMU binaries as migration source and destination.
>
> The code now recognizes two new environment variables
> QTEST_QEMU_BINARY_SRC and QTEST_QEMU_BINARY_DST. In the absence of
> either of them, the test will use the QTEST_QEMU_BINARY variable. If
> both are missing then the tests are run with single binary as
> previously.
>
> The machine type is selected automatically as the latest machine type
> version that works with both binaries.
>
> Usage:
> QTEST_QEMU_BINARY_SRC=../build-8.2.0/qemu-system-x86_64 \
> QTEST_QEMU_BINARY_DST=../build-8.1.0/qemu-system-x86_64 \
> ./tests/qtest/migration-test
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

> ---
>  tests/qtest/migration-test.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 7c10ac925b..984f52becd 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -66,6 +66,9 @@ static bool got_dst_resume;
>   */
>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>  
> +#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
> +#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
> +
>  #if defined(__linux__)
>  #include <sys/syscall.h>
>  #include <sys/vfs.h>
> @@ -747,6 +750,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      const char *arch = qtest_get_arch();
>      const char *memory_size;
>      const char *machine;
> +    g_autofree char *machine_type = NULL;

machine_name?


