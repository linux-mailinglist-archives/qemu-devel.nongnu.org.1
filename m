Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC9709308
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:28:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwPb-0001Fd-LC; Fri, 19 May 2023 05:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzwPZ-0001FS-Eu
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzwPY-0005WL-20
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684488511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVCx4LWG8ejPDSUrMAo5LoHQwWMBbftfXTA4oFvLgRE=;
 b=XZFp0LgJox6BuzoufG5ix5LoWHrLbrT9ev/aRq1iprm5u9+8frtJpvdJBSznKdKcKTIpx6
 F1Wp/Yes76iOE8dFobdzPl9imA2Xnq9d/BqDfQuBb8ARr14Azz/TiK7hp0YQd4Hc3W1wWk
 ZapMANeo5gM6ILXmeRG6fmO05pjbjWo=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-ZMUWi-Z1M3exr9NyposBHg-1; Fri, 19 May 2023 05:28:29 -0400
X-MC-Unique: ZMUWi-Z1M3exr9NyposBHg-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-784207f6e60so122051241.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 02:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684488508; x=1687080508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVCx4LWG8ejPDSUrMAo5LoHQwWMBbftfXTA4oFvLgRE=;
 b=R4UQAeBSMeBWMQ+o1+41oKYlfJZx0Wo12dUtNvGUfznC/ZkwWph22AjgSRuMINJ9VL
 dFqkThmvq6BQFDbO2KeZs2OGz6/8adzvu5MRl0jtATQD7SLGRbn0KwAWF7ROoRsGecE7
 vNI6iduw5CZqoAGcWgR1O6zAc+PoWq9xWjNALMZB6kbAzXLmi3RH7aZfQa6bC6QYHVkm
 TDKTJ2dFp62wHhkCmwbZvXakRqgNQ/pGS2a3WeXudl6pwDj6qxmo4qMbsrqjaXbofc+3
 W+oPeJen4VSuHoHHcoZ4AMi+DZfGff7YN4ALRnIfiBgJCOwLwVXZ7/0UlcRmcP/+CE3e
 D2DQ==
X-Gm-Message-State: AC+VfDz27sfiUWxhASYJY2uVsuXBVCq914jPIUNF+8/ihSFtNPSsw2lj
 OSYwQrc9rsuMAHi8E1sH8jkTRsm7a+BFVXDCr28joWY/W+JYxO1mSVMqoGJJTtCLLIZIMZspzyJ
 FgmHz/vUICdoLoSddfaFwYDKfkK8Z6qU=
X-Received: by 2002:a67:ebd4:0:b0:430:1fa:87c5 with SMTP id
 y20-20020a67ebd4000000b0043001fa87c5mr440837vso.32.1684488508496; 
 Fri, 19 May 2023 02:28:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67merTlLkkkfqb5HHlVhBjtyxzEgh63AtlS3BpA22YJSEbrtty1RcaEaDk30HsFXBAvsxZlVLiG00VA6nNGlo=
X-Received: by 2002:a67:ebd4:0:b0:430:1fa:87c5 with SMTP id
 y20-20020a67ebd4000000b0043001fa87c5mr440830vso.32.1684488508190; Fri, 19 May
 2023 02:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230519085647.1104775-1-pbonzini@redhat.com>
 <CAFEAcA-nMG_5u4pADASoQNF_MCCXHMCB3APTtVLohzTzCmJ3cQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-nMG_5u4pADASoQNF_MCCXHMCB3APTtVLohzTzCmJ3cQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2023 11:28:16 +0200
Message-ID: <CABgObfZ8bx-v_A2wEu5e21y+Nd8WP4rfi6LYP13bm7+6gBfVvw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] meson: use subprojects for bundled projects
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 19, 2023 at 11:21=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Fri, 19 May 2023 at 09:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > QEMU bundles a copy of dtc and keycodemapdb.  They both support meson,
> > so we can run their build system via subproject() instead of hardcoding
> > their contents.
> >
> > In fact, now that QEMU's configure script knows how to install missing
> > Python dependencies, we can replace submodules altogether with .wrap
> > files, which have several advantages, either immediate or potential:
>
> So do we have a path for getting rid of submodules entirely?

For building QEMU, yes.

The firmware submodules would not be affected, but those are really
just a way to ensure we respect the GPL when distributing firmware
blobs. We could keep them, as they mostly stay out of the way, or we
could move the information to files that are then consulted by
scripts/make-release. And those files could very well reuse the same
".ini" format that is used by .wrap files.

Paolo

> I'd be all in favour of that, but I'm somewhat less in favour
> of "some things are submodules and some things are this new
> .wrap file setup"...


