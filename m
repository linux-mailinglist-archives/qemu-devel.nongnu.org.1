Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED64734924
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 00:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0uK-00063r-Q0; Sun, 18 Jun 2023 18:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmaline@mac.com>) id 1qB0uI-00063f-B1
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 18:30:02 -0400
Received: from ms11p00im-qufo17281401.me.com ([17.58.38.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmaline@mac.com>) id 1qB0uG-0006DM-9w
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 18:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
 t=1687127397; bh=QhlbHAfltkEQhWvcjcqUamPqhVY8ySH0hazKrgGrDl0=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
 b=kDkDEYfMkSLypGAjDJnLAKIicYBKEG2QaY8yDWUFRrxGdwXNCWNEpWZ6I8Xn8GJpr
 BGT5Z7HaflZ1l9vCQ+8UM3xvcrW1/Tygj9tgz7pFn+grenJVouaHu9SgOKZLK2AfKv
 tPUQm3Xzc4RfKy3t2+5oqm2UeDLQhZX5v7bTb0oW1sn6hRrZrMjVqb/+NaDWnILHfC
 Ti2IvZ5oLfbD+fY1cqr+YbzzyahqujbUaANvTohVJJBx55DsfnSKhuO8m1UQhlM4/l
 hEqqLTrZvvCx8LRCaBGe4sTc9y7eT/U8YzD7WmsxtAqPwaoaaIWj2o1p8ZKVFLcipI
 h1izn0mi4nERg==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com
 [17.57.154.19])
 by ms11p00im-qufo17281401.me.com (Postfix) with ESMTPSA id DFFC4BA0185
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 22:29:56 +0000 (UTC)
From: John Maline <jmaline@mac.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_3A8C90D1-64F5-4F37-874D-1E462E8D1E13"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: virtiofsd - removed in QEMU 8.0, replacement seems Linux-only
Message-Id: <FF669CD8-4E37-4940-9713-4E5F83161DCE@mac.com>
Date: Sun, 18 Jun 2023 17:29:44 -0500
To: qemu-devel <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Proofpoint-ORIG-GUID: ubAwFdYd_tP2Zk9MqGnhijgI9pkdHRd6
X-Proofpoint-GUID: ubAwFdYd_tP2Zk9MqGnhijgI9pkdHRd6
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2020-02-14=5F02,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2306180215
Received-SPF: pass client-ip=17.58.38.51; envelope-from=jmaline@mac.com;
 helo=ms11p00im-qufo17281401.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--Apple-Mail=_3A8C90D1-64F5-4F37-874D-1E462E8D1E13
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

The QEMU Removed Features page indicates that virtiofsd has been =
removed, replaced with https://gitlab.com/virtio-fs/virtiofsd, a =
rust-based implementation.
=
https://qemu-project.gitlab.io/qemu/about/removed-features.html#virtiofsd-=
removed-in-8-0=EF=BF=BC

Browsing and searching the qemu source, it sure looks like the qemu =
implementation is gone. tools/virtiofsd is there in 7.2, gone in 8.0.

Searching a bit, it seems the rust implementation is Linux-only. I read =
this email thread as saying that=E2=80=99s true, with the addiitonal =
point that the writer had gotten some subset working for another use =
case.
https://listman.redhat.com/archives/virtio-fs/2021-April/003021.html

I've been running on a macos host and a Linux (Red Hat-based) guest. =
Worked fine when I had virtiofsd implementation.
Alternatives?
- RH seems allergic to 9P filesystem for host file access, the qemu =
alternative I=E2=80=99m finding.
- Or I=E2=80=99m pointed to NFS which operationally I=E2=80=99m not =
wanting to do.
- Ubuntu ships a 9P client. Ideally I=E2=80=99d not have to switch to =
that distribution.

Anyone more clued in know if there=E2=80=99s some expectation / roadmap =
/ hope that we=E2=80=99ll get a more portable virtiofsd on the horizon? =
Or is there another alternative I=E2=80=99m missing?

John


--
John Maline
jmaline@mac.com




--
John Maline
jmaline@mac.com



--Apple-Mail=_3A8C90D1-64F5-4F37-874D-1E462E8D1E13
Content-Type: multipart/related;
	type="text/html";
	boundary="Apple-Mail=_B02BAE0A-AA7A-4FAF-981B-BB4D6D9FD5C8"


--Apple-Mail=_B02BAE0A-AA7A-4FAF-981B-BB4D6D9FD5C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><meta =
http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><div =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">The QEMU Removed Features page indicates =
that virtiofsd has been removed, replaced with&nbsp;<a =
href=3D"https://gitlab.com/virtio-fs/virtiofsd">https://gitlab.com/virtio-=
fs/virtiofsd</a>, a rust-based implementation.<div><div style=3D"display: =
block;"><div style=3D"-webkit-user-select: all; -webkit-user-drag: =
element; display: inline-block;" class=3D"apple-rich-link" =
draggable=3D"true" role=3D"link" =
data-url=3D"https://qemu-project.gitlab.io/qemu/about/removed-features.htm=
l#virtiofsd-removed-in-8-0"><a =
style=3D"border-radius:10px;font-family:-apple-system, Helvetica, Arial, =
sans-serif;display:block;-webkit-user-select:none;width:300px;user-select:=
none;-webkit-user-modify:read-only;user-modify:read-only;overflow:hidden;t=
ext-decoration:none;" class=3D"lp-rich-link" rel=3D"nofollow" =
href=3D"https://qemu-project.gitlab.io/qemu/about/removed-features.html#vi=
rtiofsd-removed-in-8-0" dir=3D"ltr" role=3D"button" draggable=3D"false" =
width=3D"300"><table =
style=3D"table-layout:fixed;border-collapse:collapse;width:300px;backgroun=
d-color:#E5E6E9;font-family:-apple-system, Helvetica, Arial, =
sans-serif;" class=3D"lp-rich-link-emailBaseTable" cellpadding=3D"0" =
cellspacing=3D"0" border=3D"0" width=3D"300"><tbody><tr><td =
vertical-align=3D"center"><table bgcolor=3D"#E5E6E9" cellpadding=3D"0" =
cellspacing=3D"0" width=3D"300" style=3D"font-family:-apple-system, =
Helvetica, Arial, =
sans-serif;table-layout:fixed;background-color:rgba(229, 230, 233, 1);" =
class=3D"lp-rich-link-captionBar"><tbody><tr><td style=3D"padding:8px =
0px 8px 0px;" class=3D"lp-rich-link-captionBar-textStackItem"><div =
style=3D"max-width:100%;margin:0px 16px 0px 16px;overflow:hidden;" =
class=3D"lp-rich-link-captionBar-textStack"><div =
style=3D"word-wrap:break-word;font-weight:500;font-size:12px;overflow:hidd=
en;text-overflow:ellipsis;text-align:left;" =
class=3D"lp-rich-link-captionBar-textStack-topCaption-leading"><a =
rel=3D"nofollow" =
href=3D"https://qemu-project.gitlab.io/qemu/about/removed-features.html#vi=
rtiofsd-removed-in-8-0" style=3D"text-decoration: none" =
draggable=3D"false"><font color=3D"#272727" style=3D"color: rgba(0, 0, =
0, 0.847059);">Removed features =E2=80=94 QEMU =
documentation</font></a></div><div =
style=3D"word-wrap:break-word;font-weight:400;font-size:11px;overflow:hidd=
en;text-overflow:ellipsis;text-align:left;" =
class=3D"lp-rich-link-captionBar-textStack-bottomCaption-leading"><a =
rel=3D"nofollow" =
href=3D"https://qemu-project.gitlab.io/qemu/about/removed-features.html#vi=
rtiofsd-removed-in-8-0" style=3D"text-decoration: none" =
draggable=3D"false"><font color=3D"#808080" style=3D"color: rgba(0, 0, =
0, 0.498039);">qemu-project.gitlab.io</font></a></div></div></td><td =
style=3D"padding:6px 12px 6px 0px;" =
class=3D"lp-rich-link-captionBar-rightIconItem" width=3D"36"><a =
rel=3D"nofollow" =
href=3D"https://qemu-project.gitlab.io/qemu/about/removed-features.html#vi=
rtiofsd-removed-in-8-0" draggable=3D"false"><img =
style=3D"pointer-events:none =
!important;display:inline-block;width:36px;height:36px;border-radius:3px;"=
 height=3D"36" draggable=3D"false" =
class=3D"lp-rich-link-captionBar-rightIcon" alt=3D"qemu_32x32.png" =
src=3D"cid:C92A9DB9-757E-4822-81BA-3D54A815062B"></a></td></tr></tbody></t=
able></td></tr></tbody></table></a></div></div></div><div><br></div><div>B=
rowsing and searching the qemu source, it sure looks like the qemu =
implementation is gone. tools/virtiofsd is there in 7.2, gone in =
8.0.</div><div><br></div><div>Searching a bit, it seems the rust =
implementation is Linux-only. I read this email thread as saying =
that=E2=80=99s true, with the addiitonal point that the writer had =
gotten some subset working for another use case.</div><div><div =
style=3D"display: block;"><div style=3D"-webkit-user-select: all; =
-webkit-user-drag: element; display: inline-block;" =
class=3D"apple-rich-link" draggable=3D"true" role=3D"link" =
data-url=3D"https://listman.redhat.com/archives/virtio-fs/2021-April/00302=
1.html"><a style=3D"border-radius:10px;font-family:-apple-system, =
Helvetica, Arial, =
sans-serif;display:block;-webkit-user-select:none;width:300px;user-select:=
none;-webkit-user-modify:read-only;user-modify:read-only;overflow:hidden;t=
ext-decoration:none;" class=3D"lp-rich-link" rel=3D"nofollow" =
href=3D"https://listman.redhat.com/archives/virtio-fs/2021-April/003021.ht=
ml" dir=3D"ltr" role=3D"button" draggable=3D"false" width=3D"300"><table =
style=3D"table-layout:fixed;border-collapse:collapse;width:300px;backgroun=
d-color:#E5E6E9;font-family:-apple-system, Helvetica, Arial, =
sans-serif;" class=3D"lp-rich-link-emailBaseTable" cellpadding=3D"0" =
cellspacing=3D"0" border=3D"0" width=3D"300"><tbody><tr><td =
vertical-align=3D"center"><table bgcolor=3D"#E5E6E9" cellpadding=3D"0" =
cellspacing=3D"0" width=3D"300" style=3D"font-family:-apple-system, =
Helvetica, Arial, =
sans-serif;table-layout:fixed;background-color:rgba(229, 230, 233, 1);" =
class=3D"lp-rich-link-captionBar"><tbody><tr><td style=3D"padding:8px =
0px 8px 0px;" class=3D"lp-rich-link-captionBar-textStackItem"><div =
style=3D"max-width:100%;margin:0px 16px 0px 16px;overflow:hidden;" =
class=3D"lp-rich-link-captionBar-textStack"><div =
style=3D"word-wrap:break-word;font-weight:500;font-size:12px;overflow:hidd=
en;text-overflow:ellipsis;text-align:left;" =
class=3D"lp-rich-link-captionBar-textStack-topCaption-leading"><a =
rel=3D"nofollow" =
href=3D"https://listman.redhat.com/archives/virtio-fs/2021-April/003021.ht=
ml" style=3D"text-decoration: none" draggable=3D"false"><font =
color=3D"#272727" style=3D"color: rgba(0, 0, 0, 0.847059);">[Virtio-fs] =
Compiling virtio-fs/qemu on Mac</font></a></div><div =
style=3D"word-wrap:break-word;font-weight:400;font-size:11px;overflow:hidd=
en;text-overflow:ellipsis;text-align:left;" =
class=3D"lp-rich-link-captionBar-textStack-bottomCaption-leading"><a =
rel=3D"nofollow" =
href=3D"https://listman.redhat.com/archives/virtio-fs/2021-April/003021.ht=
ml" style=3D"text-decoration: none" draggable=3D"false"><font =
color=3D"#808080" style=3D"color: rgba(0, 0, 0, =
0.498039);">listman.redhat.com</font></a></div></div></td><td =
style=3D"padding:0px 12px 0px 0px;" =
class=3D"lp-rich-link-captionBar-rightIconItem" width=3D"36"><a =
rel=3D"nofollow" =
href=3D"https://listman.redhat.com/archives/virtio-fs/2021-April/003021.ht=
ml" draggable=3D"false"><img =
src=3D"data:image/png;base64,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3D=
" draggable=3D"false" style=3D"pointer-events:none =
!important;display:inline-block;width:36px;height:36px;" =
class=3D"lp-rich-link-captionBar-rightIcon" width=3D"36" height=3D"36" =
data-unique-identifier=3D""></a></td></tr></tbody></table></td></tr></tbod=
y></table></a></div></div><div><br></div>I've been running on a macos =
host and a Linux (Red Hat-based) guest. Worked fine when I had virtiofsd =
implementation.</div><div>Alternatives?</div><div>- RH seems allergic to =
9P filesystem for host file access, the qemu alternative I=E2=80=99m =
finding.</div><div>- Or I=E2=80=99m pointed to NFS which operationally =
I=E2=80=99m not wanting to do.</div><div>- Ubuntu ships a 9P client. =
Ideally I=E2=80=99d not have to switch to that =
distribution.</div><div><br></div><div>Anyone more clued in know if =
there=E2=80=99s some expectation / roadmap / hope that we=E2=80=99ll get =
a more portable virtiofsd on the horizon? Or is there another =
alternative I=E2=80=99m missing?<br><div><br></div><div><div =
style=3D"display: block;">John</div><br><div><br><div>
<span class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px; font-variant-ligatures: normal; =
font-variant-alternates: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-weight: normal; line-height: normal;"><span =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><div>--</div><div>John Maline</div><div>jmaline@mac.com</div><br =
class=3D"Apple-interchange-newline"></span></span>
</div>

<br></div></div></div></div><br><br><div>
<span class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><span =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><div>--</div><div>John Maline</div><div>jmaline@mac.com</div><br =
class=3D"Apple-interchange-newline"></span></span>
</div>
<br></body></html>=

--Apple-Mail=_B02BAE0A-AA7A-4FAF-981B-BB4D6D9FD5C8
Content-Transfer-Encoding: base64
Content-Disposition: inline;
	filename=qemu_32x32.png
Content-Type: image/png;
	x-unix-mode=0666;
	name="qemu_32x32.png"
Content-Id: <C92A9DB9-757E-4822-81BA-3D54A815062B>

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
--Apple-Mail=_B02BAE0A-AA7A-4FAF-981B-BB4D6D9FD5C8--

--Apple-Mail=_3A8C90D1-64F5-4F37-874D-1E462E8D1E13--

