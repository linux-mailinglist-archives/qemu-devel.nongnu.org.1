Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E381FEC2
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:45:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9Pr-0005QO-QU; Fri, 29 Dec 2023 04:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9Pc-0005Q5-Nu
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:44:18 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9Pb-0005wD-5T
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:44:16 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so341128766b.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703843053; x=1704447853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C2m51AiovtVMAUBJcjtkPchet9U4AkH+q41VbNed/Ds=;
 b=h1LFJheUUTC7K3s2QAAOrO6Hhq93FRCO5YWoGGUfAOrZAoT+EWY4cLdskkqfT+vRAP
 qgXCd+VtYl74mrrgpTslqZcmTErYh0V1lv8sEvGu7cahO8ijbRal9pkuMy1CXGCXnjJS
 Dw8n9XsBY2W37E35i5ReKfE9doTSPpMmIoYbsekJzKcovt1yCyyDjKNNKD7akTHj0qX+
 +uDC1dq530NOlqZM/8gmkSlVmv4G6PJa+3/ZDI39SiHVF5SHHgziV4YI7WY3AIlGYcB0
 U+qOSzZZ00UH8qG/Lf6/SDyUmIKHk67oemRmeU3op6MrYjhzFprhjtQY0eCLJ2MnssmF
 AW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703843053; x=1704447853;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C2m51AiovtVMAUBJcjtkPchet9U4AkH+q41VbNed/Ds=;
 b=tDCVpdlI57wRwMb+GPEbKHxf4Q0ICKLKx5nE3M7cG5WBzYXihayK11cz+PtMxpWtVZ
 o8wRLIVqE1bxeyVpuGDhRvRkYkcfzbaf3BgawYqAaApWQjVOTBwWwAi/9p2Hdu0DBJzL
 gix85r+4F3RpMAvmEa0INwcoe1UBJ9Ln6b6mF5nb6BNOGESfFJnFtB//fIeuNgBiNIag
 huCMVLx5uvdm+Nx+BhaRT8a4cFjqCCudFb04dv/llteRzvmqKpY4YvQzn819NQsVB6rD
 I9Rd94Hv2APLZoPx4vH12AczW4WyGyJbQumM/HkHojszBS4ZkGrIwPWcfJ829U4usVO8
 7sdg==
X-Gm-Message-State: AOJu0YzUVpQ6E20ZTixi34psMozpw8dvqU+LuNv7hm4nyJEnvKps6+Yc
 zpwcBEQU26X6crCfPnJ5QS7I7z+Np7+mJgYtw4EcIcIhiqc=
X-Google-Smtp-Source: AGHT+IHTuYiiBGfmMU8agFQOkWGZe/rcv9v45qltRL/tsMK8Bk+T4WtofRcJa/XTJ/C5/uqTahLn3Q==
X-Received: by 2002:a17:907:2686:b0:a27:8953:a710 with SMTP id
 bn6-20020a170907268600b00a278953a710mr562046ejc.155.1703843053545; 
 Fri, 29 Dec 2023 01:44:13 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a170906078a00b00a26adbd4f15sm7488110ejc.102.2023.12.29.01.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 01:44:13 -0800 (PST)
Message-ID: <156979a1-3e10-4a6d-abb9-2e980b4db896@linaro.org>
Date: Fri, 29 Dec 2023 10:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/21] meson: add more sections to main meson.build
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221171958.59350-1-pbonzini@redhat.com>
 <20231221171958.59350-14-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221171958.59350-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 21/12/23 18:19, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


