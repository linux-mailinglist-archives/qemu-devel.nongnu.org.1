Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0BE7A1F75
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8SG-0006BD-3c; Fri, 15 Sep 2023 09:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh8S7-00062v-2o
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:01:43 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh8S5-0002Us-Aq
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:01:42 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-313e742a787so1384013f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694782899; x=1695387699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C+iDFxDOqL6zcmkWpZ+5KTpBdccZrbqp0qmkhNcdHig=;
 b=IqYmIMrX7uQsTRmWkgeA4HLXT7lOi/klA5Xtu4fzPGj6tQTnkJvQvN3bU+vnW9IzCf
 lQwjnQ4VMvb0Rbs3N7WAnzeEDRVcPulGn3pBw6h8ltmYhpeRchnLatHp0aNvqxx342iY
 6R8kov5cw1hz7D4QWm0h9MVUSYImGau57YMhH/ey/KWILQKcgIAMz1p782B8UuqR/Pao
 mwM0o8PyR1t4A7pk7pxeLBe1O5EGuzq0NRZvIx385V99/5yQFCPo9bSMc/+DRgwnv02D
 I0yh8u35ndZdKWuoWU7wZH2iYk8KD/+CyIbPULnAZnM9WDeiDTCfNyhFE8+0CcEthBUM
 OZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694782899; x=1695387699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C+iDFxDOqL6zcmkWpZ+5KTpBdccZrbqp0qmkhNcdHig=;
 b=c8phAZz/karxs2Jad+ibhAmLOGVNS8vgtBl5fqxwAB1LGAptx3Nf4vUc6VqYWvZZm7
 WuE4L9RhZsVJVpxceJPbh+35dxqlbTipM+W/oJjovXFaMjAkIAhNArjpruckl2jjx2wn
 QXwwyxL6v5LgRgVTR7kA+9O9+FnxcnL6XwZQ0lP/gdazNbb95oskIK0rYmK9sKvsEKwE
 siDjlxMvOQMuXe5wV4kQ9jDSbzjJHaUCCLagd2nuYvLhTrdnSNB2dJSovC8ZeiI4Zi3X
 sfME0w0Um3GCF23CvwnHjA4Bx6x96FVxuRgFNnDMnMagax/VKWcsLjs03eteIbh+zRZx
 NuuA==
X-Gm-Message-State: AOJu0YxCl86aj8MpWy6L+/FoKfaE/+kx4V8yH6QhdyzE+OQ1r4GMqUQ9
 Os5AUqajvlfPphclv0h8rvr2MA==
X-Google-Smtp-Source: AGHT+IGHOYEw6pcL6w6ni6umg1ujbQUA98/L8YQ5GcJov0ZEx1fg9VHRx2h4GyT6DsJBn/Qpq752hQ==
X-Received: by 2002:adf:e28f:0:b0:317:558c:c15e with SMTP id
 v15-20020adfe28f000000b00317558cc15emr3267651wri.27.1694782898439; 
 Fri, 15 Sep 2023 06:01:38 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 26-20020a05600c231a00b003fe1a96845bsm7511078wmo.2.2023.09.15.06.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 06:01:37 -0700 (PDT)
Message-ID: <738f9a7c-4364-3d2b-4a8b-448dcb5b038e@linaro.org>
Date: Fri, 15 Sep 2023 15:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] tests/avocado: update firmware to enable
 sbsa-ref/neoverse-v1
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230915113519.269290-1-marcin.juszkiewicz@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915113519.269290-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/9/23 13:35, Marcin Juszkiewicz wrote:
> Update prebuilt firmware images to have TF-A with Neoverse V1 support enabled.
> This allowed us to enable test for this cpu in sbsa-ref machine.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 25 ++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


