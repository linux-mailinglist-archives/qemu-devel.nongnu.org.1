Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D737B2793
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 23:34:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlyeO-00070w-7H; Thu, 28 Sep 2023 17:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyeG-000706-2g
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:34:16 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyeE-0005Bc-Fj
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:34:15 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-584a761b301so5116667a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695936852; x=1696541652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=svOpPq3uO1beUhLYTmN3FevoP/Yh4F1OE/oyUV5WRnc=;
 b=Tx1SvhBR5rHvACqlcIwsI0aAulFKnnMart002MTksjpaq5Vy4qVTTHX201Qovh3nbt
 L6JxflOs9hDXQJHerXe6ZGx0PghcyNznmSv2y87JAREGQJodLiED55oT2z1EyGzmCutn
 /HvJsaV/911fDF9ho9tErLuL5zVCIY8TIr4R0ufpICNa2nyHxbmLMgJzxA9TFpRmIwlt
 kP5gXJ4d+UMF795uwfzpdyWl/Y6w822hmg4QQIHkVQSjijhxZAM3iLVt687QpzGVLKWI
 5V5AyidgL18NqlXBy5WSrufNseFGQ+3Y4thlHBgU6njvASTtXoI97CVuW2Gi9RFjFIyX
 hygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695936852; x=1696541652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=svOpPq3uO1beUhLYTmN3FevoP/Yh4F1OE/oyUV5WRnc=;
 b=s3Hhzv3aI/2wVrg4CUQ2KQtqOgu5l8yDS6IjjJ0c0zMeggO8767EaSmk/uWr0vLUjm
 JBcXXr8jI6jv44FE567H2LARkKuBwFL1XKxKm8btk6aSv6chUHfeqksqnzIvGC92Gu1R
 Rvnqu9DfSNc8aEfom7cW2nHa/f9iSmbwvALOMzfk2kiwvt//NRUHFxSu1tD5K7SZZQkC
 euytTEMjWk2h4NLN8lQRcoP3b/YbHexqjZGLqjnBWAAOvek5sf6ixxE+VTXyoMrH2FiM
 ncZz1MuZnS9+fIs+Y3lqYy577g1JFbGW9RC113y6gj4FUj+e6sK34GsirbTHOPHB9aBh
 7d/Q==
X-Gm-Message-State: AOJu0Ywp02NoRRhlEzJmPDCxABVQRCecszg6TcdkZyNmZK4rvS3Or4an
 /2Y/UKZi8sCnYlCvLrFEtfuj/w==
X-Google-Smtp-Source: AGHT+IEPFCDARO3/zclCqKiRROifrJuI/V35pcdvB8h8CJ4LURwSb7HxHtkTgZgD2H0T4VsjwujNmg==
X-Received: by 2002:a05:6a21:47ca:b0:15d:ad11:748 with SMTP id
 as10-20020a056a2147ca00b0015dad110748mr2050863pzc.30.1695936852641; 
 Thu, 28 Sep 2023 14:34:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 14-20020a17090a19ce00b00277371fd346sm14214pjj.30.2023.09.28.14.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 14:34:12 -0700 (PDT)
Message-ID: <70be6521-1f1b-2693-2d6c-bc8f898d770b@linaro.org>
Date: Thu, 28 Sep 2023 14:34:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/8] target/sparc: Fix VIS fmuld8ulx16 instruction.
Content-Language: en-US
To: Nick Bowler <nbowler@draconx.ca>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-6-nbowler@draconx.ca>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230925050545.30912-6-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/24/23 01:03, Nick Bowler wrote:
> On a real UltraSparc II, the fmuld8ulx16 instruction takes two single-
> precision input operands and returns a double-precision result.
> 
> However, the emulation is taking two double-precision input operands,
> which are unlikely to contain the correct values, so the results are
> garbage in most cases.  Even if the inputs happen to be correct, the
> emulator is rounding the output, which the real processor does not do.
> 
> Signed-off-by: Nick Bowler<nbowler@draconx.ca>
> ---
>   target/sparc/helper.h     |  2 +-
>   target/sparc/translate.c  |  2 +-
>   target/sparc/vis_helper.c | 17 +++++++----------
>   3 files changed, 9 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

