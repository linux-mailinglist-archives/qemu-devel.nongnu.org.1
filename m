Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA817E2F5A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 22:59:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r07c6-0005JL-Ie; Mon, 06 Nov 2023 16:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r07c2-0005IF-If
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:58:26 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r07c1-0004wY-4b
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:58:26 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso4242139b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 13:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699307903; x=1699912703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dZpMJE1c0gfsALxbWCk+QF0J0aBL44CPgJ0W7abvdp4=;
 b=sVJyQlj6wtig8GqauHqnERXxIX73x6sasQFrCHgwwWlSbVwwW0TO+cCu5A+eq3Kbl+
 3D+HvOYRjR7FG1DlSl3n0FR8rFn3o2OFxpUluVSFhDHfTWNaj6bErZj8seIQKqrkKjXD
 Da9P4Mb4gn5qi3OROFoz86la5now5arGTSdGHLNbv3K5JsKvg3thvJxgbSatlZX93/V6
 pkYU0+Zj8a1IKc7lALnBvsDkrwiFJndhdoclGkveYSEiADowwvGGQ8L0ZEAeKIN8u0+F
 OK9IQcgMv/KYADqXOEsbVE87DvEssdZc9RzLx2YvYcS2WNSz0Ij1+HCrbdWJN/vl1h1H
 FBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699307903; x=1699912703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dZpMJE1c0gfsALxbWCk+QF0J0aBL44CPgJ0W7abvdp4=;
 b=l1FoNKBXMuGdbYIzDHdnBs4BvsW/WHCjSJzIIN4KJ/uROX65/2wvi1karQwliZirQ2
 TWjH/2fBe6Ci2MFlafYAb5b7ErxR/s5+LnS2/aBEjRoF6DXtPIEJfSCzPvwgm3yXVkkB
 wNW+xsGNAbybgAFvF5R9kGWoyI5JCQOw8Yf1shu6v1dvF4XdavUGRafmUhupZKO6hyIh
 B9iVObxx0R9Q57wGXz95BaTzgqlN3To0f5jumNIY+zWWbxjOfjnfXC/E/b/nywMWsjRn
 p//Q5yj6iRvDLNwOrZTVhwtBaXevgEDihxToEpvGd2m6+lTaCbzRGoha9iovzeV2fZsX
 T0zw==
X-Gm-Message-State: AOJu0Yz4kwo4w5HwCuYuiJCI4ovJFHMsjrgOhaS883A+iVu17lhfSIaM
 Mc931cOs0NlQozO15QrqY4+eNg==
X-Google-Smtp-Source: AGHT+IHty/FyTZ0UsVH8gGAP4efkSdMhJ8ExGtkVMeTN5hPrgHTxPWtwftCc4oKTy4lVY4Yf3G1WXw==
X-Received: by 2002:a05:6a20:e109:b0:180:d9de:2d5e with SMTP id
 kr9-20020a056a20e10900b00180d9de2d5emr21547792pzb.39.1699307903344; 
 Mon, 06 Nov 2023 13:58:23 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 h22-20020a056a00231600b006be0bd6a4d8sm6044914pfh.36.2023.11.06.13.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 13:58:22 -0800 (PST)
Message-ID: <397df99b-897f-4354-94fe-696960d3ef38@linaro.org>
Date: Mon, 6 Nov 2023 13:58:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] Revert "tests/tcg/nios2: Re-enable linux-user tests"
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-23-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231106185112.2755262-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 11/6/23 10:51, Alex Bennée wrote:
> nios2 signal tests are broken again:
> 
>    retry.py -n 10 -c -- ./qemu-nios2 ./tests/tcg/nios2-linux-user/signals
>    Results summary:
>    0: 8 times (80.00%), avg time 2.254 (0.00 varience/0.00 deviation)
>    -11: 2 times (20.00%), avg time 0.253 (0.00 varience/0.00 deviation)
>    Ran command 10 times, 8 passes
> 
> This wasn't picked up by CI as we don't have a docker container that
> can build QEMU with the nios2 compiler. I don't have to bisect the
> breakage and the target is orphaned anyway so take the easy route and
> revert it.
> 
> This reverts commit 20e7524ff9f0cab4c9a0306014d6f3d7b467ae1e.
> 
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Ug.  It's definitely time to deprecate prior to removal.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

