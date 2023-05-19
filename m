Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F41DD709F71
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 20:53:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q05DK-00040n-85; Fri, 19 May 2023 14:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q05DH-00040R-9G
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:52:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q05DE-0007QB-Vw
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:52:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ae6b4c5a53so15216715ad.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684522342; x=1687114342;
 h=cc:to:subject:message-id:date:references:mime-version:from
 :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=r+3IlCRaXoRoI+778Qjr3/XuLST5OqmiNCRP1TIfRg0=;
 b=A9hCx8NRLWbo+K5xM3S3Ehjh28Er3PBA2e96Db2pFxcb7nnapXdNr0M5Za/uZiTXLh
 Z/L/HhwQp9OiWgeV3l7PIaNVmmaoal29qQRaEKbJUfxaXXoLQysDMqG4kTRXDe5au+p/
 MyGvXc+x70oQ5V0VkU+ii3CUKrzALGOEpdqyYVQQ6K+dcl9J7kSjgSSyEq8kv+I2XQ1N
 FpUSsHmDnKn4cjnkRsT+nfF4FNVxNRQ/+w+214D+IkobGUogd+9iP/SYasc/syh5cEMs
 /LCBYf9ejUmsyyhqsCaLyqqXVQy0pi0MmTdz4Yoa7GzYYAWO7z/HQRS/2dAFZKDPBrAI
 4iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684522342; x=1687114342;
 h=cc:to:subject:message-id:date:references:mime-version:from
 :in-reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r+3IlCRaXoRoI+778Qjr3/XuLST5OqmiNCRP1TIfRg0=;
 b=dIc+S40QG/2j+shbRA+VNc5NrqD8aNmgNQilzLu/bbDnGaYA9uicfBYva6gkPmDKaS
 SO9Cknr6OziUE0am+zi6k/EwqlDQ0LltYOrukL1QM/z4CmH+o0mJnkroz7Dr1grDVeOi
 cFFIL9RdLfK09qRGAakDgqOK37dlBZrTAcSlyB/zBY9vMUIa7+DVM+Vzp4WLWa5s4qT+
 1kc6C8aeQF1RFib6uApuUabvvKrYKcHN7CnYWlbdpOWFwHcoZsSJxSyfjMOwAOrv4wo+
 FcKYjs5zD+BfY/8BfiNaby5K5r1xmvzAm8lLUTCG/VSk+rbvjEVy/OHM/2WyFpB/fX/z
 wZAQ==
X-Gm-Message-State: AC+VfDzuZvtVchYzRPmD7CPbw2376hgnUnKHtRDUIomk1qddKkQtxwVp
 v+0FvECBtz8bdOSbNiZy7LP0hrKm3+krzuQHJpEjyQ==
X-Google-Smtp-Source: ACHHUZ51MpPZc83d8qKIMAYpH9m5AC7H83ucA2W08JbPzLfjNGsqNejX24eyYJd0XbAuyowcIawONss5AbltWhVNARY=
X-Received: by 2002:a17:902:7448:b0:1a6:dd9a:62c5 with SMTP id
 e8-20020a170902744800b001a6dd9a62c5mr3531747plt.10.1684522342688; Fri, 19 May
 2023 11:52:22 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 19 May 2023 11:52:21 -0700
In-Reply-To: <81e3dd08-1927-241e-2fe2-343e0f815acb@redhat.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Mime-Version: 1.0
References: <CAAYibXhsM8rWghEtUoehodK1u+SZ5of81vA-gshmTWiH7PvbLg@mail.gmail.com>
 <81e3dd08-1927-241e-2fe2-343e0f815acb@redhat.com>
Date: Fri, 19 May 2023 11:52:21 -0700
Message-ID: <CAAYibXiUc8uz2v16AdwGeZNntgCRC=NZyiyBhr8+gVUQGWkdzQ@mail.gmail.com>
Subject: Re: [External] Re: Configure no longer works after pulling in the
 latest QEMU commits
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000daba7605fc106bb0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000daba7605fc106bb0
Content-Type: text/plain; charset="UTF-8"

Hi Paolo, I have applied this patch locally and I am able to run
"configure" now.
From: "Paolo Bonzini"<pbonzini@redhat.com>
Date: Fri, May 19, 2023, 1:31 AM
Subject: [External] Re: Configure no longer works after pulling in the
latest QEMU commits
To: "Hao Xiang"<hao.xiang@bytedance.com>, "qemu-devel@nongnu.org"<
qemu-devel@nongnu.org>, "jsnow@redhat.com"<jsnow@redhat.com>
On 5/19/23 05:00, Hao Xiang wrote: > Hi, > > After pulling in the QEMU
latest commits, I can no longer run the > "configure" command. Below is the
error message I am seeing. I believe > this is related to this change
"configure: create a python venv > unconditionally". > I am running on
Debian GNU/Linux 11 (bullseye) and 5.15 kernel version. > What can I do to
fix/work around the issue? Hi, please try the patch I have Cc'd you on,
"[PATCH] mkvenv: replace distlib.database with
importlib.metadata/pkg_resources" Paolo

--000000000000daba7605fc106bb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div id=3D"editor_version_1.26.2_sNFFA4hm" style=
=3D"word-break:break-word"><div style=3D"margin-top:4px;margin-bottom:4px;l=
ine-height:1.6"><div class=3D"" style=3D"font-size:14px">Hi Paolo, I have a=
pplied this patch locally and I am able to run &quot;configure&quot; now.
</div></div></div><div class=3D"history-quote-wrapper" id=3D"lark-mail-quot=
e-168452233"><div style=3D"list-style-position:inside"><div class=3D"adit-h=
tml-block adit-html-block--collapsed" style=3D"border-left:none;padding-lef=
t:0px"><div><div class=3D"adit-html-block__attr history-quote-meta-wrapper =
history-quote-gap-tag" id=3D"lark-mail-quote-meta-Ipo2uaUrF" style=3D"paddi=
ng:12px;background:rgb(245,246,247);color:rgb(31,35,41);border-radius:4px;m=
argin-top:24px;margin-bottom:12px"><div id=3D"lark-mail-quote-9a111657ffab3=
5031faa79e9271874fe"><div style=3D"word-break:break-word"><div style=3D""><=
span style=3D"">From: </span><span style=3D"white-space:nowrap">&quot;Paolo=
 Bonzini&quot;&lt;<a style=3D"white-space:pre-wrap;word-break:break-word;te=
xt-decoration:none;color:inherit" href=3D"mailto:pbonzini@redhat.com" class=
=3D"quote-head-meta-mailto">pbonzini@redhat.com</a>&gt;</span></div><div st=
yle=3D""><span style=3D"">Date: </span> Fri, May 19, 2023, 1:31 AM</div><di=
v style=3D""><span style=3D"">Subject: </span> [External] Re: Configure no =
longer works after pulling in the latest QEMU commits</div><div style=3D"">=
<span style=3D"">To: </span><span style=3D"white-space:nowrap">&quot;Hao Xi=
ang&quot;&lt;<a style=3D"white-space:pre-wrap;word-break:break-word;text-de=
coration:none;color:inherit" href=3D"mailto:hao.xiang@bytedance.com" class=
=3D"quote-head-meta-mailto">hao.xiang@bytedance.com</a>&gt;</span>, <span s=
tyle=3D"white-space:nowrap"><span>&quot;<a href=3D"mailto:qemu-devel@nongnu=
.org" target=3D"_blank">qemu-devel@nongnu.org</a>&quot;&lt;</span><a style=
=3D"white-space:pre-wrap;word-break:break-word;text-decoration:none;color:i=
nherit" href=3D"mailto:qemu-devel@nongnu.org" class=3D"quote-head-meta-mail=
to">qemu-devel@nongnu.org</a>&gt;</span>, <span style=3D"white-space:nowrap=
"><span>&quot;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsnow@r=
edhat.com</a>&quot;&lt;</span><a style=3D"white-space:pre-wrap;word-break:b=
reak-word;text-decoration:none;color:inherit" href=3D"mailto:jsnow@redhat.c=
om" class=3D"quote-head-meta-mailto">jsnow@redhat.com</a>&gt;</span></div><=
/div></div></div><div><div style=3D"white-space:pre-wrap">On 5/19/23 05:00,=
 Hao Xiang wrote:
&gt; Hi,
&gt;=20
&gt; After pulling in the QEMU latest commits, I can no longer run the=20
&gt; &quot;configure&quot; command. Below is the error message I am seeing.=
 I believe=20
&gt; this is related to this change &quot;configure: create a python venv=
=20
&gt; unconditionally&quot;.
&gt; I am running on Debian GNU/Linux 11 (bullseye) and 5.15 kernel version=
.
&gt; What can I do to fix/work around the issue?

Hi,

please try the patch I have Cc&#39;d you on,

&quot;[PATCH] mkvenv: replace distlib.database with importlib.metadata/pkg_=
resources&quot;

Paolo</div></div></div></div></div></div></body></html>

--000000000000daba7605fc106bb0--

