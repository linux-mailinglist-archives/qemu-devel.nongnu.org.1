Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5F776343
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:04:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkj4-000337-MX; Wed, 09 Aug 2023 11:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkj2-00032k-Ln
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:03:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkj1-0006gk-5N
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:03:52 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b8b4748fe4so45954865ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691593429; x=1692198229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nespcu0sEGhNWDz85ABeh/WGbZLHs5R1vnIwfkt/T9c=;
 b=mQkCPcRVWw9x5bO5A+NEQrFp9af+Oy1aLbRwIqaTp1tSL9x+yefmUSY6A6P2V/0weq
 dAV4BMzaFmb4ihmcWCFDDUy8bt1Ns9cddZXG9sN70/+uG1onSPB3ugyTWktsV32wpZYZ
 JxwdyjhEgbTM3L1mJYktoxfTsKfvl9cB1YZc9OSDZdralQ1Ldly//PtcsVddWQkpOYkA
 OJlte1uknLFb70o9SeOTAUkBRXSLqpFgYhPjCnOs70Juhnf77cLjexBSludFf5fYFOyy
 zM8c6PJ7nddpIZWZ+kAJFCWpvL4foP60zYfinno0Wqq0z/V87icgQ19Mkm0R29r/8HIf
 02vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691593429; x=1692198229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nespcu0sEGhNWDz85ABeh/WGbZLHs5R1vnIwfkt/T9c=;
 b=dzRAaC2W0OzG6yGWOtBYvYjYv6SYSpndzKtUakEU1vRBilrSKwi0697lj8TIlplbd5
 VbcCzi2JIpUS/iyE+M8ox5eFexA0+pXM8MEV1kZsE6yyc0M0+4ACl0eLJpPkmgV0ygv/
 GnDSgZPVh4GFXOj5eADzmkZF00nlKLST8VlTml9dYLFenDXqPlCmcpdclW/Vc0ZiFYyp
 rCZdFztus9A9dVfp8Q7GdnGmDnzqVrVdFQHQMZsYNAhja1d5R3zcCImTId1SgVrQc4js
 35R4+C15kTBgm79RF1LYDz+xhGD3P8csT6dnIsER4w+BjZ5pjZDEFlzZ94q4+FbEyWQF
 iv2A==
X-Gm-Message-State: AOJu0YyozgCiRTDYbsNDj1jgdcQhNQNI1ZK93+72C3B55qJv1xa4a7+u
 3bFYk8j1Pf02Ci3X4xdLNUQE/Q==
X-Google-Smtp-Source: AGHT+IHVnDEU1pDbdXHcal661AVSHMWSoeWwpSe1pCo8bjFE//gy7Lx3zy5Hwhpg8Q3BN04yWbb0hw==
X-Received: by 2002:a17:902:f684:b0:1b6:bced:1dc2 with SMTP id
 l4-20020a170902f68400b001b6bced1dc2mr3104155plg.0.1691593429656; 
 Wed, 09 Aug 2023 08:03:49 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 y1-20020a1709027c8100b001bc6e6069a6sm6523529pll.122.2023.08.09.08.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 08:03:49 -0700 (PDT)
Message-ID: <8e84ef00-7272-c26a-9e97-c135d577cf08@linaro.org>
Date: Wed, 9 Aug 2023 08:03:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 08/11] target/loongarch: Reject la64-only instructions
 in la32 mode
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230809083258.1787464-1-c@jia.je>
 <20230809083258.1787464-9-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230809083258.1787464-9-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> LoongArch64-only instructions are marked with regard to the instruction
> manual Table 2. LSX instructions are not marked for now for lack of
> public manual.

I would expect LSX not to be affected by CPUCFG.1.ARCH, but only by CPUCFG.2.LSX.

Note that there appears to be a bug with respect to LSX, in that CPUCFG.2.LSX is not 
checked.  The manual is not clear, but I would expect CPUCFG.2.LSX == 0 to trigger an 
illegal instruction exception before the check for EUEN.SXE == 0 to trigger an instruction 
disable exception.  Also, are bit in EUEN allowed to be set to non-zero values when the 
corresponding expansion is not present?

But that is not a problem with this patch, so:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

