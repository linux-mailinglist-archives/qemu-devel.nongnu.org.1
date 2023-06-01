Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7271971A
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:37:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ek7-0002Be-QG; Thu, 01 Jun 2023 05:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ek5-0002BJ-Ce
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ek3-00011l-UO
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685612231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krAet3y50rxWHU+pohUVUqRDmlYulalK1p3xESwxbDc=;
 b=jGAwGineK8MOOZeiF92+fsTncG2qDvHn5XbToJYfysGE4KbkthJyH7BlwVevkw0YMWrsoY
 bGee0vrqnJe5uuPx9nY+Hrd6yH1WmWM0gVUhgAL7MUv4/l5CX+kJWN8yBnyOUsflftGgW7
 JEsWvV2AHTp8be+AEnNSNskZITywe7Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-BkkcsaRTNhOQ1zU3s7D5gA-1; Thu, 01 Jun 2023 05:37:10 -0400
X-MC-Unique: BkkcsaRTNhOQ1zU3s7D5gA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af17f626e3so5608881fa.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612228; x=1688204228;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=krAet3y50rxWHU+pohUVUqRDmlYulalK1p3xESwxbDc=;
 b=V0H5bhoEWtG+e6qWTThZPSXKW+PE0QLJNqXye3XSM1jEBJhujCtTrwXg/06F7Lju+t
 IuFSiJ11sOUK0ZjJazW7Xxad7gTl6uNnCqyqf43EeWYgGHv594CpdgDRXNzGSp+42m+Y
 XduJa8io1soQ28R2VCpKTWq9LMxGwjzI0xOKZwiIbaRmAbkypgzjv7byCAKeExk4KrZX
 cd9ecxPbj/otY55GKV83LXlZgKRFkf/0IvX8cGPEDDk8vJCpHYcjqYjk4Eo3+ta4Q1W4
 jRyrGvgQbqzw+uw5pOS9DyHuMeRWDl3mQHrA3xKIDYmuDgne7aL8+0RYYkwNVTTG8fej
 2z8Q==
X-Gm-Message-State: AC+VfDzRVp2lS738tn6F9ECCcEalcqC+FdaLosvMGNu1lvyXihwl5HGp
 eEy5HURJjVcVKPo5LInW/4AIPqYN9nbPE9JX7NCj9qoTROI0HVensMGOBjB/Y2kBN1pOuaRIiI2
 2F9zUDYnGP9HMmJc=
X-Received: by 2002:a2e:9d53:0:b0:2b0:297c:cbdf with SMTP id
 y19-20020a2e9d53000000b002b0297ccbdfmr4400384ljj.1.1685612228680; 
 Thu, 01 Jun 2023 02:37:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EM/4drF2pHAVyke7ngQIdE1B0MVeHUv7Uhez+vpoBm2eD9drJK8UFH/hWyBOjOKo21CbN+A==
X-Received: by 2002:a2e:9d53:0:b0:2b0:297c:cbdf with SMTP id
 y19-20020a2e9d53000000b002b0297ccbdfmr4400371ljj.1.1685612228402; 
 Thu, 01 Jun 2023 02:37:08 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-86.web.vodafone.de.
 [109.43.178.86]) by smtp.gmail.com with ESMTPSA id
 f1-20020a1c6a01000000b003f427cba193sm1687940wmc.41.2023.06.01.02.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 02:37:07 -0700 (PDT)
Message-ID: <f59c1822-0364-072e-1da9-70ece7c1f039@redhat.com>
Date: Thu, 1 Jun 2023 11:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 6/9] tests/qtest: replace wait_command() with
 qtest_qmp_assert_success
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-7-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531132400.1129576-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/05/2023 15.23, Daniel P. Berrangé wrote:
> Most usage of wait_command() is followed by qobject_unref(), which
> is just a verbose re-implementation of qtest_qmp_assert_success().
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/migration-helpers.c |  53 +---------
>   tests/qtest/migration-helpers.h |   8 --
>   tests/qtest/migration-test.c    | 170 +++++++++++++-------------------
>   3 files changed, 74 insertions(+), 157 deletions(-)
...
> @@ -1759,7 +1741,6 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
>   static void *test_migrate_fd_start_hook(QTestState *from,
>                                           QTestState *to)
>   {
> -    QDict *rsp;
>       int ret;
>       int pair[2];
>   
> @@ -1768,22 +1749,19 @@ static void *test_migrate_fd_start_hook(QTestState *from,
>       g_assert_cmpint(ret, ==, 0);
>   
>       /* Send the 1st socket to the target */
> -    rsp = wait_command_fd(to, pair[0],
> -                          "{ 'execute': 'getfd',"
> -                          "  'arguments': { 'fdname': 'fd-mig' }}");
> -    qobject_unref(rsp);
> +    qtest_qmp_fds_assert_success(to, &(pair[0]), 1,

Matter of taste, but I think I'd prefer &pair[0] without the parentheses.

> +                                 "{ 'execute': 'getfd',"
> +                                 "  'arguments': { 'fdname': 'fd-mig' }}");
>       close(pair[0]);
>   
>       /* Start incoming migration from the 1st socket */
> -    rsp = wait_command(to, "{ 'execute': 'migrate-incoming',"
> -                           "  'arguments': { 'uri': 'fd:fd-mig' }}");
> -    qobject_unref(rsp);
> +    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
> +                             "  'arguments': { 'uri': 'fd:fd-mig' }}");
>   
>       /* Send the 2nd socket to the target */
> -    rsp = wait_command_fd(from, pair[1],
> -                          "{ 'execute': 'getfd',"
> -                          "  'arguments': { 'fdname': 'fd-mig' }}");
> -    qobject_unref(rsp);
> +    qtest_qmp_fds_assert_success(from, &(pair[1]), 1,

&pair[1] ?

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>



