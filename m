Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2B973D974
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhOo-0007v9-2R; Mon, 26 Jun 2023 04:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhOI-0007Ry-Ff
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:16:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhOH-0001EO-14
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:16:06 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-313f363a6f1so515398f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687767363; x=1690359363;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jgDnVQYWIrHoKAh59cOihexTGqi1CaFvI3UATOefaTs=;
 b=jUX4zURnGmAXugdX2xXU1OPBJluHq+FKMsqlyYu0D9cYCMh78eFEkwaL/iobcyllip
 A8qI5LAtolLAeTv0/p5FbpNBObr3+zFTZLcgs42U/x2n6lzCdVR1F5HuI/e1v/49p7EE
 y2S6Tsu47JzedwKLDjYDiA6b4N0boWymtKOoMtv0f2Pl5+arWHOwVj2zQfBgYux6rm1r
 5iHHDuUYIzDOrl5VQDZ1G3EJCKGAFbKQN74nPeGtm81Bg6RItljt4+tHfVuDN55CCQhe
 txZQqupiB5M1FNI61eW+ZGI72TDvBRntb5NvHAWXRSPq4RVTrTK5jHwKD6s2OXkdz4GG
 pPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687767363; x=1690359363;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jgDnVQYWIrHoKAh59cOihexTGqi1CaFvI3UATOefaTs=;
 b=I8dbMRY1Ipo1+kyAcDST7T6nn+lWmWYA4aOLs/AKAlJIty28oq5OgseNouAUNBLE2g
 lUjUfRGBBTCm0sawpNL0hBaIlCW6cB2DRh6iqqmV992AhwVWxGEPkPh5757gNN2YYsxC
 YqnBHOmDapXFdUBXHOtp6IZPFrHFLrGnv5uJFzYDy9TAx7Kt+FGdloSSrACUgLy67VEH
 T13fYFwdzo8v0lVzuoGvIdDbeXJrAeq7JqQ8xdMmArOKuVP3/T5EUb1rRUGuJib6de+W
 SJdqP9kq+uU0xU46N7pI3bQblOtD0M1uQ5KzBkEyMdZGKprUDs+OR53f4MM6kmHVduQx
 6E/Q==
X-Gm-Message-State: AC+VfDy8iK2RpyrTs3j+2dAflWWMNeVe9k0clLT8Rjl2CQVXzwe+Un6d
 9ukJKkXU+jrpmHDZgxBcE8TpAQ==
X-Google-Smtp-Source: ACHHUZ4C6T8fQoTAh11KNgnI99mn3hohlu8G11JTl9a4JH9kYHHMPTdXQvLJ8XX7axHrOobkHFIQag==
X-Received: by 2002:a5d:4149:0:b0:311:1b83:e1e4 with SMTP id
 c9-20020a5d4149000000b003111b83e1e4mr25998158wrq.5.1687767363479; 
 Mon, 26 Jun 2023 01:16:03 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm2946732wrm.45.2023.06.26.01.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:16:03 -0700 (PDT)
Message-ID: <15e5bb4d-d066-8fba-ef8b-51c33a235668@linaro.org>
Date: Mon, 26 Jun 2023 10:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 16/26] tests/docker: convert riscv64-cross to lcitool
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 14:20, Alex Bennée wrote:

> --- a/tests/lcitool/projects/qemu-minimal.yml
> +++ b/tests/lcitool/projects/qemu-minimal.yml
> @@ -4,6 +4,8 @@ packages:
>    - bash
>    - bc
>    - bison
> + - ccache
> + - findutils
>    - flex
>    - g++
>    - gcc
> @@ -21,3 +23,5 @@ packages:
>    - pkg-config
>    - python3
>    - python3-venv
> + - sed
> + - tar

Squash this with previous, or just merge the two patches.


r~

