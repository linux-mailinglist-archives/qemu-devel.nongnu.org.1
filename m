Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E70CB7787CD
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 09:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUM9h-0001WX-Vl; Fri, 11 Aug 2023 03:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qUM9K-0001Pf-Cd
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 03:01:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qUM9H-0007U8-Tq
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 03:01:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe5695b180so14339455e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691737286; x=1692342086;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GnEgtBOFOPJD60jWty+zwjcaT5pxpLUINeaMh7ZaYyU=;
 b=nYglEKKmJhagElHy1fmCXp8/ElKzg0iSAtnBXu9J1oJ6BJObLIXWV3cZ2r0acp/tmu
 OWK3JeHbxbAJFwwqcApFfGMOWMXTgnLTE/+XRFsbYjD5xYXyi1kb1Jw8Bv1Hoz8D5I8O
 dU9XkiZyDow6hNo1vfkIc1NLn5/kgleBR8p+932Y88m0NhaQ9sG8fvWX688Y8KiKmkTL
 VLtxlgB583Vv65chQaBq/z2i3aoeoADuxzF+pb/QJ+60n81S8CrNtTsXf4xIyW3NW4EM
 6uehNOc7jy8Fa/0WAQS5gFBPWrTO5dQOptrrqlRz3R3Sc3DZEtCqUiLjRJtlK5oHHwRo
 vxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691737286; x=1692342086;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GnEgtBOFOPJD60jWty+zwjcaT5pxpLUINeaMh7ZaYyU=;
 b=EPHxEtlqGCYKOH/B/GR40ssk5VH0UF3Gk6rweKPgUjpeQXVHHtdyEPQOXKr/3gKXNQ
 A3NqH57wiCPwNUd8wRDBqxWG8zMYq4quTMJVT3qxo2o1fDRBviE1hssKNoo2nq8wdWUm
 F9Dr5+0SeBD201hiAcK5upPhZsf5rGzYMb5MwNmWKs0uqJWyzdih4IM5GUg61s9/4z5G
 ve0j5OcHQLKzRxHgIWOuFJXNHQIp+wM+8wYi6faPTIM93DKyVhwkZrR/ZGwv99JOHfCS
 FAksG+sDE6OIQ94jQWXJbcqOmSHDff8sl6n7Ykndf1u51ouvNEsnj0+ks/HleIOMjXY4
 5KZw==
X-Gm-Message-State: AOJu0YzGSCdBslJ2yC1MdmXB2Bc649wYtb3FPv4YN5aprm5l5wm1yl8z
 /nXIl8z0AzJ5eMjUB8aA7Y+5/w==
X-Google-Smtp-Source: AGHT+IEdrCXJbfBsWEV5vlzvwkT2lHyLqPI+nD4BHbsR770dgcBzO87q7bEyyQoUeNS5z+YEeYWUkA==
X-Received: by 2002:a05:600c:2949:b0:3f7:f584:579b with SMTP id
 n9-20020a05600c294900b003f7f584579bmr847873wmd.9.1691737285946; 
 Fri, 11 Aug 2023 00:01:25 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a1ced04000000b003fe61c33df5sm7184763wmh.3.2023.08.11.00.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 00:01:25 -0700 (PDT)
Date: Fri, 11 Aug 2023 09:01:19 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Vineet Gupta <vineetg@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 kito.cheng@gmail.com, Jeff Law <jeffreyalaw@gmail.com>, 
 Palmer Dabbelt <palmer@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 2/2] riscv: zicond: make default
Message-ID: <20230811-f81889afd0f38ffdc215883d@orel>
References: <20230808181715.436395-1-vineetg@rivosinc.com>
 <20230808181715.436395-2-vineetg@rivosinc.com>
 <ff43edc3-f160-e57d-deb1-185601ed5b7d@ventanamicro.com>
 <1aa3bdff-0db4-c589-8863-56bbea825fda@rivosinc.com>
 <CAKmqyKP2jQ1TYFNjMJNJxGqxHgq5fe5RhBhJDiPE1DoBXpf0gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKP2jQ1TYFNjMJNJxGqxHgq5fe5RhBhJDiPE1DoBXpf0gw@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x331.google.com
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

On Thu, Aug 10, 2023 at 02:07:17PM -0400, Alistair Francis wrote:
> On Tue, Aug 8, 2023 at 6:10 PM Vineet Gupta <vineetg@rivosinc.com> wrote:
> >
> >
> >
> > On 8/8/23 14:06, Daniel Henrique Barboza wrote:
> > > (CCing Alistair and other reviewers)
> > >
> > > On 8/8/23 15:17, Vineet Gupta wrote:
> > >> Again this helps with better testing and something qemu has been doing
> > >> with newer features anyways.
> > >>
> > >> Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
> > >> ---
> > >
> > > Even if we can reach a consensus about removing the experimental (x-
> > > prefix) status
> > > from an extension that is Frozen instead of ratified, enabling stuff
> > > in the default
> > > CPUs because it's easier to test is something we would like to avoid.
> > > The rv64
> > > CPU has a random set of extensions enabled for the most different and
> > > undocumented
> > > reasons, and users don't know what they'll get because we keep beefing
> > > up the
> > > generic CPUs arbitrarily.
> 
> The idea was to enable "most" extensions for the virt machine. It's a
> bit wishy-washy, but the idea was to enable as much as possible by
> default on the virt machine, as long as it doesn't conflict. The goal
> being to allow users to get the "best" experience as all their
> favourite extensions are enabled.
> 
> It's harder to do in practice, so we are in a weird state where users
> don't know what is and isn't enabled.
> 
> We probably want to revisit this. We should try to enable what is
> useful for users and make it clear what is and isn't enabled. I'm not
> clear on how best to do that though.
> 
> Again, I think this comes back to we need to version the virt machine.
> I might do that as a starting point, that allows us to make changes in
> a clear way.

While some extensions will impact the machine model, as well as cpu
models, versioning the machine model won't help much with ambiguity in
cpu model extension support. Daniel's proposal of having a base cpu mode,
which, on top, users can explicitly enable what they want (including with
profile support which work like a shorthand to enable many extensions at
once), is, IMO, the best way for users to know what they get. Also, the
'max' cpu model is the best way to "quickly get as much as possible" for
testing. To know what's in 'max', or named cpu models, we need to
implement qmp_query_cpu_model_expansion(). Something that could be used
from the command line would also be nice, but neither x86 nor arm provide
that (they have '-cpu help', but arm doesn't output anything for cpu
features and x86 dumps all features out without saying what's enabled for
any particular cpu model...)

I know x86 people have in the past discussed versioning cpu models, but
I don't think that should be necessary for riscv with the base+profile
approach. A profile would effectively be a versioned cpu model in that
case.

Finally, I'd discourage versioning the virt machine type until we need
to worry about users creating riscv guest images that they are unwilling
to modify, despite wanting to update their QEMU versions. And, even then,
we should only consider versioning when we're aware of problems for those
static guest images, i.e. we introduce a change to the virt machine model
which breaks that supported, old guest image. (NB: It was me that
advocated to start versioning Arm's virt machine type. In hindsight, I
think I may have advocated prematurely. I'm trying not to make that
mistake twice!)

> 
> >
> > I understand this position given the arbitrary nature of gazillion
> > extensions. However pragmatically things like bitmanip and zicond are so
> > fundamental it would be strange for designs to not have them, in a few
> > years. Besides these don't compete or conflict with other extensions.
> > But on face value it is indeed possible for vendors to drop them for
> > various reasons or no-reasons.
> >
> > But having the x- dropped is good enough for our needs as there's
> > already mechanisms to enable the toggles from elf attributes.
> >
> > >
> > > Starting on QEMU 8.2 we'll have a 'max' CPU type that will enable all
> > > non-experimental
> > > and non-vendor extensions by default, making it easier for tooling to
> > > test new
> > > features/extensions. All tooling should consider changing their
> > > scripts to use the
> > > 'max' CPU when it's available.
> >
> > That would be great.
> 
> The max CPU helps, but I do feel that the default should allow users
> to experience as many RISC-V extensions/features as practical.
> 

If the virt machine type has a default cpu type, then why not set it to
'max'?

Thanks,
drew

