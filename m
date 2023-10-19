Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4287CF00F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 08:26:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtMTn-0007iv-Py; Thu, 19 Oct 2023 02:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtMTi-0007h7-7I
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtMTd-0008Nu-8e
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697696747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UeZZqJCGHH0M8UDUlN29++l8j1hB4yy6gIYyKTbI2Hs=;
 b=ezN3W9ao5/6mX3mGXYm7mC5grcsIOeqEy3On4KXt5gDyZ3nSHqLhGIAedAE3LMEM6Atgum
 JHz6pNw074RjmGpMSlh2Smmi3HmytVrl0mf0vzf2gU/FP0t4CLNXNXap9IUNR+nywtLjOW
 sqydTRlpOSJxiMphEBrYWPABymeqmVA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-raOYTUVyMsq6bPLHvqL35Q-1; Thu, 19 Oct 2023 02:25:45 -0400
X-MC-Unique: raOYTUVyMsq6bPLHvqL35Q-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41b8299aad9so30039461cf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 23:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697696745; x=1698301545;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UeZZqJCGHH0M8UDUlN29++l8j1hB4yy6gIYyKTbI2Hs=;
 b=fls59qO+HjM/XuOiwmEXGLv+NLhPUGLcTRpxu92xHzXodMI59k0JQO6m8lCzM6jQaN
 xrIFB2z7HBhU1y5rRPlc085mWjVWUdtzBjuVO9pGTNLIoU9+GAxouhkOx2UQs0C8gut5
 1Ll7OQjU0+go4E6X9uwr9IevYu7n9sve26pwziZd1+qhNuWroDKnFUPcr1jV790pIQZh
 3GR93CtXHrESXpiZ52C0oQ58SSMkyjQesibSX1tq0ztGXbPw2TkYDNmNzwy4GcMhG4X2
 M1nLkJ/b82zQlZxwq4/p+N2MTtID23lZtaY8MbS/sHxUz+8qUGZNckMeWA701MMnKCgt
 bDeA==
X-Gm-Message-State: AOJu0YydA2M0NvcH2UvHxfg+YOA+fwl3FK6vPQxYKjoA/8/QL5v5cD0s
 EBhrl0nMLJlSbYoa6ulo9qt6csig4q4SHqKVr/JMvSwHAQcF2lXJq6LmfXlYIGPQuOP+e35o5dC
 pyd6WULuUJybDKTU=
X-Received: by 2002:a05:622a:1910:b0:417:a514:72cd with SMTP id
 w16-20020a05622a191000b00417a51472cdmr1631119qtc.19.1697696745251; 
 Wed, 18 Oct 2023 23:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERh32oCoyts0TdBV0nkFLHNoapdDnqb1PVM3u9lHPQjpftj1z9crG+ka/sdJOub2W7K//cQw==
X-Received: by 2002:a05:622a:1910:b0:417:a514:72cd with SMTP id
 w16-20020a05622a191000b00417a51472cdmr1631101qtc.19.1697696744948; 
 Wed, 18 Oct 2023 23:25:44 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 o9-20020ac85a49000000b004199f47ccdbsm531701qta.51.2023.10.18.23.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 23:25:44 -0700 (PDT)
Message-ID: <1b7b78b2-4292-4daa-91a2-79966aa72a9d@redhat.com>
Date: Thu, 19 Oct 2023 08:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] tests/qtest/migration: Define a machine for all
 architectures
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231018192741.25885-1-farosas@suse.de>
 <20231018192741.25885-8-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231018192741.25885-8-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 18/10/2023 21.27, Fabiano Rosas wrote:
> Stop relying on defaults and select a machine explicitly for every
> architecture.
> 
> This is a prerequisite for being able to select machine types for
> migration using different QEMU binaries for source and destination.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/migration-test.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index e1c110537b..43d0b83771 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -743,6 +743,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       const char *kvm_opts = NULL;
>       const char *arch = qtest_get_arch();
>       const char *memory_size;
> +    const char *machine_alias, *machine_opts = "";
>   
>       if (args->use_shmem) {
>           if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> @@ -755,11 +756,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       got_dst_resume = false;
>       if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>           memory_size = "150M";
> +        machine_alias = "pc";
>           arch_opts = g_strdup_printf("-drive file=%s,format=raw", bootpath);
>           start_address = X86_TEST_MEM_START;
>           end_address = X86_TEST_MEM_END;
>       } else if (g_str_equal(arch, "s390x")) {
>           memory_size = "128M";
> +        machine_alias = "s390-ccw-virtio";
>           arch_opts = g_strdup_printf("-bios %s", bootpath);
>           start_address = S390_TEST_MEM_START;
>           end_address = S390_TEST_MEM_END;
> @@ -771,11 +774,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                         "'nvramrc=hex .\" _\" begin %x %x "
>                                         "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
>                                         "until'", end_address, start_address);
> -        arch_opts = g_strdup("-nodefaults -machine vsmt=8");
> +        machine_alias = "pseries";
> +        machine_opts = "vsmt=8";
> +        arch_opts = g_strdup("-nodefaults");
>       } else if (strcmp(arch, "aarch64") == 0) {
>           memory_size = "150M";
> -        arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
> -                                    "-kernel %s", bootpath);
> +        machine_alias = "virt";
> +        machine_opts = "gic-version=max";
> +        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
>           start_address = ARM_TEST_MEM_START;
>           end_address = ARM_TEST_MEM_END;
>       } else {
> @@ -810,11 +816,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       }
>   
>       cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
> +                                 "-machine %s,%s "
>                                    "-name source,debug-threads=on "
>                                    "-m %s "
>                                    "-serial file:%s/src_serial "
>                                    "%s %s %s %s %s",
>                                    kvm_opts ? kvm_opts : "",
> +                                 machine_alias, machine_opts,
>                                    memory_size, tmpfs,
>                                    arch_opts ? arch_opts : "",
>                                    arch_source ? arch_source : "",
> @@ -829,12 +837,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       }
>   
>       cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
> +                                 "-machine %s,%s "

If machine_opts is empty, there will be a lonely "," at the end of the 
parameter ... seems to work, but it's a little bit ugly.

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


>                                    "-name target,debug-threads=on "
>                                    "-m %s "
>                                    "-serial file:%s/dest_serial "
>                                    "-incoming %s "
>                                    "%s %s %s %s %s",
>                                    kvm_opts ? kvm_opts : "",
> +                                 machine_alias, machine_opts,
>                                    memory_size, tmpfs, uri,
>                                    arch_opts ? arch_opts : "",
>                                    arch_target ? arch_target : "",


