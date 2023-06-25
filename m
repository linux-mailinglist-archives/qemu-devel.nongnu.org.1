Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB673CF50
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 10:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDL4q-0004Ud-Ge; Sun, 25 Jun 2023 04:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDL4p-0004UV-Ht
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:26:31 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDL4n-0006il-Rz
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:26:31 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-98df6bc0048so122141466b.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687681588; x=1690273588;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=osu/uwRe6dqE/LoY0IkKJmIJukGR1Yt3ufispVgOBWg=;
 b=NaHK9N2sfJATuPx4q+Ae4qNRbeG0qKwZXPi8r4M3BiunRrtatxHVjGXOmhqgSDpJvi
 VOJU2GU5kK7klJ1rugFhHkIkcpU7BflbFSsdsyJFzYadtdLi/dssnZ/gpK+jTtzUjWMn
 kEJT/4tbJIHN1MPbhI4AkufXBrulg1mH7N/daJqsYKNldY3wu22Sfb3Ogpx1uIFY24IM
 /Tp2jlNmMPV1yQLXgP8Ncy3/Byy2GB+wQmOOe1I1Wy0fAAi59fGsDi9n4fdiNx/vdoRb
 zodDnLe0EoSLD6f/vaQGZgEw54AH6h+T9tLA2f90QmA31pWF8LlOLebEZS2Mty2C5RiD
 nYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687681588; x=1690273588;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=osu/uwRe6dqE/LoY0IkKJmIJukGR1Yt3ufispVgOBWg=;
 b=VWYe5WcU9KDe4NS264oeKGLx1J/XVfjjzzw6yevS9+aJAkFzKQUOr0RyluLKot4F3h
 DRDzagNnx1ZOtWSLae2rorTeBRJiK6kWxz3jWhvcS0MweqglMOfBuJ7Frz2Z3/Ppxc07
 FnJV1BkRIfuM1dz2EydPraBgsk7gxIE47SI9tpooDHvRviavIGSUIuacm5NdZTtqWr1n
 5HAap8seIY0ioX0ZOzArVjDokTyBekMCgmAQ1YFSGcipYnYt+07n0F9a3zYhFjDKCQ7K
 ddvdAF+ny4nsYZGcg7BdVi52hV5GxCYutaHmKUBNoQP/bq80xw4AWhZq4XosnlRmyN26
 PNrg==
X-Gm-Message-State: AC+VfDxs3zTGP0U9iNqEhrJ1bAS8DHxfZhPA+3eQ04ExlQ9pxcbUin4g
 0XeSlB6ZWwMDsTnZQ5AkLDkYlD1PvOnmAyZbJwai0w==
X-Google-Smtp-Source: ACHHUZ6OmqTQYepVC4EOw+E31Nc1D/gzBWk9lCfS+ChIlctAgtgrn3jDNT2Rqa6CjOoWvGnGXPEYTQ==
X-Received: by 2002:a17:907:968c:b0:988:b204:66a7 with SMTP id
 hd12-20020a170907968c00b00988b20466a7mr17050418ejc.74.1687681587964; 
 Sun, 25 Jun 2023 01:26:27 -0700 (PDT)
Received: from [192.168.157.227] ([91.223.100.38])
 by smtp.gmail.com with ESMTPSA id
 z24-20020aa7cf98000000b0051bfcd3c4desm1489348edx.19.2023.06.25.01.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 01:26:27 -0700 (PDT)
Message-ID: <5d34d97b-6095-4b30-7357-91d6f25dd655@linaro.org>
Date: Sun, 25 Jun 2023 10:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 0/3] Hppa boot reboot fixes patches
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230624115007.30332-1-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230624115007.30332-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/24/23 13:50, Helge Deller wrote:
> The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a4cb:
> 
>    Merge tag 'q800-for-8.1-pull-request' ofhttps://github.com/vivier/qemu-m68k  into staging (2023-06-22 10:18:32 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git  tags/hppa-boot-reboot-fixes-pull-request
> 
> for you to fetch changes up to 34ec3aea54368a92b62a55c656335885ba8c65ef:
> 
>    target/hppa: Update to SeaBIOS-hppa version 8 (2023-06-24 13:39:48 +0200)
> 
> ----------------------------------------------------------------
> target/hppa: Fix boot and reboot for SMP machines
> 
> Fix some SMP-related boot and reboot issues with HP-UX and Linux by
> correctly initializing the CPU PSW bits, disabling data and instruction
> translations and unhalting the CPU in the qemu hppa_machine_reset()
> function.
> 
> To work correctly some fixes are needed in the SeaBIOS-hppa firmware too,
> which is why this series updates it to version 8 which includes those
> fixes and enhancements:
> 
> Fixes
> - boot of HP-UX with SMP, and
> - reboot of Linux and HP-UX with SMP
> 
> Enhancements:
> - show qemu version in boot menu
> - adds exit menu entry in boot menu to quit emulation
> - allow to trace PCD_CHASSIS codes more specifically
> 
> Signed-off-by: Helge Deller<deller@gmx.de>

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


