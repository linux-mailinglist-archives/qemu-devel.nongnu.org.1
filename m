Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF97B7B8542
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:29:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4k1-00079N-Jd; Wed, 04 Oct 2023 12:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qo4jx-00072y-Cw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:28:49 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qo4ju-0000LS-GK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:28:49 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c87e55a6baso3624685ad.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696436924; x=1697041724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j/VVs5GHkxv6vQaFWwof3xzzhsTjzsfLrO8UcA2AF/c=;
 b=ywxB78IldEr8DHwj5fmrpxFFlIMKF46DETputdLK4lMgx9LSFYKAVPjvQr2C2dGMzk
 dQjQu2b7pKyJjCKP+qfZpPoMraTJDkv+7ecJkxy6qOe23e977xehcoIldYdNA0MyT0qI
 jwI+F5RzuqDCkCC2gXfyxbUEGnrvpbq5B0La1zBvK4YT19i5cNGd3TuP1g3XQRkz0x6x
 mga9WAmqEVyOQBcDkmkN1wGW2W/hTcDtS64Oi6wkARoZyh3zuVbla/lU7K/qhXoJoiyF
 RpCbhvesSUVm2RdBBoJKFap50F9rflDIzIfn9gdu34n+O/7oowfw+uOBRUtpRt8bdyvz
 At/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436924; x=1697041724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j/VVs5GHkxv6vQaFWwof3xzzhsTjzsfLrO8UcA2AF/c=;
 b=XBqgykoqsAoIpzj8ow76nt59oqAJqG4awRY6LnyLMs9ewfGb6596B9TdOpjkF4zSGU
 QZbjskqLMlemuWT0wCKyHfwFrM30GKqojs/UgTjBcEfkFpjcT2ZJStwRA3iq2xz2Yadf
 afkl+949BduMliEC93SBfMQY0hVmjeCOq/QjCOKw+7UpRtJyIwDaBGw9qJC3MAa6px71
 BCn65KvM3QWtmukoz+z+op2mF87XL3eJ/ggkmiFX0NYNNdtFFvGDc+gGhtemuGNMDPJ4
 dsHuEw8vj+IxqI64IVaq1gQ93yRjbC3L8+XR/DzxfL3hDTEkSrFkbKits6wCVKOPRY4o
 bbDQ==
X-Gm-Message-State: AOJu0YzMBB/RERu6ZmmErVcULXy3OhBNIfUm9kEynLox/y9lntiT3otb
 JeAGA3hEQm3gostUbdzUNbVNgA==
X-Google-Smtp-Source: AGHT+IGOm9t3mk2Mw9bICTvBITl5wQyF2s9HjwMWhHHVOhKDd88Ct9aXhDFnJSY8FTOFLfzTHk07CQ==
X-Received: by 2002:a17:902:e847:b0:1c3:dad8:bb99 with SMTP id
 t7-20020a170902e84700b001c3dad8bb99mr2783262plg.64.1696436924146; 
 Wed, 04 Oct 2023 09:28:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 a20-20020a170903101400b001c60a548331sm3931161plb.304.2023.10.04.09.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 09:28:43 -0700 (PDT)
Message-ID: <72fabe24-0b50-92d1-6269-7722d6708ebb@linaro.org>
Date: Wed, 4 Oct 2023 09:28:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 00/47] tcg patch queue
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
 <CAJSP0QXw80o=S-f3ey1ujF7nY0JwYQ-BPrmxm6nRJPt2wrjxOg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAJSP0QXw80o=S-f3ey1ujF7nY0JwYQ-BPrmxm6nRJPt2wrjxOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 10/4/23 07:57, Stefan Hajnoczi wrote:
> This commit breaks the build:
> 
> ../bsd-user/signal.c:479:19: error: unused variable 'env'
> [-Werror,-Wunused-variable]
> CPUArchState *env = cpu_env(cpu);
> ^
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/5222693462
> 
> Please resend the pull request with a fix.

The line number quoted above does not correspond to my source.
Did you attempt to merge multiple pulls simultaneously?
There must be a conflict between them.

My guess is Warner's bsd-user PR.
Please just apply that first and I'll re-roll mine afterward.


r~


