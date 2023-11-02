Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AE97DF3F0
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:36:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXrq-0006uG-9k; Thu, 02 Nov 2023 09:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qyXrl-0006mD-Lc
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qyXri-0007mP-Bv
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698932162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1YLGun92tB7ms+f77cDRxSljEyb6bcvbQmNWzz8D5w=;
 b=N8xUePDhdNTquq7bdy+M9KO/oB8sciLcpUlE3GKKRyIC69SeeAdlhFvRJB2E93sd8O0lN/
 iANUiBvVHOfQTGDCPaJGtEP5Wtv/k9jvmseipXCU/Enj3vJ8gZgjfjnVsddfVf+iUm00kr
 2Y/UIFqhv0aCCoRtlxTqoQzytLyws/c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-YUNJgQvJN6uXXDczMNNAbA-1; Thu, 02 Nov 2023 09:35:58 -0400
X-MC-Unique: YUNJgQvJN6uXXDczMNNAbA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-53e02a0ebfdso726653a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 06:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698932157; x=1699536957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1YLGun92tB7ms+f77cDRxSljEyb6bcvbQmNWzz8D5w=;
 b=XiQ84V40CoyfmL9dRACpmNisHmYrtsysnomQHbN3V0pC5H8NCsCI/ylzfqormUSs/S
 H7Hy0Gj205NhRBrLuVgOSEBPpeLfUKdUWlR8IJYu8v9hQdBTyJb8RU4k7iuB0wNpQvhQ
 RV59w3KxUN47IRIgCzlpW2hAVQfqS99HUFfxeNyrZax+IN8wSd6uVrhKaChHFJPKeiP6
 AV7q744271536XoG2Cuki2Mleq29L17aQMijpWYwlKQmL/1Npo9jMWrut7GPCGJssXLu
 ZrOAvhCBc/hbYk8DCbprMO1xxf64v5R2RivGMm32ikKM+N0QZ7++QwUQh2pnE+1ef7qN
 skFg==
X-Gm-Message-State: AOJu0Yy/D3YEJ+8IibMFFG7jqmGAxiNjZB6W4jpI5D8yDUoe/S0UCyqQ
 zPBo9ZJTvRxc0EUWgM48O9nadmvhfGGc1SXmtVMhXaJsaBIwLsmosda2m9jVUScaRu0s4ZmIGU8
 SOOKWalXaQ1UAyD5GTMJWsfSW+8sxgS0=
X-Received: by 2002:a50:9fc9:0:b0:542:d56c:ed67 with SMTP id
 c67-20020a509fc9000000b00542d56ced67mr13011373edf.4.1698932156812; 
 Thu, 02 Nov 2023 06:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH08fR3/JeRnMPIH8y+zZwPWOM7H6owKWv7at1m2chY4mtBDG/5w8KGZvGm1Q/G/2WRgcZcy/zVRVdjebj1m8=
X-Received: by 2002:a50:9fc9:0:b0:542:d56c:ed67 with SMTP id
 c67-20020a509fc9000000b00542d56ced67mr13011357edf.4.1698932156529; Thu, 02
 Nov 2023 06:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230927151205.70930-1-peter.maydell@linaro.org>
 <20230927151205.70930-8-peter.maydell@linaro.org>
 <66663c7e-3ab8-ae62-cd55-52c89bcd7733@linaro.org>
In-Reply-To: <66663c7e-3ab8-ae62-cd55-52c89bcd7733@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 2 Nov 2023 17:35:44 +0400
Message-ID: <CAMxuvay+8eyRbYGtUdSBW2Yk8qUTse0DEhWNGoPurTygv1uHjA@mail.gmail.com>
Subject: Re: [PATCH 7/8] docs/specs/vmcoreinfo: Convert to rST
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 31, 2023 at 7:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 27/9/23 17:12, Peter Maydell wrote:
> > Convert docs/specs/vmcoreinfo.txt to rST format.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> > ---
> >   MAINTAINERS                                   |  1 +
> >   docs/specs/index.rst                          |  1 +
> >   docs/specs/{vmcoreinfo.txt =3D> vmcoreinfo.rst} | 33 ++++++++++------=
---
> >   3 files changed, 19 insertions(+), 16 deletions(-)
> >   rename docs/specs/{vmcoreinfo.txt =3D> vmcoreinfo.rst} (50%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9e27cad11c3..23ee617acaf 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2805,6 +2805,7 @@ F: include/sysemu/dump.h
> >   F: qapi/dump.json
> >   F: scripts/dump-guest-memory.py
> >   F: stubs/dump.c
> > +F: docs/specs/vmcoreinfo.rst
>
> Good :)
>
> Cc'ing Marc-Andr=C3=A9.
>
> >   Error reporting
> >   M: Markus Armbruster <armbru@redhat.com>
> > diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> > index 8d30968650b..7a56ccb2155 100644
> > --- a/docs/specs/index.rst
> > +++ b/docs/specs/index.rst
> > @@ -30,3 +30,4 @@ guest hardware that is specific to QEMU.
> >      pvpanic
> >      standard-vga
> >      virt-ctlr
> > +   vmcoreinfo
> > diff --git a/docs/specs/vmcoreinfo.txt b/docs/specs/vmcoreinfo.rst
> > similarity index 50%
> > rename from docs/specs/vmcoreinfo.txt
> > rename to docs/specs/vmcoreinfo.rst
> > index bcbca6fe47c..462b04474d3 100644
> > --- a/docs/specs/vmcoreinfo.txt
> > +++ b/docs/specs/vmcoreinfo.rst
> > @@ -2,19 +2,19 @@
> >   VMCoreInfo device
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -The `-device vmcoreinfo` will create a fw_cfg entry for a guest to
> > +The ``-device vmcoreinfo`` will create a ``fw_cfg`` entry for a guest =
to
> >   store dump details.
> >
> > -etc/vmcoreinfo
> > -**************
> > +``etc/vmcoreinfo``
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -A guest may use this fw_cfg entry to add information details to qemu
> > +A guest may use this ``fw_cfg`` entry to add information details to qe=
mu
> >   dumps.
> >
> >   The entry of 16 bytes has the following layout, in little-endian::
> >
> > -#define VMCOREINFO_FORMAT_NONE 0x0
> > -#define VMCOREINFO_FORMAT_ELF 0x1
> > +    #define VMCOREINFO_FORMAT_NONE 0x0
> > +    #define VMCOREINFO_FORMAT_ELF 0x1
> >
> >       struct FWCfgVMCoreInfo {
> >           uint16_t host_format;  /* formats host supports */
> > @@ -26,17 +26,17 @@ The entry of 16 bytes has the following layout, in =
little-endian::
> >   Only full write (of 16 bytes) are considered valid for further
> >   processing of entry values.
> >
> > -A write of 0 in guest_format will disable further processing of
> > +A write of 0 in ``guest_format`` will disable further processing of
> >   vmcoreinfo entry values & content.
> >
> > -You may write a guest_format that is not supported by the host, in
> > +You may write a ``guest_format`` that is not supported by the host, in
> >   which case the entry data can be ignored by qemu (but you may still
> > -access it through a debugger, via vmcoreinfo_realize::vmcoreinfo_state=
).
> > +access it through a debugger, via ``vmcoreinfo_realize::vmcoreinfo_sta=
te``).
> >
> >   Format & content
> > -****************
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -As of qemu 2.11, only VMCOREINFO_FORMAT_ELF is supported.
> > +As of qemu 2.11, only ``VMCOREINFO_FORMAT_ELF`` is supported.
>
> Maybe s/qemu/QEMU/, otherwise:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> >   The entry gives location and size of an ELF note that is appended in
> >   qemu dumps.
> > @@ -44,10 +44,11 @@ qemu dumps.
> >   The note format/class must be of the target bitness and the size must
> >   be less than 1Mb.
> >
> > -If the ELF note name is "VMCOREINFO", it is expected to be the Linux
> > -vmcoreinfo note (see Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
> > -in Linux source). In this case, qemu dump code will read the content
> > -as a key=3Dvalue text file, looking for "NUMBER(phys_base)" key
> > +If the ELF note name is ``VMCOREINFO``, it is expected to be the Linux
> > +vmcoreinfo note (see `the kernel documentation for its format
> > +<https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-vmc=
oreinfo>`_).
> > +In this case, qemu dump code will read the content
> > +as a key=3Dvalue text file, looking for ``NUMBER(phys_base)`` key
> >   value. The value is expected to be more accurate than architecture
> >   guess of the value. This is useful for KASLR-enabled guest with
> > -ancient tools not handling the VMCOREINFO note.
> > +ancient tools not handling the ``VMCOREINFO`` note.
>


