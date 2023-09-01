Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A3578FF50
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5H3-0006Ew-Fl; Fri, 01 Sep 2023 10:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc5H0-0006Eh-Vt
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:37:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc5Gx-0006FK-HK
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:37:21 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-313e742a787so16811f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693579037; x=1694183837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sFOhjyrZr4V8VBZpLEDjiykpEnWE8AF4+k2ONgi+sTk=;
 b=VQ8bJPtoMJGQc3KixrciBN+0UqUm8qomnxf7y+oI4nbmolyUwxFvudwIIwAMXmvGT+
 LMsSQCUgWf8FN2UdgX6tlAZ5xYEO0UaLKZcwUFQXKAXn29OZ1/GsADhb4Vwpf8SBu40z
 FKPpTohY0yLGlKOz88lPYkPIbDvfffYUOS8mczUPasAtiT9XRyUVZvbVcpv3vhcJRbf4
 1MDCghzMA3SbZS5jAsfp66VychEgJUcPpSA0c2hSNve9MqWfyOccdK/PyU/6ThFEGzzq
 e99pnu4dnjqj9tLkFp8TZfEL9lEu2zslWlT8BpT+0TefX+wQ7PgLLGT5xVY/xyNeSMka
 IN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693579037; x=1694183837;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sFOhjyrZr4V8VBZpLEDjiykpEnWE8AF4+k2ONgi+sTk=;
 b=IUF5pNf8LZ7zhoF4Bn4JAFuWIvKWxtUFwDStcYhGRg6Ue1GH0PPkep4d4caf8Zpo9f
 q69eTFnl0048BthhT9IGPCsJftr29u/z5DW+VLpy0QZBLfU7xYnm4g1JE2erQLriuRyv
 Y7L8v2Xs5HrkQQ/r8LuQcKGEJXjkz9914Gu8DS3EwxDxPT/Yjx7iDenhUzwPTwusWBya
 453JSFE4yJZetDpnXSAtNOFNTumS/7BouJMASJt7aqsUJix6Rnhg8LE3pRiVODm97WAT
 HDCWptGFLwEyo8zRIvd8TU0/pD2DhRcqSvExldUlun/Ro+As1m2b8e9rYkbSEIWo8iaD
 mjgA==
X-Gm-Message-State: AOJu0YxeUe3NDOBPdMO0LoFXIhF1MZnC5a+H9fw6ig6ln9B9F32TXldc
 VseogHa2LxeFlQDm9Q7r0eLSAxcAGc30T4CeCGc=
X-Google-Smtp-Source: AGHT+IEJjSWv7Eos+Bjjhxxs5wNO+DRS/qL/QAC48vjF9zh89SZOkSWbSGpL+JHWTrpzCoq3O6FAdA==
X-Received: by 2002:adf:de88:0:b0:31d:db2d:27c6 with SMTP id
 w8-20020adfde88000000b0031ddb2d27c6mr4643801wrl.30.1693579037386; 
 Fri, 01 Sep 2023 07:37:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.220])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a5d4805000000b003197c7d08ddsm5433113wrq.71.2023.09.01.07.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 07:37:16 -0700 (PDT)
Message-ID: <06ff21b2-5d2d-bd4b-dbae-942acc564093@linaro.org>
Date: Fri, 1 Sep 2023 16:37:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 08/13] linux-user: Emulate the Anonymous: keyword in
 /proc/self/smaps
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
 <20230824010237.1379735-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824010237.1379735-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 24/8/23 03:02, Richard Henderson wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> Core dumps produced by gdb's gcore when connected to qemu's gdbstub
> lack stack. The reason is that gdb includes only anonymous memory in
> core dumps, which is distinguished by a non-0 Anonymous: value.
> 
> Consider the mappings with PAGE_ANON fully anonymous, and the mappings
> without it fully non-anonymous.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> [rth: Update for open_self_maps_* rewrite]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


