Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 998FA7DAD49
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 17:49:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx8xx-0007Hp-9O; Sun, 29 Oct 2023 12:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qx8xg-0007Gs-Si
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 12:48:29 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qx8xf-00067N-CU
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 12:48:28 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b2018a11efso3694954b3a.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698598106; x=1699202906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qXYzjSibu6FzKvoWS51oeEVAZ5rV2FJhjI1zJcO67TA=;
 b=HDNN7oKymDMNlJ7HjYh4vxY0HOhJ0ODB2lYbu1Z4ASOeO6jHoHXGwAZq/75iHFRHcC
 poW5DEQozaXVu2QYPZicLsCIheEZqp4tCi4YLvo6mJq9qz0HAfPCBEkEUjuIki0cw2W7
 iCNWdeJ7Y9NWPRIzvWHg+oY8ea9dBNaOHFRjTiYwWK9+5M2MjyKi625ZFKjDcYEgtVRc
 LUbOXkKYQiI6tLSwEZpJAOCBbbqUNbHZNbZffy51Ovlli2Io58c9/3pNGEZtUP+aFsfi
 5qCpPmy9z4+aL9/Fij7fs/3f6G6XzJElxLeRITBh2WW4kNqVXQE0cCo1nJPiA30X3yBj
 /shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698598106; x=1699202906;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qXYzjSibu6FzKvoWS51oeEVAZ5rV2FJhjI1zJcO67TA=;
 b=hyQhXRnyGDMWb4c46lY+u6P6NzvvZjq0ckzZIpmx12jN4PHlMq3FOAWSzyQEPu9oSZ
 XytvpmLo6OaXWRrYVM/51N8jwuTpLDS3D129UFH1ZPSfS9ASr4MIxVpbGz4sAzZ3H2Ke
 buKiBzyFzGqhxn+rdU340yvwitEDbzkYdHlee6a3VNwXvKfMOPFA+qgU5dCm701fz5uY
 wm0KhO0owq3KDHSHzhSSiGJoNlQoi4i5NJj+gG4TMIbHnWzAEZ1A2ski1w7DiQRI9bAK
 Iyx19zmHBrmDBaji3TF/PdJ22F5MrIxlujg8e/ZNSvstNvaM5Gr9nBO4C+5RPhY2RKPR
 NlYg==
X-Gm-Message-State: AOJu0YwZZysLK9T+BP+tRooKwDOJkdvH/n0hYk1brCVIHH++ckGMQ3Rf
 ow7O6qNa+w7cs3425hAy4uKnskBXvzObMbY5dxY=
X-Google-Smtp-Source: AGHT+IGmk1+kihGdmPQgzjesVkD+yn0QqNutO5v3Gk6PGYSfanLL+XdsxBfH1IrCViPgvL++9QC8cQ==
X-Received: by 2002:a05:6a20:7610:b0:17d:dda5:3685 with SMTP id
 m16-20020a056a20761000b0017ddda53685mr6384068pze.27.1698598105821; 
 Sun, 29 Oct 2023 09:48:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a62ae14000000b006934a1c69f8sm4475376pff.24.2023.10.29.09.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 09:48:25 -0700 (PDT)
Message-ID: <daae291d-5f8e-4a3e-b3f5-c16b500feb94@linaro.org>
Date: Sun, 29 Oct 2023 09:48:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/19] gitlab: clean-up build-soft-softmmu job
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231029145033.592566-1-alex.bennee@linaro.org>
 <20231029145033.592566-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231029145033.592566-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/29/23 07:50, Alex Bennée wrote:
> Having dropped alpha we also now drop xtensa as we don't have the
> compiler in this image. It's not all doom and gloom though as a number
> of other targets have gained softmmu TCG tests so we can add them. We
> will take care of the other targets with their own containers in
> future commits.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

