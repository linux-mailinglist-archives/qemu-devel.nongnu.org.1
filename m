Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 903F378D002
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:10:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7ms-0000hN-3b; Tue, 29 Aug 2023 19:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5Mg-0005DR-2z
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:31:06 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5Md-0004yk-SV
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:31:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68c576d35feso1978419b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693341062; x=1693945862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NIO6oKwh+Kz7emPXyt66l6/bSfLiu6BgjWbzOp85sn4=;
 b=sUJxUIs3CjjZGOaVlXthGg1l703ipknj4x4XVt2uJXMLx4JjSQaceFyT+3GTVD+l9V
 fr3ypNc0Y4jWuxJB8zEIFnISdOOcPl2OGpI/MJ0knTbhL8oMTQhOu5hQqeixnJ7Iy3VJ
 xDjkwtlti9auofReKCKPkdxvEA4SUb4vTzZ11p/1YVHEhMY4IReaCPUf3PnoqiDPPnpw
 jNMAG8CZQyvBWsfiiJ+f7p7dcC4JF/frZYcnMWo87Yc/daFWVp3BKjMbhEBPSAGcGPPb
 6iAYxSmuYgRdnsquuS1uh3yvWo7dYBjdfboPWLv6/VoKe6JYPk8CMHZGYTdSyrmucS4T
 +zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341062; x=1693945862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NIO6oKwh+Kz7emPXyt66l6/bSfLiu6BgjWbzOp85sn4=;
 b=I4T68XQRJD8A0/ORSRvj/SLMpBnrcgnaKG7lNucaFLzJO7iO/AQXVQ7anMa492LMPF
 BR0DpwG1YXDNtPv7TUOT7oITbgpwBPjoPbbgdkcsmFnlj74rd3RSbadNw98o/wkBV7iD
 PfFKA7p9S6CvSL4GNYWJlUDPu5HippOaW1wertZ0adZ3ocw7jaCoGYbrrs02xK8STsw4
 3ozxUhIJO/YdHfMy047O96l2Bp5yIFHyYYIe1/9x4mHiUKEyNmGGwgBrDXgrApxSc0yS
 ToKYmdj2vBZVq4MksiX6karXLTObB7wIsDuTSznG51OHwHUmFbcqQpPcjDbw2HTXQSuG
 r9Bw==
X-Gm-Message-State: AOJu0YzknrS2beYvO3eB+TjKD0E6Q0L8iOxCdhebxQfWV6dDi5lxwVbv
 +qfEAPl2bzIy9SmAM9fpVJ+9c/JWT7jyZ5OZKwQ=
X-Google-Smtp-Source: AGHT+IGuGyVPUsev1OjnHrBnaAFDW3uawDG48QO6PO4fxvBhBizHfGc2guOXH0ze7p/zzlUgz/+T+w==
X-Received: by 2002:a05:6a00:189f:b0:68a:4dfa:ea62 with SMTP id
 x31-20020a056a00189f00b0068a4dfaea62mr387173pfh.9.1693341061896; 
 Tue, 29 Aug 2023 13:31:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 z8-20020aa791c8000000b00689f5940061sm9133620pfa.17.2023.08.29.13.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:31:01 -0700 (PDT)
Message-ID: <df225fca-34c5-7507-7549-afb11679e6c6@linaro.org>
Date: Tue, 29 Aug 2023 13:30:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 25/32] bsd-user: Implement procctl(2) system call.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-26-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-26-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-proc.c    | 114 ++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |   3 +
>   2 files changed, 117

Acked-by: Richard Henderson <richard.henderson@linaro.org>

I think you need to squash this with patch 24.


r~

