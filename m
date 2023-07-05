Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DFD748EF2
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH97F-0001GR-RK; Wed, 05 Jul 2023 16:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH97D-0001FK-LW
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:28:43 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH97B-0002eA-MC
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:28:43 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so2160374a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 13:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688588920; x=1691180920;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tBj9BjVeAr5t0UAlpEDu1ptJX5VNhfpFxraP19vEluA=;
 b=fCaPLC2EArZFnRNGhQuvLcOpG5MgnQGpn7SAa3hpg/LYJpxttRKa9mLmBlouoIdP9L
 82T6w3LeYYFdbSM4Unbae4maNifOV9r06LjBfvnm/OSmGpTR83RWrOX2vMnHFRd6M0xj
 E5/mXefs68E3HuoF9wvTVjy7b6u+8EFwwFPzKPfS6fYtaBXuw547BZ9n+8EiKm6jGeRr
 Ma5CKpgfte8iBIp5cnZEEvSsRutOSiivB4Vhx6RxKRqZGPLI8B+L22tXr4w3A2b4SLim
 BC+rF7UpQZ2sVQT09gKepGJnQqVVnkpq3wEZ/gYh2HJ8qKbrP9rHHO5Ei2Ge2j7KBdWC
 py/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688588920; x=1691180920;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tBj9BjVeAr5t0UAlpEDu1ptJX5VNhfpFxraP19vEluA=;
 b=a6W4XSOMakm8oMPFrZc80Oyq9+I63MknZsYPgCYVFLEdvUSTZYuiObRj63WSLwR0Ug
 rOQA3MVx4MuYPz6w+LiMrUIFiBFzaDsys5bn5lHQmlxJ4x7fxLClnqpBmp4YHTLHic3g
 uMZmsE2TSvhGZkdReHgIIzqeCJNUqoV1ejQGmLiW9Ayud1bqY5j8YRJHU6WQBlsm8enC
 l2iPpokWe0F9rwJ5lPdbU/NWz4U/pf0koc/xgX52Q2n6AOKbyZQ5vtVUzlGl7JS/iWLP
 Wx0xDX5AMPPJCoSouMbUh/eSZCinUgDywy76SSzFmUSpAwuLBdP4+hqe04nCtySjW1fw
 ZwPg==
X-Gm-Message-State: ABy/qLavrYjN0sZ1CdTLXH+AKyh1AO4hk5DvrfxaCs0EFvxkN9O5PW17
 Wuy2nzL6HhQNbTs+z2gEBAtC7g==
X-Google-Smtp-Source: APBJJlG83Gb431/+tAmdoiCIe5JSFFS83TjD7atqNFY3k3yfx1lsQzo+IR0fPg+Fv32ApjPsbjsgYA==
X-Received: by 2002:a17:906:7a11:b0:991:d883:3df9 with SMTP id
 d17-20020a1709067a1100b00991d8833df9mr195028ejo.21.1688588920098; 
 Wed, 05 Jul 2023 13:28:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a1709064a8f00b00993017b64a8sm7067000eju.224.2023.07.05.13.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 13:28:39 -0700 (PDT)
Message-ID: <53a13ed9-3e10-497b-ad3f-73f201bd9b62@linaro.org>
Date: Wed, 5 Jul 2023 22:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 13/14] ppc440_pcix: Don't use iomem for regs
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688586835.git.balaton@eik.bme.hu>
 <3def68f200edd4540393d6b3b03baabe15d649f2.1688586835.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <3def68f200edd4540393d6b3b03baabe15d649f2.1688586835.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/7/23 22:12, BALATON Zoltan wrote:
> The iomem memory region is better used for the PCI IO space but
> currently used for registers. Stop using it for that to allow this to
> be cleaned up in the next patch.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_pcix.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



