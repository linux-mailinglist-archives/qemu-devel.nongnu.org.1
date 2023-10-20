Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 134347D119A
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 16:30:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtqVR-0007R9-6S; Fri, 20 Oct 2023 10:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtqVK-0007Qr-Ue
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 10:29:35 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtqVI-000724-VG
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 10:29:34 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ada2e6e75fso135682566b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697812171; x=1698416971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FujUaO+baNB7sA+ben7V/dRMzcEBOoUN4v8JLZvYkDM=;
 b=UkSb2ksL9/8C+l73PxewFhuLr4mzn0L8aXyYuobGK2sv04J7h7sQKHJV9B5wurRn1r
 uXtOE5iHAKCufMC9ktZAw1nK3xeBpJhOHCScc/F4XgHQt54xSbKZZYiPYWMkJzObwqSq
 1JATzxjV39GqW6e3QGcVtRB+k4gbAyoIVsIeXapVwMRb2moQqa6xS2/8iPjFPzu7Gc1U
 QCS4SXz6NTFXl0dTbpqt5FuZZ4h25EyumqErtHslbIC+ECMtkzch5kEEEZFA57p+FMPy
 oxn6oH27DeuIpl4uKJ/4ailShHbtt5wAIEhGeERpvodOnKD8DV4b18ZxMbBbJ8pTJvw2
 9ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697812171; x=1698416971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FujUaO+baNB7sA+ben7V/dRMzcEBOoUN4v8JLZvYkDM=;
 b=sQy/d+VUCSBV38YLPkY/yGCoRbNE97syb4KACPTgRs8S+pO8AcyRXEEQLeKJhybNae
 +iLU+t6SNYkFy9Rn141JYy0GDXkGTz2eNRixKAvpUSmt1Tg4sId4Hn4yQIrhyN3Gk7Mx
 a1ultfwMY/Csx8N1TG7ZTa6c0JZLkzwXVbCoMlhgaEKtLOkRmWcJyBIfoQe0gHa1QfCp
 3+XyRyyKVxuUcQ3qqaZSkmUXGh5RDD5B3uNV4CHNvUKA/3fR8Dp+jl9RfZL45+xKd10b
 errfRoCzLRSnXXXc3Kqw4vIZVGhp5XX2LOoa8iQ8VQgUtoj+4WAFVy530KlvGxDXTy8t
 2Szw==
X-Gm-Message-State: AOJu0YylI/pqGOZt269He8NRqqg+tq2Sji/fy/yBtdcRqV68gClXpBFg
 TrKL9lnFP/tQ5INMG4yVGthRmA==
X-Google-Smtp-Source: AGHT+IFaQ675s/D4HwlKFYl7454hA8RntmpOe5WCyYLfAbqwpQgTGlhMIQ1DPV5QT8/CgFT9QtIPlQ==
X-Received: by 2002:a17:906:7310:b0:9c6:724:fa1f with SMTP id
 di16-20020a170906731000b009c60724fa1fmr1768817ejc.66.1697812170875; 
 Fri, 20 Oct 2023 07:29:30 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 jy20-20020a170907763400b009b97d9ae329sm1605239ejc.198.2023.10.20.07.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 07:29:30 -0700 (PDT)
Message-ID: <c79dbd2c-3f31-ff68-bc33-cd57b75e893c@linaro.org>
Date: Fri, 20 Oct 2023 16:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Fix a couple s390 paths
Content-Language: en-US
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>
References: <20231020141509.2096591-1-farman@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020141509.2096591-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 20/10/23 16:15, Eric Farman wrote:
> These are simple typos, since the directories don't exist but the
> files themselves do in hw/s390x/
> 
> Fixes: 56e3483402 ("MAINTAINERS: split out s390x sections")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


