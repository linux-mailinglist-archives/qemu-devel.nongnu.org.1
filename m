Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC9B7D79D5
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoaf-0005I9-8x; Wed, 25 Oct 2023 20:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qvoad-0005Ha-5w; Wed, 25 Oct 2023 20:51:11 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qvoab-0002E9-3j; Wed, 25 Oct 2023 20:51:10 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-581fb6f53fcso225148eaf.2; 
 Wed, 25 Oct 2023 17:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698281465; x=1698886265; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvLKDcA1Bbl99MTx91e5m6PwJViefSi8KsQ0LDpK4Lw=;
 b=INigDWjvN2+WQ2X3/add5QkNX2hU3oRbYC3YJtCWESTmVwLnbPSjKL4zbQYjisRB8+
 DejgIjR1/ZgkyxY7wl/e1eb6kmhVNGs6Cj5OSDLo+j7ahE1p5ISGjmOXq/X+v4bYoEle
 xKzdpPnxI/1gM3Q4o59o6LdkYVUdm8EQINo+9AOLIp8AKLupIOf7E6pok4COekGnu+P0
 757BiPavlD5umZ0HIRXRHmD+H92bEt+KQhpiScZXsOimAtmie1/CaRYMSEt3zE61BtgX
 lxfFnuCKQT4TWrRqsbbew5onvKqqT6QqEM+AxFxniuOso7QVMd4RluC3+lUuKr0mPbpP
 Wqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698281465; x=1698886265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZvLKDcA1Bbl99MTx91e5m6PwJViefSi8KsQ0LDpK4Lw=;
 b=wWhCSvSOFJICNBw5SX3Dk3zG6vfuwjoeAJb9KwyKSD7XFcan2zusrcaZbV2X5vimTw
 oDvLvK+Sc7pHcfFu2T4x+lfRJVAUi+LuqhUXZC0yU+HPGkPshcQLQijXRrR9XVJZr7ir
 xmiQ+j5R3CaXarkfGxJeH5NcJA5FLl7dXzNFuYnv7xC8OfbC2F8P3+QnRjub1M0CD9gd
 ID6TXRIKSpfma5TKguEQw67cDs4OQKxab7ejrW6jP8qtiqTT2/51KK3l+nlG8/Yqx3I1
 QDf1a9SDsjiENWCVyZvgA6vRjUDy7n/4EkC6BH/xxd04D5wOeB7ACRUs8qA3SFYLaOAc
 S96Q==
X-Gm-Message-State: AOJu0Yz1/eEQ5LPXpigsuz/ZKlXVyjkb+Q7pEUV/WhBwOt8aVEHWzBNi
 dTWXHoSHz6BqFf+tx1C9r6wchyeqJGLBX+C0e48=
X-Google-Smtp-Source: AGHT+IEEG/CXIsfuRU2rhKdnDA8u0ton+Avd/Pl40OJt5lgPRrzEyGQtNFz7marDPjlEMwPHDPOGDRy9jypEXYsh4vk=
X-Received: by 2002:a4a:e8dc:0:b0:573:bf68:8dbc with SMTP id
 h28-20020a4ae8dc000000b00573bf688dbcmr14060519ooe.7.1698281465607; Wed, 25
 Oct 2023 17:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231024131305.87468-1-quintela@redhat.com>
In-Reply-To: <20231024131305.87468-1-quintela@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 26 Oct 2023 09:50:53 +0900
Message-ID: <CAJSP0QVZPM5BkHYBTqXmDBuBvUuAAhjdgX_3Ka0WbqTzBxutvg@mail.gmail.com>
Subject: Re: [PULL 00/39] Migration 20231024 patches
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Corey Minyard <minyard@acm.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Kevin Wolf <kwolf@redhat.com>,
 qemu-s390x@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 libvir-list@redhat.com, Stefan Weil <sw@weilnetz.de>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 24 Oct 2023 at 23:45, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit a95260486aa7e78d7c7194eba65cf03311ad94=
ad:
>
>   Merge tag 'pull-tcg-20231023' of https://gitlab.com/rth7680/qemu into s=
taging (2023-10-23 14:45:46 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/juan.quintela/qemu.git tags/migration-20231024-pull-=
request
>
> for you to fetch changes up to 088f7f03da3f5b3487091302b795c22b1bfe56fb:
>
>   migration: Deprecate old compression method (2023-10-24 13:48:24 +0200)
>
> ----------------------------------------------------------------
> Migration Pull request (20231024)
>
> Hi
>
> In this PULL:
> - vmstate registration fixes (thomas, juan)
> - start merging vmstate_section_needed changes (marc)
> - migration depreactions (juan)
> - migration documentation for backwards compatibility (juan)
>
> Please apply.

Hi Juan,
I'm seeing CI failures:
https://gitlab.com/qemu-project/qemu/-/pipelines/1048630760

You can ignore avocado-system-debian, but the others look like real failure=
s.

Please take a look. Thanks!

Stefan

>
> ----------------------------------------------------------------
>
> Juan Quintela (31):
>   migration/doc: Add contents
>   migration/doc: Add documentation for backwards compatiblity
>   migration/doc: How to migrate when hosts have different features
>   migration/doc: We broke backwards compatibility
>   migration: Receiving a zero page non zero is an error
>   migration: Rename ram_handle_compressed() to ram_handle_zero()
>   migration: Give one error if trying to set MULTIFD and XBZRLE
>   migration: Give one error if trying to set COMPRESSION and XBZRLE
>   migration: Remove save_page_use_compression()
>   migration: Make compress_data_with_multithreads return bool
>   migration: Simplify compress_page_with_multithread()
>   migration: Move busy++ to migrate_with_multithread
>   migration: Create compress_update_rates()
>   migration: Export send_queued_data()
>   migration: Move ram_flush_compressed_data() to ram-compress.c
>   migration: Merge flush_compressed_data() and compress_flush_data()
>   migration: Rename ram_compressed_pages() to compress_ram_pages()
>   migration: Create vmstate_register_any()
>   migration: Use vmstate_register_any()
>   migration: Use vmstate_register_any() for isa-ide
>   migration: Use VMSTATE_INSTANCE_ID_ANY for slirp
>   migration: Hack to maintain backwards compatibility for ppc
>   migration: Improve example and documentation of vmstate_register()
>   migration: Use vmstate_register_any() for audio
>   migration: Use vmstate_register_any() for eeprom93xx
>   migration: Use vmstate_register_any() for vmware_vga
>   qemu-iotests: Filter warnings about block migration being deprecated
>   migration: migrate 'inc' command option is deprecated.
>   migration: migrate 'blk' command option is deprecated.
>   migration: Deprecate block migration
>   migration: Deprecate old compression method
>
> Marc-Andr=C3=A9 Lureau (2):
>   migration: rename vmstate_save_needed->vmstate_section_needed
>   migration: set file error on subsection loading
>
> Peter Xu (1):
>   migration: Check in savevm_state_handler_insert for dups
>
> Thomas Huth (5):
>   hw/ipmi: Don't call vmstate_register() from instance_init() functions
>   hw/s390x/s390-skeys: Don't call register_savevm_live() during
>     instance_init()
>   hw/s390x/s390-stattrib: Simplify handling of the "migration-enabled"
>     property
>   hw/s390x/s390-stattrib: Don't call register_savevm_live() during
>     instance_init()
>   migration/ram: Fix compilation with -Wshadow=3Dlocal
>
>  docs/about/deprecated.rst        |  35 ++
>  docs/devel/migration.rst         | 532 ++++++++++++++++++++++++++++++-
>  qapi/migration.json              |  93 ++++--
>  include/migration/vmstate.h      |  30 +-
>  migration/ram-compress.h         |  10 +-
>  migration/ram.h                  |   3 +-
>  audio/audio.c                    |   2 +-
>  backends/dbus-vmstate.c          |   3 +-
>  backends/tpm/tpm_emulator.c      |   3 +-
>  hw/display/vmware_vga.c          |   2 +-
>  hw/i2c/core.c                    |   2 +-
>  hw/ide/isa.c                     |   2 +-
>  hw/input/adb.c                   |   2 +-
>  hw/input/ads7846.c               |   2 +-
>  hw/input/stellaris_input.c       |   3 +-
>  hw/intc/xics.c                   |  18 +-
>  hw/ipmi/ipmi_bmc_extern.c        |  29 +-
>  hw/ipmi/isa_ipmi_bt.c            |  34 +-
>  hw/ipmi/isa_ipmi_kcs.c           |  50 +--
>  hw/net/eepro100.c                |   3 +-
>  hw/nvram/eeprom93xx.c            |   2 +-
>  hw/pci/pci.c                     |   2 +-
>  hw/ppc/spapr.c                   |  25 +-
>  hw/ppc/spapr_nvdimm.c            |   3 +-
>  hw/s390x/s390-skeys.c            |  35 +-
>  hw/s390x/s390-stattrib.c         |  71 ++---
>  hw/timer/arm_timer.c             |   2 +-
>  hw/virtio/virtio-mem.c           |   4 +-
>  migration/block.c                |   3 +
>  migration/migration-hmp-cmds.c   |  10 +
>  migration/migration.c            |  10 +
>  migration/options.c              |  36 ++-
>  migration/ram-compress.c         | 112 +++++--
>  migration/ram.c                  | 114 ++-----
>  migration/rdma.c                 |   8 +-
>  migration/savevm.c               |  34 +-
>  migration/vmstate.c              |   5 +-
>  net/slirp.c                      |   5 +-
>  tests/qemu-iotests/183           |   2 +-
>  tests/qemu-iotests/common.filter |   7 +
>  40 files changed, 1041 insertions(+), 307 deletions(-)
>
> --
> 2.41.0
>
>

