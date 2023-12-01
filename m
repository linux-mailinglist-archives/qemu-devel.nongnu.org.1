Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C923800CC6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:01:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r944r-0002Po-5D; Fri, 01 Dec 2023 09:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentao.jia@nephogine.com>)
 id 1r90ZQ-0005kb-Dy
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:16:28 -0500
Received: from mail-dm6nam10on2118.outbound.protection.outlook.com
 ([40.107.93.118] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentao.jia@nephogine.com>)
 id 1r90ZN-0004ZM-7q
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:16:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBUFWafuT71ywDh9U6l4jmZy1s9KzNk6Cp2/t+ooMCSG1T579mTpe+n/XGNLhR64yQ5Inu3/zgWRrPxwa+NbSZbstsUVoxaESrFFEkNzSCARspWlVXXLV1ruwFQmCyJaBZRZIfuODJrfSzxYVgK3dA8jQBzPs+NVUCMaPMoWjTnbyxSN4LvGjKV0BKniN/XDC/RnU4QR8dlAMeQK7bMeVIHKLMat8TWD+kVFadoWKliZCZvipTrSUPj8rYYKjd0awP/X487abWs6JxzTa4//CloPoJa8UCMch021IMJSVlnM30OW/YRZuMetWR9VZDGbrUguP/JGtCBg227cUsWFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6wJ8D8iRyquW4C4xpf7M9/DZjTWDC7OlS6Ttaw5xi4=;
 b=fykTJa0hZd2bWI15mWJiSPqrptMLQfb53PS1ilzrUJFgKiCiBAotXMnsptzqjlGkeH0xvdBZtgmMB4UA7cF8R50bcVC5K/yi7z+SA8Z8cg+D2uPsEXWfS/KyMJ2HlZaA562ElSbA2AduYRT3E/4mNpyg+xcWt8rBaJEIhz0LyYLBFmjDlXYHkE/keCrvR7OY+zd/rKx+8PPgz+sV4xYBcGkDyFIkPqQMRzJAae06seZE2pDyMjwm53q17hsG026+PguoLigNl0ytUIrq3689yEWYTWkowMgKJ971z78A2ZeHWu92Me8kIOp/Yd5KkJaIKgY/+kIbf9SWGCZtEfmovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nephogine.com; dmarc=pass action=none
 header.from=nephogine.com; dkim=pass header.d=nephogine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nephogine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6wJ8D8iRyquW4C4xpf7M9/DZjTWDC7OlS6Ttaw5xi4=;
 b=Dj3IeDf+QM4SCruZmvRbWxElApdrMUuWXvgrRDbuxa1gUKlw81Mahb3KUE0I+rWRA00fIyVdZjVOFmT9Lqi3H2m09Z1tdyxLFWXgMuQbA+LtB7aog8Y3w2K7erXRaGFJ6HBWiHLYcBYg4hZzhsW6wl7DWpNo8hFlg/Wh5HjboD5UM3tPbaxozIVh/Se9Ar+dhSVCHFJzr4HUKohjpksJo29ca8RBsYQT56vfG5wRDo2nxgGwMznE6fhp0+5HeefnYqxj1JjUgaJu8kgO5ATQzytX1rtFnFV0OXmn0XiDn47qeYrNcSRVVYLqDCOBCMtEkLAsR7Y9eJV7D7Cr5dJvgQ==
Received: from SN4PR13MB5727.namprd13.prod.outlook.com (2603:10b6:806:213::12)
 by CO6PR13MB5321.namprd13.prod.outlook.com (2603:10b6:303:148::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 10:11:15 +0000
Received: from SN4PR13MB5727.namprd13.prod.outlook.com
 ([fe80::523c:c466:5715:81d6]) by SN4PR13MB5727.namprd13.prod.outlook.com
 ([fe80::523c:c466:5715:81d6%7]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 10:11:15 +0000
From: Wentao Jia <wentao.jia@nephogine.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Topic: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Index: AdokPrZLsAJfb0btQhCy7EbMDce/Eg==
Date: Fri, 1 Dec 2023 10:11:15 +0000
Message-ID: <SN4PR13MB5727A538887598415C5A37D28681A@SN4PR13MB5727.namprd13.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nephogine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR13MB5727:EE_|CO6PR13MB5321:EE_
x-ms-office365-filtering-correlation-id: 10676cb8-82d8-4f87-eaa2-08dbf255da49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GVW8pMRK0xiD3WL4vQSrCXrsnq564a8ANqKSib7UeFK4WxDwd1J5+UmCESsu6r3a8A2QnVN5Qwpc5UANvt/xvKaUNXxq4hZju94n3au5GQbXdcCTBIDM+EAV6eGG7ka4yjJ5dRO8GPFV6Kahef5M3XeiYPx4pBjxTN4vUUb2VvERk+3miDCVE1W2R3LhNaNT1cvT9XTLlJOGsm/revQyk9DwVs7De+7EvqNHRHoLOQEX0kCyRXGSWsqVuLCVv5Qjpl3Lh7BQZ5zVZJ/53KeVu/mH+skCkST3S92AkIHmHrmzwrD9aheVE6LSrO+nUt4q9qQlYQRSmTlwuCI6acfpBkQnVxAcDXXWI9DkpNeBnKDK+PIilRKVZaGQfs7toqTIJU7ZgxqmznbzcBLzY6I4IU2QpvioYydfe1+as5WD7TG/5VucUrD5e52Ktuml0TAaQ66palMHTAaFGEWGdN4n5mMrF18mOJe0gTb3Y1FpUYA/OwZk8ov19wbFAxkNq1HC5oSbiPO4Y8YNdhW/nnh35b5fQdLxoLKcJKAXgmdmnqfCB85DTdd20fBXnRke/13y/iMB9fQMsgLYsKQv7ximj2ZB+TLsuknPP06MrOd1sl+7wMfyvkAwni/kmbLKd+lEZmuYZwQdZ//BwP/MIXgJip+s5oEVT59UabNPqA0j98=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR13MB5727.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39830400003)(376002)(366004)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(38100700002)(44832011)(52536014)(5660300002)(33656002)(2906002)(41300700001)(38070700009)(83380400001)(55016003)(64756008)(66476007)(66446008)(6916009)(66556008)(76116006)(66946007)(6506007)(7696005)(478600001)(71200400001)(26005)(9686003)(316002)(8936002)(8676002)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sGxPPx5l9VgQfzoVnWkvw70MkFlo1DH+CHgQhB/tFNceOTE/3PVX52cQhlTQ?=
 =?us-ascii?Q?AXQU3nRei/79ViO5BxWtvPO+yPicjQT+vqPBCAy5CfTUIPp0QLLhF7XBLT7D?=
 =?us-ascii?Q?3b0MSWeIA/plo6lUON38wnDiDbSbmkLS9ya8holfUa1eU8RLi/ibV2f+KUj/?=
 =?us-ascii?Q?ven5Qn8iArnFrwjcGXmIWC2gnHFl9NoIECrIQoaCYJexWXwLL1Jv9lBFrpn0?=
 =?us-ascii?Q?B8BHy0NGeEm5e9P3c3JoMqj/F2Jfn/yO2Y8CxkqgvmtrqPFSTxtM27WcGFd4?=
 =?us-ascii?Q?G+1FSwiXKR9WZwJbsVijQ9kssGMk6B+WgVjVAyaCNBs27dEYSxsGfQqaVBo5?=
 =?us-ascii?Q?aTVNSRnuvzmiTgpvOAVhtPN0c4V6fEU7CQKaXQa8+mmRRWhNt71YcbRPOGpo?=
 =?us-ascii?Q?wGTuh4yjhx0qG6l+kNhz+wr74C4vLQDPE2A8fkZ8vlQyrdt2JLkGVn1KHtnp?=
 =?us-ascii?Q?GUvswZwWfqJ+PizYl6UWG2EwgmkNSGswFts1IwAuqNSQOMWo0CygpdZ2CQv9?=
 =?us-ascii?Q?gBZhq1TqlLth4lSB/w+h/jh8c0ppDXPIImZc4pel1ujsX7DWOlllI0wYposp?=
 =?us-ascii?Q?iyRWub1veM2znmnr5DI9OhhgdHL8wu6snfh+cGu4WXwmMKiDxQxg+9sWhco4?=
 =?us-ascii?Q?jx24Lz8A3CqPHL3A2GEdvMB/Sfncent35h+69z/Tjb7EYZ0VXsmBHmwM/udA?=
 =?us-ascii?Q?qRPlksq7Ts2SQz3t4mZ6E/QRp89YUxHvNceD/poGnCdGNRoEgXCvLLiD8SPZ?=
 =?us-ascii?Q?RZaCQOo0KCy8EJpQBvS21pBnBDH5op8vmXVK8vlxMz5XJTp6NMBu7+3pBeMz?=
 =?us-ascii?Q?jKw/jiEDGhCmhwC47hIzsdSdDum128lc7r4qSP/qSHRxPyvQm+eRdw23wQcn?=
 =?us-ascii?Q?3qLEw5I3/tc9kiRxoszBcxnThxQ61qqN3PNizwIPAEp6oMlyFEZVTQCrK61c?=
 =?us-ascii?Q?1g8aHLMTxse6CzA38mY3E7VA/QsEHVnQhxEXjrjAS+bqnko8YiFGMvZlP/p0?=
 =?us-ascii?Q?NSrslklHnaCAgmEe+THR4VVjEkgTveXYy3+4tD2gTxyuwN3NSUZ77JKWVdsM?=
 =?us-ascii?Q?kazYvnwnGDJgZTUelHWCxDByCCq4zGlAAqJ7zsbIMwO6m6OLNpfcBfwr2TFP?=
 =?us-ascii?Q?u5AbYceTyauaIjymLuTo7Dx2rS5GE01WjIKOzgsZqT1u62QLeLzY7jOV1p/c?=
 =?us-ascii?Q?aKFV03bMHLa+ev8ibfkyqa60NzaSUXCLPz/XtmdtL+oue3OhUAgx5YW1SOjW?=
 =?us-ascii?Q?75h8g6omQmDZ2sRD6Gpw2Fozvv/mqEmWymZgoFcKKsjyuSssQlHkrWT4S+k5?=
 =?us-ascii?Q?2VHOTk9tM5TSJunJNA4Sixe4rPKXf1XsIXh7EBFG2bj9jFLI9j99YCbKOwyQ?=
 =?us-ascii?Q?kcdz7pxH8uwaLozEpFrbiM2ZkfQw0dBQz616pw0VkxnGhHxDrWCARDIGiX9z?=
 =?us-ascii?Q?EPc4CWv8N9Hf6/ovv71KKJ+YgEkb6ZvVigzG6YTc2BTH2HkTk8N0s9ptpazC?=
 =?us-ascii?Q?ELIhmEMhJgn8y09/hz72kKCedBApIFEXGwabTXmC7d3sEmqzlYH+6o5a2pmz?=
 =?us-ascii?Q?d8I+xGYmqb7Abkhvt0niIjFk3CU2pf8PxmIEK3bD?=
Content-Type: multipart/alternative;
 boundary="_000_SN4PR13MB5727A538887598415C5A37D28681ASN4PR13MB5727namp_"
MIME-Version: 1.0
X-OriginatorOrg: nephogine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR13MB5727.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10676cb8-82d8-4f87-eaa2-08dbf255da49
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 10:11:15.0967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0I9V1HWaCk9luUQHZMgJiqAXaxIvcGZLdiLsPZTCAt2LC+Qsv1/NV2tq9J83s447FqdfF21VPkgZnOADAWWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5321
Received-SPF: pass client-ip=40.107.93.118;
 envelope-from=wentao.jia@nephogine.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 01 Dec 2023 09:00:20 -0500
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

--_000_SN4PR13MB5727A538887598415C5A37D28681ASN4PR13MB5727namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA feature are important feat=
ure
for dpdk vdpa packets transmitting performance, add the 2 features at vhost=
-user
front-end to negotiation with backend.

Signed-off-by: Kyle Xu zhenbing.xu@corigine.com<mailto:zhenbing.xu@corigine=
.com>
Signed-off-by: Wentao Jia wentao.jia@corigine.com<mailto:wentao.jia@corigin=
e.com>
Reviewed-by:   Xinying Yu xinying.yu@corigine.com<mailto:xinying.yu@corigin=
e.com>
Reviewed-by:   Shujing Dong shujing.dong@corigine.com<mailto:shujing.dong@c=
origine.com>
Reviewed-by:   Rick Zhong zhaoyong.zhong@corigine.com<mailto:zhaoyong.zhong=
@corigine.com>
---
hw/net/vhost_net.c         | 2 ++
include/hw/virtio/virtio.h | 4 ++++
2 files changed, 6 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e8e1661646..211ca859a6 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -76,6 +76,8 @@ static const int user_feature_bits[] =3D {
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_IN_ORDER,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_RSS,
     VIRTIO_NET_F_HASH_REPORT,
     VIRTIO_NET_F_GUEST_USO4,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c8f72850bc..3880b6764c 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -369,6 +369,10 @@ typedef struct VirtIORNGConf VirtIORNGConf;
                       VIRTIO_F_RING_PACKED, false), \
     DEFINE_PROP_BIT64("queue_reset", _state, _field, \
                       VIRTIO_F_RING_RESET, true)
+    DEFINE_PROP_BIT64("notification_data", _state, _field, \
+                      VIRTIO_F_NOTIFICATION_DATA, true), \
+    DEFINE_PROP_BIT64("in_order", _state, _field, \
+                      VIRTIO_F_IN_ORDER, true)

hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
--

--_000_SN4PR13MB5727A538887598415C5A37D28681ASN4PR13MB5727namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:DengXian;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">VIRTIO_F_IN_ORDER and VIRTIO_F_=
NOTIFICATION_DATA feature are important feature<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">for dpdk vdpa packets transmitt=
ing performance, add the 2 features at vhost-user<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">front-end to negotiation with b=
ackend.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Kyle Xu <a href=
=3D"mailto:zhenbing.xu@corigine.com">
zhenbing.xu@corigine.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Wentao Jia <a hr=
ef=3D"mailto:wentao.jia@corigine.com">
wentao.jia@corigine.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Reviewed-by:&nbsp;&nbsp; Xinyin=
g Yu <a href=3D"mailto:xinying.yu@corigine.com">
xinying.yu@corigine.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Reviewed-by:&nbsp;&nbsp; Shujin=
g Dong <a href=3D"mailto:shujing.dong@corigine.com">
shujing.dong@corigine.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Reviewed-by:&nbsp;&nbsp; Rick Z=
hong <a href=3D"mailto:zhaoyong.zhong@corigine.com">
zhaoyong.zhong@corigine.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">hw/net/vhost_net.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 ++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">include/hw/virtio/virtio.h | 4 =
++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2 files changed, 6 insertions(+=
)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/hw/net/vhost_net.c=
 b/hw/net/vhost_net.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index e8e1661646..211ca859a6 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/hw/net/vhost_net.c<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/hw/net/vhost_net.c<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -76,6 +76,8 @@ static const =
int user_feature_bits[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO=
_F_IOMMU_PLATFORM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO=
_F_RING_PACKED,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO=
_F_RING_RESET,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; VIRTIO_F_IN=
_ORDER,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; VIRTIO_F_NO=
TIFICATION_DATA,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO=
_NET_F_RSS,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO=
_NET_F_HASH_REPORT,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO=
_NET_F_GUEST_USO4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/include/hw/virtio/=
virtio.h b/include/hw/virtio/virtio.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index c8f72850bc..3880b6764c 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/include/hw/virtio/virtio.=
h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/include/hw/virtio/virtio.=
h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -369,6 +369,10 @@ typedef st=
ruct VirtIORNGConf VirtIORNGConf;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_F_RING_PACKED, false), \<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; DEFINE=
_PROP_BIT64(&quot;queue_reset&quot;, _state, _field, \<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_F_RING_RESET, true)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; DEFINE_PROP=
_BIT64(&quot;notification_data&quot;, _state, _field, \<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; VIRTIO_F_NOTIFICATION_DATA, true), \<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; DEFINE_PROP=
_BIT64(&quot;in_order&quot;, _state, _field, \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; VIRTIO_F_IN_ORDER, true)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">hwaddr virtio_queue_get_desc_ad=
dr(VirtIODevice *vdev, int n);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">bool virtio_queue_enabled_legac=
y(VirtIODevice *vdev, int n);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_SN4PR13MB5727A538887598415C5A37D28681ASN4PR13MB5727namp_--

