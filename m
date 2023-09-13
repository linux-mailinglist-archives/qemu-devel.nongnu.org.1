Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB4479E7EA
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:28:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgOxp-0003BZ-Kr; Wed, 13 Sep 2023 08:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgOxn-0003BD-Mj
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:27:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgOxl-000218-7Q
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:27:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31f8a05aa24so4557336f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694608039; x=1695212839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zv95AECmAp+x0WkRUMICkPH4BbqoKl12iX5o1Ycs2q4=;
 b=Zaf0QpDY9umRFcpxM0O9IFRVQwReqRUOtiXDqGnF9fvcrHThWnf5AO+5sTLoZuPeRz
 4SRWat2Um/P+vQRF/GKrAb81mS1LXIK+t236chhLWxZ50RUBcygZfN6SrquFcBPazpYE
 TB6dLNLhZsd9ShOHkJYgiJMRru7PLVj5iPkadzP5wj3kpNj/V4Hq8EPNwvog1O0xK90q
 1nPO+UT6JyVc0vyqVu2PEe3tkPgwDFjnEUy5xXKVpj3ml7I2FGjc9Kf+BNSizLazvNWy
 ERcO0rMCT1StgUJ7IhPlubCobnYH735GicIDzz9vbFdVtUSs8t5fS1YTuWWs6qhmYl+m
 Ji5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694608039; x=1695212839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zv95AECmAp+x0WkRUMICkPH4BbqoKl12iX5o1Ycs2q4=;
 b=t5zyRB4reTPfj2bn2bGRD5dvRCgyHg8AENfcE7gThAMr99jTPCBXQvoqyWcWbyQfDI
 4ITHPZlo6rNgfdpFeNbVUfYh+XjMY90at7Ugq5XRRj8XPNVs8G/SUr6Ac1b94/tilYgi
 bzvUzE6UBlxt44KnJeTOgtXbp15GtbCLx7pV0Oc47oDDSOiBx3hPkiodEuwiwLvDxz38
 fE30fj3gnYwceyjpk3GureCsCgiVlLt7+JU9/J58Ec7Gsvp5+PS1NWWWroSt2befZczt
 dAjzZAxKJCeup/G/1I/tzY2f6aXQiWvf4+YZs4ykSile3jYNhQeSBk5utIWCr1vjvhzZ
 dl0A==
X-Gm-Message-State: AOJu0YwUzVm1IKdve+OQa0D06+dFJV8PJuH/rEZJe7o2RG/Gc7lEvhUK
 e5J/Bib5V1dtfifuyClVdd9ONQ==
X-Google-Smtp-Source: AGHT+IFeBaMFkdhAOz7TmFLWYAom1qcsbJe0CM2dI1KxS8ugA33IY+mAlGnEmjmy4ywL2dh9YnKVSg==
X-Received: by 2002:adf:f08c:0:b0:31d:c3d2:4300 with SMTP id
 n12-20020adff08c000000b0031dc3d24300mr1792843wro.71.1694608038681; 
 Wed, 13 Sep 2023 05:27:18 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 v26-20020a1cf71a000000b003fe1630a8f0sm1933698wmh.24.2023.09.13.05.27.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 05:27:18 -0700 (PDT)
Message-ID: <da9342e8-f38b-9276-60bc-62594651a4a9@linaro.org>
Date: Wed, 13 Sep 2023 14:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL v2 0/1] Merge tpm 2023/09/12 v2
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20230913115449.502183-1-stefanb@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230913115449.502183-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi Stefan,

On 13/9/23 13:54, Stefan Berger wrote:
> Hello!
> 
>    This PR contains a fix for the case where the TPM file descriptor is >= 1024
> and the select() call cannot be used. It also avoids unnecessary errors due to
> EINTR being returned from the syscall.
> 
> Regards,
>     Stefan
> 
> The following changes since commit 9ef497755afc252fb8e060c9ea6b0987abfd20b6:
> 
>    Merge tag 'pull-vfio-20230911' of https://github.com/legoater/qemu into staging (2023-09-11 09:13:08 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2023-09-12-2
> 
> for you to fetch changes up to 07160c57e47ce38bd256af3eae0481543fb52626:
> 
>    tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR (2023-09-13 07:46:59 -0400)
> 
> ----------------------------------------------------------------
> 
> Marc-Andr޸ Lureau (1):
>    tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR

I recommend you the b4 tool, see:
https://pypi.org/project/b4/
https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation

