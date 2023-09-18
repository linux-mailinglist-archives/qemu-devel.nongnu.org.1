Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 493CA7A47BD
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiC0P-0001b9-Qo; Mon, 18 Sep 2023 07:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiBzn-0001Jc-IS
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiBzl-0001nk-LR
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695034848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmehkUj8qHEX9CWfYPOkemhfEwHmTusLZnjSK4FRXMs=;
 b=i+9o3WaOlN5zEgqqWbjX//dhv83wuNgMQHoU/3PRl7BHd7FrKqqfQBcKYRZH1056OTUCFk
 8GyOlrjttoJDJgxJTXDHrmyxSHNUrqzd3Y6CzqNSETUvZpnaL3Hbfq69sClpOmbt+Gy2pQ
 EPxBdtpARcFGGYLfQpZqqDXzBIpbJhI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-TjwyXr5MNfiEINNsfULcKg-1; Mon, 18 Sep 2023 07:00:47 -0400
X-MC-Unique: TjwyXr5MNfiEINNsfULcKg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bffe368ae3so12398451fa.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 04:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695034845; x=1695639645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EmehkUj8qHEX9CWfYPOkemhfEwHmTusLZnjSK4FRXMs=;
 b=aKB/DN++7bchkxIu2fXiczTpoS7lPe4HJLcZag3eHqeggMr4s8aroD32ktRoFb1c1w
 v9FPMRzTFCi/RLFuvl4x7VJmXgeyITxEpRrzCxAXIncqMqrMYunD6dTcoPduiiXVB5LH
 c+juqC/fu5FKNfF0hImnu4GjHx/AW5bOiindUXFyp0gaQ5PqAdILPTkzQcYYYMRGDgC4
 cvyTPCi5ziF24jsfvkJlhabWFkTSz7qLyGc5hcVKTSmIROARuXnWJ9Sy8x7cXqRPWmtJ
 9sn1H3t21NIZapEZCGzElAG5uAxlAyhSyhdTTEWP/yY8slZz6IZc3L0wdfitXjQTkGCP
 SdNA==
X-Gm-Message-State: AOJu0YwmSaRJIPdfwiCIAmfvPB1oNz4u/MXOsW+AE051BTQ8qhCdV+X2
 wDuEe1FHsk5j8EN0JLjB8PyTDtOEFvMpZ5MEKCU4EJlmFV/c/6GoI9y5VUFV22MnrLWwdmalf1J
 i+Cj+JTpVny6BFsGnHZO3s7EK2wNn5Gg=
X-Received: by 2002:a2e:7c19:0:b0:2bc:dd96:147c with SMTP id
 x25-20020a2e7c19000000b002bcdd96147cmr7703162ljc.34.1695034845673; 
 Mon, 18 Sep 2023 04:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMoZCfpQ4G6venXhv7LIuW1/7SK4WlcLxi2ueSJEG86Jd13dEAYI0Itmz1tbKT0ZfWiLv8p7lZJ4eZWfqMlS4=
X-Received: by 2002:a2e:7c19:0:b0:2bc:dd96:147c with SMTP id
 x25-20020a2e7c19000000b002bcdd96147cmr7703126ljc.34.1695034845268; Mon, 18
 Sep 2023 04:00:45 -0700 (PDT)
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
In-Reply-To: <cce0cebd-952f-9ed9-f2fd-d84dd666d322@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 18 Sep 2023 16:30:33 +0530
Message-ID: <CAK3XEhO9DAWE6SXd4Nmham3Q=MMLU6Dda1O=EHwz55iMELv3zQ@mail.gmail.com>
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

On Mon, Sep 18, 2023 at 4:28=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.09.23 12:54, Ani Sinha wrote:
> > On Mon, Sep 18, 2023 at 3:49=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 18.09.23 12:11, Ani Sinha wrote:
> >>
> >>>
> >>>      Ok hopefully my last question. I am still confused on something.
> >>>      Does the above mean that the hole64 will actually start from an
> >>>      address that is beyond maxram? Like basically if you added all o=
f
> >>>      ram_below_4G, ram_above_4G, hot plug_mem and pci_hole64 then can=
 it
> >>>      exceed maxram? I think it will. Does this not an issue?
> >>
> >> If you'd have a 2 GiB VM, the device memory region and hole64 would
> >> always be placed >=3D 4 GiB address, yes.
> >>
> >> As maxram is just a size, and not a PFN, I don't think there is any
> >> issue with that.
> >
> > So this is all just a scheme to decide what to place where with maxram
> > amount of memory available. When the processor needs to access the
>
> Yes. ram_size and maxram_size are only used to create the memory layout.
>
> > memory mapped PCI device, its simply dynamically mapped to the
> > available physical ram. Is my understanding correct here?
>
> I'm no expert on that, but from my understanding that's what the
> pci/pci64 hole is for -- mapping PCI BARs into these areas, such that
> they don't conflict with actual guest RAM. That's why we still account
> these "holes" as valid GFN that could be used+accessed by the VM once a
> PCI BAR gets mapped in there.

Yes that was my understanding too but since device drivers need to
access those BAR addresses, they need to be mapped to the actual
available physical ram.


