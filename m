Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B6D74975B
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:20:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKDR-0006Gc-Uv; Thu, 06 Jul 2023 04:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHKDC-0006FY-O2
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:19:41 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHKD9-0000KP-Pz
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:19:37 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b6f9edac8dso5020921fa.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688631573; x=1691223573;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XupYVj5l/1CmBiinrxynOKsLwtXwl5NT5P4+gRmt2rA=;
 b=lhl1Y85TL9FtJfBIA1R41NmHUth3+odEMfup16Ve32q+xf5Z8L0ZtJpgSR+lR28uVz
 ajtGViw2/YbRzzbY2I3LgdvDaVUZPq42QDaVu/MzHOE86VAIvy8JbDLzcNG//gXSuiVb
 mB+tJpzOO1eAVwgZXy9TR7PcGIsDpZzDfTJGsEeDzrmEZWLkY3luzKpM4HB0WXp0Ak1V
 IpaYh/eVfQZb+FHK5Hy2HQ4C04ATHxdf7iwb/Esh/gerFUVc5nV+E2J1mHD+5/hcduwO
 xWXK2LwfHMFlxddL/Ry0CfD0ZNrsFLcr8XjNUUllcP22h41AL9y2qVq85N27Gsqqq10N
 Te3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688631573; x=1691223573;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XupYVj5l/1CmBiinrxynOKsLwtXwl5NT5P4+gRmt2rA=;
 b=ZTdhtdVaCR9MBDBK2ZlaSHQ4pCHGhmdNnhGW0GH+IikTcji0t4fQxUElHJRot0Cdpd
 giPLn2UgGgUWSGLkaCzYM2jovflMu8W23UJjjH4LlHRKiYkhxnKecrnTnOu4AyX3lI5A
 xPNuVVSRTnzue+WufPVl0QoMDcuTBjJ1/5ScJ3BH1ZyRlpmRGA13fcmviDHddMsKxQ59
 yNm9odVOMDACXDKzo/52+HbWcP3Jtd6ltoYPq2usCXMUE+QidR4+ba7MOAJhGw4LTdRZ
 WnzRFZ4BWIeTuQkxGo+SkYsuj5SWV8LMOab1vVjNXDWcM04PVX1cb3zDMsaSyRb73UO2
 b9xg==
X-Gm-Message-State: ABy/qLZRDZqiizAyEtxOkc8xHnCsI5lg1Fuag+k/ExOjayeEr+CEtlsY
 aSZGOOJ8/8/fXPZBKs2kDijeHIA6uaPCwWz3/3A=
X-Google-Smtp-Source: APBJJlG01xlAI782WVmxMfx163+xuH33OAMBJATnUrT4LANZVcFwmQPdL2Gc9W438V7oqxo/LEwpUQ==
X-Received: by 2002:a2e:b0cf:0:b0:2b6:ef5d:965c with SMTP id
 g15-20020a2eb0cf000000b002b6ef5d965cmr798673ljl.44.1688631573497; 
 Thu, 06 Jul 2023 01:19:33 -0700 (PDT)
Received: from [192.168.82.227] ([91.209.212.17])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c214d00b003fb225d414fsm4373381wml.21.2023.07.06.01.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:19:33 -0700 (PDT)
Message-ID: <a9899619-8cbc-ea7e-8dbf-776193ae0835@linaro.org>
Date: Thu, 6 Jul 2023 09:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 14/46] target/loongarch: Implement xvmax/xvmin
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-15-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-15-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/30/23 08:58, Song Gao wrote:
> +    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;           \
> +    for (i = 0; i < len / BIT; i++) {                           \

Likewise.

r~

