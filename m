Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1427EA109
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 17:13:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ZYR-0003KH-0B; Mon, 13 Nov 2023 11:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ZYP-0003K1-Tj
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:12:49 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ZYO-00040v-0D
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:12:49 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c72e275d96so62631861fa.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 08:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699891966; x=1700496766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yl4xTLMqQWk2uepu3DZU0VGOTPzmuSp0w7NXUiLqnGc=;
 b=MaT2vzrqCdzZsio6YWLzJQ9pPQAckvTel6y5GGXt/juTj9JhoJniXeuCIM+mxKL3kf
 1xqYrbf3m5e6/mB85ETelXMBjkPdtdvF9nJLiQIMKw3ttjAVtTuhAZdNZ04OMmAhoTP9
 IE9NsrlFNMp1RUx4I/LzHYG6C2kj/OLyEXn0TmFNctfzxrUDMP8TcmVD6x56j9wgeQBE
 0H0J7AA7udUVZ8GjvC1x16kLrhcI+BpLSmJTmBzVa8RDT/XHjBguTnl0zSl3uIUUypdo
 IbXK3BH+/Ux1vQAtx7DjDbm0k5eok6VePVwUA31CVJS2bI8vf+JAV2o7dbPc7b7wjyQ3
 03lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699891966; x=1700496766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yl4xTLMqQWk2uepu3DZU0VGOTPzmuSp0w7NXUiLqnGc=;
 b=hGFI/shHiXWZ9Skm0iXn2GFASylVRuYpmmHAgoCOctYetbOPQHj57xFOW+pFPyuSO5
 fDmWVNi0OFmWCZHyg/1zq45vQ0tSmk+75QAYewle8z4Vsz3N1yN7HDpzbu85TsKA13ui
 q1CEYKUsvfY77ffvNqiule3+fmx2DrNSn4bRdg8Z+yhj/PxH68jWfqKMAtTI7QSo7m3D
 SdZWVmSMHqJ8hJyOJq8XTj7Ogl8MKvSdchPGQcIwmHMpwlaMjuPMChuLqhVTfaja2wSu
 yth9es4EN2zordlNbC8Uda7nPEl4NM/IrHPhmVvfHQWrGlSE2mqE8t6lPOplxNl5jw5H
 JWeg==
X-Gm-Message-State: AOJu0YyjZR/4ZNQrLiWW4SgyKNlEcSfPWB059gqGrTt6eKJzhV2QaCUg
 I63PdIkAiT3o7CV56/dRD0mMMw==
X-Google-Smtp-Source: AGHT+IEZEdL+8yFH1ZJRilpNLdRY2wE8/vLXRnFFQzh3Fsd9sVG49+zMJROFTKtDj+J66GzhRaZ3PQ==
X-Received: by 2002:a2e:9848:0:b0:2c5:2221:614f with SMTP id
 e8-20020a2e9848000000b002c52221614fmr4765063ljj.45.1699891966031; 
 Mon, 13 Nov 2023 08:12:46 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 gx24-20020a170906f1d800b009c503bf61c9sm4153662ejb.165.2023.11.13.08.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 08:12:45 -0800 (PST)
Message-ID: <8e4496fb-1e6a-4724-a272-4076d5b4745d@linaro.org>
Date: Mon, 13 Nov 2023 17:12:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/machine_s390_ccw_virtio.py: Fix
 SyntaxWarnings from python 3.12
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, John Snow <jsnow@redhat.com>
References: <20231113140721.46903-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231113140721.46903-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 13/11/23 15:07, Thomas Huth wrote:
> Python 3.12 now warns about backslashes in strings that aren't used
> for escaping a special character from Python. Silence the warning
> by using raw strings here instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/machine_s390_ccw_virtio.py | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Thanks, patch queued.

