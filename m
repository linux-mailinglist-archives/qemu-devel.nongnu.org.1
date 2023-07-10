Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A297474D3D0
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIoME-0002hN-9Y; Mon, 10 Jul 2023 06:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIoMC-0002h1-7g
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:43:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIoM7-00080d-Cp
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:43:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8ceso45414825e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688985777; x=1691577777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3z7jTLEN148JQRtl4w/pZ1H6BLFwfYwNomUEoKiu05E=;
 b=sTxSSOQrlBslNW2vLHGEOclQCvQsn0vu0ptu0SRs2eZFEs1AGSe9iBKfURTA74uj8n
 4sH+z2WTJPl1VWKec1gGFDRIHmc1VwYlY6V6ipuOryEEDoi8lmw5iFP50AukFvEp+TQY
 nO7xf1SHBacCv7vgexmbqaIANJ9P3I9kedcyT8FwRYLF7+2gF2ck5NHK9bLuQ2WGjw1j
 a3dFWoY5CT4kGLaIVM6tSgnRmpIZYJ474PsS1CIjDZ2NIi9Kh7vB9ML+iilXFrKbmQnr
 0VhfgLoN4odCrVzyRa8/Dzb/JQZ25iNAt1VUj1tdu508vQ8yqcSIfo5kGlGNMwqAAsQM
 q/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688985777; x=1691577777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3z7jTLEN148JQRtl4w/pZ1H6BLFwfYwNomUEoKiu05E=;
 b=GJv2Ua1gZrECMrxx1vSIS4tQZJaoe8suVKK/EDKlIncpNxWlPIjntyNmZdLJhR1CUa
 N7DO5dzYW0vvULQ8ZA21jSxxtzFqLCZ/4EFD02wfX0byDKCiJKe0IJLdP5Gsiz3drQxa
 +JDI7yUnf6Vb48RZ+3ssJzjJgYkWarKqdr7388bpbXneuH/Nv7rTehd7t8NF79aJE7K8
 fD+x+TUwhGenNafUm9IvytSewQkdjHIgFb/+upJjJOEoSfrT64YZ4ySdzmbqoS2BJKV7
 LMuHbJd0FDY62UKBXOhSok4OB8CkFAOBHpNP9iQeFnXZkE0NQT0EwrNQ+CWGdNhCoEV3
 /zVg==
X-Gm-Message-State: ABy/qLaUSL3fTUYNWIGEo6xSKPbyJlZ6U0eT7MjkA4EILDY/axI2SNNc
 2Ed/DPMGvppwWNq/qKWA/9aBiQ==
X-Google-Smtp-Source: APBJJlE8ZMj/TT+Ob+TTPvtOnORuwujlTAgJIoV9mNgbAMa0xVd1P3zx5XQ3GHWlaIDyXztPW44kDg==
X-Received: by 2002:adf:fed1:0:b0:30e:4515:1529 with SMTP id
 q17-20020adffed1000000b0030e45151529mr10153318wrs.37.1688985777628; 
 Mon, 10 Jul 2023 03:42:57 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 n12-20020adfe78c000000b00314367cf43asm11389597wrm.106.2023.07.10.03.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 03:42:57 -0700 (PDT)
Message-ID: <7fb2aebe-dab1-dfbb-42f1-b884ee52607d@linaro.org>
Date: Mon, 10 Jul 2023 12:42:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/mips: enable GINVx support for I6400 and I6500
To: Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20230630072806.3093704-1-marcin.nowakowski@fungible.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230630072806.3093704-1-marcin.nowakowski@fungible.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/6/23 09:28, Marcin Nowakowski wrote:
> GINVI and GINVT operations are supported on MIPS I6400 and I6500 cores,
> so indicate that properly in CP0.Config5 register bits [16:15].
> 
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@fungible.com>
> ---
>   target/mips/cpu-defs.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


