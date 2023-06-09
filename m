Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B42B772A2A5
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hGT-00060p-21; Fri, 09 Jun 2023 14:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hGP-00060P-5u
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:55:09 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hGN-00049h-KW
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:55:08 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5445ef3ef1eso1004645a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686336906; x=1688928906;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NSa2TqVpO7VWFTaChUl5Klq/d7SCYiq5CUpPCygi03A=;
 b=SJvuZ+qKYwejL8YLhKlfNjdlh+Y5YHBWq8duglHnfp6kOkmj8/5PJcr8GHLKGHU3o/
 UUWtqPN31LE0wkmzMiVSpPdWutl1TOjMUMXpFYcMztYsg9PWbL4EsmwvYBrvZloc80DH
 xXfQLMo4WpCEDWdQxo/s8NwIIV/IlTk7zM9LArl1rHrY0ieRKiO/fIRNPuMsXmOJIBzG
 Q/lg5z0prHZSyYEllrYLFNzdStGKzemGNyiFCynZpxE+VqYu0QNJAP7Rlg9PfCpkXgQD
 G7UNb2WnbaooGLozKvQHMyWK1ccXYPoa/OyCAObMJAKJgrUviM9Rp1NaiofqjQNsdJGp
 9qrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686336906; x=1688928906;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSa2TqVpO7VWFTaChUl5Klq/d7SCYiq5CUpPCygi03A=;
 b=UzjbCYkJcX39qB2Tq1mtHDxmycdcr2yfgy1HdbmoOxSOnnGpgxk0TuFma7JSBiBvCS
 auXYnBgOohZtdLn58qndfSqB5OzGszP+k3d9i/zp6K41RAbsb0aAdGZ2N8OQMJh0++B2
 szoyi1s36NsSb4NMW18rrPEukyMWaqjbQ7HXoaLhDDlyhE1T65245TV6rP0p4fMnNrlo
 NygqQckMlNfnpCpy2sRfLZo8KIK7VitKyDnOagY1uo29SQ8vCrbuZCT64dnuZ1s+PbEx
 ozUQ38uiGOVK1mJCMgNx7WnBLdVCVN993dFgHWa5q0QJZl7/NmM0KVGtXGnQiy2Wfo/S
 qqtg==
X-Gm-Message-State: AC+VfDw09Lc/vVK6CnDkJRjGYexwgLl7CEo67iuOYAXeZbC3oJGetCdX
 TDI9p5JKM4T8UMdlRFBztTCOgQ==
X-Google-Smtp-Source: ACHHUZ7A/W6dD0Yr/hW/XWfJ45fkenSNae6U3HWtdjKm63RBbSL/fL25+ZiTBfgRK+K+jaaGgdIceA==
X-Received: by 2002:a17:902:dacc:b0:1af:c1a7:3bb5 with SMTP id
 q12-20020a170902dacc00b001afc1a73bb5mr2299215plx.4.1686336905913; 
 Fri, 09 Jun 2023 11:55:05 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001a65fa33e62sm3603138plg.154.2023.06.09.11.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 11:55:05 -0700 (PDT)
Message-ID: <e3cbbf73-21c2-f91c-572a-13b4bb271770@linaro.org>
Date: Fri, 9 Jun 2023 11:55:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tcg/tci: Fix MemOpIdx operand index for 3-operand memops
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230608162925.677598-1-richard.henderson@linaro.org>
 <cb9be1e8-889c-f315-8a8d-18b81dda3f4a@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cb9be1e8-889c-f315-8a8d-18b81dda3f4a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/8/23 09:58, Philippe Mathieu-Daudé wrote:
> On 8/6/23 18:29, Richard Henderson wrote:
>> Cut and paste error from the 4-operand memops.
>>
>> Fixes: ab64da797740 ("tcg/tci: Adjust passing of MemOpIdx")
> 
> I had this patch tagged for review but you were quicker
> (not sure I'd have caught the issue although)
> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/tci/tcg-target.c.inc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 

Applied to master, though it hasn't completely greened the board.


r~

