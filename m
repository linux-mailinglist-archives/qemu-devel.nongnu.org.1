Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C4742AA8
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 18:29:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEuVg-0003CR-0x; Thu, 29 Jun 2023 12:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEuVe-0003C0-C3
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 12:28:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEuVc-0000xw-Mh
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 12:28:41 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-313e714342cso963042f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688056115; x=1690648115;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWu1qF6/XCMkqqjI74o/5AQy9Al7woXmlNUgHkAHj8g=;
 b=HwhLDq0A6cGMvDfXF5hsGNiAY6DmxFilccamFeYO7EZA8zgVEDcIxeAIXowMoAgcMG
 +5B3ajbzeBvFzc7R2i3hRvRbKMPiXyr12ZLGv94Gw854IgwNonzucwY6V2c71v1/H0UF
 6lpi5sV6Vga5u3TPMCTsN3iHc//yCMJ2WsBndiH7oW2UJIOCk9SxlAyOw1RV8+oITdvy
 zbRc4WRYRA9VqTgD7SISi49972MvivM8FWLC6QdVqn4Ie3Pqf3WmHaiDMQbrZfAp6i1b
 yfCZsUmmPG7xaaZxH9AG62tpx6Hv+If1GoJuFtKT2DNTDgDKRUPdaj6zJ4ywrfahUZZW
 Pwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688056115; x=1690648115;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DWu1qF6/XCMkqqjI74o/5AQy9Al7woXmlNUgHkAHj8g=;
 b=F6LiZtGmnoYYRIOgfeDUecWbAVWJ8MSyl2dsZisJoBgPsgJbNHTz8Yb1Vw8vGAUr9k
 BIickfwmk9ftlZfzdnN3LUCe+bFoJf+TdOkH7QqZCdEdkMUU5B56lq4cukJ022x+XaBK
 I/LTUIygMM0IOpsQo7DuvC7r8rA+cBu4c1u0glvJv5O937bNTT8LkuztO3+VPZCwJIMX
 mfWur3LpKvshMpHfSdmF++E4JLVtSSieICiDfEqA/IPP8TBpBoXu9HqYIC6Hwmvd3z/B
 RGFP4+GrotyccHV0Wao4rjmP5waGzqZYB9pfpx4KWpxJ9hD881L2qKlH8PHH9VtWAkOr
 J7/A==
X-Gm-Message-State: ABy/qLapS/jm3zuQ+rdsCmmCNA6qJOYKS72xs7L0Yte4B3uh3AfNxYjS
 9MQFjytOpdPUNAD13mrMF3TBpg==
X-Google-Smtp-Source: APBJJlH8CgagA0TFQNmFHzCrxd3AfrAHaAd2K8hGigiTH6KSMrx/iZ6JVAZCLItBvDOHPzKkH+VEBA==
X-Received: by 2002:a5d:5592:0:b0:313:f5f0:8efa with SMTP id
 i18-20020a5d5592000000b00313f5f08efamr108723wrv.18.1688056115643; 
 Thu, 29 Jun 2023 09:28:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x18-20020adff0d2000000b003141e86e751sm332884wro.5.2023.06.29.09.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 09:28:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DDB111FFBB;
 Thu, 29 Jun 2023 17:28:34 +0100 (BST)
References: <20230629120255.85581-1-philmd@linaro.org>
 <20230629120255.85581-2-philmd@linaro.org>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 Alistair Francis <alistair.francis@wdc.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>, Palmer Dabbelt
 <palmer@dabbelt.com>, Eduardo Habkost <eduardo@habkost.net>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 1/2] target/riscv: Check for CF_PARALLEL instead of
 qemu_tcg_mttcg_enabled
Date: Thu, 29 Jun 2023 17:26:59 +0100
In-reply-to: <20230629120255.85581-2-philmd@linaro.org>
Message-ID: <87jzvmxmfh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> A CPU knows whether MTTCG is enabled or not because it is
> reflected in its TCG flags via the CF_PARALLEL bit.
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4035fe0e62..4dfa64af6a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -473,7 +473,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
>=20=20
>  static void rv128_base_cpu_init(Object *obj)
>  {
> -    if (qemu_tcg_mttcg_enabled()) {
> +    if (CPU(obj)->tcg_cflags & CF_PARALLEL) {

Hmm have you checked that tcg_cpu_init_cflags() has executed by this point?

>          /* Missing 128-bit aligned atomics */
>          error_report("128-bit RISC-V currently does not work with Multi "
>                       "Threaded TCG. Please use: -accel tcg,thread=3Dsing=
le");

Not that we can do anything about it but in linux-user we start with
CF_PARALLEL unset and only set it at the point we spawn a new thread.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

