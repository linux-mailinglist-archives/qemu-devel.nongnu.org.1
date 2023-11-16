Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 913247EDC65
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:53:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3XBd-0004BC-Q1; Thu, 16 Nov 2023 02:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XBB-0003tr-5U
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:52:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XB8-00018B-HJ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:52:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso4385485e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700121165; x=1700725965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bVBLTPcn6P6YOOV5bkUTIF63TSWbVHO4Z9N2cS8rcho=;
 b=hiyJxWYkN7eOiYsE5ASuQ8qHQlJE5/kirDv1XOyRVbaWjiviJ2yesR1vW5qig7uGwN
 +84hOJLdOGfS4BGFimpU9i9xCubbZhoHDXL8QSUBTAqPq+PkkrxbRVSiHsUIigPzM6G9
 q/0kVGUMQ7PsSNlt8F0V5fn+YckPRZePVqdQaLelk8o09Mwz7XXQCEfaJ91S2MhBib4R
 LpcRpK03xs3RIev6qeZ19n2h8d4Uv3rRsDEUb105nV5Va5kgpwsjozqCFRvjXolpSZJK
 A9WF+nnxtlaBS++7+GMPSC7GDVg4UJJfm7qc1BIKo0BK5YBZTEfrd/lGyKy7l/WLVWeM
 fKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700121165; x=1700725965;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bVBLTPcn6P6YOOV5bkUTIF63TSWbVHO4Z9N2cS8rcho=;
 b=F5t8ldBp9TJ+sTz9iWLh886eMGUqvftCBHOft3dJl+0u2mhNARKjOeyx992J6TfQKC
 rCyfd72+o9MCYEmJCrOAhD9KFmSlNAdEU1y4+4Sy8ScY2iGidEjvwb/EK29JXtsxQAoe
 EWMyjpKyhb4Me2Y74nZIm6z4NCJaBY21Qz14xx4s221FmFui6PSVCn3YyrnYAWDvu+A8
 lamFjSP526fuwuk1PfnKadvdGU9Lal1tjb2E2Oj/Xzy4tcWDK+oPowWqIWI+bXWxA/Up
 iUIY14L2fuKBVHmmsFGYMgVIKtbM7aEtBl9ANfJiBRn6GeEL8UcwTM7Smcx+5Z6r4jNz
 ZIsQ==
X-Gm-Message-State: AOJu0Yx65B1KBZYkUjPr+b04ZIpz3eiK4aFi+c3hRVdWLD94zkPFkMA3
 WHcpFFUS3IECjdY3FKQ1rVRt8Q==
X-Google-Smtp-Source: AGHT+IHBqojRmgSEo7XDl6FQ5KXswCIsBgJj3xDChttMYF8d3Pg82whdOyGWEDc+THsYTYhF/GPezQ==
X-Received: by 2002:a05:6000:2c1:b0:32f:c750:6ebc with SMTP id
 o1-20020a05600002c100b0032fc7506ebcmr11761156wry.71.1700121165106; 
 Wed, 15 Nov 2023 23:52:45 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a056000024400b0032fb0e2087asm12582889wrz.82.2023.11.15.23.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:52:44 -0800 (PST)
Message-ID: <e76fa4a3-a768-477d-a67d-cc8ba5d777d7@linaro.org>
Date: Thu, 16 Nov 2023 08:52:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/31] target/hexagon: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-12-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-12-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 15/11/23 00:56, Gavin Shan wrote:
> No changes in the output from the following command.
> 
> [gshan@gshan q]$ ./build/qemu-hexagon -cpu ?
> Available CPUs:
>    v67
>    v68
>    v69
>    v71
>    v73
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/hexagon/cpu.c | 20 --------------------
>   target/hexagon/cpu.h |  3 ---
>   2 files changed, 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


