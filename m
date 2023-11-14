Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 174287EB1A4
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:11:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2u7a-000053-Qv; Tue, 14 Nov 2023 09:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2u7P-0008Vb-6g
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:10:19 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2u7N-00026m-He
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:10:18 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so7585389e87.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699971015; x=1700575815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBXqKG7LMRKOlYiafZlN/lT12YtsLlfXhDpDWrlLlKs=;
 b=cKKIDS5X+5MkrsbP9PGodAeqsw79lAC0cmHFLcv3BVD+e9IZkbkjPBTN39xBzdsmr1
 HvVNqjDYPFabo1lzecQXnl0G+97izdy9iUTnRHaubqfqjmWoKGhLntX12hLW406tQx5b
 djU9OhvgQWEI+bqqXJ4aEP0cOVXiuBLwthwb1fA3jWoL4/oHRJI883DJZhApzv2fq8w4
 TDd6rG8Nt2sSMc0l9GPeWKObeZSaDszZFVuF2UZ07GfNNEFjx8eeh15rye4x/m5Vtw6F
 vFqBtrdsZHMnSIzIjs7gypRa9/HoZyXgHKf7B8tDk2/UK5VIHNgdwSnFChIsn+gqxlz+
 E5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699971015; x=1700575815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBXqKG7LMRKOlYiafZlN/lT12YtsLlfXhDpDWrlLlKs=;
 b=Iv4ozjRbKkPz0tLTtgrNqcJPkwxBsgaBipP3RfDEyRliorrpYu4ArqUHXxCh7fhDp3
 +Ggf1XEcfS3iSlYW6guqhI5XpbTti08ACqgyaVSCGqIT1DSrOa71Zy9Z9GtEXT6MfOQT
 cXbImnbjgX+1hnjJmfxvGfPIJVLBLEq/XW5prWgFApKndm2/DItO7FCZRuJhgGPwS3UZ
 0TdjRz0QlasvwnxMOcGTM0JEs5OD8diO3DvTmTneDqAg7soDNxBSysTNlKNx7jlM5rOy
 cfdLgkjuGMFRuNfvS90iNnxBkXLHi/KEx4Xps70FV5zlwVAB1WcYEpdYlOO2BNda1qWW
 3OlQ==
X-Gm-Message-State: AOJu0YyfR8XVoS0SOrUHsJyJw6WM1rkvJc/ZHHvKr1k6lzxMvf2CXjjp
 l2ro9qTrZRICf5pd03+Q/53VMHoA6aQS0IeusNg=
X-Google-Smtp-Source: AGHT+IFPEZTT+lG0J4/4+C310oztdrgdbthxnfcEk1rXFciZEQbDPT2FkNilPOoN3z3ch165UQHQUw==
X-Received: by 2002:a05:6512:2003:b0:507:984e:9f17 with SMTP id
 a3-20020a056512200300b00507984e9f17mr5908357lfb.34.1699971014832; 
 Tue, 14 Nov 2023 06:10:14 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 xo15-20020a170907bb8f00b009ade1a4f795sm5562272ejc.168.2023.11.14.06.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:10:14 -0800 (PST)
Message-ID: <d3c8466c-9a41-4e03-b69f-28ff39aeafd8@linaro.org>
Date: Tue, 14 Nov 2023 15:10:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: Replace assertEquals() for Python 3.12
 compatibility
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20231114134326.287242-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114134326.287242-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

Hi Thomas,

On 14/11/23 14:43, Thomas Huth wrote:
> assertEquals() has been removed in Python 3.12 and should be replaced by
> assertEqual(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3

 From this list I see assertEquals() has been deprecated in 3.2, along
with assertRegexpMatches(). No warning for this single use?

tests/avocado/version.py:25:        self.assertRegexpMatches(res, 
r'^(\d+\.\d+\.\d)')

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/devel/testing.rst                  |  2 +-
>   tests/avocado/cpu_queries.py            |  2 +-
>   tests/avocado/empty_cpu_model.py        |  2 +-
>   tests/avocado/pc_cpu_hotplug_props.py   |  2 +-
>   tests/avocado/x86_cpu_model_versions.py | 96 ++++++++++++-------------
>   5 files changed, 52 insertions(+), 52 deletions(-)


