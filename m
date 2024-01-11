Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C313582B4FB
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 20:00:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO0GK-0000y3-WE; Thu, 11 Jan 2024 13:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1rO0GK-0000xv-57
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 13:58:44 -0500
Received: from pv34p98im-ztdg02172101.me.com ([17.143.234.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1rO0GI-0000BY-Hr
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 13:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1704999518; bh=KQCwymrVwWrwm1PB6fp/XRtKLfQRlYa6D0JO2iEG/Dk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=EOpLGltJvIqtToFjKII3OdZpvvWPAtbP2q/AyGDMoGIAuHUjjuzUL748mdaGrYZxf
 whsFIP/dUdaoZTXdWEgEKaql5cuUML2t1nXj6eelfQWFwnBJd4i0KaWKzXYRiJ5bai
 UmlvkekF5zx44C6Dd+N12uFc3S0e+yr4+8TSa+dMQhx/IcpFhIUT0kdlRH4ATw4J+G
 9Dfun2lqWmfoh9XzKOKUSfHspbzB36UJe9Rk9jP+Vgdfz9Zy1cFO1q3123p8n5eHHZ
 rGq4RzIJTjU1ntvfDaBueDPyZZOecVrKYB2O5Z7Xw47vFuu6lZhFgrXLgXEmpWyxAF
 mUVaUqNI3cKQQ==
Received: from smtpclient.apple (pv43p00im-smtp.me.com [17.56.9.9])
 by pv34p98im-ztdg02172101.me.com (Postfix) with ESMTPSA id B61C2CC00FE;
 Thu, 11 Jan 2024 18:58:36 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.122\))
Subject: Re: Goldfish TTY enhancement
From: Jason Thorpe <thorpej@me.com>
In-Reply-To: <20f3d501-7ff4-4094-8f34-9393c4c7c1e0@linaro.org>
Date: Thu, 11 Jan 2024 10:58:26 -0800
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 David 'Digit' Turner <digit@android.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <286AB63F-6453-42FF-9CF4-5C75C22C6559@me.com>
References: <8FAAD163-46DD-426F-AF69-1DDAB45B2A9B@me.com>
 <20f3d501-7ff4-4094-8f34-9393c4c7c1e0@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3774.500.122)
X-Proofpoint-GUID: _8a7F5egTbc_ixrK5-zzBDRzoOAA3ZYu
X-Proofpoint-ORIG-GUID: _8a7F5egTbc_ixrK5-zzBDRzoOAA3ZYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_11,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 mlxlogscore=931
 spamscore=0 phishscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401110148
Received-SPF: pass client-ip=17.143.234.142; envelope-from=thorpej@me.com;
 helo=pv34p98im-ztdg02172101.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


> On Jan 10, 2024, at 8:01=E2=80=AFAM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> IIUC Goldfish virtual HW is maintained externally by Google
> =
https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLD=
FISH-VIRTUAL-HARDWARE.TXT
>=20
> I suppose the spec needs to be updated before the change can be
> accepted in mainstream QEMU, but since I'm not sure I Cc'ed Alex,
> David and Laurent.

Hey Philippe,

I have seen that document didn=E2=80=99t realize that it was the source =
of truth for the Goldfish devices in Qemu, as Qemu already has Goldfish =
devices that deviate in behavior from that document.  In particular:

1. There is no distinction between =E2=80=9Crtc=E2=80=9D and =E2=80=9Ctime=
r=E2=80=9D in Qemu.

2. The Goldfish =E2=80=9Cpic=E2=80=9D device does not behave as that =
document describes.  In particular, the =E2=80=9CNUMBER=E2=80=9D =
register is described in that document as returning the lowest pending =
interrupt index or 0 for none (i.e. a number in the range 0..32).  But =
Qemu returns a bitmask of pending interrupts when that register is read. =
 And despite the name =E2=80=9CDISABLE_ALL=E2=80=9D that document claims =
that writing to it merely clears the pending interrupts without =
disabling them (which would be quite the trick with level-triggered =
interrupt sources) whereas in Qemu, it does both clear and disable.

(I am not, in any way, advocating for a behavior change in Qemu, BTW=E2=80=
=A6 I just thought that referenced docuemnt was no longer relevant.)

-- thorpej


