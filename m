Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5087B781B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:44:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvbq-0000On-9I; Wed, 04 Oct 2023 02:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvbo-0000OQ-If
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:43:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvbn-0007jN-4A
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:43:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40651a72807so17071255e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696401825; x=1697006625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nRaWIXv5QMzjv9vml0bMcDyIvYVYeJA0ULcLyU21pnA=;
 b=DQ1qf4y1uMSFbBge+o4YnWYBMltYfokPbFUfGeElkDxk1Do8hucxhT1nqrDoX0wv8y
 UCSTup9Qs0rv+e1jvM8R1KzNhI1A58bYyVv/La8HLMhx8lB8C6VVYcfi53EahwVWMHW3
 tZWbwHHTL9Mf1M8V+xx6w4/T5zCooWV7Jp/S77sG+xnQLBufJAh2sS8NPzI3u3Gogh4a
 braXZanVIcrqXBl6658gtCOfEKNFY0fmd+079ddU8i2qgNmcHUIoF5Ifn/Rd+HqHkPcS
 EC/PTDlXO3LRuwa4FZ/7DziUq4CP9oC9fWW3bdvs2ZFwp8sSBOTqATmS5mKHSI5FEZmT
 WZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696401825; x=1697006625;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nRaWIXv5QMzjv9vml0bMcDyIvYVYeJA0ULcLyU21pnA=;
 b=pKpZR818CjzQXhWi1F5CNTDnx2fmnW7cEbOD6TfmEy8nIQl0hOhl7b/9n8HpCuUkUH
 ba5uep1n2sOjpEUSgbC+2vbS9ZgVmdaIwhutFJv51vrPLbf2oCRrbn8JoNDKg2WeNovI
 dD8N1tkHHIatl7Yn0k6Z0vNpDkrzE33mL7CouNTKcSh7CqEtDbDsZovRAXmu6QBSgYLu
 0MxXA6DHijkukpEKnmeoFy4TlwKkQHN2IeCgBmH+FjTcxJinAvKIMF4uwef150yQ846f
 IOQRX3IARURjT9v0/+O1rMSq1VrFPvaNHWZ0xrPjyfqaRJ3Tm8GenDMD7xBcAj1wq3UR
 h8oQ==
X-Gm-Message-State: AOJu0YxKOr+FVOQT5oYpjZqLbgP6bcJCWLAgVKbFMxb4yeqj89JU99jb
 +xokt45oO3msIO9a8s+Lra6bNg==
X-Google-Smtp-Source: AGHT+IHbgac4D7EwihK/fQ4LSSKOGrV2u5v457u2FdsrE3mORfLl0UjNdnfUzMDLSpSM04aK1W87iw==
X-Received: by 2002:a05:600c:22ce:b0:405:4c3a:796f with SMTP id
 14-20020a05600c22ce00b004054c3a796fmr1519955wmg.2.1696401825225; 
 Tue, 03 Oct 2023 23:43:45 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 v2-20020a1cf702000000b00405d9a950a2sm729252wmh.28.2023.10.03.23.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:43:44 -0700 (PDT)
Message-ID: <70386ee5-bc7b-caaa-8b41-7d81336bcb0c@linaro.org>
Date: Wed, 4 Oct 2023 08:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 02/10] tcg: Provide guest_base fallback for system mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003174356.1602279-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
> Provide a define to allow !tcg_use_softmmu code paths to
> compile in system mode, but require elimination.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


