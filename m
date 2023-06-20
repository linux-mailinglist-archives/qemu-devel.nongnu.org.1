Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA1737565
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhOD-0000cq-Mk; Tue, 20 Jun 2023 15:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qBhO8-0000C8-FJ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:51:40 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qBhO2-0002ks-Kd
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:51:36 -0400
Received: from lenovo-t14s ([37.171.229.63]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MbjBo-1pfOpj2WPG-00dIAw; Tue, 20 Jun 2023 21:50:58 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 eric.auger@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 0/2] vhost-vdpa: skip TPM CRB memory section
Date: Tue, 20 Jun 2023 21:50:52 +0200
Message-ID: <20230620195054.23929-1-lvivier@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2isbiNmmuOsyLH8ff9LWWCE1YNBWQC0k4MEulQcEizl6TWAFnEU
 7dbA/8MvwCPxrv21L5hUXW1HkTq1hBRt0n/DF7mdjCrj4gwB/GaEmp6kMwdD2eOFCWBiCl1
 BJI/O+wEY1L3MXYEw8Uo9piYCDpwQffL/ZYMI88N8pT9fc8aEk+Zz+AuwYi18hkKHvSqLSz
 7WsHVAVwTb5DcnVCxa1Cg==
UI-OutboundReport: notjunk:1;M01:P0:IcPsdrjQouU=;2KKWZ1S1Q3y8yQku6QtbEoNxs7J
 za4rp5811a8wpeI2y6dANtAUjZyqMuXdBNpezQRLbDEiHdTFgmuww1oXTJpAMLm2M2MH5cZf6
 jvMl64NPqE8x9794JP5l804MOom/zpsNtkDDAW2UMhC5ga3qJhABTyCyNO9JhCHE60ZNejOcb
 104EZf6tdseod251CaHyk98qa8Td/7x6AZYRjWBPaDtNNHvArF0jaMPU4CdOsN/OrN5rlkcUT
 lyJ8BjJfDcctbzQm5Wgqg78Kv5DgCQh2tBCRrQeyOp51+B4WrBaMdjY/QjDpMkq5uailrYpsC
 VZgzp0PCljizQK0QJxXQoOpyKa3m+1Cn2wMkS62XnR86z+uCaZQEjAjlQhP/wxEur72sHUKMG
 vQRKA/khBcGlUbxsi6Vv3pCgd6BAucLvHT58HyzIRO2pt7/WXhyLp3ppmqh70He6Z8LY8uOLo
 wD5yqa+CcPz4UNa4EjwqL5ZJ0ADyNhZ2yWPMyby85SSmJwVT9huLBnQn9dRe3Kd4azNEdonxJ
 9Mpy9HnQ5L5SkhcIuy01ONh5iQL+6bmMWzQxcDyTKBUvJYJW6DtSWM3MJMeRxu7CekuA5DmA5
 2FaEW1tCOQlAUiuuw6D9iI79ADOoOdyo4yqNRx5GignKR5tjWwyvqalVR/8663mPEbisA1HZB
 IHfO91CAwmkefBwR8wu5HMuQpZxxTRpwv6qbkpcHIA==
Received-SPF: permerror client-ip=212.227.17.24;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_FAIL=0.001,
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
to skip not DMA-able memory.=0D
=0D
We have a memory flag for that, RAM_PROTECTED.=0D
=0D
This series expands the memory API to provide a way to initialize=0D
a "protected" memory region and use it with the TPM CRB object.=0D
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
Laurent Vivier (2):=0D
  memory: introduce memory_region_init_ram_protected()=0D
  tpm_crb: mark memory as protected=0D
=0D
 hw/tpm/tpm_crb.c      |  2 +-=0D
 include/exec/memory.h | 33 +++++++++++++++++++++++++++++++++=0D
 softmmu/memory.c      | 33 +++++++++++++++++++++++++++------=0D
 softmmu/physmem.c     |  4 ++--=0D
 4 files changed, 63 insertions(+), 9 deletions(-)=0D
=0D
-- =0D
2.41.0=0D
=0D

