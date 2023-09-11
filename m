Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1544C79AB89
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfoPE-0008UO-Qn; Mon, 11 Sep 2023 17:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfoPB-0008Tv-Qg
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:25:13 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfoP6-0007nA-Uz
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:25:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68fac346f6aso1905107b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694467505; x=1695072305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zR+M8al6wz8tv7IuflETgml5bNOl/d4aTuvPmks6zGg=;
 b=mvJqMsJ6cU9JC46CvJsMYXWMXIA86/aTeU2UoOAKQ7MxoKXJ+TQbAP+++xbMQyywuj
 3/t8/vl8bjAfWpMPPgz0Xe1Tc8C0sr3sD9MXdyq4YweHo0x6rqq3t6icds/rKdhTjm7s
 FbefviTGj0Fzls6nKUh8EGwLSN5J0F01iJmCDmp8uxEVaLwAkGD2VPtKDxyFAV26gNLE
 IaV2PMrYrnPx13SQhzbvBbNKz3rI3t8YcZ/mzY8d7bcLxB7rbXFkWtCcHMiqWU+5G9ZB
 8l6DI/OFDn8qJJ/ZWO8dw8UvMaXmlclbVxmjoB0Kd+Cjm0MF56ca9sUCKQTsyDF+RrGx
 JN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694467505; x=1695072305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zR+M8al6wz8tv7IuflETgml5bNOl/d4aTuvPmks6zGg=;
 b=BSv4h/5LTm33hQKcoCKkVXGfX04g0vVZj2BSAU6RHcUxvwceEi02fxNEwtt1E3+yYy
 +e98Oh2PG7NABtFewVQR2y/NXeU6KJgbh4zjRBIxCiWobVoUUolgsUt3OvZcGZKFro6+
 2TwBOKclmYZXs5S7YzYGHpbqUQI/Nrv9B+yfPPY3IJkY6WVcCcjdOnoa+zKDpY458LcO
 wp0lsQRgb4NCBblHT9J9Bn3/84vXlcCR24MKeFBjZWuYeQiOrWYcltCTAYD1O1munGd4
 3g19Beawn3E0u6cvq20r0X6LUQY6tVjAVMsIJmUJESne17LHiS6c0cHdFkHBqRo1A9zz
 ITaA==
X-Gm-Message-State: AOJu0YxKbEJSwjBP/ix83V+AcKYh721EFZFndnQikpjO3IcvUA3lP3hE
 qkGkzHOTaBkeIo5nJ2XuGagGScYyDIup5B7yato=
X-Google-Smtp-Source: AGHT+IGeLbKP4zGSdyjJn/XR8xrJ6tB0NWK1L6pYt66kjsSx9aF1SmVk1OEMpHbU9DDDaDdH2j3HtA==
X-Received: by 2002:a05:6a20:72a7:b0:153:b245:50ff with SMTP id
 o39-20020a056a2072a700b00153b24550ffmr13193523pzk.40.1694467505358; 
 Mon, 11 Sep 2023 14:25:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a62ea04000000b0068bc44dc40dsm5996425pfh.34.2023.09.11.14.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 14:25:04 -0700 (PDT)
Message-ID: <f69c3e53-ca9c-9eae-f37e-13722e937382@linaro.org>
Date: Mon, 11 Sep 2023 14:25:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 20/57] target/loongarch: Implement xvaddw/xvsubw
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-21-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-21-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 9/7/23 01:31, Song Gao wrote:
> This patch includes:
> - XVADDW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
> - XVSUBW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
> - XVADDW{EV/OD}.{H.BU.B/W.HU.H/D.WU.W/Q.DU.D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode               |  45 ++++++++
>   target/loongarch/disas.c                    |  43 +++++++
>   target/loongarch/vec_helper.c               | 120 ++++++++++++++------
>   target/loongarch/insn_trans/trans_vec.c.inc |  41 +++++++
>   4 files changed, 215 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

