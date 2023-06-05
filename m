Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC5F722668
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:53:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69hx-0005VY-33; Mon, 05 Jun 2023 08:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69hi-0005Ur-F2
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:52:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69hg-0006aB-Ul
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:52:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30aef0b8837so3927932f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969575; x=1688561575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJsq1TiWeCK/NStU0mA9D3CKfJanvws6bizphcfAaDo=;
 b=thQbjlUUrqXUgFTLXeoOlEvdMKYaUVbJWXZsGi7VKdUX+dr9DZHh+ESxEMaVfj2oS8
 D3EnYQGRUicS4GTR3AfY/8i3wl4zM58KBSGHFJgtgJz0zl00ANwLCdES2gamaxiDF7Tw
 BCyASWAIrWQ3BkRpifyh/++HKgUKW7JYjVZu6ObkWGGEnk1c/7Bu6qptdyUH/r+Du2cZ
 ap2+00CHb9bEeznvPPi2J6OLUAmYa2Vg5SDpb5FswPUM74xg9RwnpNZn2kQ9Ol7ffTgf
 9Im2yOzuHPuWBsn51gXI7OQ6NO7CHcSmsbBxQ7JCNzr0CcYZGU7J1FXV8EI38vJuVyka
 5G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969575; x=1688561575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jJsq1TiWeCK/NStU0mA9D3CKfJanvws6bizphcfAaDo=;
 b=eyiJC3u/CmYza5uob/sVpvBPMZDqs1ar21/N9XRM/g9KGn3mxxVo7Dqb8Ycm1gPi76
 vQjSD7a8/SC6o31owhXnuGROqsyWSsDk0NWzS8FkcL9rFXOV3tjQnEt08G9l5V3g/on+
 Qj/TuNhG8IV/LE/UxCzOBjMUPjYu9vKMoIAo8vZVmNIvSF1XN46qODAlELx03PnNX9Hk
 1TaUgclj3H9hZkQy4rBr/FFlsa+UeW3CvkHYO/BOwOwI5W8NsQsziG+LO28/hjleXwOl
 wQkbEDvRB25uOooFZUUbi6wvnmJgZOLIA5NRvooVLq/f68GuCWgG46i8f18UwZA6LxIE
 Tjhw==
X-Gm-Message-State: AC+VfDzLr8FMfWA8iTF9muVKzvJxETDtbdraeTZR4O2RA86nQCcXGilN
 mD65Jrwm1KlU43Kc3u1HsmYCMufYFi2QDBvUMZk=
X-Google-Smtp-Source: ACHHUZ6zVmCItNQDr5KvlO0xYc0U6N4qJ8TRgaAVdfFVxmRDK+kmhkmyWX1IdqrSJytVNLy9B08vaQ==
X-Received: by 2002:adf:dd10:0:b0:30a:b030:9cdd with SMTP id
 a16-20020adfdd10000000b0030ab0309cddmr4393740wrm.25.1685969575266; 
 Mon, 05 Jun 2023 05:52:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 y12-20020adff14c000000b0030ae7bd1737sm9749531wro.45.2023.06.05.05.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:52:54 -0700 (PDT)
Message-ID: <66190771-3f34-bf45-142f-ef7f1a2d2870@linaro.org>
Date: Mon, 5 Jun 2023 14:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 04/15] linux-user: Use abi_int not int32_t in
 syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
 <20230603222355.1379711-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603222355.1379711-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 4/6/23 00:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 60 +++++++++++++++++++--------------------
>   1 file changed, 30 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


