Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3137D3737
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quuP8-0007Yb-1W; Mon, 23 Oct 2023 08:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1quuP6-0007Vu-0V
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:51:32 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1quuP2-00057b-LB
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:51:31 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so4747805a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698065486; x=1698670286; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d/GZw909RfOunItm2KggrrXC9aZXw2AvjFnQ9ajvocM=;
 b=MD3nCnbk/EodSkQuGaDENRSvoSJKf6SlsdTm3gUjRa5miYZ7DZn/Ac7AAA/oLJkoe6
 aLzrBk/ELuZlASM1omwDYn2YKNLMBFTLgCUg26qM+tHcFBgJKRDCKKjeTEpsk8xPOGsf
 9RZExAAde7Eo1QsXN9g4Ujq0eYUfISfWX+ror6KGZfhUDOicZga1zzubmGCi+hISr7rW
 zT66bdWDX2CNEfEDSSXAAUjoXJJ1E9j8FCWSngNV+o0Rsx9EsoN7w3k/aVSMHIajxUtd
 e3JH+SsxUJWT4T2NSNi2fUs4pij+9he0HWxwkrvXYiyzjOE1jQP07z9PZY9nITxi5yS6
 KGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698065486; x=1698670286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/GZw909RfOunItm2KggrrXC9aZXw2AvjFnQ9ajvocM=;
 b=FgzLihrhcIw8e1iVk95F5Gil2Jp6Q7y00umwgLi0aQzMbCm2/OAtsgHDzkkdOerB9W
 VY3dYmRISJAkehsrRLTfLrR9mhKi3pzZwbKpk6KdmOxsmvsWKvCCOIQVWkFWo+G1hvUH
 5XURAE79IUuhvERdzPneqFs6Dcokd/q2nsjDIcXQEBh2qRIpr+wYVThCRWVcLxjt0082
 qqFwaqPBr3XlwaVD0Fey8/pHsIjqO0B3ugm6/e5jxK8uvN9Whl5CtoeC4Bb6iiJg1qVa
 CDCGS/jJnLKmDg0r/oj6p3tARbSITTsf8SXUmFyTLalQGyq2CBpr6Y16LLr/Snu62Iu0
 2CHw==
X-Gm-Message-State: AOJu0Yx66wj5sDx0nFOfV3nBRmdyGYJMISLUTP5mLmr0jOHXgHPeu5LL
 b6ZuDX+9oJOOSdT8LodKy8YwxQ==
X-Google-Smtp-Source: AGHT+IFBciXYXg1yuOeb1sIjU/vrRgC0KZtXxGjy/j9OZ0NZUYqkSKgdw2wODEDy2OuyCqF4YXFadg==
X-Received: by 2002:a17:907:2ce1:b0:9c1:9bc5:c25c with SMTP id
 hz1-20020a1709072ce100b009c19bc5c25cmr7471111ejc.22.1698065486485; 
 Mon, 23 Oct 2023 05:51:26 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a170906261900b00992e14af9c3sm6647585ejc.143.2023.10.23.05.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:51:26 -0700 (PDT)
Date: Mon, 23 Oct 2023 14:51:25 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Anup Patel <apatel@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [PATCH v3 07/12] hw/riscv/virt-acpi-build.c: Add CMO information
 in RHCT
Message-ID: <20231023-bef871e5fa4e26f66db68961@orel>
References: <20231019132648.23703-1-sunilvl@ventanamicro.com>
 <20231019132648.23703-8-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019132648.23703-8-sunilvl@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 19, 2023 at 06:56:43PM +0530, Sunil V L wrote:
> When CMO related extensions like Zicboz, Zicbom and Zicbop are enabled, the
> block size for those extensions need to be communicated via CMO node in
> RHCT. Add CMO node in RHCT if any of those CMO extensions are detected.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/virt-acpi-build.c | 64 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 8 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

