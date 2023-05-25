Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D8A7111CA
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 19:15:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2EYe-0000ef-V9; Thu, 25 May 2023 13:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2EYY-0000cx-GS
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:15:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2EYT-0001xg-Kq
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:15:18 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso2722722b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685034912; x=1687626912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eersNOkoYzk0XbAOQptNxJ2J8i2voZJcClyO2hfwM/E=;
 b=JGeNMNXC91nCpO4uJPiqjmVJ7+BzsU+t4PcE07xCTvlI9RVuigpa6iWIXXVhN0mcAP
 KTP+wbiqVNacT4IsnDAB2KGx5NOpFxLt/uAabR4OkQymObOxEI5nX3mmls7ywwh1Zm+D
 c508AJCUnI8pH+/mODf3gzcx12yayC6PtoISRGchXRN4CrK1TpaEgAJkafWekOF8kJxN
 9fCGIyi5l0FuWQK8+/uIzS0XTLElq/lXPO5LrchUsrBt4rzaYGUCJc8OjPgeSsrHspjn
 nQpfkYv3ZbgqYjW3lQnpRoCUsZamDsf6mU8Z9lY/ziD57BTlwcC9AhOdMSgxaXrDvnuc
 XMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685034912; x=1687626912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eersNOkoYzk0XbAOQptNxJ2J8i2voZJcClyO2hfwM/E=;
 b=WZMgoy18VwIKLSkrvXwdEpAMMgIeeKbcX4FuJ6RfCahqlg5SyJe7y++bJFcJ5/vRV8
 afDnsFYPP+dSrh7MWkCzlr7WuLK1qB5VIew6sxZOvSYs537yk4q8A7oOw0kgFuLP9qJ3
 Gv6FPiHCWBMQVsEFXM4PyIviWd1BUuh/Q/WpgABgvjIvAy18xKefX5j3v09ffsn0DoPA
 u4w3gIqcBTzm16malr8Hb7yVHJKKVWQG20MUsBnJsNAZPLH89B69nJCDy9ik5IGLXDHk
 UoU5XXc3tvBOJ9HjJ1lVQWEblzt2E0tgm8ql5CS6rPfbyI3sOFI3wixzo4C9uGzkPCcV
 SGJw==
X-Gm-Message-State: AC+VfDwH4zDindrJrXU1+jz2ifTNkmau1lfRKf1PwzrDz6X3oWKco98j
 87MaFwOEAeO7JvSrXf3Wh14j7lBHYWBBSydzPRY=
X-Google-Smtp-Source: ACHHUZ4OLF7SNfcy6nykaRIzTmwd41hcWBRE4gfAvcheT4j98A+Iq7UBkQcAJcUBBCq5sLneIC/YLQ==
X-Received: by 2002:a05:6a21:3613:b0:101:62c7:9db1 with SMTP id
 yg19-20020a056a21361300b0010162c79db1mr17587471pzb.55.1685034911791; 
 Thu, 25 May 2023 10:15:11 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7ac5:31cc:3997:3a16?
 ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a656786000000b0053f1d55676fsm1330114pgr.2.2023.05.25.10.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 10:15:10 -0700 (PDT)
Message-ID: <d1bd457d-3fde-3d7d-040c-b0a0bd43d8a5@linaro.org>
Date: Thu, 25 May 2023 10:15:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/20] Misc patches for 2023-05-25
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230525141532.295817-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/25/23 07:15, Paolo Bonzini wrote:
> The following changes since commit 886c0453cbf10eebd42a9ccf89c3e46eb389c357:
> 
>    Merge tag 'pull-qapi-2023-05-17-v2' ofhttps://repo.or.cz/qemu/armbru  into staging (2023-05-22 15:54:21 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to cd9b15bb62e4c422c3ed5fd69c613ecd5409838e:
> 
>    monitor: do not use mb_read/mb_set (2023-05-25 15:40:13 +0200)
> 
> ----------------------------------------------------------------
> * hot-unplug fixes for ioport
> * purge qatomic_mb_read/set from monitor
> * build system fixes and cleanups
> * OHCI fix from gitlab
> * provide EPYC-Rome CPU model not susceptible to XSAVES erratum

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


