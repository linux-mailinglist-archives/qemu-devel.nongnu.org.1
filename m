Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4299C8022A5
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 12:12:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9kNS-0003w4-Ep; Sun, 03 Dec 2023 06:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amit251098@gmail.com>)
 id 1r9kNO-0003uI-4p
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 06:11:06 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amit251098@gmail.com>)
 id 1r9kNM-00076g-P2
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 06:11:05 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67aa3b62c35so13098536d6.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 03:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701601863; x=1702206663; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=d/2YOaE6/UVANrnzomyCq443TlwYHxsy0dboNLXM3r4=;
 b=kf0kIWnKF34l9dyzp1KdlFTO6bkHNzaIoeplYx798AEg36SBHI895UiQUS36e/WIzg
 QENAsmeomIIBZOE9utxwp6w+mXFbrB3nm5zvR9BT3V6boraECSwweiMIYdvvZwJ+kqTM
 9Q2dkSDzfVw9Gk3BCbVTVL56pV5vig26u1rC0oPufjK9CIp/MQsTYET2ZteRV5MJK/L/
 RmsDP1Z8zPkuJamIe9Ho9BaHBHfc6aKxVnkcMaIZOy+Smb4+YrMbLJ3Q2HJRDuJ2O2My
 dkMHx0c+kxSUW/Bz51OkCYw3De3X6ky27JP/Z7L6jWqJtfY6tsn5rVFFpnWdfa5vwYTC
 CBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701601863; x=1702206663;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d/2YOaE6/UVANrnzomyCq443TlwYHxsy0dboNLXM3r4=;
 b=E5f4HfelmhavE/eTaJQhtrXiU3sAqLkr3UwyUV/QBbo9X+gGdDlBBecLpggw+p+k3Q
 6OOPOjiktCbyEJxmo9UyArzAGvR+X3KTJK7Ss/F+ivKGVitW1XUM+dXYlEtO6IKWySzu
 wTGh+fOJyJUAhsQ9I5Rcej3bzlRL9feVE804uoisIVD1Yn26cYkj4cUmqu4ZJHTJHbcG
 COgYmv6MiwTxWy4OkLG/FoSIPWD6rm74BeCfLUGTt3XN9LkIpQ9F+nHW22ua0gYgtHc+
 dSs7jCVGJPLgDeh3/f4im2a+b7MpzmrlF70vZm8+yCgQwwP2uTuykk+BZuiYtGniCk5A
 cW/w==
X-Gm-Message-State: AOJu0YxUTGBAoMAtaopN/GCZzf2kBJa1xiauAsTnLq3RRB1Tuyh0PXxA
 WBfbWZVT3WmrunVUwW6EmcF2FRvqUScUntYIan/ZEFKkeCE=
X-Google-Smtp-Source: AGHT+IFwWeyN+1bNwzPV930uij35COiZlVvRcUSNeohf/ntB3EM3VO1pDWE0FFuqigW3r4UrevLaaylQLZQ1G7A+JQ4=
X-Received: by 2002:a05:6214:420f:b0:67a:72c9:c12e with SMTP id
 nd15-20020a056214420f00b0067a72c9c12emr3256072qvb.65.1701601862783; Sun, 03
 Dec 2023 03:11:02 -0800 (PST)
MIME-Version: 1.0
From: Amit Kumar <amit251098@gmail.com>
Date: Sun, 3 Dec 2023 16:40:51 +0530
Message-ID: <CAHhcV8-npbXbBL25onW9Z8jsLXO7yCGkNTECOxqwOWs9prtZeg@mail.gmail.com>
Subject: Save VM created using x86_64-softmmu/qemu-system-x86_64
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000094982b060b990e40"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=amit251098@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000094982b060b990e40
Content-Type: text/plain; charset="UTF-8"

Hi

I am building QEMU from source, then creating a qcow2 file and then
installing a VM using the following command.

./qemu-img create -f qcow2 test.qcow2 8G

x86_64-softmmu/qemu-system-x86_64 -m 1024 -enable-kvm -drive
if=virtio,file=test.qcow2,cache=none -cdrom
ubuntu-22.04.3-live-server-amd64.iso

However the VM does not persist after I install it. Please guide me how to
be able to do that

Thanks, Amit

--00000000000094982b060b990e40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br></div><div>I am building QEMU from s=
ource, then creating a qcow2 file and then installing a VM using the follow=
ing command. <br></div><div><br></div><div><span style=3D"font-family:monos=
pace">./qemu-img create -f qcow2 test.qcow2 8G</span></div><div><span style=
=3D"font-family:monospace"><br></span></div><div><span style=3D"font-family=
:monospace">x86_64-softmmu/qemu-system-x86_64 -m 1024 -enable-kvm -drive if=
=3Dvirtio,file=3Dtest.qcow2,cache=3Dnone -cdrom ubuntu-22.04.3-live-server-=
amd64.iso</span></div><div><br></div><div>However the VM does not persist a=
fter I install it. Please guide me how to be able to do that</div><div><br>=
</div><div>Thanks, Amit<br></div></div>

--00000000000094982b060b990e40--

