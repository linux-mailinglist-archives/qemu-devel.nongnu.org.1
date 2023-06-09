Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0117290F6
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7WXg-0005uT-Hp; Fri, 09 Jun 2023 03:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q7WXd-0005se-Vy
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:28:14 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q7WXc-0003FB-AE
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:28:13 -0400
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MG9Pg-1qO2n32bmO-00Gcju; Fri, 09 Jun 2023 09:27:49 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 0/3] net: socket: do not close file descriptor if it's not a
 socket
Date: Fri,  9 Jun 2023 09:27:45 +0200
Message-Id: <20230609072748.4179873-1-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z7LUGgFK7iVV3DR48Aqr3u91uglL/618/zJ2SDTRqXVJZ2LueYm
 22vll6WonoO8uABTu+mWgVOluIOh8Y0rfCXqVjJGBiKdEocyKisS/btyYmBFskkReC3Bmri
 44dro2xrUGH8nUWbJ/zaiK9eQC/MkWsFOqX0hArKa3rnRxRBHB87MOc8E4MbkVYhznUroVx
 vw93+oPDKGEc/6WqA/ofw==
UI-OutboundReport: notjunk:1;M01:P0:NJNDcdeCNkM=;LOMzWbabnE6EiIH6zoswWrLWogm
 QUNf/ry5SJaPfVPhMYcHeDx85RNFitf4YA03zYZp5oEf838GKAyk5bBwJWJcHiKNaqTEbdPtE
 fnUcYtYYtR7WZhDyp2U9fKCEVxBJDy/Xif7Ro4TcsGsZxkuZDKYzut4S/hAmKIzkR9QC+IfWX
 Yso0mVlUWCo/dSpAAWo9fnzh/KojTOvmITu9Px3XO6mJoXvEGX8xi2NnfcAGXz1CqBabQePtl
 4Sf0j5keC/G3HWeuGQmGb9ebGz9q5qPm8mqWLC0lxPk1wKk0UcgV5YJbBg576kQdOtL+J7YDc
 lFg60pFcIYTpCXfCHLRIbHLo8buP3NitcBtGN2+MmhxP8KmW4cmlnCJ9OoCF09vQDf/zLrdWM
 efARy2Rye0lYpjuN0CqVg8Pw1eW4CTU6ygY6p/UamBUxg5gAB3aqhqt7tdGod+uKHxZhdPmtL
 pqxVhORvgRmmBEj6YtB147yHQCDkL3JdKyrmpXxaFTv2ao4d+vo5K1fQAmyUllyrAvmjMm5nj
 ceOcknf+BEy955sUx9Udm14ewgRKS3vE4f5Y/z9W0ughKR8ra++9UVR5g77S/k72MNaQlvliI
 7NobL9+1bcvehM+vYvo1cSCV4XYusRsQUUicBlcWfhQ0rAnB1R+dyICcoh14J5R5NabdRnMxC
 YSYP9ufVk1Ds3dptiqMjbZjZkX/wZpZczG/pxXQJvg==
Received-SPF: permerror client-ip=212.227.126.134;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_FAIL=0.001,
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

The socket netdev with a file descriptor (fd) cannot be removed=0D
and then added again because the fd is closed when the backend is=0D
removed and thus is not available anymore when we want to add the=0D
backend again.=0D
=0D
But this can bring to a core dump:=0D
1- boot a VM with an fd socket netdev=0D
2- remove the netdev=0D
3- reboot=0D
4- add the netdev again, it fails because the fd is not a=0D
   socket, and then closed=0D
5- stop QEMU -> core dump=0D
=0D
On reboot (step 3) the fd is allocated to another use in QEMU, and when=0D
we try to use it with a socket netdev, it fails. But the netdev backend=0D
closes the file descriptor that is in use by another part of QEMU.=0D
We can see the core dump on QEMU exit because it tries to close=0D
an invalid file descriptor.=0D
=0D
It happens for instance when we have a PCI device and the fd is allocated=0D
to a VirtIOIRQFD on reboot.=0D
=0D
Moreover, using "netdev socket,fd=3DX" allows an user to close any QEMU=0D
internal file descriptor from an HMP or QMP interface.=0D
=0D
Laurent Vivier (3):=0D
  net: socket: prepare to cleanup net_init_socket()=0D
  net: socket: move fd type checking to its own function=0D
  net: socket: remove net_init_socket()=0D
=0D
 net/socket.c | 53 +++++++++++++++++++++++++++-------------------------=0D
 1 file changed, 28 insertions(+), 25 deletions(-)=0D
=0D
-- =0D
2.39.2=0D
=0D

