Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5C78CA88
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:17:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2L8-0004Ln-7o; Tue, 29 Aug 2023 13:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2L0-0004HB-Ad
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:17:10 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2Ky-000878-5v
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:17:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68bec3a1c0fso3371626b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693329427; x=1693934227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A0ElfheLx8Pnlt8PXG5yALy+MjPNw9/7of++hYyBx5M=;
 b=f0vpmxqLBGifCPXVBlecyp7CHDcKI+P2T1oIffIXDvY3Rb44FrJH0BZo6LUMSZJtxP
 uYxHckq8iH8YKJWqkJDv695Y4T756b8zYkl9SE5Oq2nMZtIZBCsZ5TtNlxDr7anpj04h
 iE2ST8sqlHSV7rhY5gh3CK3YASXdK6ib9Sy6XVMJ29C8ztJkKrK0OWcJYLJOFvhbINCl
 aw+u2dGkXWIhh/E3Hh7BxTauINImiIt1VeIkEY4aNdd3BEmA92oV3MwgnloYHOA0CHlR
 msbVvsC7Z+E8xwaKT+dkQKkGByE5gA9WZuX8C2QlNNk/+afQt0bunpIt3R9rWqTJdJ4t
 3r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693329427; x=1693934227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A0ElfheLx8Pnlt8PXG5yALy+MjPNw9/7of++hYyBx5M=;
 b=kuJ1j+a9vZBOqy+EcG8nlDczuYJ5mLzSPAChWvNox5flrTVjzAwbLwjBsHMmLpzJKe
 N633+I4RduUuSWwWGcnaVeB9KKt4z1CI9HfIIcBJBTQi/Hm7/CQulWYJDv7DQ74ODRXB
 jjKikh07iieYHbbqYDZSJFNr9mc1vhl4+zlLd71JyYCOaV6zzVDRS3lXKkowjRqP5nsF
 sHAW16Fc8VeBvxqCB/FxfgV12oDJZRQUo82jiPCMNvdmJQonvpPAvvT2Y83AGHJ10be5
 RxgzvriCgZGhk7TkXC+VheiaqUYBBaJTIWv98iJWVKvk/F+7gGqMHD2NwMfOduHKggIq
 WxJQ==
X-Gm-Message-State: AOJu0YxXR+FHs7QaNgH3tMCWXu7IkgxTSDuW+NzdnkdGdMzDu9Qj+aUD
 clk4mWMAYn7YyIwhorIxFYBEAYntnmiFYqjD3b4=
X-Google-Smtp-Source: AGHT+IGn8cVW10dNLHTDQ86Kf+qJHbdU2PCyPraArBoHMv9xhrojpQcor5W1qQCC1UnCTdzkrCGCng==
X-Received: by 2002:a05:6a00:1955:b0:68b:ff3b:e146 with SMTP id
 s21-20020a056a00195500b0068bff3be146mr12652351pfk.26.1693329426759; 
 Tue, 29 Aug 2023 10:17:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a62aa0e000000b006873aa079aasm9051610pff.171.2023.08.29.10.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 10:17:06 -0700 (PDT)
Message-ID: <759ab1c9-e467-3b33-7c16-5c7f76ee34c3@linaro.org>
Date: Tue, 29 Aug 2023 10:17:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/m68k: Add URL to semihosting spec
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230801154451.3505492-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230801154451.3505492-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/1/23 08:44, Peter Maydell wrote:
> The spec for m68k semihosting is documented in the libgloss
> sources. Add a comment with the URL for it, as we already
> have for nios2 semihosting.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/m68k/m68k-semi.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

