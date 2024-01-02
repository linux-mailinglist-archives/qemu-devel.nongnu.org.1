Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DDF8218DB
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 10:22:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKayY-0002B1-RQ; Tue, 02 Jan 2024 04:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rapaport@cadence.com>)
 id 1rKa0e-0001Zy-If
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 03:20:29 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]
 helo=mx0a-0014ca01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rapaport@cadence.com>)
 id 1rKa0a-0005Y8-JM
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 03:20:24 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
 by mx0b-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 401LOlnd007726
 for <qemu-devel@nongnu.org>; Tue, 2 Jan 2024 00:20:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
 from:to:subject:date:message-id:content-type:mime-version; s=
 proofpoint; bh=GXkQc6LCC/VDBWySwTjaCoPuzBLIreRTwrbrU9ldY0A=; b=H
 LYoxe1OPlCY+1tq10H7Y7uNPxZU+S1zWYWWFE9JjWhwocZOqTzRFpZ7BafS6bT7W
 7aanpDUUaW+gtN9ZaNlV/mjM0rC5eresCYU3q8KwVfb49anxHk45NGhP7fOb5Ipu
 nTcrZtz4EuR7T7lQjMKBfHmg1/+q/Tasf9PcdHl4RRw19gnFBaCc1oEWBrbJxxQE
 sqOdltaXU5/MQF3lnoTENqsHeY1NwjUBUBpVD4gRp6NeBIeVyy+fGgQaPzTJmkvB
 xiUY8t+R+v9gWxcpWWC5+qTOVmyfMq6LSwT0SrqnNLBYmaIuG2MpfMM3gQsMtyN3
 uGYSzKwl6GFT7ADrOGRiw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3vafp0ec05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 00:20:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKwkDUKuUFEdmvg6CnOMVMPPd62YlKbAhqT0ivA0Fiy3TN+er7q+E7MxPs+PsezAlco+mK/sQfCLTedKJpYJmQHvacFQjbo2b8YS32lftFXT4eQMd5Oa8SehWp66CS7iiRoeGZyHD67VGX0J5ru647yqhfvi+GKNWoGeqEpJPytcUzOuMteJnTK+qzw0CAsCq37c4lojKnzt39/eT8sV5M9mnjWBekAt9rjyswluVdk6tX/WZIc4ey5PtY/EEcCx+LFccnsqgdxPtBl3Ou6VkghZ10RcM56Y7S6SKYobN6qDdC19rMnJoNwnDTNd9u2n2CQPphbmQ9vJYEOaW2fp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXkQc6LCC/VDBWySwTjaCoPuzBLIreRTwrbrU9ldY0A=;
 b=Y5vpOaWBu6I46E4QHYI2ifIsvcTQGDOiVB8RlZXrHz9y/EcZFQBPBRNHQRJrjgkI3aBWpIT/kxAn/3/aaR3GN3LW3ePnEZLHTEWg/BXBsS2TUYbPIoSRJZ/OMzInC1RWN6sBtpmx9FL9CaD9Yjrlqf+DUt2bqjk5Rzf+dkPPTmSk+xbjNy41ECt8KbZyG/r3b2qcxx/Fw7Sa5nU940Z38wvQXTQ0nddFVnwqn5M4Zg2e+er0MaR2Wb6G7u5kc5ONo4BgfNnwjiL7Xn+wq+j4YbPUMU0/wL87bKpb49xwlVBfYwv3LmNtbS0h7Utc9nI+ZBt6jUuR6npfBYs4hfqO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXkQc6LCC/VDBWySwTjaCoPuzBLIreRTwrbrU9ldY0A=;
 b=7VUHcNdXcIeLi/G+3DhZMvVtMxP8QCc7vqE13ELhyjYFFG6+gVlzGqhYg11eVHxMWQHAcGZT8PpPzkaj3I49PwiOaQQcRx8YywE2pSU1LVnAJyPkRj1KSlvgAi4OOEF355KYXDNUcpo09H19iKN1wrkVttLV8rTLNTPj27lRHa4=
Received: from MN2PR07MB6080.namprd07.prod.outlook.com (2603:10b6:208:ae::21)
 by CH0PR07MB9894.namprd07.prod.outlook.com (2603:10b6:610:188::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:20:12 +0000
Received: from MN2PR07MB6080.namprd07.prod.outlook.com
 ([fe80::cdeb:f0ac:8ea6:36fb]) by MN2PR07MB6080.namprd07.prod.outlook.com
 ([fe80::cdeb:f0ac:8ea6:36fb%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:20:11 +0000
From: Nati Rapaport <rapaport@cadence.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Adding custom CSR to riscv-qemu
Thread-Topic: Adding custom CSR to riscv-qemu
Thread-Index: Ado9Uy9OFEfgcdnOSsCOfhfvtpr35A==
Date: Tue, 2 Jan 2024 08:20:11 +0000
Message-ID: <MN2PR07MB60808AC0A8A31AF17BE2EBC6C561A@MN2PR07MB6080.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5Lmh0bWwiIHA9ImM6XHVzZXJzXHJhcGFwb3J0XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYmQ5MGIxZDMtYTk0Ny0xMWVlLWE4ZjUtZjRhNDc1ZDU5YjEwXGFtZS10ZXN0XGJkOTBiMWQ0LWE5NDctMTFlZS1hOGY1LWY0YTQ3NWQ1OWIxMGJvZHkuaHRtbCIgc3o9IjQ4MTYiIHQ9IjEzMzQ4NjU3MjA5Mzg4NTI4MiIgaD0ibGZpN0tVYk40cjQ1SjJMeUlHMjN3SmxTalpzPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR07MB6080:EE_|CH0PR07MB9894:EE_
x-ms-office365-filtering-correlation-id: 5e239314-b8a7-411a-11e1-08dc0b6ba3e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tme3x+0FMwk3W5YCJLVXmr0TjAP3/dg6b74yw6QkTIHhwXveF78nubexkrUrmPZyFpNygGMnQ3er+jCh9B/Yi8bH9Uc9Aa4Fsx4lhdxUs6XSFutIxPjj8spsRnpMr912+ERPGUVUI+bQuzDM7fNpWoI53MyNYabHFQ+08AnC5zNaG2N9JTLQeZsdQQ4byFlE7JkDPtaSn8OIe/n8aZ7FdWi7yurfOcs2dqv8TDV3GfwjDeqr3ed58Iz7bOVEvOq68BZEmjA9gYHekcYqpdnJUafDKpv+BcJoRP63KEb+mIwTY2TrlSr6U2IiKsQQRMOBQZs5Nyftr+QiA9OSkSRXfGGF30dKmIJIKZg3OgNByjFtSCr3f5bStIC15t8Gln88XpNTUTeavnYudZiMJ0uKpEYp6EtE/Ia6fFgS2FumNnLtCwuGmwInN7hxOIiA2iq8VaTyRiT/eBtT6hnIZqGu21pVyYnyPcEhdBE7elRe9Lsb4dWLGbg2lRU5yB9pPDvwyer7voy+ZJVI7w+/6znPVQ3kwIOEXVEvEQ1FMUc7OkInxFQWMciHd3A1kM9gC31YDgjtryqZlsgF+7luR4EDyhqWFQloXMIHFzojpGAnm+aFTs1NMsQvv92QgAOfruPu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR07MB6080.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2906002)(4744005)(5660300002)(38070700009)(41300700001)(26005)(33656002)(478600001)(7696005)(71200400001)(6506007)(9686003)(122000001)(55016003)(38100700002)(66476007)(66946007)(64756008)(86362001)(76116006)(66556008)(66446008)(6916009)(316002)(52536014)(8936002)(9326002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y5iT736ztwc+BFjL0Xk/v1VpCvkN9hYkTPJ1qQ060jO0MblrWmPIs0eTj/E7?=
 =?us-ascii?Q?ibim4xS+lmk7bSV/43SwCVXUsDwHSCFWgCXsHBtvV+F2b+TPJuPuZdGK6EPR?=
 =?us-ascii?Q?V4U7LbHWtIO7UrQNCFp6dsHfIRmzbiog81pLRqi9WkZxwZM66Iel+0GPVXHW?=
 =?us-ascii?Q?/s22MB3F2SdJvMvFc3NZSI8x3xqnPZMHFDn9i9xeDTfHu+unmu3XCWpqVpEF?=
 =?us-ascii?Q?6MrD+SsgFtmufmktHwIWeIbSYsJ8xBaXiwDuDfH8rxAdfKZftDvqZYOmNv6C?=
 =?us-ascii?Q?6SQ4ORDPaJuhDnYht/mXF0waTR4TV2aBcKvpNFIYoYT/+sA2SazKb/W9OBha?=
 =?us-ascii?Q?+uqqoH9uqOkvazx55lGD9CaGsMF11FNK6t97s3AYGh5l3SPntkcEDiGCJVi2?=
 =?us-ascii?Q?X8JMUgLeFkUvk2+0XWFJSN6l2rmY+5XBV12VWB1oyyz79M2DCVklEy5F+p9l?=
 =?us-ascii?Q?M1bqgPjQ/LnYJkDYpqsyjy4P4PeOBZ40zYM0JIdJA9ZDGehHr5wFztDigBGn?=
 =?us-ascii?Q?hRsNf/qQNvwqc18FIuSnw7rjpt+6wffIaUdrjIfTTRhmEKDt39VYd3xUbOJ6?=
 =?us-ascii?Q?cFJNscL7BY4o3EB74TogzwyGtl+joYicH8SbCbyGAFoyyfxDWwUMS6I/fq8d?=
 =?us-ascii?Q?XGyGDruyj783xoqO6qr9k0Z613Sc4nzfB3FgeicyJsQLeVVY/EsLzD0NkqMJ?=
 =?us-ascii?Q?AarWJCjQ7WDenrCOEUHlYwN+Lh5DiCURqPkvHFFlJPkQP7wAE/KY9jVQgSFq?=
 =?us-ascii?Q?3Jo4ZZbs8FLZt8R75vcjd7uVO3RfT+IizALg1mB1PcqXQ4uoqItUX21rrf+B?=
 =?us-ascii?Q?TKDi19XE9IH5SXXrd9eOlnVn9svEGG+5pV0AE5EJj8QP6Vqd1gtRD8eYqRED?=
 =?us-ascii?Q?OU56pmqjaKaW44Xtq+SCeTMEVD7lU/zuKBjtC3fQN9TdF64me9i1Of7nWp4l?=
 =?us-ascii?Q?rM+JF6klMhm74LxZdHkylb4Myn4P7qVkdue8QX11EZj0zOTL1naPTtgqNkXm?=
 =?us-ascii?Q?f7qEZRE8JdwHHYmGqd9qhumdojcjCPsHmD/ZGkZiZMtEnufN/6PH5obR365S?=
 =?us-ascii?Q?okZaiVcgDpBDfNXFlgjXvUmQrlBuZ7Q4r9F4/MRtHFs7NBrN5XEDhJX1qXC5?=
 =?us-ascii?Q?LChrTtdz5heSqu09Nn9QYzzIWzTUfPVIWg1CVYW6S2q0LELjvVzkCF9kRxcB?=
 =?us-ascii?Q?PFxgUUqdo9rAjt4jMnSS3iPMbOrTtK9iaJgIerrQle3bl0d196VURrsVFVGL?=
 =?us-ascii?Q?C9U9ZX/WQ0TD7Q3GzUAjbxFaFTyR+xOczjAlt+aiZfPVzqEeK88i0BWq8QR9?=
 =?us-ascii?Q?VB1XjuLkZuCTX8cYDbgpkJnpGw5Hgk61E5wNGFAKnuDyC7x4sxgwCqnB3Sgw?=
 =?us-ascii?Q?gkUYAeFQsRp3VyF2MwKpPhHbJ5e80+qRBjKAqTciXnhOI5BW+osLZlKMxz8Z?=
 =?us-ascii?Q?DtIX4Yw85sjdrbmIoqRxJvzwt8OPrmXDHpO8yPVVJXMroHHNEnJDqURoRruz?=
 =?us-ascii?Q?8CpN7THhSjU0wq3Jc1OOtwr8Rle9hhak+e6ftqzRfd67gzr9L9cm5ZW2unNw?=
 =?us-ascii?Q?oVnB4NzY7+Z3U8HVlbQHtg6aTnL/gX80oSdx2nMFiB1/V51pf6rAhXZbR9ZS?=
 =?us-ascii?Q?Jw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR07MB60808AC0A8A31AF17BE2EBC6C561AMN2PR07MB6080namp_"
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6080.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e239314-b8a7-411a-11e1-08dc0b6ba3e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 08:20:11.8822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaWyRCJpYRezntUiU/SAw1ymAaEwmUIBlkgpaDiE6Rzj1t6c7+dksdSVlJKgE2EXIXcxqIxtjM0uveIldfcZmZVlIwiJbRBvG6X/e1OVT/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB9894
X-Proofpoint-GUID: kyFhkXkhVtQ-7R1FwIrj_nfMZBaaGP6n
X-Proofpoint-ORIG-GUID: kyFhkXkhVtQ-7R1FwIrj_nfMZBaaGP6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=603 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401020063
Received-SPF: pass client-ip=208.86.201.193; envelope-from=rapaport@cadence.com;
 helo=mx0a-0014ca01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jan 2024 04:22:04 -0500
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

--_000_MN2PR07MB60808AC0A8A31AF17BE2EBC6C561AMN2PR07MB6080namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,
I'm going to add some custom CSRs (Control & Status Registers) to a new Ris=
cV core in qemu.
Could you please help me understanding if there is any method to do it?
Should I do it in /target/riscv/cpu_bits.h where all CSRs are defined  (and=
 other files, where all standard CSRs implementation reside?) and just put =
it under a compilation flag for our new core only?
I don't think so.. as I don't see any similar example for that there.
Should I add all the related code around these CSRs in dedicated source fil=
es and let them built only for our core?
Please explain..

Thank you in advance.
Nati Rapaport
Cadence Design Systems

--_000_MN2PR07MB60808AC0A8A31AF17BE2EBC6C561AMN2PR07MB6080namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal">I&#8217;m going to add some custom CSRs (Control &am=
p; Status Registers) to a new RiscV core in qemu.<o:p></o:p></p>
<p class=3D"MsoNormal">Could you please help me understanding if there is a=
ny method to do it?<o:p></o:p></p>
<p class=3D"MsoNormal">Should I do it in /target/riscv/cpu_bits.h where all=
 CSRs are defined &nbsp;(and other files, where all standard CSRs implement=
ation reside?) and just put it under a compilation flag for our new core on=
ly?<o:p></o:p></p>
<p class=3D"MsoNormal">I don&#8217;t think so.. as I don&#8217;t see any si=
milar example for that there.<o:p></o:p></p>
<p class=3D"MsoNormal">Should I add all the related code around these CSRs =
in dedicated source files and let them built only for our core?<o:p></o:p><=
/p>
<p class=3D"MsoNormal">Please explain..<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you in advance.<o:p></o:p></p>
<p class=3D"MsoNormal">Nati Rapaport<o:p></o:p></p>
<p class=3D"MsoNormal">Cadence Design Systems<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR07MB60808AC0A8A31AF17BE2EBC6C561AMN2PR07MB6080namp_--

