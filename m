Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6F74B1C0
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 15:27:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHlT8-00027r-Qx; Fri, 07 Jul 2023 09:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHlSx-000226-6q
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:25:48 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHlSv-0005rh-CI
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:25:42 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b6b98ac328so28498551fa.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688736339; x=1691328339;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cJ+8OCj3iI+O/WZNhELqK4XTm4vfEKcOADwRPsQaXmg=;
 b=KUvYigYfuPIK9XDybA2+RFJWyh/33NO3BTzxuR0jaLdcUZUU591y/ClF70C/6LJp2m
 vxcpW4xn2uBjsHkOCVvvfC+LY97yRO/klND/3+eH+Bzcv++UQvlMjWh9XsKODgLha4rt
 raWZAlbEnxbL+7gND5j8eV/CuiWJtg35fJm4PMDMO4QsMXJd4dEpDgTRyRvVLh+lg5jE
 tFUzTdpHjiuECBpdd1+KbSRyaQWAFzLb78vLyHnSaZVTIS4HuZWExxHa6XsowzYvEsEx
 9pi4TM/cGCBupsY1FgmzbWMT4NTO8pS5BY1OWywg6ltS+XJpr99jtAhc5v98zucqYyZi
 kkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688736339; x=1691328339;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cJ+8OCj3iI+O/WZNhELqK4XTm4vfEKcOADwRPsQaXmg=;
 b=C8Dg6miT0zureOynCykA2d9RUVZ8GqNYOW2XFi1dR0GAWW8AybVu+eIw3z/UIKWnWN
 fVPD65rtxBUVt3hRyiP87EjQdDwopret3IJ5nACRd13CQSUV3oH2l6/L9qEczYySVP7t
 kGm/+W12hjZ1l7DwB0fCqWdLAndXhYe1Mdz09TlYPkdVZlCl/Z4t0fI9ik0ETJGPPweT
 R/XPDX/GrZ6WxZA3nbPeun5PblWYXYGspm0/1r0WefTHdDQFQ9thh4x+awyNlIThzLYF
 CjUlc909Y4xCP2fViJ2KmJ+9GMJUYvlhDHJhF7xnQ5Ebm6OUoBubaiYmmPZwVLmJ153y
 yLgA==
X-Gm-Message-State: ABy/qLZhgjDQsEu0qY3uIz8WvIp4B5csoS9Z8+rLKN7gTqjlp2BlR6pw
 GVFjzpEScml4RAW36bFXKidPCjrJV+kkDicKfnI=
X-Google-Smtp-Source: APBJJlHTYRDwy6Tdwdj4LBbAB471Ue53LxO+uHjMcTEDb7rLc5paODH+mC67nYjF9bOquyFfjRDxmQ==
X-Received: by 2002:a2e:9f14:0:b0:2b6:a841:e686 with SMTP id
 u20-20020a2e9f14000000b002b6a841e686mr3659500ljk.6.1688736339300; 
 Fri, 07 Jul 2023 06:25:39 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a170906851200b0098669cc16b2sm2157552ejx.83.2023.07.07.06.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 06:25:38 -0700 (PDT)
Message-ID: <1bc798c2-863f-96d8-10c4-18bc2e5d1067@linaro.org>
Date: Fri, 7 Jul 2023 15:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] accel/tcg: Split out cpu_exec_longjmp_cleanup
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: rjones@redhat.com, pbonzini@redhat.com
References: <20230707103611.5906-1-richard.henderson@linaro.org>
 <20230707103611.5906-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230707103611.5906-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 12:36, Richard Henderson wrote:
> Share the setjmp cleanup between cpu_exec_step_atomic
> and cpu_exec_setjmp.
> 
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


