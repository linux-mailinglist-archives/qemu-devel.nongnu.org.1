Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC774855D
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:47:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2q4-0001ZF-Mj; Wed, 05 Jul 2023 09:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH2pw-0001Xs-1x
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:46:28 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH2ps-0005KD-RV
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:46:26 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fb96e2b573so10941218e87.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 06:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688564783; x=1691156783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hU1Eo2dPiVhTVCGOI/u7NqMTyJAfkIbmqU+Nqt7Jxgs=;
 b=Hgr5/88wyWI4jjNZqnV7onhD9rjK7JOY3E3rRVztQABO8Taj4guy3XEZ8Wlbh/FOE4
 O1VlcTzryZLrR/Ls8voZZfRxR/tbbtqVMVfT5YFsuKxUIdU+GCFxrj7k5pd0oy//tj5Z
 LQ4o+jSep/IRk3VjlK2NdJUC92uOXoeuJuh7tfroqHGxET5zqo/y9AnkMox7MNRzrz1o
 A2IGdXY6oV3stxrysChyhfaHhlHhbUB20uFaZzu5QASbfi0CSKmyZF5OHAeIjFhNZcZy
 oow+1EZjYsUiyyw7bsw/OeAHPIMy8lp7Fxu0KxWys6EK4AG3zQiaD1gq9M9ZOs1bQvuU
 5XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688564783; x=1691156783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hU1Eo2dPiVhTVCGOI/u7NqMTyJAfkIbmqU+Nqt7Jxgs=;
 b=e2w4GBt1nrM2gSs5cJrqcsqQF8I14U1b0OkbqUdMxlMli7hmyfE4A0Lwgm4ByQ0Mav
 YNf4M31hcl/i61qA6Ybm6f7C/sxE58+4alagp1z9ssDqTsGZqrGmqIJmfUv+LfrF+CjN
 VAACkNIYRYIlZRbpO4B1o1TJhn4zMiwjg8woqH458UuQYQuyXpC3MeG/IkYqhchrknta
 hMmi70OUmigxwC4e0AIURUsR9F1fogH8HcgHSeyzBldK34cqtj/8F1kUiSmqXpUVVjuC
 4wLrJPKEQ08O84VI8fk0jPgVuW1BBah7BD2Y4bncepyvXmRboUKuwTXXFUDCz0KJiFJZ
 yZpg==
X-Gm-Message-State: ABy/qLY2QSt0ft9WTGXu24vRTU+wcTmKnKIg7d7DXPTRywgRklxPrdc8
 E8k+D8zqLDhd5rx6XCs+7dh0lQ==
X-Google-Smtp-Source: APBJJlHX+WUwhZ2pSk85f2RkOfOD0gQQqUvzX1fFDf+QD5x9Gt9kzYNZnDlhHJP5TEoG6Xjd+UUGag==
X-Received: by 2002:a19:5049:0:b0:4f9:5ff6:c06a with SMTP id
 z9-20020a195049000000b004f95ff6c06amr11305981lfj.67.1688564782857; 
 Wed, 05 Jul 2023 06:46:22 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 v17-20020ac25931000000b004fa039eb84csm5393772lfi.198.2023.07.05.06.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 06:46:22 -0700 (PDT)
Message-ID: <5a6ebc83-3f10-8cae-8fe2-478379d8429b@linaro.org>
Date: Wed, 5 Jul 2023 15:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Hexagon: move GETPC() calls to top level helpers
Content-Language: en-US
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 ltaylorsimpson@gmail.com
Cc: bcain@quicinc.com, qemu-devel@nongnu.org, quic_mliebel@quicinc.com,
 e.emanuelegiuseppe@gmail.com
References: <000001d9aec2$fa0154e0$ee03fea0$@gmail.com>
 <20230705124520.2693489-1-quic_mathbern@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230705124520.2693489-1-quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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

On 7/5/23 14:45, Matheus Tavares Bernardino wrote:
>> Taylor <ltaylorsimpson@gmail.com> wrote:
>> Note that check_noshuf calls HELPER(probe_noshuf_load) and
>> HELPER(commit_store).  Both of those call GETPC() from within.  So, you'll
>> need to pull the contents into separate functions that take ra as an
>> argument.
> 
> Ah, good point. It was my understanding that, in case of a memory
> exception in one of those nested helper calls, the GETPC() we would want
> to use for unwinding was the one from the most recent helper. I'm still
> trying to wrap my head around these concepts, though, so I might have
> misunderstood it. Is this not the case?

No, it is not the case.

GETPC fetches the return address from the current function.

The unwinder which uses this value needs the return address *into* the generated code.

Therefore the HELPER function that is directly called from generated code is the place at 
which GETPC must be used, and nowhere else.  The corollary is that one HELPER should avoid 
calling another HELPER, Just In Case -- use separate intermediate functions instead, as 
Taylor suggests above.


r~

