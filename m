Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD17982D0B5
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 14:04:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rP09J-0000Rv-16; Sun, 14 Jan 2024 08:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rP09C-0000OZ-5H
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 08:03:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rP095-0006YU-0D
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 08:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705237397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t6k73rthAbd+hxKBTmzR2hkHyay6E7DrikFsQmfkVvY=;
 b=OLvVeNlZn0HBE3ZeaxjL6Vdh85hVsuVu3CXapElI7/5nug3xYussGtrMQ+RfGE0D6ZK0zD
 /dNYzmokACWR+0//c+UzRLrMwIktiSC0YA2499MnkXXx9KVXPz334aElQARwcmJYHhys0L
 j+9m7wfw2C+mtJvCwBAe9qLoSlC48K8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-SseQe5yKM82XGJT7zOhkAA-1; Sun, 14 Jan 2024 08:03:14 -0500
X-MC-Unique: SseQe5yKM82XGJT7zOhkAA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e74771019so3050735e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 05:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705237393; x=1705842193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6k73rthAbd+hxKBTmzR2hkHyay6E7DrikFsQmfkVvY=;
 b=FmShzKLRN8a/r/0MEqh3kC9AZorYq5rtpzMeZ2E4891wCgsoNo8IIncvQszc+tKvNd
 vFTfA2LGnyWfn+wl+1neGlH/w5jfHXAIfzK4Cfi912uG4WITQ3sSI+BB+4AxhtY+pg4a
 tet1ribspHCGeDalqxOGMqsPUK1qKINjNDJ0RfAD2pQ2Ju1V9s1D1kOQ/bfBDzIe01TU
 k/sDK2gZ7YnSdtgomgrNlfZ/6Jz+oYa9RIQoHjJvrReDv/FiAqzCvmmDVv+Sz1wcybMb
 CjCKlkpLzsUK3bjQnVcWrnQr0i1dQ6VJU//MTmk2em6hLcDsFNsrap/xZLV+kY8EFjal
 hUWQ==
X-Gm-Message-State: AOJu0YzLpa8M6Zi78aq2CuySSW2rdvFHgzbxQFdnzzCc6bBRvRqDdxaJ
 Pg9n8SmM+k42LSzzKBMN6xZZIs7RQj9KrFkJWN1PNLW//gi9zTNO1mfldsRKb6aln0pm/SQFvtt
 qgEr55va3qs6wRpTO4sUXYgs=
X-Received: by 2002:a7b:cc8c:0:b0:40e:6299:577d with SMTP id
 p12-20020a7bcc8c000000b0040e6299577dmr1213945wma.86.1705237393318; 
 Sun, 14 Jan 2024 05:03:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoGJ0fNhnuqxeLunLWX6t9ty5WS/DGuifMmAppk0o9TnZOBhjfMSU6Y0H2r1h27jEaBEUbMQ==
X-Received: by 2002:a7b:cc8c:0:b0:40e:6299:577d with SMTP id
 p12-20020a7bcc8c000000b0040e6299577dmr1213926wma.86.1705237392866; 
 Sun, 14 Jan 2024 05:03:12 -0800 (PST)
Received: from redhat.com ([2.52.131.87]) by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b0040d6b91efd9sm16302206wmq.44.2024.01.14.05.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 05:03:12 -0800 (PST)
Date: Sun, 14 Jan 2024 08:03:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 =?iso-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 00/11] hw/isa/vt82c686: Implement relocation and
 toggling of SuperI/O functions
Message-ID: <20240114080249-mutt-send-email-mst@kernel.org>
References: <20240114123911.4877-1-shentey@gmail.com>
 <05B650FF-EA74-471D-B427-A0AC037423DF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05B650FF-EA74-471D-B427-A0AC037423DF@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sun, Jan 14, 2024 at 12:52:53PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 14. Januar 2024 12:39:00 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
> >This series implements relocation of the SuperI/O functions of the VIA south
> >
> >bridges which resolves some FIXME's. It is part of my via-apollo-pro-133t
> >
> >branch [1] which is an extension of bringing the VIA south bridges to the PC
> >
> >machine [2]. This branch is able to run some real-world X86 BIOSes in the hope
> >
> >that it allows us to form a better understanding of the real vt82c686b devices.
> >
> >Implementing relocation and toggling of the SuperI/O functions is one step to
> >
> >make these BIOSes run without error messages, so here we go.
> >
> >
> >
> >The series is structured as follows: Patches 1-3 prepare the TYPE_ISA_FDC,
> >
> >TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL to relocate and toggle (enable/disable)
> >
> >themselves without breaking encapsulation of their respective device states.
> >
> >This is achieved by moving the MemoryRegions and PortioLists from the device
> >
> >states into the encapsulating ISA devices since they will be relocated and
> >
> >toggled.
> >
> >
> >
> >Inspired by the memory API patches 4-6 add two convenience functions to the
> >
> >portio_list API to toggle and relocate portio lists. Patch 5 is a preparation
> >
> >for that which removes some redundancies which otherwise had to be dealt with
> >
> >during relocation.
> >
> >
> >
> >Patches 7-9 implement toggling and relocation for types TYPE_ISA_FDC,
> >
> >TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL. Patch 10 prepares the pegasos2 machine
> >
> >which would end up with all SuperI/O functions disabled if no -bios argument is
> >
> >given. Patch 11 finally implements the main feature which now relies on
> >
> >firmware to configure the SuperI/O functions accordingly (except for pegasos2).
> >
> >
> >
> >v5:
> >
> >* Use cpu_physical_memory_write() in pegasos2 (Zoltan)
> >
> >* Use an int as for loop variable (Zoltan)
> >
> >
> >
> >v4:
> >
> >* Drop incomplete SuperI/O vmstate handling (Zoltan)
> >
> >
> >
> >v3:
> >
> >* Rework various commit messages (Zoltan)
> >
> >* Drop patch "hw/char/serial: Free struct SerialState from MemoryRegion"
> >
> >  (Zoltan)
> >
> >* Generalize wording in migration.rst to include portio_list API (Zoltan)
> >
> >
> >
> >v2:
> >
> >* Improve commit messages (Zoltan)
> >
> >* Split pegasos2 from vt82c686 patch (Zoltan)
> >
> >* Avoid poking into device internals (Zoltan)
> >
> >
> >
> >Testing done:
> >
> >* `make check`
> >
> >* `make check-avocado`
> >
> >* Run MorphOS on pegasos2 with and without pegasos2.rom
> >
> >* Run Linux on amigaone
> >
> >* Run real-world BIOSes on via-apollo-pro-133t branch
> >
> >* Start rescue-yl on fuloong2e
> >
> >
> >
> >[1] https://github.com/shentok/qemu/tree/via-apollo-pro-133t
> >
> >[2] https://github.com/shentok/qemu/tree/pc-via
> >
> >
> >
> >Bernhard Beschow (11):
> >
> >  hw/block/fdc-isa: Move portio_list from FDCtrl to FDCtrlISABus
> >
> >  hw/block/fdc-sysbus: Move iomem from FDCtrl to FDCtrlSysBus
> >
> >  hw/char/parallel: Move portio_list from ParallelState to
> >
> >    ISAParallelState
> >
> 
> 
> >  exec/ioport: Resolve redundant .base attribute in struct
> >
> >    MemoryRegionPortio
> >
> >  exec/ioport: Add portio_list_set_address()
> >
> >  exec/ioport: Add portio_list_set_enabled()
> >
> >  hw/block/fdc-isa: Implement relocation and enabling/disabling for
> >
> >    TYPE_ISA_FDC
> >
> >  hw/char/serial-isa: Implement relocation and enabling/disabling for
> >
> >    TYPE_ISA_SERIAL
> >
> >  hw/char/parallel-isa: Implement relocation and enabling/disabling for
> >
> >    TYPE_ISA_PARALLEL
> >
> 
> Ping for the above six patches. These are critical for this series and haven't had comments from maintainers for five iterations, so pardon for the annoyance.

Was hoping for more reviews. Oh well.
Tagged.


> Best regards,
> Bernhard
> 
> >  hw/ppc/pegasos2: Let pegasos2 machine configure SuperI/O functions
> >
> >  hw/isa/vt82c686: Implement relocation and toggling of SuperI/O
> >
> >    functions
> >
> >
> >
> > docs/devel/migration.rst       |  6 ++--
> >
> > hw/block/fdc-internal.h        |  4 ---
> >
> > include/exec/ioport.h          |  4 ++-
> >
> > include/hw/block/fdc.h         |  3 ++
> >
> > include/hw/char/parallel-isa.h |  5 +++
> >
> > include/hw/char/parallel.h     |  2 --
> >
> > include/hw/char/serial.h       |  2 ++
> >
> > hw/block/fdc-isa.c             | 18 +++++++++-
> >
> > hw/block/fdc-sysbus.c          |  6 ++--
> >
> > hw/char/parallel-isa.c         | 14 ++++++++
> >
> > hw/char/parallel.c             |  2 +-
> >
> > hw/char/serial-isa.c           | 14 ++++++++
> >
> > hw/isa/vt82c686.c              | 65 ++++++++++++++++++++++++++++------
> >
> > hw/ppc/pegasos2.c              | 12 +++++++
> >
> > system/ioport.c                | 41 +++++++++++++++++----
> >
> > 15 files changed, 168 insertions(+), 30 deletions(-)
> >
> >
> >
> >-- >
> >2.43.0
> >
> >
> >


