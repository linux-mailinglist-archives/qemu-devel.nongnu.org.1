Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D3178D0A8
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:36:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb8Fd-0003yY-L5; Tue, 29 Aug 2023 19:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb8Fb-0003ue-1j
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:35:59 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb8FY-0004Hp-QS
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:35:58 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68c0d4cc3a4so3027653b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693352155; x=1693956955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MxYAw4azpOCEBZCehUDmRwtjcAepbgNx8cIgdOgpkBc=;
 b=NwpiGm7pu0Sy6UlfWUrCnvDPnrPVZlNZuYGntlwnrTvruBBK+47vRwBnKlyAVyMbOQ
 UFAawkhhwKO35schbl8bt9FSepP6K5b1l2Ymx/9Jtrz9t+JzeaPZpaTx1awoHhjpu3v0
 oBdmvb+cGTlzuAb8IF1VwN/HrjHtzgnMuAk4z/AFmNQLd/8JaB3r5Uji/sPjE5ZzH0tq
 YMtdgn/lQ7ibaUFenv5wME1ten0XjW8Mao+EkC3+n3qgwSnJuNEqZSpYmU8SgtYAdb3v
 1bDwqLGoooz5V+J71lIfr9mZHKSluypZ4yf2N3kK+B0rfIIVstzfzDneNzn9TBQW2u28
 WQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693352155; x=1693956955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MxYAw4azpOCEBZCehUDmRwtjcAepbgNx8cIgdOgpkBc=;
 b=eI2r6iGUaYLseUBTYDVu3UwdmuFCr7a3tmUrn0k1fhORk9tC0xGikGJd7xt0w7lSaZ
 p5MrgSWXiKxbWbEzNkz7yJYy22NdjjsYFC+QHOd5T9bLBIbFqDWaMM2JUAREaTG04d8H
 n/6T64Vb5VdMglUZang1hErsbR5pc1QO6rWt6hJOr/DBcic6oHVWYKyQskf9Y8DHau+0
 KU/bjcLvZObCKITuiyWh2RUgFlc8Mgssl9NTBcoTry6x/+YHz3+6AqpWHxpeSiPXKaEj
 BMdaPwDltCgwvQLSHSIjA1IfK3X5ZHgEXNW3Rh5GccM7As+C69vCssHYFjtOTB+6hL5e
 cc0w==
X-Gm-Message-State: AOJu0YxBotU09zg8b0yZe3k4RNNVmVjCBMLMAIaTAxR86BMd/zkXAmwU
 Pnq7m7r5nKzqjIsEqySFl38QGg==
X-Google-Smtp-Source: AGHT+IHo/qKohGVgt2XY6iQZrDOy/s7WVIez9/tP6/gJc5WGOpBQ5ogRQxJFLdnUJvOvvp3aJg2vYw==
X-Received: by 2002:a05:6a00:10c8:b0:68a:2e50:d7f1 with SMTP id
 d8-20020a056a0010c800b0068a2e50d7f1mr716865pfu.4.1693352155435; 
 Tue, 29 Aug 2023 16:35:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y17-20020aa78051000000b00688c733fe92sm8913335pfm.215.2023.08.29.16.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 16:35:55 -0700 (PDT)
Message-ID: <67903f3f-89b0-06c5-2b50-911682554c75@linaro.org>
Date: Tue, 29 Aug 2023 16:35:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to
 compiler.h
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20230829184743.54557-1-imp@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829184743.54557-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 11:47, Warner Losh wrote:
> Replace the slightly older version of this in include/qemu/compiler.h
> that was commit as part of bsd-user changes with the newer one from
> linux-user. bsd-user has no regreassions with this.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index bbd55b4d18c..9bff3b763b5 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634
> +Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb

Be careful about these.


r~

