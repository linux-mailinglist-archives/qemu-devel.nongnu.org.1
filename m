Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F28B716212
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:35:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zUR-0004fy-3c; Tue, 30 May 2023 09:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1q3vBg-0008Kz-9B
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:58:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1q3vBd-00023K-VD
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:58:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34U8spGa001304; Tue, 30 May 2023 08:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=qcppdkim1; bh=Evo0xXZWThHYVUxogBq80ZvDXYzHAq3/NVEkgotUjpk=;
 b=nPxMkwbI3m8wNp5VLCzQQdEzUjJwhUiswZwYfdjm1Sd69F9Q340U5oWaqW5tYhCRSk3v
 FrxR+gphBcq2etNayoMWLlC6N1jYSrxQGbBmCJ9htI4h82pgKJrNar4rR6O5QlsB6Aku
 Mj7r1GgygO/hpLHgjyTPmkYABH2fwgCYrtehMMB/apskJXhk9BY4GDTt1l7QQ85Widzb
 +R2uG5l+iCeDQw1cZhwuDTpJRD75IOydwA56G99z9MRTgECDU2iGJm6ZHWtV1udAx82K
 h1pgh62VVGt2yKGJvqbJ2lM5evsyvJxRVnXq4tEIp/d+3k7EsOHvEaY/V98RsiBEev2O Dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw83crn6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 08:57:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34U8vYcJ028238
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 08:57:34 GMT
Received: from smtpclient.apple (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 30 May
 2023 01:57:26 -0700
From: Mark Burton <quic_mburton@quicinc.com>
Message-ID: <981F78E0-D8E1-41FF-A421-9A74CAE50B99@quicinc.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_F1B7D166-A2ED-45BB-9414-4BBB89D53576"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: QEMU developers fortnightly call for agenda - 2023-05-29
Date: Tue, 30 May 2023 10:57:24 +0200
In-Reply-To: <calendar-ce7061a5-eb12-4714-b952-732b206d497a@google.com>
CC: <afaerber@suse.de>, Alessandro Di Federico <ale@rev.ng>, <anjo@rev.ng>,
 <bazulay@redhat.com>, <bbauman@redhat.com>,
 <chao.p.peng@linux.intel.com>, <cjia@nvidia.com>, <cw@f00f.org>,
 <david.edmondson@oracle.com>, <dustin.kirkland@canonical.com>,
 <eblake@redhat.com>, <edgar.iglesias@gmail.com>,
 <elena.ufimtseva@oracle.com>, <eric.auger@redhat.com>,
 <f4bug@amsat.org>, Felipe Franciosi <felipe.franciosi@nutanix.com>,
 "iggy@theiggy.com" <iggy@kws1.com>, Warner Losh <wlosh@bsdimp.com>,
 <jan.kiszka@web.de>, <jgg@nvidia.com>, <jidong.xiao@gmail.com>,
 <jjherne@linux.vnet.ibm.com>, <joao.m.martins@oracle.com>,
 <konrad.wilk@oracle.com>, <kvm@vger.kernel.org>, <mdean@redhat.com>,
 <mimu@linux.vnet.ibm.com>, <peter.maydell@linaro.org>,
 <qemu-devel@nongnu.org>, <quintela@redhat.com>,
 <richard.henderson@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
 <stefanha@gmail.com>, <wei.w.wang@intel.com>, <z.huo@139.com>,
 <zwu.kernel@gmail.com>
To: <juan.quintela@gmail.com>
References: <calendar-ce7061a5-eb12-4714-b952-732b206d497a@google.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: ZLmzCa_Es4tQrEbuVFzS5TYGwMm4QN7p
X-Proofpoint-GUID: ZLmzCa_Es4tQrEbuVFzS5TYGwMm4QN7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_06,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mburton@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 May 2023 09:33:57 -0400
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

--Apple-Mail=_F1B7D166-A2ED-45BB-9414-4BBB89D53576
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

(Sorry Juan - I do have a question)

We do have a question, about using Instruction abort in HVF/KVM - =
we=E2=80=99re like to explain, and ask if a patch would be acceptable.

Cheers
Mark.


> On 28 May 2023, at 19:50, juan.quintela@gmail.com wrote:
>=20
> WARNING: This email originated from outside of Qualcomm. Please be =
wary of any links or attachments, and do not enable macros.
>=20
>  =20
> Hi
> If you had any topics for Tuesday call, please let's us know.
>=20
> Thanks, Juan.
>=20
> QEMU developers fortnightly conference call
> Tuesday 2023-05-30 =E2=8B=85 15:00 =E2=80=93 16:00 (Central European =
Time - Madrid)
> If you need call details, please contact me: quintela@redhat.com =
<mailto:quintela@redhat.com>
> Location
> https://meet.jit.si/kvmcallmeeting =
<https://meet.jit.si/kvmcallmeeting>
> View map =
<https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting=
&sa=3DD&ust=3D1685728200000000&usg=3DAOvVaw2zgoxlN4h2wBZVSbLdQ6uR>
> Guests
> Philippe Mathieu-Daud=C3=A9 <mailto:f4bug@amsat.org>
> Joao Martins <mailto:joao.m.martins@oracle.com>
> quintela@redhat.com <mailto:quintela@redhat.com>
> Meirav Dean <mailto:mdean@redhat.com>
> Felipe Franciosi <mailto:felipe@nutanix.com>
> afaerber@suse.de <mailto:afaerber@suse.de>
> bazulay@redhat.com <mailto:bazulay@redhat.com>
> bbauman@redhat.com <mailto:bbauman@redhat.com>
> cw@f00f.org <mailto:cw@f00f.org>
> dustin.kirkland@canonical.com <mailto:dustin.kirkland@canonical.com>
> eblake@redhat.com <mailto:eblake@redhat.com>
> edgar.iglesias@gmail.com <mailto:edgar.iglesias@gmail.com>
> eric.auger@redhat.com <mailto:eric.auger@redhat.com>
> iggy@theiggy.com <mailto:iggy@theiggy.com>
> jan.kiszka@web.de <mailto:jan.kiszka@web.de>
> jidong.xiao@gmail.com <mailto:jidong.xiao@gmail.com>
> jjherne@linux.vnet.ibm.com <mailto:jjherne@linux.vnet.ibm.com>
> mimu@linux.vnet.ibm.com <mailto:mimu@linux.vnet.ibm.com>
> Peter Maydell <mailto:peter.maydell@linaro.org>
> richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>
> stefanha@gmail.com <mailto:stefanha@gmail.com>
> Warner Losh <mailto:imp@bsdimp.com>
> z.huo@139.com <mailto:z.huo@139.com>
> zwu.kernel@gmail.com <mailto:zwu.kernel@gmail.com>
> Jason Gunthorpe <mailto:jgg@nvidia.com>
> Neo Jia <mailto:cjia@nvidia.com>
> David Edmondson <mailto:david.edmondson@oracle.com>
> Elena Ufimtseva <mailto:elena.ufimtseva@oracle.com>
> Konrad Wilk <mailto:konrad.wilk@oracle.com>
> ale@rev.ng <mailto:ale@rev.ng>
> anjo@rev.ng <mailto:anjo@rev.ng>
> Shameerali Kolothum Thodi =
<mailto:shameerali.kolothum.thodi@huawei.com>
> Wang, Wei W <mailto:wei.w.wang@intel.com>
> Chao Peng <mailto:chao.p.peng@linux.intel.com>
> kvm-devel <mailto:kvm@vger.kernel.org>
> qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>
> mburton@qti.qualcomm.com <mailto:mburton@qti.qualcomm.com>

--Apple-Mail=_F1B7D166-A2ED-45BB-9414-4BBB89D53576
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" =
class=3D"">(Sorry Juan - I do have a question)<div class=3D""><br =
class=3D""></div><div class=3D"">We do have a question, about using =
Instruction abort in HVF/KVM - we=E2=80=99re like to explain, and ask if =
a patch would be acceptable.</div><div class=3D""><br =
class=3D""></div><div class=3D"">Cheers</div><div =
class=3D"">Mark.</div><div class=3D""><br class=3D""><div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On 28 =
May 2023, at 19:50, <a href=3D"mailto:juan.quintela@gmail.com" =
class=3D"">juan.quintela@gmail.com</a> wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><meta =
charset=3D"UTF-8" class=3D""><p style=3D"display: block; margin: 13px =
0px; caret-color: rgb(0, 0, 0); font-family: Roboto, Helvetica, Arial, =
sans-serif; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; text-align: =
center;" class=3D""><span style=3D"background-color: rgb(255, 255, 0); =
font-size: 14px; font-family: sans-serif;" class=3D""><strong =
class=3D"">WARNING:</strong><span =
class=3D"Apple-converted-space">&nbsp;</span>This email originated from =
outside of Qualcomm. Please be wary of any links or attachments, and do =
not enable macros.</span></p><div style=3D"caret-color: rgb(0, 0, 0); =
font-family: Roboto, Helvetica, Arial, sans-serif; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
itemscope=3D"" itemtype=3D"http://schema.org/InformAction" =
class=3D""><span itemprop=3D"object" itemscope=3D"" =
itemtype=3D"http://schema.org/Event" class=3D""><span =
itemprop=3D"publisher" itemscope=3D"" =
itemtype=3D"http://schema.org/Organization" class=3D""></span><span =
aria-hidden=3D"true" class=3D""><time itemprop=3D"startDate" =
datetime=3D"20230530T130000Z" class=3D""></time><time itemprop=3D"endDate"=
 datetime=3D"20230530T140000Z" class=3D""></time></span><table =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
align=3D"center" class=3D"body-container" style=3D"padding-left: 16px; =
padding-right: 16px; width: 1031px;"><tbody class=3D""><tr class=3D""><td =
class=3D"" align=3D"left"><div aria-hidden=3D"true" style=3D"height: =
16px;" class=3D"">&nbsp;<span =
class=3D"Apple-converted-space">&nbsp;</span></div><table border=3D"0" =
cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center"=
 class=3D"" style=3D"width: 1031px;"><tbody class=3D""><tr class=3D""><td =
class=3D"" align=3D"left"><span itemscope=3D"" =
itemtype=3D"http://schema.org/EmailMessage" class=3D""><p =
itemprop=3D"description" style=3D"display: block; margin: 13px 0px;" =
class=3D"">Hi<br class=3D"">If you had any topics for Tuesday call, =
please let's us know.</p><p style=3D"display: block; margin: 13px 0px;" =
class=3D"">Thanks, Juan.</p></span></td></tr></tbody></table><table =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
align=3D"center" class=3D"" style=3D"width: 1031px;"><tbody class=3D""><tr=
 class=3D""><td class=3D"main-container-inner" style=3D"padding: 24px =
32px; border: 1px solid rgb(218, 220, 224); border-radius: 8px; =
direction: rtl; font-size: 0px; text-align: left; vertical-align: =
top;"><div class=3D"" style=3D"font-size: 13px; text-align: left; =
direction: ltr; display: inline-block; vertical-align: top; width: =
965px; overflow: hidden; word-wrap: break-word;"><table border=3D"0" =
cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%" =
class=3D"main-column-table-ltr" style=3D"padding-right: 32px; =
padding-left: 0px; table-layout: fixed;"><tbody class=3D""><tr =
class=3D""><td class=3D"main-column-td" style=3D"padding: 0px; =
vertical-align: top;"><table border=3D"0" cellpadding=3D"0" =
cellspacing=3D"0" role=3D"presentation" width=3D"100%" =
style=3D"table-layout: fixed;" class=3D""><tbody class=3D""><tr =
class=3D""><td style=3D"font-size: 0px; padding: 0px 0px 2px; =
text-align: left; word-break: break-word;" class=3D""><div =
class=3D"primary-text" role=3D"presentation" style=3D"color: rgb(60, 64, =
67); font-family: &quot;Google Sans&quot;, Roboto, sans-serif; =
font-weight: 400; font-size: 22px; line-height: 28px; text-decoration: =
none;"><span itemprop=3D"name" class=3D"">QEMU developers fortnightly =
conference call</span></div></td></tr><tr class=3D""><td =
style=3D"font-size: 0px; padding: 0px 0px 24px; text-align: left; =
word-break: break-word;" class=3D""><div class=3D"primary-text" =
role=3D"presentation" style=3D"color: rgb(60, 64, 67); font-family: =
Roboto, sans-serif; font-style: normal; font-weight: 400; font-size: =
14px; line-height: 20px; letter-spacing: 0.2px; text-decoration: =
none;"><span aria-hidden=3D"true" class=3D""><time itemprop=3D"startDate" =
datetime=3D"20230530T130000Z" class=3D""></time><time itemprop=3D"endDate"=
 datetime=3D"20230530T140000Z" class=3D""></time></span><span =
class=3D"">Tuesday 2023-05-30 =E2=8B=85 15:00 =E2=80=93 16:00 (Central =
European Time - Madrid)</span></div></td></tr><tr class=3D""><td =
style=3D"font-size: 0px; padding: 0px 0px 24px; text-align: left; =
word-break: break-word;" class=3D""><div class=3D"primary-text" =
role=3D"presentation" style=3D"color: rgb(60, 64, 67); font-family: =
Roboto, sans-serif; font-style: normal; font-weight: 400; font-size: =
14px; line-height: 20px; letter-spacing: 0.2px; text-decoration: =
none;"><span class=3D"">If you need call details, please contact =
me:<span class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"mailto:quintela@redhat.com" target=3D"_blank" =
class=3D"">quintela@redhat.com</a></span></div></td></tr><tr =
class=3D""><td style=3D"font-size: 0px; padding: 0px 0px 24px; =
text-align: left; word-break: break-word;" class=3D""><div =
class=3D"primary-text" role=3D"presentation" style=3D"color: rgb(60, 64, =
67); font-family: Roboto, sans-serif; font-style: normal; font-weight: =
400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px; =
text-decoration: none;"><table border=3D"0" cellpadding=3D"0" =
cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;" =
class=3D""><tbody class=3D""><tr class=3D""><td class=3D""><h2 =
class=3D"primary-text" style=3D"color: rgb(60, 64, 67); font-size: 14px; =
text-decoration: none; font-weight: 700; -webkit-font-smoothing: =
antialiased; margin: 0px; padding: =
0px;">Location</h2></td></tr></tbody></table><span itemprop=3D"location" =
itemscope=3D"" itemtype=3D"http://schema.org/Place" class=3D""><span =
itemprop=3D"name" class=3D"primary-text notranslate" style=3D"color: =
rgb(60, 64, 67); font-family: Roboto, sans-serif; font-style: normal; =
font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: =
0.2px; text-decoration: none;"><a =
href=3D"https://meet.jit.si/kvmcallmeeting" =
class=3D"">https://meet.jit.si/kvmcallmeeting</a></span><br class=3D""><a =
href=3D"https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcall=
meeting&amp;sa=3DD&amp;ust=3D1685728200000000&amp;usg=3DAOvVaw2zgoxlN4h2wB=
ZVSbLdQ6uR" class=3D"accent-text underline-on-hover" target=3D"_blank" =
itemprop=3D"map" style=3D"color: rgb(26, 115, 232); display: =
inline-block; text-decoration: none; font-weight: 700;">View =
map</a></span></div></td></tr><tr class=3D""><td style=3D"font-size: =
0px; padding: 0px 0px 24px; text-align: left; word-break: break-word;" =
class=3D""><div class=3D"primary-text" role=3D"presentation" =
style=3D"color: rgb(60, 64, 67); font-family: Roboto, sans-serif; =
font-style: normal; font-weight: 400; font-size: 14px; line-height: =
20px; letter-spacing: 0.2px; text-decoration: none;"><table border=3D"0" =
cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
style=3D"padding-bottom: 4px;" class=3D""><tbody class=3D""><tr =
class=3D""><td class=3D""><h2 class=3D"primary-text" style=3D"color: =
rgb(60, 64, 67); font-size: 14px; text-decoration: none; font-weight: =
700; -webkit-font-smoothing: antialiased; margin: 0px; padding: =
0px;">Guests</h2></td></tr></tbody></table><div style=3D"padding-bottom: =
4px; text-align: left; color: rgb(60, 64, 66);" class=3D""><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:f4bug@amsat.org" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: none;">Philippe =
Mathieu-Daud=C3=A9</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:joao.m.martins@oracle.com" =
style=3D"color: rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">Joao Martins</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:quintela@redhat.com" style=3D"color: =
rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">quintela@redhat.com</a></span></span><span class=3D"secondary-text"=
 style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:mdean@redhat.com" style=3D"color: =
rgb(60, 64, 67); display: inline-block; text-decoration: none;">Meirav =
Dean</a></span></span><span class=3D"secondary-text" style=3D"color: =
rgb(112, 117, 122); text-decoration: none;"></span></div><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:felipe@nutanix.com" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: none;">Felipe =
Franciosi</a></span></span><span class=3D"secondary-text" style=3D"color: =
rgb(112, 117, 122); text-decoration: none;"></span></div><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:afaerber@suse.de" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: =
none;">afaerber@suse.de</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:bazulay@redhat.com" style=3D"color: =
rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">bazulay@redhat.com</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:bbauman@redhat.com" style=3D"color: =
rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">bbauman@redhat.com</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:cw@f00f.org" style=3D"color: rgb(60, =
64, 67); display: inline-block; text-decoration: =
none;">cw@f00f.org</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:dustin.kirkland@canonical.com" =
style=3D"color: rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">dustin.kirkland@canonical.com</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" =
href=3D"mailto:eblake@redhat.com" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: =
none;">eblake@redhat.com</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:edgar.iglesias@gmail.com" =
style=3D"color: rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">edgar.iglesias@gmail.com</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" =
href=3D"mailto:eric.auger@redhat.com" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: =
none;">eric.auger@redhat.com</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" href=3D"mailto:iggy@theiggy.com"=
 style=3D"color: rgb(60, 64, 67); display: inline-block; =
text-decoration: none;">iggy@theiggy.com</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" =
href=3D"mailto:jan.kiszka@web.de" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: =
none;">jan.kiszka@web.de</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:jidong.xiao@gmail.com" style=3D"color: =
rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">jidong.xiao@gmail.com</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" =
href=3D"mailto:jjherne@linux.vnet.ibm.com" style=3D"color: rgb(60, 64, =
67); display: inline-block; text-decoration: =
none;">jjherne@linux.vnet.ibm.com</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" =
href=3D"mailto:mimu@linux.vnet.ibm.com" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: =
none;">mimu@linux.vnet.ibm.com</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" =
href=3D"mailto:peter.maydell@linaro.org" style=3D"color: rgb(60, 64, =
67); display: inline-block; text-decoration: none;">Peter =
Maydell</a></span></span><span class=3D"secondary-text" style=3D"color: =
rgb(112, 117, 122); text-decoration: none;"></span></div><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:richard.henderson@linaro.org" style=3D"color: rgb(60, 64, =
67); display: inline-block; text-decoration: =
none;">richard.henderson@linaro.org</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" =
href=3D"mailto:stefanha@gmail.com" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: =
none;">stefanha@gmail.com</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:imp@bsdimp.com" style=3D"color: =
rgb(60, 64, 67); display: inline-block; text-decoration: none;">Warner =
Losh</a></span></span><span class=3D"secondary-text" style=3D"color: =
rgb(112, 117, 122); text-decoration: none;"></span></div><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:z.huo@139.com" style=3D"color: rgb(60, 64, 67); display: =
inline-block; text-decoration: =
none;">z.huo@139.com</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:zwu.kernel@gmail.com" style=3D"color: =
rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">zwu.kernel@gmail.com</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" href=3D"mailto:jgg@nvidia.com" =
style=3D"color: rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">Jason Gunthorpe</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:cjia@nvidia.com" style=3D"color: =
rgb(60, 64, 67); display: inline-block; text-decoration: none;">Neo =
Jia</a></span></span><span class=3D"secondary-text" style=3D"color: =
rgb(112, 117, 122); text-decoration: none;"></span></div><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:david.edmondson@oracle.com" style=3D"color: rgb(60, 64, =
67); display: inline-block; text-decoration: none;">David =
Edmondson</a></span></span><span class=3D"secondary-text" style=3D"color: =
rgb(112, 117, 122); text-decoration: none;"></span></div><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:elena.ufimtseva@oracle.com" style=3D"color: rgb(60, 64, =
67); display: inline-block; text-decoration: none;">Elena =
Ufimtseva</a></span></span><span class=3D"secondary-text" style=3D"color: =
rgb(112, 117, 122); text-decoration: none;"></span></div><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:konrad.wilk@oracle.com" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: none;">Konrad =
Wilk</a></span></span><span class=3D"secondary-text" style=3D"color: =
rgb(112, 117, 122); text-decoration: none;"></span></div><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:ale@rev.ng" style=3D"color: rgb(60, 64, 67); display: =
inline-block; text-decoration: none;">ale@rev.ng</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" href=3D"mailto:anjo@rev.ng" =
style=3D"color: rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">anjo@rev.ng</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:shameerali.kolothum.thodi@huawei.com" =
style=3D"color: rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">Shameerali Kolothum Thodi</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" =
href=3D"mailto:wei.w.wang@intel.com" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: none;">Wang, Wei =
W</a></span></span><span class=3D"secondary-text" style=3D"color: =
rgb(112, 117, 122); text-decoration: none;"></span></div><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:chao.p.peng@linux.intel.com" style=3D"color: rgb(60, 64, =
67); display: inline-block; text-decoration: none;">Chao =
Peng</a></span></span><span class=3D"secondary-text" style=3D"color: =
rgb(112, 117, 122); text-decoration: none;"></span></div><div =
class=3D""><span itemprop=3D"attendee" itemscope=3D"" =
itemtype=3D"http://schema.org/Person" class=3D""><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" =
href=3D"mailto:kvm@vger.kernel.org" style=3D"color: rgb(60, 64, 67); =
display: inline-block; text-decoration: =
none;">kvm-devel</a></span></span><span class=3D"secondary-text" =
style=3D"color: rgb(112, 117, 122); text-decoration: =
none;"></span></div><div class=3D""><span itemprop=3D"attendee" =
itemscope=3D"" itemtype=3D"http://schema.org/Person" class=3D""><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" href=3D"mailto:qemu-devel@nongnu.org" style=3D"color: =
rgb(60, 64, 67); display: inline-block; text-decoration: =
none;">qemu-devel@nongnu.org</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: none;"></span></div><div class=3D""><span =
itemprop=3D"attendee" itemscope=3D"" itemtype=3D"http://schema.org/Person"=
 class=3D""><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" =
href=3D"mailto:mburton@qti.qualcomm.com" style=3D"color: rgb(60, 64, =
67); display: inline-block; text-decoration: =
none;">mburton@qti.qualcomm.com</a></span></span><span =
class=3D"secondary-text" style=3D"color: rgb(112, 117, 122); =
text-decoration: =
none;"></span></div></div></div></td></tr></tbody></table></td></tr></tbod=
y></table></div></td></tr></tbody></table></td></tr></tbody></table></span=
></span></div></div></blockquote></div><br class=3D""></div></body></html>=

--Apple-Mail=_F1B7D166-A2ED-45BB-9414-4BBB89D53576--

