Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D333718F06
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 01:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4V7s-0004XX-H1; Wed, 31 May 2023 19:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4V7q-0004Wg-Mm
 for qemu-devel@nongnu.org; Wed, 31 May 2023 19:21:06 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4V7m-0007k5-53
 for qemu-devel@nongnu.org; Wed, 31 May 2023 19:21:06 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-394c7ba4cb5so55245b6e.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685575260; x=1688167260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FLyvxyqbTyxjr/g4QUbA5aHjKQRhcPg6eZKmEKEMm5c=;
 b=TzoXoglLmQAf211B+pLqMExNqjAoCRQ+eCSwfj2nuZeJiRPkhK43j8StK43I/MIzrA
 boxHDwoIJDqBu28dQDpqrmXBqsZcVuC0UkI13fhiYiQvOT4ChwFseYKtocqLuv8g8RSK
 3w1Q6C/W2Q60tCmjlAkJ4ekpfOT7oIzk6K3jnCp1lYNuTEBKFJ1bph5dLWD5hDGYvgxt
 Sk4MN2h/cSytFnFfJZtIKY2rrJqIvKK2nNMveyDLJvpVTUZPKArG6M+Zv3UyMiLN5N/N
 cS3A+78nhxchktlP7Fkhtpc/pQrPVkJheWeRl16xDr4pCygJVDdMbtt3st5DifsxWjYI
 q4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685575260; x=1688167260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FLyvxyqbTyxjr/g4QUbA5aHjKQRhcPg6eZKmEKEMm5c=;
 b=cXMImPGpyUyA4tUQoDgXI76OAIDRk+VraxwsOmEgufDldub0V6BrhNSDM3IU12lVRf
 dWrcxoD6ZuNcMCWCAzs6/g/wph84vv/kNVrZtLTWRhA317S6bxn1QpZ2of05qLeMHFMd
 ryFMA/5rxrqk9mLeNI9ufHltHtYi8d4khwP1xsxyIa5ppm1TkWC47k21NJ+bG6654G2m
 /rrzfPjjXTyxFjq0cpLX2Os6X69mfut2N2+5GV80+SfyUyUwpsPuG+MybCBq76eVGNm5
 9N0ULI4v8uxsaoTwZu6/L5r4ZlWUZNxnsMSeXv6Nn9YUDcswr3IFZ2+0/hD3nwQ5MWfb
 zhMw==
X-Gm-Message-State: AC+VfDwpQ1+APsWIQqybWr3/Ie9b3skC1vCCnhV0gKdB9TrUkKXZfH24
 /DiexaLUvV++5y7CgOldWMWShA==
X-Google-Smtp-Source: ACHHUZ7Gl5SfIDO6IhvfW/40tbMqBkHQq5BOnBzIHAJM6gdqbBG6SI4QldVTH/9MRTEn4wMSS1RtZQ==
X-Received: by 2002:a05:6808:11c5:b0:398:3152:fee1 with SMTP id
 p5-20020a05680811c500b003983152fee1mr6065210oiv.20.1685575260560; 
 Wed, 31 May 2023 16:21:00 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a17090aca8d00b0025632363477sm68341pjt.14.2023.05.31.16.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 16:21:00 -0700 (PDT)
Message-ID: <e77bf733-ff18-17ba-567a-c496f8468682@linaro.org>
Date: Wed, 31 May 2023 16:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/5] Python patches
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20230531204338.1656158-1-jsnow@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531204338.1656158-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/31/23 13:43, John Snow wrote:
> The following changes since commit ab7252279727da51c01cdaf41c5fe563bbded3a6:
> 
>    gitlab: switch from 'stable' to 'latest' docker container tags (2023-05-31 10:29:14 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jsnow/qemu.git  tags/python-pull-request
> 
> for you to fetch changes up to c76e7652c786683edcc846ee0a7a65b587787792:
> 
>    Revert "python/qmp/protocol: add open_with_socket()" (2023-05-31 16:25:35 -0400)
> 
> ----------------------------------------------------------------
> Python: synchronize python-qemu-qmp

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


