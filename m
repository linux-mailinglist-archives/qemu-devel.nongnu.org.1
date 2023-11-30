Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B54777FE7A0
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 04:25:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Xeo-0004mN-Ca; Wed, 29 Nov 2023 22:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1r8Xem-0004m9-Je
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 22:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1r8Xek-0002BS-Pz
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 22:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701314641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OgRb3kczbRiGqvP8QcGwU5NSzqTyU5pFybm+y6ESZ90=;
 b=bz/OWlTFrypdFJuzO0tJHznFF215hRMA5ngQPeHtkE7T6K8DBwOD+sSE6Gb81BcIcG/028
 iPa8y3cWcTOUghaOLIY2CNCp/1ouRBZ9UQHETVZfDwblvciCqc9tL3mI+h6je0DjlVTkh+
 0Vbzd+qx4kXheE3S2WzzOmQFFqmb62o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-044O8PUjM-2qyTgMkF70Xg-1; Wed, 29 Nov 2023 22:22:24 -0500
X-MC-Unique: 044O8PUjM-2qyTgMkF70Xg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a15ce298cf4so40165366b.1
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 19:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701314543; x=1701919343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OgRb3kczbRiGqvP8QcGwU5NSzqTyU5pFybm+y6ESZ90=;
 b=nH2RMJpFFUo4FyO5k9ygHPVoi4yMkq33uyxCwX1YOt59tYbcEYIElx39Gjm6UyHCGb
 lxaHwumjFajOQmQ99+uSloZqaOp5onfEZQ9YxpxnnAEPsk/Uf+jEdBWRoMetyxH9QWXp
 JqUxLR3AzJvte15nZbj4yFlOC8vtrmG8e5VZypE/g6qPnyfvXmWsKdf7Q/CdLtW0bal0
 lRrO0OvwrBN3cJvVcrA08khHHSh/edi90KySwPV14sipn5GTUNmJyewsafz/l07dINRF
 WPgyDQpaH+0WGehpqgOJGSVQ8xiSTYzRcVUJoSJKMx+p1VIx7OZ+J1lFifrSAXIhlYpo
 EgLQ==
X-Gm-Message-State: AOJu0YyJG2WCqkSTNlOgS1OFi3htL06X6hflyvfDvX9Wb/qPfqLjMdDu
 1vzhKyIKkvUV0zqNsGickMMKxQemglQcELoWuJYL4z1Oylp9pO5ywFtvwekgwBzuVQEMWIX7IQl
 3q7T+12qqGW4GAdF6FuPVx5kSsbfIzBg=
X-Received: by 2002:a17:906:4e:b0:a0d:a567:b92a with SMTP id
 14-20020a170906004e00b00a0da567b92amr9480619ejg.39.1701314543013; 
 Wed, 29 Nov 2023 19:22:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx8ewMvH9nFtE9+pmc12AyHMXptGf07/EoqwN4CbbVmpf8073QMMs7Ufi9bfqzGODW9u+Rqe5mxg9AoTk7Hfg=
X-Received: by 2002:a17:906:4e:b0:a0d:a567:b92a with SMTP id
 14-20020a170906004e00b00a0da567b92amr9480608ejg.39.1701314542608; Wed, 29 Nov
 2023 19:22:22 -0800 (PST)
MIME-Version: 1.0
References: <20231124171430.2964464-1-eperezma@redhat.com>
In-Reply-To: <20231124171430.2964464-1-eperezma@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 30 Nov 2023 11:21:45 +0800
Message-ID: <CAPpAL=zdLeiEdNdBBuB1uJPoEdng-G4biLVzq-qrx9XZCut1fg@mail.gmail.com>
Subject: Re: [PATCH 9.0 00/13] Consolidate common vdpa members in
 VhostVDPAShared
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000f70788060b562846"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000f70788060b562846
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eugenio

QE performed regression testing after applying this patch. This series
patch introduced a qemu core dump bug, for the core dump information
please review the attached file.

Tested-by: Lei Yang <leiyang@redhat.com>




On Sat, Nov 25, 2023 at 1:14=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Current memory operations like pinning may take a lot of time at the
> destination.  Currently they are done after the source of the migration i=
s
> stopped, and before the workload is resumed at the destination.  This is =
a
> period where neigher traffic can flow, nor the VM workload can continue
> (downtime).
>
> We can do better as we know the memory layout of the guest RAM at the
> destination from the moment the migration starts.  Moving that operation =
allows
> QEMU to communicate the kernel the maps while the workload is still runni=
ng in
> the source, so Linux can start mapping them.  Ideally, all IOMMU is confi=
gured,
> but if the vDPA parent driver uses on-chip IOMMU and .set_map we're still
> saving all the pinning time.
>
> This is a first required step to consolidate all the members in a common
> struct.  This is needed because the destination does not know what vhost_=
vdpa
> struct will have the registered listener member, so it is easier to place=
 them
> in a shared struct rather to keep them in vhost_vdpa struct.
>
> v1 from RFC:
> * Fix vhost_vdpa_net_cvq_start checking for always_svq instead of
>   shadow_data.  This could cause CVQ not being shadowed if
>   vhost_vdpa_net_cvq_start was called in the middle of a migration.
>
> Eugenio P=C3=A9rez (13):
>   vdpa: add VhostVDPAShared
>   vdpa: move iova tree to the shared struct
>   vdpa: move iova_range to vhost_vdpa_shared
>   vdpa: move shadow_data to vhost_vdpa_shared
>   vdpa: use vdpa shared for tracing
>   vdpa: move file descriptor to vhost_vdpa_shared
>   vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
>   vdpa: move backend_cap to vhost_vdpa_shared
>   vdpa: remove msg type of vhost_vdpa
>   vdpa: move iommu_list to vhost_vdpa_shared
>   vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
>   vdpa: use dev_shared in vdpa_iommu
>   vdpa: move memory listener to vhost_vdpa_shared
>
>  include/hw/virtio/vhost-vdpa.h |  36 +++++---
>  hw/virtio/vdpa-dev.c           |   7 +-
>  hw/virtio/vhost-vdpa.c         | 160 +++++++++++++++++----------------
>  net/vhost-vdpa.c               | 117 ++++++++++++------------
>  hw/virtio/trace-events         |  14 +--
>  5 files changed, 174 insertions(+), 160 deletions(-)
>
> --
> 2.39.3
>
>

--000000000000f70788060b562846
Content-Type: application/octet-stream; name=core_dump_info
Content-Disposition: attachment; filename=core_dump_info
Content-Transfer-Encoding: base64
Content-ID: <f_lpkmoqsw0>
X-Attachment-Id: f_lpkmoqsw0

KGdkYikgYnQgZnVsbAojMCAgbWVtb3J5X2xpc3RlbmVyX3VucmVnaXN0ZXIgKGxpc3RlbmVyPTB4
NTVhMWVkN2UyZDk4KSBhdCAuLi9zeXN0ZW0vbWVtb3J5LmM6MzEyMwojMSAgMHgwMDAwNTVhMWU4
YWU1ZWJhIGluIHZob3N0X3ZkcGFfY2xlYW51cCAoZGV2PTB4NTVhMWViZTYwNDcwKSBhdCAuLi9o
dy92aXJ0aW8vdmhvc3QtdmRwYS5jOjc1MQogICAgICAgIHYgPSAweDU1YTFlY2ZkN2Y5MAogICAg
ICAgIF9fUFJFVFRZX0ZVTkNUSU9OX18gPSAidmhvc3RfdmRwYV9jbGVhbnVwIgojMiAgMHgwMDAw
NTVhMWU4YWRkZjdiIGluIHZob3N0X2Rldl9jbGVhbnVwIChoZGV2PTB4NTVhMWViZTYwNDcwKSBh
dCAuLi9ody92aXJ0aW8vdmhvc3QuYzoxNjAzCiAgICAgICAgaSA9IDEKICAgICAgICBfX1BSRVRU
WV9GVU5DVElPTl9fID0gInZob3N0X2Rldl9jbGVhbnVwIgojMyAgMHgwMDAwNTVhMWU4OWI3ZDI2
IGluIHZob3N0X25ldF9jbGVhbnVwIChuZXQ9MHg1NWExZWJlNjA0NzApIGF0IC4uL2h3L25ldC92
aG9zdF9uZXQuYzo0NjkKIzQgIDB4MDAwMDU1YTFlOGI5Nzk3NiBpbiB2aG9zdF92ZHBhX2NsZWFu
dXAgKG5jPTB4NTVhMWVjZmQ3ZTEwKSBhdCAuLi9uZXQvdmhvc3QtdmRwYS5jOjIzNQogICAgICAg
IHMgPSAweDU1YTFlY2ZkN2UxMAojNSAgMHgwMDAwNTVhMWU4YjgyYWFiIGluIHFlbXVfY2xlYW51
cF9uZXRfY2xpZW50IChuYz0weDU1YTFlY2ZkN2UxMCkgYXQgLi4vbmV0L25ldC5jOjM4MwojNiAg
MHgwMDAwNTVhMWU4YjgyZDdiIGluIHFlbXVfZGVsX25ldF9jbGllbnQgKG5jPTB4NTVhMWVkNTJl
MjYwKSBhdCAuLi9uZXQvbmV0LmM6NDQ2CiAgICAgICAgbmNzID0gCiAgICAgICAgICB7MHg1NWEx
ZWQ1MmUyNjAsIDB4NTVhMWVjZmQ3ZTEwLCAweDIwMDAwMDAwMiwgMHg1NWExZWQ1ZThiMTgsIDB4
NTVhMWVkNWU4YjE4LCAweDU1YTFlZDVlOGM5MCwgMHgwIDxyZXBlYXRzIDQ1IHRpbWVzPiwgMHg3
ZjMyZTg3NGY0NWYgPF9fbGliY19jb25uZWN0Kzk1PiwgMHg3ZmZkZjdkNzAxMzAsIDB4NmVmZmZm
ZmZmZiwgMHgwLCAweDdmMzJlODc5Mjc0ZSA8b3Blbl9zb2NrZXQrNjA2PiwgMHgwLCAweDAsIDB4
MCwgMHg3ZjMyZTg3OTI1MzAgPG9wZW5fc29ja2V0KzY0PiwgMHgwLCAweGQsIDB4MCwgMHgwLCAw
eDAsIDB4MCwgMHg3MjJmNzI2MTc2MmYwMDAxLCAweDJmNjQ2MzczNmUyZjZlNzUsIDB4NzQ2NTZi
NjM2ZjczLCAweDAgPHJlcGVhdHMgMTIgdGltZXM+LCAweDU3MTQ4NGQ2N2E3ODdiMDAsIDB4MCwg
MHhmZmZmZmZmZmZmZmZmYjA4LCAweGQsIDB4NSwgMHg3ZjMyZTg3YmJkYTgsIDB4ZmZmZmZmZmZm
ZmZmZmZmZiwgMHg3ZmZkZjdkNzAzYTAsIDB4N2YzMmU4NzkyYjFkIDxfX25zY2RfZ2V0X21hcHBp
bmcrMTg5PiwgMHgwLCAweDdmMzJlODc5MmE5YyA8X19uc2NkX2dldF9tYXBwaW5nKzYwPiwgMHgw
LCAweDAsIDB4N2ZmZGY3ZDcwMWYwLCAweDdmMzJlODgwZGQ2OCA8X19oc3RfbWFwX2hhbmRsZSs4
PiwgMHgyMDAwMDAwMDAsIDB4NiwgMHgwIDxyZXBlYXRzIDExIHRpbWVzPiwgMHg3ZjMyZTg2YWUz
YjAgPG1hbGxvY19jb25zb2xpZGF0ZSszNjg+LCAweDAsIDB4N2YzMmU4N2ZmY2UwIDxtYWluX2Fy
ZW5hKzk2PiwgMHgwLCAweDAsIDB4MCwgMHgwLCAweDAsIDB4NjIwLCAweDYxOCwgMHg2MiwgMHg2
MTgsIDB4NmUsIDB4N2MsIDB4N2YzMmU4NmIwYTgxIDxfaW50X21hbGxvYyszMjgxPiwgMHg3ZjMy
ZTg3ZmZjODAgPG1haW5fYXJlbmE+LCAweDYwLCAweDAsIDB4NywgMHg2MTgsIDB4NzEwN2QzMGU1
Yjg3M2UwMSwgMHg0OCwgMHg3MCwgMHg2NDAsIDB4MTgsIDB4NDgwMDAwMDA2MiwgMHgwLCAweDAs
IDB4NTcxNDg0ZDY3YTc4N2IwMCwgMHg3NzAwMDAwMDdjLCAweDAsIDB4MCwgMHg3ZmZkZjdkNzE0
YTAsIDB4ZiwgMHg1NWExZWMzNzUwYTAsIDB4N2ZmZGY3ZDcxNTMwLCAweDdmMzJlODc5MDljNiA8
X19uc2NkX2dldF9ubF90aW1lc3RhbXArMjE0PiwgMHgxNmNhLCAweDU3MTQ4NGQ2N2E3ODdiMDAs
IDB4N2ZmZGY3ZDcxNTMwLCAweDU3MTQ4NGQ2N2E3ODdiMDAsIDB4MTQsIDB4N2ZmZGY3ZDcxNTMw
LCAweDAsIDB4N2YzMmU4NzZhM2EzIDxfX2NoZWNrX3BmKzE1MjM+LCAweDIwMDAzMDAwMDAwMTQs
IDB4MTZjYTY1NjdmMjcyLCAweDEwMDAwMDAwMCwgMHgxMDAxNCwgMHgwLCAweDYwMDE0MDEwMDAw
MDAsIDB4ZmZmZmZmZmZmZmZmZmZmZiwgMHgyOTEwMDAwMDI5MSwgMHg4MDAwMDgwMDA4LCAweDIw
MDE0MDAwMDAwNDgsIDB4MTZjYTY1NjdmMjcyLCAweDYwMDAwNDAwYSwgMHg1MjAwMjAyNjAwMDEw
MDE0LCAweDEwYmZlNTg3ODg0ODAwMDAsIDB4NjAwMTQzNTQ5MjgxMiwgMHgyNzhjZGIwMDA5M2E1
YiwgMHgzYjZkNzAwMDAwYTg5LCAweDIwMDAwMDgwMDA4LCAweDIwMDE0MDAwMDAwNDgsIDB4MTZj
YTY1NjdmMjcyLCAweDZmZDgwNDAwYSwgMHg4MGZlMDAwMTAwMTQsIDB4MWVhZmJhOWEwMDAwMDAw
MCwgMHg2MDAxNDJmZGRhYzkxLCAweGZmZmZmZmZmZmZmZmZmZmYsIDB4OWZmMDAwMDA5ZmYsIDB4
MjgwMDAwODAwMDgsIDB4MjAwMTQwMDAwMDA0OCwgMHgxNmNhNjU2N2YyNzIsIDB4MTZmZDgwNDAw
YSwgMHg4MGZlMDAwMTAwMTQsIDB4ZmZmNmNlYmEwMDAwMDAwMCwgMHg2MDAxNGYwMTEwYWZlLCAw
eGZmZmZmZmZmZmZmZmZmZmYsIDB4ZGE5MDAwMDBkYTkwLCAweDgwMDAwODAwMDgsIDB4MCA8cmVw
ZWF0cyA4MyB0aW1lcz4sIDB4N2YzMmU4NmIwYTgxIDxfaW50X21hbGxvYyszMjgxPiwgMHg3ZjMy
ZTg3ZmZjODAgPG1haW5fYXJlbmE+LCAweDEzZiwgMHgwLCAweDcsIDB4MTQwMSwgMHg3MTA3ZDMw
ZTViODczZTAxLCAweDY1LCAweDdmMzJlODZhZjNiZSA8X2ludF9mcmVlKzIwMzA+LCAweDE0MzAs
IDB4NTAsIDB4ODAwMDAwMDE0MSwgMHgxMDAwMDAwMDAsIDB4MSwgMHhhLCAweDc3MDAwMDAwN2Ms
IDB4NTcxNDg0ZDY3YTc4N2IwMCwgMHgwLCAweDE3YjAsIDB4YTAsIDB4MCwgMHg4MWEwMDAwMCwg
MHgwLCAweGEwLCAweDAsIDB4ODFhMDAwMDAsIDB4MCwgMHg4MWEwMDEwMCwgMHg3ZmZkZjdkNzBh
YjAsIDB4ODFhMDAwMDAsIDB4MCwgMHg4MWEwMDBhMCwgMHgwLCAweDdmZmRmN2Q3MDkyMCwgMHg1
NWExZThkM2NkNDIgPGFkZHJyYW5nZV9pbnRlcnNlY3Rpb24rMjI2PiwgMHg3ZmZkZjdkNzA4ZTAs
IDB4N2ZmZGY3ZDcwYWIwLCAweDgxYTAwMDAwLi4ufQogICAgICAgIHF1ZXVlcyA9IDIKICAgICAg
ICBpID0gMQogICAgICAgIG5mID0gMHgwCiAgICAgICAgbmV4dCA9IDB4N2ZmZGY3ZDcxZjg4CiAg
ICAgICAgX19QUkVUVFlfRlVOQ1RJT05fXyA9ICJxZW11X2RlbF9uZXRfY2xpZW50IgojNyAgMHgw
MDAwNTVhMWU4Yjg0YTlmIGluIHFtcF9uZXRkZXZfZGVsIChpZD0weDU1YTFlZDE4Yzc3MCAiaWRx
VDBoaWEiLCBlcnJwPTB4N2ZmZGY3ZDcxZjk4KSBhdCAuLi9uZXQvbmV0LmM6MTMyNQogICAgICAg
IG5jID0gMHg1NWExZWQ1MmUyNjAKICAgICAgICBvcHRzID0gMHg1NWExZWMyZGMwMjAKICAgICAg
ICBfX2Z1bmNfXyA9ICJxbXBfbmV0ZGV2X2RlbCIKIzggIDB4MDAwMDU1YTFlOGY1ZDdiOCBpbiBx
bXBfbWFyc2hhbF9uZXRkZXZfZGVsIChhcmdzPTB4N2YzMmRjMDA1OGYwLCByZXQ9MHg3ZjMyZTdj
MzRkOTgsIGVycnA9MHg3ZjMyZTdjMzRkOTApIGF0IHFhcGkvcWFwaS1jb21tYW5kcy1uZXQuYzox
MzUKICAgICAgICBlcnIgPSAweDAKICAgICAgICBvayA9IHRydWUKICAgICAgICB2ID0gMHg1NWEx
ZWMyZGMwMjAKICAgICAgICBhcmcgPSB7aWQgPSAweDU1YTFlZDE4Yzc3MCAiaWRxVDBoaWEifQoj
OSAgMHgwMDAwNTVhMWU4ZjliMjQxIGluIGRvX3FtcF9kaXNwYXRjaF9iaCAob3BhcXVlPTB4N2Yz
MmU3YzM0ZTMwKSBhdCAuLi9xYXBpL3FtcC1kaXNwYXRjaC5jOjEyOAogICAgICAgIGRhdGEgPSAw
eDdmMzJlN2MzNGUzMAogICAgICAgIF9fUFJFVFRZX0ZVTkNUSU9OX18gPSAiZG9fcW1wX2Rpc3Bh
dGNoX2JoIgojMTAgMHgwMDAwNTVhMWU4ZmM1OGU5IGluIGFpb19iaF9jYWxsIChiaD0weDdmMzJk
YzAwNDE1MCkgYXQgLi4vdXRpbC9hc3luYy5jOjE2OQogICAgICAgIGxhc3RfZW5nYWdlZF9pbl9p
byA9IGZhbHNlCiAgICAgICAgcmVlbnRyYW5jeV9ndWFyZCA9IDB4MAojMTEgMHgwMDAwNTVhMWU4
ZmM1YTA0IGluIGFpb19iaF9wb2xsIChjdHg9MHg1NWExZWJlZDZmYjApIGF0IC4uL3V0aWwvYXN5
bmMuYzoyMTYKICAgICAgICBiaCA9IDB4N2YzMmRjMDA0MTUwCiAgICAgICAgZmxhZ3MgPSAxMQog
ICAgICAgIHNsaWNlID0ge2JoX2xpc3QgPSB7c2xoX2ZpcnN0ID0gMHgwfSwgbmV4dCA9IHtzcWVf
bmV4dCA9IDB4MH19CiAgICAgICAgcyA9IDB4N2ZmZGY3ZDcyMDkwCiAgICAgICAgcmV0ID0gMQoj
MTIgMHgwMDAwNTVhMWU4ZmE4NWFmIGluIGFpb19kaXNwYXRjaCAoY3R4PTB4NTVhMWViZWQ2ZmIw
KSBhdCAuLi91dGlsL2Fpby1wb3NpeC5jOjQyMwojMTMgMHgwMDAwNTVhMWU4ZmM1ZTQzIGluIGFp
b19jdHhfZGlzcGF0Y2ggKHNvdXJjZT0weDU1YTFlYmVkNmZiMCwgY2FsbGJhY2s9MHgwLCB1c2Vy
X2RhdGE9MHgwKSBhdCAuLi91dGlsL2FzeW5jLmM6MzU4CiAgICAgICAgY3R4ID0gMHg1NWExZWJl
ZDZmYjAKICAgICAgICBfX1BSRVRUWV9GVU5DVElPTl9fID0gImFpb19jdHhfZGlzcGF0Y2giCiMx
NCAweDAwMDA3ZjMyZThhN2VmNGYgaW4gZ19tYWluX2Rpc3BhdGNoIChjb250ZXh0PTB4NTVhMWVi
ZWQ5NTIwKSBhdCAuLi9nbGliL2dtYWluLmM6MzM2NAogICAgICAgIGRpc3BhdGNoID0gMHg1NWEx
ZThmYzVkZWMgPGFpb19jdHhfZGlzcGF0Y2g+CiAgICAgICAgcHJldl9zb3VyY2UgPSAweDAKICAg
ICAgICBiZWdpbl90aW1lX25zZWMgPSAyNjg3ODM0NDYyNjAwCiAgICAgICAgd2FzX2luX2NhbGwg
PSA8b3B0aW1pemVkIG91dD4KICAgICAgICB1c2VyX2RhdGEgPSAweDAKICAgICAgICBjYWxsYmFj
ayA9IDB4MAogICAgICAgIGNiX2Z1bmNzID0gMHgwCiAgICAgICAgY2JfZGF0YSA9IDB4MAogICAg
ICAgIG5lZWRfZGVzdHJveSA9IDxvcHRpbWl6ZWQgb3V0PgogICAgICAgIHNvdXJjZSA9IDB4NTVh
MWViZWQ2ZmIwCiAgICAgICAgY3VycmVudCA9IDB4NTVhMWVjMzNmZmEwCiAgICAgICAgaSA9IDAK
IzE1IGdfbWFpbl9jb250ZXh0X2Rpc3BhdGNoIChjb250ZXh0PTB4NTVhMWViZWQ5NTIwKSBhdCAu
Li9nbGliL2dtYWluLmM6NDA3OQojMTYgMHgwMDAwNTVhMWU4ZmM3M2FlIGluIGdsaWJfcG9sbGZk
c19wb2xsICgpIGF0IC4uL3V0aWwvbWFpbi1sb29wLmM6MjkwCiAgICAgICAgY29udGV4dCA9IDB4
NTVhMWViZWQ5NTIwCiAgICAgICAgcGZkcyA9IDB4NTVhMWVjM2VjZTAwCiMxNyAweDAwMDA1NWEx
ZThmYzc0MmIgaW4gb3NfaG9zdF9tYWluX2xvb3Bfd2FpdCAodGltZW91dD0wKSBhdCAuLi91dGls
L21haW4tbG9vcC5jOjMxMwogICAgICAgIGNvbnRleHQgPSAweDU1YTFlYmVkOTUyMAogICAgICAg
IHJldCA9IDEKIzE4IDB4MDAwMDU1YTFlOGZjNzUzOSBpbiBtYWluX2xvb3Bfd2FpdCAobm9uYmxv
Y2tpbmc9MCkgYXQgLi4vdXRpbC9tYWluLWxvb3AuYzo1OTIKICAgICAgICBtbHBvbGwgPSB7c3Rh
dGUgPSAwLCB0aW1lb3V0ID0gNDI5NDk2NzI5NSwgcG9sbGZkcyA9IDB4NTVhMWViZWJlODYwfQog
ICAgICAgIHJldCA9IDMyNzY1CiAgICAgICAgdGltZW91dF9ucyA9IDc5ODU0MjE3NAojMTkgMHgw
MDAwNTVhMWU4YjIyZDI3IGluIHFlbXVfbWFpbl9sb29wICgpIGF0IC4uL3N5c3RlbS9ydW5zdGF0
ZS5jOjc4MgogICAgICAgIHN0YXR1cyA9IDAKIzIwIDB4MDAwMDU1YTFlODgxYjcwNiBpbiBxZW11
X2RlZmF1bHRfbWFpbiAoKSBhdCAuLi9zeXN0ZW0vbWFpbi5jOjM3CiAgICAgICAgc3RhdHVzID0g
MAojMjEgMHgwMDAwNTVhMWU4ODFiNzQxIGluIG1haW4gKGFyZ2M9ODQsIGFyZ3Y9MHg3ZmZkZjdk
NzIzYzgpIGF0IC4uL3N5c3RlbS9tYWluLmM6NDgK
--000000000000f70788060b562846--


