Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC06273DC0C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:11:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDjBD-0006On-Fg; Mon, 26 Jun 2023 06:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDjAn-0006MC-57
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:10:19 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDjAl-0001r1-5G
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:10:16 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so4002572e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687774212; x=1690366212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=74FM579RKOmTf3FtTjRf/xU5EA/KuNtZjlzUaBEQ9kQ=;
 b=nLE/Pm3qhLC2qx5vPyjVFKPQrxJF0K91GUhvZGs/DHxYhPV8rkozpMNmKi64J4OQDG
 jqZ61YXBN4PsQVhzfrQdMGxeDdx0HC9R1ur7HFa6ZD055H1jBVBU/gMKMaLU1wF2l0Wj
 dr2iytS7iEtatP2QefppN8lUThrS6jxbFW1MXMmCTavhZlNPl1e70U6avo5ighXSSPd7
 x+XodVyxam5UDR0y2mNOGL/aUS26/1AfUqNY591YxwLmTcGDrHCwwG+RcfxO7jXFF6/m
 UQiMBSEqfGSZX+q9u3QDw/JKJCsmtRiaRZPBP5Q+0dKfGa/5NzBn63NZeMXlg/XknLyb
 q/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687774212; x=1690366212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=74FM579RKOmTf3FtTjRf/xU5EA/KuNtZjlzUaBEQ9kQ=;
 b=KNawyjLZDwzT+H8D4wfqKHPembAyzoTUy2DpmsYZbKGAQRo3r7qzInQtK98nh6JNXY
 hNNrh6XwBUSd9en6jNqmQmyT76EwynNMEYA9TD8z7PCGF5U09pX5WEuWBHJCauxeKpAU
 3I7x1EJBWpZQDscU+kO1kSZHlIKZse/V/NypI4la5RHwkaxl48oL0cp49VS6EiM9IPyb
 2YdY6l3mLmKYxOHAaZzlJIgI1QFWnbyU/f9ApzACVYZfliFGS1GpqyiaM8SSgpQR0hSk
 3CnAQq2LMHWEF3BOwk2kC8jh0kAxUSaaV7hv4jEZYxn+jN0I71vZrPDqo3DCG7v2MMB6
 oOYg==
X-Gm-Message-State: AC+VfDxqO8RBvylfXGWKQj1qvgsdwwiUG0E1pZRJ7jgL++RKgA3yltZP
 F3NYkWjlWa8nIGkbXPNkz0NLNA==
X-Google-Smtp-Source: ACHHUZ6vqORSRxMfrjz7CD/A/+w802FrwEYPSRxttM5nM7zy+gOj9GIQg8wRk+pyySrD350QiwEj1A==
X-Received: by 2002:a19:7108:0:b0:4ef:f11c:f5b0 with SMTP id
 m8-20020a197108000000b004eff11cf5b0mr15203630lfc.54.1687774210741; 
 Mon, 26 Jun 2023 03:10:10 -0700 (PDT)
Received: from [192.168.157.227] (141.pool92-176-132.dynamic.orange.es.
 [92.176.132.141]) by smtp.gmail.com with ESMTPSA id
 j19-20020a5d4533000000b0030fafcbbd33sm6833820wra.50.2023.06.26.03.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 03:10:10 -0700 (PDT)
Message-ID: <93dda239-00cb-3c5a-c7c2-6ade248e147b@linaro.org>
Date: Mon, 26 Jun 2023 12:10:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 07/16] accel: Rename HAX 'struct hax_vcpu_state' ->
 AccelCPUState
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paul Durrant <paul@xen.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230624174121.11508-1-philmd@linaro.org>
 <20230624174121.11508-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230624174121.11508-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/24/23 19:41, Philippe Mathieu-Daudé wrote:
> We want all accelerators to share the same opaque pointer in
> CPUState. Start with the HAX context, renaming its forward
> declarated structure 'hax_vcpu_state' as 'AccelCPUState'.
> Document the CPUState field. Directly use the typedef.
> 
> Remove the amusing but now unnecessary casts in NVMM / WHPX.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/core/cpu.h         |  5 ++---
>   include/qemu/typedefs.h       |  1 +
>   target/i386/hax/hax-i386.h    |  9 +++++----
>   target/i386/hax/hax-all.c     | 16 ++++++++--------
>   target/i386/hax/hax-posix.c   |  4 ++--
>   target/i386/hax/hax-windows.c |  4 ++--
>   target/i386/nvmm/nvmm-all.c   |  2 +-
>   target/i386/whpx/whpx-all.c   |  2 +-
>   8 files changed, 22 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

