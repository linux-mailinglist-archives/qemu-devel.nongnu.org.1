Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DF6728300
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GvY-0008Br-AS; Thu, 08 Jun 2023 10:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7GvW-00088H-Fd
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:47:50 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7GvU-0000hs-7u
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:47:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b2439e9004so3449895ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686235665; x=1688827665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fPbJFVgkWod1XHXePqT9vRhIy74eSJuoHrABqXKFwRo=;
 b=Cg//bCg/hVwvj0ugXx9L5YIYw9ACs0JK0uvoSc/iJnTCUCTinIKmTffmnDsSA7wRPb
 DGHGSbwdNom+lzzVb7EbsB7HsRdYXFn+1GRQ9bPPYFfjyOa+P76nSZCtOgRZb22+gOHa
 9tIs/LghXcOqbeN13/mtHwYIYo8B87rYsQ/d/2xS5CmHQkYsmm1XkJSnZfRl13xA59S1
 XFjjRxHdN1OLA9y7ZKiRwf5LIEzPIrte3aIoRJ2K4cMWka3EfnDRYNGBVVAf/daHGT0i
 2ICFiuVLUGnRDl3P+HiEYPaW9h/Tda10JJqmG3Lp7RT8hBev+YzJ9F4V96jLxp9f3fAN
 2Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235665; x=1688827665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fPbJFVgkWod1XHXePqT9vRhIy74eSJuoHrABqXKFwRo=;
 b=i91WwuG0GlOputjQbGTTj0GfEfmx2o/+Zc2FdaclA4VZlCVXIDuef6ZyXGhR1g2/lZ
 Kw5cq3mzttrIh9sUe17JO7UxQcbDYlT1nhlLe1p8DC7japvwNneYCz53EdNzQDB7BsPN
 k6YB698lIyNKR2sRk7K8A3HIQbmtuFZkLCfUoGRqYIevnt+3tgBK9RqN6yBONXuHIccW
 lQhF5+tkmnQmfMwe9235O/pDXiXEPWiqu1Y2CpHHLieQia2LwoSlKNEcUgPkXlcR8GU1
 0HTKvqKv4ucAloxXjZbCutgnyaMBTFqTM/QCzkrWT95Rt6GFXwNvi7/eXTMzc+F3wXPh
 n6Yg==
X-Gm-Message-State: AC+VfDzXMEKMhYePQiyMN5VFzDoZQfBmHfeNi7m1PamlDtwJu621PV1Z
 aa+kvOPljCwSIMC6lBqT1oHPNQ==
X-Google-Smtp-Source: ACHHUZ68WmCQ/1HHsX3k0biScCCuEPBMputtEmtqIpSl53zztkTmoLWxqjt2bCAMM536hwhadyHbXQ==
X-Received: by 2002:a17:902:da8c:b0:1b0:5ca0:41a8 with SMTP id
 j12-20020a170902da8c00b001b05ca041a8mr5189836plx.39.1686235665161; 
 Thu, 08 Jun 2023 07:47:45 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:1ac8:15fb:bc3f:9b00?
 ([2602:ae:1598:4c01:1ac8:15fb:bc3f:9b00])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a170903229000b001ab2592ed33sm1534636plh.171.2023.06.08.07.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jun 2023 07:47:44 -0700 (PDT)
Message-ID: <d7b7735d-8673-3aba-7894-3716be20edd5@linaro.org>
Date: Thu, 8 Jun 2023 07:47:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/3] SNAFU build system fixes for 2023-06-07
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230607154724.253659-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230607154724.253659-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 6/7/23 08:47, Paolo Bonzini wrote:
> The following changes since commit f5e6786de4815751b0a3d2235c760361f228ea48:
> 
>    Merge tag 'pull-target-arm-20230606' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-06-06 12:11:34 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 45904b56d5321be5f6e2c9e12bd143fb3b871ca8:
> 
>    tests: fp: remove unused submodules (2023-06-07 11:05:09 +0200)
> 
> ----------------------------------------------------------------
> Build system snafus.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


