Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC57BD4FF
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:18:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qplSo-0000Rg-Te; Mon, 09 Oct 2023 04:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qplSn-0000RV-8r
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:18:05 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qplSl-00068y-Pg
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:18:05 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3214cdb4b27so4057902f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 01:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696839482; x=1697444282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UG2QaMuLN6wCet/x94Y8vo+fFHupfwrxk+G4l8yk2HI=;
 b=x338M+prLxFyxUvfQDhvWCi4wJoyrZHVPsBBhQt+DgSTEhY10uIxcxtdwAsnO3IMoQ
 SQrl3leYzNHPe9H677cVZFeNjm6h46eJmCsWg0QdbNqJOBD4/mcOtEcxfAmrbY+qrjgx
 9UURQFlKZDhnr92ELChqkDh1mUljrNHJm+mOSVpNGPw2/rUnptsgklatYmAuPB91ZBR9
 MI+Mut0GtqRl+zwEtIlb/dXV3EGNRxc5+dPvKqRrEgB81y/Z0AO2k0jliD6WpAAdkx3V
 UUIzb+1o/gsL4MR0ZgYmgWvIx8Ys76zg+SMW9D6Evdazuo147aNrqW1jZgIfme0TLftl
 w82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696839482; x=1697444282;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UG2QaMuLN6wCet/x94Y8vo+fFHupfwrxk+G4l8yk2HI=;
 b=otFvOQOoPk6RAVUaQ3/ci6ybCjb8jKZkszMuQQX6hXoAcdsxYaus+hdjJLF5ctzSjT
 k4py8Lu1yE49cudyBV2dXYZRXF/kP1hT0++B6230Thca6Md2ZS1myzq6tKeRgVoqhILJ
 mKSEe9QY9fwGNV9MR/96GexvcsvbhneLvhmH//3SZQbwXnxdtVjmB4rOxnEftzM2z31s
 lRm9h2Cflx8lrrXlP+8oUUao6Oxfu8eDYCXBmo8Oh9PFfOpiGG3gMkvwD+fWFnwAL3KS
 uiPKAGtYzkTj/s3+C0E7gwsTjf/JA/CySMOuBzId8HNiGigmJwLBymXKHCxtAWd+kB73
 L7Xg==
X-Gm-Message-State: AOJu0YxIYV2SDQtpGuxaP3kffuVKnpAWfCg8Lcni71JUzQOZHTchWwnL
 ShoECQLSWeifjc/foeAf75EUOg==
X-Google-Smtp-Source: AGHT+IGSqLHaKP9n7qCVZq9XSSbNPapbi3oDcWSh+E99hh9o3r5dr3CkWOlVWyGgyMXha8TN8oilMw==
X-Received: by 2002:adf:f403:0:b0:321:5b64:f744 with SMTP id
 g3-20020adff403000000b003215b64f744mr12615076wro.20.1696839481822; 
 Mon, 09 Oct 2023 01:18:01 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 e18-20020adffd12000000b0031980783d78sm8856794wrr.54.2023.10.09.01.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 01:18:01 -0700 (PDT)
Message-ID: <8c93c319-546b-45a8-f3fa-825add57e0b5@linaro.org>
Date: Mon, 9 Oct 2023 10:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] memory: drop needless argument
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20231009075231.150568-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009075231.150568-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

On 9/10/23 09:52, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The argument is unused since commit bdc44640c ("cpu: Use QTAILQ for CPU list").

10 years =)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   softmmu/memory_mapping.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


