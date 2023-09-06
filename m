Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7087934B7
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 07:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdklH-0005Kj-6h; Wed, 06 Sep 2023 01:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdkky-0005AV-Kv
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 01:07:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdkkk-0000nI-AE
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 01:07:12 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99357737980so493789566b.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 22:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693976816; x=1694581616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GBBpneu0JSf+P2LW9fiT+KslmEwyFkoFwG2GAdzZ518=;
 b=cnpQdF1UGXwz4LKwijnWKzZoRwKgwSHyo3zjbn4uhTz2ogJvaryXDrw+uLyWflcWT0
 y21UZfw4UtNQ3M6fzRyyCGPZmFQCzsiwaWQb96t3GuR9qXY3r0cRlhebSGbHFtfa/p1w
 RSv4kAZ8R06QgU2sZ7JyeNycCDhkrdfnG1GrGiTvmNUWo9kut41X4U/HPFYjlBkfC5Wm
 I8VobL7e9CqL0prtBYfKEc+8NU+Ru+X3vQlL/tqGWWNwDeBALEmBX6qyUVdqzdP0NSnp
 jlqU2fqs/0Np6MNDIKcText2FkrNlZT6cf2YBz3m6UWoEd/zS0HlG7qG4Q/m9GpmQiGV
 CxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693976816; x=1694581616;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GBBpneu0JSf+P2LW9fiT+KslmEwyFkoFwG2GAdzZ518=;
 b=ApsHi0NIVynFQ4CL+dierJfbPPfALGXui7bV8G7TtPQp/x7dkXeMiQCHuZ5NpV4HL2
 8kb9lLpcjynkowXdodh4iMBBT2moh3awMp9cZv5c0o5WpWIQQzCGQDqEUBl91uvAF1FY
 iSWHxjS/ukc1SQtt93f+0F9ELesfgNUqkFz5zxCyLmxD25UIfWyCnJhAdsOYgRxIjtek
 xzNG6QiskS2W4WuFkyb/qLwtVwPNkQ/0dEdGjFM+DTNXLBIkRwSFp/UDQ2kfivKuWXFU
 BjHA6IMKm+UaA7EaaWsueoKIJQSkd0ek/IDuOvvKOmZp6zS8Tt2kAiZUY0vr+k0pJAwW
 BdEw==
X-Gm-Message-State: AOJu0YxeGUj+3LLv0c8W8F27piKLuNvBN0tCWfX4wErXw3FWvXAz/qD4
 R30EEOOd/W5MNLOX0h7Jw+12Bw==
X-Google-Smtp-Source: AGHT+IE9/xMa6ep9Tui39YLAyrolf5l4xleh1sdlh/4nSihdfODdHReSe/zohJATyEaEf859ujnPcg==
X-Received: by 2002:a17:907:774d:b0:9a1:bd53:b23 with SMTP id
 kx13-20020a170907774d00b009a1bd530b23mr1470518ejc.14.1693976816185; 
 Tue, 05 Sep 2023 22:06:56 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 e7-20020a170906248700b0099cc15f09a0sm8418555ejb.55.2023.09.05.22.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 22:06:55 -0700 (PDT)
Message-ID: <f4d924de-9098-cc9d-7e2f-4ab2bb07c693@linaro.org>
Date: Wed, 6 Sep 2023 07:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 1/4] uuid: add a hash function
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230802090824.91688-1-aesteve@redhat.com>
 <20230802090824.91688-2-aesteve@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230802090824.91688-2-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 2/8/23 11:08, Albert Esteve wrote:
> Add hash function to uuid module using the
> djb2 hash algorithm.

^ This info ...

> Add a couple simple unit tests for the hash
> function, checking collisions for similar UUIDs.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   include/qemu/uuid.h    |  2 ++
>   tests/unit/test-uuid.c | 27 +++++++++++++++++++++++++++
>   util/uuid.c            | 14 ++++++++++++++
>   3 files changed, 43 insertions(+)
> 
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index dc40ee1fc9..e24a1099e4 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -96,4 +96,6 @@ int qemu_uuid_parse(const char *str, QemuUUID *uuid);
>   
>   QemuUUID qemu_uuid_bswap(QemuUUID uuid);
>   
> +uint32_t qemu_uuid_hash(const void *uuid);
> +
>   #endif
> diff --git a/tests/unit/test-uuid.c b/tests/unit/test-uuid.c
> index c111de5fc1..aedc125ae9 100644
> --- a/tests/unit/test-uuid.c
> +++ b/tests/unit/test-uuid.c
> @@ -171,6 +171,32 @@ static void test_uuid_unparse_strdup(void)
>       }
>   }
>   
> +static void test_uuid_hash(void)
> +{
> +    QemuUUID uuid;
> +    int i;
> +
> +    for (i = 0; i < 100; i++) {
> +        qemu_uuid_generate(&uuid);
> +        /* Obtain the UUID hash */
> +        uint32_t hash_a = qemu_uuid_hash(&uuid);
> +        int data_idx = g_random_int_range(0, 15);
> +        /* Change a single random byte of the UUID */
> +        if (uuid.data[data_idx] < 0xFF) {
> +            uuid.data[data_idx]++;
> +        } else {
> +            uuid.data[data_idx]--;
> +        }
> +        /* Obtain the UUID hash again */
> +        uint32_t hash_b = qemu_uuid_hash(&uuid);
> +        /*
> +         * Both hashes shall be different (avoid collision)
> +         * for any change in the UUID fields
> +         */
> +        g_assert_cmpint(hash_a, !=, hash_b);
> +    }
> +}
> +
>   int main(int argc, char **argv)
>   {
>       g_test_init(&argc, &argv, NULL);
> @@ -179,6 +205,7 @@ int main(int argc, char **argv)
>       g_test_add_func("/uuid/parse", test_uuid_parse);
>       g_test_add_func("/uuid/unparse", test_uuid_unparse);
>       g_test_add_func("/uuid/unparse_strdup", test_uuid_unparse_strdup);
> +    g_test_add_func("/uuid/hash", test_uuid_hash);
>   
>       return g_test_run();
>   }
> diff --git a/util/uuid.c b/util/uuid.c
> index b1108dde78..64eaf2e208 100644
> --- a/util/uuid.c
> +++ b/util/uuid.c
> @@ -116,3 +116,17 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid)
>       bswap16s(&uuid.fields.time_high_and_version);
>       return uuid;
>   }

... would be more useful as a comment here.

/* djb2 hash algorithm */

Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +uint32_t qemu_uuid_hash(const void *uuid)
> +{
> +    QemuUUID *qid = (QemuUUID *) uuid;
> +    uint32_t h = 5381;
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(qid->data); i++) {
> +        h = (h << 5) + h + qid->data[i];
> +    }
> +
> +    return h;
> +}
> +


