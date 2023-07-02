Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E60AA744C69
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 08:02:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFq9u-0007dO-DT; Sun, 02 Jul 2023 02:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq9p-0007d1-K3
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 02:02:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq9o-0002QE-1D
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 02:02:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-311367a3e12so4354546f8f.2
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 23:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688277718; x=1690869718;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=44nF1hVwIpB/e3r6cdZFXcIhonfRSEMMWahWIJ78+fU=;
 b=m4Fl2ieZguJhivFC2URELnASzW80MpPqAbcrn2DKVxqGy1dq7Uk5+qSlfA6Gi1hlg1
 6vwA+ghPkLVZUnD63TBX4bvtCh3fILn8vKFmUySD6ZxBboK9Fugw4x2ICjcQEQETvETB
 yokTnAVGFePkU8sxKaB+dzC7UebNq+hX0L7qwV7b20RA76VBSSBtHK/DqhG8hH/IYR0U
 MTmRIgYHZnh+t25WjcHw8kQ06FcMlnWZMZL4EjwcSRkb93+iYmKRZmIO2XhMLFQMJ/Og
 166l8UM5EpkfGRr/8vMdtGW1Mu3wLrGdppvxxwRc9bsaEyxrlQOPMsfkES698fQF4Lr8
 iwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688277718; x=1690869718;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=44nF1hVwIpB/e3r6cdZFXcIhonfRSEMMWahWIJ78+fU=;
 b=mGO0rWyYIgS/wYBq1WadDqwbLoPQ1/kVoKH2AKa2vvqBK10dZVhTeXvGdvWVo1XdzC
 8qEdCMoF1awwQz1btVJ2Mjqd7Z0rMibWgvHdaL/WvdsljXqoDQ1g5acx8SDtaY223xwZ
 gEPjyCiX3fgKYD2KrMU1TnRG6dnnWPzJ4tuJyfPrd6LB8qszrb5/IhMRV3uZHT5d5g63
 k+7jQ1FfsoiBpcC3VntuSh0+0L4GwAHwTGrKZsd2c6JtFtWI6VlM4Fd/lr9HcjvuL9ft
 6Vy3b+YkB+Qxk7EmrC4FgFgKfPxfw1pfzqSktaW4EsO+xPPYgTc0thgGrOGjKqk3dqt4
 gtOA==
X-Gm-Message-State: ABy/qLZKwjHGA1DFKTrUvuQL8Tnijc5IRNJrK2WAdKPxUlIbOYtPOoeS
 zEbS7a2TL7bxnVi+Y4JLdFEX5/utLn7H1EuKxgyfjQ==
X-Google-Smtp-Source: APBJJlGD9BsyC48BT9nZvcZbI9295hnurS9WC4MTJqiQy0eKan4KeLhk//DDpqzrwa8LJRP7LuPEhA==
X-Received: by 2002:a5d:504b:0:b0:313:fc3a:175b with SMTP id
 h11-20020a5d504b000000b00313fc3a175bmr2641332wrt.54.1688277717801; 
 Sat, 01 Jul 2023 23:01:57 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 m3-20020adff383000000b0031417b0d338sm7926710wro.87.2023.07.01.23.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 23:01:57 -0700 (PDT)
Message-ID: <b8ebfa55-5f5f-8710-b498-0dc99a18250e@linaro.org>
Date: Sun, 2 Jul 2023 08:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 08/46] target/loongarch: Implement xvsadd/xvssub
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-9-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-9-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/30/23 09:58, Song Gao wrote:
> This patch includes:
> - XVSADD.{B/H/W/D}[U];
> - XVSSUB.{B/H/W/D}[U].
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/disas.c                     | 17 +++++++++++++++++
>   target/loongarch/insn_trans/trans_lasx.c.inc | 17 +++++++++++++++++
>   target/loongarch/insns.decode                | 18 ++++++++++++++++++
>   3 files changed, 52 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

