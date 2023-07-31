Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AB9769859
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:53:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTKl-0005Ku-Po; Mon, 31 Jul 2023 09:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTKg-0005Jl-Ki
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:53:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTKc-00037x-QU
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:53:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso12189155e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690811584; x=1691416384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PYb25o9TpeL44fOb3xpjsBI4FbNNQ2EW5i5KDKsqu3k=;
 b=UIjQ2gGSy+jYPBMBq1tldQaAYXTXPs77jNiqJt9CeniXajehblRSvLglG2LmBAccxh
 rS/DQ8I2aTnR4BkmqjBtDtZv+X5/3aYZwMgDzaMVlGtexZ7s1ohv6sZSK3TzNwS5HMGh
 SRU7zO53mpfk4QFnz4Vnd/B1dXMtLfXwyYrq5dgZbJaMuwApTNTlFjk0OfUuSjaYoIiY
 P/O1snTMRLNetDwqWWJxno2IHKPQGGBA8ZSWQaSg3/q68RmDHhFR6SCjjijCo88Fyieq
 aJ6iZ12syciQH3WjKXERI/SV8tH0GNgyInHQlPaZxvIXj7AD7sntiyXQbRiAIUCfcsym
 8Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690811584; x=1691416384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PYb25o9TpeL44fOb3xpjsBI4FbNNQ2EW5i5KDKsqu3k=;
 b=XZ+9EFj0jIZYrx/atCkrGxM7ecy3AW0Gstlgc2v7YAJPJo3x4hT7tQHlnYTFZgipql
 IimxPideojBhjzMYmaA2kAFBFT6MfP4sPjJrXuXTOuZNtGSXC+gH9a31GbLdh1ot4rP4
 46BJJCNHpcqAijwZ9A1OhVLUe3f7Fr6FcJXCHo9rRo/WzvBrYMRosHnCEHyO0rGpi3V1
 9/tNfji1f02COtqa6sRQxxheZYU1TZ5+ILayzS7NiEDuMBtPlqcKgsroAD+/JDxVuFHH
 OlbMoy3uaaEQsHp1VjEBm6UXAdoit5PEkS3uIcSqpgqN6jMskmAW48gjJmvjWv2x68+y
 2Cuw==
X-Gm-Message-State: ABy/qLagI8N/AFLD03YtRzF/F/cJFLcC/lC5r2x0Y7uQ6kvQJz2Y4U+R
 W6dWcVGFozm4DbSg5pbKaPQeGg==
X-Google-Smtp-Source: APBJJlFPzk5Nu7U0ttJ6pmM9RL12liha3SjICEr5rZuoE6S/5szC9pKQ6MiH0J0L4j42LA/msmfY8A==
X-Received: by 2002:a1c:ed0d:0:b0:3f9:255e:ee3b with SMTP id
 l13-20020a1ced0d000000b003f9255eee3bmr9260364wmh.30.1690811584364; 
 Mon, 31 Jul 2023 06:53:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.198.42])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a7bc8c2000000b003fbc9b9699dsm11520994wml.45.2023.07.31.06.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 06:53:03 -0700 (PDT)
Message-ID: <dc296d6d-6959-c924-b0f0-97d122807d15@linaro.org>
Date: Mon, 31 Jul 2023 15:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 04/24] gdbstub: Introduce gdb_find_static_feature()
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Rolnik
 <mrolnik@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Laurent Vivier
 <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230731084354.115015-1-akihiko.odaki@daynix.com>
 <20230731084354.115015-5-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230731084354.115015-5-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 31/7/23 10:43, Akihiko Odaki wrote:
> This function is useful to determine the number of registers exposed to
> GDB from the XML name.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/exec/gdbstub.h |  2 ++
>   gdbstub/gdbstub.c      | 13 +++++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 22e5add5b1..3115dc21c0 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -34,6 +34,8 @@ void gdb_register_coprocessor(CPUState *cpu,
>    */
>   int gdbserver_start(const char *port_or_device);
>   
> +const GDBFeature *gdb_find_static_feature(const char *xmlname);
> +
>   void gdb_set_stop_cpu(CPUState *cpu);
>   
>   /**
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index fad70200d8..6d9cef5b95 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -414,6 +414,19 @@ static const char *get_feature_xml(const char *p, const char **newp,
>       return name ? gdb_features[i].xml : NULL;
>   }
>   
> +const GDBFeature *gdb_find_static_feature(const char *xmlname)
> +{
> +    const GDBFeature *feature;

Alternatively (in case you consider the suggestion to use array
of dyn_features):

const GDBFeature *gdb_find_feature(const GDBFeature *gdb_features,
                                    const char *xmlname)
{
     const GDBFeature *feature;
     const GDBFeature *features = gdb_features ?: gdb_static_features;

> +    for (feature = gdb_features; feature->xmlname; feature++) {
> +        if (!strcmp(feature->xmlname, xmlname)) {
> +            return feature;
> +        }
> +    }
> +
> +    return NULL;
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


