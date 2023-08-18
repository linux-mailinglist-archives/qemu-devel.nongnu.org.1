Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D8D780FB1
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:58:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1rx-0005F5-S0; Fri, 18 Aug 2023 11:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1rw-0005Em-Hm
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:58:36 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1ru-0004vd-ES
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:58:36 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso7925195ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692374312; x=1692979112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ShSb47kAc4/i6wGIEWiO2fpeQiW5R2KHKjk4nVZoq5I=;
 b=KDI5Qmnjieha7O9m2qmYAQwkfOb1q2tVS/g/BiFLrh4memS+i+ioH1pvtCGVjDaur/
 +4CNCSSc7PDXOrEjSgBNLd2uI9O7E31mYKNPv7DUuvtGfycGa739cJlNVHAnfgvdLCeu
 OAKNaBPN6tlK6EZB17mj+Fh4gv1WoWZDuaj12u45q7mV6f+DMZH/zzAzIgpxjrOLegWV
 /B9lQJVuK8DvR+ECxSTpPlcP2CMaaWxf1XkhBA67onkR+fMytpmzS1feOGsZzvhIQTwV
 3E0YNbbFCmG86zS+6ZdrTgGUfO9ygDrRTYO/z1+jFbWAon0pu4y4G3qbq0dyNcDN1tNR
 wODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692374312; x=1692979112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ShSb47kAc4/i6wGIEWiO2fpeQiW5R2KHKjk4nVZoq5I=;
 b=Qnmlf9IgE5hzCXJlbChLVuDmWSc804WEt1moKwfx8SIM5GACFVVfj9rtPZ46CvxmEP
 B16Owe8gFByTI2NcghkVVd6vhn6lCG2N6VzMbH+lwjruYgl0x9RT+Fh+WOK/pdwintyz
 ZRTweG3qzj090kZiVJpIzJxY7n8bAeuZhRJhurvgtReCmfOpjEelyDsTl+vlqyl1XTJu
 ewuHoHUrwLbHPajScjMFS0ovt3tTGvnRABytP2fuqHSkbGIwZTDzWvh4M4XMpd3VZq5l
 v9KBGX+5bpSdOeSXZErYUboysWhQe6DMOTb6X8Z3k2tMq+59lug1YaC7eXvhLdGUAnyl
 W3ZQ==
X-Gm-Message-State: AOJu0YwSa+mkgmccbd1BRyObBE+rPqx9EzgsK3I9A8Y34wKbsu4HW4ff
 Y8Y2bcV/kYGrPLgHA649dwhOiw==
X-Google-Smtp-Source: AGHT+IG+rbpyfzd3s6ndwrvthL5hHG4Dr5fJ5OjjJLooJMr+L+FuOzvstuyjbdUMrWumknqpWqiU7g==
X-Received: by 2002:a17:903:4ca:b0:1bb:59a0:3d34 with SMTP id
 jm10-20020a17090304ca00b001bb59a03d34mr2753458plb.30.1692374312520; 
 Fri, 18 Aug 2023 08:58:32 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a170902ecc800b001bb97e51ad5sm1942044plh.99.2023.08.18.08.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 08:58:32 -0700 (PDT)
Message-ID: <58779418-210d-1843-126e-815f91cacbe6@linaro.org>
Date: Fri, 18 Aug 2023 08:58:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] target/loongarch: Remove duplicated disas_set_info
 assignment
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Jiajie Chen <c@jia.je>
References: <20230818103425.16271-1-philmd@linaro.org>
 <20230818103425.16271-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230818103425.16271-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 8/18/23 03:34, Philippe Mathieu-Daudé wrote:
> Commit 228021f05e ("target/loongarch: Add core definition") sets
> disas_set_info to loongarch_cpu_disas_set_info. Probably due to
> a failed git-rebase, commit ca61e75071 ("target/loongarch: Add gdb
> support") also sets it to the same value. Remove the duplication.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/loongarch/cpu.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

