Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C5722FD6
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 21:32:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Fup-0007dB-J4; Mon, 05 Jun 2023 15:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Fum-0007ck-NT
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:30:52 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Fuk-0004uF-FV
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:30:52 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-655fce0f354so1276043b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 12:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685993449; x=1688585449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9MnhiBF7aAanVV6mGfK9uoXanxnyXOYa9JVTYilCb+A=;
 b=YOiAWICYRXJZKujPYR+lOqKoCaJhBKVjdbV8Uez579bCIEtyC5Wv6OxJyckDTyZZml
 ZR/BBpE23M6RcIZnf7myw1i4tKYLnAOq4taMK+iGZc/mYZy9W4LBA15AkIoez4cKUn2u
 i+OU5cuNfWQ8UzpxV3LHe16ErZoG9Sa0KOoDmtm980UHqYXxzavkoq517I58YV/SPTRE
 ru9tajgY30Y/dVwdr46eSb5wpNP0i/2Q1VtsE5nedACe1Tygshr76EPTn734X55MGXYX
 zd9pX+kql8ejW2yy5z+UYwKyHSsXfBIO+E4fp/1drUbMG78U1k9tJUh0aIeBr1XJsy1H
 sTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685993449; x=1688585449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9MnhiBF7aAanVV6mGfK9uoXanxnyXOYa9JVTYilCb+A=;
 b=Xmx4BhMxLnVYP1pEr9FiT6B9Vp0HfZxaAjN0DZCrhvVydriZXXpXphl5wGQoee7IMT
 cFqdF6MzW/yVAMXfZEzUao02f7r61MQW5GTSi2Wz/vA2L4V7uReyGZXr0EgnzOSBKzJq
 Ho68eG7ddfGQEKcl9S2WJq9BmA7LwFhtbzZBeUp1N4CQ1CMerILmme/zNtprAC9Nr/WK
 Zg/hKifwsy//ZDaJSIsh+F/HBiKlRVc4SdI8+Hj/rHMR8D2gAMpElJfSSli0lWhe+SeY
 +Gf5DGJrQvFiUPpJtEtNJb013C+iWBPVTw1/fhWxJFAcdjU+aBo6xidJxpkm9hxzbSM1
 9bAg==
X-Gm-Message-State: AC+VfDynqWZP1twtOY8bXPCEYNWpGK2Jc/ozxezs1Srra1MU6JldM0S5
 RzM8y9EU02oxZ2CLsDEEOqxfQA==
X-Google-Smtp-Source: ACHHUZ5pmx82MUTqQc6V6mW0VDRFiHBdK60dfTE4MmCXCTC5G7Wa8iC1gDUeFt6hFzKl9y82hAr/gg==
X-Received: by 2002:a05:6a21:78a4:b0:10f:3fa0:fd8e with SMTP id
 bf36-20020a056a2178a400b0010f3fa0fd8emr26013pzc.27.1685993448703; 
 Mon, 05 Jun 2023 12:30:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a170902d4d100b001b077301b15sm6951529plg.156.2023.06.05.12.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 12:30:48 -0700 (PDT)
Message-ID: <7b03c13b-5a6a-f415-4628-b9254c8cfb74@linaro.org>
Date: Mon, 5 Jun 2023 12:30:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/5] bulk: Replace __attribute__((noreturn)) ->
 G_NORETURN
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>
References: <20230605175647.88395-1-philmd@linaro.org>
 <20230605175647.88395-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605175647.88395-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 6/5/23 10:56, Philippe Mathieu-Daudé wrote:
> -static __attribute__((noreturn)) void exit_failure(void)
> +static G_NORETURN void exit_failure(void)

I think attr-spec-seq ('[[noreturn]]') has to come before specifiers-and-qualifiers (i.e. 
'static').

To me this means that G_NORETURN being redefined from __attribute__((noreturn)) to 
[[noreturn]] was a glib bug, since it has a different syntax.

Therefore we should simply avoid G_NORETURN entirely.  At some point we should be able to 
update -to --std=c23, at which point we use [[noreturn]] directly and not G_NORETURN anyway.


r~

