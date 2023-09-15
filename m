Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF72F7A1F37
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:52:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8HR-00079C-CM; Fri, 15 Sep 2023 08:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qh8HO-00078e-RD
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:50:38 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qh8HM-0007Vr-4h
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:50:38 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c3d6d88231so17818275ad.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694782234; x=1695387034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xuvzmAXdYolPe+5g4w18hDVqLwDr3K6FEZPBwiW3JfA=;
 b=c+aIlc8q52fClJaLrIDqAvRznbNmlkWn+XxzGDeYWJQGzv5sN1KAdBocE17zOFUQo7
 xJt8h/vBXmWKudh2IFcIPZh4ZTTpgr2j2xG5AtDMLTiscfNGu9qFbJ8TeQleB+TQ4xSh
 SeWTyHLAKrOM7eg69vdI3bvoCxwwNjZAnPw49eHgBjg5PO0jeVnBxReI12q6qRfnv3se
 SNaPFNe2q8JqUl6WGH1V3hvxz765U9Ag0E076cOudggdEVi3xCI24Bx/X7ETXZa8mM6p
 ZKUv2wmUypnx2HNBdLhMlnBwkAMmdfsZvvhjdZRWBge2OQMxBJ8V1KNQguFg+uXQAcOq
 9gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694782234; x=1695387034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xuvzmAXdYolPe+5g4w18hDVqLwDr3K6FEZPBwiW3JfA=;
 b=apm+zE6Sqm6iDSSi5uuOSr5IVx2MMmJ3AMvmm6oh05Znaoep4oHlBOSgXeIVvr//dT
 D65KVBRFYTzRmhCHoRqXa87CwVM/8AOXXNa9oq+74EjPTh3uNcyMyj89+/dJ8KZZWIDO
 A28hnigDFna1yc5FTxam8VKGsrtfYaTxQYuZTUqzMvCUeR2j0XxSDPRtQECqdgpg5sxl
 L2COkBXXistWo3L7QlmnCxGDG5yRsNoDC95/56DGUwQEVyrplRgtn45BB3IqEAfev+zG
 2ljyv/72l8VYoiiQDLD6+BNnYofHC2s0j+dP10kWgWFwVMihBsUW38khEqwC/yV44R3F
 FxOQ==
X-Gm-Message-State: AOJu0Yx2jrLDkcY0fffkUFkbzvJq66UUmoH3hf3vTlSBbJAdAk0VnG9Z
 8SEkMpafAPxiTh6EqsdcLiwOew==
X-Google-Smtp-Source: AGHT+IELpO9EN50AJYjxQLJEdqYNyZ4H+8/0qYDWCPFjvY/20R8+fMfSdGUOmHaIsVS1cWJIUn7Skw==
X-Received: by 2002:a17:902:ce82:b0:1c3:6163:210a with SMTP id
 f2-20020a170902ce8200b001c36163210amr1463735plg.60.1694782234388; 
 Fri, 15 Sep 2023 05:50:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jg13-20020a17090326cd00b001c0aa301703sm3415230plb.63.2023.09.15.05.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 05:50:33 -0700 (PDT)
Message-ID: <1e7ac58f-907b-826f-5a06-5caf8fb3b963@linaro.org>
Date: Fri, 15 Sep 2023 05:50:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] tests/avocado: update firmware to enable
 sbsa-ref/neoverse-v1
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230915113519.269290-1-marcin.juszkiewicz@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230915113519.269290-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 9/15/23 04:35, Marcin Juszkiewicz wrote:
>       def test_sbsaref_alpine_linux_neoverse_n1(self):
>           """
> -        :avocado: tags=cpu:max
> +        :avocado: tags=cpu:neoverse-n1
>           """
>           self.boot_alpine_linux("neoverse-n1")
>   
> +    def test_sbsaref_alpine_linux_neoverse_v1(self):
> +        """
> +        :avocado: tags=cpu:neoverse-v1
> +        """
> +        self.boot_alpine_linux("neoverse-v1,pauth-impdef=on")
> +

Second function shadows the first?


r~

