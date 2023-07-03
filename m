Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9354A746030
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:56:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLuP-0000lE-K7; Mon, 03 Jul 2023 11:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGLuM-0000kY-UV
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:56:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGLuL-0004Bh-EB
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:56:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313e742a787so3957032f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688399768; x=1690991768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MCHVcPsnRABFaLdcPD9r/Umhi5dGKil0OQBUC1VcB7Y=;
 b=DTu871+xyyn759vx//aR4oJ/B/+sFs+6VGS3HyYibFm0uFkPw7BJdzSpxQIdXJXsXu
 Q146e/GeToOZd+gYSMTSIpwjUYG7oE41QHHoQvHoa09mqDcCuU1whOKo4csEqB+xP0Fp
 BeH6KBlpoQNUUrLKKTeS/DAQSAynOAtnWN6DDG6zCSTO9KlxTui2ev+rk1+1u6Cln/Co
 2di9EwgvXCjU3xpuRabkWerFixMwSPQdkw8c7hyxD12fcfG6YUBmwhKtjO64xBHq+BrX
 yD/OJR0itvHU1xs0n0PFPPuOD79afVXOKOb2mk4gLlJyYHWN0GQKn2Vpo9DwK9s9au+T
 n8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688399768; x=1690991768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MCHVcPsnRABFaLdcPD9r/Umhi5dGKil0OQBUC1VcB7Y=;
 b=BLoXFLJ/hJt1ZvIHFjXWPJDnWOFYkcYCDoBLjZPZZCCxKZbpOyAz9ZWiVild6k0egJ
 mtBkxtz3aktNFGNqR7SxgdHDeY8LlUUBppKVxHL/9zKY88epn3my8DtRnVWaRuoBb8tQ
 932yJNCLEivbp43fhN6/kOKRfDFuUKXcBcEUeI12EibVPvPtFMiC2YjBEUUS7Af2FHDi
 yeunrJRt1th46q9ksqdtpAwj//0lxn1xbM6WsZh9AVk47+/tMPXXJXICMVaJpoZ+wou1
 Z7EmVhCjG9iT+EvskmCqlOst5dp6n9IHRsAvWupD0dQmx6EA0WNMLd8dyLTvCO0ekaTK
 NWJQ==
X-Gm-Message-State: ABy/qLbUuNSS8RL+DuBG4AR6EqZrrCORU4hlDXwU7aJ+hcXQ/nBAf5sB
 tI+Hhc90eKqjbwShfI2G+kW25A==
X-Google-Smtp-Source: APBJJlHEaWzc+qz61rpgIxKlRmtUedOEesHx67MMj5K4sNLDDphHo+wuUPOusUovBnt0h/la857ecg==
X-Received: by 2002:a5d:66c8:0:b0:314:1096:6437 with SMTP id
 k8-20020a5d66c8000000b0031410966437mr10095110wrw.19.1688399767997; 
 Mon, 03 Jul 2023 08:56:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a5d6092000000b003143be36d99sm769008wrt.58.2023.07.03.08.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 08:56:07 -0700 (PDT)
Message-ID: <4f1499fd-b45a-5210-d2dc-e10b46bf9b98@linaro.org>
Date: Mon, 3 Jul 2023 17:56:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 01/24] linux-user: Use assert in mmap_fork_start
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, laurent@vivier.eu
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230630132159.376995-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 30/6/23 15:21, Richard Henderson wrote:
> Assert is preferred over if+abort for the error message.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



