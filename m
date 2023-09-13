Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2CC79DF97
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 07:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgIsp-00048M-Ay; Wed, 13 Sep 2023 01:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgIsa-0003we-Cn
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 01:57:38 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgIsX-0003M3-MH
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 01:57:36 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so8245837a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 22:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694584652; x=1695189452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hNHYnF5MVX/n0/0kyyaXDZ8q70ZJruaqNi5MeJ0U9Fk=;
 b=Z05qJaWUaf9lArDolaZhybgrgovi/ERSe1CNsBNriCuTk2RtyrHrE0/Dnu19aL/5fN
 Lkq8+OgRkuk9bN5ZawaTDb4N0LnGnhIyhHbNKjier8lI80BDGoo58ZsDoTYCwZnTsyhS
 IE7q66HEVMvmcy5KagMJ0UFr+RewgdAZbOO7SrSv+3XCZeu0ilplGnrIQRX/RBTSteEr
 WYhRmrngMTfKOjedN4PJPiPaRTFIo37dFu9yScm5TA/wTgHK/0JkDQ6lsGPW22nmLKwY
 zN7Tto0NjUXILTpxKi7ZtBIx4UH2Htha1tmCIbYePP9sLO+6qE01MkJ5d/dCdKHeBIna
 KkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694584652; x=1695189452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hNHYnF5MVX/n0/0kyyaXDZ8q70ZJruaqNi5MeJ0U9Fk=;
 b=JL5ha71Q1lMEP1fjZsANUfDMCFBnbnz9Ehlcn4PYAoW2X33wAiEkeDNWxZAu3Z9q2B
 wwIwq0SVHRScYZ4195HEW7ywU7I4U6A+E39gBud808CSWoPncmjGMbvXOTmuzhiq7Lj4
 d1rbGXiavJgJrjcoaKDeXXYDodtrY//w0iPCgTXoEAY0Jx2beQUTJWnFiHiymuBDCSpQ
 zDN992ZjZM2GMMxXldNgb1H+VhvR36bwn2Tc2UqtueYtNihhCHpe4avULE+rfljfxpHb
 GmJVOBym922V66J4kvINVcFr13D4Lor31STG8eNiIrulxR3xt7FLxzEjS8ome++i2sPH
 Phew==
X-Gm-Message-State: AOJu0YxbyFPiJTkxsGlqHBBF55eSOQvBnVbP8wa6ZCvZ3JLfRFkqPiLa
 LEkr5BCELFHZEV2WXOYVKMfgfw==
X-Google-Smtp-Source: AGHT+IHgk4fOoh4iW2Xzar5MXhxCJIWqeIOQN7ZToclP7hl5dXTiQfsLIp2TanqIc30Y6nFFESnmxA==
X-Received: by 2002:a17:906:109a:b0:9a1:c44d:7056 with SMTP id
 u26-20020a170906109a00b009a1c44d7056mr1244141eju.26.1694584651996; 
 Tue, 12 Sep 2023 22:57:31 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b009a5f7fb51d1sm7798345eji.40.2023.09.12.22.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 22:57:31 -0700 (PDT)
Message-ID: <7d1e8d40-b744-aaa8-c47f-478b4848ada2@linaro.org>
Date: Wed, 13 Sep 2023 07:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL v1 0/1] Merge tpm 2023/09/12 v1
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20230912214110.482744-1-stefanb@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230912214110.482744-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 12/9/23 23:41, Stefan Berger wrote:
> Hello!
> 
>    This PR contains a fix for the case where the TPM file descriptor is >= 1024
> and the select() call cannot be used.
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
>    https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2023-09-12-1
> 
> for you to fetch changes up to 8557de964dfaae5c6eea09d488f85f4aa6cb3ce7:
> 
>    tpm: fix crash when FD >= 1024 (2023-09-12 17:30:12 -0400)
> 
> ----------------------------------------------------------------
> Marc-Andr޸ Lureau (1):

UTF-8 mojibake :/

>        tpm: fix crash when FD >= 1024
> 
>   backends/tpm/tpm_util.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 


