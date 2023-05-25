Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C85A710B70
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29Sx-00074Y-1y; Thu, 25 May 2023 07:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q29Su-000743-MM
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:49:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q29St-000515-6Q
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:49:08 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3078d1c8828so1945797f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685015345; x=1687607345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w+aXgadqggQnIfOC/IpR4yjLrfRISG94sVagSHANZow=;
 b=FqpwwRL7S1+zy+UJjkYju8DG279asr0NPILKPxE67w6RoStIKoxnWfAee3N0FNqu00
 ikUOOtvNbPItP/SbgPVuAQuIQ6c14uBElrLgnqq0Ys4xkC7+maa6Z5oAyrWHjVf5WRnr
 OW+oHdKR6feUfxFRxu2KWCCUKp+MSIfQIcjYCR/uZ5hKt/cOESY7jTQYvCKm7mH2MPOy
 VRuGIMmsRFMpWRZDtgeC37f+AsPrSyZBpNvd1ht/c5w82cPnKmdgBK4pPU9ea4xI6Gsc
 Y1toMrcqy6xFPQBwp72dN0FAsci3WZwgnsh3f9nhX3OCSjYqWkBtx0VapmZ4r0KvRVPc
 JIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685015345; x=1687607345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w+aXgadqggQnIfOC/IpR4yjLrfRISG94sVagSHANZow=;
 b=bt99ym2j5vJ/1wft5np8Z1OIpDvQRK6FZAynqWXoI02wj9ojnVzneF/spyWiQGCTay
 i2jb3S9NBruGtxUhMOYkdm7BSuRess9N7YNtgsf0mzMmuZvVhbrnBnyZFg9FFTdv/r9e
 bPzL71ng828lCCcsQSv3n/1KSVsoVfLOEQu3+DiAmcGlG4XXpLtmUOvJuATugX+3wlXx
 QRqmh3tvZnb6gTznRv/oxm5LtKzkGCrz5dok35LVrCHkXfszwk9SvOudRq5anTEPRZYy
 UqQ947FTmyCw2OxDFB8VmRr5qaw5HKoFqr7sDetbBX22YBiZzzU0Dj2CZtyHWjeZXkJl
 kivA==
X-Gm-Message-State: AC+VfDxn0ind8TX36Y+p6LdCSCe/a/7NVLWyLL8VUWq+IJMLDcp3A8DH
 IbkqCHl08cDvud010KF6/CwSNw==
X-Google-Smtp-Source: ACHHUZ44AO20Scm0zOp8mMeoZpIoBEKS/+DO/FcAZvJWnN8BK+xpgXyADT3H5wRZQUo/oOi0GrrUzA==
X-Received: by 2002:a5d:42c2:0:b0:306:3911:dff0 with SMTP id
 t2-20020a5d42c2000000b003063911dff0mr2024059wrr.4.1685015345318; 
 Thu, 25 May 2023 04:49:05 -0700 (PDT)
Received: from [192.168.69.115] (cor91-h02-176-184-30-254.dsl.sta.abo.bbox.fr.
 [176.184.30.254]) by smtp.gmail.com with ESMTPSA id
 s17-20020a5d69d1000000b00304adbeeabbsm1566692wrw.99.2023.05.25.04.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 04:49:04 -0700 (PDT)
Message-ID: <29e579f1-39f5-c354-bfad-6f9241e22f23@linaro.org>
Date: Thu, 25 May 2023 13:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] tests/docker: simplify HOST_ARCH definition
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, jsnow@redhat.com
References: <20230525102844.209240-1-pbonzini@redhat.com>
 <20230525102844.209240-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230525102844.209240-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 25/5/23 12:28, Paolo Bonzini wrote:
> ARCH is always empty, so just define HOST_ARCH as the result of uname.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/docker/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


