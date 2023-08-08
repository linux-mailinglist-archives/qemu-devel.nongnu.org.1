Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679A774CFA
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:23:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUAn-000593-5o; Tue, 08 Aug 2023 17:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUAk-00058h-6f
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:23:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUAi-0000U9-Q5
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:23:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc1c1c68e2so39621835ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691529799; x=1692134599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ba/s4iYLccxde7+EzUXOZWgin7Rci/d7o1AdUZu8970=;
 b=cEwC2d8zsbbZPjwvbrJ1p/Odo7xSKXyRf885ixmyOZLFfy+ibB+4d2T7y2BTl5xCDr
 D6eGfJXXAQDQ5LX2mYz/GeF3jRA4uH7ans3OTYMcrV34ZoQWtoouDsNZUS9dlN93987t
 HLS5p9DDtlIq5AucqK3qXX3SJAaKQG9CYoiB2aI4TSG8sEv2C+MtlV2IcPInukhVu59g
 GxidJtqrAXu40w/eW2Ac52sSAQTT5Ga069AIS1Ott9V+LVQ2D0pnAASl+IhmnwcTUF28
 f3+q/cSvSLG50GREMzPxgj0WuSY+NJfumR5DCL8K9y80sBCnVBRry1csBPAAPuhVXH0o
 H6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529799; x=1692134599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ba/s4iYLccxde7+EzUXOZWgin7Rci/d7o1AdUZu8970=;
 b=IPiyS2/eNNVBwBPUZDAxb3XjnueX5yY17fqt8Ys7S8rFcEfeFz2w/w/vQROR6INxTC
 leAEcXgCMNAbcGJatOITAU0hk4DEmo66pbGPxAYNWj9lWVBqupMkeg4pzdmZ7JGOo81B
 9qgJ404mu1anPug2zIFYDYobZMxtcPLCk3g5OXgstvAquOPb96y38tcivso9IFibI5+G
 PvXoBNieyqO2K1TvQXgYHgG1uvWBbJMGxKHAlmIBS1dC9uDNRiTfl+AxtLZdjgob5BA8
 6sHn6ACy4UFXREgByR7oBoiOPbmoLF9sQYop3ynCALVThu3oqlCIhVvR8IND45C0eGR/
 m4Xw==
X-Gm-Message-State: AOJu0Yw4qJS7W2bRUU/V59256fgZn95UOjrxOdabN6672EwKfEc6e51I
 z01rJfCQb81/DLNnZM7yNTyvcA==
X-Google-Smtp-Source: AGHT+IHP8FEwgU6tXWafA0aA8Fh0MWzGczl4mn989pXDDseo4K/AZ83wjHw56WtYG9xePJ2r/SaIoQ==
X-Received: by 2002:a17:903:1cb:b0:1b8:9044:9ede with SMTP id
 e11-20020a17090301cb00b001b890449edemr1000166plh.62.1691529799157; 
 Tue, 08 Aug 2023 14:23:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001b8b2fb52d4sm9457582plh.203.2023.08.08.14.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:23:18 -0700 (PDT)
Message-ID: <05c85989-b7b3-572a-57b5-3e9c68de52fd@linaro.org>
Date: Tue, 8 Aug 2023 14:23:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/33] Add struct target_freebsd11_stat to
 bsd-user/syscall_defs
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-7-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-7-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/7/23 23:07, Karim Taha wrote:
> +    uint32_t   st_flags;    /* user defined flags for file */
> +    __uint32_t st_gen;      /* file generation number */
> +    __int32_t  st_lspare;

Oh, drop the __ types.


r~

