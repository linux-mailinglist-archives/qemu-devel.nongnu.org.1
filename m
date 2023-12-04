Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA88803E9B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 20:43:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAEqK-0006Zd-CJ; Mon, 04 Dec 2023 14:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAEqJ-0006ZR-Ah
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 14:42:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAEqH-0000kj-N9
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 14:42:59 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c09f4bea8so15360215e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 11:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701718976; x=1702323776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4DZ6bnVj9OjE4+em1vUbcjwozJDjg3ScRU1bRJ97uMo=;
 b=UnPOFy+URcHiBz63LhpNkMswYU5dqTwoVmTBp/lkZjkTEQ/OXqQBu/kjDrt0hMPMO2
 CMBIYj4iWnWbycYA50Op0Sdx9BVxNHI3oyNfhVIfdgqQpm6Hlpf1tX9G1xVdHz+xcvuI
 5gl2kRPbqfkVcwB/x31Eoikiv9yaImMMMhrxZh65AVaQpqJ4ezbJcKv6ggMWBXJX24En
 jCBh/lJx1KGduineMlZSp2LMC7GIfEev26qcuEH5DAfox+tR1IHVJ/6SMLaprvOiPht5
 m2Rb89QZCe9bYOwwLSDjcKblfW83KNh9hYfHpjuSOYPHuNl8CJprNDzgdd0eJPqULf67
 gv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701718976; x=1702323776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4DZ6bnVj9OjE4+em1vUbcjwozJDjg3ScRU1bRJ97uMo=;
 b=faH6aHdicpZGmFz6z48I+QfUtebzcC2KJuJW3HUT+zUrOpo3ngtRx62cQ76zr68xqn
 zDOv0e8KAgGaoTyMRKrrmojmESt9oRSSzKek7KOqufjsvffMILhTZHx8U1uoTObTJ3T8
 VhytjeYu5shh9pzRrZwrspfMh4rG4FaVxd+YyCllYvvPivAerRg/XGsheywQIXfqQMKJ
 U+Y5/VSYYglmGIJymcgTj1ThoHi+UZaFDQ+pvQo37gwFJuEbsbfqmji98Nzez4/uAJ+I
 7ZQrzefjvxJdlMHSJ3LGuI4huj3oZdzU6+BWpMCHWbj21dQhtQ82l4oDCEHWphj/g6U4
 tQMA==
X-Gm-Message-State: AOJu0Yz3L9OLTj1av5hrsExeMoZJVcniPdfzDbfP7h7DjJO8AhuNdQZX
 Zr4ZBVqVke8VkLxOKDGcWqiJoQ==
X-Google-Smtp-Source: AGHT+IFEcP6nNM2tn23vWZEuwYJ/nuwz4l3BigTTnbGtfSoG6tM+WQPX8BJ9YkCMuIfLCFB5Ci9QKQ==
X-Received: by 2002:a05:600c:4216:b0:40c:87e:a52e with SMTP id
 x22-20020a05600c421600b0040c087ea52emr1551895wmh.186.1701718975970; 
 Mon, 04 Dec 2023 11:42:55 -0800 (PST)
Received: from [192.168.69.100] ([176.176.140.35])
 by smtp.gmail.com with ESMTPSA id
 hg10-20020a05600c538a00b0040b398f0585sm16433701wmb.9.2023.12.04.11.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 11:42:55 -0800 (PST)
Message-ID: <7aa25b43-eb95-460e-9a80-22cb3991c7c8@linaro.org>
Date: Mon, 4 Dec 2023 20:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu ppc64 crash when adding CPU
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Michal_Such=C3=A1nek?=
 <msuchanek@suse.de>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20231204183638.GZ9696@kitsune.suse.cz>
 <CAJSP0QUShqgd18ZFib-EzwWbG1uz4E4pKNXpiTBauQhsDXUiyw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QUShqgd18ZFib-EzwWbG1uz4E4pKNXpiTBauQhsDXUiyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi,

On 4/12/23 19:57, Stefan Hajnoczi wrote:
> On Mon, 4 Dec 2023 at 13:37, Michal Suchánek <msuchanek@suse.de> wrote:

>> Looking at tcg.c line 784 is here:
>>
>> ster_thread(void)
>> {
>>      TCGContext *s = g_malloc(sizeof(*s));
>>      unsigned int i, n;
>>
>>      *s = tcg_init_ctx;
>>
>>      /* Relink mem_base.  */
>>      for (i = 0, n = tcg_init_ctx.nb_globals; i < n; ++i) {
>>          if (tcg_init_ctx.temps[i].mem_base) {
>>              ptrdiff_t b = tcg_init_ctx.temps[i].mem_base - tcg_init_ctx.temps;
>>              tcg_debug_assert(b >= 0 && b < n);
>>              s->temps[i].mem_base = &s->temps[b];
>>          }
>>      }
>>
>>      /* Claim an entry in tcg_ctxs */
>>      n = qatomic_fetch_inc(&tcg_cur_ctxs);
>>>>> g_assert(n < tcg_max_ctxs); <<<
>>      qatomic_set(&tcg_ctxs[n], s);
>>
>>      if (n > 0) {
>>          alloc_tcg_plugin_context(s);
>>          tcg_region_initial_alloc(s);
>>      }
>>
>>      tcg_ctx = s;
>> }
>>
>> Any idea why qemu would be crashing here?
> 
> Hi Michal,
> 
> $ git grep tcg_cur_ctxs
> tcg/region.c:409:    unsigned int n_ctxs = qatomic_read(&tcg_cur_ctxs);
> tcg/region.c:889:    unsigned int n_ctxs = qatomic_read(&tcg_cur_ctxs);
> tcg/tcg-internal.h:34:extern unsigned int tcg_cur_ctxs;
> tcg/tcg.c:241:unsigned int tcg_cur_ctxs;
> tcg/tcg.c:806:    n = qatomic_fetch_inc(&tcg_cur_ctxs);
> tcg/tcg.c:1369:    tcg_cur_ctxs = 1;
> 
> I don't see a qatomic_dec(&tcg_cur_ctxs) anywhere, so it seems hot
> unplugging a vcpu doesn't release the tcg_cur_ctxs refcount. Do we
> need a tcg_unregister_thread() function?

Suggested fix posted as RFC patch:
https://lore.kernel.org/qemu-devel/20231204194039.56169-1-philmd@linaro.org/

