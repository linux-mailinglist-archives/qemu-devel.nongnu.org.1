Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC687B7818
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:43:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvb6-00084X-SN; Wed, 04 Oct 2023 02:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvb5-0007xp-6D
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:43:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvb3-0007YN-ML
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:43:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405505b07dfso2943465e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696401780; x=1697006580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QLpvzEYmfECznb0KoytjCy9vbPN1hQ/Al5EVUYbw0xk=;
 b=w6afAPuCJPxQ8U54Vhb93+jeD+kVZlHXFN2+RoenFZ+rF9VAE6RmxSaFXz9WJPPRH+
 JChX1rFGVEAvcD7IQ2XEVtKqQbpY+GM4KP2AJcrsifRTXf6ahgPD5JWG4GfKugQ6ojHl
 mtJl3gVs6uECaJYxG31NMsxLXXpvobmssxTk5R7aR/PZSe3dia0LUzkgNbMSNrxz+wXZ
 TSfMui9H0gu2grGf+BAOGhz/3GXJa95l22eLerG97gvH6ulrXPv7tpKMo64Zq3/HNiTv
 MdP9pgtCel9sYb36fXVi4nKPTPqBvJAWG+kLbbzEpYF4JrfNLW4sL0ywPF87ibXdUIO+
 BTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696401780; x=1697006580;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QLpvzEYmfECznb0KoytjCy9vbPN1hQ/Al5EVUYbw0xk=;
 b=bptmWQ8Tcm/kyh9/enCqcqVH9lq8jq2MZZ1CdT/XfS1faLfrNjlqVJulorbCViQc4Q
 fkek3NCSg0lsCXSOsN29N34UHX5X9BqfTjFGvWEcllktwazC+rpcMJycIqWYJWYOda0A
 WarIE9cXH/Az7DcaeuH2h9CrskGwyg+sCmwYZnuZdGPm7JCJjk5URM8ULBcCTuX2cEsC
 IazdvaRVMx5RShu42N2dw6K7Kmq5Q1YWbA8u97eqd2dSjcJGsGXeeZCVhns785uFSoxC
 o60+XRlAFXP9wdi2pcw0hG/GDs3fGJb1phayoGPi6AygkS77ZTwpfoIj/QE9acLtOMf/
 BUCw==
X-Gm-Message-State: AOJu0YzZgHKlSvPizFwaFas9E9W+JgyBpcmFz/eMCoiGL/DFcbkFASfG
 ME3Hr74bn5KVexpZSB31UQ5n3eqpl6o9AcGUpEs=
X-Google-Smtp-Source: AGHT+IF1hZgXgLMN68W8nFmKVdTPA6dlLdWeWNVK+Du3K0vGW1ejweiHdPyt16nYnvu8KLxJdodN4g==
X-Received: by 2002:adf:f001:0:b0:320:6d6:315b with SMTP id
 j1-20020adff001000000b0032006d6315bmr984426wro.29.1696401780207; 
 Tue, 03 Oct 2023 23:43:00 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 a10-20020adffaca000000b0032763287473sm3222503wrs.75.2023.10.03.23.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:42:59 -0700 (PDT)
Message-ID: <b757047b-26bb-a1ef-3ed0-6ffd7abd9228@linaro.org>
Date: Wed, 4 Oct 2023 08:42:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 10/10] tcg/s390x: Use tcg_use_softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003174356.1602279-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 19:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target.c.inc | 161 ++++++++++++++++++-------------------
>   1 file changed, 79 insertions(+), 82 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


