Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9027E7F5E1E
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:44:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r688A-0002fj-OD; Thu, 23 Nov 2023 06:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6887-0002b3-U9
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:44:24 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6884-0006lV-Ld
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:44:23 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c8769edd9fso10601791fa.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700739859; x=1701344659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ce0UdoP69WQp9djpBr/2y5m8LFeKEN1zdjCnJGCglCE=;
 b=s82ffathHP2R2BrdQhu+qvpY2hLRdOylLL+HafIzM4tl913zANxwlW1CavGk3s40pl
 WiD/lmfGKMUZNj/p8HlgAKXPBJUEc/E9fZ33uNRBxDBSkYcumtsvjaVAWJz2ro71LNYr
 8cTyuQZKUctPllsLbfKoB9AfGz1vTAKfnwpxS8rR5mzanj0HSHiDFm6Cp2Z/JxfRgxB8
 AjXt6nz1NLapv6VmeFozcWsinfJ8YO05NVvKzurBCjdAAJJWfWaukpsvMB3jv+hu1jHT
 jU331UeCvyfc/N/fVjxOgxrAiL9WjCI+VhehdtjM9gY0aqGfBvHDew15Xqk3JeafdsRF
 jIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700739859; x=1701344659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ce0UdoP69WQp9djpBr/2y5m8LFeKEN1zdjCnJGCglCE=;
 b=u/9JW4YgnvFdIIrqy5ZvXtOBAzIZElpVnoislDL4rOOdS6MZ23axilH0aIi1NRR8UI
 1af+17a7cVhcrmIlRc307ciGBokmhBw9ZAXLqbSaoaDPMK8JBdU8s0zYZ1ro4vIJWfGI
 UdEluGbWhAmJh6IllG+tTYgDiv7TG+3YE59WHOLe96s3akKaADs+TC/GlVL+EzcVNFoK
 85hQ13WIbAraI0nIX9UHX5HpE2janR2lrr6xVtrdd6VhCl58lkA18wnnJ60V3I1s/HZj
 8aieI++Z+jCuWPf71FBahebpB/b04GWLhfq1zu87lYKdx7sauU4MzC3YJn9BIKQIyG/+
 d5Hg==
X-Gm-Message-State: AOJu0YwcfKxDG+9Qv58WpOtJikXA+6ijd+guR47maf9idIiwJpu4rztT
 FeS81FM9hkY/FCABA35JM7uR+5u+wfqFBcS7H/I=
X-Google-Smtp-Source: AGHT+IFm2QHqg/IG2mbVqXrk/dR9BY7/iWKgzCZMAoB5QRwrycY+lSuIZXt37iaygBaZelvrp+9YZQ==
X-Received: by 2002:a05:651c:2129:b0:2c6:ed45:8c94 with SMTP id
 a41-20020a05651c212900b002c6ed458c94mr4487312ljq.51.1700739858680; 
 Thu, 23 Nov 2023 03:44:18 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adfa4c4000000b0032d8eecf901sm1455905wrb.3.2023.11.23.03.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:44:18 -0800 (PST)
Message-ID: <41b8a704-96c4-4903-94c7-f0817233d137@linaro.org>
Date: Thu, 23 Nov 2023 12:44:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/21] target/arm/kvm: Unexport kvm_arm_vcpu_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/11/23 05:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 12 ------------
>   target/arm/kvm.c     | 12 +++++++++++-
>   2 files changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


