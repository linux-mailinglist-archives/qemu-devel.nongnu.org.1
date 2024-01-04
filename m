Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0522D824146
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 13:07:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLMTo-0006k3-2h; Thu, 04 Jan 2024 07:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rLMTj-0006ic-C7
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:05:40 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rLMTf-0000GE-EF
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:05:38 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5cde7afa1d7so263734a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 04:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1704369932; x=1704974732;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1JfSYgvG+gN3IuIgW3mKT13qe2Rfz3AaTGl7a0v25sQ=;
 b=3DxkuBAWTHVazoQPmHwXyxjcEtY2ZMGv21rAc3ZBHBY8ryqdJMNHc1rvG9T206WBxw
 HY6Uxr41uypCWmd2PxyCXfd+QBMH/SkhWP5Gfx/rSDZiuSj3ri5x9Ug1z63ASwBX1n4j
 2W1V/NrHeWXm0KNShqRVmJ9IIBzv04li+QXFApBf2Qs5L7uPiOE+HmXkjCrHTWMOvZC7
 oh55eyz7p0UPx1TPihiK8+WTegorHDuhOsZibIAPCUiJcoeUftKWajl8jYWzMsyRegpp
 ebUuaR3VtLLHXxrBOR/9c/HnPeqIfoLB/xPWIsnxdY79Z3DIJHOOWVb1u5MLZGmCPgPr
 QShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704369932; x=1704974732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JfSYgvG+gN3IuIgW3mKT13qe2Rfz3AaTGl7a0v25sQ=;
 b=KQAGDpJHlwk6cbMwyb7+TxAakvp/XMIojASYRPzNAYfHoFI8cFFXInHYF0T3sGuG9I
 vnuerval62rBmebetB9v2nhFQetmVkdAce70SWbr9UCnt9FIfYLD6bdC7m/RvwweUtUz
 aSMCAArQ2CuKPGDEWdK5VsD4UgAhbsukRZzAMtLnbFQJpp/a9lDTm9BNMKIE6hZHdZBy
 7mxcESnbL4lTcSinz01doYP06uxegpy4lMchQ7D5MX00u0hrXXP2vUefFzKiCr1k8tRi
 7GsWqUbG1uv1y6f6XMnGEg5A1lR5nWyc5fLXyDX/18KmjkYHW5dXRwLWXdNvpceSPPNQ
 eswg==
X-Gm-Message-State: AOJu0YzSMHLpWaHwPVi4gPFMDtz5oxymCBzEfRuDgU7nQtFZiaAi24L8
 f7YO23vY21bX/3ONRibmi5UwMKh3Zhdt6Q==
X-Google-Smtp-Source: AGHT+IF2iS1huYrRTsdmtHUlZNPJuYf+UOYa/O57oEjcrmBp+rJUuvidSwvdw5+1d7IxIqlfD1OWKQ==
X-Received: by 2002:a05:6a20:430d:b0:198:f146:b2da with SMTP id
 h13-20020a056a20430d00b00198f146b2damr405894pzk.93.1704369932451; 
 Thu, 04 Jan 2024 04:05:32 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a63a441000000b005ce472f2d0fsm12383424pgp.66.2024.01.04.04.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 04:05:32 -0800 (PST)
Message-ID: <52cac44e-a467-4748-8c5b-c9c47f5b0f79@daynix.com>
Date: Thu, 4 Jan 2024 21:05:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/43] plugins: add an API to read registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
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
 Weiwei Li <liwei1518@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
 <20240103173349.398526-39-alex.bennee@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240103173349.398526-39-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

On 2024/01/04 2:33, Alex Bennée wrote:
> We can only request a list of registers once the vCPU has been
> initialised so the user needs to use either call the get function on
> vCPU initialisation or during the translation phase.
> 
> We don't expose the reg number to the plugin instead hiding it behind
> an opaque handle. This allows for a bit of future proofing should the
> internals need to be changed while also being hashed against the
> CPUClass so we can handle different register sets per-vCPU in
> hetrogenous situations.
> 
> Having an internal state within the plugins also allows us to expand
> the interface in future (for example providing callbacks on register
> change if the translator can track changes).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>    - also g_intern_string the register name
>    - make get_registers documentation a bit less verbose
> v2
>    - use new get whole list api, and expose upwards
> 
> vAJB:
> 
> The main difference to Akikio's version is hiding the gdb register
> detail from the plugin for the reasons described above.
> ---
>   include/qemu/qemu-plugin.h   |  51 +++++++++++++++++-
>   plugins/api.c                | 102 +++++++++++++++++++++++++++++++++++
>   plugins/qemu-plugins.symbols |   2 +
>   3 files changed, 153 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 4daab6efd29..95380895f81 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -11,6 +11,7 @@
>   #ifndef QEMU_QEMU_PLUGIN_H
>   #define QEMU_QEMU_PLUGIN_H
>   
> +#include <glib.h>
>   #include <inttypes.h>
>   #include <stdbool.h>
>   #include <stddef.h>
> @@ -227,8 +228,8 @@ struct qemu_plugin_insn;
>    * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>    * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
>    *
> - * Note: currently unused, plugins cannot read or change system
> - * register state.
> + * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
> + * system register state.
>    */
>   enum qemu_plugin_cb_flags {
>       QEMU_PLUGIN_CB_NO_REGS,
> @@ -708,4 +709,50 @@ uint64_t qemu_plugin_end_code(void);
>   QEMU_PLUGIN_API
>   uint64_t qemu_plugin_entry_code(void);
>   
> +/** struct qemu_plugin_register - Opaque handle for register access */
> +struct qemu_plugin_register;

Just in case you missed my comment for the earlier version:

What about identifying a register with an index in an array returned
by qemu_plugin_get_registers(). That saves troubles having the handle
member in qemu_plugin_reg_descriptor.

Regards,
Akihiko Odaki

