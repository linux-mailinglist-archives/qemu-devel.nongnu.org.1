Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B05797110
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:55:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAmo-0004Er-44; Thu, 07 Sep 2023 04:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeAml-0004DV-JM
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:54:47 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeAmh-0005AM-86
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:54:47 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b962c226ceso12276861fa.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694076881; x=1694681681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a0TqEG6zDRSkYYAUrJKaEhEYdZdOL/5N4fBUkiY/+fo=;
 b=bc7LOQSwIZCZmrHgMKwrWrWZljhLAw+B3PQ/PaKQ2eA1flMEN4XgYHFB3M6Jse7XDS
 3ims3L9opjgOgwHE4zgm7K7ZhS0Bcdi3P82uxbjd6OVEEUJls9uh6izJxhZKn38VISyi
 9qx8PWx0ZxXQFLwyoO15tJ5n6DJxrRMVUs7va+N0gzlKibZm4rljOMperW3E4Vso7Pk6
 c7j/cDbGO59P9eGwsuu5YMpLHxKQgitiqEffTuHYvJTcHxq5dujEpB0tSkqpIrdPx2cU
 Er/m3mSQvM1LjlusvmGo6sUIsBha9ZYWI/pZwgB6RVj9ygjzoe4wfOs5LP+76mRtqHY7
 dFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694076881; x=1694681681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a0TqEG6zDRSkYYAUrJKaEhEYdZdOL/5N4fBUkiY/+fo=;
 b=Sfjt8o7E3EXSia9BqmazLX4T/tTFHS1td9SGZgqOdr75tCTPR60uanGIDHXeKvSXD6
 y33WJYzDnR3VAfrDPyh2v0zKZTlfYqV4whHILDf8nAiLb19sTV1EQgCMJu7RGjamfSLa
 B/xNbDGhDNwL02lZw60d8zgKGpg6S5uZ9ILIwmH/tH67n9th+pZJUYypWN33l41wI/U1
 9U8RENMdQpvIy4rPZXE8Kp3+TJ6hyXobrGO2mpvnfTBzQ7keIbV03KLBjRbjTtmB2f7V
 aNzeYus9GvmlMYn0IuQELSKUdDksH3M4UE2F04omvGY7OMUzuNMqld/mxh6/MNdi6LVz
 uZ9A==
X-Gm-Message-State: AOJu0YwCtiHw8sUPZGmQMfTwo8nLGjODgTX1bhGdi+MbzrZDWUmyF7WZ
 5vCNeREHcLE6TBEpyVRVMTaMNA==
X-Google-Smtp-Source: AGHT+IE4vZ0zXKDSqQ9gVpQ1yUYK2RZmeuFA4N5VTn9eb460Xk3o/UJ53vC2owGD7i8VWdAdhRIfxw==
X-Received: by 2002:a2e:9303:0:b0:2bc:f252:6cc4 with SMTP id
 e3-20020a2e9303000000b002bcf2526cc4mr3365753ljh.10.1694076881150; 
 Thu, 07 Sep 2023 01:54:41 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 lj17-20020a170906f9d100b009829dc0f2a0sm10129733ejb.111.2023.09.07.01.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 01:54:40 -0700 (PDT)
Message-ID: <923ad3bf-4663-248a-aaf2-cd596d5ec0b2@linaro.org>
Date: Thu, 7 Sep 2023 10:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 01/32] cpu: Add helper cpu_model_from_type()
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
 <20230907003553.1636896-2-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907003553.1636896-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 7/9/23 02:35, Gavin Shan wrote:
> Add helper cpu_model_from_type() to extract the CPU model name from
> the CPU type name in two circumstances: (1) The CPU type name is the
> combination of the CPU model name and suffix. (2) The CPU type name
> is same to the CPU model name.
> 
> The helper will be used in the subsequent patches to conver the

"patches to conver" -> "commits to convert"

> CPU type name to the CPU model name.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   cpu.c                 | 16 ++++++++++++++++
>   include/hw/core/cpu.h | 12 ++++++++++++
>   2 files changed, 28 insertions(+)


