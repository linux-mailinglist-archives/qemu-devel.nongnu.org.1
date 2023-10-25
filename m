Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B047D71A5
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 18:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvgeQ-0008N8-5L; Wed, 25 Oct 2023 12:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvgeO-0008MQ-C2
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:22:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvgeM-0000Gu-Pn
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:22:32 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so9229878a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698250948; x=1698855748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IEzb2g3H+9ZWf34OeCM0OT8HYheGdvlVV/rYsT/QtT4=;
 b=bqT/xb6Lhhmd9ZrOb4uAYRzQXfBAw+xaWvMmFWEle9qITr1QYRKMdcDTsE7ku1mB0t
 YstlA+2IWmFIZf0HWnWcXLdIbtwcgZ252TypQ9K/ryUYV9Om5/EHz52Tokx8sjN/tg/1
 T4bvHaiRI0RedukuIzCVYSOvN4kGlmBBHIvL1U31U/q514QSg/gAm9+iUpBED7wk41Nl
 xRCg6ZNaXBthcWjS7GKJFJQG+3VqsnpNvx4SYsUv38CArnjPPGL3UjtKg47GRrl9BOMq
 /UMoQ7y5nGTULC9f9hoOs9Ayc4tfJ2pWUdC89mZH4JPhuzZ9BBmN/qIZNiMrQ5u1qdQU
 auQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698250948; x=1698855748;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IEzb2g3H+9ZWf34OeCM0OT8HYheGdvlVV/rYsT/QtT4=;
 b=nH8sKNU8QnoFsGik7UwJlNKMU1Qi94ijLnqP1/ibfCD1Y3sQj5muzbAxKSELo1Hp2n
 H4AXPsbHrPAc/+t+FAj5SXMDji4RIzluLIeOM5i4ple6G4JccrqPvCUG1WhQHgnbaSoO
 spB1vATBVJ3uvC+hIG3uO1EbSEVN8mA9mliRuZBffTbJq71QGGinqzYrOWQnECNHWxzF
 PnbFjT3tkj+6YhjXOQdHpuWhF1TQk2JsUWxbjZL+PHvuKR//IZXSRq7mMZYF1/TE0csI
 wQY1Fzjde6oPT0b/D7o3MvxCosdKidapxRhwRT30G8J7+prRAFnDgCv3yJXG7Kr0Eahz
 e12w==
X-Gm-Message-State: AOJu0YyPX+sruqZ+WoeY78gmUyLRmDAUcstglZHiE46Q9PyaSXF0C+M/
 yZoQAjsUqa2u1XOnhmhGesypdoCSd83fLMUX/B4=
X-Google-Smtp-Source: AGHT+IEB75hE6xa+B56RgNxTLeaXGS98Wm5scAwy2g6Qgy4w8x+rdm4/tMUVY8s4adbb7h7j88DhYw==
X-Received: by 2002:a50:8d4f:0:b0:540:fd21:98d2 with SMTP id
 t15-20020a508d4f000000b00540fd2198d2mr629553edt.12.1698250947676; 
 Wed, 25 Oct 2023 09:22:27 -0700 (PDT)
Received: from [192.168.69.115] (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 cf15-20020a0564020b8f00b0053deb97e8e6sm9619212edb.28.2023.10.25.09.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 09:22:27 -0700 (PDT)
Message-ID: <e6ea5968-ca71-fdf5-aaf0-26c76a9e0775@linaro.org>
Date: Wed, 25 Oct 2023 18:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 05/29] tcg/optimize: Split out arg_new_constant
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231025072707.833943-1-richard.henderson@linaro.org>
 <20231025072707.833943-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231025072707.833943-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 25/10/23 09:26, Richard Henderson wrote:
> Fixes a bug wherein raw uses of tcg_constant_internal
> do not have their TempOptInfo initialized.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


