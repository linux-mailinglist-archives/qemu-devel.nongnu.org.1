Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 478927EBB0A
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:55:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r357I-0006ob-CR; Tue, 14 Nov 2023 20:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1r33C3-0006tW-DZ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 18:51:43 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1r33Br-0005cJ-72
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 18:51:43 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231114235126epoutp044ce9a948201ef7dce8ad410398b0b0a9~XoljSIBxt2828028280epoutp04X
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 23:51:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231114235126epoutp044ce9a948201ef7dce8ad410398b0b0a9~XoljSIBxt2828028280epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1700005886;
 bh=HaxbAImOVQDm8kclM8kj+yTJNgVbSDal5jQDjh6AqaQ=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=K+5HIIe+iAkVdD9qqohrVs5hmob1EjEGC7R/Mmt26D1UuhvxWM+agn+DXXXV/lMdS
 8eIDuBpSxQeuu06qo3dDMkFFv6UC4+1MUZLXwWKhzb1Pf0wJCLzGK4zMPADr1bhUAF
 JafsOdJ9p/pQKDW338C5oaQUx/yANv+hb/CRwUVM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231114235126epcas2p48150599e1a5246be5d23b36dff4b8a4d~XoljEMuT50583905839epcas2p4k;
 Tue, 14 Nov 2023 23:51:26 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.99]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SVNNs5XKxz4x9Pw; Tue, 14 Nov
 2023 23:51:25 +0000 (GMT)
X-AuditID: b6c32a43-4b3ff700000021c8-eb-655407fd045e
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 92.17.08648.DF704556; Wed, 15 Nov 2023 08:51:25 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH trivial 19/21] tests/qtest/ufs-test.c: spelling fix:
 tranfer
From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20231114165834.2949011-20-mjt@tls.msk.ru>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231114235125epcms2p7995fc4cff29a1dadf464ed9ec38489dc@epcms2p7>
Date: Wed, 15 Nov 2023 08:51:25 +0900
X-CMS-MailID: 20231114235125epcms2p7995fc4cff29a1dadf464ed9ec38489dc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmue5f9pBUgx1rtCxeHtK0ePLvO6PF
 8d4dLBZrz8xldWDxeHJtM5NH35ZVjB4Tpi5lCWCOyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
 NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqmpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
 Si1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjOmD7lA2PBcu6KjxeXszQwvuDqYuTkkBAw
 kTj08wZjFyMXh5DADkaJ6fdfsXQxcnDwCghK/N0hDFIjLBAk8WPXQxYQW0hAQWLOtg52iLim
 xPT1E5lAytkE1CVOLzQHMUUEwiUu79UBqWAWMJdYue82G8QmXokZ7U9ZIGxpie3LtzKClHMC
 1TRucYAIa0j8WNbLDGGLStxc/ZYdxn5/bD4jhC0i0XrvLFSNoMSDn7uh4pISp749ZoWwpzNK
 LPhvCvKUhMACRolfzdOhGvQlrnVsBLuBV8BX4s+qTUwgNouAqsTRndOgml0kjl15xQxxv7bE
 soWvmUHuZAb6dv0ufRBTQkBZ4sgtFogKPomOw3/ZYT5s2PgbK3vHvCdMELaKxOLmw6wTGJVn
 IUJ5FpJdsxB2LWBkXsUollpQnJuemmxUYAiP2OT83E2M4ESn5byD8cr8f3qHGJk4GA8xSnAw
 K4nw5mkGpArxpiRWVqUW5ccXleakFh9iNAX6ciKzlGhyPjDV5pXEG5pYGpiYmRmaG5kamCuJ
 895rnZsiJJCeWJKanZpakFoE08fEwSnVwHQr8Iipq2RT7LQSi+2un2ui15+bn772jwsra0T1
 mv/pTvHXu/5WyHC4Gz/S7935qenGWa0jn/Iq6v3ZV9uYyrHdV2W4GSCm9GypcViD1oLV/wTf
 X+vjeyMvP+tgTfMb815l1vXKRcbF949tSWk3vaN9wGlvy3wflRZ7balXC/Q9H5pYi9+QrLii
 e8n/d1e7s6hM85pnvEEe/47VfprZap5g5fBxt8a6lSs4J98zvbqz5Hc+q+L93FuNWfdmz3vJ
 t8N70rS7n7aL9GXeiDlj8ftH2iIG74jm+ncpe5Ys1XsadD7892SZi4vvSr9/nJz/muV14hmb
 tSvLbmlec2WYq/uEX61kfmhhRUK20bX0NUosxRmJhlrMRcWJAGaQgmT9AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231114165850epcas2p379e2e74b30942ab0216fd87b5c22470d
References: <20231114165834.2949011-20-mjt@tls.msk.ru>
 <20231114165834.2949011-1-mjt@tls.msk.ru>
 <CGME20231114165850epcas2p379e2e74b30942ab0216fd87b5c22470d@epcms2p7>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=jeuk20.kim@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Nov 2023 20:54:52 -0500
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
Reply-To: jeuk20.kim@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 14/11/2023 17.58, Michael Tokarev wrote:
> Fixes: 631c872614ac =22tests/qtest: Introduce tests for UFS=22
> Cc: Jeuk Kim <jeuk20.kim=40samsung.com>
> Signed-off-by: Michael Tokarev <mjt=40tls.msk.ru>
> ---
>=C2=A0=20=C2=A0tests/qtest/ufs-test.c=20=7C=202=20+-=0D=0A>=C2=A0=20=C2=A0=
1=20file=20changed,=201=20insertion(+),=201=20deletion(-)=0D=0A>=C2=A0=0D=
=0A>=20diff=20--git=20a/tests/qtest/ufs-test.c=20b/tests/qtest/ufs-test.c=
=0D=0A>=20index=205daf8c9c49..95e82f9472=20100644=0D=0A>=20---=20a/tests/qt=
est/ufs-test.c=0D=0A>=20+++=20b/tests/qtest/ufs-test.c=0D=0A>=20=40=40=20-3=
19,7=20+319,7=20=40=40=20static=20void=20ufs_init(QUfs=20*ufs,=20QGuestAllo=
cator=20*alloc)=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ufs_wreg(ufs,=20A_IE=
,=20ie);=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ufs_wreg(ufs,=20A_UTRIACR,=
=200);=0D=0A>=C2=A0=20=C2=A0=0D=0A>=20-=C2=A0=20=C2=A0=20/*=20Enable=20tran=
fer=20request=20and=20task=20management=20request=20*/=0D=0A>=20+=C2=A0=20=
=C2=A0=20/*=20Enable=20transfer=20request=20and=20task=20management=20reque=
st=20*/=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0cap=20=3D=20ufs_rreg(ufs,=20=
A_CAP);=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0nutrs=20=3D=20FIELD_EX32(cap=
,=20CAP,=20NUTRS)=20+=201;=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0nutmrs=20=
=3D=20FIELD_EX32(cap,=20CAP,=20NUTMRS)=20+=201;=0D=0A=0D=0AReviewed-by:=20J=
euk=20Kim=20<jeuk20.kim=40samsung.com>=0D=0A=0D=0AThanks,=0D=0AJeuk

