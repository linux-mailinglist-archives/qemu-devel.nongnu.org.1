Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF97273C761
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 09:34:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCxlW-0007k3-Id; Sat, 24 Jun 2023 03:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qCxlR-0007je-Ek
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 03:32:57 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qCxlM-0004Yl-19
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 03:32:57 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-98dfb3f9af6so25568566b.2
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 00:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687591969; x=1690183969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jFOfFJMjJKPZon94/NUbHz+xQgBUEgHKhM9pYLWus2w=;
 b=KSAlXwkkZy0/+YL1m8Nndj8ieypmHN+8f/SM4y1zgknWJJciy/LXu+XSYVOqNDQmx+
 KozDhB8X/aMvtl39r0Zn4wUv+PeMXq7ulWnrHtNrjU6QpwyeyfDglUMpBqg7Ez0LulrK
 +pU1F3Ek6QHrV7pXUGrZAZYQN0Npwxvt/1BfbeqQEIUA4jZVTrH7BtmbLb/ylVcEhM1j
 A1neUTzvvSA0Mu0rbqFxxmOC4HI09fdRJFhhIL1tA014SvruYiDSpM3jt6D78z/+j/U4
 s1zoC8grU1+dSyn0BYpMJ0fPa+A8YLa9Obc8m85oMlmaRpZVd4FnXiAkpSF4Fukg+GtM
 DlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687591969; x=1690183969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFOfFJMjJKPZon94/NUbHz+xQgBUEgHKhM9pYLWus2w=;
 b=JRQL7LNofbf0HQAs4GgcZf2ARrVy5eqorAZG5KYbc0xbO/7iY9Iqmj1eXfyLuqmZvA
 5gN9P3a8FmU/Ci5Ia5Pcwk6amXFW0qf8xY/SuSfVUhafaes/CdwMkiEs+o4GkIFJnYyD
 hG37wnkMkMyZKwQw/QHmswiSqPp2z+juPh9o6+lk+ksxa4VWzYAIFSfUW26+WKBJzaU2
 pL2p69q90N61QMY53vLyI9xGyW3ZY1qc+eUMS/GM1CQm5mhb5a2rgM4tZxfKmmTJ+Fy6
 1E0bvcQtixhtKVCzsuNm0Z7sdH131NMdzb/s060wj/iOrVsUSZCjA1Uj35T3TozjfQVa
 bcqg==
X-Gm-Message-State: AC+VfDyE9PwaH9F31oeuozWMT9JxPHefMBWdTsZ/mMKv4QIWjxX7jRgd
 Wqlazaw9nBuni9TeGLz0eNXLQw==
X-Google-Smtp-Source: ACHHUZ76i8ak15+ibI1Cvz+5qAnfEBykUlIV01AhNjSyH1rAVV6Epchk1K7iaYn/XVvY52WEIb2mPA==
X-Received: by 2002:a17:907:6d1a:b0:988:6193:29dd with SMTP id
 sa26-20020a1709076d1a00b00988619329ddmr16523624ejc.53.1687591968996; 
 Sat, 24 Jun 2023 00:32:48 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a170906654700b009875a6d28b0sm581186ejn.51.2023.06.24.00.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jun 2023 00:32:48 -0700 (PDT)
Date: Sat, 24 Jun 2023 09:32:47 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v3 12/19] target/riscv: add KVM specific MISA properties
Message-ID: <20230624-bd82bafb08e5daa8fb81b72f@orel>
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
 <20230622135700.105383-13-dbarboza@ventanamicro.com>
 <20230623-df5c527b7dae3e28123be577@orel>
 <6da71298-8345-f0b1-b086-830425db6ec5@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da71298-8345-f0b1-b086-830425db6ec5@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62f.google.com
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

On Fri, Jun 23, 2023 at 11:14:45AM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 6/23/23 06:38, Andrew Jones wrote:
> > On Thu, Jun 22, 2023 at 10:56:53AM -0300, Daniel Henrique Barboza wrote:
> > ...
> > > +#define KVM_MISA_CFG(_bit, _reg_id) \
> > > +    {.offset = _bit, .kvm_reg_id = _reg_id}
> > > +
> > > +/* KVM ISA extensions */
> > > +static KVMCPUConfig kvm_misa_ext_cfgs[] = {
> > > +    KVM_MISA_CFG(RVA, KVM_RISCV_ISA_EXT_A),
> > > +    KVM_MISA_CFG(RVC, KVM_RISCV_ISA_EXT_C),
> > > +    KVM_MISA_CFG(RVD, KVM_RISCV_ISA_EXT_D),
> > > +    KVM_MISA_CFG(RVF, KVM_RISCV_ISA_EXT_F),
> > > +    KVM_MISA_CFG(RVH, KVM_RISCV_ISA_EXT_H),
> > > +    KVM_MISA_CFG(RVI, KVM_RISCV_ISA_EXT_I),
> > > +    KVM_MISA_CFG(RVM, KVM_RISCV_ISA_EXT_M),
> > > +};
> > > +
> > ...
> > > +static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
> > > +{
> > > +    int i;
> > > +
> > > +    for (i = 0; i < ARRAY_SIZE(kvm_misa_ext_cfgs); i++) {
> > > +        KVMCPUConfig *misa_cfg = &kvm_misa_ext_cfgs[i];
> > > +        int bit = misa_cfg->offset;
> > > +
> > > +        misa_cfg->name = misa_ext_info_arr[bit].name;
> > > +        misa_cfg->description = misa_ext_info_arr[bit].description;
> > 
> > I'd prefer these be set by KVM_MISA_CFG(), since we can. No need to wait
> > until runtime if we can do it at compile-time.
> 
> The compiler will complain about "error: initializer element is not constant" and
> the build will fail. This happens because, apparently, the compiler doesn't see the
> imported array as a constant, regardless of the 'const' type.
>

You're right. Initialization the way I suggested only works when
everything is in the same source file. That's a pity. So we can
either manage it they way you've done here or the way you did
in a previous patch, which was to include the info array in each
source file by putting it in the header. I think I prefer the
approach you used in this version more though.

Thanks,
drew

