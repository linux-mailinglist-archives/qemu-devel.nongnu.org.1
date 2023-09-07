Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B5C79711E
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 11:08:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAzZ-0006js-85; Thu, 07 Sep 2023 05:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeAzV-0006ez-VB
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:07:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeAzE-0002cg-Ir
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:07:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401d80f4ef8so8077275e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 02:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694077653; x=1694682453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e+0LeLWheEZo2jx/tfksWwMPjBz6FAD9QINK4UCiU0s=;
 b=zp6QgQaBHXOtXQvCv1vaY9xh/fIPXqPGoHZfhlsuSwQ3q5x0hTN17t8vk4usxh97Ik
 kInnUkLXA+s/lxwgxi5w1aoi+2AON9O48upTFPKjBJ4P6SGd0SgwHR0QxY6YNa00CXHp
 TUzY0mZ/VmeCaY5hnm0cP+eB8vcOYn4PGKGSncQ+w57gvf9DpBdPgxrn2jTKuwRcLzMs
 sHc4S0GfhsPhorL19uWlgv6vPWHMTYif8tG86ABue2nZRrauLywFXVbM0HrX5dzTxA5n
 H47QGAV26wnj5qLUWo6+obmKbbDf3b4+J8hj5MTMmJsKRsAZBfJUncIRvZr5mxHqkpvE
 17BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694077653; x=1694682453;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+0LeLWheEZo2jx/tfksWwMPjBz6FAD9QINK4UCiU0s=;
 b=RRulwfBB4R1Mri68grNz3uY1fw1a6iDw9FbjNg1WevKMCSVeT41F2voF2AO/mGs5BD
 rF2xdFHejOUkWXE7c7rZ/SAcIXvevGPkTTim7Qt2H6XgQ0u6pXOYOg5Yte4le7kUZksW
 oWuvUV1e02upgp5nTWSd0YdkxvUwMEoq8kavLEG950AgDWVG+Orf+qdp2XQz6mIOo/MD
 nOoTx/Tgb99ONrkeph43oy9hEGtvfsWsxslMvPsXyt+K9wt2hR7I7ObdW3jAi0uNjpll
 ZkSk2jEQDJtDHB069lQC4WW8Z2hnl0KFgi8K2UExQHCpXFUrGRh//xOi3g6s9SDW+Qsf
 5+jA==
X-Gm-Message-State: AOJu0Yz4KCELjD8gS2VWjFQ4c7qbooZGAz3XQ30ExlL6aT872TFGiJ1s
 SJeXjGG/rapT4sJEeMVxxPMT4A==
X-Google-Smtp-Source: AGHT+IGyxgw0EZYuHgZyu6Ifx7lIrPV8Awh6kT+c5irEiqwp03f+XVTOM/12OQ4qqtDOa5qLoCIwIw==
X-Received: by 2002:a7b:c7c7:0:b0:402:cc9a:31a7 with SMTP id
 z7-20020a7bc7c7000000b00402cc9a31a7mr3997937wmk.19.1694077653219; 
 Thu, 07 Sep 2023 02:07:33 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c204700b003fed630f560sm1896685wmg.36.2023.09.07.02.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 02:07:32 -0700 (PDT)
Message-ID: <c74ace91-b1be-9a12-c428-a59fd4ffcf1a@linaro.org>
Date: Thu, 7 Sep 2023 11:07:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 32/32] hw/riscv/shakti_c: Check CPU type in
 machine_run_board_init()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, imp@bsdimp.com, kevans@freebsd.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 peter.maydell@linaro.org, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com, kfting@nuvoton.com,
 wuhaotsh@google.com, nieklinnenbank@gmail.com, rad@semihalf.com,
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org, laurent@vivier.eu,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 mrolnik@gmail.com, edgar.iglesias@gmail.com, bcain@quicinc.com,
 gaosong@loongson.cn, yangxiaojuan@loongson.cn, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, crwulff@gmail.com, marex@denx.de, shorne@gmail.com,
 clg@kaod.org, david@gibson.dropbear.id.au, groug@kaod.org,
 npiggin@gmail.com, ysato@users.sourceforge.jp, david@redhat.com,
 thuth@redhat.com, iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk,
 atar4qemu@gmail.com, kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com,
 pbonzini@redhat.com, imammedo@redhat.com, shan.gavin@gmail.com
References: <20230907003553.1636896-1-gshan@redhat.com>
 <20230907003553.1636896-33-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907003553.1636896-33-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/9/23 02:35, Gavin Shan wrote:
> Set mc->valid_cpu_types so that the user specified CPU type can
> be validated in machine_run_board_init(). We needn't to do it
> by ourselves.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/riscv/shakti_c.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


