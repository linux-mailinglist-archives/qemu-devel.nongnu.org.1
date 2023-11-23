Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E5D7F6582
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DaS-0003b5-Ey; Thu, 23 Nov 2023 12:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6DaP-0003aJ-9r
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:33:57 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6DaN-0000dp-PP
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:33:57 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c887d1fb8fso14289611fa.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 09:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700760834; x=1701365634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lavYDdN/Mv6yJ+kdqqYmIq+qs5nycWgd1tfZqwn099s=;
 b=H5dW6oSHld4N1hwFx3RPBjiY/QG5r00c+hnPbOTpQ0/XMUC5/fXcxgSJfv+bMtV4e2
 LU92micuiiwhJI1bROIhtLL3wLIdF/Ne5PtNE/ypoVh2XY+BBO2BD+/PvF9QCdrMHI5H
 TZXQNapsElt+DnVkYx8DL8oGqV3XNEXGfyTjhefb2VPsowXrHgbByTjZwyKeHiCE3DFM
 UcSboGE3G3TE8odrxEXsByWZvza3Aj2pt8HMa9BWOkjWXfwXlogtEW+7mIkEB5tAc4Lc
 4pmQ/mSc3sJGg9dr42VUF8bl7QagC9f6Q1FqSiHLE69l4gCwxAVcT32zrLmJbiRAOU4k
 m/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700760834; x=1701365634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lavYDdN/Mv6yJ+kdqqYmIq+qs5nycWgd1tfZqwn099s=;
 b=uFjSQS6EwtHCEqxSo/Oop8gf1dNZ6GD+/cIMO7Gpwzn4Ii2ZvQ2jC7zm+IN2cEZGzQ
 +eFMihsqzkJFJktDaymip9HmpnICwvO1XB6sMz7X5SmREtjIXdSgso6lwIBO0ZqWR24B
 YL3SJvV6xokN6FgRSnrN8QNRO5QBD/tdzqOCp3UGeoL3xAveXTNHWO1ZRJCVLvWgDTSc
 C8Qlt9jiL/nbZGjDtg8P0RWybh43MQcaikyxN80NAzfIZ3n0kYSBlvODc/lo+chkD6Ut
 Ns57QL+ECv0BYDMsNIL2nM9wCjr7H/ihbjZ5dLhuRpIDcSrexq8ZnLcATmjaVTt2M3Ev
 BmfA==
X-Gm-Message-State: AOJu0Yw1YIhBcDU805CsQdlD9kQwSNoknS7CMk0zsCrtJKBPQCNYClAA
 GIdf1IbwWr+xOSS7aEQFRH2PSw==
X-Google-Smtp-Source: AGHT+IGSamQ6anrubh4W3lozjAnmTgAxq0wGpG4r4/UQh/RoIK/W8cip6H49IiWkmYTigbNaLc8NYw==
X-Received: by 2002:a2e:81cc:0:b0:2c8:33a6:4df4 with SMTP id
 s12-20020a2e81cc000000b002c833a64df4mr36402ljg.38.1700760833658; 
 Thu, 23 Nov 2023 09:33:53 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 be7-20020a05600c1e8700b00405442edc69sm3305072wmb.14.2023.11.23.09.33.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 09:33:53 -0800 (PST)
Message-ID: <235ef186-50cc-4893-abaa-f0a9e0386d9b@linaro.org>
Date: Thu, 23 Nov 2023 18:33:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] target/arm/kvm: Unexport kvm_arm_init_cpreg_list
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 23/11/23 05:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 12 ------------
>   target/arm/kvm.c     | 10 ++++++++--
>   2 files changed, 8 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


