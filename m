Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA4978F66E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 02:39:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbsBU-0001NV-Ll; Thu, 31 Aug 2023 20:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbsBD-0001I7-Ue
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 20:38:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbsB8-0004P3-Jk
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 20:38:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68c3b9f8333so933424b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 17:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693528703; x=1694133503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=taA0aY40AgM649B8wnCD0KFOwzw1i52mzgxmLn0otc8=;
 b=uVUVMcj+ly/4XMDewHZLPUoIixmE+lL66C9Q2UsKNT4iqhOBSgwZs1e8hB9McqRL0o
 +KHVcNte9Ym4BiX8zLYcO0jITpb2vo/ALhT/4PSEEpTUhy/rkb2rgcWqGWvANXx60muP
 93WeQ2W0qfpsWXHpr4Wskh37BUVM+SLUH8hya+T+xrE/2PbAMfGnJr6O2RmYmrezvNb+
 Hu7hG9gx2FBCZHpVpVDPsdBmC7kxZ9kcM/UlYTYZ2oQNtKGabFNcoroQi4kPcgvg+mtA
 sfXI5cnojbKhmx6O4GfwsGBSsycc8DuQALWS78lXx5DClCt2uOHQ2UukaYWZTFD97KEU
 D9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693528703; x=1694133503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=taA0aY40AgM649B8wnCD0KFOwzw1i52mzgxmLn0otc8=;
 b=l5YR/ZnSPU+zq9Hqm84Er6uLjap25/yFO1XM7c9EsD4T1qRjnekj3QBfW0Wg4yVR7P
 W1f9y7dVIUil12zoDsTByRBxJRN5w6/bBBgycgXRGhBqYKCztUoqEgWaIm9fyVu0Tar6
 AC+hZVESPuDa055wGj9n+KjQpQCNA7qn1V1CxOaInpaV9yvYF+1XHsDoKqsuXIsexeen
 rukhPt4x7T4SnZ3Q81qXqNzP8bt5pTNJBodd2/gF9vbyK28qIJhjJacmuNTtvJwUYhIQ
 pOa0cB0UQXQxpdECkkCHVZHIPMfEyTh2M/TGXyEH9p3DYGtxYJECfLARVEY9X/WlLqmB
 Ughg==
X-Gm-Message-State: AOJu0YyHxRvQoH84IbWYGu/oD5RjKVe+WtxnC2+nfJq84rLZQuUZU7Ew
 1y8GCW29QELmNHua+vHZNModNA==
X-Google-Smtp-Source: AGHT+IE7pieQS45Dfi88gvcgTT8QTZ6EmVvI2FVWi1h7Fu2TlRk0/EWmBZcd8+nDvS/9NJCEyHf6lQ==
X-Received: by 2002:a05:6a00:1786:b0:68a:5cf8:dae4 with SMTP id
 s6-20020a056a00178600b0068a5cf8dae4mr1591471pfg.3.1693528702922; 
 Thu, 31 Aug 2023 17:38:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a056a00270a00b0068a13b0b300sm1900522pfv.11.2023.08.31.17.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 17:38:22 -0700 (PDT)
Message-ID: <91f8724b-1f1d-6121-afc8-cc6446bf9359@linaro.org>
Date: Thu, 31 Aug 2023 17:38:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/11] tcg: Clean up local variable shadowing
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230831225607.30829-1-philmd@linaro.org>
 <20230831225607.30829-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230831225607.30829-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/31/23 15:55, Philippe Mathieu-Daudé wrote:
> -                    MemOp op = get_memop(oi);
> +                    MemOp o = get_memop(oi);

mop would be a more descriptive replacement.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

