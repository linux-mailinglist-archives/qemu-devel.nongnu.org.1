Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DFE706D64
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:54:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJSR-0003Ku-Vn; Wed, 17 May 2023 11:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzJSO-0003Jj-3i
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:52:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzJSM-0005v0-EW
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:52:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3063433fa66so635563f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684338768; x=1686930768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:user-agent:from:to:cc:subject:date:message-id:reply-to;
 bh=2zgawbbiH3ZN+t5cl5i5se7wIX3B/JzZA+6PRyvIIdQ=;
 b=g5vI9spJJGk0AQg2nrDscgqmqP0hfliUsHdlmHIo3Us/3MCHru8MSL5VhuY5GT2/mq
 dRoS9rGKH+DSY0Pk6SGac+3nIrPcqrixW/J4kbvJqqzBVSCbZ8xOFTu/ib1xQ7zviDZk
 ibs2kc+8BOqHSss7aGDvVd5cDpfR14sdXJxylUPWqT/o/PqQ4hY9XSf+wHEmCaQh4q94
 FdFDSJGxvGseU3ZcQCFrHKeAwnWn++N0N3NhMWfDwCBhXlwgBEWuTh1Zzuy6AvkocsEa
 JF4hTrpK1NZCFMuLudbaFaQY4XnlK7TfXMkMNOZzzhktmkAMiz6g0Gc46Sl6Jd0zwx3/
 nMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684338768; x=1686930768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:user-agent:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zgawbbiH3ZN+t5cl5i5se7wIX3B/JzZA+6PRyvIIdQ=;
 b=de2kcFJzbJEdGfbJ/au1QZmZx48mHg/CJyxkG8OxUe6siURZexhh/aLP0rqnk2GDTa
 nUyk/ichBIn9sh1xLqskYvv2UrcF/ajoy4Vmw/hc6MCx8061DkPWFjbAkKku7wsD9Ik6
 rpvYgnA1nchjxIygSm0ozPDPAFY+24EOtiMAIQxHYmumoJxoyPO0QXVMMJ1EomHxSYux
 Qx5NjphsPJ2piK23cyo2W9YL+1Fb+E4g0VFcSRT0DAdECIujISdo3btX6HqB82O3bEph
 GKbixsMyCYDLzEbaYf66WL2FtTiWYzs3SH99Mey4IpyIFaUxWYlsnO/M8I5LRdzPm4uA
 kZbQ==
X-Gm-Message-State: AC+VfDzskmrx6nQgNWKlkuGI5+P/y+OtOvctIN5VfiypSvI90R+N917b
 cwlNKVyyZ6+nH2kJHH6FaukhL4XP/vPD+zLqUBzyEQ==
X-Google-Smtp-Source: ACHHUZ7q2z3P6UZkiBWionaRCIoCzNwGj7Sy+we/QRxvSxXiETH9tC1liVIInk17lzo3LqqEPXPiVg==
X-Received: by 2002:a5d:58e6:0:b0:309:33c4:52e1 with SMTP id
 f6-20020a5d58e6000000b0030933c452e1mr838763wrd.64.1684338767816; 
 Wed, 17 May 2023 08:52:47 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j11-20020adff54b000000b003062c609115sm3235414wrp.21.2023.05.17.08.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 08:52:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0148D1FFBB;
 Wed, 17 May 2023 16:52:47 +0100 (BST)
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-fs@redhat.com, Erik
 Schilling <erik.schilling@linaro.org>
Subject: Status of DAX for virtio-fs/virtiofsd?
Date: Wed, 17 May 2023 16:23:46 +0100
Message-ID: <87v8grlzu9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Hi,

I remember from the dim and distant past (probably a KVM Forum) that one
of the touted features of virtio-fs was the ability to get memory
efficiency savings by having a direct memory mapping the host pages into
the guest address space.

AFAICT the kernel side was merged a while ago, see 22f3787 (virtiofs:
set up virtio_fs dax_device) and related. However when investigating
what would be needed to support this for Xen guests using virtio-fs we
were confused as to what else was needed.

There were some patches for the old C daemon:

  Subject: [PATCH v3 00/26] virtiofs dax patches
  Date: Wed, 28 Apr 2021 12:00:34 +0100	[thread overview]
  Message-ID: <20210428110100.27757-1-dgilbert@redhat.com>

although they look like they were never merged and the C version of
virtiofsd has since been dropped from tools.

Looking at the supporting rust code (vhost_user/message.rs) there are a
number of additional messages:

    /// Virtio-fs draft: map file content into the window.
    FS_MAP =3D 6,
    /// Virtio-fs draft: unmap file content from the window.
    FS_UNMAP =3D 7,
    /// Virtio-fs draft: sync file content.
    FS_SYNC =3D 8,
    /// Virtio-fs draft: perform a read/write from an fd directly to GPA.
    FS_IO =3D 9,
    /// Upper bound of valid commands.
    MAX_CMD =3D 10,

that don't appear in the current canonical vhost-user reference in the
QEMU repository and the QEMU code certainly doesn't have implementations
for any of them. So I have some questions:

 * What VMM/daemon combinations has DAX been tested on?
 * Isn't it time the vhost-user spec is updated?
 * Is anyone picking up Dave's patches for the QEMU side of support?

Thanks,


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

