Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31734743BC6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFD3u-0000yL-JI; Fri, 30 Jun 2023 08:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qFD3k-0000pH-EO
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:17:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qFD3f-0002XS-Ky
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:17:07 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35U5nGnj026221; Fri, 30 Jun 2023 05:16:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=O5v54+fD8zW/qh4K5hz85auY7CVf6Btz7ZNGEL2HLI8=;
 b=yG76XbbJWXI5npH/+20xSYc5fw6TOWXbd+U3vH3HyXQ1J5XQxTqlvjUyFTNq3CX4Syb5
 l2xPfGRSFruR6DtJuQrg9YPY8a1hCHXFX75k8XWr8eMoX/w/5f792AlNpdns6Ii7mbKY
 7I+SlRpiYkpt1+Fwt/24LB2uYBnG4JfSEBVzNXneIzOb4Di1qbG/1+bk0L4PnCC4r9vI
 wp8fYHH9M3NW2orNbJAxM6XoxP6eCOfgPWzKgkhvVUrtSRqsn9q6UT8rxY81drC66BBC
 VUKR+lEIgu94wpjL+e30hMBml/Vd2x32LPkmaP8e7+MByXxVu9yzZ1Jrgttz7o3mMnyc bA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rdyjem2p0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 05:16:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNl7x0CVVqe/DR25PRROVKC10x4/CQjkP+CEtaY8+sGkv805RczuwdL88UKilfGxMsYgCK97mY4HBmXODdlf9NZOrcMzZCGLWQesB92Qdl7p4GoDijFkvlbPIAGprYmlrFRUhWkOHLr9SCLe6gWjs7irNCK9Z+DjOitPKMyiBFka1gLcdsTpSUGbk6pZKmHOg5Shx0aUdpxk5qLZSzDrSLkJA+sKulYK1OBsYZa1hxIzKFW0L40aDYCjSvECzaHzrxv/sdIxfInraRfp5FvIAYrYpFnneESzhPYHh6WJ83fLxcJMRDDL+83V5/ktbZe9rF8ftk9v5EDDxJQI2lyjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5v54+fD8zW/qh4K5hz85auY7CVf6Btz7ZNGEL2HLI8=;
 b=Lfvlu+fXNV6xXMFfoIwGjtRw4Clv6w7u4cDYQfqXjvrGTnixdVlzFGRqpot+LeUchRgyQIhoML9exSiM/talUu3/6+H0QWfO7+rA/Q+onvLjcVnIfzGJkrNAQXsaYwdA6zy9aJXRT+3mhLRIYT82EBW+JiReXehlCUr3/4YLoOxyP9txHOoHWFrB9PO6zsURSQa/yyOqUAg3cEYPtiIkWwMwV2z6tP3hNkyV7T0tJ0V1l4rAs4kWpTugRaRFNwceyK618BPZXKKpZGlFxCBhH3CIpHyTWidaBGewD9UZiP/kyLUAe8sgLOfZr/6Zw3VwLARRuv7B6MjAEbAIVfkxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5v54+fD8zW/qh4K5hz85auY7CVf6Btz7ZNGEL2HLI8=;
 b=HdA18TkJCyupI7TpYU7DkqywCgZoXmcBuLHqmTFxs6544uH22Au/UDiqskdo3mSr15HQc8H43iHFFdx0IVnu1vunvidPzhYHLy2cJ5X0/LzPTwuaO4u7kQJje3V9e3scjPFgjg2aZ9R+Y4HCARsLktCXdFU+Jr4MbLnM9OlT+S62/hKiP2XCClNT6s6A8xkw4cA1Lfvv1RYa3AmLmaZGT8Rfp+My/TEgvASpT2V39n1Fm44OxcB8qfIAvs3AaNXu6xbTWuesWAEFB3cBI687RBYhz8Ve4aS2XR9KPGNNqxnGFQt32KTU+Yl1ERn3C6oukU0TYp31YZACJLQsiLy77w==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO1PR02MB8604.namprd02.prod.outlook.com (2603:10b6:303:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 12:16:43 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::a769:9be9:a331:6d6d]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::a769:9be9:a331:6d6d%4]) with mapi id 15.20.6565.007; Fri, 30 Jun 2023
 12:16:42 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Tom Lonergan <tom.lonergan@nutanix.com>
CC: "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "yuanmh12@chinatelecom.cn"
 <yuanmh12@chinatelecom.cn>
Subject: Re: [PATCH 2/2] vhost-user: Make RESET_DEVICE a per device message
Thread-Topic: [PATCH 2/2] vhost-user: Make RESET_DEVICE a per device message
Thread-Index: AQHZqd8l8NmOXkL9qUuMYUUlh1uLOK+jRbYA
Date: Fri, 30 Jun 2023 12:16:42 +0000
Message-ID: <67F41DC0-31E9-4A54-AFE0-8D425DDC90CB@nutanix.com>
References: <20230628163927.108171-1-tom.lonergan@nutanix.com>
 <20230628163927.108171-3-tom.lonergan@nutanix.com>
In-Reply-To: <20230628163927.108171-3-tom.lonergan@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO1PR02MB8604:EE_
x-ms-office365-filtering-correlation-id: 5c8d0b58-f402-476f-c685-08db7963dd9c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qhw8o0ZYUSsEzdUI94UWDccYWiETeMP2gjsnKP5rz669vrXo93SIa+XV9gRhptTFH9dOFKZd3cdYjkYiTQUJIU+mn3DrAm0NVGblkftnB15AMC9gO+2Pc2G2Jg79J/Cr+wp/rjOWM0BKveC+E+c/8PeBaffk+81S8IE6Evtu3o4jk+e5EEWu1lSFbGmeS7c4RUJEc/tpGaWTp53kcTr8MGjRhSPySEyogc0XcsPOK5ZANV1SInbR6fllbD/gMIWFZQWgubM9TngscIMZ6GOj4x3z6lox/F9LZPFyuQ/+WAaQM6QPuMv6Hip6O3kcnxxcvYxkXm831HDaF9uzkl6Gq9G26WE9JVE6vjSfVrjzMbo5ssbZli/J7/hLnf7w8RslHG5CMai8G3pe4sTlAt4f6PQ02AeAiDLYuu/M94/i6y7+pDZ0F4H5T9FrE7Tkt+aOvK5Ia45bN9NeUQr7rVmNNsNIfVxzQEXuq6fLbdaKS17BM6KONY9vpnZjYaCZxnLwz/LtH3NkFVig774Z1SY/NYPw6VotejGstGgy7BIZJ8YyI15c1NfdHBeDkDozUJibWxs8zdxRN2lmH96rFKb+q3ww6HdJED/Bycwkwo4mtW7cCcT4Og9KNEuThvW24AP6A9Yq0RTbzKMYTO5jwyRY+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(2906002)(4744005)(6486002)(53546011)(2616005)(71200400001)(122000001)(83380400001)(38100700002)(186003)(6512007)(38070700005)(41300700001)(6506007)(37006003)(86362001)(54906003)(26005)(66556008)(316002)(478600001)(36756003)(6636002)(66946007)(64756008)(66476007)(66446008)(4326008)(76116006)(33656002)(44832011)(5660300002)(91956017)(15650500001)(6862004)(8676002)(8936002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9o/BYhisM801AQx9cFE8UgZFkX4QTtNceNL1PmXrew0qwNHV3WmJayIN20ag?=
 =?us-ascii?Q?1TLo69Vn1tF5iBxJgoNsoHL8wCNlPlpLJLP2dw6/jWsaf+GaCTqYEu3XqW3o?=
 =?us-ascii?Q?EMVZnqo/dVx7Vyo/CrMCvfXg1E9i8ePK4g1WSu1T8InP0Bx1lOZDPiolXdCu?=
 =?us-ascii?Q?hI+QHktJa5w4l5de3g0jIw1bYHeyDEeCYZE5qo7KqISoUF6nCOXTXRrI3FVw?=
 =?us-ascii?Q?72+6Ih1An2Pkt/EkKKusI9Pw0pdVXkqbuNdiExQ4hXXbAmNXnnyM4Tik8uHg?=
 =?us-ascii?Q?M2HcsI8N9WDpLL6WaVQU98YlTzr8n2dEUl7pUX+GOyZfHIaQj7UB4daHrqH8?=
 =?us-ascii?Q?iZikfx0WUHjbYTPY8X3MqevKDk/CcC09wRJ7NEEuQO7SsMvPA9Ek6Jul8GC5?=
 =?us-ascii?Q?ARGa9QY6ihPNqbxz+WiHNg9fo0n/5S10PVq2kYFDyZ2KJt3C8CVbL9BMEoKv?=
 =?us-ascii?Q?GBwQgC1dXREZL9U1rMFhfyVTIndz/W7pRBtwSXTrf9O9M0dZ4OVR5H/Qsmer?=
 =?us-ascii?Q?1HQU7WGfoApOqtZzL12TA172NGfQV/xPM5AjwT8mJL7Vaa/xy6q9JRIgOcaY?=
 =?us-ascii?Q?R4vKvkpuzB4Dloj0n/SXFJNuWEQw1D942R6YbTKtTQOe/w1eWpwk3dkegA92?=
 =?us-ascii?Q?6Iu84UPGB3yOH2A8ijoAfLBIvEZ22S8n4wdt4YbzAbXUQgGyhgWaItDEwDku?=
 =?us-ascii?Q?QN5Fk7yxB0jK7qto234huQ0KuxYMeBn4tKHBVgLojrdHZOqUrn3bPDqkMdZ3?=
 =?us-ascii?Q?yj04q9cIpRkR1IEN5PhOoC9ebDk9nLD9B1Mk6eQ08JSnp+FyCubRmH86zI39?=
 =?us-ascii?Q?iZiltuVb8JXR3WE1sHTgKru/mI8v94rPJr8dsvkdXHABlFvqJ/ovHWqBkLO8?=
 =?us-ascii?Q?3y3luElH1UVZsuio99qDcigDIsfJRa3lNOFj6EG2/yp4QP63o8Dvomqcd07F?=
 =?us-ascii?Q?14Db9qAZq6xaZ2gz5Zxub6SsfULWzlfMcsLic06BCnY6+/an9jay8sII/EXU?=
 =?us-ascii?Q?TTY+1c9jUjqaVVaST3+7Jf4nBPGNcxAqtpGul0+9NuBCL+/8Uw7HG3Vf0e27?=
 =?us-ascii?Q?VUVERmlhDb5/yGsaLWtOVvkY+sguUspKypD6VP/zdFc3CFHWn/yterRqzwv7?=
 =?us-ascii?Q?G6WrdXsJSJSxiQT2NldGKtGVued720ME1Go3UwzIrS4DtTAgI8bjClPwnZI2?=
 =?us-ascii?Q?acKfbucPRZzIHvGZXgk59Lia1iviURl4MTNGuma2dBHRf2psEHLkt6/Zd3Bp?=
 =?us-ascii?Q?m8UIuJ7lUTlikAm+0LqSBZA/HjNfs2cr+YrYEkwhmtLoomVH6vbRJ5UT9S4T?=
 =?us-ascii?Q?jUnKMVRLVcuJbmbqZqjiQJaOvCCQ/CpxYPLxtj8GLOZ3R7PEYXsY+x9/fSnP?=
 =?us-ascii?Q?O5GBF4F1181HUb6n8N5dGyTdbsh+K1GFJZSZQm0PTx7oQ7juMSVqvymlTkid?=
 =?us-ascii?Q?1jr5Ca3HKwqK+2OcxMQcCmexGSP/5i3N+Dda6pxJ0HMf/ZARPcp2F7YtUbwm?=
 =?us-ascii?Q?C+rU8G/d+N+jfzkB0nq4DjPGNI+yA/PjrNJmDEG2tPTkoyM0ITlaIYPkRTfx?=
 =?us-ascii?Q?YUw2drxl+eZXW+Z+W405jX9nYizkfdmhmmz5EQzZzoTPMoExLjxmiYw9znbQ?=
 =?us-ascii?Q?Eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3291F80989D62D4DB93D66F19D6C2AE7@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8d0b58-f402-476f-c685-08db7963dd9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 12:16:42.9459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMLzgnSRCuHcuJaggKuljzPi1tcfjex1wfm9oNpbxi4X6woZwipQLGiVeqFWoukv2QLE/aOYH/VuOpySCBB0x1iNtxWOOPBTBmV+bPG9v1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8604
X-Proofpoint-GUID: L7QUVazW_3PCAeABHCG9h6_e9F69Iswi
X-Proofpoint-ORIG-GUID: L7QUVazW_3PCAeABHCG9h6_e9F69Iswi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


> On Jun 28, 2023, at 5:39 PM, Tom Lonergan <tom.lonergan@nutanix.com> wrot=
e:
>=20
> A device reset is issued per device, not per VQ. The legacy device reset
> message, VHOST_USER_RESET_OWNER, is already a per device message. Therefo=
re,
> this change adds the proper message, VHOST_USER_RESET_DEVICE, to per devi=
ce
> messages.
>=20

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> Signed-off-by: Tom Lonergan <tom.lonergan@nutanix.com>
> ---
> hw/virtio/vhost-user.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 65d6299343..8dcf049d42 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -375,6 +375,7 @@ static bool vhost_user_per_device_request(VhostUserRe=
quest request)
>     case VHOST_USER_SET_MEM_TABLE:
>     case VHOST_USER_GET_QUEUE_NUM:
>     case VHOST_USER_NET_SET_MTU:
> +    case VHOST_USER_RESET_DEVICE:
>     case VHOST_USER_ADD_MEM_REG:
>     case VHOST_USER_REM_MEM_REG:
>         return true;
> --=20
> 2.22.3
>=20


