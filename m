Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8488233C2
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:48:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5Hf-0004VI-BR; Wed, 03 Jan 2024 12:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL5Hc-0004Nx-MV
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:44:00 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL5Ha-00033y-To
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:44:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d76fefd6bso43490205e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303837; x=1704908637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V8US0ACJb4Hw/yRgDiojK+LPOeoUlnaAFyhJhDgbvbA=;
 b=SHg9izNTyV5bSUY3q8V4rD8z5klv8v9sJrKdDTX2cw+MNa+SEFsofmYXnX6z8M2Rkh
 plPUQ7TOieb4/gl3Ovu2Ltx1C1NBsKqPkPPgEsSt0uRKmgPBBWr3v9x3zJQ2/oSAqPKu
 fJxDABXEIWLQJ9t4tn5g0BOjNfBSf93d07Liy2EF86HT7Zn1kBdMH7nwl5cksHSO2Jcz
 WknSAOQ1EsbifWRoypGo9dj2aCr0OH+21tGt/hy+AhJkkenM7E5rjkuh2Vy/izmBKTWR
 Xhv7GkE6S0ARTJqh+i9l39VZAO/uK7sky/RKIqAWxtDfz91mMfpRAD7JjOZj+aRCtIWF
 I+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303837; x=1704908637;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V8US0ACJb4Hw/yRgDiojK+LPOeoUlnaAFyhJhDgbvbA=;
 b=erIEkHozJNmVVbE3fOrTED/xM4DhXd6eqMR6zX8QVB/vysCpASfvUJv5MnPWRcywZO
 Ju2csDiUb6lGdPsQWO5ZHnGZfQ/UOgvU0TmNBDJZ7xPuNDZG4mezSdyWBECvdLhcKFEH
 46w1ppZx4H32BiiaXuW66MgIxvRotbqw2Kb5yH+Mmz6bXWnXPyMK2/x0b969SzZ7XhF/
 84MwMtPZ8+tPI/hKI20iGA8x6mvXb9i1R67BU/43brusBCVxvT5a7IGfS8Z7chZfRwoj
 KpLxMy9lyM0bwxBM+QyB3OstY/9GNTI1G9TzxaWE3oSRyQfoOv+n760eTabgioKRzh9a
 lL9g==
X-Gm-Message-State: AOJu0Yzfwn80Gkua3ooDrEZQR1Ub4MXelN7c9qXLniqWD2j5gueD2haE
 1OWjy5Ot+GV59JcuOXyhBcXzzAuhnQhPMQ==
X-Google-Smtp-Source: AGHT+IG5G9mQ4BJ4FXQ/6LVXB48S3IsiORpTQTFyaxnxAOVk8KcHF9cASuMfoLN6MOOl0hYkw6H46w==
X-Received: by 2002:a05:600c:3501:b0:40d:5a99:3bb6 with SMTP id
 h1-20020a05600c350100b0040d5a993bb6mr3579336wmq.41.1704303836866; 
 Wed, 03 Jan 2024 09:43:56 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 p7-20020adfe607000000b00336843ae919sm30885254wrm.49.2024.01.03.09.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 09:43:56 -0800 (PST)
Message-ID: <6826da51-3b97-4ecf-8517-9e5b5243e91f@linaro.org>
Date: Wed, 3 Jan 2024 18:43:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/43] qtest: bump pxe-test timeout to 10 minutes
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, David Woodhouse <dwmw2@infradead.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Paul Durrant <paul@xen.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
 <20240103173349.398526-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240103173349.398526-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

On 3/1/24 18:33, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The pxe-test uses the boot_sector_test() function, and that already
> uses a timeout of 600 seconds. So adjust the timeout on the meson
> side accordingly.

IIRC few years ago you said tests running on CI ('Tier-1') should
respect a time limit. IMO 10min seems too much for CI, should this
test be skipped there?

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> [thuth: Bump timeout to 600s and adjust commit description]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20231215070357.10888-7-thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/qtest/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 7a4160df046..ec93d5a384f 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -4,6 +4,7 @@ slow_qtests = {
>     'npcm7xx_pwm-test': 300,
>     'qom-test' : 900,
>     'test-hmp' : 240,
> +  'pxe-test': 600,
>   }
>   
>   qtests_generic = [


