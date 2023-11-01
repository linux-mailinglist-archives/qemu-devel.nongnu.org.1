Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C277DDB5E
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 04:11:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy1d7-0008T0-Ex; Tue, 31 Oct 2023 23:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy1cz-0008Lb-FH
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:10:47 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy1cy-0006Jp-19
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:10:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcee9so5606739b3a.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 20:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698808242; x=1699413042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JV/9EQkcgRbuS6vhBd2e7Z3iSBOMqcgiy3MJRhBxYWg=;
 b=p4kZmDvVyQTHvXzNhggTX8KTDZRbwkNjrESngo39dWbPb2R1njf5nwHD6A8QBGDni9
 SXbEd5YftUTcFgUJrIZtn7B0lAXT3ekNDnkAh/73tRkMBKt57ZN4HgcfSStjw5uGaoDy
 vGB6f5km07EC1IKWYXy75vOPNUHVq+z0Gtt38PvyVQofoLb0cssPJmm3jjT1e54H0r28
 lmOsZJ7Hx36EcasgDIc+vTNm+KI0cK0oR4ecgQoDpMCXoc6ZvgGjJQw8dKpXgfN8bys9
 yFs09Q7FqMF8QaPrMC84nR3zKst7zbtUyKPZiJNoawDKi9WHPFZDksPuXLVYrF3HFHtm
 VWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698808242; x=1699413042;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JV/9EQkcgRbuS6vhBd2e7Z3iSBOMqcgiy3MJRhBxYWg=;
 b=YZ8mjwslg88NPSfflWV1F9d9PlgLWiFxRqZPSNA9eGzQ8qTyEXSwFemSsh2JMmRZ+8
 CGSV0T+aXcr4gWfiajY/xBvsCzxnD17F5mC1PCJmTM/w+43naiKme8O+rJgAaC/10Ypg
 W+lAmJsPGJu61xlo9xU3FVHzAdkhnm0bK3AzLbiFSAnkYWfXUjuTBh2XawYOcIgGhife
 TigymBqYV0EKRtbiROUtNbJ0/F3Q6VNGsilLdijbQKuW7cI17tVFFB/YdjNnmt66OU+X
 ko1ctHM0YamW7XiRav2NOoOawZfURrXFUJm7QP9yQrYzTYWinHYJB3LeBgVhr+JHDaft
 yYew==
X-Gm-Message-State: AOJu0YxlCzzGHlFfJ3Urm0dB0QSNKzpYeJvq57RXkBwN8XrXmY7hAjPA
 bGJcz0mLCLYA9mfa9hwFnVuYf++4o1xjyMXMpLI=
X-Google-Smtp-Source: AGHT+IEWXn/cMrqH+yiaex9rpVE5P1cfvrNs35phmx/C7fshVDSEkCWWBaoYWxFoc/FXOWKbjf9UFQ==
X-Received: by 2002:a05:6a00:1a04:b0:6b5:ec98:427d with SMTP id
 g4-20020a056a001a0400b006b5ec98427dmr12190076pfv.17.1698808242428; 
 Tue, 31 Oct 2023 20:10:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a056a0010c600b006b24b99afd4sm306204pfu.176.2023.10.31.20.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 20:10:42 -0700 (PDT)
Message-ID: <5f2f8506-a3c8-473d-9473-094078450b41@linaro.org>
Date: Tue, 31 Oct 2023 20:10:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] linux-user/loongarch64: Use abi_{ulong, uint} types
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, maobibo@loongson.cn
References: <20231101030816.2353416-1-gaosong@loongson.cn>
 <20231101030816.2353416-5-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231101030816.2353416-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/31/23 20:08, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   linux-user/loongarch64/signal.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

