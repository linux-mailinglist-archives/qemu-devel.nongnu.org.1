Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D9979D1C8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:10:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg38i-0002aQ-50; Tue, 12 Sep 2023 09:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg38c-0002ZG-BU
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:09:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg38Y-0003Tq-SD
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:09:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40061928e5aso63802545e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694524140; x=1695128940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vDbR0dDAWNI06kvkIawHO1H4PQm7Igpv7Hr2LCVZIDg=;
 b=zPs2FP0nwVCy8fvEAhU5euE77XTlRsVfP7/eJ9ZMxGCn5dy/0iylCYcc9xqhMrJkrx
 57It5qzEaTGXh2bZfOCIOtS+lgk4f/5vqFfV0vQ/JWvuqoQKRpGB9UFYV5l5pfab6Ynx
 /VfDp3OqQyRkZQZ9V5Z/89aa4L8xmeMVturMMRL/Vfy4tbONPMCNiZY8vyy9c3CtyG9E
 1GqzHa3f9WKZGPIiDP1ddQgr4LVzaYZBGo85GdF8U2KTLQqXmDY/bkeJYNYRJ5iF+uFu
 aSu+fLjZu+L17nvxl/M//s2hapRFSDW2uHqmAKJJs5otMtIKezn6Yy1EdR6qBHLO3FcV
 MTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694524140; x=1695128940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vDbR0dDAWNI06kvkIawHO1H4PQm7Igpv7Hr2LCVZIDg=;
 b=UaaDiDtI61WFfc/IGDPf2ZuH1jFdfiKLPyWeHUaNKGdOSaFZTej6N/Y3EmSIReG2HL
 ppou1/lMXP9KjorQFhdTs27Hp3pstNT6hJJdI8dQ11tWSXgl4Ks6nQTsBqxNzyjiTbcN
 rv1pH6pPQZ5SdDLvS84PcRMW6PPK9XUkFQSXtvC2aM6YfPF5/W7RnoGujhuTxs5Mdsls
 mEMhomo1neJOSPNYIdFmg+XfikAUVrYDOX/2Ng9bWQgok6ryMzdzd5EehAbD9naUD6WX
 uTJliYyiR16ykwhmbUkwzIv1GJlSudVPDf9AyVBc8OJXd7s9lTstEL7e2+nX0lOb9vKQ
 aDdQ==
X-Gm-Message-State: AOJu0Yy0YrJ3gIEgdINziIaHZefVwAErZwOTTGO3SGgimg9xlxQTt1mo
 AdOZnhFcHUwrr2zRh0fYzbz6oA==
X-Google-Smtp-Source: AGHT+IEr3lYZgB9ZBUBSiRKnuc978M7yGRVKQ3dOmwy2FRtMtNP7jo+3z5EYlPpzt+m8mSEIYgH9QA==
X-Received: by 2002:a7b:cd17:0:b0:3f6:58ad:ed85 with SMTP id
 f23-20020a7bcd17000000b003f658aded85mr10493223wmj.10.1694524140131; 
 Tue, 12 Sep 2023 06:09:00 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c4f4f00b00403bbe69629sm1901395wmq.31.2023.09.12.06.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 06:08:59 -0700 (PDT)
Message-ID: <3244f20e-f2c8-4b46-0836-c6ac8e748938@linaro.org>
Date: Tue, 12 Sep 2023 15:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] subprojects: Use the correct .git suffix in the
 repository URLs
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230912130237.300014-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230912130237.300014-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/9/23 15:02, Thomas Huth wrote:
> This avoids the warnings à la:
> "warning: redirecting to https://gitlab.com/qemu-project/xyz.git/"
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   subprojects/berkeley-softfloat-3.wrap | 2 +-
>   subprojects/berkeley-testfloat-3.wrap | 2 +-
>   subprojects/slirp.wrap                | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


