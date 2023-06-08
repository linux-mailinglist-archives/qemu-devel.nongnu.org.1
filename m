Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB61728301
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:48:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Gvj-0008Fu-0X; Thu, 08 Jun 2023 10:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7Gvg-0008Fa-OO
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:48:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7Gvf-0000kC-05
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:48:00 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b038064d97so13971425ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686235677; x=1688827677;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1LxiprAMfv99QQZF3YfA8LciqY6LYeOX4vWz5dtCvuY=;
 b=HO4h63wN6h7XfhKl6H4aPxJocw1zF3xs7i4sjAQTTQrH2TyulV0MjGOuox+KsO0wck
 aEy0BNCzDqI82ICPpfI5i4vVdi24h01Rp+cyvMv0MpQal11aGwjwLaC1LfjQCb/NRBGq
 9LfGS/5apvMdOw87EMpIibTVzdZbDyWbr9iZaPJEjKQoZ2bS1ukRhZpZTklZw4wpDjjg
 GLfNaPD8ryYJKvHrazdN1mYK9Kcs2aV5mwbaM9fcM9Dr8VJyZastkIWhkWNv3mR8SKwZ
 e8ckii1Ar4tqx7JJNDjnO3TTkb8Hlg50BosYiSKasyDSh+NkW7Rq/XUiTHxLEzZlOpWK
 tUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235677; x=1688827677;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1LxiprAMfv99QQZF3YfA8LciqY6LYeOX4vWz5dtCvuY=;
 b=Zll+WmHiNdNkCVcR/PtXZDyvKiHs+Q6BTlHr5J62sYuvqu7wH+VAQ18AvVSXGBCo5I
 hRyIrux/vRuvX6A3uACS8dl6vvJWSwNJFA+3ZeAp1nQpJOrMKvNXwpU8j88tnsWS4rel
 DaWPtgmUWsUeGhQNreymAX19lznTlGrwurugWSzGjsfsbBz9WZfr5nQiTQKN2EPu7+y+
 0XOUDFYxKTy4bEcAY1yJ5/VUPJup7OlRRwZeq1OYGyO5+RW/VjaLSEUyaPQqmw96q1Tk
 EOqTTg6WIvOfpPAyZTusZBG5iT8KXrrG5dZBzdBvWhm+x1BrjwNOLYT9IzKM/xc64qpt
 OJlA==
X-Gm-Message-State: AC+VfDwjxlwAfJmQ4o7S9eXaVBv7u6zfYn4WqmF7BhWlbCOK3nEyfG53
 zS4SYCi3C8+Rqsk2PcgpXwGTfKEpfoQgtHNAkxE=
X-Google-Smtp-Source: ACHHUZ7brGfY/UfzOm0TR8NYzbJMEibXsFGTOUb84WJde01k4zx/0DM0py6yhOeiY4O6XzQIeYVfOA==
X-Received: by 2002:a17:903:18a:b0:1ad:e2b6:d2a0 with SMTP id
 z10-20020a170903018a00b001ade2b6d2a0mr2660842plg.11.1686235676808; 
 Thu, 08 Jun 2023 07:47:56 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:1ac8:15fb:bc3f:9b00?
 ([2602:ae:1598:4c01:1ac8:15fb:bc3f:9b00])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a170902ea0b00b001b045c9abd2sm1538339plg.143.2023.06.08.07.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jun 2023 07:47:56 -0700 (PDT)
Message-ID: <487dab07-1790-e7b6-79ea-f75a1627c1f0@linaro.org>
Date: Thu, 8 Jun 2023 07:47:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/6] tricore queue
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230607162440.7807-1-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230607162440.7807-1-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 6/7/23 09:24, Bastian Koppelmann wrote:
> The following changes since commit f5e6786de4815751b0a3d2235c760361f228ea48:
> 
>    Merge tag 'pull-target-arm-20230606' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-06-06 12:11:34 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/bkoppelmann/qemu.git  tags/pull-tricore-20230607
> 
> for you to fetch changes up to e926c94171ae37397c8c4b54cef60e5c7ebbf243:
> 
>    tests/tcg/tricore: Add recursion test for CSAs (2023-06-07 18:20:51 +0200)
> 
> ----------------------------------------------------------------
> - Refactor PCXI/ICR field handling in newer ISA versions
> - Add simple tests written in C

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


