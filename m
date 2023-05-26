Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCDA712A25
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zro-0006hN-F9; Fri, 26 May 2023 12:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ZrE-0006g9-VU
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:00:00 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ZrD-0000pr-AE
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:00:00 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-25627779002so840152a91.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685116797; x=1687708797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cFq3R22iNXHqh2URWTtlvINT/P88rccI9+OJLHJhb0w=;
 b=eLwS+TiitBCWTV3OSTPKQHebP/7nLcOHwNkTE+Ii2hAs9MDZqyPJ8nEEvbB5KnC3Kt
 g1QQS9ogA4m3ohg58iZ+BhDBsYkOHlpKYQwyRE+3SPR+/vmHAXP5VCtGbZjFTYgifyBL
 9UwHQ5PdMaJaXWJPnvOF63nmZ/lxacWL+RKQwpNqdCdhLZng3Lx7A1qEd3HxgWgd1UkU
 sw7uZRAchAYwmI1oQZ+/Qc2qjM3B9AuiwZSwwkqZSbIweoQUfricEWQHCULHiM/S6ujT
 bBgSddwBKxfCsBZybOjA9SBiwhHANghPazwFt3o1iM4QwpHpdSfsSbm3/losG5Lgc4kd
 TsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685116797; x=1687708797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cFq3R22iNXHqh2URWTtlvINT/P88rccI9+OJLHJhb0w=;
 b=VNAif4qVvKf4tflttL/HXhRdDJLQTaUo8JqLfp7+01bP4GUaE4TwbrAeN2UAfZAa/5
 xKgFZ+jcw23CWgWRvSlPq0KwzCVNlAcXfAJO0L5z4UD+2ZAVib0jzazfxM6zQSEJH+hY
 Zp1Vjvad5r13sK4MCenjzwW3H5Xv2KHw+OzC9YTaj0lm5/9nzGuJVqWiGeJYi+Kz8OVf
 teISl5WSwHlRaf0jTqP59RcrSagqoX1++7/5VPvrQZlIDmcncwecQlwY7DmzW0yeB5eX
 Iw6IdhvaaFre3yVmfIAcWBkTlvYc64Q3P+zVpKtduaoRMBnbezuwokw0Ar97i3EH3xRc
 prOg==
X-Gm-Message-State: AC+VfDxALaMox9gS7yfyChZxu5hO/EwX/gehaGrobJBhalW9BFV8v2Iw
 IvgmFq05QxAdQfEcEaxpLvSSMA==
X-Google-Smtp-Source: ACHHUZ6X/89Nfplsrs2FtcKfPji67WNCuVJAhi/5lVwH7FjtvIW7djTmWHYKXEn+8qvRYp18G8p0Jg==
X-Received: by 2002:a17:90a:be09:b0:255:6174:1588 with SMTP id
 a9-20020a17090abe0900b0025561741588mr2712548pjs.42.1685116797645; 
 Fri, 26 May 2023 08:59:57 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 8-20020a17090a018800b00256395cb599sm852079pjc.38.2023.05.26.08.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 08:59:57 -0700 (PDT)
Message-ID: <b39df9b7-c8f1-cda7-5a45-f218de6446b1@linaro.org>
Date: Fri, 26 May 2023 08:59:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] gitlab: stable staging branches publish containers
 in a separate tag
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230526101934.935969-1-berrange@redhat.com>
 <20230526101934.935969-4-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526101934.935969-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 03:19, Daniel P. Berrangé wrote:
> If the stable staging branches publish containers under the 'latest' tag
> they will clash with containers published on the primary staging branch,
> as well  as with each other. This introduces logic that overrides the
> container tag when jobs run against the stable staging branches.
> 
> The CI_COMMIT_REF_SLUG variable we use expands to the git branch name,
> but with most special characters removed, such that it is valid as a
> docker tag name. eg 'staging-8.0' will get a slug of 'staging-8-0'
> 
> Reviewed-by: Michael Tokarev<mjt@tls.msk.ru>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   .gitlab-ci.d/base.yml | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

