Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BC17CB68C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 00:24:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsW0Y-0006nt-1Y; Mon, 16 Oct 2023 18:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jacek.suchenia@gmail.com>)
 id 1qsUcu-0007MB-Kc
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 16:55:48 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jacek.suchenia@gmail.com>)
 id 1qsUcs-0005FI-UI
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 16:55:48 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99de884ad25so807565366b.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 13:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697489745; x=1698094545; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IB4xKw53Y3zAYRPTZmFiJtQoeCvSV0wmLWqBb+Ic0kA=;
 b=DjzsSux06Ah+r/eQrVD8+AYkwl+g8c7RreT++mq0cdU9Femk4Km9QI6WShPZo/pz+F
 CZAw/Tv3LAF6umvLYe+HkOA59XWzr7P6NktvcZncBtLWCCKDROvgTOR3nrhce5p6v0Ve
 TsZT4StzlXVPX3ufSBtKU7+OQwlIRtTgK8c5v/4yD4iU4cCtw/iBxzHUm8oOBsBzrcHn
 Y+2umPhpJrxshq/RV2fmwBTIerfv7FlCwe6ZjQ6C7cg4Dp8MYfi5I9XROw3y/WhkAkCB
 an+4L5KgihWO7pz+eaF9cPtoADCmGezzHz5DO30h4PBLPfz/XmpKPn3aoZLiTTMmBEnp
 DpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697489745; x=1698094545;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IB4xKw53Y3zAYRPTZmFiJtQoeCvSV0wmLWqBb+Ic0kA=;
 b=mlD0UnD8xjyKudzL6YRh3kkE9D2wzAOdJfClO7/Ag3lt0PYB5Igpa3zDE2HJw5UZ1W
 ckorR0ih989hPqIdT69v/kFdIb/Ou4ytHHM6uvxR2+Bf+n3uDF8Pdcu9zO5AM/xYWbwa
 714vUh04RpqJAMbt/IJ3TLjOiuHJflU3tyAIRMXdxcfifIAYpoH2P+LqdV+WFO/lmpmV
 jr0/OdFiX4N2mb1ZMI+18XKhimoggZqyXaWaz8eVmgpOh677NvByMTYAYtyTzVHxSDfM
 +eVoT9wHYB3Vx/AJ/3Yj1zde0f7CGjcBQHodO50T0edCrT4q5yUaUaYy7AkvKTsUXE0S
 M0sw==
X-Gm-Message-State: AOJu0Yz7SsOArb4n6w/h0j4u+2k2+iNJhZb1uvVlRX1rBKxKAyaB08ix
 hgWoR+3WaE5HT3dRZfXwHJGZ5CFWtSUgR5lmLKTuk5tXKSE=
X-Google-Smtp-Source: AGHT+IEf9VZUTgirAmU4+wslaK64mbCrL7/Y6ZDyfyC5dB+9FS6M/fegd3EuHNvFFcCZMvUUKPizZ9b/Ekgk6OnGD+Y=
X-Received: by 2002:a17:907:968b:b0:9b6:499a:172d with SMTP id
 hd11-20020a170907968b00b009b6499a172dmr167946ejc.52.1697489744549; Mon, 16
 Oct 2023 13:55:44 -0700 (PDT)
MIME-Version: 1.0
From: Jacek Suchenia <jacek.suchenia@gmail.com>
Date: Mon, 16 Oct 2023 22:55:33 +0200
Message-ID: <CACouuaLhWR3579XY5pBQWAXs6_GTi6iOaPxvxzMQLbP_AWZhcg@mail.gmail.com>
Subject: UEFI secure boot on Macos
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003bdd310607dba199"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=jacek.suchenia@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Oct 2023 18:24:16 -0400
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

--0000000000003bdd310607dba199
Content-Type: text/plain; charset="UTF-8"

Hi

Recently, I was trying to run x86_64 UEFI image on Macos (both Intel and
Apple Silicon),

* With edk2 and secure boot enabled - it hangs before video card init
* With edk2 and without secure boot - it boots the image correctly - so the
video splash screen from edk2 is present, and then the image boots - it is
reproducible on almost all machines that I had access to

(I was using images attached to qemu, or from the Ubuntu repository (with
MS and Ubuntu keys)

Here is a ticket: https://gitlab.com/qemu-project/qemu/-/issues/1919

Could anyone possibly suggest any troubleshooting? How can I distinguish
whether this is a qemu bug or edk2?

Jacek

-- 
Jacek Suchenia
jacek.suchenia@gmail.com

--0000000000003bdd310607dba199
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>Recently, I was trying to run x86_64=
 UEFI image on Macos (both Intel and Apple Silicon),=C2=A0</div><div><br></=
div><div>* With edk2 and secure boot enabled - it hangs before video card i=
nit</div><div>* With=C2=A0edk2 and without secure boot - it boots the image=
 correctly - so the video splash screen from edk2 is present, and then the =
image boots - it is reproducible=C2=A0on almost=C2=A0all machines that I ha=
d access to</div><div><br></div><div>(I was using images attached to qemu, =
or from the Ubuntu repository (with MS and Ubuntu keys)</div><div><br></div=
><div>Here is a ticket:=C2=A0<a href=3D"https://gitlab.com/qemu-project/qem=
u/-/issues/1919">https://gitlab.com/qemu-project/qemu/-/issues/1919</a></di=
v><div><br></div><div>Could anyone possibly suggest any troubleshooting? Ho=
w can I distinguish whether this is a qemu bug or edk2?<br></div><div><br><=
/div><div>Jacek</div><div><div><br></div><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmai=
l=3D"gmail_signature">Jacek Suchenia<br><a href=3D"mailto:jacek.suchenia@gm=
ail.com" target=3D"_blank">jacek.suchenia@gmail.com</a></div></div></div>

--0000000000003bdd310607dba199--

