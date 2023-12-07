Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF26808B3C
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 15:59:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBFpn-0003E4-MP; Thu, 07 Dec 2023 09:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aziztlili2222@gmail.com>)
 id 1rBDsc-00049w-PD
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 07:53:26 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aziztlili2222@gmail.com>)
 id 1rBDsb-0007yN-00
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 07:53:26 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50bffb64178so752412e87.2
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 04:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701953602; x=1702558402; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lNURdBONFT3CwFJdUZaeV2hYje4FZUPRgbAMjcAv95E=;
 b=RhPMoScnNcqI6EtlGrq5v5LgaYOC3nhGTlISFCUdxxC486Ci30+FEa0DIJUzkjoA1I
 txseZLLolIDpNLkJfE7MaWbIE4DcacbvRyesQMFj2+epFSQS//41o+OSp0A9g6CTPDWD
 Kgo6ndAOP/mzk6SCWC1BEIer8rErtLi+qxV6JS8pXJhhbk5cPm3IvspMp+D/HEbEHkMk
 PkWP/aQMhBVryoQlLCJTMHGuxH0ICq1jegwEG9wG4sgwRGfqflkOS6nUkM1Rcc/OqdZy
 8xbW3uSbuf1ksABYbQGlL234GmOYBlafvdkGc+36c8cLTbGxGtoZEl83OUg1xjOaxo3Q
 nFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701953602; x=1702558402;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lNURdBONFT3CwFJdUZaeV2hYje4FZUPRgbAMjcAv95E=;
 b=YVwtJHIkfTCuQyEIuZu/M2WUvAzvKCY+afZ7NEkINd9NQF51az4LWzzZ27gveb/nT1
 nD+r3R18WTIJ2lEyF4/eXla4ox8/CQBv3LZvNInEE7Ct1LzKeBMfy/QNzeiCFhxOKPcd
 lzFmMMkOMjtQQ14g956LZ90rLxyWZcHFwZFQCsK8bGuo4YWzcxFR7m+zG/5KS0Ovwu5j
 X9/pV8P1dfMFRjGnalAAjWID+ta3WAktHGeqgsXiDerLiSoCnjXg/kNfAXXXrh0+DWpy
 I2UDo1nhkrsBmGsWL8YNBW1QfBcCQJboA2bRkvA0ayG2F3T7SFCiXSfiN0qcvT4ly4Bw
 VogA==
X-Gm-Message-State: AOJu0Yz2skFikcPVonFrXbIvHPY7oxk91aEyzP+OrUGb7cSbgv8FZjV0
 F1zFpse2RFSoGMEjK2q21htXlFcBpEYOkjCLD9pTobCn
X-Google-Smtp-Source: AGHT+IGRV1YL2L70HghkEDEzC6QDDZvT33lGmkehTVBzJi7NVYeB9MySBeqgQbCk1jc926L0K24Gb0e+hyR5FFFzMzY=
X-Received: by 2002:a05:6512:3703:b0:50b:f07f:5308 with SMTP id
 z3-20020a056512370300b0050bf07f5308mr1380799lfr.122.1701953602218; Thu, 07
 Dec 2023 04:53:22 -0800 (PST)
MIME-Version: 1.0
From: aziz tlili <aziztlili2222@gmail.com>
Date: Thu, 7 Dec 2023 13:53:10 +0100
Message-ID: <CAHwHw5Bk7qbDfTmDpV82xcO+YujeJa09mCgdd7c8oQvNLxVKKA@mail.gmail.com>
Subject: Request for New PPC Machine Supporting Multiple SMP Cores
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e26ea5060beaf33c"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=aziztlili2222@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 07 Dec 2023 09:58:36 -0500
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

--000000000000e26ea5060beaf33c
Content-Type: text/plain; charset="UTF-8"

Dear QEMU Team,

I hope this message finds you well. I've been a user of QEMU for well
over a year.

I wanted to share an idea for a potential enhancement that I believe could
benefit many users, including myself. It would be fantastic to have a new
PPC machine model similar to the existing mac99, but with support for
multiple SMP cores.

The ability to simulate multiple SMP cores within a PPC machine environment
would significantly enhance the capabilities of QEMU for various
applications, testing scenarios, and development purposes. This addition
could greatly benefit the community working on PowerPC architecture.

I understand the complexities involved in such developments but wanted to
express the potential advantages and how this enhancement could contribute
to expanding QEMU's capabilities.

Thank you for considering my suggestion. I would be more than happy to
provide further details or collaborate in any way that could assist in
making this idea a reality.

Best regards,
Aziz Tlili

--000000000000e26ea5060beaf33c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Dear QEMU Team,<br></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">I hope this message finds you well. I&#39;v=
e been a user of QEMU for well over=C2=A0a year.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">I wanted to share an idea for a potential enhancem=
ent that I believe could benefit many users, including myself. It would be =
fantastic to have a new PPC machine model similar to the existing mac99, bu=
t with support for multiple SMP cores.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">The ability to simulate multiple SMP cores within a PPC mach=
ine environment would significantly enhance the capabilities of QEMU for va=
rious applications, testing scenarios, and development purposes. This addit=
ion could greatly benefit the community working on PowerPC architecture.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">I understand the complexit=
ies involved in such developments but wanted to express the potential advan=
tages and how this enhancement could contribute to expanding QEMU&#39;s cap=
abilities.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thank you for=
 considering my suggestion. I would be more than happy to provide further d=
etails or collaborate in any way that could assist in making this idea a re=
ality.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Best regards,</di=
v><div dir=3D"auto">Aziz Tlili</div></div>

--000000000000e26ea5060beaf33c--

