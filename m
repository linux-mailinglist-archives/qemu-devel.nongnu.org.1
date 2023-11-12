Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C8D7E91C0
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 18:10:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2DyQ-00054v-Qd; Sun, 12 Nov 2023 12:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2DyN-00054f-6j
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 12:10:11 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2DyK-0005Cl-IG
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 12:10:10 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c6b30acacdso47065921fa.2
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 09:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699809006; x=1700413806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tth8aIMpUMn44DS4q8xTygEYQA9qQUQGECf7G2wy/EY=;
 b=c0lrHlVflQTWw1tSB4i/8BU0B60lu+uJlT1ixZ1Q8MD3J5zYmp5ipS6QPphmIgdadz
 dSMvxiGXYtpeR6s5uKI8xq5AJHyqj5FLuPMp5xcgOmeS6COZ/10zNG8HfEv0oFrNiPXS
 BQd7x0PIeBF0ANwuKQG7hMqrSluT01TgNA/W91lDRau3GFN0QpUyEQM2JyIMo2Q6L3gm
 3eERkYP5M/sZ+P5WysdWFS/jAwKwfga04uBTqG5rWstM5wivdVXcnirB4X6qy8H5OhYI
 CAlb/c0NfPM8495evMZpFJ39zkWRTdAAg0P36M9t1/xqixE4V8XqC8SiUeQwegE1bmNm
 qJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699809006; x=1700413806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tth8aIMpUMn44DS4q8xTygEYQA9qQUQGECf7G2wy/EY=;
 b=OfBnkEhtQfj8B+6Y+vAEt3YKWo6ol3R2n7DbI0t/lFmvPUgWKiV14bSWdh87AQQFw5
 vEQzEGaMTlT1ubbSkKSavyhBdW1kfd+/uw4JO9Dl0ibcJL2ylX6VSKeFCTrCsNaCW2Qe
 MvA4KT1IPagAWnLDJmsjhkxTwjkiQGSFOG0IpYbuMtFSHnF2fi2JZq9T5W6YWgQi6eBJ
 nqTmDxcZDQShJvoTT52a+mNRuusIBhM2qyLsYLBLyFc7aGphp6FuC5qpccOTRMaeIYUm
 7GOZ4QLoYQsyE+JEjgyK3mCr/+AA2X5d1yzVfhP0qKJspYecRQk4qNScwNMBHQuiOlY5
 BLcw==
X-Gm-Message-State: AOJu0YybqIv1hgc/bFLCz96J+IuzPMyB83Hm3Lqcwc9TPNbGnxZD18YA
 ZWyQdsicDEJ4x8MPEROgS03Mtg==
X-Google-Smtp-Source: AGHT+IEtPTKMHkvowdK1lP5IUe7v9ivFIOFsDNl7kMxZ+zja8rNIiSv87ZZpegZZGmeHuU2CuzFj3g==
X-Received: by 2002:a2e:3908:0:b0:2c8:3613:d07c with SMTP id
 g8-20020a2e3908000000b002c83613d07cmr3047630lja.12.1699809006621; 
 Sun, 12 Nov 2023 09:10:06 -0800 (PST)
Received: from [192.168.69.100]
 (i15-lef02-th2-89-83-217-202.ft.lns.abo.bbox.fr. [89.83.217.202])
 by smtp.gmail.com with ESMTPSA id
 fy15-20020a170906b7cf00b009e5e1710ae7sm2802444ejb.191.2023.11.12.09.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 09:10:06 -0800 (PST)
Message-ID: <7d74454f-559e-4448-afab-53d76b76b511@linaro.org>
Date: Sun, 12 Nov 2023 18:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] target/hppa: Introduce MMU_IDX_MMU_DISABLED
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231111013212.229673-1-richard.henderson@linaro.org>
 <20231111013212.229673-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231111013212.229673-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 11/11/23 02:32, Richard Henderson wrote:
> Reduce the number of direct checks against MMU_PHYS_IDX.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/cpu.h        |  1 +
>   target/hppa/mem_helper.c |  4 ++--
>   target/hppa/translate.c  | 20 +++++++++++---------
>   3 files changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


