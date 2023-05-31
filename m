Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AB3718ACE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:09:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4S6e-0004Cb-Ak; Wed, 31 May 2023 16:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4S6c-0004CR-9t
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:07:38 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4S6V-0006So-Pv
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:07:38 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d2f99c8c3so141737b3a.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685563639; x=1688155639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/DgX9YiTgyuO6jdpMfZpM24ixxM2YVVFma/h+UsXLms=;
 b=s9/A4ZJUXunxU51Hv8Ruf1UV0pfQZhhtvF5dFcEyQEyJvPrdmtRYXV6xKbT6yelbqp
 PXFdymMRlePLSwibT3K6W4jLEq00k8ZQoGJnuUGaVwBID9WEcyTSazNlsBujb/lFAkCP
 Oel7M3DAFCfm+DVrGOQPyaPnzOIBH4HjyWEVh5+4Nj5z1WOvftna7/9J8et15Gr0GpDe
 ik30uDS56dvSHxkuoW+U/AH6U0llOTmRX1R/lZHT0Qq/3eE2sZB+fEx/AMmfbU08w3+M
 vQJnTsPhUV46YS99Q2YGtOPOWL6f99WHHUTtdrkqkN27x4m9yzkLM5EE8ellDzHJ8wUU
 MUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685563639; x=1688155639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/DgX9YiTgyuO6jdpMfZpM24ixxM2YVVFma/h+UsXLms=;
 b=DHJU3dQp96E+3E+FvH9MUd+TB31AuV8bDblykpKQ6z7Tjrf2MJr0dJe+EvYgt/YBHt
 npNYiVuMymY0sBUiWAl3DrhpkVlqEfQb9FmSeqPOs7f8R7aVAepMkqZRfmmQMqBxALZG
 QNcYaMU6QRzGk2NXXpJ66luLDR6SwSQ2R6Yb2XgN4xii3kmgzB2GDxEzh4f3mdRaNByP
 f8BPdj6J0FO8WqaXhhT1i9SHGJXQn9XTKzGpR3IB1wKWrXcFhZrgqCWmXsYaPx08kBP6
 cDk+zpxB4ZCB6Y3hCu0X+Ej7BClDtn+oW/jEovW/hM2IXil7RP9m/VPF+SZvhjp+mSB3
 Fasw==
X-Gm-Message-State: AC+VfDw2uE3WcEzYvq3G8Y8bNIsduFl68CregZvE4Rd8Jv5WkwH6AIkE
 CDaupdpiKktnmUi5XOHu7YD5/w==
X-Google-Smtp-Source: ACHHUZ7qlXEwS+OBEEAb9KHtfXCfwp3yM99FQiYUgHvqeEHHtjyCjay+55gCHHgeRY0CNYLhdwpcEg==
X-Received: by 2002:a05:6a00:1903:b0:646:b165:1b29 with SMTP id
 y3-20020a056a00190300b00646b1651b29mr6196546pfi.23.1685563637760; 
 Wed, 31 May 2023 13:07:17 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 g19-20020aa78753000000b0063f2a5a59d1sm3633605pfo.190.2023.05.31.13.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 13:07:17 -0700 (PDT)
Message-ID: <4388a719-8206-ef1f-170b-da3734fd6741@linaro.org>
Date: Wed, 31 May 2023 13:07:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gitlab: switch from 'stable' to 'latest' docker container
 tags
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Camilla Conte <cconte@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230531140654.1141145-1-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531140654.1141145-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/31/23 07:06, Daniel P. Berrangé wrote:
> The 'stable' and 'stable-dind' tags are not documented as supported
> tags at:
> 
>    https://hub.docker.com/_/docker
> 
> Looking at their content they reflect docker 19.x.x release series,
> were last built in Dec 2020, and have 3 critical and 20 high rated
> CVEs unfixed. This obsolete status is attested by this commit:
> 
>    https://github.com/docker-library/docker/commit/606c63960a4845af7077721eb3900c706f5d0c5e
> 
> The 'stable-dind' tag in particular appears buggy as it is unable to
> resolve DNS for Fedora repos:
> 
>    - Curl error (6): Couldn't resolve host name for https://mirrors.fedoraproject.org/metalink?repo=fedora-37&arch=x86_64&countme=1 [getaddrinfo() thread failed to start]
> 
> We used the 'stable' tag previously at the recommendation of GitLab
> docs, but those docs are wrong and pending a fix:
> 
>    https://gitlab.com/gitlab-org/gitlab/-/issues/409430
> 
> Fixes: 5f63a67adb58478974b91f5e5c2b1222b5c7f2cc
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Excellent.  Applied to master directly, and it fixed all of our container issues.
We're now only a few regressions shy of green!

https://gitlab.com/qemu-project/qemu/-/pipelines/885058571

r~


