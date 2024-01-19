Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 505D1832C5A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:27:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqm8-0007K8-4N; Fri, 19 Jan 2024 10:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQqm4-0007GN-9r
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:27:16 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQqm2-0001PJ-Ia
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:27:15 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55a3a2fec1bso982870a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705678033; x=1706282833; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nVAKVz/Pdq592yhS5/KmVaVARjy5Rg/AG1d3vJ7LVgY=;
 b=nKXCeHGN3BSkX8/BBe7qd3flgBE7jgL8MgoSWGiuIJxBFqwOebJBpGI4W9My8xZhDf
 y0yBcMu/zgv4k75KaLyUoEz/T9WlRK8XDz1/Zz4citpwbk13SjjFkpLuBjwqKH+vKY4Z
 eBhAfgLrq5tSuIsrShzaIJpTWJift/xuJbT6h9YAn5WrSr1uq3QmabQcrQ2HKabEkDrP
 Z4k4gFH8fIpgaXFofWc6p4ZjhtHDJqD1RoRuhHrc+qJOVc3zjL06snHRLciJu7jSz4II
 rMTo+XYBB0tQ3zXvRHrgU55chStsPVKpfKfb+0TxNjt7m0r9ZTLaoBeuU0kzdTjL9eG0
 h5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705678033; x=1706282833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nVAKVz/Pdq592yhS5/KmVaVARjy5Rg/AG1d3vJ7LVgY=;
 b=QSrs0JpeY83X9xqvuC25m/05QpQhGUspe9FOsIsWDazyuxyuHnS8SFLfx54oOH9wXt
 IGkL4TI96HzWf7Q6G2dVe+eZyWEJgRQv+IF9EsabKaChFtlPbYMcImNYXN1hpKyo76TR
 yBShQ94HhCGM6OXHPwG2t5adBDzz1XvifiF3NR6Nv/tcfWfmYwJpANy7rJOMG0FKUWM0
 Z9dgCBAxAR24p2pp+VrMIF78CFxh530l4mCBwk2gGiVDTlhHPqAtKs2Y+h8L7G2cS/Fq
 IxLIjn62CbQM3TgzEx3YwET9OdwooZ1nolpRnRGGQNDXvKMMXlaD7YpUaFPdWBWU00ju
 CCwA==
X-Gm-Message-State: AOJu0YwroIIiBJvDVnMQQUFRsLZ1s/Ayj0ZFUc2gBoETksxoX/7A3+J7
 nn6KOpuh8eyVt8ZdV85KG41wFik5exyfpHpNSF90hO1ZL7FvLveu0/YlDN5zBeCJnxwkTAFltmg
 gksH0zR4cTggx2LRE0th3iEAoFRptdDKi0SNfyA==
X-Google-Smtp-Source: AGHT+IEFRhn80qAqVKIM3gtmi/vEOFwOSCXus3QsKpNmWzt/2fOeK/IrgTHWeSzMvxkHonXyd2Tx37NPWr3crjvJRjE=
X-Received: by 2002:aa7:c156:0:b0:558:874e:b42d with SMTP id
 r22-20020aa7c156000000b00558874eb42dmr844237edp.144.1705678032877; Fri, 19
 Jan 2024 07:27:12 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_7s=scvgYfG8kGmJ==5cKmvvA-ZqVkpt4M9jV6eS1Zow@mail.gmail.com>
 <ZaqCA5uYWFSgK6F-@redhat.com>
In-Reply-To: <ZaqCA5uYWFSgK6F-@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 15:26:58 +0000
Message-ID: <CAFEAcA_n-pgzd-bne7VvHk5a3Q9ofpxWsmWTshtV=nKfZd9ESA@mail.gmail.com>
Subject: Re: how do the iotests pick a machine model to run on ?
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 19 Jan 2024 at 14:07, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 19.01.2024 um 13:55 hat Peter Maydell geschrieben:
> > How are the iotests supposed to select a machine model to run
> > on, and how are they intended to mark themselves as requiring
> > particular facilities, like PCI? Presumably some of the tests
> > are missing the appropriate annotations to ensure they're
> > skipped when the facilities required aren't present.
>
> Probably next to nobody builds only sh4 and then runs 'make check'...
>
> I think the following patch should fix this test case (but as nobody
> ever tested it, I fully expect other cases to fail, too). The fix could
> of course be a lot more fine grained and skip only some individual tests
> instead of all of them. I doubt we care, though, as long as it passes.

> iotests use machine_map in tests/qemu-iotests/testenv.py to decide which
> machine to use for which target (unless the individual test case
> overrides that). If the target isn't the list, it gets the default
> machine type.

Thanks. Unfortunately your suggested fix doesn't work.

Looking at the definition of  verify_virtio_scsi_pci_or_ccw():

def verify_virtio_scsi_pci_or_ccw() -> None:
    out = qemu_pipe('-M', 'none', '-device', 'help')
    if 'virtio-scsi-pci' not in out and 'virtio-scsi-ccw' not in out:
        notrun('Missing virtio-scsi-pci or virtio-scsi-ccw in QEMU binary')

this doesn't look to me like it's testing the right thing.
You want to know "will one of these devices work on the
machine type I am going to run", not "is this built in to
the binary at all". The -device help output for qemu-system-sh4
does include virtio-scsi-pci because there is a different
non-default machine type that has PCI; but the machine the
040 test actually runs doesn't have PCI.

(Also, we should probably put an entry for sh4 in machine_map,
because the default board type (shix) is about to be deprecated,
and the r2d board type is thus a better choice.)

-- PMM

