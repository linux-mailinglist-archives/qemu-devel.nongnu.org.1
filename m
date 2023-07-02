Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F8744C60
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 07:57:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFq4m-0005WF-R1; Sun, 02 Jul 2023 01:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq4k-0005Vo-5J
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:56:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq4i-0001Vt-F8
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:56:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31409e8c145so3822521f8f.2
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 22:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688277402; x=1690869402;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qdWhHtZ26908+2lzDZ7zfZlsWkcXES0AeQUyphIzwhw=;
 b=c9fAtEkCNos+d1GhVq5yiPBKafKbUBkyzEmmOWlWZkP1ydjeZJXaxnXbE7LrFnTwDc
 c2u8g6ZZMzuKp4oh4GZNnxPaVxQoxXFZtS1zVGyC6dokENyyY8j47aUoFlD510beHA2I
 pEENykCnCO2N4bQje/tVg9VsfcbIsP5jtWSHqeBqvb2p/DxQwCjoBjluXhv35xbmDP81
 rCc4pXVmLjA1Oz0c20b88ZCgFVNHY1Tt6Lx2Nl8D4CDKk9Tc7HyWB5TSIo+uHA69q84v
 Ufd27DMNa4LX4/KRFslibIpv2vJ743uBOFYLdRPj0RgzJ0AUyKYCjzUUKvjxp3Y0UVez
 gbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688277402; x=1690869402;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qdWhHtZ26908+2lzDZ7zfZlsWkcXES0AeQUyphIzwhw=;
 b=TFngpOhBnRmQQ2mzAoKLK3sejnV8kgp2JplCIjFM6SqAuk9FxkljrWjhjovVjexAjb
 nYWWJNVftw0MZWH7y/Nti8E+jgeScNplANfGHzWI0w90vNdn5dZZVt9XbLAaZvrtb2Cz
 cRKIHklXWk3qPjDsxTWMQ7TOq/OiDh2HH5/L+8P7GOODDdCXGzdkLB8Btao5/wJNoyc3
 23uugO4OVMQTpZ5lUbdA7SvvMBNf/LT7k12bUTmhGWvfK3KCZt4A1LJPh/McmwdKdWH4
 qpTtE9I6a4QbkkXc/93/EpIhK0J3I4Bt5IcfE7TD8aKfWuqhYnAN9jAiIeAbRcZmuF0h
 xIxQ==
X-Gm-Message-State: ABy/qLad1edYijNdnxe/mz0j0Q+m0eXfLbyk2WIMMPoNSBNvNPPfKS2U
 Wfa53PPEc953Cu+LBxN1NBfY+g==
X-Google-Smtp-Source: APBJJlFRabMjb3D2/kQR5Z0/eTtWWCT7c90lqRlx934Jms5UdI/76c/TArysLqy4mKLHDK9T79yb/Q==
X-Received: by 2002:adf:f30e:0:b0:313:f353:d5d9 with SMTP id
 i14-20020adff30e000000b00313f353d5d9mr4980071wro.50.1688277402505; 
 Sat, 01 Jul 2023 22:56:42 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 e5-20020a05600c218500b003fbcdba1a52sm3856654wme.3.2023.07.01.22.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 22:56:42 -0700 (PDT)
Message-ID: <70e54f44-b6db-9c83-edd0-10f70335c193@linaro.org>
Date: Sun, 2 Jul 2023 07:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 05/46] target/loongarch: Implement xvreplgr2vr
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-6-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-6-gaosong@loongson.cn>
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
> - XVREPLGR2VR.{B/H/W/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/disas.c                     | 10 ++++++++++
>   target/loongarch/insn_trans/trans_lasx.c.inc |  5 +++++
>   target/loongarch/insn_trans/trans_lsx.c.inc  | 13 +++++++------
>   target/loongarch/insns.decode                |  5 +++++
>   4 files changed, 27 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

