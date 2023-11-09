Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F2B7E7213
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:15:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AV2-0004Ia-R4; Thu, 09 Nov 2023 14:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AUV-0004AH-Ry
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:15:02 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AUS-0002H4-AL
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:14:57 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso1946420a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699557294; x=1700162094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ezrSB8etlnV+V1rA5c4ZdIsdgmX4qrXOWddJoZd1qc=;
 b=klGpeJAf9aemL4CYnuQJJ7oa27sAuJ7H+dKJptTAardd5dge6rsy7me9R8HY88Fuwe
 M/G40AnYlC0Sg5Wo3HZKGqbiutR3ksAlvH24m6tFUwgymmgSzM3KCImNo/BZKJPA24xl
 No8mnr8e1MV+Z8slfSvHh11MSsvobpM7DVxOr/uiQsI1REN/mRVPfeWnSXF7AkGiHOou
 E4eKSZcSbZomiqgXNn1uQD4vvkn5mAy7MMFZ8Yo2Gm0RaCHpHgmRBQB0Shuf+bnidyL1
 pb9jFaEZ0S+zPSxTZejlmnbmGH+cb42WR6KCAxxp4s0yjcLDhkZMrAQum3YPrz98zji5
 4NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699557294; x=1700162094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ezrSB8etlnV+V1rA5c4ZdIsdgmX4qrXOWddJoZd1qc=;
 b=j/glpoc7x77Lb3ZCnJnjBCp44rtNURG7gay3TYNpaoteQtzbzuv4zuFHJGJnSVnJ0I
 82p2WYvqhVvr/WUPQG3a2/Uqq28iO3O20u4uk2IihNvE5BSfjpME91D3KE+VEg3ZiIqy
 Wkhuh80HOkdUOquNLcDs90KZPu9Ck5zUw4waygHDTmrreEfvdY6l6hhqVSTjRNPslQxx
 PrENwLfA2c7qj8/IHLpVhCMa5kbhlkIzJbR8kTrlazu1BwXJwe9Igw/0WaDnoY4d94IH
 84EDlECUYsMjivy2vTQ+Q+ZbXqEm/JTFR4WTCkaSggzhfV0k4bXoxyca1KoPl+mXxQcF
 CbUA==
X-Gm-Message-State: AOJu0YzU6dGnMg1HMCmFTrjw4I97VK6/spkdyln7kGu6KKE8DIrXlJPX
 GmFRzN8QScFknEESpJ7RLnFy/A==
X-Google-Smtp-Source: AGHT+IEIQgcfDOyQYMgrUyCgrkQ49suIzldL1bXHOocXDncUy0pSHoCrY6J5GwERvAv5Pmse9PXmrg==
X-Received: by 2002:a50:d507:0:b0:53e:6d33:3c94 with SMTP id
 u7-20020a50d507000000b0053e6d333c94mr5283512edi.10.1699557294344; 
 Thu, 09 Nov 2023 11:14:54 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a056402516400b0052febc781bfsm166756ede.36.2023.11.09.11.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 11:14:54 -0800 (PST)
Message-ID: <590c5076-034f-456a-ae8a-a10090b91a34@linaro.org>
Date: Thu, 9 Nov 2023 20:14:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] qdev: Make array properties user accessible again
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com
References: <20231109174240.72376-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109174240.72376-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Kevin,

On 9/11/23 18:42, Kevin Wolf wrote:
> Array properties have been inaccessible since commit f3558b1b both on
> the command line and in QMP. This series reworks them so that they are
> made accessible again in these external interfaces, this time as JSON
> lists. See patch 11 for details.

This justifies getting this merged for v8.2, right?

