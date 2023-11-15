Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 569367EBAA2
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:39:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33w3-0006CB-Jv; Tue, 14 Nov 2023 19:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33vn-0006Br-Sr
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:38:59 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33vm-0007qi-D3
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:38:59 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so2850645ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700008737; x=1700613537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4G2BTMKOI+HjAvNWZ/w8cgmInvN8O5quMrPd9ioDbhQ=;
 b=nWd1oVnFJ3CbgY+PE6wnsB7q7Rg6Q3ksAgCsA9JxBgy1daMcRHfzrZS6paJGri1Eow
 eAJlvypxaSVA+OaMtcTO87+zifWajCPfILRmYRuyuMlaANjnTpJLH+8lzn9On1/5Qlnq
 r+ckX3eukmPKgZhdSM8D5IfYC6CUyaEkz7+5RsktXEJzqw7ycC3l0aVgSHGUrtRuAlIz
 BMrQoxtiATFi866WPFh4Rc+dad7U2UTdKpU2PBfmpwdHkFOx6SA0A5dD0sMSBKUWl16k
 kTgAgOTixO9NPo/PJoCN4zJjACe2ByQE1A3VlC5q+ndGJ9YheJcudr1pDnGs+645U95i
 +ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700008737; x=1700613537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4G2BTMKOI+HjAvNWZ/w8cgmInvN8O5quMrPd9ioDbhQ=;
 b=TUAKBePUTjusSFe3axDIfNMbPmxQ/9bWZSRQb+jVnIzhtZ0cMI2HtcUfOFRYrwLbsd
 FOntJQgArADww5oEL/1YeLBtnEike5MDdWrNfCz7UFtwdVXyIqjvW4JoQxa/lyMTfPo0
 BSxSod4488sxZzBlcoo2F4FvA6PywWmwcaVl9KNLo4P8e3Dvb158n6zl1uO/GfMl2Z1v
 NuXAcYIllLCj6ChteUmkkyeBdkywNMG8D5MyLijYRXWuq+3jIHNUXGT23EYpI7Nf2F28
 rX+JdVYThD6ENZNPyo82u+sBz7XOthxW18tz+g9wSen3xvgH3UpzUAGR3HGX3DU0H0v3
 mT2w==
X-Gm-Message-State: AOJu0YxJCOTe7gdqvuUgr6aQGX18lxsrvT23bc87WpRbKa1jaVhI9xAv
 TUMLu6leXCPwABjhmszlI/tIcIE/L4fX4sCpQjY=
X-Google-Smtp-Source: AGHT+IFvzKxgmBmGfG/7REL0vYxokSCoi/+yxLDGgCTl8+cazVMwT+fkmaqXJ5MNs3AVj8wrUHbkDw==
X-Received: by 2002:a17:902:e80a:b0:1cc:5549:aab8 with SMTP id
 u10-20020a170902e80a00b001cc5549aab8mr5200195plg.5.1700008737159; 
 Tue, 14 Nov 2023 16:38:57 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a17090332c400b001bbfa86ca3bsm6275251plr.78.2023.11.14.16.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:38:56 -0800 (PST)
Message-ID: <39415308-dca0-4a46-ae56-30f8b988934e@linaro.org>
Date: Tue, 14 Nov 2023 16:38:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/31] target/alpha: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-8-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-8-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-alpha -cpu ?
> Available CPUs:
>    ev4-alpha-cpu
>    ev5-alpha-cpu
>    ev56-alpha-cpu
>    ev6-alpha-cpu
>    ev67-alpha-cpu
>    ev68-alpha-cpu
>    pca56-alpha-cpu
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-alpha -cpu ?
> Available CPUs:
>    ev4
>    ev5
>    ev56
>    ev6
>    ev67
>    ev68
>    pca56
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/alpha/cpu.c | 17 -----------------
>   target/alpha/cpu.h |  3 ---
>   2 files changed, 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

