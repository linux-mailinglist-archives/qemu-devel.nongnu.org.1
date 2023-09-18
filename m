Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A77A4DBB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:58:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGc6-0000d0-QH; Mon, 18 Sep 2023 11:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiGc2-0000cd-79
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiGbx-0002iG-8a
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695052592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TteUXHP0iYZstcV4MAENIgoTvtm5SwbdrJ5W9RTLpdI=;
 b=N2sY42mbb5J7lnsS59PonV3x/9I5avlbN7E1yGgLL8YBFhIll6iYww7YRsZeD8XNhfwIT0
 XtR3D1jUEggmTPXQIeoDMyVNMf9bGpabBzEyT1hffG38arWIq5cV93HjWgXJR7sJKliGwx
 dMD6PgKupao/Ry3vZ8/T155NRBKaaG4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-zvyU410iNYGWAT5IJ3kFKw-1; Mon, 18 Sep 2023 11:56:31 -0400
X-MC-Unique: zvyU410iNYGWAT5IJ3kFKw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bff8e92054so20261211fa.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695052589; x=1695657389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TteUXHP0iYZstcV4MAENIgoTvtm5SwbdrJ5W9RTLpdI=;
 b=Nx/XcW9wBg3XRkGolyKBs7Oz/xvAm5bAet+2qlR8GH6WSKUix9dUFEEWWJoyvLpEFm
 uPqZkNd0VO0IqWQfZGQ/86N66XNsR1xMEzJsy3GKaEnr5onfVKjKadcdaPWiSOr05a5J
 NkrxJP9CSeGehjGCX6Qth0ViETf4ccDGQnHf3shKBTPLBGPQRKWzCNqY8krSiTBIg5O7
 GghRziDH8A8urJJXJcNC19wbOFKCBfDOKdxk7k4lZT1YCfQAvDbYXAyq12YiZSe9mxAA
 Pa7RFTA6jLF9bTjuXRNlIHM7eS/DeWdwFMXmJrY9Uiua5WEKjwLht6MID8sqR8iBR07y
 qDMg==
X-Gm-Message-State: AOJu0YzIS21A83zulMNvVj+MqCvAupOjerigc4QYg3hKZjwlBDdAZhkj
 asBoXWr35MgAxTbzzO8ZDP0LdX1bgTiKLbYz7u/8wQPE+OgsigvD7A2McMt41ChB14b7IZ3Dowg
 VuzV/4Sl7wL7LbulpHE6WyhvkjQWX/t4=
X-Received: by 2002:a2e:9f0c:0:b0:2bc:e32f:6fb0 with SMTP id
 u12-20020a2e9f0c000000b002bce32f6fb0mr8736010ljk.9.1695052589512; 
 Mon, 18 Sep 2023 08:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy7ddmYsMzp68O3jrJJwtqFR6ogVISr/fEd2B7qEkTMGa2C9WJFtIJiSHoAx6JpoyPjhXErHvvSUCrNhrdt84=
X-Received: by 2002:a2e:9f0c:0:b0:2bc:e32f:6fb0 with SMTP id
 u12-20020a2e9f0c000000b002bce32f6fb0mr8735991ljk.9.1695052589174; Mon, 18 Sep
 2023 08:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135448.90963-1-anisinha@redhat.com>
 <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
 <ceea0d9d-19d6-29e7-cb84-81f85936b8c2@redhat.com>
In-Reply-To: <ceea0d9d-19d6-29e7-cb84-81f85936b8c2@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 18 Sep 2023 21:26:17 +0530
Message-ID: <CAK3XEhNETZBGtzpv2vBzygQtYuzTrsihzQNRdK8kp3+_u590Rg@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 18, 2023 at 8:59=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.09.23 17:22, Ani Sinha wrote:
> > On Mon, Sep 18, 2023 at 7:25=E2=80=AFPM Ani Sinha <anisinha@redhat.com>=
 wrote:
> >>
> >> 32-bit systems do not have a reserved memory for hole64 but they may h=
ave a
> >> reserved memory space for memory hotplug. Since, hole64 starts after t=
he
> >> reserved hotplug memory, the unaligned hole64 start address gives us t=
he
> >> end address for this memory hotplug region that the processor may use.
> >> Fix this. This ensures that the physical address space bound checking =
works
> >> correctly for 32-bit systems as well.
> >
> > This patch breaks some unit tests. I am not sure why it did not catch
> > it when I tested it before sending.
> > Will have to resend after fixing the tests.
>
> Probably because they supply more memory than the system can actually
> handle? (e.g., -m 4g on 32bit)?

cxl tests are failing for example.

$ ./qemu-system-i386 -display none -machine q35,cxl=3Don
qemu-system-i386: Address space limit 0xffffffff < 0x1000fffff
phys-bits too low (32)



>
> Agreed with MST that we should glue this to compat machines.
>
> --
> Cheers,
>
> David / dhildenb
>


