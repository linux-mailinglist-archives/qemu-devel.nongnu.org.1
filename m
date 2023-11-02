Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C567DED51
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:31:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS8D-0003ER-KV; Thu, 02 Nov 2023 03:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qyS8B-0003DZ-MC
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:28:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qyS8A-0003Hi-2N
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:28:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-409299277bbso4417085e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 00:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698910119; x=1699514919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bQs93aMYfASDblqZAecRC/6iObYeY9wecDvgSeUOO0Q=;
 b=e1b57ercaKfWg2yGBLzc57ACJPzY6pyL1m32QYrYm79x2xPDAqwc0WfOxVCOElu/bQ
 HeX7wmen9G8/mYC43hZ2I76DWbqd8HVHJNeLVyIOejlZ+EtpAZP+eojQ7rMmU70UwmZg
 1u0szbWBLW1WkgOQvXjB+HGgi4QQJl64M9bPZ3plVT887DPs60wWcD0hw/ts19fpRNR/
 Fj3WyPB77lMiAcwqtAolsJ0z86A1WwFZlWMk5CQ44cFF7owMCMO2S7dgAMiDsyVP+7lh
 mf92f0w+pPXRMOpfD9RIDW+gPlOUK9SJpP4gcigETL27MyJt7qKYL8GdqqQ335AfM2p4
 V2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698910119; x=1699514919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bQs93aMYfASDblqZAecRC/6iObYeY9wecDvgSeUOO0Q=;
 b=a3UHF+Mpkv+cIGbX+M7Hbc6DBIIG2tlfZr3SqDLDsKuMKkqd/idC5lzR/UhrXB7xee
 U7eSI+wcfyGHlw1+lpyb8kaiG3TrNNzEK0gVytN6pyZ8pNo0da47M3yRIzIjKtAWjsqF
 dA5Xb9Wtm8ybxZmT0XgLFmNnG5a0Zl/c5e2bUND2khtfc7ZtI1dmyxiJzbSCG70hRayC
 q40kizHzfH+Gck7kVNsWkyCjZvad7ahu91Sv5EvWgByfmdeld7mQWpNElbmt3pfPUXFl
 03rKYswls26XLfS4y9m6xivYxcCE0gbB4vCJTxaGYwtwNVxTyokBCx+mlfWA7XGruE8F
 9MgQ==
X-Gm-Message-State: AOJu0YyB3ayIi1ZpedfHRFjOkNz7x7rt2tuRLC+KMvj2CeNC4RbKzCB4
 6l2mSdJ3CA6X3vVwx7nr1bYKDw==
X-Google-Smtp-Source: AGHT+IG4oPUaV4UTSDwnTu5Fae8Fhfg1IOTPZaDaOCLpyw33uH6lvQ8f1nKYArH4G5zFr85yTGckug==
X-Received: by 2002:a05:600c:4594:b0:406:54e4:359c with SMTP id
 r20-20020a05600c459400b0040654e4359cmr14341163wmo.19.1698910119455; 
 Thu, 02 Nov 2023 00:28:39 -0700 (PDT)
Received: from [192.168.69.115] (176-131-219-113.abo.bbox.fr.
 [176.131.219.113]) by smtp.gmail.com with ESMTPSA id
 k11-20020a05600c0b4b00b00401b242e2e6sm1890592wmr.47.2023.11.02.00.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 00:28:39 -0700 (PDT)
Message-ID: <d897c14b-d193-f148-1afe-aa64e348da52@linaro.org>
Date: Thu, 2 Nov 2023 08:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] linux-user: Report AArch64 hwcap2 fields above bit 31
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231030174000.3792225-1-peter.maydell@linaro.org>
 <20231030174000.3792225-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231030174000.3792225-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.777,
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

On 30/10/23 18:39, Peter Maydell wrote:
> The AArch64 ELF hwcap2 field is 64 bits, but our get_elf_hwcap2()
> works with uint32_t, so it accidentally fails to report any hwcaps
> over bit 31.  Use uint64_t here.
> 
> The Arm hwcap2 is only 32 bits (because the ELF format makes these
> fields be the size of "long" in the ABI), but since it shares the
> prototype declaration for get_elf_hwcap2() it is easier to also
> expand it to 64 bits.
> 
> The only hwcap fields we implement already that are affected by this
> are the HBC and MOPS ones, neither of which were implemented in a
> previous release, so this doesn't need backporting to older stable
> branches.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/loader.h  | 2 +-
>   linux-user/elfload.c | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


