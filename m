Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C71B74D967
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:01:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsMv-0001VM-Jx; Mon, 10 Jul 2023 11:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIsMr-0001Uy-8Y
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:00:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIsMp-0007nW-Q3
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:00:01 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82dc7so47737645e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689001198; x=1691593198;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+u1AUneL/qxmP0Yx90wuzLaJSUrM9K59olbweGOB/78=;
 b=qiV6ZuY4XoNiwqsGj1D6CZSZxXphLiYBaHtjGBYrvSUtB6YkK06snF9/wVXbXRijd1
 mIdDvgqHbDe/wKZRd/Mr5YMMLuwU8iZ4AzR7YZ3JsP88aQYdNfHF8pToINyYBrL7MV18
 p853YoQBEqf/zpvajABNOTLzRxMcNS99jngYHQdhV1SWlegWXb6XVwcAPfjgFPxCXgpj
 bY317niNvt9eqqRawpkkv2K+2MAYcneKV3sSI+fdHnsY11tOd/ty/T8yxVeJJKtANFeu
 4/LP8AqNZzNyvXnwOYZJDvwHD6BfD7iaOm2IwkSKK83SHHOU7DyMENIEbqL7okXUTyGY
 sgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689001198; x=1691593198;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+u1AUneL/qxmP0Yx90wuzLaJSUrM9K59olbweGOB/78=;
 b=XCmJ+0/IZQEdrbNYNxSJaXh9fRL/Lqub1vdCHPv1ViZlAloN6R+vcMXwsR1lniExu3
 m33m5MO09AksLIf9ino0hPfJCo7+BPPXeWqk7e0UYNQi6RwZtOZvB8R2fm42LZa1CJGd
 FUtviSK8Ct9Rp8YBfp5aoqtl7Rp6cMtxT3P1nl939vvPsaI9ABZHoOie0n+7J8liPQlG
 S2PfvJ3MFzeL8zxTTFmp6c2g6MPkDxz92sqJ/KT8K+zhcjJKbXrGYtmXEjbF4S0k2GpG
 vSLEW0Cg1oYvCmnuDMdwpWsvFRqYeLhXJIqz43f/LQBuxtwst0wqvPsiRkarslFRzn+1
 OGiw==
X-Gm-Message-State: ABy/qLa0glFl/H9ZRHru3h+sDE8mluSYQTx0V0bEu759eJUaQHG1EGzb
 ai00RUC2wrdXYz0M7hWasFMsH2EKNChYVTEyar9Z0A==
X-Google-Smtp-Source: APBJJlGynwUxPOSkJeCytHBGcpZrBVOLJcJu//2PwB1sh+KGWXsuEIj12ecPIHMvExKfuwStcuHy6w==
X-Received: by 2002:a7b:c050:0:b0:3fc:10:b25b with SMTP id
 u16-20020a7bc050000000b003fc0010b25bmr10117957wmc.21.1689001197963; 
 Mon, 10 Jul 2023 07:59:57 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 f21-20020a7bcc15000000b003fbb06af219sm75121wmh.32.2023.07.10.07.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 07:59:57 -0700 (PDT)
Message-ID: <799c0116-0041-d489-c790-0038bc0a5f1d@linaro.org>
Date: Mon, 10 Jul 2023 16:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/mips: enable GINVx support for I6400 and I6500
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20230630072806.3093704-1-marcin.nowakowski@fungible.com>
 <ee19d8a2-733a-23c9-cce9-db8b8dc0e253@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ee19d8a2-733a-23c9-cce9-db8b8dc0e253@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 10/7/23 14:58, Jiaxun Yang wrote:
> 
> 
> 在 2023/6/30 15:28, Marcin Nowakowski 写道:
>> GINVI and GINVT operations are supported on MIPS I6400 and I6500 cores,
>> so indicate that properly in CP0.Config5 register bits [16:15].
>>
>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@fungible.com>
> 
> VZ is unimplemented in TCG so perhaps we should leave them as not 
> supported?

GINVI and GINVT instr were implemented in commit 99029be1c2
("target/mips: Add implementation of GINVT instruction").

