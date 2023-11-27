Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F3E7F9C7C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 10:17:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Xjo-0003d5-5Z; Mon, 27 Nov 2023 04:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56951a8688=volodymyr_babchuk@epam.com>)
 id 1r7Xj4-0003Qm-20
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 04:16:22 -0500
Received: from mx0b-0039f301.pphosted.com ([148.163.137.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56951a8688=volodymyr_babchuk@epam.com>)
 id 1r7Xiz-0003vD-Q8
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 04:16:21 -0500
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AR8lxbW031745; Mon, 27 Nov 2023 09:15:47 GMT
Received: from eur02-db5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2104.outbound.protection.outlook.com [104.47.11.104])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3umqhjg7ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 09:15:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJeuUpsTFBpbEsDoGoRWb+oOmrBya7GVJ19HAzUxp+ZeEYDu8ZgqqhFrJR3U8BV893Of25hDTfT4B74ykVHtQdbjPaKEnjHneRQ6L5gEC28xlm+ApV6dW/OyJs7xw1DuyvBZVjFRN0GskVp8/kS3YwHsE1q72tAtvsonqwM9SqjMgsr6ufBAlQvo4KDCJ7dS/7dRre5fnPtfDU0ji8cor3OqDjbORlwmiggMRg2Cz0hI44H9NdlhwlSJJLKzOReU3DGl9EPV9JfgLe6MYORkucvwg5DieKCnWVaxliKEL49rXr6EofSJrzGIpee8cWS5OgIf5kpMJdoiuv6z6kNDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFzyiHh/QMZTRP7tUR5OUPs10G9l38g+TiH8pO4ZwuA=;
 b=lrjb+f4aPpKQTuOOnON5d1uq5kIRpCcNpNpT19sEKo3fV7tXS4TmNTKBpCCo3jCLUfLU9d0f0Bb2J6n0Ay3JYo3oAVp3yvBiF66Ill0GsJtFMSnJcMT+VGbWOm7Zl6KWmDDD7yoKJHuY7IijGJ/KINTlXbte6L8zkjHwUTbW4ipL1yvSG6AF5HhRFX9NrEiJni5dVTCVxs8+RYi8GH6dxvoeIbYlpRWiN8FX5ACpR7hATnh8awrjpXNPPIlPsta7AUU7SH9GQPZpOy9omy6ZjuvNhxlzeGVLvl+/6Gjfw77exUvGXv+ZXuw0B6KqNKsh7qWlVPH8qQoh4l1fYNOxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFzyiHh/QMZTRP7tUR5OUPs10G9l38g+TiH8pO4ZwuA=;
 b=eO9sZuv12/6ZmTFmCARXgknOGla776TtBHAUUo6eE8A3SepKva02zn1wltjpjsWOoJb0g+sn+iNd1eUBLgmbgpSJA/n5E2gvfLxSJ2B2fFADvHETkoH7DZ8tSfuExdVfpa3kZfvoyB1i8PxcqFCXueyi0reAdBABttYxggBvSA3fLuZ2LGcx8OdQ/Ck1LtgrWcjN6zYx29xYxyWJapWDOP4JSWNBX0NmPFbDOkO29ocko20ysPLDYirgIWqsMJnLNfyTovDM2L6RSnH1yyOEdnASWvdw4segwzR48hcMcI7mtwwdYmhyEe9KB48BW0/gBwpELgmP8zwvsOpzkGVpxg==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by AS8PR03MB6741.eurprd03.prod.outlook.com (2603:10a6:20b:23c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 09:15:43 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822%6]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 09:15:43 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "Woodhouse, David" <dwmw@amazon.co.uk>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eduardo@habkost.net"
 <eduardo@habkost.net>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "groug@kaod.org"
 <groug@kaod.org>, "qemu_oss@crudebyte.com" <qemu_oss@crudebyte.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "julien@xen.org" <julien@xen.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "paul@xen.org" <paul@xen.org>, "anthony.perard@citrix.com"
 <anthony.perard@citrix.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "thuth@redhat.com" <thuth@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Subject: Re: [RFC PATCH v3 3/5] xen: add option to disable legacy backends
Thread-Topic: [RFC PATCH v3 3/5] xen: add option to disable legacy backends
Thread-Index: AQHaHy1b1vaaoDkYtEa69hkezixH/LCN3giAgAAHWwA=
Date: Mon, 27 Nov 2023 09:15:43 +0000
Message-ID: <871qcbwo8x.fsf@epam.com>
References: <20231124232400.943580-1-volodymyr_babchuk@epam.com>
 <20231124232400.943580-4-volodymyr_babchuk@epam.com>
 <a876dd8d01570f76da06f009eb8ed96bc3e0fea6.camel@amazon.co.uk>
In-Reply-To: <a876dd8d01570f76da06f009eb8ed96bc3e0fea6.camel@amazon.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3710:EE_|AS8PR03MB6741:EE_
x-ms-office365-filtering-correlation-id: c908b975-f085-4d55-c2cc-08dbef296ec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EnMH7v1sM1TrQ/uGzdFyLfhC+9A6MIVXVC93H1x/8Msu/fPpskJ331arUSBhaWpt9MFGO2gZX0TexrVtBKKh97FlNTvxw7ZzS3R1vbIsOINtnqQawlAAHz0KMOLKbVnPNdA8lOjiDsCMpL36LsX75tHEERaL3ArgO5PCrrh+WTki1Dtd75gvKhewoss01l3WVOCiYzh5IeQ2jEGpCgGMGfaHxF7EJwOfA/yleus9iNsx+0xs/6iSVGD8vBO86nKQ+BPsEsee/yOLJwAKSn2vYuNG1yicA3ntoCmR+rDZdmae1YztQtCgl3HY4jeMC/JAwQk06xa+K1eJkLoeU2+DJapGC1EIZmcWxbUcAed4WBXk3c9QpfD9k65fQh0uXXI98aa5w+WKEQtpT60CGBGveKy5wTQkFnaMxrHh7fhcJFtn105eE5AxAOeTIByHRDPA5wFptCY5Q1uvw8qKMkFrD8kbzsC9NHNNqcDYvftG1N2MAyF8gufNdA/L+PYq/jQZxPW09lB0Tc4+Yl3ab5S/DdS+De9aKCrPfn2UeBhIQXG8WILDiaa9wYEPTqAkR2kxIec1LLKNs3nbl/ocrW0rxakauNsRwvko7DJcbea5P/o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB3710.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(41300700001)(36756003)(86362001)(4001150100001)(38070700009)(122000001)(2906002)(5660300002)(7416002)(26005)(2616005)(6512007)(55236004)(6506007)(71200400001)(8676002)(4326008)(8936002)(478600001)(6486002)(966005)(66446008)(66946007)(91956017)(64756008)(76116006)(54906003)(66476007)(66556008)(6916009)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/kAxux74LSvL9unhpDUhwi2npPk0bO4Ngurhrzvka/K3sIBaC6o1vA1UdH?=
 =?iso-8859-1?Q?PY4GQ7K0YolvN4Y9Vh0g9weeUbrfF+r7H8Xa8asEE9jGfjECs6iAsXC6Dx?=
 =?iso-8859-1?Q?TjXTVABxWDsiUztd95MoXdzSdE2JJkZNdRsYeGAUYgJBE3vjEp3erDYHpB?=
 =?iso-8859-1?Q?YOl9LOWmCvcQo9f2g5lLIlniIH8YvoVC5fteTVDM6wR5pe1d/8XjG5dY1I?=
 =?iso-8859-1?Q?3eC1hvycDZetgNeQwqMwztUKTJrW2525Xn1Y6JCi1F4YNW4PZlqMMxl3fT?=
 =?iso-8859-1?Q?EhUv5Mf7q6+w+ZZWv8CXnvtZSvLuJyXLNP/6teBkqkO+VN0IRBEm0Nrx+k?=
 =?iso-8859-1?Q?k14uAtpS3Ru9dvpnAiUoWBTDgwPq4K+4aEuI60mEw9rBbITJwmcWSHP+yB?=
 =?iso-8859-1?Q?oLjr+0KDz7/cUTQ/saKJbm6NI1HLwOnzoXx8upCwruwU+AnGFwkFE+MDvw?=
 =?iso-8859-1?Q?a8fB0uzu3WfudWpP3vOS6OWArdqnM695ArNj97jNny9E5z98OP6emLYlKo?=
 =?iso-8859-1?Q?QJBMfiRWS5ts2jNWxUDmkOEVXKt4mXIYyMmhzKGysNCRr5m6XtbfWpgV2Y?=
 =?iso-8859-1?Q?dgvmgG6PVgPJ5CID+VXPnZ1hMfuhNQ2F/R3FiuIL4NURn9GcpTj27FSQoA?=
 =?iso-8859-1?Q?azpwW8Qg0qcjtCdA4gmy2aE2xhcKkTFxGOS45zCvI5vhts6TrcdefYgWnQ?=
 =?iso-8859-1?Q?0TMdwCS+MsWG1h1Su7lpncocqy3u7IbmcvuTptew4d6LJPtPGoMb++YNCT?=
 =?iso-8859-1?Q?AA2M8BpXG47qmn8JGWsWUMkj28oANcU9BH/4ztMIUmultPK0Ozf4jyBZ33?=
 =?iso-8859-1?Q?rwaMS6LQszUkJxUYFlDpadIzVfphcMvUh63Od/XcP8LahJ4bWL/2RVI7os?=
 =?iso-8859-1?Q?M18E6UEtbB8xyHUcQB4ElPFfplPFySnTfM6TRpnMjQKDhDriKQWaDHrUEN?=
 =?iso-8859-1?Q?FCMgO9aamXFra483fox8spzj4Vt8/tUoxKQqRiFI285QY4As/meKq8hsLc?=
 =?iso-8859-1?Q?oSDMo8FEyMcEPQfn1jWId5hiWitRpla+hWx90FWcmn6C3TTKjm4dI16KwS?=
 =?iso-8859-1?Q?BLZ2QNWksGvIjs1e8zlci31M7b/djjjh1mIHhhhtC7HmA5BUkl6S6X8M+O?=
 =?iso-8859-1?Q?6x3ZE7gHMDeXo+JRAemGmLJFHbzLfz1eGhobBce2MpJA7vq1KudUUXfWjY?=
 =?iso-8859-1?Q?KiWlZNe9u6R0kHiAX1OhmfhcxEBn35UMyuNAI/8t6uqlV9jTmgPYwm+TVY?=
 =?iso-8859-1?Q?CCTF3d9GbckZboJpuDczEH6AflMCgx5iYSNp2p/BnYam+e2YJxVPeqMRKT?=
 =?iso-8859-1?Q?ecawO3Spe4sW5VldTUQb6XzDqW4y6T0ntiHdWJa6++mIWtFU2OGdQ2HgRx?=
 =?iso-8859-1?Q?6IGNB5zOzYZpRDwhGpdBLg01rIpkBPX5x0Tp6rpFWyKAE/hS8P+ZxMx4W3?=
 =?iso-8859-1?Q?gRuiwc5F+rPIsKcquRg0gYmym4F7RGoTAhf7jfuf+DubtuoTqFJq6xqVhj?=
 =?iso-8859-1?Q?WrVczi4hLvNTkkbDkUfSl3rcaSLfiKq90VLfyCdK5fpzzqrtOLRbCge0TU?=
 =?iso-8859-1?Q?k0eZDqLYZlWr4ss7nUk2bg31lDmcadjgs42ANvvP2Ka/+4VKMyn+dtAPc4?=
 =?iso-8859-1?Q?x4uC8wkZqGGJqmtenkAmO4V+JcKGqA30T0ysxObHJD9BubQSRcR7tX8Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c908b975-f085-4d55-c2cc-08dbef296ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 09:15:43.3919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQHQTZK6WLjgB1ehk1w3cv1cDV3fIHrol/lqaJwfwPtoFgtO4gI7TKl6NRUc5UWLElRXuiK4jE5hC9z0mYD7kaqve31SHKL21HhhBw7gSmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6741
X-Proofpoint-GUID: ovnmhCe0hxnTS8isImgkJDed2dlVCqQh
X-Proofpoint-ORIG-GUID: ovnmhCe0hxnTS8isImgkJDed2dlVCqQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270064
Received-SPF: pass client-ip=148.163.137.242;
 envelope-from=prvs=56951a8688=volodymyr_babchuk@epam.com;
 helo=mx0b-0039f301.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


Hi David,

"Woodhouse, David" <dwmw@amazon.co.uk> writes:

> [[S/MIME Signed Part:Undecided]]
> On Fri, 2023-11-24 at 23:24 +0000, Volodymyr Babchuk wrote:
>> This patch makes legacy backends optional. As was discussed at [1]
>> this is a solution to a problem when we can't run QEMU as a device
>> model in a non-privileged domain. This is because legacy backends
>> assume that they are always running in domain with ID =3D 0. Actually,
>> this may prevent running QEMU in a privileged domain with ID not equal
>> to zero.
>>=20
>> To be able to disable legacy backends we need to alter couple of
>> source files that unintentionally depend on them. For example
>> xen-all.c used xen_pv_printf to report errors, while not providing any
>> additional like xendev pointer. Also, we need to move xenstore
>> structure from xen-legacy-backend.c, because it is apparently used in
>> xen-all.c.
>>=20
>> With this patch it is possible to provide
>> "--disable-xen-legacy-backends" configure option to get QEMU binary
>> that can run in a driver domain. With price of not be able to use
>> legacy backends of course.
>>=20
>> [1]
>> https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg05022.html
>>=20
>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>=20
>> ---
>>=20
>> I am not sure if I made correct changes to the build system, thus this
>> patch is tagged as RFC.
>
> Hm, I was imagining a new CONFIG_LEGACY_XEN_BACKENDS option which would
> look a lot like CONFIG_XEN_BUS (which would now be only for the new
> XenBus code).
>

It was my original intention too. But it appears that it is not possible
to add Kconfig value and then make it configurable via ./config
script. As I understood it can be set only via defconfig file.

> This looks weird to me:
>
>> --- a/hw/display/meson.build
>> +++ b/hw/display/meson.build
>> @@ -14,7 +14,9 @@ system_ss.add(when: 'CONFIG_PL110', if_true:
>> files('pl110.c'))
>>  system_ss.add(when: 'CONFIG_SII9022', if_true: files('sii9022.c'))
>>  system_ss.add(when: 'CONFIG_SSD0303', if_true: files('ssd0303.c'))
>>  system_ss.add(when: 'CONFIG_SSD0323', if_true: files('ssd0323.c'))
>> -system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xenfb.c'))
>> +if have_xen_legacy_backends
>> +  system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xenfb.c'))
>> +endif
>>=20
>>  system_ss.add(when: 'CONFIG_VGA_PCI', if_true: files('vga-pci.c'))
>>  system_ss.add(when: 'CONFIG_VGA_ISA', if_true: files('vga-isa.c'))
>
> I'd prefer to see just:
>
> -system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xenfb.c'))
> +system_ss.add(when: 'CONFIG_XEN_LEGACY_BACKENDS', if_true: files('xenfb.=
c'))

I tried, but it does not work this way. I need to create Kconfig
variable to do this, but then other problems appear.

>
> Probably also better to split out the bits in accel/xen/xen-all.c and
> hw/xen/xen-legacy-backend.c to a separate preparatory commit.

Okay, will do.

--=20
WBR, Volodymyr=

