Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D697C8AF7
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:27:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKyw-0001U0-PL; Fri, 13 Oct 2023 12:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrKyu-0001SZ-Tx
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:25:44 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrKyq-0004OQ-58
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:25:44 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so263664b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697214339; x=1697819139;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6h8OlzIS5jTn7jMfwa2Wj7hZz1jxdKvU83HfYmivdJ4=;
 b=z1GSO9J2fp3ylLs5d1b71QaPKEfjq0b0BqIwIo8+Z9y+ukPd3GC4Rmx9ahpCYwqRIA
 v0LvrMXUFMa7sZd17eM/mhRmANqpkZE+zIezck+rPDIfrLNummeDsPqPRFv9YfhZJlJq
 Hlx1VeXwGQKWC2bgIMYiEODQ8mtwM1wXEQEoHNR78hLd/zMmf+Yf3uScJCQMyr4WPrfq
 6Jn/5k4dtQ9rgc+e3R+LKN1z4+M8KomzMRC1nSe7k8Nbz67CXi8UabrMuDXA/GuGDOdR
 tw7SyaJ/sPaZLQ1+acCVgQyY2JU9K/yC/d1ZChi/4xYSnroe4IoV1iMDEkh/hXYWKTCF
 7oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697214339; x=1697819139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6h8OlzIS5jTn7jMfwa2Wj7hZz1jxdKvU83HfYmivdJ4=;
 b=bpyua6UBGYZlTIxAVKp9VmxpmLRG51z9GwDyYIg9daay2oRFwGPfXch/8AYbQh0XtI
 oKbsk9gM8xfbXE4sfhE3Lyy+5h5vdZJ7ZcPRWuL8ODkgkE2DHmGLfrOlW7qA6X/3phYc
 +FxFyi0uFafUqoJV0FAXLbdqDWZQ23DwPwFbI6A4IAS+XItv1m9awnl1jdBVMfOr/6AF
 rMnn06bPfnYOAHpvSQhl6zv0PcRY2AiMFc93+LzXCiUuKlum1sfU9PafYS3Rx1o8Zo3J
 gFtomXi2ojgF6utpsUm+Nnkx2uGUQ2X6Ku3ikhgkK7ImU49zNuJKRmakbBgP8Nnat6d1
 oZhg==
X-Gm-Message-State: AOJu0Yy9IgsaWSK7n7oVQA3QdzcZ91oAvrQevwi70KMpmaLFHyJY7fnU
 TiCa90M/YSvEp3yj2QgkR9GYZQ==
X-Google-Smtp-Source: AGHT+IH3m2WiX+v1BGxmFONKVoS/gBVt+UQsBoerlUbFq2U7gxWBvKAaEFTqXSzS4xcvlH40RSp1Mg==
X-Received: by 2002:a05:6a00:2e96:b0:68b:c562:da65 with SMTP id
 fd22-20020a056a002e9600b0068bc562da65mr29115527pfb.26.1697214338686; 
 Fri, 13 Oct 2023 09:25:38 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a637118000000b00563e1ef0491sm3645370pgc.8.2023.10.13.09.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 09:25:38 -0700 (PDT)
Message-ID: <e355e52d-950a-4342-8547-19a1e36da99d@daynix.com>
Date: Sat, 14 Oct 2023 01:25:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] contrib/gitdm: add Daynix to domain-map
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor@daynix.com>
References: <20231013154424.1536392-1-alex.bennee@linaro.org>
 <20231013154424.1536392-8-alex.bennee@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231013154424.1536392-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/14 0:44, Alex Bennée wrote:
> Daynix describes itself as a cloud technology company so I assume
> employee contributions should count as such.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Viktor Prutyanov <viktor@daynix.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   contrib/gitdm/domain-map | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 42571fc1c4..bf1dce03fd 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -17,6 +17,7 @@ cmss.chinamobile.com China Mobile
>   citrix.com      Citrix
>   crudebyte.com   Crudebyte
>   chinatelecom.cn China Telecom
> +daynix.com      Daynix
>   eldorado.org.br Instituto de Pesquisas Eldorado
>   fb.com          Facebook
>   fujitsu.com     Fujitsu

Thanks!

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

