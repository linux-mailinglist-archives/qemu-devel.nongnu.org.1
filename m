Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9923D7A03D2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglQc-0007ny-KS; Thu, 14 Sep 2023 08:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qglQI-0007kI-S2
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:26:18 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qglQG-0006RV-8N
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:26:18 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9a648f9d8e3so127355266b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694694374; x=1695299174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AJFEHBLkPZAZgUlNe2cLzWBIOLdTGvDgJjEkdDMQrRs=;
 b=GwlNzojFe7nFAufjhxqks77rMeF3dEdmmorarrPvuaPwN8wb6OJAYlmIaEnUUiyG4X
 6Dr39p3yZ1ZR1/dzmWcXu9vA0N1QRNVNmHwSMKUBZHC4WjBJAzly3FbRewoCFR6ZkMf/
 h0p8Z+4u9vghVUse13PkxYTffCM9ewjrLxVvMfCUGlRKOk5vxxJnYneGTYSOVezVwvSr
 YjaXzTEZZDhX4FIuDZOvoRptyjVb2Osi6JovigGTvblViGoF7BQ3eRD/1FUDe6owmfWy
 FO3aUbjZWl3tz/vrD/WbXUclPEvpkUMkRU5e4yfSF4lEcJdAP0/Vndjx0xSk1/0pAD1w
 F5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694694374; x=1695299174;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AJFEHBLkPZAZgUlNe2cLzWBIOLdTGvDgJjEkdDMQrRs=;
 b=NdSR0Z9jsl/hwBDxVImt/XYCMZqipeY3fRwDOgbT+j+ldRrbgyQl+Eam6m1MYk/143
 donEosjUbgpKh+0kDJxZFAuRubR/AaHS87YBQfGAi/cacvcwKmOiqEN9KLM1chaZZVQ5
 CQ7tZYMyE5/4v8ML0z2u+G+Sgw4AUzGSyr6E7UI4Wjda+Shy1CaykuiPvLsFtf3uEtEZ
 RhQZqetWUYECe8wAmFoCdhgOanwM3iUZOTxAMAlJcL9WsFd7h0dYa/Tar0NaaZ9p2AC2
 Z2CdBFQIeiviT5HgHhUvMkNAZQmBLXy3QaWtosQAr6D0XsdVeOJceh1zFTVnBzQsY6XJ
 UDUw==
X-Gm-Message-State: AOJu0YzV2rjpWQjj9CLjjzmfIf83sCMFfZJEHlFxRCTblIcBq1eevW9b
 DN1SJH0TtLEbSlAojRtFwvD7Qw==
X-Google-Smtp-Source: AGHT+IFEkkQ63ZFC9q3Qg0LkPDfZcZ1pwZJB9hHLLGE522m6/6QyIuMp8tda9G9qpK00QiiNT8/kCg==
X-Received: by 2002:a17:907:7816:b0:9a6:572f:597f with SMTP id
 la22-20020a170907781600b009a6572f597fmr4715210ejc.38.1694694373907; 
 Thu, 14 Sep 2023 05:26:13 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 j19-20020a170906411300b009930308425csm932765ejk.31.2023.09.14.05.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 05:26:13 -0700 (PDT)
Message-ID: <1c07cd98-5381-28fd-58bb-d42d3de85a22@linaro.org>
Date: Thu, 14 Sep 2023 14:26:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 3/3] hw/arm/sbsa-ref: use bsa.h for PPI definitions
Content-Language: en-US
To: Leif Lindholm <quic_llindhol@quicinc.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20230914120124.55410-1-quic_llindhol@quicinc.com>
 <20230914120124.55410-4-quic_llindhol@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914120124.55410-4-quic_llindhol@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 14/9/23 14:01, Leif Lindholm wrote:
> Use the private peripheral interrupt definitions from bsa.h instead of
> defining them locally. Refactor to use PPI() to convert from INTID macro
> where necessary.
> 
> Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
> ---
>   hw/arm/sbsa-ref.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


