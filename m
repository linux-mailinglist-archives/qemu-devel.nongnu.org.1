Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B1883B574
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jan 2024 00:11:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmPH-0006i8-58; Wed, 24 Jan 2024 18:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmPF-0006hO-2O
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:11:41 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmPD-0003up-Fb
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:11:40 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so140991a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137896; x=1706742696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XDkAiNGuU47Lf9GHTQcJgmICrLyRLIEDQVJIdDAwQeU=;
 b=OMt0DXZIq+a7SVKYvpRmgZ7DDdEPacr7iURF2UPuOPx6FUzNWsXjE/0Cg2TD0lbj07
 3QsFYP57ebCGMFUdIdMTbVtZ8hS+5oR/CnyX/QHQPXMWIo/2vSftdJBYgSlcAeovjYtL
 vJWw/Rs7lUNyQfCJuQkmWo3s7rkOLPTNPT4uA+epPW9uoIwzTfPVT4fZwi3HdAVbq8o6
 szexNHDa0HFkkFcn/UG70kuoCXOmKi/jhshhxCkSxaWSBm9b6LFkdwN3MCn5OGsK2PCl
 dKJQTFGkRqPvvJlbCv0qqiu8GgmdtJEPE6hM36g1h31bGfi18Q/CHi1YoOvmXuuzaNmA
 2Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137896; x=1706742696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XDkAiNGuU47Lf9GHTQcJgmICrLyRLIEDQVJIdDAwQeU=;
 b=DFLnI4Cdx6Iy+hhD3a/4BrSZ8qZzptk46kX8Oxk545+/c1XmCuExpEXDhcXOliyhrI
 LVzasgEytYd3a7xEidQ3cXsQQiav9Es8p+WKA+b7iPvrTAjtTnIfX+RcvdqEbCsM0ZV/
 6N/rmUmC4nWwGaaACe7CqTGye1tncuw2pBDjJaM3IPNOawiuoRndrjZRB2zZ8FtZNPvw
 CetmU0BbzGahzm/mre5sNEuTAy4vHW46lKoY4bRpX3tPCSPRUtpsiRu3DLf8wB2sxTKK
 s6bInTuhcUn1BVgb/xsrmM3U+ZlEglo5hSODjtXJ3uqJB7ul9RD8Yi6s3YCHhavUthcL
 a/wg==
X-Gm-Message-State: AOJu0YxqWAQgHjaOoWh3wSdKIqqbl706b1UVFjAfgC7CEPT+YOlKMYzD
 9qHNvFtTvcaN6GMYLALbKM9/LMKOvx1oRiTgz4Fu6lXZ/6G+C2V9hA2THNWv/O8=
X-Google-Smtp-Source: AGHT+IGLhTB9Ki6xXgWMCXAWw9vFKuU+73QutgL1XfD8FtvBIKCLfdyEsKkIme/D360A/3V2MBSfBQ==
X-Received: by 2002:a05:6a20:1454:b0:19a:a026:4e7c with SMTP id
 a20-20020a056a20145400b0019aa0264e7cmr134356pzi.49.1706137896214; 
 Wed, 24 Jan 2024 15:11:36 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a056a0010c100b006dbc750ea5asm9684090pfu.196.2024.01.24.15.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:11:35 -0800 (PST)
Message-ID: <62908ce0-da58-4f36-a88f-22487231fb08@linaro.org>
Date: Thu, 25 Jan 2024 09:11:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/arm/exynos: Add missing QOM parent for CPU cores
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Gavin Shan <gshan@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240123222508.13826-1-philmd@linaro.org>
 <20240123222508.13826-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123222508.13826-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
> QDev objects created with qdev_new() need to manually add
> their parent relationship with object_property_add_child().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/exynos4210.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

