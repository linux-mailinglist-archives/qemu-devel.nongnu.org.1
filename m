Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2804E7E2982
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:14:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02F2-0002MK-Ox; Mon, 06 Nov 2023 11:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r02F0-0002IY-Tp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:14:18 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r02Ey-0003to-Hc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:14:18 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2800bb246ceso3441852a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699287255; x=1699892055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/dn6OaM9XyvsYTdAmlqqL1c9cwyrUM/RL1SDDVGOzZI=;
 b=qOJ6tI47utqx1bw7CZtdeiMoR5vfuWYB6hala3EJXKBk4U60Ryj0zK5xZ88wJBeZpC
 sDskiJ4Mfb0xzwRcBwhSGe29e1NfvpvktHwYkSkljCLc9MeOmfm+YmlEdBRmxNpfxWUE
 m8Q6KrU4lUsRs4Uq/P9VRcjdRbE/osjXOG9qEfLimymVXltyUTVG1Bg5yAymOm6heXVV
 AHTzsZ3Y2ZOKid3fic2lWSGRBRCggF3kp+wWNLrLn58Bda/D5TkLb5/Xa5HY9JH3u4Jn
 +akUjkphZxJIkv6EA0UwVQQtvOhu5skunraNxWn3oANUGUhZFtzRpnktip1HC5KFqxJK
 BDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699287255; x=1699892055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/dn6OaM9XyvsYTdAmlqqL1c9cwyrUM/RL1SDDVGOzZI=;
 b=P/nWuMoKn8P6ncmiXco81PDG4/TvbRC6PYDmqW2HY7/JnymkhqaMHcVqvLgn6k3vNX
 2QEIm9LHFQ2XqGNLR0JNgFTnqrLCNL1e2eIZl1al6sU/cdvsO5BHqiyranmHZh1kHYCk
 6PzM6wp/PlRttQIxNhlhx/ap4DmBN60QpnD9O5dMJEfJt9RI/pT//NkDEC4FhCTedMi3
 k3MlhegbCVhelstf19Rs/5wH5Psy6LgMDw6l8Yy98LV5Wn5UC2m1KdqTH6R+Os4/Ok7F
 A3GWoYLcYLHAVbcagdlCYPURvNSqCZnW608CBN6jjK7VSfwPtDgQA6qjRY5RoSbDw1Hg
 s8kg==
X-Gm-Message-State: AOJu0YwlndOul8XYOt2HawbLz8D7e4kEn7Qy1y+KftERX2Xp/EbtPoh/
 rh1AwgxN+TcL2ygPjrIjj/NJf8kkPj3yH3sBUdY=
X-Google-Smtp-Source: AGHT+IGRGi9VF+On90mHeXsUm40wCt6c0Ptb6IQnErtvdTQd4I6+z82JsD9SukKoUeOR2eJqRm2UAQ==
X-Received: by 2002:a17:90b:4acb:b0:280:3650:382a with SMTP id
 mh11-20020a17090b4acb00b002803650382amr19122685pjb.16.1699287254931; 
 Mon, 06 Nov 2023 08:14:14 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a17090ad50600b0027d219d3ac6sm5753089pju.47.2023.11.06.08.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:14:14 -0800 (PST)
Message-ID: <3acbe9d0-011c-49c2-b2ce-89d7d6925378@linaro.org>
Date: Mon, 6 Nov 2023 08:14:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] target/s390x: Fix LAALG not updating cc_src
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-stable@nongnu.org
References: <20231106093605.1349201-1-iii@linux.ibm.com>
 <20231106093605.1349201-4-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231106093605.1349201-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 11/6/23 01:31, Ilya Leoshkevich wrote:
> LAALG uses op_laa() and wout_addu64(). The latter expects cc_src to be
> set, but the former does not do it. This can lead to assertion failures
> if something sets cc_src to neither 0 nor 1 before.
> 
> Fix by introducing op_laa_addu64(), which sets cc_src, and using it for
> LAALG.
> 
> Fixes: 4dba4d6fef61 ("target/s390x: Use atomic operations for LOAD AND OP")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/insn-data.h.inc |  2 +-
>   target/s390x/tcg/translate.c     | 19 +++++++++++++++++--
>   2 files changed, 18 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

