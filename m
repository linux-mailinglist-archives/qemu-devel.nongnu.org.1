Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E223799C33
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 02:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf8fX-0007u1-GU; Sat, 09 Sep 2023 20:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8fV-0007tN-B3
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 20:51:17 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8fT-0004SW-77
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 20:51:17 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-268bc714ce0so3104803a91.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694307073; x=1694911873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D0pGAbECzBB6C0k6yjD4kW0YPlD7ZWEBaaD1ydvuY/0=;
 b=Arx8cxPOJDomgJvkqhJ6pIJ/KAxw5AMaXiUx1YaiWSKijdbbdrZ23lCc/shomjO0td
 JMd6XfV2t6ocCQC/M5op5VcSrBC3KLvj6QgMokpw9CWg+4oditJb0VPUQIdTmU/aW7Gx
 wjEmByGzrGW7hhwgg03vyl76HJwqtr37hcwbc5jtLssRxn/WxC8zSGFLrGFABu/15s6K
 I74sgQ4MGVHR8O92bW+NKqgKbJG1026N0LgGH7pr8eLOnl/ZGav9V65+xIIdCOhMrI+/
 9KV09vmW46rvBH8Hbp2CQB/KzVOpyCQyi3Czxbz7+VjGtLFwMTw/IEcYCFB04ngB5uhE
 Z7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694307073; x=1694911873;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0pGAbECzBB6C0k6yjD4kW0YPlD7ZWEBaaD1ydvuY/0=;
 b=KG88+IbCXbnLwWKMeMLV9gfe/XBC3BNV1uQJosAf7NiiW4OpBI8c8vAvWFcbjl2Wen
 W9rtmNASuAAj3zkfefTEg7CApNdW01SnuS3HsDipBAKJmGGz+oMDhxsrwr7XW8GgN62Z
 s0VeXfiuAx1YPOHPEqGd13nPeAJwa8Hghlpc/Ab0AquXMFTpkA2Iex5pyaXkliiFHKCT
 W8ny4+QavK3YQDiOSVf/yfVq9wqwpfuJqXdjCBsn/Jh8ruWALrMBjGGzRuZZ4zRVI7Ok
 TfZ7rutzyEQcnWCJyHjP9WmwAdbL7ff31elfqdTvp/zYeIzptVzFERAf+kjecLEBIAyt
 GE+Q==
X-Gm-Message-State: AOJu0Yx1Ksv5ZyKtXtE8WgDW3Ir8AtGkgvk0IuleEGgeRaIKbmhyeaqY
 OLmHzMOH9nQEBRTD3wyDd/6fayexZcMI99nTyj0=
X-Google-Smtp-Source: AGHT+IF7hMpmYueJhcU0PAZHQ0PCs0P1LmN4cD03gkZXfkNhwfR6VNzaPOTx9oAZ/wfdSS4SnwXSQA==
X-Received: by 2002:a17:90b:8c1:b0:25c:18ad:6b82 with SMTP id
 ds1-20020a17090b08c100b0025c18ad6b82mr7969629pjb.21.1694307073129; 
 Sat, 09 Sep 2023 17:51:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a17090a588400b0026b3773043dsm3276582pji.22.2023.09.09.17.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 17:51:12 -0700 (PDT)
Message-ID: <e68959ea-f6bf-4765-720e-a7e07c7433d3@linaro.org>
Date: Sat, 9 Sep 2023 17:51:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 05/57] target/loongarch: Use
 gen_helper_gvec_3_ptr for 3OP + env vector instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-6-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 01:31, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                   | 48 +++++++--------
>   target/loongarch/vec_helper.c               | 50 ++++++++--------
>   target/loongarch/insn_trans/trans_vec.c.inc | 66 +++++++++++++--------
>   3 files changed, 91 insertions(+), 73 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

