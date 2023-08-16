Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 589AD77DBE8
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 10:16:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWBfy-0007ao-Ji; Wed, 16 Aug 2023 04:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWBfw-0007aW-4o; Wed, 16 Aug 2023 04:14:44 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWBfs-000262-Dg; Wed, 16 Aug 2023 04:14:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5231410ab27so8129003a12.0; 
 Wed, 16 Aug 2023 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692173678; x=1692778478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8pHbkfEj+9L/GBG6s46giXIYjKMVc74pY0BviJ7SuI=;
 b=AHmRrdjaSzOTqQoXmJXLebbkN/dMbM+Z5y4UhNwEaiiaAuPcoxUVy/RgQhWjpIxO2U
 Y/HG0LxupHGFn7F2BACVdMx6SJdqq29lElJdslddYPquH+tgJbFzJ1mtyGbZ65JW6oZH
 bk6//P3ePI1hZe5JxG/614S+8w/rKB8YA9qrFKVtT9NpDFhKmoWXw8Kr4yADUTsoJHjK
 iS+0rrA622zIjByAGVEf/7TMKHeKU8XVctGRfMgpaZLN5ozofkete7tfTCd/12NBhMf2
 tNm60xBZUo1MQRjVdODH7DxxDHGxy0qaPwUBbTd42B4Z5nS+NvHe0HtVbfymQEFsqt0O
 VEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692173678; x=1692778478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8pHbkfEj+9L/GBG6s46giXIYjKMVc74pY0BviJ7SuI=;
 b=fZ8oDyOrSn7IvLU89LK2vjmhosxlcrjVQ1njtCnBQX1NqaX9ESKL81MEd1fccbcT9T
 hCat0K1nODcavrTOstK/JfH/G0EzjiGOa97h9DDWOON7SGtZCwRE3Xa57FDnUEIVWOpE
 pxzb6WO4deaqEDs6heqhi9NWuLMuYJhlQMpAQK52759R7k9crSeTvOIgaZcCUaZ7/oTT
 6xBS8n/I0U2+Z78VeixFV2SoSSuCtb50iPhrypDKNPDD3lcNAkmPu0ofPjpX0WywMdwn
 xkb4gQ55/iVJ1uYafLMLbDAGdYez3uvWfY5avzOu2Wu77lIj4DhmUOPQ79tCCx6j88yo
 suyA==
X-Gm-Message-State: AOJu0YyrhVRkD1OxQFbD7z/1PaAmvi1rRSpFwQc+TESn+Q+f9JWrrRcl
 JsBOUQUyGgFPqwQCAtzRH5MUm8X7hsrLQSTwppU=
X-Google-Smtp-Source: AGHT+IEga+ulCOZIwUxzTMxY8LmjOWKge12GTbh8v6XM+y74cfc4wOYF5rfivPzKHd6PyqW9BAX2Qufd2KzyGV9qrCU=
X-Received: by 2002:a17:906:105c:b0:99d:f778:b8e5 with SMTP id
 j28-20020a170906105c00b0099df778b8e5mr328145ejj.28.1692173677317; Wed, 16 Aug
 2023 01:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <ZNx8sVd5YL6UAFkT@cormorant.local>
In-Reply-To: <ZNx8sVd5YL6UAFkT@cormorant.local>
From: Sam Li <faithilikerun@gmail.com>
Date: Wed, 16 Aug 2023 16:14:08 +0800
Message-ID: <CAAAx-8KuRP3-OO-VWHS4PXhCSKV67d2g7waNz5p2eCL9-oaYBw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add full zoned storage emulation to qcow2 driver
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>, 
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 stefanha@redhat.com, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x533.google.com
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

Klaus Jensen <its@irrelevant.dk> =E4=BA=8E2023=E5=B9=B48=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 15:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Aug 14 16:57, Sam Li wrote:
> > This patch series add a new extension - zoned format - to the
> > qcow2 driver thereby allowing full zoned storage emulation on
> > the qcow2 img file. Users can attach such a qcow2 file to the
> > guest as a zoned device.
> >
> > To create a qcow2 file with zoned format, use command like this:
> > $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> > zone_size=3D64M -o zone_capacity=3D64M -o zone_nr_conv=3D0 -o
> > max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=3D0
> > -o zoned_profile=3Dzbc
> >
> > Then add it to the QEMU command line:
> >     -blockdev node-name=3Ddrive1,driver=3Dqcow2,file.driver=3Dfile,file=
.filename=3D../qemu/test.qcow2 \
> >     -device virtio-blk-pci,drive=3Ddrive1 \
> >
> > v1->v2:
> > - add more tests to qemu-io zoned commands
> > - make zone append change state to full when wp reaches end
> > - add documentation to qcow2 zoned extension header
> > - address review comments (Stefan):
> >   * fix zoned_mata allocation size
> >   * use bitwise or than addition
> >   * fix wp index overflow and locking
> >   * cleanups: comments, naming
> >
> > Sam Li (4):
> >   docs/qcow2: add the zoned format feature
> >   qcow2: add configurations for zoned format extension
> >   qcow2: add zoned emulation capability
> >   iotests: test the zoned format feature for qcow2 file
> >
> >  block/qcow2.c                            | 799 ++++++++++++++++++++++-
> >  block/qcow2.h                            |  23 +
> >  docs/interop/qcow2.txt                   |  26 +
> >  docs/system/qemu-block-drivers.rst.inc   |  39 ++
> >  include/block/block-common.h             |   5 +
> >  include/block/block_int-common.h         |  16 +
> >  qapi/block-core.json                     |  46 +-
> >  tests/qemu-iotests/tests/zoned-qcow2     | 135 ++++
> >  tests/qemu-iotests/tests/zoned-qcow2.out | 140 ++++
> >  9 files changed, 1214 insertions(+), 15 deletions(-)
> >  create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
> >  create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out
> >
>
> Hi Sam,
>
> Thanks for this and for the RFC for hw/nvme - this is an awesome
> improvement.
>
> Can you explain the need for the zoned_profile? I understand that only
> ZNS requires potentially setting zone_capacity and configuring extended
> descriptors. When an image is hooked up to a block emulation device that
> doesnt understand cap < size or extended descriptors, it could just
> would fail on the cap < size and just ignore the extended descriptor
> space. Do we really need to add the complexity of the user explicitly
> having to set the profile? I also think it is fair for the QEMU zoned
> block api to accomodate both variations - if a particular configuration
> is supported or not is up to the emulating device.
>
> Checking the profile from hw/nvme or hw/block/virtio is the same as
> checking if cap < size or possibly the presence of extended descriptors.

Hi Klaus,

Thanks for your feedback.

The zoned_profile is for users to choose the emulating device type,
either zbc or zns. It implies using virtio-blk or nvme pass through.
The zoned block api does accommodate both variations. Since the cap <
size and extended descriptor config can also infer zoned_profile, this
option can be dropped. Then the device type is determined by the
configurations. When cap =3D size and no extended descriptor, the img
can be used both in virtio-blk and nvme zns depending on the QEMU
command line.


Best regards,
Sam

