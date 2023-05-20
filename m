Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1670A8B1
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 17:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0OEU-0006RS-J2; Sat, 20 May 2023 11:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0OES-0006RB-HM
 for qemu-devel@nongnu.org; Sat, 20 May 2023 11:10:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0OER-0005ke-0h
 for qemu-devel@nongnu.org; Sat, 20 May 2023 11:10:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d3578c25bso1895298b3a.3
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684595453; x=1687187453;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=spg/Qsa6p8fb8S1nlFezJ2DF9LAEVscpvC+MkfvtNgM=;
 b=SWx5kvesZhbIs3xIlyOV25fnz/A4lOifKRrPeT/bByyayJ7zj9kO+V/UkMoclw+UX3
 jH2+P2oWchu+BubSDP2ZoQOlf1pN6zNifyjRFAZmSYTSY/aSQ6Mx/ffi79gis3KmoqfL
 8j4OirV7RowKHbqfl0FbttKwDKFdB8zs/FjrxluPRoC9gwM2NKz+wEku4HLhrjNyXaMd
 6sX48qZBaYn1KgXvx7PXKtWF1ZxSQF+N90i72LsFWNAjaT7HktqLPg347biyynkRYLMf
 XA3Rxb/E3lXE+HqHxt+ALH7BMgP7rhSs5jSl7ioGhSXv6IZADr9dUflRVTbsmSyb97hP
 vAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684595453; x=1687187453;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=spg/Qsa6p8fb8S1nlFezJ2DF9LAEVscpvC+MkfvtNgM=;
 b=d1mPW0MMk6ApriLtd3Rj4rmkIg2WxSPzUaFB64BSAfRPUI21ml9mjE7OvLRHL1LQsx
 hVuUdwOh81u4vov3IX7VSjCNi8n8Sl+O9mGfng6ObqYw3XhdvPVnlYbVO9+albBQicrW
 gN74izkjzAtUTcRED5/VQfVxtcDUa5NaS3Mo/0x+nT64yIgQ4xuEJ7P+0uXxA5ICxvrd
 VibXsb17riuAYXqOBiD0p+KEQjkO/1LdrjjI305fYtTcOtswKxspF00aEA9rL5Adz6lL
 QRgDonytb8C6Wqp8+Vu/bQyft/sRTMoSbDAtKppryVELrVYkFxYykuiSD3FHGxPV/vxj
 7OSw==
X-Gm-Message-State: AC+VfDwxz11iPH/ZVf82KDHB3wbyLihae6cXTNGOtVmGPwTdfnxV4jQS
 jlW6gYetBTAH0B7M/8OCiPIlpQ==
X-Google-Smtp-Source: ACHHUZ4KZ1Gkc804w4QbaB/+VS41q+Wj+/gOhZEbavO2t8oaqNJAEXuXgUxCxr72tO+9sWSwN/lRSA==
X-Received: by 2002:a05:6a00:190f:b0:64d:4a94:1a60 with SMTP id
 y15-20020a056a00190f00b0064d4a941a60mr2284232pfi.18.1684595453109; 
 Sat, 20 May 2023 08:10:53 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:d078:d94e:cb2b:a055?
 ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 i19-20020aa787d3000000b0063d2d9990ecsm1384900pfo.87.2023.05.20.08.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 May 2023 08:10:52 -0700 (PDT)
Message-ID: <2f1fbb76-0d9f-769f-293d-ff346b943998@linaro.org>
Date: Sat, 20 May 2023 08:10:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/6] target/tricore: Refactor PCXI/ICR register fields
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230519133650.575600-1-kbastian@mail.uni-paderborn.de>
 <20230519133650.575600-5-kbastian@mail.uni-paderborn.de>
 <906dbffa-c677-1192-fedc-5664e61f8255@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <906dbffa-c677-1192-fedc-5664e61f8255@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.597,
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

On 5/19/23 08:02, Philippe Mathieu-Daudé wrote:
> Could it be clearer to add a 'icr_ie_mask' field in CPUTriCoreState,
> initialized once in tricore_cpu_realizefn() and avoid this if/else/ in
> translation here, simply using the initialized mask?

If its for use in the translator, put it in DisasContext.


r~

