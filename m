Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1C370E1ED
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:38:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V1U-0001N4-FZ; Tue, 23 May 2023 12:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V1Q-00011g-O3
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:38:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V1O-00022X-U8
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:38:04 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30959c0dfd6so4777757f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859880; x=1687451880;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KyoN6LP5mG1/U4UiMixPquLQpXRKahotRDSCKp8OEZo=;
 b=Hsql192BAxGD5LtCe5iX5T6HEMg+Fi3fNsRLWpIL0ID17f0TsQ1oQzi96tUSix5A6t
 Wtorb/+IiJwFWKvqNIZF5t9aXkt6GGcAV8LMkRMU9Qy/klrZwTOz0BOmmgMALWYh4GT0
 jtyrZPkoV0elqunKp4G3yRdEcU1EqO/W0KfUJuOC0x0BwRpkyOV/sR2D4U64mGkm2Y2T
 Y0OT0e4sd6mvstnEWVD8OOyRXYBIss12YwODXUZZU2FnrDFM6QvSypj9L9Dqw538G4Db
 n74zE6DTRtmwvXv35qVXnJGQAJFLwpfW+3Z7iwkgPlhmjbHK9uf+8/g9dXCNZmPu51S2
 8KkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859880; x=1687451880;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KyoN6LP5mG1/U4UiMixPquLQpXRKahotRDSCKp8OEZo=;
 b=gbDNWmRcuPV1/5nh84ODjUXiF6Fmt6gYKP90X3Q3A2TwiX11UzqHIPBGsSr70tEtBL
 Op4SdgKgxy7hL4Ysky8tuqs/bBgBFLwBhop9f2S2VyC7Dg79W66QkmsKTZDp2ZlIRjye
 rZRlk7r4lE1buTlSU6JYlR25zAxTAk4v8byoi66EUpCJswi8Q2DjUdhKSU3qMac6SCm9
 4Tcwtsk+IedhihhYzxm8P1fGwgvkhX7bkAMIGDTUW7lXHMt2LqufnnwCVBsVlBTe9ejd
 wr8HZaIGkqmNrGJFpthq80cVjhg65raW2dwO6vymjz7XvOHVijh/bHUmzDSIHDC/Z3sA
 4kVg==
X-Gm-Message-State: AC+VfDwbNUs3BplGy86/K1Sd3iKC4kxfwBbBEnORBqP2d7ArmiIfoMUo
 XVV6QhRPS4sPvOcjbd05DnO8rNP3/B96cxeb26g=
X-Google-Smtp-Source: ACHHUZ7mHnU4zCReTwaq29ILmPkWnhZgHOssDuMriy0E5gSr1kwEy9l0RDm5bVJNjDrE87Wx33EYwA==
X-Received: by 2002:a5d:69c7:0:b0:309:4e2a:cf6a with SMTP id
 s7-20020a5d69c7000000b003094e2acf6amr10536678wrw.16.1684859880709; 
 Tue, 23 May 2023 09:38:00 -0700 (PDT)
Received: from [192.168.1.102] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 w4-20020adfee44000000b0030785b864f1sm11608186wro.65.2023.05.23.09.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:38:00 -0700 (PDT)
Message-ID: <a2eb78fc-c991-0a43-cd24-0e1735a1d57a@linaro.org>
Date: Tue, 23 May 2023 18:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 34/52] tcg: Remove USE_TCG_OPTIMIZATIONS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230523135322.678948-1-richard.henderson@linaro.org>
 <20230523135322.678948-35-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523135322.678948-35-richard.henderson@linaro.org>
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

On 23/5/23 15:53, Richard Henderson wrote:
> This is always defined, and the optimization pass is
> essential to producing reasonable code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


