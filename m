Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE90A775150
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 05:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZhF-0006bz-FL; Tue, 08 Aug 2023 23:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTZhE-0006bd-6C
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:17:16 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTZhC-0004KN-Ly
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:17:15 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2680eee423aso3345714a91.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691551033; x=1692155833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AIpDuRlgkbVfu+ZrXS9b8+ta5q+xX9IIvCnBqma4lbY=;
 b=PeQDdcfUa/A5limGTEJ/qN2idFjlkKrEUmaj2yvAiYr+pWchsPmYlyPvTRhAR5t4gQ
 fRJhGBPeSofnWJUGKeOewwg+0IcOG8tmjaXxk/BQ7l6yfOteVN1subCT3nwQaU781CqY
 KynNYDoF0Uz0QwNmeFaa2GBC/eOGAeCJEZaL8Iz1GIpxnCb1w0dU3Lj2Xr/VfCyjG8oK
 nZHGUT4RPBrJKm7F0FN9v17VLeXn28irTOPGMwOW4K3e6rRg1DPSfK99D7KyRS/k+bHn
 qoRBhGQ57//rXI3kXqQm+FeJUdq2XHaFbcz2Evv0I73a4wDUSTZ23NFNBcO+ewFom4Nh
 KQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691551033; x=1692155833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AIpDuRlgkbVfu+ZrXS9b8+ta5q+xX9IIvCnBqma4lbY=;
 b=lMxT0oIqw1b3JrXftxe/6ac+d+eZQscqbmwo5gahg7o+eic47hPG0zjZOuDqAj7em/
 fqGiJyanekLOSeww4xYsrAe270eHf6PP0mV7aqLOmNlKVZKRXiDyUoIGajMOFUsB1N4T
 7gIZ8w1GJuX/EBE9U2KKJeTnSYaCxxOHCIBx/pUHXZmKb3NKsfDW2+CrN+ZLKwQ/jTXQ
 ZgM2lPatgZomN8MLQ+Dr/b6iRK+FJlitlsCxIAryBXNAkH9JcCHZwtDm9Ky69gYdrl9v
 E6HatTLU3pHlVPcz/80NZut45A1Zw7Zq2pbTSW/OQFHyn0OyMf/KpGWxYh/SiDmbNrCW
 HC5g==
X-Gm-Message-State: AOJu0YzyjaVOpmTeT68jsRK6UcUdzNDuhfKsXSDck5gEcrFs1plZp8sa
 J2M3Z4ss6oPsFPJr5QltvqHkwA==
X-Google-Smtp-Source: AGHT+IH75Ljf6fgYn751MdqYukyALpCReT4uLHUAXcSVC09P4Q9W1ltkbdS4k5VJnQtFiFuW4FCJvA==
X-Received: by 2002:a17:90a:c243:b0:268:f45:c10a with SMTP id
 d3-20020a17090ac24300b002680f45c10amr1122405pjx.26.1691551032877; 
 Tue, 08 Aug 2023 20:17:12 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:aef:cddd:11b6:aee3?
 ([2602:47:d483:7301:aef:cddd:11b6:aee3])
 by smtp.gmail.com with ESMTPSA id
 40-20020a17090a0fab00b002680f0f2886sm318938pjz.12.2023.08.08.20.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 20:17:12 -0700 (PDT)
Message-ID: <2265f57d-a277-5748-ce41-cade93db8a84@linaro.org>
Date: Tue, 8 Aug 2023 20:17:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 18/33] Implement stat related syscalls
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org,
 Stacey Son <sson@freebsd.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-19-kariem.taha2.7@gmail.com>
 <ebc5c562-205e-5a1a-6b3e-381b8c022b26@linaro.org>
 <CANCZdfrZSF1cxTPYa-ec1rMqjC9cDVOR148qUG=g=S1MXh34Wg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfrZSF1cxTPYa-ec1rMqjC9cDVOR148qUG=g=S1MXh34Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 20:07, Warner Losh wrote:
> So, that's kinda why. I do agree with you that that would be a better structure, but
> can we use this structure for upstreaming and once we get the other issues worked
> out, we can do a restructure... We've moved things around a bit, and I'm also waiting
> for the NetBSD folks that contacted me to finish their efforts before I pull the rug out
> from them (or they timeout, which isn't quite yet).

Yes, that's fine.  I understand the pain.

In which case have a

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

for patches 18-33.  My only quibble with all of them related to this.


r~

