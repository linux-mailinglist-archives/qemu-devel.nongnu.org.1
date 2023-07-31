Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A57697C6
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQT4Q-00010q-IO; Mon, 31 Jul 2023 09:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQT4G-0000zb-OT
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:36:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQT4E-00077p-Bf
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:36:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe110de3b6so19574235e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690810567; x=1691415367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S0z9m68fumFWDSuz2IWQxIZ0SeaHB4wPDPgx2tio7qw=;
 b=OxX6931QTMcRV2b/y8dp4xkgJMbhPi/O4rOe3kq8HpIoUo4hg2NUi5vC+qcL8w77yQ
 BA7fIeaI39JPzCxMCcoXzi1P0niV51Y08U7Ot+BerqEjfXyFbpAUjL/SgbO54YvZMiw8
 SYZKwq3NArV3ildsW+rN3Bg1poWp2CRC0n4nm65zblZHA0fupvjky/5CVsN4BP5wbjUN
 ZE7P42a535XXrT+LPbQEunlnfGMcD59y6EtS4wjZ4iKQWVTpYoDzupukYKN3r0WYA0YV
 +w8TYcBpiYnpHACMaOe47+ydTvTDOjgLYiimisll9oFuAvRC7eRLJqhfS7AgXVMU+658
 s+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690810567; x=1691415367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S0z9m68fumFWDSuz2IWQxIZ0SeaHB4wPDPgx2tio7qw=;
 b=gsDxecnSVVoL2OQVqYtrvyh58KAPyJDBEJKcIialeeWOUB5FjwujwL8HzQvGTwlupQ
 cSa7tOEMEHvBksSphd9gl5S1zpvMln3mjSCgehFPpgVwPPJUHrW2qb8z6JpU4oMdcEU+
 LM2NbyP/Om3iPf0oD9ig0d0VRtGkkPM43bBE/qLMlP3etRFNtY7AK51N0uTphUImhgsc
 wwNWOj3hLJjuEQdjL6eovOrc8awhgy8PvIfCEP763j4F0AoGnuEzQFksjBmQ2kero+Pf
 tQmDzJjQDYmhLjZ/RDIRHUIGM2uaBY/UpueQ1yvx9sZQWa0ZLXaOaXOMHck1e+CJDExt
 os9A==
X-Gm-Message-State: ABy/qLaZ19YvPFsTtzUMMEuQxNGgydujBTwwT8HFMqVmxE++cJj8OvRN
 12Ek4TbqNLBo6IRT7dxmpADmrg==
X-Google-Smtp-Source: APBJJlHphjBoN5iWkPwJPtmrbwnGtoqD5CFqMasC8/idVq/LLgnv1DQcqZHVBhdhnI7YCujdIYZzlQ==
X-Received: by 2002:a05:600c:29a:b0:3fe:1c10:8d04 with SMTP id
 26-20020a05600c029a00b003fe1c108d04mr3749092wmk.19.1690810567628; 
 Mon, 31 Jul 2023 06:36:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.198.42])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bce09000000b003fe1ddd6ac0sm4122960wmc.35.2023.07.31.06.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 06:36:06 -0700 (PDT)
Message-ID: <b41b076e-e423-7399-c03d-1f002edd6324@linaro.org>
Date: Mon, 31 Jul 2023 15:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 03/24] gdbstub: Add num_regs member to GDBFeature
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
 <20230731084354.115015-4-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230731084354.115015-4-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
> Currently the number of registers exposed to GDB is written as magic
> numbers in code. Derive the number of registers GDB actually see from
> XML files to replace the magic numbers in code later.

Nice :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/exec/gdbstub.h  |  1 +
>   scripts/feature_to_c.py | 46 +++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 45 insertions(+), 2 deletions(-)


