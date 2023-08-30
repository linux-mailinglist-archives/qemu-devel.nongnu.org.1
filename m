Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F99278E285
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbTxr-0005nS-Nb; Wed, 30 Aug 2023 18:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTxo-0005lC-10
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:47:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTxi-00018I-WC
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:47:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so1303475ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693435617; x=1694040417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OP12lyRw+rUdZowwnpZ1SOOMGeSk89mn325Byp59/uM=;
 b=O4CMzot9PJOHm0CABlh60RMd67DXoIUqUp7DBZrsZNgV990o6GBSx+fdHgtVWYXJ3A
 K+t8gA1ZOFt35Vbhj9M9W0VbNXhe455uV9CQFDEtNLyDmj+BUGj+1ZUM8ptwzaN7L2U+
 J2eZnflw6cDh04GczJ9r1W7IjxTWUF0IERPBiTK4QERA/LSb6Mqr9ZL1XgDtjyQKoVsN
 eq+a7v+8IvZgrUpxj21HLGKmuKy20Z6W92YYpXwoZWpGmZFzxAp/o+gl+ksCVaRNgivf
 aTA5NqvZUXXrYLgwGGCXTaDuYi0z9Is8va4eOwIrmzN1tMDk1bow267d6FMVv4fwU1l8
 Gzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693435617; x=1694040417;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OP12lyRw+rUdZowwnpZ1SOOMGeSk89mn325Byp59/uM=;
 b=hziVzozFxQAS+qwE3zcGbOP3ZZl5BsCu5X8TJMWMaVNgo2yfhb8cZ/19mTMWeMTkSg
 ICgeTLxyaGzumRAgD7sAgIR9aHLiJTWtnuZPryRPUCbCc/e24F5ivNfSl67KedbydP/K
 sZBlUfggKfDpqV1GAKw7LIuHEZ5C4GnMNlP25ApkogWUnxCn5Uw0i1YSAWt9XiTN8ex+
 09RjFtxyQQ8ltF3vtWcJO0tkpsoRvXcOy2lTTu7O7OSpr0KaU2zWOq+JrqCRvttALCtX
 kp6kiK7poz1vhwaf3RLq4APr8+2W65B2hBWxna1gdrEyk1oz8hYGiHrvau1NbqkqasPa
 4xzg==
X-Gm-Message-State: AOJu0YwXVc+rrGqqKmAAQCxTj14PawGMYaN+4V4bV1APjfWCa0UirFCi
 p4GUTk26ZmY2HEp1ZOHRkUTyBweC9+6MwCl6PXM=
X-Google-Smtp-Source: AGHT+IHL8f1wHIiDR+LLBWBMue9zFIWDUwLK/L542XVLRN1M13/61TmiEpAUHxkGSEiAfB+h1/RBvg==
X-Received: by 2002:a17:902:8e89:b0:1c0:b7f4:5b86 with SMTP id
 bg9-20020a1709028e8900b001c0b7f45b86mr3387660plb.65.1693435617045; 
 Wed, 30 Aug 2023 15:46:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001bdc5023783sm14825plc.179.2023.08.30.15.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 15:46:56 -0700 (PDT)
Message-ID: <a97806f7-49b6-8fb1-eabd-a8bd83a0a058@linaro.org>
Date: Wed, 30 Aug 2023 15:46:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 26/48] target/loongarch: Implement LASX logic
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-27-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-27-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XV{AND/OR/XOR/NOR/ANDN/ORN}.V;
> - XV{AND/OR/XOR/NOR}I.B.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                | 12 ++++++++++++
>   target/loongarch/disas.c                     | 12 ++++++++++++
>   target/loongarch/vec_helper.c                |  4 ++--
>   target/loongarch/insn_trans/trans_lasx.c.inc | 11 +++++++++++
>   target/loongarch/insn_trans/trans_lsx.c.inc  |  5 +++--
>   5 files changed, 40 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

