Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8697A47C1
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:03:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiC1i-000311-TO; Mon, 18 Sep 2023 07:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiC1T-0002aP-Gh
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiC1K-0002Cg-QO
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695034941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFXPTDMTTSxkGeou7Rz71qaFzQ24YcuH/j6q7aWNEiE=;
 b=JElNsMUvsOJDF8+ygS6DBri+P8K/ToLTsDsIzQIrA3FkcJ5iPi+vxpar7BLosuxa8JQoHG
 O5CtxhIe/BC+idHf0vLOmP7vmpipfTgtNJfoQaGb5K53wmvxrvhWX9RxDFr1FF5VaKz4Yp
 LYQBMV7dpA8Fs9SFdOVe8q52gViSyfs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-5egldhByMAGrt9FzltW_JA-1; Mon, 18 Sep 2023 07:02:19 -0400
X-MC-Unique: 5egldhByMAGrt9FzltW_JA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a355c9028so307339166b.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 04:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695034938; x=1695639738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFXPTDMTTSxkGeou7Rz71qaFzQ24YcuH/j6q7aWNEiE=;
 b=EUbiQkENZo67uQpd00vuSDp8JU6l40jXqe7AEdVDxJOD6Io5ae+NjSDfHBMBqWaZoe
 a6Y8quF91w+xUrxCChhG3gVbu24ZIy7GEqX8qh3JBiR5HPAm0GKv9gIIsv0OXfLGyIso
 brn/wI4Z+So4SbzsRLeGcaJsFY5wahyIr9kLiaRVmK3FVXr0aO+tntABRqCBJulQIJ8P
 Ru6W3TCjCwa61nCxiD5WzivihcLD1914ulKpNhv7gcMj3SxPPGvrVc68UmX0es4/5im0
 uGlUWsygzMvm+a3RNNFP/i9/sH0YCrYqSu+YOKpfnpQDYVTkdgpeyEsZYK+7jwoxcIrb
 V48w==
X-Gm-Message-State: AOJu0YybipuYhW+Auqbtpm5E7DSDYEw7/ghD3JtBOD6a/fdFddcM+d/0
 z9VvaranbKDlBT3zx4LsGMt2+gxtsa+cRY/SR5BJVOT+MQa6j9jzTZseLVYemqfh7bnuGKNNcvj
 LmwNzqGJ1vkaO+uXO/Dm/9kefcxEM1Sw=
X-Received: by 2002:a17:906:31c7:b0:9ad:be8a:a588 with SMTP id
 f7-20020a17090631c700b009adbe8aa588mr7633372ejf.1.1695034938080; 
 Mon, 18 Sep 2023 04:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiSbWv5Ojw3VvFd6QR010u+6N/vpMru1lHJ3GVLdDwfCCfYorIW0AAmjmDpWMoy0mj/nya1tqePtQkuI5cU2I=
X-Received: by 2002:a17:906:31c7:b0:9ad:be8a:a588 with SMTP id
 f7-20020a17090631c700b009adbe8aa588mr7633347ejf.1.1695034937627; Mon, 18 Sep
 2023 04:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230908095024.270946-1-anisinha@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
 <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
 <30f0ddfb-6eb7-84a5-04a0-e11905451733@redhat.com>
 <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
 <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
 <08530A80-90F3-4E33-9B1A-E71A66726123@redhat.com>
 <e052a3c4-33e9-1d75-dc9b-3c64f8ae777b@redhat.com>
 <41A3B19D-87B7-4FD6-A5C7-17D758B2DB37@redhat.com>
 <143a437c-be99-d6d8-732f-e9544e2d9b35@redhat.com>
 <CAK3XEhOQCudb0VsBHFfubbcRredLMuSQCTA6fhbg99f7W9y5PA@mail.gmail.com>
 <8af5fb9f-83dc-f997-e761-f8e69f9515ac@redhat.com>
 <CAK3XEhMTSP7TkJgKX1_VxUVxaoU1jX8d_i-0H4t=bNktY5wo5g@mail.gmail.com>
 <5b22fff5-270f-0ab5-1ee5-2e54f491aefd@redhat.com>
 <CAK3XEhMf88si5NcQbAODRC+7760ymgFOx83a_ih4jOqoaDDcyg@mail.gmail.com>
 <cce0cebd-952f-9ed9-f2fd-d84dd666d322@redhat.com>
 <CAK3XEhO9DAWE6SXd4Nmham3Q=MMLU6Dda1O=EHwz55iMELv3zQ@mail.gmail.com>
In-Reply-To: <CAK3XEhO9DAWE6SXd4Nmham3Q=MMLU6Dda1O=EHwz55iMELv3zQ@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 18 Sep 2023 16:32:06 +0530
Message-ID: <CAK3XEhN4Apg3QBJBmUKEWgP76Xp_nO5-j6CaHpCHHxeOo-=2jA@mail.gmail.com>
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 18, 2023 at 4:30=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> On Mon, Sep 18, 2023 at 4:28=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 18.09.23 12:54, Ani Sinha wrote:
> > > On Mon, Sep 18, 2023 at 3:49=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> > >>
> > >> On 18.09.23 12:11, Ani Sinha wrote:
> > >>
> > >>>
> > >>>      Ok hopefully my last question. I am still confused on somethin=
g.
> > >>>      Does the above mean that the hole64 will actually start from a=
n
> > >>>      address that is beyond maxram? Like basically if you added all=
 of
> > >>>      ram_below_4G, ram_above_4G, hot plug_mem and pci_hole64 then c=
an it
> > >>>      exceed maxram? I think it will. Does this not an issue?
> > >>
> > >> If you'd have a 2 GiB VM, the device memory region and hole64 would
> > >> always be placed >=3D 4 GiB address, yes.
> > >>
> > >> As maxram is just a size, and not a PFN, I don't think there is any
> > >> issue with that.
> > >
> > > So this is all just a scheme to decide what to place where with maxra=
m
> > > amount of memory available. When the processor needs to access the
> >
> > Yes. ram_size and maxram_size are only used to create the memory layout=
.
> >
> > > memory mapped PCI device, its simply dynamically mapped to the
> > > available physical ram. Is my understanding correct here?
> >
> > I'm no expert on that, but from my understanding that's what the
> > pci/pci64 hole is for -- mapping PCI BARs into these areas, such that
> > they don't conflict with actual guest RAM. That's why we still account
> > these "holes" as valid GFN that could be used+accessed by the VM once a
> > PCI BAR gets mapped in there.
>
> Yes that was my understanding too but since device drivers need to
> access those BAR addresses, they need to be mapped to the actual
> available physical ram.

No sorry I was confused. They are just register addresses on the
device unrelated to RAM.


