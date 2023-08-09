Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0927764CD
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 18:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTlpb-0007Kx-B8; Wed, 09 Aug 2023 12:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTlpY-0007Is-NN
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:14:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTlpX-0002gt-7O
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:14:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so309575ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691597677; x=1692202477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ReJjrFw/LL76Jafls8LTHEmgAWDDhsPgaPPDQz7kylo=;
 b=zv6DLAronZOCubLg0WLRjElMuXifh4HWyGlP79P58YV+F6x+em6g1vqbOmcwGbPsKb
 ZERgFlZlaeC2q963ozkUAF/+bCoAYZvnpl62eWjLbKkJ43LcksZmvJJ4EmcN3iXh55Td
 BvBYTXD8P5q+yni6b3jkdNdwvGBERwWYRuVw0liwreIZ7qAx1DHTic5nFVW8hRf9QB8v
 ILDUEGMjywc71ISXRUZ4X6vbufNFzugLhQHULi5joiIgGhAX2QMpY8U18IoE+ANBX8NL
 1yWD2k4Oqn/QOB61GVAHxQdzYv9rbAM6Yn+DZSuFkYCyqoe3KYUtzf5PGM0XUoIizWQ4
 wGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691597677; x=1692202477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ReJjrFw/LL76Jafls8LTHEmgAWDDhsPgaPPDQz7kylo=;
 b=WmB/xFjDmasEXHGF34mj8v5/HrWW1+vYVkw7p3F0hXOpN2lbt5avlJT/cPQWzU5L35
 W0eStXSV5P1w4yTJklFlx35QTt9PBSef83O9RxnYPE9FhkTTBk0ijijlHuQXWq688uUu
 xj/ofr3Wwa7fGhJH63EQXxoMPMqwFsvQr97ZCSARLyLvZUil0wzzq/dAjrFof+dhcRI+
 1pA4DaZ3ow1Ji8w1BSClsEPry3JUL343PHwLSBVv15JAO7gAUTIBdUv3mjJIVLAzVvsl
 VL+a3FaPkNPgnVZTVN2NMiK/wqwogqYH0OArxodbcMQi3N6WIAlsL4HsuEtN03rA6VyR
 M/cw==
X-Gm-Message-State: AOJu0YywLbKN7oDLxjsMsw3aE3YuWvv5OIjEPQu7V5r1Q+EEYvIjaC9f
 aDM11vECt51GFy0L6+OZ3HnYFaD69uQa47tMzRM=
X-Google-Smtp-Source: AGHT+IFijC3GK1kGZgq15eNau15298ZxqVRSvFs9P0Mpb1WjGuifzOkZo+H3IE/T58KxvKuBxiMR0g==
X-Received: by 2002:a17:902:eed2:b0:1bb:3a7:6af7 with SMTP id
 h18-20020a170902eed200b001bb03a76af7mr2908983plb.23.1691597677638; 
 Wed, 09 Aug 2023 09:14:37 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a170902d48700b001bb9b87ac95sm11399480plg.103.2023.08.09.09.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 09:14:37 -0700 (PDT)
Message-ID: <7bebed42-a081-c2d8-d931-9a12e7258d63@linaro.org>
Date: Wed, 9 Aug 2023 09:14:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v4 05/11] linux-user/elfload: Add support for parsing
 symbols of native libraries.
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-6-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808141739.3110740-6-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 8/8/23 07:17, Yeqi Fu wrote:
> This commit addresses the need to parse symbols of native libraries.
> The base address of a shared library is determined by the dynamic
> linker. To simplify the process, we focus on the last three digits,
> which reside within the same page and remain unaffected by the base
> address.
> 
> Signed-off-by: Yeqi Fu<fufuyqqqqqq@gmail.com>
> ---
>   linux-user/elfload.c | 85 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 80 insertions(+), 5 deletions(-)

I'm not keen on this.  I would much prefer the native library to be self-contained and not 
rely on symbols in this fashion.


r~

