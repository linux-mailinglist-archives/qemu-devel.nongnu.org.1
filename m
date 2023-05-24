Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 389C970FE21
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1tk7-0007SL-Pg; Wed, 24 May 2023 15:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tk3-0007Q3-Ht
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:01:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tk2-00061T-1y
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:01:47 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso1035600b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684954904; x=1687546904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TwI8HsnLZZVW+eBChZJLSW4iUg6kKWsOAoR+HeGruLE=;
 b=Hoj3dKfxgKweRIEFnvZTXS4GVLhSjxMc6UMkEz5YwoUd2f2pTKn43Qa3R67Tqzl13h
 v5TJvxgSbfOrfscO/Gm4VAYu2SaWKL0fLXs3jfo5A+sBcs5IXjP7Hq3I+2kkEsbZ2Nuk
 ih2I+hA84Ygj1zqbBlMMoGyX7TsNDo3dG2QeAFnHpU1t0OucACoR/NS4I4XHl4H/W6tu
 kx0gx4Gyn2dB6FT6Ncx+8WhEQgQAdI7tv9HSeveMnswemn5U1cwvI06zPk2TEoGA0k8e
 TvLl5MPgDYha+JdtRdEEGsqbglCr9a5G33qKBi4p1kKUFPtxj8s/5DCeJJQhIO8EZsY6
 c92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684954904; x=1687546904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TwI8HsnLZZVW+eBChZJLSW4iUg6kKWsOAoR+HeGruLE=;
 b=YcnUTkvoCXqLDENTRf0/g9JiDoj5ghi/QwZr4EFxkWx54o4e8v3nGx7ykzIGva1qi/
 Hv/wcMkGDS3HOYJQMlBfrKIHA416MXQ4slDChW2ipTLwrGHFRqovpHphE0c77F07cmMR
 hWePzDosbc6rbs3RZnWZm0Db/100VMfbJ3j77KqdG0V3waaRlL8vBk4CSGi0rOStF4lo
 F9pmB1WDABNqppIS5NxsPA03W0DrWpZgrh/ahbwQMO60QJ8G4Tz7UaDt44vGa6JSc4OC
 AdWz7S6TdIZjS9IViA9LNMc0JlRtiFPQMBxNlN5JQCHPqK20fXxfhgjgk2RICTKld8Ba
 CnPg==
X-Gm-Message-State: AC+VfDzO82e1b7yo9cvqAaXATthRZw3B1nKVcnP/76iizLyJ8HNsJ4gn
 /pUaZ7uy8tWJ4M5CUhBwv52ywA==
X-Google-Smtp-Source: ACHHUZ6G5X1HFS6hoPbLOUjkmrRdQLgUD/+gJPj6BpxngV+QBL3TcS06fEzoynA87/gFxhuikaAPow==
X-Received: by 2002:a17:902:ea84:b0:1a1:a800:96a7 with SMTP id
 x4-20020a170902ea8400b001a1a80096a7mr18789734plb.8.1684954904377; 
 Wed, 24 May 2023 12:01:44 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a170902b78c00b001993a1fce7bsm9030560pls.196.2023.05.24.12.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 12:01:43 -0700 (PDT)
Message-ID: <ea76efaa-f298-9f29-1474-68c01bf3dc03@linaro.org>
Date: Wed, 24 May 2023 12:01:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/10] hw/arm/realview: Declare QOM types using
 DEFINE_TYPES() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230524145906.33156-1-philmd@linaro.org>
 <20230524145906.33156-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524145906.33156-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 07:58, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. Replace
> the type_init() / type_register_static() combination.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/realview.c | 50 ++++++++++++++++++-----------------------------
>   1 file changed, 19 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

