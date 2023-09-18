Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 705E37A418B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 08:50:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi84p-0006xw-UY; Mon, 18 Sep 2023 02:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qi84n-0006xQ-QP
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 02:49:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qi84m-0002VX-9n
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 02:49:45 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-402c46c49f4so44627665e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695019781; x=1695624581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CJgSOmofLxjX8BFHONSfc7CubjsC4NOczEty68/sMJE=;
 b=HvLPHFlagCtE6EgyZQbjcJGgpLWpBYFr75SWGBBUsHjH7YN4ixpbwsN6ovuJqGwgfW
 G6K13UeDlCLC6beQfmCX4cfjNLIs9MaoT4FEoROoKVCO3UisxmKB2N/ZmfYxPtcxGO7k
 9zjTXFyNpyNfV+zIAWw9hF5nYCTy4jNPI7auhYYdvHcpDBWtVrHf8+L/QjJuJ5rNdk3b
 GPw8DLaCBW12VGV973mptQjotrPBNjSfu7ztmnAHK9k/BGCkjj1jIkrh9z4m9uZ+KiQV
 i4qZd5kmtlKmgP/AUVwGm3k/4KGDuvwe8AWMf02tINp0Se+87BqTu9hnKoNeABkZkc4j
 x6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695019781; x=1695624581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CJgSOmofLxjX8BFHONSfc7CubjsC4NOczEty68/sMJE=;
 b=KKp9hCH/J75ctj5llFA2VWV9M1Lox8q1bzRACEDpK0VchLIAmM0OPgQ1dF0oQqtLM2
 mKFFUQSPgcaGhWf9p/mZOvSUypx+eIdynYegq3lHB2ff0KZ8U5tzAHS9T/Z/FfSCPV7O
 trezzpoi04mvV1N+lLMWA4v2tfUnzDvewh6V25Nf0GhigfxDUjdNSdChoDpw8XBedzKa
 TR58j4vux4yhquz3U77ScuPLy6qByCnJuiBUd8ZNTHoHQVzM9YwrTk6rO2t1d1VvNkFf
 L5niNblMGKs+FyPRcSo7c9oaVtWQcigRkPY53Bt8Xsg8ne1N/Q38qNTfHeSU3xgEZ80u
 efSg==
X-Gm-Message-State: AOJu0YwiHh796Bhy53+wo5tzOInkblkqBSzcEEgfQYvE6tOC9PnIWy8e
 Q8sh2HhYrVhNky3o0qhyswDnn7hK5E1/EuPa53kTuA==
X-Google-Smtp-Source: AGHT+IEPGYvIUF58mKTUp2srej8xHHNkrPhiCsNyM9wolVlDOLf/U6Z1XnGJJOdQdYgrIBgk5HNISw==
X-Received: by 2002:a05:600c:21c1:b0:400:57d1:491b with SMTP id
 x1-20020a05600c21c100b0040057d1491bmr7280303wmj.2.1695019781613; 
 Sun, 17 Sep 2023 23:49:41 -0700 (PDT)
Received: from [192.168.179.175] (50.red-88-29-174.dynamicip.rima-tde.net.
 [88.29.174.50]) by smtp.gmail.com with ESMTPSA id
 p20-20020a7bcc94000000b003feea62440bsm11448735wma.43.2023.09.17.23.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Sep 2023 23:49:41 -0700 (PDT)
Message-ID: <00de8b9b-abe4-debb-0f58-165eec723cf9@linaro.org>
Date: Mon, 18 Sep 2023 08:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] tests/qtest/netdev-socket: Do not test multicast on Darwin
To: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20230918062549.2363-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230918062549.2363-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

I just noticed Jason wasn't Cc'ed. Assuming this test belongs
to "Network device backends", Cc'ing him. (Should we add the
test entry in MAINTAINERS?)

On 18/9/23 08:25, Philippe Mathieu-Daudé wrote:
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


