Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A390788DD9
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 19:35:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZagg-0001ri-GY; Fri, 25 Aug 2023 13:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZagd-0001rE-O4
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZagb-0004vK-D6
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692984808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3T3udCzIZ6asIVce3bVXx5+qApIuHNMyk+/fCSxsO4=;
 b=bS5cPnSamumW37Pe3iL6AjnExTeXauiGfnvap2CP5K8mXE6UBLvYJdyumsR3TJUVAmPVsW
 Jen6mD8zUv8RLlnwe16gr9SwaZ4va833vUsZWwVIx2oe5N//X/AP/5FkTGbkIwvSY8SDUr
 q6RR00iQRT38A0xUcguTneWp5cIVUEg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-VhmU6UGuPNauO_haUfbVeg-1; Fri, 25 Aug 2023 13:33:26 -0400
X-MC-Unique: VhmU6UGuPNauO_haUfbVeg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401be705672so1067555e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 10:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692984805; x=1693589605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3T3udCzIZ6asIVce3bVXx5+qApIuHNMyk+/fCSxsO4=;
 b=LvJh5Cz48mSkRmhSNx2pdCQLzwTZC/VUQCNSrl/ZmwCDp+qzL5JaUoN+dB8+cVCV3k
 WBSKsYXBEsUOwBwGA3qy2UY+ngzxvc8A0uzg7/+X8l3aje4pnioTr0ux1WN6beuYplnd
 4JBxB0Qv2yajLIXb5V8XQtFhsghtffj7KrAYvDBLYnu2j71yko7CIhRnQtrinbXOPTO6
 x9MutXkESnL7Q2JfZ+kFH4Fqy9NPHehsvhp3Scak35tKXyPgH8E9F4GkQYU5ToU/VLly
 rFkk3OTrhqTaWTXQWuUoumSZaRsxMinEUCEkMFSqNGI4rqTkQKKQR+RnsfuL+uLJpuBx
 wh/Q==
X-Gm-Message-State: AOJu0YxA/eoFg5WAg//6g5KXBthcAhpSvTGDXqdmde2ijOd1gs/Trhyc
 Rv+9ywPyyMexeUSCU+6e4/Sy84NrmAIQhFXu/Hkopc96u7UFkFUk3q47G7Wjy3Sok2p+eUploX2
 ebYeLKqBrkSATTFg=
X-Received: by 2002:a05:600c:2491:b0:3fe:15f0:dfbc with SMTP id
 17-20020a05600c249100b003fe15f0dfbcmr15190897wms.12.1692984805658; 
 Fri, 25 Aug 2023 10:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtgkAMRFcUES/hcADije938auP6TV6F9T1qL4znW+Wuq84McJDpZA8fyAMKuAivCxjQ9bUJQ==
X-Received: by 2002:a05:600c:2491:b0:3fe:15f0:dfbc with SMTP id
 17-20020a05600c249100b003fe15f0dfbcmr15190885wms.12.1692984805330; 
 Fri, 25 Aug 2023 10:33:25 -0700 (PDT)
Received: from [192.168.8.103] (tmo-099-164.customers.d1-online.com.
 [80.187.99.164]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c234a00b003feeb082a9fsm2778283wmq.3.2023.08.25.10.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 10:33:24 -0700 (PDT)
Message-ID: <4c58d125-3d98-af27-2833-95913dc52df9@redhat.com>
Date: Fri, 25 Aug 2023 19:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] tests/migration-test: Add a test for null
 parameter setups
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230825171517.1215317-1-peterx@redhat.com>
 <20230825171517.1215317-3-peterx@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230825171517.1215317-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.57, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 25/08/2023 19.15, Peter Xu wrote:
> Add a test for StrOrNull parameters (tls-*).
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/qtest/migration-test.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 62d3f37021..64efee8b04 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1471,6 +1471,26 @@ static void test_postcopy_preempt_all(void)
>   
>   #endif
>   
> +/*
> + * We have a few parameters that allows null as input, test them to make
> + * sure they won't crash (where some used to).
> + */
> +static void test_null_parameters(void)
> +{
> +    const char *allow_null_params[] = {
> +        "tls-authz", "tls-hostname", "tls-creds"};

I'd place the ending bracket on a new line.

> +    QTestState *vm = qtest_init("");
> +    int i;
> +
> +    for (i = 0; i < sizeof(allow_null_params) / sizeof(const char *); i++) {

Could you use ARRAY_SIZE() instead of calculating it on your own?

> +        qtest_qmp_assert_success(vm, "{ 'execute': 'migrate-set-parameters',"
> +                                 "'arguments': { %s: null } }",
> +                                 allow_null_params[i]);
> +    }
> +
> +    qtest_quit(vm);
> +}
> +
>   static void test_baddest(void)
>   {
>       MigrateStart args = {
> @@ -2827,6 +2847,7 @@ int main(int argc, char **argv)
>           }
>       }
>   
> +    qtest_add_func("/migration/null_parameters", test_null_parameters);
>       qtest_add_func("/migration/bad_dest", test_baddest);
>       qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_plain);
>       qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_xbzrle);

  Thomas


