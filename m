Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E442C7D78A1
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:35:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnOp-0001GD-7M; Wed, 25 Oct 2023 19:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnOm-0001FR-Sb
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:34:52 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnOl-00075E-9U
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:34:52 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5aaebfac4b0so270942a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698276887; x=1698881687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FKu6u176FAIiet0JVCdUgtMTkmUZTJlOqoN+FCqOz5Y=;
 b=Y4ALA8+rIVYDysx+NMNF7W2eZA/NMN5pYPdWCH616JKLn7zHUb+GlH7TcDrE7iHM+g
 ZpxceCnrUPNiBzFsEpBLVBgL4c80RCok18i5T6DS4KRiV+AjozzaX3zElSWt+l54uMj3
 9jfuyofm1Qaq8JXQwXlCJGRylnA+PnF8bBxtJHlzr+mWMiXxGK5z5uov+jTJESFpNept
 FU4JdnQemygRH0uoDnXAWoKvG06AOSg31a0n4LBTm1887tBM1BvdO9vEYs8AJba5GmNk
 50jJJTqLVtQ5IIo6jgTnXqpM9NMh6Hh+XdEFV0gNSlXharIDK+4D/4rHl/qQfMRICNz+
 fZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276887; x=1698881687;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FKu6u176FAIiet0JVCdUgtMTkmUZTJlOqoN+FCqOz5Y=;
 b=FQyV4FPHHuVAm8M614A5CQNJzVTuiBgGVEMsA/z0czRGfB4x160KQfJpVaDynr6VKG
 yUlSBtW2lt21kzvDYfmqQPLtYuNiEPaD1MVqbdRMQ7iW6WIOIjIdik2xGSTTAksWBEdG
 QU/psyL1owQnR8Y3UjTQQ+ag0wbsYi2E+t6N0wA9Zm1guBhyeGi2IBxRmd1sSUzUZO3T
 ASKDKg6k1nAmEKXYbbEGc+7A5DoiA2glBZ9IW3HxKyhQMeL47X9ndZ+uFuUb5fxVGQka
 JWUF+fGEvHBG8mSkdssg7h3b0ukDxzkr4zcRQga8V/02+RIERkwJmeo0CKmd7+d1C59G
 2iyA==
X-Gm-Message-State: AOJu0Yw6Ku84xRaEan7tjSepVi+l1DjCG7WJKSUYUc8vBc4Bl0Dp0DN7
 4/HEOJhBRWhy8u7feXMsFV+5eg==
X-Google-Smtp-Source: AGHT+IEiUqEGRAnGnudjFbyA+NhtVWnwlaFFIehPULyCdlowN1cuUg28YfqClaguYUFfsUfCZ+0DMw==
X-Received: by 2002:a17:90b:1dc4:b0:27d:882f:e6cd with SMTP id
 pd4-20020a17090b1dc400b0027d882fe6cdmr13459214pjb.44.1698276887498; 
 Wed, 25 Oct 2023 16:34:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a17090a6b8500b00277371fd346sm475304pjj.30.2023.10.25.16.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 16:34:47 -0700 (PDT)
Message-ID: <5632a3ba-78e5-4e7a-b21d-a2079ec72aea@linaro.org>
Date: Wed, 25 Oct 2023 16:34:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/arm: Move feature test functions to their own
 header
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231024163510.2972081-1-peter.maydell@linaro.org>
 <20231024163510.2972081-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231024163510.2972081-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/24/23 09:35, Peter Maydell wrote:
> The feature test functions isar_feature_*() now take up nearly
> a thousand lines in target/arm/cpu.h. This header file is included
> by a lot of source files, most of which don't need these functions.
> Move the feature test functions to their own header file.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

