Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 903398057B2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 15:45:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAWfK-0002EH-Il; Tue, 05 Dec 2023 09:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAWfJ-0002Dx-1p
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:44:49 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAWfC-0000cn-1D
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:44:48 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1fb71880f12so220354fac.0
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 06:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701787480; x=1702392280; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cM8CRRX3pk6uPxP5JwLI/p4BNCJK/lsT1YZEXDGLOdk=;
 b=OANMCoYjAxDpCvXWVBPA3dWk/kl/1VVdc62yK9etEpiF6W0G4l+PjECdjqYSt0Wyhm
 QBZ4pIMMVi6uKgbofW4qb5DzQfsk6psciW1ARbdekMmf/4zEhv2hKxsPRO7mMWQJxnzr
 8zdLmAcIcy0e5Q/ynFn/5bocl4e2QEhC7swUCppl5UTaeq+W5wRK7YZxsQ5mSys++Gn5
 bWe0P76sY0hPyVJRe3mInchyB2cmKLQGPXjmpTDRPaOJWGYG3JBuVWqWp6wpM8bLfDeA
 wsxLLZ8aSOEY49S+6X5yvp+NwljBq5En+LDnx8eEMQxJ1m2UlB0LE0qFOCPntFrjVc0I
 qfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701787480; x=1702392280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cM8CRRX3pk6uPxP5JwLI/p4BNCJK/lsT1YZEXDGLOdk=;
 b=GECf3MDca4vY+UsC0/c0NXkW0RzbnWs/meCidaTWm8crvSJvr1m4GyMwLEsjjavIxh
 4F7PqwsEhAovtSnkJegQ3kqKJY55L6MmQ7NCFU5vxl3q9h9IHK17Ssw/ULzGdPjq4YMx
 AXl8i4UFwbvUpThaKAz1XY5wmcn5VtSqc4bX+NbNTcZHEbBOrOcMFV9RRqmMSs5nnWvl
 HHv3Cq6eKjEcTHNyTF0aJqdaz+xIT5QQsttzktLCJdqtT2sKnjhldAg5owK4wMrLzHhb
 D5giht2YXvF1F3N5zGXK8+V3QXgexSWqnVlwoMI0E7IiDqccarcTkAXZkifSMAW3Di6X
 xfdw==
X-Gm-Message-State: AOJu0YyBxJh6IEMRI46zeRNIleJHiIcFR/kImBXiV1GnclouC9emw9cP
 BgnAHlvp+2/EWPJ4RQV8pPghFEOnJRuaggdWyjTUfbxs
X-Google-Smtp-Source: AGHT+IGDsTyHvHkF8UOkFfe+D/ygzlERPCKD+aLRvoVz4XETD0C7ErU5mmc36YvlWD1Vh1mbv/ydpfV0mqXLzVkEoTs=
X-Received: by 2002:a05:6871:149:b0:1fb:75a:7799 with SMTP id
 z9-20020a056871014900b001fb075a7799mr5416867oab.74.1701787480674; Tue, 05 Dec
 2023 06:44:40 -0800 (PST)
MIME-Version: 1.0
References: <9447a47d-751c-4913-a60b-8d92f87f2998@univention.de>
In-Reply-To: <9447a47d-751c-4913-a60b-8d92f87f2998@univention.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 5 Dec 2023 09:44:28 -0500
Message-ID: <CAJSP0QX_7NtrxjYMCXNtHZkGLV7nXRZ8RUK7m4-ypcf9-8Pr_Q@mail.gmail.com>
Subject: Re: "Instant clone" with Qemu?
To: Philipp Hahn <hahn@univention.de>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2b.google.com
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

On Tue, 5 Dec 2023 at 04:53, Philipp Hahn <hahn@univention.de> wrote:
>
> Hello,
>
> by accident I stumbled over "VMware Instant Clone" =C2=B9, which allows
> cloning of running VMs by copy-on-write-sharing the disk images and
> memory content; the network MAC address gets changed (or a different
> bridge is used?).
> I wonder if something similar can also be done with Qemu? My current
> solution would be to:
> - start and install the VM
> - create a live-snapshot into the qcow2 file
> - clone the disk image, e.g. put a qcow2 overlay on it per clone
> - start and restore the clones from that live-snapshot
> - put the clones in individual bridges and let the host do some network
> address translation (NAT) to give each clone a unique external IP address=
.
>
> Has someone done something similar or is there even a better alternative?
>
> Background: our test suite currently provisions a set of multiple VMs,
> which are dependent on each other. Provisioning them takes sometimes
> many hours. After that the test suite runs inside these VMs and again
> takes many hours.
> I'd like to speed that up by parallelizing these tests, e.g.
> 1. setup the VM environment once
> 2. clone the VM environments as the resources allow
> 3. distribute tests over these environments to run in parallel and to
> allow running flaky tests multiple times from a clean clone again

It would be simplest to use qcow2 backing files and boot each new
instance from scratch. This involves setting up a master image and
then "qemu-img create -f qcow2 -b master.img vm001.qcow2" to create
the instance image. You may be able to use systemd or your distro's
"first boot" functionality to recreate unique IDs and cryptographic
keys when the new instance boots.

If you really want to use a RAM snapshot then I suggest creating a
qcow2 master image with the savevm command and using "cp
--reflink=3Dalways master.qcow2 vm001.qcow2" to create an efficient copy
of the qcow2 file. You'll need some custom scripts to recreate unique
IDs and cryptographic keys inside the new instance after loadvm.

Stefan

>
> =C2=B9<https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.v=
m_admin.doc/GUID-853B1E2B-76CE-4240-A654-3806912820EB.html>
> --
> Philipp Hahn
> Open Source Software Engineer
>
> Univention GmbH
> Mary-Somerville-Str. 1
> 28359 Bremen
> Germany | Deutschland
> Phone: +49 (0)421 22232-0 | E-Mail: info@univention.de
>
> https://www.univention.de | https://www.univention.com
>
> Managing Directors: Peter H. Ganten, Stefan Gohmann
> Local court: Amtsgericht Bremen
> HRB 20755 | Ust-ID: DE220051310
>

