Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E771903E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 03:52:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4XTp-0000NA-EF; Wed, 31 May 2023 21:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4XTn-0000Mv-Qd
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4XTm-000176-8X
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685584312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQ8hHw0B9NKxPz9Mswp5pEVW5qc/T1BiYW8WQaYasow=;
 b=KauKARVpTfnev8RA9HPU3yKQoA8QlQhHNoEknbq2mZjZqbakucRkhIs36MW4ICvvBxRehs
 b/FqotLlrn1Deifzit/HT2z3+IXahipEV+klGSut2sNXwVEDQ2eIVGBPGSeGX/weWItQru
 /vzNAUtoX9Celq509026kGFOKnyfdoY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-H8NhyaNgMx2S71TIxpSPvQ-1; Wed, 31 May 2023 21:51:51 -0400
X-MC-Unique: H8NhyaNgMx2S71TIxpSPvQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-513fd7d56c8so250619a12.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 18:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685584309; x=1688176309;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQ8hHw0B9NKxPz9Mswp5pEVW5qc/T1BiYW8WQaYasow=;
 b=gYyrm2aCLLsM2cqZctCpmDiqBY300NYkYHycu+ZvL8q4yastSWXDrpY9Cqk0p1MzJS
 ZqLkn2drgsIeqJ0yvSQ8tiGW91rWzt5hhDqvEuHUCoBKWUDmdZ+joOz7Z6UzyIAvxeHz
 55+d/MHAacT6bH3xlTofKRiee6TjDFA8cLcA38q6s5zxhxrVuZX1MWLhLcExgyoENFVF
 fYTFFs2kEc2k08wGxBuvi5ZloCX/EC1TqGR2C5l+K6yhgT7QGM2DpeOzprCdjYhsk7Nj
 DdkcdSEZAzn8+xxn9haPQrSFOEuTs7A+7nHetZDQbmcfeKWPHi5xkEJY6pFoZhz+msWV
 qmKQ==
X-Gm-Message-State: AC+VfDyS7l3cUHf2oT9syFQRZ3pKWfuAKvfVFCqz95dGVcwJZ5g/p/UX
 30bkrRbto4jLXxV4mYspVolQ9QIOK1U82tGXxxCdoOIRVaQ13nCl2dpOeVkRo6NWyN5MOVo09ih
 AL7FmBOCoCAg90OI=
X-Received: by 2002:a17:907:c0c:b0:93b:5f2:36c with SMTP id
 ga12-20020a1709070c0c00b0093b05f2036cmr7650325ejc.61.1685584309861; 
 Wed, 31 May 2023 18:51:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7EUa7BNcbI150azIxWGPf+pBqXdS4mXxcCyRGAJpxG84IQd2J6X4ts8O1yGyYsxfRGvKFICg==
X-Received: by 2002:a17:907:c0c:b0:93b:5f2:36c with SMTP id
 ga12-20020a1709070c0c00b0093b05f2036cmr7650314ejc.61.1685584309562; 
 Wed, 31 May 2023 18:51:49 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 d24-20020aa7d5d8000000b00510de087302sm6488649eds.47.2023.05.31.18.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 18:51:48 -0700 (PDT)
Message-ID: <731efff0-3230-e3f6-5caa-1b2d1082f266@redhat.com>
Date: Thu, 1 Jun 2023 03:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] decodetree: Add --output-null for meson testing
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531232510.66985-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531232510.66985-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01/06/2023 01.25, Richard Henderson wrote:
> Using "-o /dev/null" fails on Windows.  Rather that working
> around this in meson, add a separate command-line option so
> that we can use python's os.devnull.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Fixes: 656666dc7d1b ("tests/decode: Convert tests to meson")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/decodetree.py    | 18 ++++++++++--------
>   tests/decode/meson.build |  4 ++--
>   2 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



