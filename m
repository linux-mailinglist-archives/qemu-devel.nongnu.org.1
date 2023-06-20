Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B823373721E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:52:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBeZN-0003Yt-U2; Tue, 20 Jun 2023 12:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBeZJ-0003Xg-FV
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:51:03 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBeZF-000545-Ey
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:51:00 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-988a5383fd4so463569366b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687279855; x=1689871855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WvR3qKi0WughjgrJC8R1M8Tr1N+10vHwo06/bOYFZlA=;
 b=OaUR1sRVF8E7FkiLNEjZ1clqe+GZRHCgJkWoYpl6FQw75Ik3QzAjNI/AhP/R85k9B2
 nMJYIIGqpijiV8Tok5Xp1Im4icVH6NydKBxsyIur9+K79hfG44yR00pO+PSZ2KdjW/wT
 TdFl2xhhceiJnt8J9USlSgoezCbXAvSPi+rYn5HZOEDy9vYl91+RoqjB8mjR1br1FJKu
 moJwbo1gGpWPF+XH7UQLPMMUNANrARm6K+A554ZCEPzArC5InRCdB+VAMc5X11FFWSoW
 pxqMaCjwyKFhh+IE7yMgGo0UIU4/uupUZLF9Fn5Ps0ZVYaLI+x+MrJWx+KVi+UGCioH0
 7fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687279855; x=1689871855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WvR3qKi0WughjgrJC8R1M8Tr1N+10vHwo06/bOYFZlA=;
 b=Q2rPRD4LkCFkocsvwBObaJQckDo4iA65X+0I1Lu/D+QwqmEPZu2VKAUfYyEr7PK4jg
 zQawdRl8snnf6AXSBnTHZMlyQJWwpoYJCWGDrJHsdURTjMKvlsAZAYpwOYKgXM9hfruN
 +iWbsoCgAxXZx8Cxj85jqdYXYn0gQqY/CDrolCm47SFXhqtg5lCjKvfJIo2B2198txaF
 GiAJZpwLE6ami5WNhVG+sCps7AAb57JIGHFfKW6tvul4M9Qr9pNN9+EdFo5MkeQiDCF4
 ynSdZ76EnHqwXwsZKtfzCKNDgvGxo828FaKbXp5pzEyt8FdZ/mZDkguHUDYvDrxgp2+U
 bG3w==
X-Gm-Message-State: AC+VfDycqhGWiC5rROz7L96QwPVQSggBFyhRXSG9AYVAeCiVlvthUQ8R
 qoWT1kB5hCFmPbTME771zs6Bsw==
X-Google-Smtp-Source: ACHHUZ4XmNga0mShkL3k6MbkTpynPfQHT23+DMro5jPV2azC9v8uo/WCJ+ZSCCv+w9aJzDgEXasEMA==
X-Received: by 2002:a17:906:ef0a:b0:978:2b56:d76e with SMTP id
 f10-20020a170906ef0a00b009782b56d76emr17015018ejs.12.1687279855738; 
 Tue, 20 Jun 2023 09:50:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a1709065e1a00b0096f71ace804sm1681915eju.99.2023.06.20.09.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 09:50:55 -0700 (PDT)
Message-ID: <11348b82-34df-0589-5cc3-a1b693362821@linaro.org>
Date: Tue, 20 Jun 2023 18:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] pc-bios/keymaps: Use the official xkb name for Arabic
 layout, not the legacy synonym
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230620162024.1132013-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230620162024.1132013-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 20/6/23 18:20, Peter Maydell wrote:
> The xkb official name for the Arabic keyboard layout is 'ara'.
> However xkb has for at least the past 15 years also permitted it to
> be named via the legacy synonym 'ar'.  In xkeyboard-config 2.39 this
> synoynm was removed, which breaks compilation of QEMU:
> 
> FAILED: pc-bios/keymaps/ar
> /home/fred/qemu-git/src/qemu/build-full/qemu-keymap -f pc-bios/keymaps/ar -l ar
> xkbcommon: ERROR: Couldn't find file "symbols/ar" in include paths
> xkbcommon: ERROR: 1 include paths searched:
> xkbcommon: ERROR: 	/usr/share/X11/xkb
> xkbcommon: ERROR: 3 include paths could not be added:
> xkbcommon: ERROR: 	/home/fred/.config/xkb
> xkbcommon: ERROR: 	/home/fred/.xkb
> xkbcommon: ERROR: 	/etc/xkb
> xkbcommon: ERROR: Abandoning symbols file "(unnamed)"
> xkbcommon: ERROR: Failed to compile xkb_symbols
> xkbcommon: ERROR: Failed to compile keymap
> 
> The upstream xkeyboard-config change removing the compat
> mapping is:
> https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/470ad2cd8fea84d7210377161d86b31999bb5ea6
> 
> Make QEMU always ask for the 'ara' xkb layout, which should work on
> both older and newer xkeyboard-config.  We leave the QEMU name for
> this keyboard layout as 'ar'; it is not the only one where our name
> for it deviates from the xkb standard name.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1709
> ---
>   pc-bios/keymaps/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


