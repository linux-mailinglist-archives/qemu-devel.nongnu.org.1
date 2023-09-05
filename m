Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7E7922F1
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVxv-0002IQ-TA; Tue, 05 Sep 2023 09:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qdVxt-0002IA-Qy
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:19:33 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qdVxr-0003VE-2B
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:19:33 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe27849e6aso3943992e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1693919968; x=1694524768; darn=nongnu.org; 
 h=mime-version:user-agent:content-transfer-encoding:date:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HbLEEYLdwGG1Y/SGiWWXlAXh0H9p7GKnPfc1L+PF2eU=;
 b=J5uAIM2DsMaBpMDC9VlZIlV1cBpYT6EH27BF1vO2s5Gs7zP2tR3RjMOTumFQv+yl/5
 7kgTNdeSiJ6bTvJG1/ddCmlAusAYaFjAt024RHQbOSrP3uQahRoEAwJEs27VFaC7EA65
 B1PwnxOzzw444EQGssH5SYeF4ogCRPEiOO9u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693919968; x=1694524768;
 h=mime-version:user-agent:content-transfer-encoding:date:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbLEEYLdwGG1Y/SGiWWXlAXh0H9p7GKnPfc1L+PF2eU=;
 b=VtGIGmpSqynKAeozDaWdnrYwKYTOHfTolkeopwgbLS8cJg1PdB6aYr/G52vNFc8xQv
 6LRICtjeBItIgC319yc0/ePMxGjtcH1CqYY2NeWh9ccuepPRbwCptSuokJa/eMWsGBrd
 QY5sxHnJ6iIuLAfQio6fCDsKvrbyeQ5rj+opEmYGL6Xx7QLABubEShBARLtVM8DWcAWP
 y1aI3/0srVTtOL1OszvJHJEPR56Ep3Op4KV1qruO7g25DldKl1wsnzSrqs9gy5m1Hv0K
 YCuZe2C+KkRNxdTSmKTYxryWWdKSvEOT2R/iF0cS6F9pYOwQ+Smlkb3+WwbYdb3t9/jb
 YxAg==
X-Gm-Message-State: AOJu0YzVns6SexuzT0rulC/sli7O4v1OUM/W0QD4Vtd4oeBag8PpgWNf
 1qskgeI9DpB9FElsH5tAoDNg9CIoFOJULwHbtRg=
X-Google-Smtp-Source: AGHT+IHs6zRKzCUOAqWNkBbWjGULK5AdyhoiJrhg6BprU+LabXqCJXeEPqVSNswbieUQakTLusznUA==
X-Received: by 2002:a05:6512:b8c:b0:500:8725:1351 with SMTP id
 b12-20020a0565120b8c00b0050087251351mr11638607lfv.47.1693919968251; 
 Tue, 05 Sep 2023 06:19:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9cbb:8ec6:1cb5:104e?
 ([2001:8b0:aba:5f3c:9cbb:8ec6:1cb5:104e])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a5d6351000000b0030fd03e3d25sm17750009wrw.75.2023.09.05.06.19.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 06:19:27 -0700 (PDT)
Message-ID: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
Subject: mips system emulation failure with virtio
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: qemu-devel@nongnu.org
Date: Tue, 05 Sep 2023 14:19:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.purdie@linuxfoundation.org;
 helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

With qemu 8.1.0 we see boot hangs fox x86-64 targets.=C2=A0

These are fixed by 0d58c660689f6da1e3feff8a997014003d928b3b (softmmu:
Use async_run_on_cpu in tcg_commit) but if I add that commit, mips and
mips64 break, hanging at boot unable to find a rootfs.=C2=A0

We use virtio for network and disk and both of those change in the
bootlog from messages like:

[    1.726118] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
[    1.728864] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
[    1.729948] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
...
[    2.162148] virtio_blk virtio2: 1/0/0 default/read/poll queues
[    2.168311] virtio_blk virtio2: [vda] 1184242 512-byte logical=20

to:

[    1.777051] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
[    1.779822] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
[    1.780926] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
...
[    1.894852] virtio_rng: probe of virtio1 failed with error -28
...
[    2.063553] virtio_blk virtio2: 1/0/0 default/read/poll queues
[    2.064260] virtio_blk: probe of virtio2 failed with error -28
[    2.069080] virtio_net: probe of virtio0 failed with error -28


i.e. the virtio drivers no longer work.

I tested with current qemu master
(17780edd81d27fcfdb7a802efc870a99788bd2fc) and mips is still broken
there.

Is this issue known about?

Cheers,

Richard

