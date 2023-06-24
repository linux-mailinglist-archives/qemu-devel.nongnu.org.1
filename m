Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EA73CB73
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 16:51:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD4aW-0002Lr-2F; Sat, 24 Jun 2023 10:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1qD1uW-0004XL-5L
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:58:38 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1qD1uU-0003SA-Fr
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:58:35 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-98e109525d6so18632566b.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687607912; x=1690199912;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5QXnT9O6JSj2dVuxeUR7mUKicEY1MUlHcAdQaFqON84=;
 b=dMroXdagjR19Nl2fTUp6oBdQi0guA6o/dkYUcUWD2gAgz3llBhR4m5nwxmwKu+8zdQ
 bH+sEMhP3nVijFhX3l9P72CHeOD2RlHUmh2brke0HXtV5EZ2onz7rjeo9MgiVO55dci8
 qlj3n8y/v9y40Bu9qeI67t4xSf5peKsYpQZLqk7s/5hxPe3tbUSNI3BMQaBY01mpQ3/b
 vyPT44gsgO0kFUum3ktBmAOF4w8Cx6eyh/saLqCmz/hblWwDEI4rKDPmPEuNNeJzM70L
 uTBR+EKe5vu/fq7w4adj5pmMMISaFZybWLtKfggNHZHN7/wJb39MpWgl6+1jJkA8hPfz
 6Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687607912; x=1690199912;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5QXnT9O6JSj2dVuxeUR7mUKicEY1MUlHcAdQaFqON84=;
 b=kN26D7DOMAiB61wusedrRt7UMDpHfeym2wn31xWOfkBqpMjl3b/A6ztI04DySUhPY2
 WnJHQSzJXIEWI05t4ElmRe8hhBLLKrHR/2HVgQHuplpvCgjRPLw9XENAFcP+ZPuULt2S
 F5fhsz45YN+/flkNV8PGTEdMZL++v33CTVW5EKPiOXeRwoJogdDtQ8BO+7tvRJhDTIhQ
 NYX9agS+U973I+CxDIeaqzF7HUr9z2Rp11a1gxixlPXimtBki0I+8T6blIMHNpFIodJm
 8T+IUsTwGjTtY4Xxx+exAAu16zG1Bd97W2OzHjg2ntBTqF5FcOrs9Z2o4jL0vj+zftJZ
 hv7Q==
X-Gm-Message-State: AC+VfDwBwrVB0xuxVrQ36busQEnJN+lR4CaxTMZy0QG0moN4M9vHrkMr
 yuL2kny1y3U3PSAYA7S47D9r3GwFA0uFyMbO3/wPlXstqB26VQ==
X-Google-Smtp-Source: ACHHUZ4Tvtgwxl6kB13HlKOfHglXHD88i0ZhrXA12VCpGlTOEzgT004l2vHpnXkcT7vmInTmIsstzl/aYk0Y02kMb28=
X-Received: by 2002:a17:906:58d2:b0:988:77f0:b671 with SMTP id
 e18-20020a17090658d200b0098877f0b671mr15094226ejs.38.1687607911648; Sat, 24
 Jun 2023 04:58:31 -0700 (PDT)
MIME-Version: 1.0
From: Shivam <shivamvijay543@gmail.com>
Date: Sat, 24 Jun 2023 17:28:20 +0530
Message-ID: <CAC583hF_8Dmsd08V+=O4m=wq-rCyJZz_aA9FZGQz-J7h1vi7iQ@mail.gmail.com>
Subject: Facing difficulties in building QEMU for windows
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000184b9105feded67f"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shivamvijay543@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 24 Jun 2023 10:50:05 -0400
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

--000000000000184b9105feded67f
Content-Type: text/plain; charset="UTF-8"

I am currently following these resources to build QEMU - Hosts/W32 - QEMU
<https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2>

However, when starting qemu-system-aarch64.exe in a console, nothing
happens. I expected a window showing up. Shortly after starting the exe,
I'm getting back the prompt. Nothing printed out to the console. No
necessary DLL is missing. What could be the problem?

--000000000000184b9105feded67f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am currently following these resources to build QEMU -=
=C2=A0<a href=3D"https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2">=
Hosts/W32 - QEMU</a><div><br><span style=3D"color:rgb(35,38,41);font-family=
:-apple-system,BlinkMacSystemFont,&quot;Segoe UI Adjusted&quot;,&quot;Segoe=
 UI&quot;,&quot;Liberation Sans&quot;,sans-serif;font-size:15px">However, w=
hen starting=C2=A0</span><code style=3D"margin:0px;border:0px;font-variant-=
numeric:inherit;font-variant-east-asian:inherit;font-variant-alternates:inh=
erit;font-stretch:inherit;line-height:inherit;font-kerning:inherit;font-fea=
ture-settings:inherit;vertical-align:baseline;box-sizing:inherit;color:rgb(=
35,38,41)">qemu-system-aarch64.exe</code><span style=3D"color:rgb(35,38,41)=
;font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI Adjusted&quot;=
,&quot;Segoe UI&quot;,&quot;Liberation Sans&quot;,sans-serif;font-size:15px=
">=C2=A0in a console, nothing happens. I expected a window showing up. Shor=
tly after starting the exe, I&#39;m getting back the prompt. Nothing printe=
d out to the console. No necessary DLL is missing. What could be the proble=
m?</span><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><span><table cellpaddin=
g=3D"0" cellspacing=3D"0" style=3D"color:rgb(255,255,255);font-size:medium;=
vertical-align:-webkit-baseline-middle;font-family:Arial"><tbody><tr><td><t=
able cellpadding=3D"0" cellspacing=3D"0" style=3D"vertical-align:-webkit-ba=
seline-middle;font-family:Arial"><tbody><tr><td style=3D"vertical-align:top=
"><br></td><td width=3D"46"></td><td style=3D"padding:0px;vertical-align:mi=
ddle"><br></td></tr></tbody></table></td></tr></tbody></table></span></div>=
</div></div></div></div>

--000000000000184b9105feded67f--

