Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB93C803DD7
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 19:58:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAE8S-0003M0-C0; Mon, 04 Dec 2023 13:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAE8P-0003LT-8Q
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 13:57:37 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAE8N-0007Uz-9J
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 13:57:37 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b8b0ced0f4so1092306b6e.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 10:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701716254; x=1702321054; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7A+P2VnkIUmQap26NpaLB0r5vKjcZDlrn/xUkO8VP0Y=;
 b=gKsXjzIltaAnQAEqUILr6xLp0EFHz1mntthY79+r3oBq1SR0z7qccju1ZkOaR+rEEq
 LfUDFqvRV5vsK7Eh4cK6Bt3ZvjxA9OgUdk6+VSMu0mSdWdkW/8YIrjUFnviROnJ9fBWJ
 IpbxNUrqnY75qdaxJDAyX8n7frhJOTtfF9GYlfxjgkpdzsV7lGQW/mH9CR1WrKRCBuEK
 ChDJFVa/7oqZLlZSszB7Y9IVu1k2iRPilmVTBAx+3WGPzOwg/GZGvd2tMXcUs9rRWCxS
 rOL6vYX+osLbuqha6EpwO3mw3SHVq2HvRpt1buiN1zAzUCYjTyvMiMP3fkFoZmvJoAe9
 Mo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701716254; x=1702321054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7A+P2VnkIUmQap26NpaLB0r5vKjcZDlrn/xUkO8VP0Y=;
 b=ldbOv1RstE+hZ1xU31e9rJ5EN3gUgEnOplh7Fq/qlrjSnmB0JyooXIyC7bKFuugxzH
 GD1tCS74o+ScZSpAQImdNBrIqHiuANLjsx3nRSGzEQZLBvsYQ95UzI+mVWaSM8nmaOF2
 7nZIKz2g6oFVfTjAwlcRGuTsJwBxcTNr0CYIfk0pLmos7JLwP6SvvW0g35MLK0wBmEvU
 yQTIw3U7WK5QRddNqD82dPnmG1v8CWDQTvOPjG8uVwWuwoR8WQXGpVV83sgQVAslyMWA
 3vMt0pQfU/68SB5wz6Tjr0a35Awe1fZUCuMT2srlCbltpc/6ZzCt8i8AMZzXBtHbn70u
 /yCQ==
X-Gm-Message-State: AOJu0YxUHugbQ9QMXEFojUKW6ajksMRo/XZDfsFp5GVg1idf6Rn2TsO9
 c2kjqWi0+ttKY+HFR5m8V+gOoyhC7qHY/7y8YPs=
X-Google-Smtp-Source: AGHT+IGYyzQNkmTq6w/neIvt3cJAnzrBNGGmGKqX4FFdACvUUaqUTPaFXwvLOQG873Yh+QoAtil7X7u0ZVP3NQScGTM=
X-Received: by 2002:a05:6870:1ec8:b0:1fb:788:e8b4 with SMTP id
 pc8-20020a0568701ec800b001fb0788e8b4mr116372oab.47.1701716253854; Mon, 04 Dec
 2023 10:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20231204183638.GZ9696@kitsune.suse.cz>
In-Reply-To: <20231204183638.GZ9696@kitsune.suse.cz>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 4 Dec 2023 13:57:21 -0500
Message-ID: <CAJSP0QUShqgd18ZFib-EzwWbG1uz4E4pKNXpiTBauQhsDXUiyw@mail.gmail.com>
Subject: Re: qemu ppc64 crash when adding CPU
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, 4 Dec 2023 at 13:37, Michal Such=C3=A1nek <msuchanek@suse.de> wrote=
:
>
> Hello,
>
> When running a VM with libvirt I get:
>
> /usr/bin/qemu-system-ppc64 --version
> QEMU emulator version 8.1.3 (Virtualization / 15.5)
> Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
>
> /usr/bin/qemu-system-ppc64 -name
> guest=3Dsles12sp5-ppc64le,debug-threads=3Don -S -object
> {"qom-type":"secret","id":"masterKey0","format":"raw","file":"/var/lib/li=
bvirt/qemu/domain-11-sles12sp5-ppc64le/master-key.aes"}
> -machine
> pseries-7.1,usb=3Doff,dump-guest-core=3Doff,memory-backend=3Dppc_spapr.ra=
m
> -accel tcg -cpu POWER9 -m 4096 -object
> {"qom-type":"memory-backend-ram","id":"ppc_spapr.ram","size":4294967296}
> -overcommit mem-lock=3Doff -smp 16,sockets=3D1,dies=3D1,cores=3D2,threads=
=3D8
> -uuid a6ad6a7d-125b-4525-b452-241ce2000eda -display none -no-user-config
> -nodefaults -chardev socket,id=3Dcharmonitor,fd=3D29,server=3Don,wait=3Do=
ff -mon
> chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shu=
tdown
> -boot strict=3Don -device
> {"driver":"qemu-xhci","p2":15,"p3":15,"id":"usb","bus":"pci.0","addr":"0x=
3"}
> -device
> {"driver":"virtio-scsi-pci","id":"scsi0","bus":"pci.0","addr":"0x4"}
> -device
> {"driver":"virtio-serial-pci","id":"virtio-serial0","bus":"pci.0","addr":=
"0x2"}
> -blockdev
> {"driver":"file","filename":"/home/hramrach/Downloads/SLE-12-SP5-Server-M=
INI-ISO-ppc64le-GM-DVD.iso","node-name":"libvirt-2-storage","auto-read-only=
":true,"discard":"unmap"}
> -blockdev
> {"node-name":"libvirt-2-format","read-only":true,"driver":"raw","file":"l=
ibvirt-2-storage"}
> -device
> {"driver":"scsi-cd","bus":"scsi0.0","channel":0,"scsi-id":0,"lun":0,"devi=
ce_id":"drive-scsi0-0-0-0","drive":"libvirt-2-format","id":"scsi0-0-0-0","b=
ootindex":2}
> -blockdev
> {"driver":"file","filename":"/var/lib/libvirt/images/sles12sp5-ppc64le.qc=
ow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap=
"}
> -blockdev
> {"node-name":"libvirt-1-format","read-only":false,"discard":"unmap","driv=
er":"qcow2","file":"libvirt-1-storage","backing":null}
> -device
> {"driver":"scsi-hd","bus":"scsi0.0","channel":0,"scsi-id":0,"lun":1,"devi=
ce_id":"drive-scsi0-0-0-1","drive":"libvirt-1-format","id":"scsi0-0-0-1","b=
ootindex":1}
> -netdev {"type":"tap","fd":"30","id":"hostnet0"} -device
> {"driver":"e1000","netdev":"hostnet0","id":"net0","mac":"52:54:00:3b:d5:a=
5","bus":"pci.0","addr":"0x1"}
> -chardev pty,id=3Dcharserial0 -device
> {"driver":"spapr-vty","chardev":"charserial0","id":"serial0","reg":805306=
368}
> -audiodev {"id":"audio1","driver":"none"} -device
> {"driver":"virtio-balloon-pci","id":"balloon0","bus":"pci.0","addr":"0x5"=
}
> -object
> {"qom-type":"rng-random","id":"objrng0","filename":"/dev/urandom"}
> -device
> {"driver":"virtio-rng-pci","rng":"objrng0","id":"rng0","bus":"pci.0","add=
r":"0x6"}
> -sandbox
> on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=
=3Ddeny
> -msg timestamp=3Don
>
> virsh qemu-monitor-command sles12sp5-ppc64le query-hotpluggable-cpus | jq=
 . | cat
> {
>   "return": [
>     {
>       "props": {
>         "core-id": 8,
>         "node-id": 0
>       },
>       "vcpus-count": 8,
>       "qom-path": "/machine/unattached/device[2]",
>       "type": "power9_v2.2-spapr-cpu-core"
>     },
>     {
>       "props": {
>         "core-id": 0,
>         "node-id": 0
>       },
>       "vcpus-count": 8,
>       "qom-path": "/machine/unattached/device[1]",
>       "type": "power9_v2.2-spapr-cpu-core"
>     }
>   ],
>   "id": "libvirt-155"
> }
>
> virsh qemu-monitor-command sles12sp5-ppc64le device_del '"id":"/machine/u=
nattached/device[2]"' | jq .
> {
>   "return": {},
>   "id": "libvirt-218"
> }
>
> virsh qemu-monitor-command sles12sp5-ppc64le query-hotpluggable-cpus | jq=
 . | cat
> {
>   "return": [
>     {
>       "props": {
>         "core-id": 8,
>         "node-id": 0
>       },
>       "vcpus-count": 8,
>       "type": "power9_v2.2-spapr-cpu-core"
>     },
>     {
>       "props": {
>         "core-id": 0,
>         "node-id": 0
>       },
>       "vcpus-count": 8,
>       "qom-path": "/machine/unattached/device[1]",
>       "type": "power9_v2.2-spapr-cpu-core"
>     }
>   ],
>   "id": "libvirt-235"
> }
>
> virsh qemu-monitor-command sles12sp5-ppc64le device_add '"id":"cpu-666"' =
'"driver":"power9_v2.2-spapr-cpu-core"' '"core-id":8' '"node-id":0'  | jq .
>
> __GI_raise (sig=3D6) at ../sysdeps/unix/sysv/linux/raise.c:51
> 51      }
> (gdb) up
> #1  0x00007f7839c553e5 in __GI_abort () at abort.c:79
> 79            raise (SIGABRT);
> (gdb) up
> #2  0x00007f783c54a125 in g_assertion_message (domain=3Ddomain@entry=3D0x=
0, file=3Dfile@entry=3D0x556b3baf9242 "../tcg/tcg.c", line=3Dline@entry=3D7=
84, func=3Dfunc@entry=3D0x556b3bb55720 <__func__.55816> "tcg_register_threa=
d",
>     message=3Dmessage@entry=3D0x7f76a46e8f40 "assertion failed: (n < tcg_=
max_ctxs)") at ../glib/gtestutils.c:3223
> 3223        g_abort ();
>
> This ends the usable part of stacktrace, going upp the call stack gdb
> locks up.
>
> Looking at tcg.c line 784 is here:
>
> ster_thread(void)
> {
>     TCGContext *s =3D g_malloc(sizeof(*s));
>     unsigned int i, n;
>
>     *s =3D tcg_init_ctx;
>
>     /* Relink mem_base.  */
>     for (i =3D 0, n =3D tcg_init_ctx.nb_globals; i < n; ++i) {
>         if (tcg_init_ctx.temps[i].mem_base) {
>             ptrdiff_t b =3D tcg_init_ctx.temps[i].mem_base - tcg_init_ctx=
.temps;
>             tcg_debug_assert(b >=3D 0 && b < n);
>             s->temps[i].mem_base =3D &s->temps[b];
>         }
>     }
>
>     /* Claim an entry in tcg_ctxs */
>     n =3D qatomic_fetch_inc(&tcg_cur_ctxs);
> >>> g_assert(n < tcg_max_ctxs); <<<
>     qatomic_set(&tcg_ctxs[n], s);
>
>     if (n > 0) {
>         alloc_tcg_plugin_context(s);
>         tcg_region_initial_alloc(s);
>     }
>
>     tcg_ctx =3D s;
> }
>
> Any idea why qemu would be crashing here?

Hi Michal,

$ git grep tcg_cur_ctxs
tcg/region.c:409:    unsigned int n_ctxs =3D qatomic_read(&tcg_cur_ctxs);
tcg/region.c:889:    unsigned int n_ctxs =3D qatomic_read(&tcg_cur_ctxs);
tcg/tcg-internal.h:34:extern unsigned int tcg_cur_ctxs;
tcg/tcg.c:241:unsigned int tcg_cur_ctxs;
tcg/tcg.c:806:    n =3D qatomic_fetch_inc(&tcg_cur_ctxs);
tcg/tcg.c:1369:    tcg_cur_ctxs =3D 1;

I don't see a qatomic_dec(&tcg_cur_ctxs) anywhere, so it seems hot
unplugging a vcpu doesn't release the tcg_cur_ctxs refcount. Do we
need a tcg_unregister_thread() function?

CCing Richard Henderson.

Stefan

