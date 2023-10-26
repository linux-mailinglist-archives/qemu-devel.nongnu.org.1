Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E67E7D85F7
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2F9-00013G-3f; Thu, 26 Oct 2023 11:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qw2F0-0000t3-Jw
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qw2Eu-00017t-2r
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698333938;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2v8VmiQDb0tNhvoln2ZSkC7xRgArE3yuCMaLDIy+CAU=;
 b=D4FwF3sEsEPXhwqNUL2EqKrp0EjJSELspMMDF8mibMv/CAXtcOOl39RQofQQduys50jotW
 xE2qjdq7ZqGcTJmE1wbyTS4qU7UQLZRLg9wyS5vmY8QTdLmSRkylW/y+4gHOaOIDx5nZ0w
 vwNnOfJZhO6QCTVAAcBlL0RCy5IYUsc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-BbT7vPSmOlq32XieyPGLMA-1; Thu, 26 Oct 2023 11:25:36 -0400
X-MC-Unique: BbT7vPSmOlq32XieyPGLMA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-407da05ee50so8086105e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698333935; x=1698938735;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2v8VmiQDb0tNhvoln2ZSkC7xRgArE3yuCMaLDIy+CAU=;
 b=ZTCA3q4SrMyxD4QYhs+XcivOosDAiRrqRE7ZZKEESESflyD658ACk3XkgMDlYmuFgj
 PYAUFRLPzHemCWitreWYoUcIGynwPJmz4a3F5+XiY9wLIMMv3kRf0QRb/SH1rbR0VYr5
 nqQbHhFiLCjXMxnHOAKZdNkpkN+osEiOTNsJ9OTEtc5LuMxvReZcfK5e/liGpJ8Z3our
 b1w0DrQ46znJMMK8hFFIoQbO1KYE3nxsVemNdpi8Mv4+50S5cfNL2DvEYohmEyrDqEzD
 +7N7kT7aCi8aqaX03El2u2Hbwtz8ywH5ORiGHfhVOc7g+2ZsjWjj9eDhNgY32Xe60uCl
 GNHA==
X-Gm-Message-State: AOJu0Yx4es8PhqvxXcwY6qpWHBbFLZZwrMN+55K1Yp2K+eXRvuvzu/Fe
 cz/CEtig6TE3jY77PIJdmYpvHpn3zvWghXbwUwhKeqW+Rvpz4ZXLSJzBmPZUgkTP0fMEidqEJ7f
 RRZbn03aCvzdp3oE=
X-Received: by 2002:a05:600c:1ca9:b0:403:9b7:a720 with SMTP id
 k41-20020a05600c1ca900b0040309b7a720mr115205wms.1.1698333934992; 
 Thu, 26 Oct 2023 08:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG83cX3E9R/z5oZLjo6bKD9SbsvFISHsRNfBZOgOkNcuaD2/bRNUdhKRDuBB0+PpK64HONbPg==
X-Received: by 2002:a05:600c:1ca9:b0:403:9b7:a720 with SMTP id
 k41-20020a05600c1ca900b0040309b7a720mr115165wms.1.1698333934391; 
 Thu, 26 Oct 2023 08:25:34 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e16-20020adfe7d0000000b0032db8f7f378sm14518834wrn.71.2023.10.26.08.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:25:33 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Corey Minyard
 <minyard@acm.org>,  Li Zhijian <lizhijian@fujitsu.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Hanna Reitz <hreitz@redhat.com>,  John Snow
 <jsnow@redhat.com>,  David Gibson <david@gibson.dropbear.id.au>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Corey Minyard <cminyard@mvista.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Kevin Wolf
 <kwolf@redhat.com>,  qemu-s390x@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater
 <clg@kaod.org>,  qemu-arm@nongnu.org,  libvir-list@redhat.com,  Stefan
 Weil <sw@weilnetz.de>,  Nicholas Piggin <npiggin@gmail.com>,  Daniel
 Henrique Barboza <danielhb413@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,  Samuel Thibault
 <samuel.thibault@ens-lyon.org>,  Eric Farman <farman@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  qemu-ppc@nongnu.org,  "Michael S. Tsirkin"
 <mst@redhat.com>,  qemu-block@nongnu.org
Subject: Re: [PULL 00/39] Migration 20231024 patches
In-Reply-To: <CAJSP0QVZPM5BkHYBTqXmDBuBvUuAAhjdgX_3Ka0WbqTzBxutvg@mail.gmail.com>
 (Stefan Hajnoczi's message of "Thu, 26 Oct 2023 09:50:53 +0900")
References: <20231024131305.87468-1-quintela@redhat.com>
 <CAJSP0QVZPM5BkHYBTqXmDBuBvUuAAhjdgX_3Ka0WbqTzBxutvg@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 26 Oct 2023 17:25:33 +0200
Message-ID: <87il6te782.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, 24 Oct 2023 at 23:45, Juan Quintela <quintela@redhat.com> wrote:
>>
>> The following changes since commit a95260486aa7e78d7c7194eba65cf03311ad9=
4ad:
>>
>>   Merge tag 'pull-tcg-20231023' of https://gitlab.com/rth7680/qemu into =
staging (2023-10-23 14:45:46 -0700)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/juan.quintela/qemu.git tags/migration-20231024-pull=
-request
>>
>> for you to fetch changes up to 088f7f03da3f5b3487091302b795c22b1bfe56fb:
>>
>>   migration: Deprecate old compression method (2023-10-24 13:48:24 +0200)
>>
>> ----------------------------------------------------------------
>> Migration Pull request (20231024)
>>
>> Hi
>>
>> In this PULL:
>> - vmstate registration fixes (thomas, juan)
>> - start merging vmstate_section_needed changes (marc)
>> - migration depreactions (juan)
>> - migration documentation for backwards compatibility (juan)
>>
>> Please apply.
>
> Hi Juan,
> I'm seeing CI failures:
> https://gitlab.com/qemu-project/qemu/-/pipelines/1048630760

start with s390x:

Errors:

 32/840 qemu:qtest+qtest-s390x / qtest-s390x/qom-test                      =
       ERROR          50.27s   killed by signal 6 SIGABRT
104/840 qemu:qtest+qtest-s390x / qtest-s390x/test-hmp                      =
       ERROR          51.55s   killed by signal 6 SIGABRT
189/840 qemu:qtest+qtest-s390x / qtest-s390x/boot-serial-test              =
       ERROR          54.07s   killed by signal 6 SIGABRT
192/840 qemu:qtest+qtest-s390x / qtest-s390x/qos-test                      =
       ERROR          51.29s   killed by signal 6 SIGABRT
519/840 qemu:qtest+qtest-s390x / qtest-s390x/test-filter-mirror            =
       ERROR          50.36s   killed by signal 6 SIGABRT
520/840 qemu:qtest+qtest-s390x / qtest-s390x/test-netfilter                =
       ERROR          51.03s   killed by signal 6 SIGABRT
522/840 qemu:qtest+qtest-s390x / qtest-s390x/device-plug-test              =
       ERROR          50.99s   killed by signal 6 SIGABRT
523/840 qemu:qtest+qtest-s390x / qtest-s390x/test-filter-redirector        =
       ERROR          54.14s   killed by signal 6 SIGABRT
524/840 qemu:qtest+qtest-s390x / qtest-s390x/drive_del-test                =
       ERROR          53.40s   killed by signal 6 SIGABRT
525/840 qemu:qtest+qtest-s390x / qtest-s390x/virtio-ccw-test               =
       ERROR          54.67s   killed by signal 6 SIGABRT
526/840 qemu:qtest+qtest-s390x / qtest-s390x/device-introspect-test        =
       ERROR          51.15s   killed by signal 6 SIGABRT
527/840 qemu:qtest+qtest-s390x / qtest-s390x/cpu-plug-test                 =
       ERROR          51.21s   killed by signal 6 SIGABRT
535/840 qemu:qtest+qtest-s390x / qtest-s390x/qmp-test                      =
       ERROR          51.18s   killed by signal 6 SIGABRT
534/840 qemu:qtest+qtest-s390x / qtest-s390x/machine-none-test             =
       ERROR          51.21s   killed by signal 6 SIGABRT
533/840 qemu:qtest+qtest-s390x / qtest-s390x/qmp-cmd-test                  =
       ERROR          51.22s   killed by signal 6 SIGABRT
549/840 qemu:qtest+qtest-s390x / qtest-s390x/readconfig-test               =
       ERROR          51.20s   killed by signal 6 SIGABRT
644/840 qemu:block / io-qcow2-001                                          =
       ERROR           0.32s   exit status 1
645/840 qemu:block / io-qcow2-002                                          =
       ERROR           0.32s   exit status 1
646/840 qemu:block / io-qcow2-003                                          =
       ERROR           0.34s   exit status 1
647/840 qemu:block / io-qcow2-004                                          =
       ERROR           0.31s   exit status 1
648/840 qemu:block / io-qcow2-005                                          =
       ERROR           0.43s   exit status 1
649/840 qemu:block / io-qcow2-007                                          =
       ERROR           0.34s   exit status 1
650/840 qemu:block / io-qcow2-008                                          =
       ERROR           0.63s   exit status 1
651/840 qemu:block / io-qcow2-009                                          =
       ERROR           0.32s   exit status 1
652/840 qemu:block / io-qcow2-010                                          =
       ERROR           0.30s   exit status 1
654/840 qemu:block / io-qcow2-011                                          =
       ERROR           0.31s   exit status 1
655/840 qemu:block / io-qcow2-012                                          =
       ERROR           0.36s   exit status 1
657/840 qemu:block / io-qcow2-013                                          =
       ERROR           0.51s   exit status 1
658/840 qemu:block / io-qcow2-017                                          =
       ERROR           0.37s   exit status 1
659/840 qemu:block / io-qcow2-018                                          =
       ERROR           0.31s   exit status 1
660/840 qemu:block / io-qcow2-019                                          =
       ERROR           0.36s   exit status 1
661/840 qemu:block / io-qcow2-020                                          =
       ERROR           0.34s   exit status 1
662/840 qemu:block / io-qcow2-021                                          =
       ERROR           0.31s   exit status 1
663/840 qemu:block / io-qcow2-022                                          =
       ERROR           0.30s   exit status 1
664/840 qemu:block / io-qcow2-024                                          =
       ERROR           0.30s   exit status 1
665/840 qemu:block / io-qcow2-025                                          =
       ERROR           0.32s   exit status 1
666/840 qemu:block / io-qcow2-027                                          =
       ERROR           0.32s   exit status 1
667/840 qemu:block / io-qcow2-029                                          =
       ERROR           0.34s   exit status 1
668/840 qemu:block / io-qcow2-031                                          =
       ERROR           0.31s   exit status 1
669/840 qemu:block / io-qcow2-032                                          =
       ERROR           0.31s   exit status 1
670/840 qemu:block / io-qcow2-033                                          =
       ERROR           0.31s   exit status 1
671/840 qemu:block / io-qcow2-034                                          =
       ERROR           0.55s   exit status 1
672/840 qemu:block / io-qcow2-035                                          =
       ERROR           0.59s   exit status 1
673/840 qemu:block / io-qcow2-037                                          =
       ERROR           0.32s   exit status 1
674/840 qemu:block / io-qcow2-036                                          =
       ERROR           0.33s   exit status 1
675/840 qemu:block / io-qcow2-038                                          =
       ERROR           0.31s   exit status 1
676/840 qemu:block / io-qcow2-040                                          =
       ERROR           0.30s   exit status 1
677/840 qemu:block / io-qcow2-039                                          =
       ERROR           0.32s   exit status 1
679/840 qemu:block / io-qcow2-041                                          =
       ERROR           0.32s   exit status 1
680/840 qemu:block / io-qcow2-042                                          =
       ERROR           0.31s   exit status 1
681/840 qemu:block / io-qcow2-043                                          =
       ERROR           0.32s   exit status 1
682/840 qemu:block / io-qcow2-046                                          =
       ERROR           0.32s   exit status 1
683/840 qemu:block / io-qcow2-047                                          =
       ERROR           0.32s   exit status 1
684/840 qemu:block / io-qcow2-048                                          =
       ERROR           0.31s   exit status 1
685/840 qemu:block / io-qcow2-049                                          =
       ERROR           0.32s   exit status 1
686/840 qemu:block / io-qcow2-050                                          =
       ERROR           0.32s   exit status 1
687/840 qemu:block / io-qcow2-052                                          =
       ERROR           0.30s   exit status 1
688/840 qemu:block / io-qcow2-053                                          =
       ERROR           0.32s   exit status 1
689/840 qemu:block / io-qcow2-054                                          =
       ERROR           0.32s   exit status 1
690/840 qemu:block / io-qcow2-060                                          =
       ERROR           0.30s   exit status 1
691/840 qemu:block / io-qcow2-061                                          =
       ERROR           0.33s   exit status 1
692/840 qemu:block / io-qcow2-062                                          =
       ERROR           0.34s   exit status 1
693/840 qemu:block / io-qcow2-063                                          =
       ERROR           0.31s   exit status 1
694/840 qemu:block / io-qcow2-066                                          =
       ERROR           0.35s   exit status 1
695/840 qemu:block / io-qcow2-069                                          =
       ERROR           0.33s   exit status 1
696/840 qemu:block / io-qcow2-072                                          =
       ERROR           0.30s   exit status 1
697/840 qemu:block / io-qcow2-071                                          =
       ERROR           0.34s   exit status 1
698/840 qemu:block / io-qcow2-073                                          =
       ERROR           0.37s   exit status 1
699/840 qemu:block / io-qcow2-074                                          =
       ERROR           0.33s   exit status 1
700/840 qemu:block / io-qcow2-079                                          =
       ERROR           0.32s   exit status 1
701/840 qemu:block / io-qcow2-080                                          =
       ERROR           0.36s   exit status 1
702/840 qemu:block / io-qcow2-086                                          =
       ERROR           0.33s   exit status 1
703/840 qemu:block / io-qcow2-089                                          =
       ERROR           0.35s   exit status 1
704/840 qemu:block / io-qcow2-090                                          =
       ERROR           0.35s   exit status 1
705/840 qemu:block / io-qcow2-097                                          =
       ERROR           0.32s   exit status 1
706/840 qemu:block / io-qcow2-098                                          =
       ERROR           0.30s   exit status 1
707/840 qemu:block / io-qcow2-099                                          =
       ERROR           0.32s   exit status 1
708/840 qemu:block / io-qcow2-104                                          =
       ERROR           0.32s   exit status 1
709/840 qemu:block / io-qcow2-103                                          =
       ERROR           0.34s   exit status 1
710/840 qemu:block / io-qcow2-105                                          =
       ERROR           0.33s   exit status 1
711/840 qemu:block / io-qcow2-107                                          =
       ERROR           0.34s   exit status 1
712/840 qemu:block / io-qcow2-108                                          =
       ERROR           0.31s   exit status 1
713/840 qemu:block / io-qcow2-110                                          =
       ERROR           0.32s   exit status 1
714/840 qemu:block / io-qcow2-111                                          =
       ERROR           0.32s   exit status 1
715/840 qemu:block / io-qcow2-114                                          =
       ERROR           0.31s   exit status 1
716/840 qemu:block / io-qcow2-120                                          =
       ERROR           0.30s   exit status 1
717/840 qemu:block / io-qcow2-117                                          =
       ERROR           0.34s   exit status 1
719/840 qemu:block / io-qcow2-126                                          =
       ERROR           0.30s   exit status 1
720/840 qemu:block / io-qcow2-127                                          =
       ERROR           0.35s   exit status 1
718/840 qemu:qtest+qtest-s390x / qtest-s390x/netdev-socket                 =
       ERROR          51.24s   killed by signal 6 SIGABRT
721/840 qemu:block / io-qcow2-133                                          =
       ERROR           0.34s   exit status 1
722/840 qemu:block / io-qcow2-134                                          =
       ERROR           0.34s   exit status 1
723/840 qemu:block / io-qcow2-137                                          =
       ERROR           0.32s   exit status 1
724/840 qemu:block / io-qcow2-138                                          =
       ERROR           0.32s   exit status 1
725/840 qemu:block / io-qcow2-140                                          =
       ERROR           0.37s   exit status 1
726/840 qemu:block / io-qcow2-141                                          =
       ERROR           0.33s   exit status 1
727/840 qemu:block / io-qcow2-143                                          =
       ERROR           0.34s   exit status 1
728/840 qemu:block / io-qcow2-150                                          =
       ERROR           0.33s   exit status 1
729/840 qemu:block / io-qcow2-154                                          =
       ERROR           0.33s   exit status 1
730/840 qemu:block / io-qcow2-156                                          =
       ERROR           0.38s   exit status 1
732/840 qemu:block / io-qcow2-158                                          =
       ERROR           0.35s   exit status 1
733/840 qemu:block / io-qcow2-159                                          =
       ERROR           0.33s   exit status 1
734/840 qemu:block / io-qcow2-161                                          =
       ERROR           0.40s   exit status 1
735/840 qemu:block / io-qcow2-170                                          =
       ERROR           0.57s   exit status 1
736/840 qemu:block / io-qcow2-174                                          =
       ERROR           0.46s   exit status 1
737/840 qemu:block / io-qcow2-176                                          =
       ERROR           0.47s   exit status 1
738/840 qemu:block / io-qcow2-177                                          =
       ERROR           0.63s   exit status 1
739/840 qemu:block / io-qcow2-172                                          =
       ERROR           0.69s   exit status 1
740/840 qemu:block / io-qcow2-181                                          =
       ERROR           0.36s   exit status 1
741/840 qemu:block / io-qcow2-179                                          =
       ERROR           0.50s   exit status 1
742/840 qemu:block / io-qcow2-184                                          =
       ERROR           0.54s   exit status 1
743/840 qemu:block / io-qcow2-186                                          =
       ERROR           0.38s   exit status 1
744/840 qemu:block / io-qcow2-187                                          =
       ERROR           0.40s   exit status 1
745/840 qemu:block / io-qcow2-190                                          =
       ERROR           0.43s   exit status 1
746/840 qemu:block / io-qcow2-191                                          =
       ERROR           0.37s   exit status 1
747/840 qemu:block / io-qcow2-192                                          =
       ERROR           0.35s   exit status 1
748/840 qemu:block / io-qcow2-195                                          =
       ERROR           0.35s   exit status 1
749/840 qemu:block / io-qcow2-214                                          =
       ERROR           0.32s   exit status 1
750/840 qemu:block / io-qcow2-203                                          =
       ERROR           0.39s   exit status 1
751/840 qemu:block / io-qcow2-217                                          =
       ERROR           0.38s   exit status 1
752/840 qemu:block / io-qcow2-220                                          =
       ERROR           0.38s   exit status 1
753/840 qemu:block / io-qcow2-226                                          =
       ERROR           0.41s   exit status 1
754/840 qemu:block / io-qcow2-229                                          =
       ERROR           0.37s   exit status 1
755/840 qemu:block / io-qcow2-244                                          =
       ERROR           0.34s   exit status 1
756/840 qemu:block / io-qcow2-249                                          =
       ERROR           0.34s   exit status 1
757/840 qemu:block / io-qcow2-251                                          =
       ERROR           0.35s   exit status 1
758/840 qemu:block / io-qcow2-252                                          =
       ERROR           0.35s   exit status 1
759/840 qemu:block / io-qcow2-256                                          =
       ERROR           0.44s   exit status 1
760/840 qemu:block / io-qcow2-265                                          =
       ERROR           0.33s   exit status 1
761/840 qemu:block / io-qcow2-268                                          =
       ERROR           0.35s   exit status 1
762/840 qemu:block / io-qcow2-267                                          =
       ERROR           0.42s   exit status 1
763/840 qemu:block / io-qcow2-271                                          =
       ERROR           0.34s   exit status 1
764/840 qemu:block / io-qcow2-283                                          =
       ERROR           0.33s   exit status 1
765/840 qemu:block / io-qcow2-287                                          =
       ERROR           0.37s   exit status 1
766/840 qemu:block / io-qcow2-290                                          =
       ERROR           0.35s   exit status 1
767/840 qemu:block / io-qcow2-292                                          =
       ERROR           0.34s   exit status 1
768/840 qemu:block / io-qcow2-313                                          =
       ERROR           0.35s   exit status 1
769/840 qemu:block / io-qcow2-copy-before-write                            =
       ERROR           0.37s   exit status 1
770/840 qemu:block / io-qcow2-299                                          =
       ERROR           0.46s   exit status 1
771/840 qemu:block / io-qcow2-iothreads-commit-active                      =
       ERROR           0.34s   exit status 1
772/840 qemu:block / io-qcow2-detect-zeroes-registered-buf                 =
       ERROR           0.41s   exit status 1
773/840 qemu:block / io-qcow2-iothreads-resize                             =
       ERROR           0.38s   exit status 1
774/840 qemu:block / io-qcow2-nbd-multiconn                                =
       ERROR           0.34s   exit status 1
778/840 qemu:block / io-qcow2-nbd-qemu-allocation                          =
       ERROR           0.34s   exit status 1
782/840 qemu:block / io-qcow2-qemu-img-close-errors                        =
       ERROR           0.37s   exit status 1
787/840 qemu:block / io-qcow2-qsd-jobs                                     =
       ERROR           0.30s   exit status 1
797/840 qemu:block / io-qcow2-regression-vhdx-log                          =
       ERROR           0.35s   exit status 1

It looks like I have really broke s390 (there are changes on my patches
for s390) and qcow2 iotests (I know I am very good, but breaking every
qcow2 iotest without touching qcow2 at all look strange).

Now looking into aarch64:

501/841 qemu:qtest+qtest-s390x / qtest-s390x/qom-test                      =
       ERROR          50.36s   killed by signal 6 SIGABRT
523/841 qemu:qtest+qtest-s390x / qtest-s390x/test-hmp                      =
       ERROR          50.07s   killed by signal 6 SIGABRT
562/841 qemu:qtest+qtest-s390x / qtest-s390x/boot-serial-test              =
       ERROR          51.24s   killed by signal 6 SIGABRT
563/841 qemu:qtest+qtest-s390x / qtest-s390x/qos-test                      =
       ERROR          51.22s   killed by signal 6 SIGABRT
823/841 qemu:qtest+qtest-s390x / qtest-s390x/device-plug-test              =
       ERROR          50.26s   killed by signal 6 SIGABRT
822/841 qemu:qtest+qtest-s390x / qtest-s390x/cpu-plug-test                 =
       ERROR          50.22s   killed by signal 6 SIGABRT
824/841 qemu:qtest+qtest-s390x / qtest-s390x/machine-none-test             =
       ERROR          50.03s   killed by signal 6 SIGABRT
821/841 qemu:qtest+qtest-s390x / qtest-s390x/test-netfilter                =
       ERROR          50.50s   killed by signal 6 SIGABRT
825/841 qemu:qtest+qtest-s390x / qtest-s390x/device-introspect-test        =
       ERROR          50.10s   killed by signal 6 SIGABRT
827/841 qemu:qtest+qtest-s390x / qtest-s390x/test-filter-redirector        =
       ERROR          50.39s   killed by signal 6 SIGABRT
828/841 qemu:qtest+qtest-s390x / qtest-s390x/drive_del-test                =
       ERROR          50.36s   killed by signal 6 SIGABRT
829/841 qemu:qtest+qtest-s390x / qtest-s390x/virtio-ccw-test               =
       ERROR          50.25s   killed by signal 6 SIGABRT
826/841 qemu:qtest+qtest-s390x / qtest-s390x/test-filter-mirror            =
       ERROR          50.42s   killed by signal 6 SIGABRT
830/841 qemu:qtest+qtest-s390x / qtest-s390x/qmp-cmd-test                  =
       ERROR          51.61s   killed by signal 6 SIGABRT
831/841 qemu:qtest+qtest-s390x / qtest-s390x/readconfig-test               =
       ERROR          50.96s   killed by signal 6 SIGABRT
832/841 qemu:qtest+qtest-s390x / qtest-s390x/qmp-test                      =
       ERROR          51.64s   killed by signal 6 SIGABRT
833/841 qemu:qtest+qtest-s390x / qtest-s390x/netdev-socket                 =
       ERROR          50.64s   killed by signal 6 SIGABRT

x64 freebsd:  Useless report

$ cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml 01:18=
:03
build 5298808968445952: TRIGGERED
build 5298808968445952: EXECUTING
build 5298808968445952: EXECUTING
build 5298808968445952: EXECUTING
build 5298808968445952: EXECUTING
build 5298808968445952: EXECUTING
build 5298808968445952: EXECUTING
build 5298808968445952: EXECUTING
build 5298808968445952: EXECUTING
build 5298808968445952: EXECUTING
....

I will let this for last.

So far:

I run full qemu-iotets on x68_64, not the subset of make check:
- passed all for raw
- failed for qcow2 (130)

Not being able to see what was going on, I tested on master, and I got
the same failure:

$ ./check 130 -qcow2
QEMU          -- "/scratch/qemu/gcc/full/all/qemu-system-x86_64" -nodefault=
s -display none -accel qtest
QEMU_IMG      -- "/scratch/qemu/gcc/full/all/qemu-img"=20
QEMU_IO       -- "/scratch/qemu/gcc/full/all/qemu-io" --cache writeback --a=
io threads -f qcow2
QEMU_NBD      -- "/scratch/qemu/gcc/full/all/qemu-nbd"=20
IMGFMT        -- qcow2
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 fada.mitica 6.5.6-200.fc38.x86_64
TEST_DIR      -- /scratch/qemu/gcc/full/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp_p9ha0gt
GDB_OPTIONS   --=20
VALGRIND_QEMU --=20
PRINT_QEMU_OUTPUT --=20

130   fail       [14:43:56] [14:43:57]   0.5s   (last: 0.4s)  output mismat=
ch (see /scratch/qemu/gcc/full/all/tests/qemu-iotests/scratch/qcow2-file-13=
0/130.out.bad)
--- /mnt/code/qemu/full/tests/qemu-iotests/130.out
+++ /scratch/qemu/gcc/full/all/tests/qemu-iotests/scratch/qcow2-file-130/13=
0.out.bad
@@ -11,18 +11,14 @@
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) commit testdisk
 (qemu)
-image: TEST_DIR/t.IMGFMT
-file format: IMGFMT
-virtual size: 64 MiB (67108864 bytes)
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared "write"=
 lock
+Is another process using the image [TEST_DIR/t.IMGFMT]?
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.orig backing_fmt=3Draw
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) commit testdisk
 (qemu)
-image: TEST_DIR/t.IMGFMT
-file format: IMGFMT
-virtual size: 64 MiB (67108864 bytes)
-backing file: TEST_DIR/t.IMGFMT.orig
-backing file format: raw
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared "write"=
 lock
+Is another process using the image [TEST_DIR/t.IMGFMT]?

So I guess there is some locking issues there, not related to my changes
at all.  Here it don't fails every time, but it fails something like 9
out of 10 times (in master, the same on my PULL request).

On x86_64, the s390x emulated tests work perfectly.  So so far I got:
- they fail native on s390
- they fail emulated on aarch64
- they pass emulated on x86_64

Here I am, hunting for an s390x machine.

After being burned on x86_64, I start with master, not with my PULL
request:

(main *)$ ./check 108 -qcow2
QEMU          -- "/home/quintela/scratch/qemu/gcc/qemu/all/qemu-system-s390=
x" -nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/quintela/scratch/qemu/gcc/qemu/all/qemu-img"=20
QEMU_IO       -- "/home/quintela/scratch/qemu/gcc/qemu/all/qemu-io" --cache=
 writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/quintela/scratch/qemu/gcc/qemu/all/qemu-nbd"=20
IMGFMT        -- qcow2
IMGPROTO      -- file
PLATFORM      -- Linux/s390x s390x-kvm-007.lab.eng.rdu2.redhat.com 5.14.0-2=
84.38.1.el9_2.s390x
TEST_DIR      -- /home/quintela/scratch/qemu/gcc/qemu/all/tests/qemu-iotest=
s/scratch
SOCK_DIR      -- /tmp/tmpls01m7ji
GDB_OPTIONS   --=20
VALGRIND_QEMU --=20
PRINT_QEMU_OUTPUT --=20

108   fail       [08:24:54] [08:24:56]   1.7s                 output mismat=
ch (see /home/quintela/scratch/qemu/gcc/qemu/all/tests/qemu-iotests/scratch=
/qcow2-file-108/108.out.bad)
--- /home/quintela/code/qemu/qemu/tests/qemu-iotests/108.out
+++ /home/quintela/scratch/qemu/gcc/qemu/all/tests/qemu-iotests/scratch/qco=
w2-file-108/108.out.bad
@@ -152,6 +152,8 @@

 --- Rebuilding refcount structures on block devices ---

+fuse: failed to exec fusermount3: No such file or directory
+qemu-storage-daemon: --export fuse,id=3Dfuse-export,node-name=3Dexport-nod=
e,mountpoint=3D/home/quintela/scratch/qemu/gcc/qemu/all/tests/qemu-iotests/=
scratch/qcow2-file-108/fuse-export,writable=3Don,growable=3Doff,allow-other=
=3Doff: Failed to mount FUSE session to export
 { "execute": "qmp_capabilities" }
 {"return": {}}
 { "execute": "blockdev-create",
@@ -188,4 +190,6 @@

 Double checking the fixed image now...
 No errors were found on the image.
+cat: /home/quintela/scratch/qemu/gcc/qemu/all/tests/qemu-iotests/scratch/q=
cow2-file-108/qsd.pid: No such file or directory
+/home/quintela/code/qemu/qemu/tests/qemu-iotests/108: line 396: kill: `': =
not a pid or valid job spec
 *** done
Failures: 108
Failed 1 of 1 iotests

So with further evidence, I will say that qemu-iotests failures are not
due to my changes.

/me goes to compile his PULL request on s390:

Thread 1 "qemu-system-s39" received signal SIGSEGV, Segmentation fault.
0x0000aaaaab05b828 in qdev_class_add_legacy_property (
    prop=3D0xaaaaab5fffe0 <savevm_s390_storage_keys>, dc=3D0xaaaaab88be60)
    at ../../../../../quintela/code/qemu/full/hw/core/qdev-properties.c:938
938	    if (!prop->info->print && prop->info->get) {
Missing separate debuginfos, use: dnf debuginfo-install libeconf-0.4.1-3.el=
9_2.aarch64
(gdb) bt
#0  0x0000aaaaab05b828 in qdev_class_add_legacy_property
    (prop=3D0xaaaaab5fffe0 <savevm_s390_storage_keys>, dc=3D0xaaaaab88be60)
    at ../../../../../quintela/code/qemu/full/hw/core/qdev-properties.c:938
#1  device_class_set_props
    (dc=3Ddc@entry=3D0xaaaaab88be60, props=3Dprops@entry=3D0xaaaaab5fff88 <=
s390_skeys_props>) at ../../../../../quintela/code/qemu/full/hw/core/qdev-p=
roperties.c:954
#2  0x0000aaaaaaf6a370 in s390_skeys_class_init
    (oc=3D<optimized out>, data=3D<optimized out>)
    at ../../../../../quintela/code/qemu/full/hw/s390x/s390-skeys.c:461
#3  0x0000aaaaab06222c in type_initialize (ti=3D0xaaaaab74ea60)
    at ../../../../../quintela/code/qemu/full/qom/object.c:1108
#4  object_class_foreach_tramp
    (key=3D<optimized out>, value=3D0xaaaaab74ea60, opaque=3D0xffffffffe498)
    at ../../../../../quintela/code/qemu/full/qom/object.c:1095
#5  0x0000fffff6fe92d8 in g_hash_table_foreach
    (hash_table=3D0xaaaaab70caa0 =3D {...}, func=3D0xaaaaab0621b0 <object_c=
lass_foreach_tramp>, user_data=3D0xffffffffe498) at ../glib/ghash.c:2065
#6  0x0000aaaaab062798 in object_class_foreach
    (opaque=3D<optimized out>, include_abstract=3D<optimized out>, implemen=
ts_type=3D<optimized out>, fn=3D<optimized out>)
    at ../../../../../quintela/code/qemu/full/qom/object.c:87
#7  object_class_get_list
    (implements_type=3Dimplements_type@entry=3D0xaaaaab3cb670 "machine", in=
clude_abstract=3Dinclude_abstract@entry=3Dfalse)
    at ../../../../../quintela/code/qemu/full/qom/object.c:1174
#8  0x0000aaaaaaef30fc in select_machine
    (errp=3D<optimized out>, qdict=3D0xaaaaab773250)
    at ../../../../../quintela/code/qemu/full/system/vl.c:1644
#9  qemu_create_machine (qdict=3D0xaaaaab773250)
    at ../../../../../quintela/code/qemu/full/system/vl.c:2078
#10 qemu_init (argc=3D<optimized out>, argv=3D0xffffffffe7d8)
    at ../../../../../quintela/code/qemu/full/system/vl.c:3668
#11 0x0000aaaaaade7fbc in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>)
    at ../../../../../quintela/code/qemu/full/system/main.c:47

OK, something fishing there.

Will post PULL request without the vmstate_register() changes.

What is weird to me is that it fails in s390x native, and aarch64 host
with s390x tcg.  But it works for x86_64 host and s390x tcg.

Sniff.

Later, Juan.


>
> You can ignore avocado-system-debian, but the others look like real failu=
res.
>
> Please take a look. Thanks!
>
> Stefan
>
>>
>> ----------------------------------------------------------------
>>
>> Juan Quintela (31):
>>   migration/doc: Add contents
>>   migration/doc: Add documentation for backwards compatiblity
>>   migration/doc: How to migrate when hosts have different features
>>   migration/doc: We broke backwards compatibility
>>   migration: Receiving a zero page non zero is an error
>>   migration: Rename ram_handle_compressed() to ram_handle_zero()
>>   migration: Give one error if trying to set MULTIFD and XBZRLE
>>   migration: Give one error if trying to set COMPRESSION and XBZRLE
>>   migration: Remove save_page_use_compression()
>>   migration: Make compress_data_with_multithreads return bool
>>   migration: Simplify compress_page_with_multithread()
>>   migration: Move busy++ to migrate_with_multithread
>>   migration: Create compress_update_rates()
>>   migration: Export send_queued_data()
>>   migration: Move ram_flush_compressed_data() to ram-compress.c
>>   migration: Merge flush_compressed_data() and compress_flush_data()
>>   migration: Rename ram_compressed_pages() to compress_ram_pages()
>>   migration: Create vmstate_register_any()
>>   migration: Use vmstate_register_any()
>>   migration: Use vmstate_register_any() for isa-ide
>>   migration: Use VMSTATE_INSTANCE_ID_ANY for slirp
>>   migration: Hack to maintain backwards compatibility for ppc
>>   migration: Improve example and documentation of vmstate_register()
>>   migration: Use vmstate_register_any() for audio
>>   migration: Use vmstate_register_any() for eeprom93xx
>>   migration: Use vmstate_register_any() for vmware_vga
>>   qemu-iotests: Filter warnings about block migration being deprecated
>>   migration: migrate 'inc' command option is deprecated.
>>   migration: migrate 'blk' command option is deprecated.
>>   migration: Deprecate block migration
>>   migration: Deprecate old compression method
>>
>> Marc-Andr=C3=A9 Lureau (2):
>>   migration: rename vmstate_save_needed->vmstate_section_needed
>>   migration: set file error on subsection loading
>>
>> Peter Xu (1):
>>   migration: Check in savevm_state_handler_insert for dups
>>
>> Thomas Huth (5):
>>   hw/ipmi: Don't call vmstate_register() from instance_init() functions
>>   hw/s390x/s390-skeys: Don't call register_savevm_live() during
>>     instance_init()
>>   hw/s390x/s390-stattrib: Simplify handling of the "migration-enabled"
>>     property
>>   hw/s390x/s390-stattrib: Don't call register_savevm_live() during
>>     instance_init()
>>   migration/ram: Fix compilation with -Wshadow=3Dlocal
>>
>>  docs/about/deprecated.rst        |  35 ++
>>  docs/devel/migration.rst         | 532 ++++++++++++++++++++++++++++++-
>>  qapi/migration.json              |  93 ++++--
>>  include/migration/vmstate.h      |  30 +-
>>  migration/ram-compress.h         |  10 +-
>>  migration/ram.h                  |   3 +-
>>  audio/audio.c                    |   2 +-
>>  backends/dbus-vmstate.c          |   3 +-
>>  backends/tpm/tpm_emulator.c      |   3 +-
>>  hw/display/vmware_vga.c          |   2 +-
>>  hw/i2c/core.c                    |   2 +-
>>  hw/ide/isa.c                     |   2 +-
>>  hw/input/adb.c                   |   2 +-
>>  hw/input/ads7846.c               |   2 +-
>>  hw/input/stellaris_input.c       |   3 +-
>>  hw/intc/xics.c                   |  18 +-
>>  hw/ipmi/ipmi_bmc_extern.c        |  29 +-
>>  hw/ipmi/isa_ipmi_bt.c            |  34 +-
>>  hw/ipmi/isa_ipmi_kcs.c           |  50 +--
>>  hw/net/eepro100.c                |   3 +-
>>  hw/nvram/eeprom93xx.c            |   2 +-
>>  hw/pci/pci.c                     |   2 +-
>>  hw/ppc/spapr.c                   |  25 +-
>>  hw/ppc/spapr_nvdimm.c            |   3 +-
>>  hw/s390x/s390-skeys.c            |  35 +-
>>  hw/s390x/s390-stattrib.c         |  71 ++---
>>  hw/timer/arm_timer.c             |   2 +-
>>  hw/virtio/virtio-mem.c           |   4 +-
>>  migration/block.c                |   3 +
>>  migration/migration-hmp-cmds.c   |  10 +
>>  migration/migration.c            |  10 +
>>  migration/options.c              |  36 ++-
>>  migration/ram-compress.c         | 112 +++++--
>>  migration/ram.c                  | 114 ++-----
>>  migration/rdma.c                 |   8 +-
>>  migration/savevm.c               |  34 +-
>>  migration/vmstate.c              |   5 +-
>>  net/slirp.c                      |   5 +-
>>  tests/qemu-iotests/183           |   2 +-
>>  tests/qemu-iotests/common.filter |   7 +
>>  40 files changed, 1041 insertions(+), 307 deletions(-)
>>
>> --
>> 2.41.0
>>
>>


