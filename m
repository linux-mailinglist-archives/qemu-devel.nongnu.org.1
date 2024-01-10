Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B246B82A0F9
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:21:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNe7C-0005KS-UY; Wed, 10 Jan 2024 14:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNe72-0005Jw-W1
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:19:41 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNe71-0001JF-1b
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:19:40 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso2346635a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704914377; x=1705519177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DMkSGgS33676tpYdvMeRICZTtCOuZc4rIkE8xlipUlY=;
 b=PYqvC9z2mziyXCB58BMH5sqxFqiygNscrudxbjUUnbrhnDeTWkDS2Ez5ED7mJuzXX1
 lrg2UX8YI1IKKgIDyZQ5HZVKpEx+pTfjQQkFzCBdPtydXd+e+/4/JsFWl8sYSS3DCc4+
 V0Jc0ImlZDDMVrrLhbk/RuisMqsdypqqz2mJgF0X/UQSvX1Yq8VWNZOd5AsvEAfbPKiU
 yuZ9QnJCMCqf9z7lo1NFZckTvBi1CZEqWXVjv3+TaMh482u4rjK+H//+gkaxrY8pKOcv
 GPa5BnrEk/zefLtV+cOCLN98Rie5LiUV0mZ6hvALwurA9xr+QZfzfle2HgTN/F+rhbWA
 xOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704914377; x=1705519177;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DMkSGgS33676tpYdvMeRICZTtCOuZc4rIkE8xlipUlY=;
 b=oUN8bY90oL3RtM0SL99w33G2Vc9hiFc/L+cqWarFS5pQ9ZhKWH8uHpPikkm/AhbBPJ
 zGQ3Do9fs4yD8Rue8LTXI098fn/ZMo3ageeZ5PdrxRabtpxyoBzM3I0jRLInOgiCrrm9
 FMJ5KC2JKX0aHZmTIprxDmsOihu6wrcXfZGws5loAwRDOAoGfLwQrSwq7wKQr19fE/WZ
 H5QBz+BdUNyxwnbc9tEyt6bazbLviYq5Rb1K0BfNdIhOVUdabNGj38BU/XTq60U1KDRY
 axAPEoJjvr7R2zr7xuKxPNnmNxBOtgbXtM3WjbciDhRjExd/do7P7qBPBKHC+GCBaO/G
 cRNQ==
X-Gm-Message-State: AOJu0YyTmsRIuZ7w+UvN2Nx/RttmWgUaPxzc2OvTlGENu25HKDbK+Twr
 ClMr7U0zrCf4NeYzfGTTwq0/n9HeUQv3cw==
X-Google-Smtp-Source: AGHT+IGofCkDdgNQf5tj4ahD44Yon8Nkf3uMpLCvOekIMOXsXDqUVPjm7uFVEFeYbOoVAqFE5+42MQ==
X-Received: by 2002:a05:6a20:9143:b0:19a:404b:86c3 with SMTP id
 x3-20020a056a20914300b0019a404b86c3mr444378pzc.70.1704914376870; 
 Wed, 10 Jan 2024 11:19:36 -0800 (PST)
Received: from [192.168.68.110] ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056a00000f00b006da13bc46c0sm3966840pfk.171.2024.01.10.11.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 11:19:36 -0800 (PST)
Message-ID: <e2763db2-fade-482d-b433-1bfce6acf7d3@ventanamicro.com>
Date: Wed, 10 Jan 2024 16:19:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Export debug triggers as an extension
Content-Language: en-US
To: Himanshu Chauhan <hchauhan@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20240110040203.1920924-1-hchauhan@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
In-Reply-To: <20240110040203.1920924-1-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Himanshu,

We spoke offline but let's make everyone aware:

- 'sdtrig' should be marked with 'x-' and be an experimental extension since
the spec isn't yet frozen;

- Alvin sent a patch to the ML adding the 'mcontext' CSR for 'sdtrig' some time
ago:

"[PATCH v2] target/riscv: Implement optional CSR mcontext of debug Sdtrig extension​"

It would be good to put his patch on top of this series to ease the review for everyone.
The changes done in patch 2 would also be applicable to the mcontext CSR;


- last but probably the most important: the existing 'debug' flag seems to be acting as
the actual 'sdtrig' extension due to how the flag is gating trigger code, e.g.:

   if (cpu->cfg.debug) {
         riscv_trigger_realize(&cpu->env);
     }

and

     if (cpu->cfg.debug) {
         riscv_trigger_reset_hold(env);
     }


If that's really the case, all the checks with cpu->cfg.debug will need to also include
cpu->cfg.ext_sdtrig (one or the other). And now we'll have to make an option: do we leave
the debug triggers (i.e. the 'debug' flag) as always enabled?

If it's up to me I would make 'debug' as default 'false' and deprecate it. Users will need
to enable the debug triggers via x-sdtrig=true from now on. This will break existing behavior,
but the way it is now we're always enabling an extension (via the debug flag) that isn't even
frozen, so we're already in the wrong.


Alistair, any thoughts?


Thanks,


Daniel


On 1/10/24 01:02, Himanshu Chauhan wrote:
> All the CPUs may or may not implement the debug trigger (sdtrig)
> extension. The presence of it should be dynamically detectable.
> This patch exports the debug triggers as an extension which
> can be turned on or off by sdtrig=<true/false> option. It is
> turned on by default.
> 
> "sdtrig" is concatenated to ISA string when it is enabled.
> Like so:
> rv64imafdch_zicbom_*_sdtrig_*_sstc_svadu
> 
> 
> Himanshu Chauhan (2):
>    target/riscv: Export sdtrig as an extension and ISA string
>    target/riscv: Raise an exception when sdtrig is turned off
> 
>   target/riscv/cpu.c     |  2 ++
>   target/riscv/cpu_cfg.h |  1 +
>   target/riscv/csr.c     | 20 ++++++++++++++++++++
>   3 files changed, 23 insertions(+)
> 

