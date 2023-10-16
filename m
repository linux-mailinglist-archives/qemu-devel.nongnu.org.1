Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41A7CA354
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJW3-0003xx-Qk; Mon, 16 Oct 2023 05:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qsJVo-0003xC-W7
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:03:45 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qsJVm-0003od-M1
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:03:44 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so7288886a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697447021; x=1698051821; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JhnG2i1EF58YFEAgHb+76/rCLUTbUHR63uQ8BL3GeZ0=;
 b=ihAZUfG+yJbL7FDh3S6U7h3avtMBBU2R7IJlylV82AmRk0IfhJCE9RiaW77UCFrr5Y
 Pyvm6821tjVBRTPWQfT5dVtppDcMQLs5TCNhZOlCxqgi6vVzUqA17d+0zBBiPDaCAry3
 v3DSkh4O8BIWKvZ+VsskDXttUkqsWkeyS8u7j8TxS89/RLvl+8Repd/h0wgyzGCpACy6
 AR0aj7ZLJKede57dzu2RuALWV6i/LXXcAxqzJitPMhRwLKSlBZrPEHUtSoQvE29HJkK4
 nspiQ4UFhVjuu/+MP+5h0JDCmevxUbE3t5d+figxL0S7CagUfb4hHjzxLIZLz/BzEADU
 cxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697447021; x=1698051821;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JhnG2i1EF58YFEAgHb+76/rCLUTbUHR63uQ8BL3GeZ0=;
 b=g988b428LSvjgoxO9ZIvuuC9NoudvFneaqZH4XRMIBjywNyL/soBcQUJFaBask1XvY
 RC3Ys5Z6S/7pSaSCeT5DBASsQi3FZgPcNcQIvgBru4gI+uAEdYgvDjlndTS4o6w4e8VR
 uUgYWBB3oDDt03wIkpAn6lWWBH9B6AyGlJQ+0mjPMBVU6nxihuxVfFlYK2Z2Cw7Vfp8w
 15A9/RGM6J3VPMx3A1kNKuS+RHs+vogNihqyy//DNr5874P7E/UbryVBOYaLv1Rvq3fr
 jJ3PHV85YTewCCePp8dQ/HHGMyWsZm1y6fw4+i4mwr27JIEDOwnNGiU9Az46mo1M3cL+
 Bjew==
X-Gm-Message-State: AOJu0YyfMFy70KfAp8fbJyhFYrQVvojnIfi/uCCT1qPeT1/eMVn7+LpP
 1hFkQ/6JLWKWOe9yNxU+fuJvKQ==
X-Google-Smtp-Source: AGHT+IETeAWhok+NCbwoECxb6yiBjiPJWpgBqxCWsoiX99lBsnNJ+ejMjfqBmEFLmxb8EE+T/JeI3Q==
X-Received: by 2002:a17:907:d02:b0:9be:1dbd:552e with SMTP id
 gn2-20020a1709070d0200b009be1dbd552emr7595140ejc.68.1697447020991; 
 Mon, 16 Oct 2023 02:03:40 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 lu9-20020a170906fac900b0099bcf9c2ec6sm3613112ejb.75.2023.10.16.02.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 02:03:39 -0700 (PDT)
Date: Mon, 16 Oct 2023 11:03:38 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org, 
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v2 00/10] riscv: RVA22U64 profile support
Message-ID: <20231016-cf26d23a1fe53ee3b5b68513@orel>
References: <20231006132134.1135297-1-dbarboza@ventanamicro.com>
 <CAKmqyKP=4kGpO=8D13iJw7pJSkD9CFary_DHt236+e1GFMAngA@mail.gmail.com>
 <a89189d3-2975-487e-9d2e-bd8ea60feba5@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a89189d3-2975-487e-9d2e-bd8ea60feba5@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52b.google.com
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

On Thu, Oct 12, 2023 at 04:07:50PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 10/11/23 00:01, Alistair Francis wrote:
> > On Sat, Oct 7, 2023 at 12:23 AM Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> > > 
> > > Hi,
> > > 
> > > Several design changes were made in this version after the reviews and
> > > feedback in the v1 [1]. The high-level summary is:
> > > 
> > > - we'll no longer allow users to set profile flags for vendor CPUs. If
> > >    we're to adhere to the current policy of not allowing users to enable
> > >    extensions for vendor CPUs, the profile support would become a
> > >    glorified way of checking if the vendor CPU happens to support a
> > >    specific profile. If a future vendor CPU supports a profile the CPU
> > >    can declare it manually in its cpu_init() function, the flag will
> > >    still be set, but users can't change it;
> > > 
> > > - disabling a profile will now disable all the mandatory extensions from
> > >    the CPU;
> > 
> > What happens if you enable one profile and disable a different one?
> 
> With this implementation as is the profiles will be evaluated by the order they're
> declared in riscv_cpu_profiles[]. Which isn't exactly ideal since we're exchanging
> a left-to-right ordering in the command line by an arbitrary order that we happened
> to set in the code.
> 
> I can make some tweaks to make the profiles sensible to left-to-right order between
> them, while keeping regular extension with higher priority. e.g.:
> 
> 
> -cpu rv64,zicbom=true,profileA=false,profileB=true,zicboz=false
> -cpu rv64,profileA=false,zicbom=true,zicboz=false,profileB=true
> -cpu rv64,profileA=false,profileB=true,zicbom=true,zicboz=false
> 
> These would all do the same thing: "keeping zicbom=true and zicboz=false, disable profileA
> and then enable profile B"
> 
> Switching the profiles order would have a different result:
> 
> -cpu rv64,profileB=true,profileA=false,zicbom=true,zicboz=false
> 
> "keeping zicbom=true and zicboz=false, enable profile B and then disable profile A"
> 
> 
> I'm happy to hear any other alternative/ideas. We'll either deal with some left-to-right
> ordering w.r.t profiles or deal with an internal profile commit ordering. TBH I think
> it's sensible to demand left-to-right command line ordering for profiles only.

left-to-right ordering is how the rest of QEMU properties work and scripts
depend on it. For example, one can do -cpu $MODEL,$DEFAULT_PROPS,$MORE_PROPS
where $MORE_PROPS can not only add more props but also override default
props (DEFAULT_PROPS='foo=off', MORE_PROPS='foo=on' - foo will be on).
left-to-right also works with multiple -cpu parameters, i.e. -cpu
$MODEL,$DEFAULT_PROPS -cpu $MODEL,$MY_PROPS will replace default props
with my props.

I don't think profiles should be treated special with regard to this. They
should behave the same as any property. If one does
profileA=off,profileB=on and there are overlapping extensions then a
sanity check in cpu-finalize should catch that and error out. Otherwise,
why not. Profiles are just like big 'G' extensions and 'G' would behave
the same way.

Thanks,
drew

