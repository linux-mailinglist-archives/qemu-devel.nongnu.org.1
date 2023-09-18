Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824A7A47A5
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBu2-00054e-2I; Mon, 18 Sep 2023 06:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiBu0-00054F-G1
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiBty-0000IU-Qe
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695034489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ojmFIVoVH+1cchuronWhk08OVecw7SgOCJ+pn9T0yo=;
 b=af/+s6Lepj6UGTfxxC//HF+vEwojU+JDB43PqbpCUyPgFBHkPKpwJHxT3jKJexThdwYzot
 TkTkMXW0Zt9/YCtKNt+kSUzxCjjNMsG4x2vuRNSe7Piac6+zquUdWCO1MPyfJXXaCgYw5L
 SbIMW44N0IHkhrWy1g5hODEO9qWKoMs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-Ge01VafXPtyhFqtSk0xLjQ-1; Mon, 18 Sep 2023 06:54:47 -0400
X-MC-Unique: Ge01VafXPtyhFqtSk0xLjQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bfb9db0397so52500441fa.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695034486; x=1695639286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ojmFIVoVH+1cchuronWhk08OVecw7SgOCJ+pn9T0yo=;
 b=Y8eUts9Ukid8MMZ5C89tEO9oZwZoxT9D88E0AGPZvG4hgoJLAEx1JHzHqy1AaYfVZM
 FVTofb2InBmQcsasypAzrIVQagqC5cq7GBjKlc5SOKPomZ7lkQqYE7pwbm7C0o/tzQQQ
 zqTb7rxcK+ry7siLBTgo/2dUmI8UDNv94U10Ivk3GN0Foydh5L2qcY/FF+jhoEmvm7h+
 HKJkLil8+wo1q7UBTns+CIzpGLn5TiRyAqNRRW7par4QzmTQe5w8A1eL4u+mzQmzYKgH
 U2TO6+CG3fXmWWHtnwsKi0+4IqXHRoAPqDpWQGqbzpqB/W4egnuFI6Lj9Xyo/k4IWjd4
 O8nQ==
X-Gm-Message-State: AOJu0YwsXLRKU8dLgo+R+043BGOfEuZXqqsClJJ0bI+DmYyPoMbm+iF8
 wOv4z9z2l0uM9xauOCDIAswyx/HgL9n62Pgau3jXaBoyppYYD2T62EMex1nm9JdVitD1pQZTC7X
 oX/CjQMPVrjfyWeQZumpe5Q/uMP5aYRw=
X-Received: by 2002:a2e:b002:0:b0:2b9:e1dd:5756 with SMTP id
 y2-20020a2eb002000000b002b9e1dd5756mr7223792ljk.45.1695034486085; 
 Mon, 18 Sep 2023 03:54:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyR4lImFTqc9FN54Y+W5M4Eq1WFO7sI528D6I5Rm0yjY/KzLYMsf2f/efANsAxG4MQEu10sc89fsme6qDNOXw=
X-Received: by 2002:a2e:b002:0:b0:2b9:e1dd:5756 with SMTP id
 y2-20020a2eb002000000b002b9e1dd5756mr7223783ljk.45.1695034485784; Mon, 18 Sep
 2023 03:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
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
In-Reply-To: <5b22fff5-270f-0ab5-1ee5-2e54f491aefd@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 18 Sep 2023 16:24:34 +0530
Message-ID: <CAK3XEhMf88si5NcQbAODRC+7760ymgFOx83a_ih4jOqoaDDcyg@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

On Mon, Sep 18, 2023 at 3:49=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.09.23 12:11, Ani Sinha wrote:
>
> >
> >     Ok hopefully my last question. I am still confused on something.
> >     Does the above mean that the hole64 will actually start from an
> >     address that is beyond maxram? Like basically if you added all of
> >     ram_below_4G, ram_above_4G, hot plug_mem and pci_hole64 then can it
> >     exceed maxram? I think it will. Does this not an issue?
>
> If you'd have a 2 GiB VM, the device memory region and hole64 would
> always be placed >=3D 4 GiB address, yes.
>
> As maxram is just a size, and not a PFN, I don't think there is any
> issue with that.

So this is all just a scheme to decide what to place where with maxram
amount of memory available. When the processor needs to access the
memory mapped PCI device, its simply dynamically mapped to the
available physical ram. Is my understanding correct here?

>
> ms->maxram_size is usually only used in combination with ms->ram_size to
> detect if memory devices will be enabled, and to size that region for
> memory devices.
>
> --
> Cheers,
>
> David / dhildenb
>


