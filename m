Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B61267697F3
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:47:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTF1-0002vY-J6; Mon, 31 Jul 2023 09:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTEd-0002dl-Mf
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:46:57 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTEa-00025A-Ty
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:46:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-313e742a787so3084245f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690811210; x=1691416010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dQ0I3HmeLwdb2CHpthEIho6U8+3evu764gXwyozJFJk=;
 b=cBIHIBOSLNObNV9EcCZWuJdAP3X/Yjf8MfPWDJ0xynWkhkAvOoCoeQ3ilBgYosgf0q
 IqixA1oCTZtQ5WZRLM6Sp3mWD4Ei12jQRo8QEZ0zL050VpnJud2f2cbulxvqFnF2LcV4
 TSxyxCWhp2FdO+Y9B37ehlsT6fvVD5nST6ZCzxWjKLAgCIRGzss02W+3Oi+8AjTpNeNk
 iHkpi1tG/V4Yj1avZhXhTcXQJnFp1RGefp/CvNyJ6jEMJppRo9a/3bLdW1VSSIz2X4HU
 TiiLHf+luOys2jBAoJnKgFfCD6u1aYYGd0E9UHSVdh9bwk5HWk7t/ywXn5GqUMjygicC
 YLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690811210; x=1691416010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dQ0I3HmeLwdb2CHpthEIho6U8+3evu764gXwyozJFJk=;
 b=WWn051S+2+vyx5+vaPHfxF7j/OKc8HT87/sHLuyjFU4/JPU6wm7oOxlbpRPmLnqrTt
 U1Z5mALBd1Pudrzvca8W6IJpPXr2zJjI+b2KqaG2nLUfOdOzxolH8viw6ybIMPbWYQMI
 dxBX5Z2w9nkSlBcrjjAcIqU6dCQAQCc78XqHswMrhvEIfkCy2S6q3thtvaNwyhqxYG4v
 7DDYpcsMfBoDB79+CR5LoAOd4dHyHaaScwHOUg8JkKRAy3YhPeFLNhPXwIL7MHmdldOc
 XKAK6MPdphJXbBZaFcOGSya3Qy1Fp4BXp/efu9zUYDf+UtFa7IGmTn7EMtbEE3roz4O/
 crfw==
X-Gm-Message-State: ABy/qLYaCIVjg5vuASnOYsB5A/S7KRpiEWMFELofmP8GnTonmHfO/ug5
 RcXz3VQpJXSc1P18/d3Im2Xk/g==
X-Google-Smtp-Source: APBJJlEGscdCdyrOOjocrIiffHS4ZOgq9nstpeavSp5NQ755reBaDEaDK7cpizfk0ROb2M0X1gS8Qw==
X-Received: by 2002:a5d:4b85:0:b0:315:7f1d:7790 with SMTP id
 b5-20020a5d4b85000000b003157f1d7790mr7532962wrt.6.1690811210364; 
 Mon, 31 Jul 2023 06:46:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.198.42])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a5d508a000000b0031773e3cf46sm13250562wrt.61.2023.07.31.06.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 06:46:49 -0700 (PDT)
Message-ID: <277b6422-7820-bd1e-74d8-5410d67bc09a@linaro.org>
Date: Mon, 31 Jul 2023 15:46:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 09/24] target/riscv: Use GDBFeature for dynamic XML
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
 <20230731084354.115015-10-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230731084354.115015-10-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
> In preparation for a change to use GDBFeature as a parameter of
> gdb_register_coprocessor(), convert the internal representation of
> dynamic feature from plain XML to GDBFeature.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   target/riscv/cpu.h     |  4 ++--
>   target/riscv/cpu.c     |  4 ++--
>   target/riscv/gdbstub.c | 25 ++++++++++++++-----------
>   3 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6ea22e0eea..f67751d5b7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -391,8 +391,8 @@ struct ArchCPU {
>       CPUNegativeOffsetState neg;
>       CPURISCVState env;
>   
> -    char *dyn_csr_xml;
> -    char *dyn_vreg_xml;
> +    GDBFeature dyn_csr_feature;
> +    GDBFeature dyn_vreg_feature;

Similar comment that ARM (dyn_features array).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


