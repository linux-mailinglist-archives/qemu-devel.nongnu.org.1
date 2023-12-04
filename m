Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96915803D3D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 19:38:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rADoF-0008EV-VD; Mon, 04 Dec 2023 13:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1rADoC-0008C6-V9
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 13:36:44 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1rADoA-00005l-LL
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 13:36:44 -0500
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F87E220F0
 for <qemu-devel@nongnu.org>; Mon,  4 Dec 2023 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701714999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=6WkjDz/d7/eQjSlgssUMU+3Ipk6cXRkH+pB+bO0xNz4=;
 b=2USRliFRieBgjaV2Xff4iIF9dbPP32g51bvAdNrGVtfAq8ceOL5kJAxi5X4Sd60bFAtjp2
 v07U2SDGP/UdcDVqkirPwAleLiWjCTCZ7IX3rQE6zln4BPVgat9RqQGvbbT6D8qDpkh9TR
 rvlfqcHDDN2Hp6zKssx8R3rua9DkFPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701714999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=6WkjDz/d7/eQjSlgssUMU+3Ipk6cXRkH+pB+bO0xNz4=;
 b=GEd0g1O+Y9GFjV5KTCaX3sQ5I4cuwR6y/hadkIfLeBYNi+/FcQb6SpIDUWELJnaAIoDw4H
 7UdmC25j7YVwcmBQ==
Date: Mon, 4 Dec 2023 19:36:38 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: qemu-devel@nongnu.org
Subject: qemu ppc64 crash when adding CPU
Message-ID: <20231204183638.GZ9696@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 4.02
X-Spamd-Result: default: False [4.02 / 50.00]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_NONE(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_SPAM_LONG(3.50)[1.000]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_ZERO(0.00)[0]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; R_MIXED_CHARSET(0.63)[subject];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=msuchanek@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello,

When running a VM with libvirt I get:

/usr/bin/qemu-system-ppc64 --version
QEMU emulator version 8.1.3 (Virtualization / 15.5)
Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers

/usr/bin/qemu-system-ppc64 -name
guest=sles12sp5-ppc64le,debug-threads=on -S -object
{"qom-type":"secret","id":"masterKey0","format":"raw","file":"/var/lib/libvirt/qemu/domain-11-sles12sp5-ppc64le/master-key.aes"}
-machine
pseries-7.1,usb=off,dump-guest-core=off,memory-backend=ppc_spapr.ram
-accel tcg -cpu POWER9 -m 4096 -object
{"qom-type":"memory-backend-ram","id":"ppc_spapr.ram","size":4294967296}
-overcommit mem-lock=off -smp 16,sockets=1,dies=1,cores=2,threads=8
-uuid a6ad6a7d-125b-4525-b452-241ce2000eda -display none -no-user-config
-nodefaults -chardev socket,id=charmonitor,fd=29,server=on,wait=off -mon
chardev=charmonitor,id=monitor,mode=control -rtc base=utc -no-shutdown
-boot strict=on -device
{"driver":"qemu-xhci","p2":15,"p3":15,"id":"usb","bus":"pci.0","addr":"0x3"}
-device
{"driver":"virtio-scsi-pci","id":"scsi0","bus":"pci.0","addr":"0x4"}
-device
{"driver":"virtio-serial-pci","id":"virtio-serial0","bus":"pci.0","addr":"0x2"}
-blockdev
{"driver":"file","filename":"/home/hramrach/Downloads/SLE-12-SP5-Server-MINI-ISO-ppc64le-GM-DVD.iso","node-name":"libvirt-2-storage","auto-read-only":true,"discard":"unmap"}
-blockdev
{"node-name":"libvirt-2-format","read-only":true,"driver":"raw","file":"libvirt-2-storage"}
-device
{"driver":"scsi-cd","bus":"scsi0.0","channel":0,"scsi-id":0,"lun":0,"device_id":"drive-scsi0-0-0-0","drive":"libvirt-2-format","id":"scsi0-0-0-0","bootindex":2}
-blockdev
{"driver":"file","filename":"/var/lib/libvirt/images/sles12sp5-ppc64le.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}
-blockdev
{"node-name":"libvirt-1-format","read-only":false,"discard":"unmap","driver":"qcow2","file":"libvirt-1-storage","backing":null}
-device
{"driver":"scsi-hd","bus":"scsi0.0","channel":0,"scsi-id":0,"lun":1,"device_id":"drive-scsi0-0-0-1","drive":"libvirt-1-format","id":"scsi0-0-0-1","bootindex":1}
-netdev {"type":"tap","fd":"30","id":"hostnet0"} -device
{"driver":"e1000","netdev":"hostnet0","id":"net0","mac":"52:54:00:3b:d5:a5","bus":"pci.0","addr":"0x1"}
-chardev pty,id=charserial0 -device
{"driver":"spapr-vty","chardev":"charserial0","id":"serial0","reg":805306368}
-audiodev {"id":"audio1","driver":"none"} -device
{"driver":"virtio-balloon-pci","id":"balloon0","bus":"pci.0","addr":"0x5"}
-object
{"qom-type":"rng-random","id":"objrng0","filename":"/dev/urandom"}
-device
{"driver":"virtio-rng-pci","rng":"objrng0","id":"rng0","bus":"pci.0","addr":"0x6"}
-sandbox
on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny
-msg timestamp=on

virsh qemu-monitor-command sles12sp5-ppc64le query-hotpluggable-cpus | jq . | cat
{
  "return": [
    {
      "props": {
        "core-id": 8,
        "node-id": 0
      },
      "vcpus-count": 8,
      "qom-path": "/machine/unattached/device[2]",
      "type": "power9_v2.2-spapr-cpu-core"
    },
    {
      "props": {
        "core-id": 0,
        "node-id": 0
      },
      "vcpus-count": 8,
      "qom-path": "/machine/unattached/device[1]",
      "type": "power9_v2.2-spapr-cpu-core"
    }
  ],
  "id": "libvirt-155"
}

virsh qemu-monitor-command sles12sp5-ppc64le device_del '"id":"/machine/unattached/device[2]"' | jq . 
{
  "return": {},
  "id": "libvirt-218"
}

virsh qemu-monitor-command sles12sp5-ppc64le query-hotpluggable-cpus | jq . | cat
{
  "return": [
    {
      "props": {
        "core-id": 8,
        "node-id": 0
      },
      "vcpus-count": 8,
      "type": "power9_v2.2-spapr-cpu-core"
    },
    {
      "props": {
        "core-id": 0,
        "node-id": 0
      },
      "vcpus-count": 8,
      "qom-path": "/machine/unattached/device[1]",
      "type": "power9_v2.2-spapr-cpu-core"
    }
  ],
  "id": "libvirt-235"
}

virsh qemu-monitor-command sles12sp5-ppc64le device_add '"id":"cpu-666"' '"driver":"power9_v2.2-spapr-cpu-core"' '"core-id":8' '"node-id":0'  | jq .

__GI_raise (sig=6) at ../sysdeps/unix/sysv/linux/raise.c:51
51	}
(gdb) up
#1  0x00007f7839c553e5 in __GI_abort () at abort.c:79
79	      raise (SIGABRT);
(gdb) up
#2  0x00007f783c54a125 in g_assertion_message (domain=domain@entry=0x0, file=file@entry=0x556b3baf9242 "../tcg/tcg.c", line=line@entry=784, func=func@entry=0x556b3bb55720 <__func__.55816> "tcg_register_thread", 
    message=message@entry=0x7f76a46e8f40 "assertion failed: (n < tcg_max_ctxs)") at ../glib/gtestutils.c:3223
3223	    g_abort ();

This ends the usable part of stacktrace, going upp the call stack gdb
locks up.

Looking at tcg.c line 784 is here:

ster_thread(void)
{
    TCGContext *s = g_malloc(sizeof(*s));
    unsigned int i, n;

    *s = tcg_init_ctx;

    /* Relink mem_base.  */
    for (i = 0, n = tcg_init_ctx.nb_globals; i < n; ++i) {
        if (tcg_init_ctx.temps[i].mem_base) {
            ptrdiff_t b = tcg_init_ctx.temps[i].mem_base - tcg_init_ctx.temps;
            tcg_debug_assert(b >= 0 && b < n);
            s->temps[i].mem_base = &s->temps[b];
        }
    }

    /* Claim an entry in tcg_ctxs */
    n = qatomic_fetch_inc(&tcg_cur_ctxs);
>>> g_assert(n < tcg_max_ctxs); <<<
    qatomic_set(&tcg_ctxs[n], s);

    if (n > 0) {
        alloc_tcg_plugin_context(s);
        tcg_region_initial_alloc(s);
    }

    tcg_ctx = s;
}

Any idea why qemu would be crashing here?

Thanks

Michal

