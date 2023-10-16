Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0A87CB038
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:49:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQmg-0007Qa-Dd; Mon, 16 Oct 2023 12:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsQmP-0007No-2I
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsQmN-0006G0-Ks
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697474958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vMjT+8kBV2OtIcrovFH8KN8YLUolB5Ho3/ZwTsGsHI=;
 b=Q9Vas5nVWYaQxAtNCazcLyT/0Vsahdd2FHhvLV7S4LVtbQGks2mdiE8XYFtwKBz0EkkWoq
 xd38jYQ7NAou/fQLo4d3w3qpLAhyPl5TN/x+/RW1uPXuvGUvYkhwNL9yRa7JTyULrb6kg4
 rE0eB7ypXWfVIZH5g3vbjIjE5YI6njQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512--SM_kOKSP1aYVasu3I5bLw-1; Mon, 16 Oct 2023 12:49:06 -0400
X-MC-Unique: -SM_kOKSP1aYVasu3I5bLw-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-457dc70bba9so613760137.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697474946; x=1698079746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/vMjT+8kBV2OtIcrovFH8KN8YLUolB5Ho3/ZwTsGsHI=;
 b=YPJZtAeviYSZYKptLFClgH7GoSeCs08DZCEJn0/u52CjUBrEQIslQgPkEO+jggo2p5
 SDwGpBQfY1GqEtDt4bJUwBFDfMObpVsE54UIIv93sbi5dKItquBEOdAKpW/gwXt6VbUJ
 V6ve2ZkYtQF/6ioPMJYMUS0p2SQvTxO9O5f4/XBDCHIEiSG3GWgBOQ8s2PGSkoVHvOpB
 JDqWBW1Oeb46+2w+RtWzhdIxb4GULNFdVxYG+Hke+cFgAZ+6mwiq+rnNuE40aHAufFvW
 aGEKktC3maPpxsUdwl3vPl03NsS8ghPA82yBDu8qvXM6rBWqzK/10iwjVyXFB+OwO8C6
 WQQw==
X-Gm-Message-State: AOJu0YzIDHrp9qw2p4PZZoX3Nvk2hba2ZTSreKtTND9OpK40+LD2Q2yR
 +g2hE3OZqsnC72AovXdOewzgunUc5GC6Lsgst0nMQzyweLDY1Gb2hPANfckza6kkHbgHJ/QDtnm
 tg+mhFim1M3ui1VAx7F6ErI51OKwueqc=
X-Received: by 2002:a05:6102:3188:b0:457:b01c:4a8e with SMTP id
 c8-20020a056102318800b00457b01c4a8emr9654689vsh.7.1697474946311; 
 Mon, 16 Oct 2023 09:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2nMCgxGH2XJd4mD8dTCNSUsS8USwHn1c/YZKMQzafMZDwWSBWNDWaD0roR+/4gMK/VrK8WbTvEglX51o9bXk=
X-Received: by 2002:a05:6102:3188:b0:457:b01c:4a8e with SMTP id
 c8-20020a056102318800b00457b01c4a8emr9654681vsh.7.1697474946024; Mon, 16 Oct
 2023 09:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230922140914.13906-1-phil@philjordan.eu>
 <4319fcd1-981c-4ef0-b6b9-1f7f57c1c4ca@redhat.com>
 <CAGCz3vuF1=Ee6_G+23QJD-u+-cY0jVJW8kz9Lrgz+KAoMMy1=w@mail.gmail.com>
In-Reply-To: <CAGCz3vuF1=Ee6_G+23QJD-u+-cY0jVJW8kz9Lrgz+KAoMMy1=w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Oct 2023 18:48:54 +0200
Message-ID: <CABgObfaCFS08LgJ2cYKLdqD=cquW3i475fvZFMnA4ih5r+vnGA@mail.gmail.com>
Subject: Re: [PATCH 0/3] hvf x86 correctness and efficiency improvements
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, dirty@apple.com,
 qemu-devel@nongnu.org, rbolshakov@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 16, 2023 at 6:45=E2=80=AFPM Phil Dennis-Jordan <lists@philjorda=
n.eu> wrote:
>
> Hi Paolo,
>
>
> On Mon, 16 Oct 2023 at 16:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 9/22/23 16:09, Phil Dennis-Jordan wrote:
> > > Patch 1 enables the INVTSC CPUID bit when running with hvf. This can
> > > enable some optimisations in the guest OS, and I've not found any rea=
son
> > > it shouldn't be allowed for hvf based hosts.
> >
> > It can be enabled, but it should include a migration blocker.  In fact,
> > probably HVF itself should include a migration blocker because QEMU
> > doesn't support TSC scaling.
>
> I didn't think Qemu's HVF backend supported migration in any form at this=
 point anyway? Or do you mean machine model versioning of the default setti=
ng?

If it doesn't support migration, it needs to register a migration blocker.

> switching to hv_vcpu_run_until() WITHOUT hv_vcpu_interrupt()
> causes some very obvious problems where the vCPU simply
> doesn't exit at all for long periods.)

Yes, that makes sense. It looks like hv_vcpu_run_until() has an
equivalent of a "do ... while (errno =3D=3D EINTR)" loop inside it.

> 1. hv_vcpu_run() exits very frequently, and often there is actually
> nothing for the VMM to do except call hv_vcpu_run() again. With
> Qemu's current hvf backend, each exit causes a BQL acquisition,
> and VMs with a bunch of vCPUs rapidly become limited by BQL
> contention according to my profiling.

Yes, that should be fixed anyway, but I agree it is a separate issue.

Paolo


