Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D313C779767
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 20:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUXL8-0005cE-SK; Fri, 11 Aug 2023 14:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhitingz@cs.utexas.edu>)
 id 1qUXL7-0005bx-1w
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 14:58:25 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhitingz@cs.utexas.edu>)
 id 1qUXL4-0001vC-VK
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 14:58:24 -0400
X-AuthUser: zhitingz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
 s=default; t=1691780296;
 bh=hexQUSjYka8rBBoSjMdaNi8G+GvaS2/qNg1W84Imfaw=;
 h=From:Date:Subject:To:From;
 b=SuGzmc6rkd2XvLAHb+2VAfXw0SFwLaWWFMJNzvwx9W0Ubujk99IAtmDagFOR/pj+d
 lWsjKucEh486OutolNJSvT1h/cuhIVHnYcL9ymqIhqYG46nvXif+yCN8sj81lVubp1
 s/vLZTiWR8/f2lwTZmOOI94mQVWoYfaGKUpuSD7g=
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) (authenticated bits=0)
 by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 37BIwFCj036313
 (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 13:58:16 -0500
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-31969580797so9280f8f.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 11:58:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YzzQjU6JwZMTobiqJ6Tx0VkMBV+QEXJ5ks6x1/Gr8V9VqAJzAt2
 J5pDfRd4t2DuiEIWYrKD/d1zALKgtXpE/N/hgfY=
X-Google-Smtp-Source: AGHT+IFuGXGVUC9iN4I5oggMaBkMWN48rNHxm7rTIIrECluoM81QrhZNI2FqH/zIF36cfTRB2JOgoCF7nJWVts9zZvo=
X-Received: by 2002:adf:e444:0:b0:318:7bc:e1b5 with SMTP id
 t4-20020adfe444000000b0031807bce1b5mr1827815wrm.32.1691780294437; Fri, 11 Aug
 2023 11:58:14 -0700 (PDT)
MIME-Version: 1.0
From: zhiting zhu <zhitingz@cs.utexas.edu>
Date: Fri, 11 Aug 2023 13:58:03 -0500
X-Gmail-Original-Message-ID: <CA+3q14wwxVR7g6ixibVtrB8oVYbYc=yhDf8USfJay_9BCE9VEg@mail.gmail.com>
Message-ID: <CA+3q14wwxVR7g6ixibVtrB8oVYbYc=yhDf8USfJay_9BCE9VEg@mail.gmail.com>
Subject: Question about MTRR settings for IVSHMEM device
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007cf5e50602aa4bd6"
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.3.9
 (newman.cs.utexas.edu [128.83.139.110]); Fri, 11 Aug 2023 13:58:16 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.103.8 at newman
X-Virus-Status: Clean
Received-SPF: pass client-ip=128.83.139.110;
 envelope-from=zhitingz@cs.utexas.edu; helo=newman.cs.utexas.edu
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001, RCVD_DOTEDU_SHORT=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

--0000000000007cf5e50602aa4bd6
Content-Type: text/plain; charset="UTF-8"

Hi,

I found that in the guest Linux OS. The IVSHMEM device is set with 3 MTRR
regions.

reg00: base=0x0c0000000 ( 3072MB), size= 1024MB, count=1: uncachable
reg01: base=0x0b0000000 ( 2816MB), size=  256MB, count=1: uncachable
reg02: base=0x800000000 (32768MB), size=32768MB, count=1: uncachable

Bar 2 is listed in reg02. As the entry said, it's set to uncachable. This
entry causes slow access on AMD machine even though I map the region to be
writeback using devm_memmap_pages with type set to MEMORY_DEVICE_GENERIC.
By removing the entry, the access to the region goes faster as it's
cacheable. Inside the kernel driver, there's no way to remove those entries
as the mtrr_del are not exposed. I have to do it in user space.

Does anyone know what sets these MTRR entries? By default, the virtio-pci
driver is used for the IVSHMEM device. I saw the device driver use ioremap
to map the bar. But what I saw in the source code is it sets the PAT not
MTRR.

Best,
Zhiting

--0000000000007cf5e50602aa4bd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I found that in the guest Linux OS.=
 The IVSHMEM device is set with 3 MTRR regions.=C2=A0</div><div><br></div><=
div>reg00: base=3D0x0c0000000 ( 3072MB), size=3D 1024MB, count=3D1: uncacha=
ble<br>reg01: base=3D0x0b0000000 ( 2816MB), size=3D =C2=A0256MB, count=3D1:=
 uncachable<br>reg02: base=3D0x800000000 (32768MB), size=3D32768MB, count=
=3D1: uncachable<br></div><div><br></div><div>Bar 2 is listed in reg02. As =
the entry said, it&#39;s set to uncachable. This entry causes slow access o=
n AMD machine even though I map the region to be writeback using devm_memma=
p_pages with type set to MEMORY_DEVICE_GENERIC. By removing the entry, the =
access to the region goes faster as it&#39;s cacheable. Inside the kernel d=
river, there&#39;s no way to remove those entries as the mtrr_del are not e=
xposed. I have to do it in user space.=C2=A0</div><div><br></div><div>Does =
anyone know what sets these MTRR entries? By default, the virtio-pci driver=
 is used for the IVSHMEM device. I saw the device driver use ioremap to map=
 the bar. But what I saw in the source code is it sets the PAT not MTRR.=C2=
=A0</div><div><br></div><div>Best,</div><div>Zhiting=C2=A0<br></div></div>

--0000000000007cf5e50602aa4bd6--

