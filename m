Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C3372325F
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 23:38:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6HtO-0007xo-3a; Mon, 05 Jun 2023 17:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6HtM-0007xf-43
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:37:32 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6HtK-0007jr-Dg
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:37:31 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6513e7e5d44so3324442b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686001048; x=1688593048;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F1ES6yRuypQH6sktpQx2bzvGmtVedlRIWkgsbG60OEs=;
 b=xQBq8x9ybl6swteU0tNzOqxRoIcd57fMLIkpxWAnVFcsclqZG70EtiOE3sflcaWQ6M
 mUpSZ95Vl0DCIolelXmz4MV3NznLJ5lep7Srfdtc3YbnxMGR5j2KUVyRp65jNKIRRG3K
 4lzDbDA4+X+9USLzg9MqhNPsDGYoj26Jxy+VTXWH0G/MJoCCt6oxQBQtBnmZDPPnr+2A
 V0ge4UgD5er6mBJfyu6UrVdfWDkSEoJwZecX06emW0lyAeM93zEVe15K2JjCfy8PDvE6
 8tMKHlbUnyiPm9ObUst+plej1gNPOM4HEMN3HJMmYWM1qcm9AzhbmO0z2G7HI04P8ECz
 Vxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686001048; x=1688593048;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F1ES6yRuypQH6sktpQx2bzvGmtVedlRIWkgsbG60OEs=;
 b=b1z3Vw3mplRveTpiCmoAg97Uu0/faUpWxrp2M5PSsv+vAMRvvJndbT9l7ZIlunLLFH
 Vx4LZ16PBjSh84QDfqCfCg6Qs/u4yAlBG7bJDbSkocH+vsoGZZaLHBWWI8WgcS40vA7p
 QF22dn1wwLbpOt2O6FuUMyjrxxXBtUnLsf6oUyLSbbZKvOiNaELdJhVJH8VMRWyowbDE
 anMIZwxy17FPuc6VFnv9mfECpeIK4yV5eljUn72lg7E1nx1gqVV4llutWJkDDtIVqnPz
 gNCOL4yfVmw5yCTVe39DtEnB7DvsZ9JnfrF/5VAJpEG3FjNiEmOBzt01lLFplHtkV81Q
 avsw==
X-Gm-Message-State: AC+VfDyLzOfUlV6bF46B2Fjbv4ljP2cfqLRepuIx5Q3eSxUe8PAXxJqq
 HkbmXauj5LKAIEbuUBdvhjxKP3gsGeyLBJ3G6jg=
X-Google-Smtp-Source: ACHHUZ5ESrI2YIY0hkl2gj5Otg8oS/yI0AK1LCEI2T/psuUYX88L9EMMeLKSwg3CtEcVb+3aa0KQOA==
X-Received: by 2002:a05:6a20:1612:b0:110:390f:6806 with SMTP id
 l18-20020a056a20161200b00110390f6806mr243885pzj.57.1686001048345; 
 Mon, 05 Jun 2023 14:37:28 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a17090301cb00b001b027221393sm7015501plh.43.2023.06.05.14.37.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 14:37:27 -0700 (PDT)
Message-ID: <d10aee6f-729b-8df8-eecc-c9163680773a@linaro.org>
Date: Mon, 5 Jun 2023 14:37:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/52] tcg patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/5/23 13:14, Richard Henderson wrote:
> The following changes since commit b52daaf2c868f2bab102eb5acbf55b2917f46aea:
> 
>    Merge tag 'pull-block-2023-06-05' ofhttps://gitlab.com/hreitz/qemu  into staging (2023-06-05 10:27:31 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230605
> 
> for you to fetch changes up to a7f6911c127b1dd1b8764e03b0ebcf0a227a15e4:
> 
>    tcg/tcg-op-vec: Remove left over _link_error() definitions (2023-06-05 12:20:16 -0700)
> 
> ----------------------------------------------------------------
> Build tcg/ once for system and once for user.
> Unmap perf_marker.
> Remove left over _link_error() definitions.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


