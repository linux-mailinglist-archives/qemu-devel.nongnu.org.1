Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC1A7A4153
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 08:36:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi7rd-0002in-3e; Mon, 18 Sep 2023 02:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qi7rQ-0002iR-MF
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 02:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qi7rN-00006O-LU
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 02:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695018951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+MtskstYXb4tF72ZjFj0eLthuf85i0P9UyTad9rO20=;
 b=J3jFablJQirU+fIg2XQWalhtLG1OSMNaR6/3oc1DV7N/ifXsI0j0nOQDBcUkcDLTXZbhMi
 EkZ7D/qMLqjiPL7GaSNTwD/H7/T825QJ+YDfsj8HoGubr2aDL+FsmgeW0G/Z9bLRAS6dr5
 vBKb7AFVepkjpjQV5qrT+jazo68+0bg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-ZEHO8UF2Mt-j0nFvFaDSMQ-1; Mon, 18 Sep 2023 02:35:46 -0400
X-MC-Unique: ZEHO8UF2Mt-j0nFvFaDSMQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-315af0252c2so2869483f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 23:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695018945; x=1695623745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+MtskstYXb4tF72ZjFj0eLthuf85i0P9UyTad9rO20=;
 b=Nc7JOs93DQIFLHaAHK0sntC91Nm132sPFlHO5JoS91qrWyMon8L4EcX9cKmRmQSCGd
 ReC+BSZCwdX1FZc3aEb7M65X6zjs1vWymf+qA4MUoU/FRvJoPixVh29DC4fGSAi+YLr/
 FWol1CwUvEC4z6ew7PwaurUajFHf2lP0OJ2eUdn8kRUsoHbyH9gAL63o2Q9wvEN+Hhht
 Zjp5+aCwYBJpki2+OyWQgIY4eHqmhpBn187f2OArbp9JF54aBbYrfcARpniyUh/ht6aC
 zCtDu7Me6qWMaO1u6t/lW73KdWrVZgV3WG48H14zt6J8XORPtPi/3L/fw1vngpwCPO3b
 gnZA==
X-Gm-Message-State: AOJu0YwDP53kIfsvGP8uwn2yfvbg2Sn7wK6CFBCDukXDfnzXhSOiT+V7
 bC7Ybn7UdFaJsYTTIUWVQ/iFgo4jZBmJDGCsEfmmgRzRfOVjFlCysVdpFwsCmanf6ZM5W8QcRAD
 COmJDqPxnlAiKcAI=
X-Received: by 2002:a5d:66c3:0:b0:317:c2a9:9b0c with SMTP id
 k3-20020a5d66c3000000b00317c2a99b0cmr6819407wrw.50.1695018945427; 
 Sun, 17 Sep 2023 23:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL9FiT9CI2/oZWtV6IBbnZh9qagWQw6Lyh4E1mngxU+uksWpA4HvKN4hDJrdfcJiXk2vH7Tg==
X-Received: by 2002:a5d:66c3:0:b0:317:c2a9:9b0c with SMTP id
 k3-20020a5d66c3000000b00317c2a99b0cmr6819399wrw.50.1695018945136; 
 Sun, 17 Sep 2023 23:35:45 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a5d42c8000000b00317a04131c5sm4678688wrr.57.2023.09.17.23.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Sep 2023 23:35:44 -0700 (PDT)
Message-ID: <4e43c72f-823f-7267-baa8-9a2fac4ed47e@redhat.com>
Date: Mon, 18 Sep 2023 08:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tests/qtest/netdev-socket: Do not test multicast on Darwin
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230918062549.2363-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230918062549.2363-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 18/09/2023 08.25, Philippe Mathieu-Daudé wrote:
> Do not run this test on Darwin, otherwise we get:
> 
>    qemu-system-arm: -netdev dgram,id=st0,remote.type=inet,remote.host=230.0.0.1,remote.port=1234: can't add socket to multicast group 230.0.0.1: Can't assign requested address
>    Broken pipe
>    ../../tests/qtest/libqtest.c:191: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>    Abort trap: 6
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/netdev-socket.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
> index 8eed54801f..3fc2ac26d0 100644
> --- a/tests/qtest/netdev-socket.c
> +++ b/tests/qtest/netdev-socket.c
> @@ -401,7 +401,7 @@ static void test_dgram_inet(void)
>       qtest_quit(qts0);
>   }
>   
> -#ifndef _WIN32
> +#if !defined(_WIN32) && !defined(CONFIG_DARWIN)
>   static void test_dgram_mcast(void)
>   {
>       QTestState *qts;
> @@ -414,7 +414,9 @@ static void test_dgram_mcast(void)
>   
>       qtest_quit(qts);
>   }
> +#endif
>   
> +#ifndef _WIN32
>   static void test_dgram_unix(void)
>   {
>       QTestState *qts0, *qts1;
> @@ -511,7 +513,7 @@ int main(int argc, char **argv)
>       if (has_ipv4) {
>           qtest_add_func("/netdev/stream/inet/ipv4", test_stream_inet_ipv4);
>           qtest_add_func("/netdev/dgram/inet", test_dgram_inet);
> -#ifndef _WIN32
> +#if !defined(_WIN32) && !defined(CONFIG_DARWIN)
>           qtest_add_func("/netdev/dgram/mcast", test_dgram_mcast);
>   #endif
>       }

Reviewed-by: Thomas Huth <thuth@redhat.com>

I'll queue this for my next pull request.


