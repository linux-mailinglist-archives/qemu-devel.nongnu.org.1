Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EC078D07B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n1-0000oS-Lo; Tue, 29 Aug 2023 19:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6qZ-0004QM-Th
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:06:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6qX-0004e7-P3
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:06:03 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c0d0bf18d7so30613155ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346760; x=1693951560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i+BzlalAfS3SboUKU7O75glZ8iZoS13QYwh3GvCIW5o=;
 b=CfqazTp4pmFTOclSRNfrvyIYdDd/dBPo9dRDvqgbMsysE2ac1753PBNHisqCUkEmw5
 KzT/1jib2TqHvp1+ZBY5v/odaG1pYoAs4spbc6Px4xmx6uM2JUqGAgrqZO354rD5SKH+
 9hhGem92MVSJu1RImqXvaBCF81Hs3QgQny8RZ6Gd9jTYkXEbz6p/7J/8mGiCxt9fGk9P
 jnwAd5df0WwQZhdvpo7ThHKSpbjzk9xTspYm0SvmRDxxY4OWPnLjQfW/pWO4Z79iNTZx
 dEDKc/OuVHF9JW9MelFA0BlTR+HHAsS+7q7hx4GcHMmVW40efjBGCndmL7dA8niAZUYD
 eJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346760; x=1693951560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i+BzlalAfS3SboUKU7O75glZ8iZoS13QYwh3GvCIW5o=;
 b=NIX+9Pon1fFMAw+EcVKHU7wyeUpJKYups2X12Gf7DN/FORI5roTBsBKlFHIOib1eq7
 j4MZoh+wEOONPBG8zWlDQzWFsqbM7mDbw658oA1oUlw7WMj5Vg4lVFyOqbsVqL7eCeuz
 xdbiRzVY4Fx/An521E3HRI5isJ97skys9Qm5AElJKYorXrWZK0iHczD4vNKusupV3wjg
 7ULSL98OAs07t8rRpEsZS1YX+Z5bUDlDXi8PvScbWprj/AxnY/ecOEy/ELKlkNCoA6lU
 H4Kvw4EpxDTUjERia0OquZIg5OKp7KWsC/E/9l/SUM0wlsHdUAdwqRsUy8io9JVFl6Zn
 Vupg==
X-Gm-Message-State: AOJu0YxpLPcCnVoLViAMwwT7ByMbdoh8jFxWMMRN0V8gbLFS1EM4jijv
 jVL3VvOVXKE6bYnCquM7mL+9Fg==
X-Google-Smtp-Source: AGHT+IGo97bubkhzorv0lNwWVlvTIXq37LRLYBzvFrHkSbTHe/22ftLqm8vDrpLbjQIr7gHIuDfuqw==
X-Received: by 2002:a17:902:eed2:b0:1b8:6cab:db7f with SMTP id
 h18-20020a170902eed200b001b86cabdb7fmr355188plb.53.1693346759814; 
 Tue, 29 Aug 2023 15:05:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a20-20020a170903101400b001b890009634sm9878956plb.139.2023.08.29.15.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 15:05:59 -0700 (PDT)
Message-ID: <3bb2bdef-1b83-0f73-4802-8cf5d7f253f9@linaro.org>
Date: Tue, 29 Aug 2023 15:05:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/9] tests/tcg/aarch64: Adjust pauth tests for FEAT_FPAC
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
 <20230822042530.1026751-2-richard.henderson@linaro.org>
 <CAFEAcA9qHW4-OGnsPnNHHhn+fda0Qri_8iqcNwkc-nhxqYiCYw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9qHW4-OGnsPnNHHhn+fda0Qri_8iqcNwkc-nhxqYiCYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 05:52, Peter Maydell wrote:
>> -run-pauth-%: QEMU_OPTS += -cpu max
>> +run-pauth-1: QEMU_OPTS += -cpu max
>> +run-pauth-2: QEMU_OPTS += -cpu max
>> +run-pauth-4: QEMU_OPTS += -cpu neoverse-v1
>> +run-pauth-5: QEMU_OPTS += -cpu neoverse-v1
> 
> Why do we need to specify neoverse-v1 here ? A comment
> would help.

neoverse-v1 has FEAT_EPAC, but not FEAT_FPAC.


r~

