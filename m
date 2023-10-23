Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7547D36B5
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quu6C-0006xi-Ri; Mon, 23 Oct 2023 08:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1quu65-0006wr-SY
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:31:53 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1quu61-00087B-9o
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:31:51 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9b95622c620so494444666b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698064307; x=1698669107; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KF7fL36npFJhBZTQEN1kO2xrKduT7F+8SzUe4B1Jc/M=;
 b=jZCFgcCFGbByAdXm4RE70OsgpC+BOG3kFwtHP6rAAtZrG3//iL3gnE0+azfRF0P+6R
 BSaCpfv6bdDwnlSXZt9KBeYU7P1BAFw8kXv0/mkCr3NNNg32NE+/S2bREWAKsBrFmoqY
 YbycmyYk8En123Rp7CqGCc+Ti/5AloOJyjnMSaIwo6wTfquh4i4KCii0+eTitVSnSnuG
 sX0AR5PiW0AN/yInG0MVUjdOZUudLqcy3xE5hBRjomLlLFJ8WCMQxJlkfEHYTHRMBW95
 w40CRm0x59SPlnE4exZJZpvzMscDFFZ9vwyDMp1nxdNGTjKAzQyZMsFAwTNSRBlNeTgE
 9oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698064307; x=1698669107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KF7fL36npFJhBZTQEN1kO2xrKduT7F+8SzUe4B1Jc/M=;
 b=RQbTZ+QyvS1ahPj+CrUgJmVkOHg3Vifj/HatV6LTATW7eo8WJH4xuJzbpFD/thzrlB
 IwMH2kZNdz/KNaNJHoE8Qs73xA0Et1xhQY4XWlwcKXBsOyYc85BaQkocQ/bOfqatVmRU
 hxP8wx+Cwai+ZeM76WRi1sseEa/Gjn/BF81th1fyseOEBIj7cvSyaRw1d4+MWCsDR9es
 EdR4UgyXsbqQUhdh/h54H0GXF1TjiG1QnKFWnb2Gatt6JWrteD+kxZvdwXD5S2cOj9c7
 jRgzC2Ty7K4mG5EGuDHpEBl5vtpl0NUH/uY9Nx9sEfoyfCuYuj1A2pqR+JCnF1+kOBRP
 IwIA==
X-Gm-Message-State: AOJu0Yx5jEukPMDBz3NgrZByw0mOHZAZeDhg4S2FzMq5TfIrIYwhhVDR
 tN61I1mNW63XFLWHyXmnao0FRw==
X-Google-Smtp-Source: AGHT+IGuYgskNikwO7VpjNvKVkHGx7Yu4RlWOWR9qopFtT0YI1Gg24xUOiYwhNz58z6L2WeG2QHGSA==
X-Received: by 2002:a17:906:6a22:b0:9be:d15e:8ca2 with SMTP id
 qw34-20020a1709066a2200b009bed15e8ca2mr5289295ejc.39.1698064307406; 
 Mon, 23 Oct 2023 05:31:47 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 u21-20020a50d515000000b0053dbb214d96sm6390502edi.13.2023.10.23.05.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:31:47 -0700 (PDT)
Date: Mon, 23 Oct 2023 14:31:46 +0200
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
Subject: Re: [PATCH v3 03/12] hw/riscv: virt: Make few IMSIC macros and
 functions public
Message-ID: <20231023-676f1ddf57f2af985da7c382@orel>
References: <20231019132648.23703-1-sunilvl@ventanamicro.com>
 <20231019132648.23703-4-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019132648.23703-4-sunilvl@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 19, 2023 at 06:56:39PM +0530, Sunil V L wrote:
> Some macros and static function related to IMSIC are defined in virt.c.
> They are required in virt-acpi-build.c. So, make them public.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt.c         | 25 +------------------------
>  include/hw/riscv/virt.h | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 24 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

