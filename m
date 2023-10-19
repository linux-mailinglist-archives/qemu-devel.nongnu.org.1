Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A8B7CFF49
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 18:18:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtViI-0004s4-Lq; Thu, 19 Oct 2023 12:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtViG-0004re-SV
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 12:17:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtViF-0002tk-A9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 12:17:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so26495805e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697732249; x=1698337049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gYk4QCu3g6fu7ptIR+Y+ak74EdA9tlsGhp3ow44agnU=;
 b=WQsZs6py1PzXcZAiNyaVncGmvoB0uITS/1289EUKv6N85fJGkA2NYyRIOtrHxKhtOM
 lXJ32gRzbncDJUpZLJmFL0aoJJNfQQMBFFavRA8FBJVqBS3+PKKSy6OKYVWlaoQpDmJw
 Cr57gCWAmWIcLvjXEgotSBVYmc6dWKJZEWLggLdDjCR8UHaUbjQxqkgClcJ0JL1pY2cL
 r6zxLkEDMBbLnntkzwBar1izMAivM8K/KgDSu3JiZ2DXEXNDMU1pNnhhIOc8oJOaOUN5
 X6C+mLxUda3DHjBbDVj53FNQEjwDmpd7lNr6JfUXPWTSRyJgvd707CFjqn/52YVoPW0I
 TzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697732249; x=1698337049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gYk4QCu3g6fu7ptIR+Y+ak74EdA9tlsGhp3ow44agnU=;
 b=HCb+n8JJozSaOUYbzHybuyX4M8WH5V0g57ryiWFBkJy5CTgT4S+A44zjsko2HdUuvf
 7ruZ6UCyqj2eXJ8J4eZ00xXnV+p1r7X9QvPcLyfyQeC30OdklC+fp2XiGaJ+Ll1Ll/hf
 I0OANuMwhGWdvWsSoSKPkImHCkTHQNdxSFXVbs7gnsOf5vdYlaSSM/dTBVkrPsokE6t2
 CbhfbYUzTkv5pB1fI6IOvCumVM4wsyhzSWJO/gx7r1q6eM7J9GRe8U+W2E9Z1CaSybj5
 YLjRpA5IBzf+0fo2J2tDGnpFFr3gxMhTSbw09pagkRbiyMkDWOnlkemLRXa53k85mryT
 o4tw==
X-Gm-Message-State: AOJu0YxJEEzZleE7DxLt6nhI34YpRhL95BztI47foPt+PGhDZl2QFZDs
 X1tlfjPYXEZGSjH4wJONR23yIg==
X-Google-Smtp-Source: AGHT+IGnjYlqFz1TplWyw/flL8Qc+t3rHcvkgJR8eyFD9/avrdO9G+advUmKrJPpxax4UmfKxX82Tw==
X-Received: by 2002:a05:600c:138f:b0:3fe:dcd0:2e32 with SMTP id
 u15-20020a05600c138f00b003fedcd02e32mr2316419wmf.19.1697732249233; 
 Thu, 19 Oct 2023 09:17:29 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 l32-20020a05600c1d2000b00402f713c56esm4892949wms.2.2023.10.19.09.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 09:17:28 -0700 (PDT)
Message-ID: <fd7ab62d-2141-7199-40f6-fb8d3e7c66cf@linaro.org>
Date: Thu, 19 Oct 2023 18:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Fix typo in openpic_kvm.c entry
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20231019155822.499027-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019155822.499027-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 19/10/23 17:58, Thomas Huth wrote:
> It's a .c file, not a header!
> 
> Fixes: ff8cdbbd7e ("MAINTAINERS: Add information for OpenPIC")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



