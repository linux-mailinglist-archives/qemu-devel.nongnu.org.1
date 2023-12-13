Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FE18115C9
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:07:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQoW-0001We-CN; Wed, 13 Dec 2023 10:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQoU-0001WP-5O
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:06:18 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQoS-0002nw-I5
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:06:17 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3363aa2bbfbso701489f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702479975; x=1703084775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9yJJL5nXm6La8L1XeamcSUokL1Xncy7obwnO8xZRrXA=;
 b=Q8aIQEXsgale6EKM5IqB0EC3JvkRk1xDDbw1AtTkDOsvvACeZKePhdbbxOM7tSAty9
 Qf5+689qq7n5M3Mboq29s0aodGupxvS8nMSdPQY0rT9yaK09WC7YUL1FOqo0x4Nxjw6+
 JDMZuni6Weak3md078wnOp06AnOLG1gXs8shHHbBGmJfEbUOrRR75sp9Yndo+DFoevRr
 giGxYnFwaGVYouVdHbGr7u8lo29jE5nlFUn61PEBpXBZO/H+Dkh6vfavbQ0kQX8yZRhS
 K0yvVhKLRQMaQK/tI6/pMc0PuyTC49gRWeqMFhJjru/NzwF3t9tIbRVUe/WePYcz4I4w
 4XCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702479975; x=1703084775;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9yJJL5nXm6La8L1XeamcSUokL1Xncy7obwnO8xZRrXA=;
 b=TvNROKkOZgpmRlhUrrEhB01Fx3Gn2mzav7JEMGuaLgMCB0liAyFb9RQIj5JGohwe5V
 QUJ1FrHMdJKxH6jAxmgp1wx6cIX5PndUlKfX5qbxdH9qVpqE/SgyNLPiPv8CH2Vs2hwD
 OI1L8Im7pAXFjWyPieX9uA9A9F8BvupfhOpmYVCMulHk5VtOv0yNRDwmIdO88zNEdgvU
 BJopaFIkkiA+jZ/RDykspj8mG7RydkrLZEuGxR3nTH6tkI9XjKQjPpsYXXZZWH5nhjs3
 j/irx2Y7SDaSMjmmcMmWLzpnf4pHCP3S9MPPwvGEg41gBkWvtKXMilfJ7Xvbk++kRiYI
 5ViQ==
X-Gm-Message-State: AOJu0YwCQwNt/RbAn6AtG28+8reIEgbGtva+5r3SqzpXn8Y+CjdXPfYP
 l6QPSnmQcu09UO5L6javNHlVxg==
X-Google-Smtp-Source: AGHT+IEjkde0VcMRj7sURCafMl6U1DH+qx6o+bJdoe6QdeUTavxgT9tCs6XsjgEkeLnFVLlCvvposQ==
X-Received: by 2002:a05:600c:81b:b0:40c:2757:d316 with SMTP id
 k27-20020a05600c081b00b0040c2757d316mr4420031wmp.150.1702479975035; 
 Wed, 13 Dec 2023 07:06:15 -0800 (PST)
Received: from [192.168.71.175] (76.red-88-28-19.dynamicip.rima-tde.net.
 [88.28.19.76]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c4e5100b0040c34cb896asm19587207wmq.41.2023.12.13.07.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 07:06:14 -0800 (PST)
Message-ID: <1c1438ea-e2bd-4f45-9658-2d0da90c9df9@linaro.org>
Date: Wed, 13 Dec 2023 15:49:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] tcg: Move tcg_gen_opN declarations to tcg-internal.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231029210848.78234-1-richard.henderson@linaro.org>
 <20231029210848.78234-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231029210848.78234-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 29/10/23 22:08, Richard Henderson wrote:
> These are used within tcg-op.c and tcg-op-ldst.c.
> There are no uses outside tcg/.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 7 -------
>   tcg/tcg-internal.h          | 7 +++++++
>   2 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


