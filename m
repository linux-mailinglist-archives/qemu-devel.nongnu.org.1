Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 805B67E5D6A
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 19:42:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0nVG-0003zW-HT; Wed, 08 Nov 2023 13:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0nVE-0003zO-9C
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:42:12 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0nVC-0004gn-Ej
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:42:12 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2809a824bbbso5569000a91.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 10:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699468929; x=1700073729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a8hP4ONYatUsSD+JK/Q3WAou1kfbPcq506JPa5WeBZ0=;
 b=ZkVUGV/w5Za1o22ysTS8lz2ryKnmvLeiNu5yLgBUeeqs+kLeJCt6ZFD0J5dgcWkpsr
 b3xivVPrgYFgWOY+mepizrukvewJ7f/NgAAC3P151r352ZY4KoLUJ3TJD+lLJeXgEcoV
 kG1EyOc3le1Dyc7AaAAlSDe61jhMIyRXqu2cNcHqG6OKX+28vMCj6IwwbztI+ObjLjj2
 jCNCD1+2SvxVHCBMr5S/0nqJFMHTYho2ZSKevzgubw3fuxYhC55tTflBjPEKHJhMNqtp
 KfhCPFApr07Bk+9u5k6R8xg/LF/560TClIYO7hTM8ydI2zTXZ3rTMeekMB0las0bVXiD
 UJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699468929; x=1700073729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a8hP4ONYatUsSD+JK/Q3WAou1kfbPcq506JPa5WeBZ0=;
 b=hOyhZkGwW35WebyiW9RpIckhcFC4sHpg6ziycfP7uPlExMXFGIKNEDPqJXoDGBCdzc
 HGKmgO7AB1yPgiBDsLryJSGkE1UytPqL1zx87kJND0KZy6lcgtU8NmzNOIm82zb6eguM
 Gql3fzI6tYGumpPrM/I/L5EplTc8JdukDkckVTuBGWTODSvW4F0RXAIgShlPzL9qPHKf
 rw6kqlGlmOUHQh7HPSy0tUhOBvT7qoKbEVvyX9irqq1Lk+IC95s583bT+IqIvvlhyYim
 3vhpJdBvAerFWZnBvzRMssicK1XfVQNoHfLJl+ij/XSFg1bgaVg/dfUve41fErrpf7Sy
 H7cw==
X-Gm-Message-State: AOJu0YyBVULQdy2i2Wl8wGisAcGsM7QiKgj4eTGisK+RpUNZPT5BUbUY
 tCKkJaqTM6Jdaqcom/JXej0v2w==
X-Google-Smtp-Source: AGHT+IF8sEZmRZBypkkajPxlNUNCDd54kiMv4fYWUvtyVdtYhPLeTacdgMPiTQpsiakIoprhETvnig==
X-Received: by 2002:a17:90b:4b82:b0:27d:c35:7f3 with SMTP id
 lr2-20020a17090b4b8200b0027d0c3507f3mr2741636pjb.8.1699468928786; 
 Wed, 08 Nov 2023 10:42:08 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a17090a4a0a00b0028105e3c7d8sm1889193pjh.0.2023.11.08.10.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 10:42:08 -0800 (PST)
Message-ID: <4a1e02a2-65ce-47b5-88f1-9bbf295cfa3f@linaro.org>
Date: Wed, 8 Nov 2023 10:42:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] target/loongarch: Add loongarch kvm into meson
 build
Content-Language: en-US
To: xianglai li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, peter.maydell@linaro.org, yangxiaojuan@loongson.cn
References: <20231108014141.2590657-1-lixianglai@loongson.cn>
 <20231108014141.2590657-10-lixianglai@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231108014141.2590657-10-lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 11/7/23 17:41, xianglai li wrote:
> From: Tianrui Zhao <zhaotianrui@loongson.cn>
> 
> Add kvm.c and kvm-stub.c into meson.build to compile
> it when kvm is configed. Meanwhile in meson.build,
> we set the kvm_targets to loongarch64-softmmu when
> the cpu is loongarch.
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>   meson.build                  | 2 ++
>   target/loongarch/meson.build | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

