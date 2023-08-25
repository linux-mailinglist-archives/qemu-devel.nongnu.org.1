Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DCA788D09
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 18:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZZRL-0008Me-E1; Fri, 25 Aug 2023 12:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qZZRH-0008Lx-09
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 12:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qZZRD-0007UT-GP
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 12:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692980009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLgA5GA1BS1SZQloMrD4D4Qd55Hj2TTaXj7bked/6OU=;
 b=cETqUxKZzcafcWEFsEW3dfxrEwUP6wfNUulABundxLDcvSXmm2sd6+I+bcOnWClzY+CjAc
 nULM+TaGCbTlbLZSDJ/BOipog8NXKbyKwgUuu7uSH9r7TQtBK75NwdtABpkDxzA0oeJE5F
 +U+9ocG+FuJVoNIXc/UFXTnE2QIcM4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-RvVKkr4mPFKvG8MevnkZdg-1; Fri, 25 Aug 2023 12:13:26 -0400
X-MC-Unique: RvVKkr4mPFKvG8MevnkZdg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so8649215e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 09:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692980006; x=1693584806;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OLgA5GA1BS1SZQloMrD4D4Qd55Hj2TTaXj7bked/6OU=;
 b=iVAWFmzvNPXU94XX7NI5CKMs7FLsHjMZOfEF3kCdzWju2IdVAeQDxTLrePdBR5a5s1
 zLHh3O83Le/tqTEpCzh/brTpNqg2ld8QFFhD3GPd0OLcpgfdU1pIpGPNYMhVf9btAf4R
 LI0ljkvUG50l1pmZvR3z4e/s00sAiUrN62EQV2pu1P/daT5vRjYNxgTnS5K4D3z39bgk
 7ygjpyAVLzYZDwKHFRsWsasx9IQxtn8kxP2jSPS3SOK125Sz/SNTRmZN8qSpYezVa/Tl
 wX5jWvfg1hsZV6QXfkFuk5DAxWKgMXnGn0vwSzAGHuzN7j1qiwWIZMogRWGSyILll5e1
 xlpg==
X-Gm-Message-State: AOJu0YyF53A/Nhj+uA5vK77EjkcXNST41sjuMlLb1yy3PhvEz6paeG6y
 0kKgHea47nTJ1zOXVmxCbyEgSPVDeZ70onW/VqVU3gTs4Lq7gihGU2wocdqENRxhKduH9bxSb9e
 aQTwyyHLRzxHYeo8=
X-Received: by 2002:a05:600c:3653:b0:401:b0f2:88c1 with SMTP id
 y19-20020a05600c365300b00401b0f288c1mr3584994wmq.29.1692980005810; 
 Fri, 25 Aug 2023 09:13:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7ZGWgId/n8Ar+EPkYScVcuqpxdr74k7RnDAImmjwaVSK3oR5u2/8xTV85SLoqW5orhrSNxw==
X-Received: by 2002:a05:600c:3653:b0:401:b0f2:88c1 with SMTP id
 y19-20020a05600c365300b00401b0f288c1mr3584983wmq.29.1692980005482; 
 Fri, 25 Aug 2023 09:13:25 -0700 (PDT)
Received: from [192.168.178.136] (port-92-192-26-146.dynamic.as20676.net.
 [92.192.26.146]) by smtp.gmail.com with ESMTPSA id
 e14-20020adfef0e000000b00315af025098sm2612753wro.46.2023.08.25.09.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 09:13:24 -0700 (PDT)
Message-ID: <31cfbe193fe6638510d310f3e2a3de6c5365006a.camel@redhat.com>
Subject: Re: [PATCH 3/3] target/i386: Fix duplicated feature name in FEAT_KVM
From: Tim Wiederhake <twiederh@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Aug 2023 18:13:24 +0200
In-Reply-To: <26d1e42b-3522-7a8a-1529-1067186e81d5@linaro.org>
References: <20230824135710.343175-1-twiederh@redhat.com>
 <20230824135710.343175-4-twiederh@redhat.com>
 <26d1e42b-3522-7a8a-1529-1067186e81d5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.129.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 2023-08-24 at 17:12 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> On 24/8/23 15:57, Tim Wiederhake wrote:
> > The mistake became apparent as there were two features with the
> > same name
> > in this cpuid leaf. The names are now in line with the
> > documentation from
> > https://kernel.org/doc/html/latest/virt/kvm/x86/cpuid.html
> >=20
>=20
> Fixes: 642258c6c7 ("kvm: add kvmclock to its second bit")
> ?
>=20
Right, added that locally. Thanks!

> > Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
> > ---
> > =C2=A0 target/i386/cpu.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 0b74d80371..ceb291f8a8 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -852,7 +852,7 @@ FeatureWordInfo
> > feature_word_info[FEATURE_WORDS] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [FEAT_KVM] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D CPUID_=
FEATURE_WORD,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .feat_names =3D =
{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "kv=
mclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "kv=
mclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock2",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-
> > pv-unhalt",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "kvm-poll-control", "kvm-pv-sched-yield", "kvm-
> > asyncpf-int", "kvm-msi-ext-dest-id",
>=20


