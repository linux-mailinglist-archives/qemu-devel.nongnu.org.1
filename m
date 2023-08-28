Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAB478A5C6
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 08:30:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaVkO-0008Qm-GC; Mon, 28 Aug 2023 02:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qaVkJ-0008QU-17
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 02:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qaVkG-0000l6-Oj
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 02:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693204139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4J53A+k25Wsjk4BWZhu+uL8GkQMJRfHwglsnNMfj5BM=;
 b=D7ic505eLdReu2Hb23L2tNfHkOHJ7DTVj+GWEmOI0fhTplimkt0Nm8dTCMAqYv4QGbKtlF
 0bIkRqjDRO7rPhmJXr5iC6CfMYhf1smVsfdjNWzBGP2Ruhu6sS7weScfVAdvwSq2DJolCB
 phBIWg4tLKfkEZINnUjz1WdUTtjQ4KU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-qODHiDZ2OYatpZ6No73F_A-1; Mon, 28 Aug 2023 02:28:58 -0400
X-MC-Unique: qODHiDZ2OYatpZ6No73F_A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50bf847b267so2202950a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 23:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693204136; x=1693808936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4J53A+k25Wsjk4BWZhu+uL8GkQMJRfHwglsnNMfj5BM=;
 b=ALDQeWNkQviYz8kp4xrot9qrR5WqHO0Vwao8Kjtcd/5LRGPncw4kdZDqCwvboSpla+
 hgSLKb/vDMFMDCzRvZVZaqLEJHsgQCDhqIMBS5aXmYPwNRwEYOkKgUVhpckdypFvTL+j
 rA4igMutnSAnhsK/7s8kThG5ZuvJgr0e/K1VUK6qmACyvcfrBbdEXNYWxz5JuYbh2NND
 AoNBpm3bjv3VwuPYJDP1q5mYtlnCMoLvcC1Y2IOexHo3xW8yMgBba87HTWZ39yXu4sN6
 ukOkrzfXniwfZIBT7dXVjahSO1jMFGHBo1B27sg6KmiJdAvOOLxFsrGdwvdkHZl1waac
 YaCA==
X-Gm-Message-State: AOJu0YxErCRpdsSmy/A4sOekuedFyRQDoAPbIXr6u0JGWdpFH3wZbVgD
 S7xYC/DL2JxS9yq++OFMmn/PCOytG2lvkM4G7JTUQEetXBSM8f/ZepdNFqXGlDu30Bu1TnUBtxp
 d1v5XKGWIlCyfQskJHYdM78CmT8HtG3qlHmNn87s=
X-Received: by 2002:aa7:cb8f:0:b0:527:fa8d:d40b with SMTP id
 r15-20020aa7cb8f000000b00527fa8dd40bmr17740976edt.26.1693204136280; 
 Sun, 27 Aug 2023 23:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1BhgvmuSLF/dgDEPkSUyJvLouik937gvhO65LZmaHuqr31XWDlzfR6PAd2K+hMetb4FpR8z4F2McJrPnoPSw=
X-Received: by 2002:aa7:cb8f:0:b0:527:fa8d:d40b with SMTP id
 r15-20020aa7cb8f000000b00527fa8dd40bmr17740969edt.26.1693204135978; Sun, 27
 Aug 2023 23:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <61fa4ed6-e299-4b1c-a152-ace156059567@elijahr.dev>
In-Reply-To: <61fa4ed6-e299-4b1c-a152-ace156059567@elijahr.dev>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 28 Aug 2023 10:28:44 +0400
Message-ID: <CAMxuvaxrNnF24WmHgH7mCa3oPrjG7MWBvm6LD6n8=MNNj+m7Gg@mail.gmail.com>
Subject: Re: Help with QEMU DBUS display
To: Elijah R <elijah@elijahr.dev>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Mon, Aug 28, 2023 at 7:58=E2=80=AFAM Elijah R <elijah@elijahr.dev> wrote=
:
>
> Hi!
>
> I'm currently attempting to use qemu's DBUS display from within a go appl=
ication, using the godbus library. However, I'm hitting some roadblocks, an=
d this is probably because I'm a bit confused about how qemu's peer-to-peer=
 dbus connection works, and it's not explained in the documentation.
>
>
> I invoke QEMU with the following argument
>
> -display dbus,p2p=3Dyes
>
> and then connect to QMP through a separate UNIX socket. From my understan=
ding, I need to listen on the socket separately in the program, and then pa=
ss qemu the file descriptor over QMP and run add_client.
>
> In the same program I listen to the socket, and start waiting for a conne=
ction. Then, on another thread, get a file descriptor for the socket by fir=
st dialing it. Here's my code for that
>
> sock, err :=3D net.Dial("unix", "/tmp/qemudbus.sock")
> if err !=3D nil {
> return err
> }
> uc, ok :=3D sock.(*net.UnixConn)
> if !ok {
> return fmt.Errorf("Could not cast Conn to UnixConn")
> }
> file, err :=3D uc.File()
>
> I then pass this file descriptor to QEMU using QMP (I'm using DigitalOcea=
n's qmp library)
>
> res, err :=3D mon.RunWithFile([]byte(`{"execute": "getfd", "arguments": {=
"fdname": "dbusmon"}}`), file)
>
> And add the dbus client:
>
> res, err =3D mon.Run([]byte(`{"execute": "add_client", "arguments": {"pro=
tocol": "@dbus-display", "fdname": "dbusmon"}}`))
>
> This seems to work fine, as I'm then (apparently) able to make a DBUS con=
nection with that so cket without any error.
>
> However, when I then try to do anything with that connection (In this cas=
e I'm attempting to introspect /org/qemu/Display1/VM), the call hangs and n=
ever returns.
>
> node, err :=3D introspect.Call(session.Object("org.qemu.Display1.VM", "/o=
rg/qemu/Display1/VM"))
>
> I'm not sure what's going wrong here, but I suspect I'm obtaining the fil=
e descriptor wrong (am I supposed to dial the socket?) or I'm doing things =
in the wrong order.
>

You seem to be doing everything correctly. Before doing the call, make
sure D-Bus authentication took place. I am not very familiar with go,
but could you share the code?


