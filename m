Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB7F7A1AEC
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5LK-0003Mt-5k; Fri, 15 Sep 2023 05:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh5LH-0003D8-Dn
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:42:27 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh5LD-0000zw-Re
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:42:25 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce529fdso2286796a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694770940; x=1695375740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z59JdjTlzcvY5qzMVvAIzK0FZpxGB5G0TuGBATGHgiQ=;
 b=qalTmfj5eWEIro1OcxDKcTWBb4BssPvr97w+IUgcC92HA3QnSPLluLJAFNjihewllF
 LjpqXu2iLTyqbpR6AfKB40jWeZx1k0r/NT1sTRYKOqFgTn6tEHy+QL+LW+iM3UQp95HE
 IUI7NXqojJowWLSxCHXJ/tDBbAiqsoAuQYZia/YN1BBBd/l/vSmDZWzdPm2+ZeDJInH3
 fHX5cSegRh6SNYs+wod+IZzaSRDDmSG94/BVXNl1Qf64Gh8+1FOdToSw/pBRvgvqx7+g
 wCMft4eh1CK7XM3kpl2NE7+wt8e/dGBZDs0Zq8Ip77zFMFKqqYp3DmXfzXEKXY+PylP0
 bNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694770940; x=1695375740;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z59JdjTlzcvY5qzMVvAIzK0FZpxGB5G0TuGBATGHgiQ=;
 b=BhlbGQEbkrySVoRzJMOTKsAIOM8pMrJ7RoeD4msEaRqbLWYd+so7bzjgAA33uprKi/
 N8m0PlNxZ5LwHC29o08DSom9oSnSasInjPYXcy02Y2Wm1TNxXC9Ffnoh8PxTcRb/22DS
 Nv4vPNvzKUM36eu+jWdI5CLwF85okTSof/rfTdPzZB3yEpP7rp2blsMRzrvB42tZtSgj
 cO/9BqBvSXCXNF/MjyiLY6DcRBfo/La4Tcqv1OUz/uSXDBteORR+6YeL7EPLPUcTNFZn
 qX6htR17yu3LCOn20jUw9+JqbjvcO2juCe5azkHj+zYNz9K30kdEuUmO4hyzA9ut6CFr
 SiJw==
X-Gm-Message-State: AOJu0YysZElpqEzdT2m6XN/O7mPrbTHJT++GYEkBUGsiwXMRv6kI5l37
 toiVfTRoQ11luK7wZ52e5nL30wBOD8//l5fyWcY=
X-Google-Smtp-Source: AGHT+IG7vNmHRsmMvrP4gXo9bU0mICSZd+iLIQQeqXWpp0rD14YvhtHopII78M2fdCOLYXnkPrfx1w==
X-Received: by 2002:aa7:cd57:0:b0:522:20a0:7eb8 with SMTP id
 v23-20020aa7cd57000000b0052220a07eb8mr1003587edw.33.1694770940596; 
 Fri, 15 Sep 2023 02:42:20 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 q18-20020aa7da92000000b0052cdc596652sm2015427eds.23.2023.09.15.02.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 02:42:20 -0700 (PDT)
Message-ID: <11460e6d-9fda-3e41-a792-288cd15f0caa@linaro.org>
Date: Fri, 15 Sep 2023 11:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/6: 1/2] accel/tcg: Refactor gen_io_start() as
 set_can_do_io()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230914174436.1597356-4-richard.henderson@linaro.org>
 <20230915094109.82757-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915094109.82757-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 15/9/23 11:41, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20230914174436.1597356-4-richard.henderson@linaro.org>
> [PMD: Split patch in 2, extracting set_can_do_io() first]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/translator.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


