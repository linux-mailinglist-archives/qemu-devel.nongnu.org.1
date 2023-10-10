Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A404B7BFCF4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:10:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCUT-0005tL-0e; Tue, 10 Oct 2023 09:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karmanimedamine@gmail.com>)
 id 1qq5vJ-0003ap-SB
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 02:08:54 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <karmanimedamine@gmail.com>)
 id 1qq5v7-0005g6-14
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 02:08:53 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53808d5b774so9428117a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696918119; x=1697522919; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gvd5hHG56a5HZWLQA0lQWIGH7C0xxSGD1aqyQ15lQZA=;
 b=PEAAEPrmc/MIrFcnEhrVoHR+MgXge/q3PoxI9VsoM7P/7zr56JDKZGylqx9Mh1WKwo
 n1yjLd9YWqCaQb6IC3d7ePag+p+/UgGh99GV8LEWejkKF5oTWPkv3mRY+fINqfDRyloD
 WCVmkVmKTIz/8670iMhzjw3w7V9mrjYl+bmIREvT7gcFrPdbKC70ex5s6RqGjerFWhcg
 FV1uF3ugZ7SpHhg/fbujOMO8yucn+Sv/VS2o0WXGS9HT0vPmtlhY42QZ6u5+13F3cRSW
 Ctm8Mmu8gGgB1okor8RKPyYqqIZjcm3TYvxssZBOz5eNlxYdFgKywLcqUHHOPqM020E8
 LWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696918119; x=1697522919;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gvd5hHG56a5HZWLQA0lQWIGH7C0xxSGD1aqyQ15lQZA=;
 b=dyXIeWaGKSgXgXY+hmhkV1scpcdD5Q0/sQ84ThRdepzzsW943AuloHAhtLnq5H7wfj
 12oFBEdlCOjP9ZQw6TKHzRTTWxkeHPc0S5U9Hg+tKoMAJr9Xqtk+Fk0qlxGt0GBwlO+M
 T5l8P0MxV7d7aMZELI3ztT1jRCEGbVAjjfLm8CXM3lrr2RewCVPrbyvE0XHXkjB+ATqp
 dQEvncp/fHg1w2W11sFbycxAn9N6nj1MDxPpHxZjUvsuI1iBHhLnQn3EhHrXz8iGmGFV
 RkSn9OmrBWWC6R1E4zcxyzZyrB8Gp+iC3WTcqIc5trWantMIwCEko4wT1lZIdxEOSpcN
 DxMA==
X-Gm-Message-State: AOJu0Yy09rxswvRVlLnl+vWfNSCf1Yv/8kqpeIg96lcFnGaeLT3wmRVG
 juzMKNkk8wGFV97LzcN4fWI+FBowByr+eWGLyTafskDX
X-Google-Smtp-Source: AGHT+IHzg9SxV0XsFkc2CoK8sA3PXJ9oy3RNVAYlX1eDUv1Y1NFrvx2CrDc1PNlPY2IqTEBYuzZEMd249sPif9c6Rno=
X-Received: by 2002:aa7:dd12:0:b0:51e:4439:f474 with SMTP id
 i18-20020aa7dd12000000b0051e4439f474mr14390703edv.35.1696918118699; Mon, 09
 Oct 2023 23:08:38 -0700 (PDT)
MIME-Version: 1.0
From: Mohamed Amine KARMANI <karmanimedamine@gmail.com>
Date: Tue, 10 Oct 2023 08:08:26 +0200
Message-ID: <CABO0MBLE0skXfO3QMcLe7HERS6BGQ5gz-UATq5gTTZ6MO=ityw@mail.gmail.com>
Subject: Tap adapter and whpx accelerator in Windows host makes network issues
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ad97060607568960"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=karmanimedamine@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Oct 2023 09:09:14 -0400
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

--000000000000ad97060607568960
Content-Type: text/plain; charset="UTF-8"

Dear Support team,

I am facing an issue with running Qemu guest running in Windows host and
here the details:
- Windows 10 host
- hyper-v is enabled
- openvpn tap-windows v9 adapter is installed and network interface is
named to QEMU_TAP
-Qemu 8.1.0 is installed

While running in cmd terminal:
qemu-system-x86_64 -accel whpx -m 2G -cdrom image.iso -netdev
tap,ifname=QEMU_TAP,id=net0 -device e1000,netdev=net0

I am facing an issue and I cannot ping the Qemu guest from windows host but
I remove the accelerator everything is working fine.


Can you please let me know is there any way to make the accelerator whpx
and tap adapter working together?

Thank you in advance for your support.

Best regards,
Mohamed Amine

--000000000000ad97060607568960
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Dear Support team,<div dir=3D"auto"><br></div><div dir=3D=
"auto">I am facing an issue with running Qemu guest running in Windows host=
 and here the details:</div><div dir=3D"auto">- Windows 10 host</div><div d=
ir=3D"auto">- hyper-v is enabled</div><div dir=3D"auto">- openvpn tap-windo=
ws v9 adapter is installed and network interface is named to QEMU_TAP</div>=
<div dir=3D"auto">-Qemu 8.1.0 is installed</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">While running in cmd terminal:</div><div dir=3D"auto">qe=
mu-system-x86_64 -accel whpx -m 2G -cdrom image.iso -netdev tap,ifname=3DQE=
MU_TAP,id=3Dnet0 -device e1000,netdev=3Dnet0=C2=A0</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">I am facing an issue and I cannot ping the Qemu =
guest from windows host but I remove the accelerator everything is working =
fine.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Can you please let me know is there any way to make the accelerat=
or whpx and tap adapter working together?</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Thank you in advance for your support.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Best regards,</div><div dir=3D"auto">Moham=
ed Amine=C2=A0</div></div>

--000000000000ad97060607568960--

