Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68F7A2405
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:56:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhC69-0005EH-1q; Fri, 15 Sep 2023 12:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhC66-000582-DE
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:55:14 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhC64-00077J-QZ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:55:14 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9a9cd066db5so313788366b.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796911; x=1695401711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EINJ8evasMfzy6Mi/m4tN9EW1DgCpcE59OMD2HpItbA=;
 b=XGkGBVMVQLJTPrL2LXb8bVvYkkeAjNxeh80djwZYFyxNcDW6JgSRhW8odlvpshHkW2
 VBspxAN4J1l8c821dY2i2kC2shRsE+iyY/BgYe/7SKGE7P58MoY9AhUBwHZvJBFzqMbH
 AbvZ0wnFTed6b/a5S/f/Fq4gkzF/8K6UF0fIqjJepZ+0vWF5hz0scG3Jvu4jdJLSSgdA
 BHvQrqRcs2WxNgcWKHOXmmolFS7WApRmDVYyeiFWjxxbIQMZaSOcsD5hE7z6P9aZa1Aq
 dos4qXkAXElhqjdLHI3Xk6JMGYTXpg76Mfz2zNmYEDxGoJbFvxuVEdLxCEfxl1QCghhX
 OWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796911; x=1695401711;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EINJ8evasMfzy6Mi/m4tN9EW1DgCpcE59OMD2HpItbA=;
 b=j2IY4HFVKUKzAhWJ2opmT04AmHbvqO/FoLKosictJL+SKgtVlTK3ehNKgRRoIukIGN
 O2nUoKQlM+IUqcr7L929ZAO6wYBGMnEpbUCpA0+DB0PQUXXEpCIbPLLqstLFPULat4xj
 dhfdMV5bSTbpjF6JXMOoNhk/+NP51Y4UOLPW/cFj6bKTYXc9A3fpn9uzedJADpxLlnmh
 VwZQINNR9funvqWOVxt+cQ4jq5vfYECwDGvzceMFcamBtZ/ySSy+AJ8jvIwpAWK4bioz
 BvNRSmoOf9Oa4XnvUWPtT6UBX9C+/hAxceXF3Irnu0VQeKzjYlzA1D/amLTvToCeDj7N
 xFNQ==
X-Gm-Message-State: AOJu0YzZurtoHydLqRgKmUQYlidtRAM1tOjlpclA6CiWgmN12gFVaPog
 DAJruht5jSv9+md9SuIPucGjmasVhMGcYHPv1W0=
X-Google-Smtp-Source: AGHT+IE5OERvcge/956OcC09AQR1xNbQsn+nWxXu6ABuCHS953kehe4OMUKmgCkTlG3khKu59mIdcw==
X-Received: by 2002:a17:907:7811:b0:9a5:c944:8e71 with SMTP id
 la17-20020a170907781100b009a5c9448e71mr2002061ejc.60.1694796911251; 
 Fri, 15 Sep 2023 09:55:11 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a17090633cf00b009944e955e19sm2642585eja.30.2023.09.15.09.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 09:55:10 -0700 (PDT)
Message-ID: <e556e795-bf0e-95ba-6bb3-b64f675b6a82@linaro.org>
Date: Fri, 15 Sep 2023 18:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] softmmu: Use cpu->created in tcg_commit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230915163254.123338-1-richard.henderson@linaro.org>
 <20230915163254.123338-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915163254.123338-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 15/9/23 18:32, Richard Henderson wrote:
> Use created not halt_cond to test for cpu created.
> 
> Fixes: 0d58c660689f ("softmmu: Use async_run_on_cpu in tcg_commit")
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   softmmu/physmem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


