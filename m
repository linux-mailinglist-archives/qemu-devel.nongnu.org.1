Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2079F882
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:55:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcVM-0000XN-RG; Wed, 13 Sep 2023 22:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcVK-0000X1-72
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:54:54 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcVG-000389-E1
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:54:53 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-577a98f78b2so328546a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694660088; x=1695264888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EZhRpgvNAjRb+ruN/V/U/dLGCKh2q6fq9Hbpt3t4oE0=;
 b=fxKfbdskC1VfRCBkArGzvavpSrCuTnozQIvRS+6aNMTXNOTuCmNvWKOkJFJVBqA1NE
 2Hnk9ylLOQ8WLdQ4x+uXKmGoDqlGq7RZZtgJJNfwswITxYD0df0XR80oIvH/pYvxsygF
 itJ4MUOBM7nGjH1vBGQ/DSyC8z4hXoBvXDaF8iyML/KjXY1RieTZa7N6B4B8PnpdyyOd
 zhu/W8d05n5Msq/AruMM8txZUuXM+1iVFkrnkmef6l1+2Vua2m+tAUEaJIKutVtQlEAU
 XCmfPpm0sNW1ve/pVmGaFxTIue4RNGwT3erHQn+CLElY1PrBw5idnCeVzKjyO+DYSAG8
 MaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694660088; x=1695264888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EZhRpgvNAjRb+ruN/V/U/dLGCKh2q6fq9Hbpt3t4oE0=;
 b=eST2C9meeltC2s+/dknCCpzDLtNLOt/esSDjI3hjAELCWNkIfM0FwTFPQzY0T6G2Dr
 U/f/IEdMZZlIT+SiiA1wb9bRNx7fabEHRbaPmvASv43kYZWDDytk2imkVcukdetYRRgs
 PRBfiqTr/fRFZ5+1sdH40PAn57hT/al/J9GCQ2dKFt3SCZjfkQDDeFoprG2NWSi93VoF
 oSwv9U6+F5D9upUjzMgrhFKSmxXO8hvdYMmk3PgceRPxR1b+Nbr0QFD7cMcfSxtRAuJ2
 yGGDih5AGdLqmfXo7OUPFLqMcCcxZ2AMAJzardQiUtbqo84/g5OOkkWlsXa5IDLQYDHq
 oQIA==
X-Gm-Message-State: AOJu0Yyxv1N8Y1ibcRIqJYyrCMfxi1B72R1L7Y+MynAJcQT16zdbK0iv
 2Fq0RcDBcIGrpGR2GjswNRAzeDii/RDChyywTWs=
X-Google-Smtp-Source: AGHT+IF/CHL20yF/rs7YVuploPGjaM5+s4wo9A/o3Kh2mph9OQx7uTzN87dwKwDrSfbEwL6BZhmz/g==
X-Received: by 2002:a05:6a20:734d:b0:12c:b10d:693d with SMTP id
 v13-20020a056a20734d00b0012cb10d693dmr4312449pzc.6.1694660088249; 
 Wed, 13 Sep 2023 19:54:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 iz11-20020a170902ef8b00b001b03b7f8adfsm317547plb.246.2023.09.13.19.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 19:54:47 -0700 (PDT)
Message-ID: <952cadf5-99c3-246f-6c55-495f48bbeb73@linaro.org>
Date: Wed, 13 Sep 2023 19:54:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 06/57] target/loongarch: Use gen_helper_gvec_3 for 3OP
 vector instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230914022645.1151356-1-gaosong@loongson.cn>
 <20230914022645.1151356-7-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230914022645.1151356-7-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 9/13/23 19:25, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                   | 214 +++++-----
>   target/loongarch/vec_helper.c               | 444 +++++++++-----------
>   target/loongarch/insn_trans/trans_vec.c.inc |  19 +-
>   3 files changed, 326 insertions(+), 351 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

