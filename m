Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811374954A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 08:05:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHI6n-0005by-Kk; Thu, 06 Jul 2023 02:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHI6l-0005bK-EP
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 02:04:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHI6h-0002CR-4w
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 02:04:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso4142625e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 23:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688623485; x=1691215485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NwpC2M24SYiuyJQvrrBQv4f7tOcLZEDlmTf397A0u60=;
 b=L7GUClRIj6filCRfSXcV7grvorDJZASvavAMblC8V8UqLVqgftoMlTVqh1zYfL9L4B
 xg8BYTl2cGoqQbObq75IUblbnTPE5h5jaCDmhU5VUNsa12/oKe7oeHYOp3wqFgcW476m
 b05TRA6Et1ilv8FN9L0xvwRlJHYn2j+MHoY592ZCgTX4efTat0HDLyJc4XeVy3/fd+Gy
 tytZNfisici+tP+tKxNbwJvSY0BH5Zc7xhKbjBYR/iR8JZ1/yHP7R/smilSGWunWHCzM
 mDY+Yaselcmi0AfdZEcm2QZ8oDqXx8u9lqpx3+HP3ASWyNx6APeqWeLfQMaqd/mHe3JS
 EGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688623485; x=1691215485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NwpC2M24SYiuyJQvrrBQv4f7tOcLZEDlmTf397A0u60=;
 b=LEJ5FPHG40H31zNx1wyozl+OWBlr6E5kpsYUs670p3L6pafxP76P9J6kEmzEcE++MO
 1AbFySjhLLFECSN7JH7ng+LHyj58fcbzkqTXMXCJBN2ZY/v7A+Vplm8i7adFImKOmW2P
 K3FTu3e0yXTNfvYFjpCNdm7SlLwW8XcwkW4frp+YMyQjcg/KrUdQjlXtxiZYguxCLh72
 xO+IjoWf0g2WKlrQyRSV4plsKQ7SPhSlBMdjMXk7G0Zz0Vd3fa/bbhqde6L65AZeg8En
 ImTfVTcMC/kB9dWFa96k7rlw9Md7Q1HlPj4glG4LIQm/3JmX9isvi5gHTARTVNKdeAla
 YZkA==
X-Gm-Message-State: ABy/qLae7x3Guoy67tTgT81IVeJA5/ZXpY+/YlhAtNTPINvIPd1jH/yK
 dgQHZ/MfwuStFb/oeJdwRDO7pg==
X-Google-Smtp-Source: APBJJlHeCQ1YRYeiTD4i9KAbScyVwCSSsWmd+NROSdrUShAIn+hsS4e6YjuxxnJ8SmQU9uHNkn9ZZg==
X-Received: by 2002:a05:600c:b43:b0:3fb:4053:a9d5 with SMTP id
 k3-20020a05600c0b4300b003fb4053a9d5mr1105660wmr.25.1688623485220; 
 Wed, 05 Jul 2023 23:04:45 -0700 (PDT)
Received: from [192.168.45.155] ([95.152.217.99])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a7bcc87000000b003fbb8c7c799sm4043590wma.30.2023.07.05.23.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 23:04:44 -0700 (PDT)
Message-ID: <aa1861d4-cd38-3733-c1c9-d486198c0b3c@linaro.org>
Date: Thu, 6 Jul 2023 07:04:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>
References: <20230704152932.194790-1-stefanha@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704152932.194790-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 7/4/23 16:29, Stefan Hajnoczi wrote:
> The following changes since commit d145c0da22cde391d8c6672d33146ce306e8bf75:
> 
>    Merge tag 'pull-tcg-20230701' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-07-01 08:55:37 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git  tags/block-pull-request
> 
> for you to fetch changes up to c21eae1ccc782440f320accb6f90c66cb8f45ee9:
> 
>    block/blkio: fix module_block.py parsing (2023-07-04 17:28:25 +0200)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Fix --enable-modules with the blkio block driver.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


