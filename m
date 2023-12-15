Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46296814BA9
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 16:22:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEA0F-0004Q5-J5; Fri, 15 Dec 2023 10:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rEA0D-0004Pa-7S
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 10:21:25 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rEA0A-0008DD-Ds
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 10:21:24 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-20373729148so344079fac.0
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 07:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702653679; x=1703258479; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXD5d3R2pDUZplxgwvb8awCESXDU0THeugQUdhfINR8=;
 b=VjjYUsOpnhi4RnZyQNsm+Tqonc0QBm54wwN/k9HuJAx0CmrHeCQAlSxK8BBwek2nSq
 xeepw9u+BO8molVn/wxaIgRIK1p84S0jkCscPXqTTgz1bN4fV74QkYkxnC4GqYOqY8Tt
 x2nq4f8zQOHcs3sZMM/o31SYjSXAoEKNhe0605Hfxoft/GK0vJQFvb4wHfPUpg313B4k
 eM+5Vn5BxglI4PRtMjsV0TLjclEQgHj4ael3Psu3dnf2FIOfYCCy5RGwaVeVJbeUCgGK
 ehG7vO7yZwpbq0P9l7qiKPL7BRbUxiMKgnb5xc0ZxEe9+/K8+/EsoYXS66vpxxSQwxEf
 uhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702653679; x=1703258479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXD5d3R2pDUZplxgwvb8awCESXDU0THeugQUdhfINR8=;
 b=sukIsaTfK0+PZl56QgrqLy/ZSV7Cja67gYFJu9bRheDy+oLtDwgXZRKwa0KCX832li
 iwVW0NsJpl3ydsxInLYIVzT0x9h1QbZxe1TUD6FLWEQxQ1O17pIz1/bNtFyYluuwXhk+
 QPMk5wuDoZbxBy6bz2KoXrY5VzLPextgXs2FLTbdU/9a/9mU3TbX85LQlXPa7h8o3tkg
 D1dY1G/7EjgT+C9iYMNzk1noSLkBrwULlZFb98cHoRUIz8K9MhvBr5LNH4SZEOxNNIR1
 NHvTrxNgr6dEFMVORYfExqV3qaR+tff2YrVbJ46IxqirZjVH26mQRsA9iuQ+LUWTgof0
 XuJg==
X-Gm-Message-State: AOJu0YxXzg+6GJMNTn2YRVKuHdVnQRnnrMtiwoVEkFuF7poeMSlTWoXO
 WhZDhodXDHlcv1OQqc1SL6n0ohjH5eNfIYA8o5o=
X-Google-Smtp-Source: AGHT+IHfdRKaAUY0CZhaBY7Bn9r2+Lv0MtDF745/o6hHQKDtgeBBfxieWSO5W5JrHik5gZuDAP3eva9YbHz2FNOYY7o=
X-Received: by 2002:a05:6870:610c:b0:203:2225:bab5 with SMTP id
 s12-20020a056870610c00b002032225bab5mr5785701oae.113.1702653678935; Fri, 15
 Dec 2023 07:21:18 -0800 (PST)
MIME-Version: 1.0
References: <9447a47d-751c-4913-a60b-8d92f87f2998@univention.de>
 <CAJSP0QX_7NtrxjYMCXNtHZkGLV7nXRZ8RUK7m4-ypcf9-8Pr_Q@mail.gmail.com>
 <e0454916-9ee9-46b8-9699-4225fa06fa63@univention.de>
In-Reply-To: <e0454916-9ee9-46b8-9699-4225fa06fa63@univention.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 15 Dec 2023 10:21:07 -0500
Message-ID: <CAJSP0QVkiE_kky47++dHReXbajVeiiJJKcaGfmFHjVjFphK7Yw@mail.gmail.com>
Subject: Re: "Instant clone" with Qemu?
To: Philipp Hahn <hahn@univention.de>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2e.google.com
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

On Fri, 15 Dec 2023 at 06:01, Philipp Hahn <hahn@univention.de> wrote:
>
> Hello Stefan,
>
> thank you for your kind reply.
>
> Am 05.12.23 um 15:44 schrieb Stefan Hajnoczi:
> > On Tue, 5 Dec 2023 at 04:53, Philipp Hahn <hahn@univention.de> wrote:
>  >
> >> by accident I stumbled over "VMware Instant Clone" =C2=B9, which allow=
s
> >> cloning of running VMs by copy-on-write-sharing the disk images and
> >> memory content; the network MAC address gets changed (or a different
> >> bridge is used?).
> >> I wonder if something similar can also be done with Qemu? My current
> >> solution would be to:
> >> - start and install the VM
> >> - create a live-snapshot into the qcow2 file
> >> - clone the disk image, e.g. put a qcow2 overlay on it per clone
> >> - start and restore the clones from that live-snapshot
> >> - put the clones in individual bridges and let the host do some networ=
k
> >> address translation (NAT) to give each clone a unique external IP addr=
ess.
> >>
> >> Has someone done something similar or is there even a better alternati=
ve?
> >>
> >> Background: our test suite currently provisions a set of multiple VMs,
> >> which are dependent on each other. Provisioning them takes sometimes
> >> many hours. After that the test suite runs inside these VMs and again
> >> takes many hours.
> >> I'd like to speed that up by parallelizing these tests, e.g.
> >> 1. setup the VM environment once
> >> 2. clone the VM environments as the resources allow
> >> 3. distribute tests over these environments to run in parallel and to
> >> allow running flaky tests multiple times from a clean clone again
> >
> > It would be simplest to use qcow2 backing files and boot each new
> > instance from scratch. This involves setting up a master image and
> > then "qemu-img create -f qcow2 -b master.img vm001.qcow2" to create
> > the instance image. You may be able to use systemd or your distro's
> > "first boot" functionality to recreate unique IDs and cryptographic
> > keys when the new instance boots.
>
> Actually I do not want to modify the clones at all: While the machine ID
> is probably less interesting to others, I can even live with re-using
> the SSH keys as this is only for *internal* testing: I can tell `ssh` to
> not check the keys as I can control all the networking, so security is
> of little concern here.
>
> > If you really want to use a RAM snapshot then I suggest creating a
> > qcow2 master image with the savevm command and using "cp
> > --reflink=3Dalways master.qcow2 vm001.qcow2" to create an efficient cop=
y
> > of the qcow2 file. You'll need some custom scripts to recreate unique
> > IDs and cryptographic keys inside the new instance after loadvm.
>
> Is there a major difference between doing a "savevm" to an external file
> and doing a live snapshot, which stores the "savevm" inside the qcow2
> file itself. The later has the benefit for me, that I only have to
> handle one file; I could even store it for later use if needed.

With the reflink approach you still snapshot the VM into the original
qcow2 file (with the "savevm" command), not into an external file. The
reflink creates an efficient copy of the file for each instance of the
VM that you with to clone. But since you've said you don't want to
modify the clones at all, maybe this approach is overkill because you
have to manage these new qcow2 files.

Have you tried the -snapshot command-line option? It creates a
temporary qcow2 overlay that is discarded when QEMU exits. That allows
the guest to write to the disk but those changes won't be permanent
and you can run as many guests simultaneously as you want (each has
its own temporary qcow2 overlay that is managed by QEMU behind the
scenes).

>
>
> My main problem currently is cloning the MAC address: As our product is
> an operating system the MAC addresses of the involved systems is stored
> in some databases; while in most cases they are not required, I do not
> want to hunt for these in all kind of different locations and change
> them to some cloned MAC address.
> I already had a look at "Virtual Routing and Forwarding"=C2=B2, which all=
ows
> me to resue the same MAC addresses in different network bridge
> interfaces, but what I did not yet get to work is the "routing" between
> them. I found some very nice articles=C2=B3=E2=81=B4 on how to do NAT wit=
h VRF, but
> it is not yet working.

I'm not knowledgeable about VRF. You could also use -netdev
user,hostfwd=3Dtcp::$VM_SSH_NAT_PORT-:22 where VM_SSH_NAT_PORT is a
unique port assigned by the script that launches the guest. That way
each guest can have the same MAC address and IP address but receive
incoming SSH connections.

Stefan

