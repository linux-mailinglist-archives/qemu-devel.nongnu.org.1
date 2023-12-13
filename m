Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C92B7810B7D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 08:29:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDJfh-0006yq-15; Wed, 13 Dec 2023 02:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDJfc-0006yU-FA
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 02:28:40 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDJfZ-0004KB-BD
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 02:28:40 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33338c47134so6014729f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 23:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702452514; x=1703057314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BbgjLAdC3knfth7krAw9mNtV5wog9mfEj+mzI0rGinM=;
 b=E/WIMYycZs4f4AIqIycX2mJjSsYLzMQ3TkRI8mGjOKeG0o7iDwnwEddBKq1G433mCo
 O/EbtsvMM4ooFklwCIioVXtshbmEVH75HCD6/INDi6i/OegrOq5KsHNyl/xeBBAmrxrK
 Tcvep0SIjLSScA81rShOYTwRRsix6z57Mu6rwNDVNQF0Z3nUhkBtJ7EhGfY2iS37NcfC
 FA7qMlnrEs7hPXQU+KVxw7BUbeMU/3Gs+ncLe9tYtAZuEPoauzfmwFopgS5aczT5OZ/K
 Hg/jCrrPqY6rh7bMwEaNTCFmmz+RjIDJNmqYuUkM7DrmJDc7HqvjtTi5nFfOto0ErWu2
 O/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702452514; x=1703057314;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BbgjLAdC3knfth7krAw9mNtV5wog9mfEj+mzI0rGinM=;
 b=w0rlb47UzBxRsQVdKMjhnWmHpw+W61diwl0CqGQlbPlnZyxejg7Ey7f2nlUbUEfsTn
 EyaYEawrSvuIjV+9uXO2+I1h5EcK56VG4whls0D63loVkur61H9JicjBwzWXnsausAm6
 kVrHGKmvoY1KkiiE0D65wF03u/i/sXNTncFZLr65fU0vw3jmFG8kTJP+rhBbCBV3JXNj
 jJ+C7xCxjrHJFBpvOkF5hEc5YI4X9kiIUEYJJq1RNtUMe1d82D/NplH0SDHFgR/G+dao
 bbI+gLCZIKMYDZwa/NZFwfO0Vasl2njwhWuklC3wFR+j2PPrR6rssC20uRF8CPC7Su+N
 iK0Q==
X-Gm-Message-State: AOJu0Ywrg4kcDFt2LRooXCWYvvpOt32EuRfOUtyezuGqrVGyWwK9n1HO
 5JX6gi183XuqXqv/n28C+ck4SA==
X-Google-Smtp-Source: AGHT+IHZC5gZnc3FWJ01FoolW9TZnJ24DYV/CMdUn1yHqwvUwsj4dwkbVEEtv1BgKKTrKoVZp3jAhg==
X-Received: by 2002:a5d:48cf:0:b0:333:3d84:cb30 with SMTP id
 p15-20020a5d48cf000000b003333d84cb30mr3289334wrs.16.1702452513892; 
 Tue, 12 Dec 2023 23:28:33 -0800 (PST)
Received: from [192.168.122.175] (4.red-88-28-2.dynamicip.rima-tde.net.
 [88.28.2.4]) by smtp.gmail.com with ESMTPSA id
 h3-20020a056000000300b003362ee04e96sm3033913wrx.75.2023.12.12.23.28.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 23:28:33 -0800 (PST)
Message-ID: <791bac16-523c-41da-a45a-abddec6174ba@linaro.org>
Date: Wed, 13 Dec 2023 07:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Reduce serial context atomicity earlier
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20231212193542.149117-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231212193542.149117-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/12/23 20:35, Richard Henderson wrote:
> Reduce atomicity while emitting opcodes, instead of later
> during code generation.  This ensures that any helper called
> also sees the reduced atomicity requirement.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2034
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-ldst.c | 28 ++++++++++++++++++++++++----
>   tcg/tcg.c         |  9 +--------
>   2 files changed, 25 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


