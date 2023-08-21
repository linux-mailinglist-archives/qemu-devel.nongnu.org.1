Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E542B782429
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:11:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXz3p-0003Wo-6R; Mon, 21 Aug 2023 03:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz3m-0003Wc-Ns
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:10:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz3j-0007zX-3R
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:10:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-313e742a787so1756436f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692601841; x=1693206641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Vb3HsVe0sjyxbHGjFaCfVvVILOsB6MRnUmU7CcV7XQ=;
 b=LNteCwnO45rTrIH4d8Fn/Q1KW7ycW6eACqkjbE+MMfxdQ8owBpsVnh/Rc7H7zvszSH
 TLX6FaDSlZL6VdYMUTlpfcV41mSNUp7/XEglAy4fUDXjfMeOZGM/+GJz2DgsDyLOvZCA
 RS/j0X8n0S121O6tzAYEyNe45HAT92wIN3ex35p9/J5w56U6TKih9AWjQNrlHUfM2J0X
 RmCHL/yxTC/nGqWwxJbByn3tj+SAUGmYtx3K6Fd6TN5LT8gIuGorvD/JOfDB3RxuhYGw
 umnyUbcbyst/U7jqkcatpRCGm/BDPRTTo7IYezV18frIJdYTQvI2BayZ6aMGUaKIG5Z9
 GVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692601841; x=1693206641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Vb3HsVe0sjyxbHGjFaCfVvVILOsB6MRnUmU7CcV7XQ=;
 b=OXahtwpSNE10hZWp2or+zZdYk9h/aVemWXXqAyqZ7PG79pn+CGrrRAXFixKn+sI3Jp
 UfDTYLgjvEGN/Pd2gIt3iBpivm/iVHEc9aCDf8OoV/JKTTVcxAnZmveN7I18MfqqxJuU
 zo6w5xzltMC46cJlklgx7HoJFgkJUwc9Tr2W+FcsENMayevdCmJl+NWREZ/nGlx4ENVm
 ICkF7UldmV/BrM8tBmYEYzPEuNinz0R9zxKW0gCKQudteKioaT0nTZzvLcXqRD5zzbjI
 CJTDYEy+XvxHp4bzcrStPBwNxf0JxEcHodbZpTCVs9r3cZfK0izD1T16wBPuj/Z7jjGg
 VwSw==
X-Gm-Message-State: AOJu0Yxz1aWxhTIkJ9D9rBUezqeg6BfA490fDQufHIOkGSWdtOFITp/g
 lX5+c0UVnuKxUvW9HHgR074+iN8aUgowiX303dk=
X-Google-Smtp-Source: AGHT+IH3+ecERIjWEXA/smcmzoVPgFGiU3zVFEYfBhKcpqN5eqgIub0ro9rH5sBpWhGZArGrnXnJvA==
X-Received: by 2002:a5d:4a8a:0:b0:317:f3fd:21b0 with SMTP id
 o10-20020a5d4a8a000000b00317f3fd21b0mr6195623wrq.7.1692601840790; 
 Mon, 21 Aug 2023 00:10:40 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 i14-20020adfe48e000000b0031c3ee933b5sm3339026wrm.108.2023.08.21.00.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:10:40 -0700 (PDT)
Message-ID: <1e92d8f7-2741-86fa-16e6-2a9cb441d172@linaro.org>
Date: Mon, 21 Aug 2023 09:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 02/23] tcg: Use tcg_gen_negsetcond_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
 <20230818221327.150194-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818221327.150194-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 19/8/23 00:13, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-gvec.c | 6 ++----
>   tcg/tcg-op.c      | 6 ++----
>   2 files changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



