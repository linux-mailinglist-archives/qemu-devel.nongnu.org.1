Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAF7743574
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF86f-0004oi-9E; Fri, 30 Jun 2023 02:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF86c-0004oV-Rc
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF86a-0001uL-Ux
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688108383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tu4N3WLuJzn1e2o0CMh/z9ZpG2oGCHrbdvqdGYGRSl8=;
 b=gT4ijwRrZaSKHz8TO8MiMVzg3oPDwRsuJsILviRSa/Wci4Cj/zuY+dECODTKwFM9vHBk0R
 q2BIZGG03xhxCaqczLH4Pzw2mPWZ+zMC3dPaoAPKbczpHlY8Xrc8If3Szt9FJFNUDcddd2
 9aRPhma63Z54WsjHBs8QnG8EIeWATCE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-0JbN4baSPEKaj1wB-NUsgA-1; Fri, 30 Jun 2023 02:59:42 -0400
X-MC-Unique: 0JbN4baSPEKaj1wB-NUsgA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b69b3ca25fso14388021fa.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 23:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688108381; x=1690700381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tu4N3WLuJzn1e2o0CMh/z9ZpG2oGCHrbdvqdGYGRSl8=;
 b=eqZyflt/mJLDiA2KsP7kGcNLQjCuK+l0sFDMf53o5+4Y8s0TJC09DX07Qwu/hOC9YI
 8vkc1+WJKvF0KlHbWLqSMBcb0ErjPEHZlVj8tafxBpaYhy7jfcsP8vRKpPncS8nj36fn
 e67kz0f7vZjMc1Ip2KlkNz4bPuYw7JWr/Pya90tQyFF1WxVRyoT1c6RkTgPL5FgqeGVk
 OZXz/K/1tmv0ypOC/sBqVlhJWc0E+dO+H3gFyvBHCmtUfI1y7IUiNV3IMH/2fjbn0/UM
 eGZccG/KoVMrf71DTYfiQw84u1qmfC4NJ/N6HX/mrPAXsL4uMbbG6pnWPmnhvli2Qbyz
 h4Cw==
X-Gm-Message-State: ABy/qLYCefSd+aV4tRNIH7KLUNjrPsgAsTQ5wUAV+Co1eag/LH8DF38X
 MTYdS0lQ3TfSy+q7NFW+ayBtXJ5eA6x41C1LWxCpYa8+Mj1Z6Ly58lAl8xMMunf2BDHXunSucQN
 rMfOTwBFRCqS1GOasyiy2iBV+q4vreac=
X-Received: by 2002:a2e:8559:0:b0:2b2:1373:2377 with SMTP id
 u25-20020a2e8559000000b002b213732377mr1349274ljj.35.1688108380835; 
 Thu, 29 Jun 2023 23:59:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEHC1g6hIguB6XXJC6L44lP38wby86G3h2znYZVDcYuMdPwYdnrDC9NqaCTT0KhOUtPCiwG0InhqmSAgJhYh9U=
X-Received: by 2002:a2e:8559:0:b0:2b2:1373:2377 with SMTP id
 u25-20020a2e8559000000b002b213732377mr1349257ljj.35.1688108380443; Thu, 29
 Jun 2023 23:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230614221026.56950-1-andrew@daynix.com>
In-Reply-To: <20230614221026.56950-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jun 2023 14:59:29 +0800
Message-ID: <CACGkMEvaMZBT92kk_xL-MXcwzUC2YFsAkz5wv8WwV2pJqxn-CQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] eBPF RSS through QMP support.
To: Andrew Melnychenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 15, 2023 at 6:29=E2=80=AFAM Andrew Melnychenko <andrew@daynix.c=
om> wrote:
>
> This series of patches provides the ability to retrieve eBPF program
> through qmp, so management application may load bpf blob with proper capa=
bilities.
> Now, virtio-net devices can accept eBPF programs and maps through propert=
ies
> as external file descriptors. Access to the eBPF map is direct through mm=
ap()
> call, so it should not require additional capabilities to bpf* calls.
> eBPF file descriptors can be passed to QEMU from parent process or by uni=
x
> socket with sendfd() qmp command.
>
> Possible solution for libvirt may look like this: https://github.com/dayn=
ix/libvirt/tree/RSS_eBPF (WIP)

I got a build failure:

[18/2192] Compiling C object
libqemuutil.a.p/meson-generated_.._qapi_qapi-commands-ebpf.c.o
FAILED: libqemuutil.a.p/meson-generated_.._qapi_qapi-commands-ebpf.c.o
cc -m64 -mcx16 -Ilibqemuutil.a.p -I. -I.. -Isubprojects/libvhost-user
-I../subprojects/libvhost-user -Iqapi -Itrace -Iui -Iui/shader
-I/usr/include/libmount -I/usr/include/blkid -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include
-I/usr/include/gio-unix-2.0 -I/usr/include/pixman-1
-fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g
-fstack-protector-strong -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -Wundef
-Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes
-Wredundant-decls -Wold-style-declaration -Wold-style-definition
-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels
-Wexpansion-to-defined -Wimplicit-fallthrough=3D2
-Wmissing-format-attribute -Wno-missing-include-dirs
-Wno-shift-negative-value -Wno-psabi -isystem
/home/devel/git/qemu/linux-headers -isystem linux-headers -iquote .
-iquote /home/devel/git/qemu -iquote /home/devel/git/qemu/include
-iquote /home/devel/git/qemu/host/include/x86_64 -iquote
/home/devel/git/qemu/host/include/generic -iquote
/home/devel/git/qemu/tcg/i386 -pthread -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
-fno-common -fwrapv -fPIE -MD -MQ
libqemuutil.a.p/meson-generated_.._qapi_qapi-commands-ebpf.c.o -MF
libqemuutil.a.p/meson-generated_.._qapi_qapi-commands-ebpf.c.o.d -o
libqemuutil.a.p/meson-generated_.._qapi_qapi-commands-ebpf.c.o -c
qapi/qapi-commands-ebpf.c
qapi/qapi-commands-ebpf.c:24:13: error:
=E2=80=98qmp_marshal_output_EbpfObject=E2=80=99 defined but not used
[-Werror=3Dunused-function]
   24 | static void qmp_marshal_output_EbpfObject(EbpfObject *ret_in,
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Please fix this.

Thanks

>
> Changes since v2:
>  * moved/refactored QMP command
>  * refactored virtio-net
>
> Changes since v1:
>  * refactored virtio-net
>  * moved hunks for ebpf mmap()
>  * added qmp enum for eBPF id.
>
> Andrew Melnychenko (6):
>   ebpf: Added eBPF map update through mmap.
>   ebpf: Added eBPF initialization by fds.
>   virtio-net: Added property to load eBPF RSS with fds.
>   ebpf: Added declaration/initialization routines.
>   qmp: Added new command to retrieve eBPF blob.
>   ebpf: Updated eBPF program and skeleton.
>
>  ebpf/ebpf.c                    |   70 ++
>  ebpf/ebpf.h                    |   31 +
>  ebpf/ebpf_rss-stub.c           |    6 +
>  ebpf/ebpf_rss.c                |  150 +++-
>  ebpf/ebpf_rss.h                |   10 +
>  ebpf/meson.build               |    2 +-
>  ebpf/rss.bpf.skeleton.h        | 1469 ++++++++++++++++----------------
>  hw/net/virtio-net.c            |   55 +-
>  include/hw/virtio/virtio-net.h |    1 +
>  qapi/ebpf.json                 |   55 ++
>  qapi/meson.build               |    1 +
>  qapi/qapi-schema.json          |    1 +
>  tools/ebpf/rss.bpf.c           |    2 +-
>  13 files changed, 1093 insertions(+), 760 deletions(-)
>  create mode 100644 ebpf/ebpf.c
>  create mode 100644 ebpf/ebpf.h
>  create mode 100644 qapi/ebpf.json
>
> --
> 2.39.1
>


