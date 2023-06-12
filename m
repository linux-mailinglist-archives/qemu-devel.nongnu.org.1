Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75572C520
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 14:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8h3U-0000tv-KJ; Mon, 12 Jun 2023 08:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8h3R-0000tb-I9
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 08:53:53 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8h3P-0005Qk-Qv
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 08:53:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30ad458f085so3110194f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686574430; x=1689166430;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hL13j2KdI0fqpjpp00fiRTsYjCvqT1bo9Gl6NsUyLTY=;
 b=VNcPyIu2iWoXWUnh6edXQ5VBOdbLankVWoGMXCajN03a1x4XHcpyWMXUQq1EHNxiTT
 gaBZf4lt/BFRPvbxTQs6gseY8smZ2zoZDF4rmNVFILBMxT7xwLFwn9PrAQImy1zSRVRD
 AsJfyoC2Mizyl10yxEJotBH0MAkzYRsdf3EQKIVltKPPGTy9hB/2pk5AeFrz6MAfbw/T
 AdBW1utJkB147I0sGhIeXiCqXbQj/NXdBvABQuh3La/geDyMozgwe8pllYkopaWx5Idl
 +lOJZfigYQAGI01baS6kVUSx7+Jq+7O9l8UtvJk3z43poSV1Qf0nYzpn9JRhXdgeY86T
 OD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686574430; x=1689166430;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hL13j2KdI0fqpjpp00fiRTsYjCvqT1bo9Gl6NsUyLTY=;
 b=i2RJzE/RbzLWlHvnF+GsjsDYbd6sZDgp3mXKCg9hwUkd36E7ZSlN+6n/2mXOdz5Gu5
 qQadsTRPqSD11SVaUgP6ddjkQms7Xm9sTxgCmrJgbkGwdDpieZiT9FUyf00KFAHQCNaj
 KmzlZvVLnszBYNozQ9eo7D1HpMZJOw2zWcj8prFcRmBWUXSkEuU4UhwIwgSLJ3eDIdy2
 ezBwRK591ifZpzg7q7Aiz46WEiK0M6AvT2FU51e2oH53nuA/HpwD/DK0BNufgg/VRUYN
 ZBmMIn/juD4oWL5QIi+in32uxFnTzPC06Conl83eBSTY9O7HQwBe3NL/cxQmQBZi+iL9
 colg==
X-Gm-Message-State: AC+VfDyoNO/PR8W9iKvzKGlo0lJuuN+fwOjK5HnuQWV4dLQNImBqyfXJ
 QCuRDb6o8hBrurCAv4jSzkcBlg==
X-Google-Smtp-Source: ACHHUZ5aiQfbLWRhs78wXQmnRQ8b79D9B2nVbmho3BAcPMmxusghK1/qrMk/XLdu7E/hhnOHCdhzBw==
X-Received: by 2002:a5d:5592:0:b0:30f:ba3a:85c5 with SMTP id
 i18-20020a5d5592000000b0030fba3a85c5mr3776337wrv.25.1686574430124; 
 Mon, 12 Jun 2023 05:53:50 -0700 (PDT)
Received: from [192.168.112.175] (176.red-88-28-1.dynamicip.rima-tde.net.
 [88.28.1.176]) by smtp.gmail.com with ESMTPSA id
 p4-20020a5d48c4000000b0030903d44dbcsm12367471wrs.33.2023.06.12.05.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 05:53:49 -0700 (PDT)
Message-ID: <268c1ca3-409f-bc43-0e88-c32f1eae71f9@linaro.org>
Date: Mon, 12 Jun 2023 14:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: Fwd: QEMU AVR Patch - Correct handling of AVR interrupts
Content-Language: en-US
To: Adecy <ld.adecy@gmail.com>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, qemu-trivial@nongnu.org
References: <CAB295yB5cFSZpGE74EW5hDMSNGnZfw06UC5ydepUL0sdT96WGg@mail.gmail.com>
 <CAB295yAzhzPpKC7KtpKk6t6x4Dn7Bpam=Nwfx8z0wAkZRP-JSg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAB295yAzhzPpKC7KtpKk6t6x4Dn7Bpam=Nwfx8z0wAkZRP-JSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

Hi Lucas,

On 8/6/23 23:03, Adecy wrote:
> ---------- Forwarded message ---------
> De : *Adecy* <ld.adecy@gmail.com <mailto:ld.adecy@gmail.com>>
> Date: jeu. 1 juin 2023 à 21:34
> Subject: QEMU AVR Patch - Correct handling of AVR interrupts
> To: <qemu-trivial@nongnu.org <mailto:qemu-trivial@nongnu.org>>
> 
> 
> Hello,
> 
> I would like to submit the attached patch.

Unfortunately your patch doesn't apply cleanly:

Applying: Fix handling of AVR interrupts above 33 by switching ctz32 to 
ctz64
error: patch failed: target/avr/helper.c:45
error: target/avr/helper.c: patch does not apply
Patch failed at 0001 Fix handling of AVR interrupts above 33 by 
switching ctz32 to ctz64
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

You can find help on how to send your patch here:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-your-patches

Thanks,

Phil.


