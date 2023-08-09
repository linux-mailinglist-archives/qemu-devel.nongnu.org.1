Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449C776376
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:11:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkqB-0006ZF-KI; Wed, 09 Aug 2023 11:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkqA-0006Z7-Ey
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:11:14 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkq9-00083q-0Y
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:11:14 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686e29b058cso4955234b3a.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691593871; x=1692198671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W2RNdv7MQVQMJmnFgtFJBdkUf7vmm1iSlEMrytAZYs0=;
 b=CLRS+s8A5zvOC99wUoVUoPboVpNUKqthuR5DQe6iM14jNQrziNCnWaQ+Gm/SbPY0uu
 cd9wElJa2awzt02HnBnyuHeEU0Vtyon/hCqPK2Typm5Ps2Tgrgr3HFmo+ZKSqoPlIM/i
 U0TNPCP1HtKYJS6+LfyJwjchzXpu5ODVzDxlFdxkVaEGCfJd9+03eTap8743Y4LW63wH
 4ixhdH+1aAuA93bGQBpNAaXGVQx0/gsCgCUZCC6kTuxoRHaqtIML7KykpmyfaKKqb9im
 Ao9W6jpBVMxzmTBN59AArWU4IV+iqorMGza3tDiEY87yswtCCBtS3ftnPfqCi3ODgosM
 2Btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691593871; x=1692198671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W2RNdv7MQVQMJmnFgtFJBdkUf7vmm1iSlEMrytAZYs0=;
 b=TGbi/Wrw4sPmqUWqDQDbO8ehaIf0KdgpebnKq1IgsRJ1uNfOPS6l6eSkGHvdgwnYit
 f6c8kPlNjV933sTqFZGvw/vD/eeAdU3KQHAf8w4h8Uv31IrbUYHEmcvYJWZKOIw6YP7o
 k119pBUWQ3giIE9JdNT4obgUlvFo3+zAMqXHsmxmN6UyLd9RrujqJoRIZjV+LInsdY95
 A1WpuN0dFAlpzdpW9etd7wQvzRrBpclF7LpoSvA4SW9LdQYWbAVvDWIdlUKgeZYCrvGT
 1K69SazpH5rITq4ydAonGpPVlBQcHEDlucIc7iliBbJVLrhBgrZG7Kj4eP5xbSn8SGqv
 eNfA==
X-Gm-Message-State: AOJu0YyLiiD4L8CmGzMj4Oc/7UHihnBDCJvLDtTYGw0KCoN+2Nbhy/Nm
 y5b3TzoxOU4Lxoc7kh+lZpPcNg==
X-Google-Smtp-Source: AGHT+IGe+HWogYyTmqFB/taGUQS7hGmMa4iYnMlSbSVOSTx82u+IGoSIkep0PLwvjj85byxomJli9w==
X-Received: by 2002:a05:6a20:8f0b:b0:134:d4d3:f0a8 with SMTP id
 b11-20020a056a208f0b00b00134d4d3f0a8mr3221574pzk.3.1691593871657; 
 Wed, 09 Aug 2023 08:11:11 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 q16-20020a170902dad000b001adf6b21c77sm11303242plx.107.2023.08.09.08.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 08:11:11 -0700 (PDT)
Message-ID: <b5a030a3-eb95-6ce0-e0f5-15912d61f57d@linaro.org>
Date: Wed, 9 Aug 2023 08:11:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 10/11] target/loongarch: Sign extend results in VA32
 mode
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230809083258.1787464-1-c@jia.je>
 <20230809083258.1787464-11-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230809083258.1787464-11-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 01:26, Jiajie Chen wrote:
> In VA32 mode, BL, JIRL and PC* instructions should sign-extend the low
> 32 bit result to 64 bits.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   target/loongarch/insn_trans/trans_arith.c.inc  | 2 +-
>   target/loongarch/insn_trans/trans_branch.c.inc | 4 ++--
>   target/loongarch/translate.c                   | 8 ++++++++
>   3 files changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

