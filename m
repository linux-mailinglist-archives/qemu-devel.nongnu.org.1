Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 927AF763C7F
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 18:29:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOhLR-0004zX-Ng; Wed, 26 Jul 2023 12:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOhIp-0003um-35
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:23:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOhIn-0008RW-Du
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:23:54 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-666ed230c81so40327b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690388631; x=1690993431;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7X2LSP3TTpUhaZP2MWAn+trCH1Wgh8n7++q88qCijmA=;
 b=xcO2WoNr3g48XsTkQXr6ZJhIrpOUhjnBk549pUypIe1PBlW6UlWI1ZkqBH7AjMTAxo
 kMSXfOwikGMa2aNFXFjKpe3DXAL1EKP3cRsP2rQq/nVv+NxQGIlEKY38DoWUuXFICeaG
 MOla/CsUDyeVZf3nwN61qBem+2tNxjscs9uDKxleuJIznv5Uygp5s73vjfK5iq6gE+0q
 mv4wPHyk7ckPOeSq1QCeMqwJoROZ4hw35RdBecoORpyTnRv177Y9kdxfvKfnEXrnFaSz
 23vtqnQxPsqersOEHi6hF0qQQNDspedr8xAf1ZMXvh+xhxI5ETUXZF3jvzQE2iITJA0N
 GWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690388631; x=1690993431;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7X2LSP3TTpUhaZP2MWAn+trCH1Wgh8n7++q88qCijmA=;
 b=TwCiSCj8YLtcaxEJnw4ot9awj9/aBPgjILl+QpvLfBQL+ZAta3eeOYyoDn0MZzrJ4t
 jFAikibNtX6iVHf3ed9tYiVVM60JEDjyHGjvq47QO5+fRt3/Hcxqj1uNCtvXYl/EFY2R
 snfPPMk6f8ARWpPKSwclp9ohogbxAfeRFlvS2IEYPhTBek2oNH0awtgxKuhEj6w+FynS
 J+z3c9k6U6KA3su27RH3acQbZVP1teghYup/KizH2WhTQfahh0tQIlSvP4cnfvDg24XZ
 MsLf+cVI8buaPxGW4jRtzJwqTkIMjYRHrBM4Y3jjBJcsZHCkp8QolNGM8L4+xcPySl9c
 hdyw==
X-Gm-Message-State: ABy/qLZoF7Bzk1B5r4l0r+UU7/Nme5K4b0HFklP+jc9hfeYObzddCEw0
 jO08uW2RwpBNBcFqFtUpwQQDCNDvZUqokm88pz8=
X-Google-Smtp-Source: APBJJlENjZpJfMrMA/zLdlRiFAy6yCbfW2b9qR1wNzeqaTEC/+J+6MP6gKAv41AKVLP9m180BqqTeg==
X-Received: by 2002:a05:6a20:13cd:b0:137:292a:fdc8 with SMTP id
 ho13-20020a056a2013cd00b00137292afdc8mr2520328pzc.9.1690388631675; 
 Wed, 26 Jul 2023 09:23:51 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9456:37ab:20dc:17e1?
 ([2602:ae:1598:4c01:9456:37ab:20dc:17e1])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a62ab13000000b00686e8b00a51sm679781pff.103.2023.07.26.09.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 09:23:51 -0700 (PDT)
Message-ID: <ce2e71df-c12c-5241-1271-fb19b5452447@linaro.org>
Date: Wed, 26 Jul 2023 09:23:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL v2 0/5] QAPI patches patches for 2023-07-26
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20230726125800.163430-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230726125800.163430-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/26/23 05:57, Markus Armbruster wrote:
> The following changes since commit 6cb2011fedf8c4e7b66b4a3abd6b42c1bae99ce6:
> 
>    Update version for v8.1.0-rc1 release (2023-07-25 20:09:05 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git  tags/pull-qapi-2023-07-26-v2
> 
> for you to fetch changes up to 9e272073e1c41acb3ba1e43b69c7a3f9c26089c2:
> 
>    qapi: Reformat recent doc comments to conform to current conventions (2023-07-26 14:51:36 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2023-07-26
> 
> ----------------------------------------------------------------
> The patches affect only documentation.  Generated code does not change.
> 
> Markus Armbruster (5):
>        qapi/block-core: Tidy up BlockLatencyHistogramInfo documentation
>        qapi/block: Tidy up block-latency-histogram-set documentation
>        qapi/qdev: Tidy up device_add documentation
>        qapi/trace: Tidy up trace-event-get-state, -set-state documentation
>        qapi: Reformat recent doc comments to conform to current conventions

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


