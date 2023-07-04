Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F03F746A74
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:20:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaKD-0002yo-Jy; Tue, 04 Jul 2023 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qGaKA-0002y8-Sw
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:19:46 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qGaK7-0007Ds-TL
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:19:46 -0400
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0WLC-1q4Ile0nbQ-00wUnL; Tue, 04 Jul 2023 09:19:34 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, eric.auger@redhat.com, Peter Xu <peterx@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, mst@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, peter.maydell@linaro.org,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 0/1] vhost-vdpa: skip TPM CRB memory section
Date: Tue,  4 Jul 2023 09:19:30 +0200
Message-ID: <20230704071931.575888-1-lvivier@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HWWUJBk9tc2ek2KaPo3tVUKO78gCItz/IwapJw6yMKZNuLOGuna
 U7zU+uNv97DywNgWG8jFKmkGWgJxjTPs7METwH5oGU/Qlq4GTvBcfxNy3TLt+TmYS4M+0tS
 X9px9BbixutEBr7fs2w8ZEq6s9PATu0aOqYt7mhCe99EOwzSL6Ou4utj7Xve7hYAzkHHETC
 xryj6dnwLQCRIk1ZKldaA==
UI-OutboundReport: notjunk:1;M01:P0:GlZIR3cJ3sk=;bUrRB9pBqZTsAyPWBjh6xOhJ2oC
 NW9owWi9ZQgTsrCuoif+L6Impph0L4Y2J4pY3lsW7ZLcqgrAGrJicYf7C0Omb5q3sKgqoh4Ru
 FwdSCMxtHMjCJUdOXJNHvURmNL/Y8/Ab3tUOEXmhPtLflZCt2PRFLoR/vvztxPODKTiJ0PJER
 fLrZpoV1mE5689JC2iWsDDeanlW2epPiZRhNX861T/ocQ5jLSXbtUCA7FAm9J5hwYlAvrJ/Rj
 6Xa1Ec8CaG2tsEIyAbvZWqJdZIzMq2drmYpRToZ63INrIWV/FNjsL+nijksNOA5FRF2pYsp1q
 fiuWYq0/nfDjzgKKDltDMlk8loWfcRnC5SO42NWFSTeLGaIxdk3MPM7/QciFh4LH1/6yFR8AI
 paCgESCFIQ5iDKXVcbUqzVs4G6fy6XKetn7i8Wia7wKSB+qWO3FLYAwOwwZrmd4jzeES2qsPN
 dyQv4YEKt5gv+uey17X2vXpqJUD9emXNojcvTo1kHg19p/hufLCAVj8dPspWhZ4fPMqtka/UQ
 0Ey3yNwzSjtoVpWOyKvnC9rd5B2XlU45rkGcrCT9K2QmkeGUBPpy2tW6DKTtpDXMkPNlkkXBy
 JqxA+aamUWEXZnsxhBjehe0WpCweDzFbqpxD2tC5TKZVOB4ORFJFLfrnhCCKK7SgOYuO5Z56W
 5t6cL6+N9VC93skJ8MMy2rcjjsbnHm3w5JaP7+nS/Q==
Received-SPF: permerror client-ip=217.72.192.74;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_FAIL=0.001,
 SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

An error is reported for vhost-vdpa case:=0D
qemu-kvm: vhost_vdpa_listener_region_add received unaligned region=0D
=0D
Marc-Andr=C3=A9 has proposed a fix to this problem by skipping=0D
the memory region owned by the TPM CRB but it seems more generic=0D
to skip not aligned memory.=0D
=0D
v1 of this series proposed to set the RAM_PROTECTED flag for the=0D
TPM CRB memory region.=0D
=0D
v2:=0D
  - do not introduce special case for TPM CRB=0D
  - do not set RAM_PROTECTED flag for TPM CRB=0D
  - remove error_report() and replace it with a trace=0D
=0D
For the previous discussions, see=0D
=0D
https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03670.html=0D
=0D
and from Eric for VFIO:=0D
=0D
https://lore.kernel.org/all/20220506132510.1847942-1-eric.auger@redhat.com/=
=0D
https://lore.kernel.org/all/20220524091405.416256-1-eric.auger@redhat.com/=
=0D
=0D
Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D2141965=0D
=0D
Thanks,=0D
Laurent=0D
=0D
Laurent Vivier (1):=0D
  vhost-vdpa: mute unaligned memory error report=0D
=0D
 hw/virtio/trace-events | 2 ++=0D
 hw/virtio/vhost-vdpa.c | 8 ++++++--=0D
 2 files changed, 8 insertions(+), 2 deletions(-)=0D
=0D
-- =0D
2.41.0=0D
=0D

