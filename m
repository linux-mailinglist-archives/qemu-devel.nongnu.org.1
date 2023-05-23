Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2CB70DF0D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:19:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Sqs-00019l-Fk; Tue, 23 May 2023 10:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Sqq-00015b-6h
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:19:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Sqo-0001dY-E2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:18:59 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30a8c4afa46so2114456f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684851536; x=1687443536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ke2iD7p31ed5Hxfz14QVVAbxkGlsZDMpq06KcFrVP+M=;
 b=OIWJzO9LWh15XIGSRF4jpEwAvwkuMPdp3OZwIXI3ShqNfAbvuDsGriiyH5yY+J/65p
 icZs90TcaBS+hAuFNiM2M8OIhJXr36CR7V+mjLLfWYafGqjDJAxXzx/Yj31sJ5uur1pM
 VWaLwYQB1t72566dAnCDCgVSm9501gL9hCoMUE6b3/FUrGM72DNbJPnwK309tAGz6LKE
 8x9D+fYMaj5XOl3pEPkbafKB7yoSZQi6SpTGnlvCW9MhzZr+fTaLACnre4gNYrb1u3fI
 HBNduHoU9r6vYABf6cAFmNvp6ZPbqLcNwjGTyeU6XQ3/HNCqzDYkuDUYdfhU+ZbwPqEB
 dVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684851536; x=1687443536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ke2iD7p31ed5Hxfz14QVVAbxkGlsZDMpq06KcFrVP+M=;
 b=LigVI/nMFIUx6OGgdzFC9PSkMDwJi2zYLa1a0iYHNsiE0sE6jqlXwGnu/xZTepQOo2
 3GtAMCZ7rmpmt0idZ/LJfG5wo87R50+p8aM1iBAcPEuXZ/l2JcYSljCf8Tnm1e7CfUSt
 xGF4WB12TTZOgKTBUWjk/cD6mRHk/BZu5P23XJrXJA1OX0q6QbxGIQdOnL1pb4koeZYy
 Yx52rCm1XnpV5X57H0usk1WRQxz7a6r5i0C45mkZiZn1TaAJx33ANIIKb3nVAs7OCyT+
 SkBlUkyoMWSQR1eKtOeUAVdgsIiHHSIh8odDoqdERUuFso+qUVEiPkhDV+UcAir2ikVc
 qL4Q==
X-Gm-Message-State: AC+VfDwC8jUqIDinK6hLkX7CuLmPcFQrb0WKO/tS7Z/tZIOff96jbfWJ
 AjuDZEfNVvaG6opUgGgkSjMQtQ==
X-Google-Smtp-Source: ACHHUZ4KT/pLzVhyOQeIUjAB48YuWlfcc3l19JbTrvs8RWD+KSEOVhSDRy/WBRpqbmTvPXE35Yfpyw==
X-Received: by 2002:a5d:4287:0:b0:309:7010:b869 with SMTP id
 k7-20020a5d4287000000b003097010b869mr9142074wrq.8.1684851535736; 
 Tue, 23 May 2023 07:18:55 -0700 (PDT)
Received: from [192.168.69.115] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 n1-20020a5d4001000000b003062ad45243sm11350736wrp.14.2023.05.23.07.18.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 07:18:55 -0700 (PDT)
Message-ID: <7a23a751-a00f-1a30-481e-97add73b3f20@linaro.org>
Date: Tue, 23 May 2023 16:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523131107.3680641-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 23/5/23 15:11, Alex Bennée wrote:
> Balton discovered that asserts for the extract/deposit calls had a

Zoltan

> significant impact on a lame benchmark on qemu-ppc. Replicating with:
> 
>    ./qemu-ppc64 ~/lsrc/tests/lame.git-svn/builds/ppc64/frontend/lame \
>      -h pts-trondheim-3.wav pts-trondheim-3.mp3
> 
> showed up the pack/unpack routines not eliding the assert checks as it
> should have done causing them to prominently figure in the profile:

Worth mentioning "even using --disable-debug"?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>    11.44%  qemu-ppc64  qemu-ppc64               [.] unpack_raw64.isra.0
>    11.03%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
>     8.26%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
>     6.75%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
>     5.34%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
>     4.75%  qemu-ppc64  qemu-ppc64               [.] pack_raw64.isra.0
>     4.38%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize
>     3.62%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical
> 
> After this patch the same test runs 31 seconds faster with a profile
> where the generated code dominates more:
> 
> +   14.12%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000619420
> +   13.30%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000616850
> +   12.58%    12.19%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
> +   10.62%     0.00%  qemu-ppc64  [unknown]                [.] 0x000000400061bf70
> +    9.91%     9.73%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
> +    7.84%     7.82%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
> +    6.47%     5.78%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize.constprop.0
> +    6.46%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000620130
> +    6.42%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000619400
> +    6.17%     6.04%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
> +    5.85%     0.00%  qemu-ppc64  [unknown]                [.] 0x00000040006167e0
> +    5.74%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000b693fcffffd3
> +    5.45%     4.78%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <ec9cfe5a-d5f2-466d-34dc-c35817e7e010@linaro.org>
> [AJB: Patchified rth's suggestion]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   fpu/softfloat.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)



