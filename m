Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B004C72A362
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 21:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7i6d-0004wR-HA; Fri, 09 Jun 2023 15:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7i6X-0004vN-Tz
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:49:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7i6S-00011P-JM
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:49:00 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b24eba185cso9779165ad.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686340135; x=1688932135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1gGVdbMQGaYb5uaHCOOcdB3rUi92fHQh5O9tvdZ01vU=;
 b=QNWSmNfLY06lwCgYj1CTbg3OrmGqXHK0LX8cDNz6O4VXhk71xdEvSoQuJ47vUA0nYD
 rC9fyQUraCGL9J1Ud8X1/+XHRzq6CrHFtjzp12tOTSW7zyCSH/Wn05eDoEBhiYHGnZSl
 zgmwcaKenHlk9npaDXkISBaYXhosd7ZjFxZ/ksaz9p7sUd2tYT92k9ZPNe8rWHBdulqC
 mgQRpvThop//XhxaDeApOBPFuQOYmhrmelNwUSLVBuCNyQTcvDz1PcZuRoynh1z/FZFW
 WZ9+/K9hKfe60mFdXPmhI/xMAAOV0BiHf770NIBY9fN8mB4W1W7fUw74mQCtXlrLPb13
 Hi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686340135; x=1688932135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1gGVdbMQGaYb5uaHCOOcdB3rUi92fHQh5O9tvdZ01vU=;
 b=WO9HNUru/p5aTvo7hBVyHjcrQZVfsJCd/0z1FF7P1L36n6pKlnFSyS1C8rNB4L8zdJ
 fhetkamWhBJsFnvqNx/HpTcE5VtJHaAHZPvUS1UbdEF+aUZBhEZDeCi950ZLXloXWoEl
 G7+HmkVk7XsdllYzVOD4+cT9SJaAjcArfbPtNd0ciZ+6emVh6uPVKGz2yqkBA1ThCDXP
 fhgZWp5CqNp7LvPoi+2HYWsCZYyi2aLPAxbZhuVDDzfrs/n9Uj0hwROJREtvFA7dUGqH
 PwDqrctZSPRQSNn8pAIfbCWOcVLZdjjBe0W7SG68f+sV/GpcgA9c5klnbZUK1b97h6kI
 Xq1Q==
X-Gm-Message-State: AC+VfDyS0om2UFwIZhAVL6szVUETOruxSPFVv6Vb3XuKJ4/yu13/0NuC
 cz10zf4+0SuQjUgOVb1OTNStLw==
X-Google-Smtp-Source: ACHHUZ6o1l35xyaSE1WBOJDHwtNFLAQM8sQR/7CE1inKG/0DfM3x4OyRrQLODFKJwr70MM8OI9Ks6g==
X-Received: by 2002:a17:903:2344:b0:1b1:93f9:4305 with SMTP id
 c4-20020a170903234400b001b193f94305mr2235478plh.60.1686340135115; 
 Fri, 09 Jun 2023 12:48:55 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a170902d2ca00b001b03c225c0asm3624075plc.221.2023.06.09.12.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 12:48:54 -0700 (PDT)
Message-ID: <fc2d01f9-b624-7678-4da1-09dc7cfb1205@linaro.org>
Date: Fri, 9 Jun 2023 12:48:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 15/22] target/arm/tcg: Extract SVE2 definitions to
 'helper-sve.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
> helper.h is used by all units, but not all require the
> SVE2 definitions. We already have helper-sve.h.inc for
> SVE* definitions, move them there. The next commit will
> remove it from the common helper.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h             | 46 ---------------------------------
>   target/arm/tcg/helper-sve.h.inc | 46 +++++++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+), 46 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

