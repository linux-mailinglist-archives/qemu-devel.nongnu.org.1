Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B4746C5F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbjp-0007V6-9T; Tue, 04 Jul 2023 04:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbjm-0007UJ-Dj
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:50:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbjk-0002aL-SD
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:50:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc587febfso45957175e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688460615; x=1691052615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G8Z48WJ8HwRkbIhsH9UepCUHG0orOmcZXC9zEfvZwso=;
 b=orBPkbUpVsRLapK7gOpIR5KKFfcdTTUAwTLnY1pUTEiGclXDdDZveC4z2AH8U2xe+v
 i0zZvvCDelbiZX7wl3/o1Lw4nC2qYZDeNm4bIYt5NTwTdLU2IaeBPW7KnWCZf7cBm+D6
 93O0P4mCcUIBKk3KkY3CTRTkybGRpPmwVsOefo/ng1xDYve+YhVi7z+ESAuWtSHFX0QZ
 noC0N0pJB8cO9ZUcKDa4R5FvET+XzKcksxuMV5RIX78cZ9CLjGzvIZHZC0rwoFno6vUG
 JYOZAGALvIw7sPQO+W0Y9BF6f56qFTUNGzk6brzzc+bZJQ1+f7XYigdMjIi0cqw+e5rx
 eMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688460615; x=1691052615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G8Z48WJ8HwRkbIhsH9UepCUHG0orOmcZXC9zEfvZwso=;
 b=iGSd+nZEj5pRkdxFxdHSpPnHdZkrFXqi5hg/15Cy5VZq9TLHKcnsDj8cCkpEGi4Ag+
 j5ADdRIP+wtw9q9ZjU7CWS73KwSciY6vWGye4rqopfZct627lRV6BjE0QNJM9xWG/wef
 p9MEwcJEZLeGzrMAkJLf7ulglmZ6qeZ5VFH4VNWDCMALReitI/xiRfJpFL8y7iHhGQlf
 nx79WtmCcszqKJ1ZMZo/gcuqC8CW/pq+DIwhIuuwoscU1V3zC4O/rX7meGiu8rZRrqzA
 3OacySwdaRiVGRx90mm6ItQ73W7XDrQyFnOh1SvCtGhAkll1ZNPyVyZTik8Ojj5GfrJE
 TLtQ==
X-Gm-Message-State: AC+VfDwWbtOCQrmc5YJ2pm1650FeSy6nnX3lqXk5C36Hr3Xnu2GU8TMm
 66uktH9N1/tG87sOqw9VFykwFg==
X-Google-Smtp-Source: ACHHUZ64L1vTf6CfkTO69EBGGGJd8ziK9vEMIzFDPmhQIBFhFDZJrkUJ+8u2OmSEN3Mb/3u6VJQFCA==
X-Received: by 2002:a7b:c7d5:0:b0:3f9:70f:8b99 with SMTP id
 z21-20020a7bc7d5000000b003f9070f8b99mr9670445wmk.7.1688460615272; 
 Tue, 04 Jul 2023 01:50:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fbc0ea491dsm13627472wmc.40.2023.07.04.01.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:50:14 -0700 (PDT)
Message-ID: <19123556-f4fb-e3d4-e321-81405771084a@linaro.org>
Date: Tue, 4 Jul 2023 10:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 04/13] ppc440: Rename local variable in dcr_read_pcie()
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <b5f39dceb537dedabefdf65acc869bf8ae4d19ee.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <b5f39dceb537dedabefdf65acc869bf8ae4d19ee.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 4/7/23 00:02, BALATON Zoltan wrote:
> Rename local variable storing state struct in dcr_read_pcie() for
> brevity and consistency with other functions.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_uc.c | 50 +++++++++++++++++++++++-----------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



