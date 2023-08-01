Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC5476BDA0
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 21:24:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuxN-0007so-B7; Tue, 01 Aug 2023 15:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQuxL-0007rz-1m
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 15:22:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQuxJ-0007ak-Ij
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 15:22:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686bc261111so4377363b3a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690917771; x=1691522571;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2atCtTRN/JMfdPzafk/J+52jDOXsvph9ibReUCUBaMw=;
 b=W9AT+lRB+4FO3iFlE1WmmORBAtqi17CS3rfu9JDsFiZ3eyOLZk6J//Xo5oE/iUKGLq
 ox46oqo2TsT/yQtij9z/MMWkrNfCF2Wq6gvFAZvo872zNQcOvT0jE9F64k0Kec0Fh1W5
 z27n9eOgsgqCJw6NOhWQJhdul3I0yAnwXmPkDr5ER9lIqo83nCvjLG0sE4kgNdy3/HVx
 LEeLYL87/rIzdSH12OGZAM8rFgB0mM8b3Tf65rzcnIhXl7TQJAG4u+mw9GNuaDgUcavl
 2KALhxdl18t7Uj7e02jRi/ytXiCG5QKhWCJxeFtagJQz9xPRXahFn+JGV/7r8JDFGEtC
 61Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690917771; x=1691522571;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2atCtTRN/JMfdPzafk/J+52jDOXsvph9ibReUCUBaMw=;
 b=C00u5LKztCZbn25uaqJQgg9DVEJvqd40/hzRKRRa8n1pLHWMbGtJSRq2hP+RTnwSlD
 SjVH5yTFNvProKYsgr32l2TKRB1ZoY4SRnylY7/qMnHPIcSaDF4kMj+s3j/tkUaaYMsr
 GxRdEaDsk7yZ4ydmmEIccPaq6UEN5c4Q+i5M5eO0yKaWvQ2q59iCTIsp5sdTNRoOH4qD
 3GDIuIdh1z6vnYI1KrI5ZGLscKxv+PWMp9iglRaKoFVOosRtnuZxZaxSy5aojFDISnkh
 2jmb7Y+cxid7RtbFaK2xbm0W+yn+v3EOfZcOeg4whwXU71Pivyb8ptBT99NW5gYdajYA
 T71A==
X-Gm-Message-State: ABy/qLb0JA0+80M2cFvQXVCTEk56Bbhj3P44q10vqG4KgD1BGKzd+C4f
 1YI1KzEcjXl6/6W/IV75YwsA1ZZxss8rEPlGfXU=
X-Google-Smtp-Source: APBJJlElq/UG3O0/wUHdShsfHsNU75G+PLGNk7QI1FnBjBXAT7E8P2Le9NN2Wv/SWDf/FhSGEEvEIw==
X-Received: by 2002:a05:6a00:1590:b0:687:4bd8:159a with SMTP id
 u16-20020a056a00159000b006874bd8159amr5067377pfk.19.1690917771014; 
 Tue, 01 Aug 2023 12:22:51 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:67b4:35b2:87e2:dccc?
 ([2602:47:d490:6901:67b4:35b2:87e2:dccc])
 by smtp.gmail.com with ESMTPSA id
 j63-20020a638b42000000b005637030d00csm10274761pge.30.2023.08.01.12.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 12:22:50 -0700 (PDT)
Message-ID: <b4f4695c-5257-4ff2-060e-0c6865eb2250@linaro.org>
Date: Tue, 1 Aug 2023 12:22:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] linux-user: Emulate /proc/cpuinfo on aarch64 and arm
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-arm@nongnu.org
References: <20230801191035.374120-1-deller@gmx.de>
 <20230801191035.374120-3-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230801191035.374120-3-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/1/23 12:10, Helge Deller wrote:
> +        dprintf(fd, "CPU implementer\t: 0x%d\n", is64 ? 50 : 56);
> +        dprintf(fd, "CPU architecture: %d\n",    is64 ? 8 : 7);
> +        dprintf(fd, "CPU variant\t: 0x%d\n",     is64 ? 0 : 2);
> +        dprintf(fd, "CPU part\t: 0x%d\n",        is64 ? 0 : 584);
> +        dprintf(fd, "CPU revision\t: %d\n\n",    is64 ? 1 : 2);

These all come from cpu->midr.  See linux/arch/arm64/kernel/cpuinfo.c:232.


r~

