Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4607D78CA
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:41:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnTx-0006An-3i; Wed, 25 Oct 2023 19:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wucf@cn.ibm.com>) id 1qvnTr-000654-LP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:40:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wucf@cn.ibm.com>) id 1qvnTn-0000FJ-NC
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:40:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39PN7SSU031177
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 23:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : content-type : mime-version; s=pp1;
 bh=cbYTsyWMBJPJ07xF+PzbaulQGUN/uGE4lrg3fxyRB1g=;
 b=ZHrMANzuGq1lqCBSN6DnbCFTJNzUGvH7cWjxxVXyhebltcegz7qXkTKdPG0s+989gOjr
 MgQpuKM07t6iVEzkTn7FFBFzEDwB3+zc4FbDXrCAT0FTvVYKwObVsO66qmiWO4OurysM
 N8Xugd268/YgKyxc7MNNfds2GIs8W7UUH0xjE5BMdrVVJnt4ThDvdyCvfbZcrF9OPZMr
 RwCSaierd95FD8dMAc2NTKN58BBtsLeTWVYlbO+7m19WkwPARf6nqP8mDXKLoUNSxqKP
 QPYnXqPYJq96SocOEGB640Xz7152ekI/yl50oahXAOP/jrEn908I6KmgDvEQflLkpEQQ jw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tycdqrpq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 23:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWsijyC8Ue7upbkWPKAaSJ1/TbylDC3pCySCFrTh3WRAzynwzBRaMZGCVRm3X3+o/VD/ekxPnXo6a3m4e6SphdSDhiBP8UQddp/tiF3ZovGvlXeg4cD4S5lQj8dx6Ckzz0i1OLPT2PZ+iyOpOBauiqs1iZpE+OoOacF+SCv1TPYNjWIhRJ/WY+iZSxUfEiEGeDiWvb0jOL0RgCQz+4vFBeymvNcCgPjWA7EThk48Z0QJ2gqfEW4Z9aNg/IZoZBXPN66At2xtEq5zRHGH7PpyCGpRMbUlh/Yh0W6+vQpp790u4gTO95mpJiRZ/vhJlXNPQYu+pV2/sQQf8xtfNNRhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbYTsyWMBJPJ07xF+PzbaulQGUN/uGE4lrg3fxyRB1g=;
 b=FgCTERSuPQ/JTkRXEcjnBlrv1p2nMzsra/W/+Wkyz3f2pV8s4JMwQTjqP6Ct3YdaC9SONpzB/+J3gzv0ZahwiqfsMa2ksJENfiJFKM2XsbvHhsysQeVG6nfFLWvb1QDuGwNzosgAipIF8oryp58VxlEFTdhzbJmrmrEEYBDCLFJvIcUy9NeAoTbYAm1807IiNQcnQcWSeDzpzvNFrb0hlA5jOqpMffM9dW+t4RDK2mwnji3ppiEO+Xx5XuFKY4U8GusLz925AcT2lujIHP8r0OKiVAg0kLXRL28NUKb3aeoZcyB3psvL8jYHNlHV3Z7ZksosXhDgT5vv43aO1k46AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.ibm.com; dmarc=pass action=none header.from=cn.ibm.com;
 dkim=pass header.d=cn.ibm.com; arc=none
Received: from BY1PR15MB6078.namprd15.prod.outlook.com (2603:10b6:a03:52d::6)
 by PH0PR15MB5286.namprd15.prod.outlook.com (2603:10b6:510:144::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.18; Wed, 25 Oct
 2023 23:39:57 +0000
Received: from BY1PR15MB6078.namprd15.prod.outlook.com
 ([fe80::6025:4f23:ea46:cafe]) by BY1PR15MB6078.namprd15.prod.outlook.com
 ([fe80::6025:4f23:ea46:cafe%7]) with mapi id 15.20.6907.022; Wed, 25 Oct 2023
 23:39:57 +0000
From: Chun Feng Wu <wucf@cn.ibm.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Does "'throttle' block filter" work?
Thread-Topic: Does "'throttle' block filter" work?
Thread-Index: AQHaBoiMFDRWrDWcnUKLQvWC19Rpmg==
Date: Wed, 25 Oct 2023 23:39:56 +0000
Message-ID: <BY1PR15MB607818DFB03A6EF7D260F963F7DFA@BY1PR15MB6078.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR15MB6078:EE_|PH0PR15MB5286:EE_
x-ms-office365-filtering-correlation-id: 7aba5fd3-6058-45e9-fd99-08dbd5b3b204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NWf8GBs+LOC8se6CmEXuEic/cajPpwoAPTAtV7/uWOkJljwhy2xdHSHnc0lGCjl9CU3ACz7ckb3HJqxVuJ6yF4kgEiJDRB6D9SwqzMmTnfVCgmFDtk9Rb6qNEab70MAOCGgGmOxjkFJGOgIlme6dIGzTRYaTSLMbiRLx80GeI3ZDQtdAnMDpnYmBTn3k+mAGDyAe1x7JQUPBcDgZj/hmSNfPHlB5Qy30xOMnRp38O5nlyMCC779jS3BVrp+kPgGfrvR8NeUg4NT4PUXIE/wl3x528bZ1KTm7fJE1/ILZNJMA7B4G9B2la7tbzNhlZ+Or0yZQwMybSWQpI23ZsDXqpDU/K+Y6ZylU2muFH+3ol3k9/dc38/I40iRsAzIvEhSPRmMh8aXzNZkO21pPOj+vXwLG25+I2PBCxhg7aB95HHph2dtuxIeg2iGufJZkXIV/90je/eLjPk5Avze4DmkDtghOcgBMXs0u/lLARLv/z7Mpk0eTqL4iO+GsrfPVKIE78Kdu/hJDRzDstDK2wpFqUPthXIl6+QZLxNngfEzZLfGdMntqO25iQ+6lcjqXKbTLqElY7Gh7PV3tnFkK924MkSGtIb9wqD87a5A+Nh0g2U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR15MB6078.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(122000001)(83380400001)(71200400001)(8676002)(8936002)(2906002)(966005)(52536014)(166002)(55016003)(19627235002)(41300700001)(9686003)(5660300002)(86362001)(6506007)(316002)(6916009)(26005)(478600001)(76116006)(7696005)(38070700009)(33656002)(38100700002)(66476007)(66946007)(66556008)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?osYBZugwG/9o7FlmjPDW0pZEgV5F0tz21QQGulUnvKdsj1kC7IdfJHD/?=
 =?Windows-1252?Q?fKTUytCLVwpshg2/z1DYgc6TMGsAkbbESSlTIFDjfC6mCQEZbNh5DepP?=
 =?Windows-1252?Q?evD9rSnvLtujk26eN3AwWG6dZ9CMXejZAdgiUsam6y81owD0MN/tKJAG?=
 =?Windows-1252?Q?IVhSInQCPz45iGi4vGOWL1ts8NGap8zd3IFSEcTu/X2ZBg+oNdoiYg82?=
 =?Windows-1252?Q?xA+QrXd951Jwl6AMS/1xqhZ85ApkiU0u+Aw9eA3F7izu00Gtf9c/Nxvw?=
 =?Windows-1252?Q?gOue4XeTjCskxsPYGiYd/zNYL/IH0XeMJBQu88FLu48byS0k1C9ynZ98?=
 =?Windows-1252?Q?l1woJE/cwdIpdE8o5gog99/r1CKHOHxQwVj+JM5evS0GdyhgluhWwWU4?=
 =?Windows-1252?Q?gnGqELEci+c8QD8CVLWCsU3ro3QM80h4KLX9IlpNU9pr8yeB0pwno20b?=
 =?Windows-1252?Q?J1szi4YX8GIWN13Sh46MxRUwe+j15uEltWQg8RdJKtBxcYebuFj0Vrfc?=
 =?Windows-1252?Q?gkzO6EGNjzkk2PgirWJHvEVoap8GWP1npnAy4j7ALCdpDNIC19BXPQV2?=
 =?Windows-1252?Q?mSUnxxcMC9YC7rxkD2WkF6GkfeBFNbtywQ2Fk6Obf3TirZWR3rneLZrJ?=
 =?Windows-1252?Q?AmyTVa0ILCAxo6T8W/Be00RUJddDeJvW82vXlslMNSDloGSGtKU0cKUS?=
 =?Windows-1252?Q?MXED8zdxowOf7CcGmeEKN3ks0aIQG2V8lIitZT10GMIhrqe2GEI212TS?=
 =?Windows-1252?Q?M9J4XDsUWW1H1nKxIAVc0kuACZpti4Lt4h0D6F+O9OlW4ZIHHEgeDwWu?=
 =?Windows-1252?Q?WnQeEAoU9OTZVPVDatHGFcDOnfhmriCytrdIT1O5mOs2g2d27hn5fYqP?=
 =?Windows-1252?Q?pfbGWptPdbnGhLhRfYyZQ0ulgViyUigTFbG4Dx6znBs1VFv7/epR5oYh?=
 =?Windows-1252?Q?5EvNciTvDk15ahY5+vK1uXobMFgWjfDEcoeoF6XzY3EobvgTOAv3XqVt?=
 =?Windows-1252?Q?kZ4BN7sn7CblilvilZAHhsk9IvFJtG2iwnbh/A4RSyeiTkv0ZcXUAJIF?=
 =?Windows-1252?Q?rgH8Gx0yr7lHKGAIabyD/Xi1VMjuNT/Ne59pflujq41mOCnIfAsfuexp?=
 =?Windows-1252?Q?glHEucoShkZ5l9kCs02SmMkIOxlmms67WijfEkL64C8ElDp5bFsk1PBY?=
 =?Windows-1252?Q?YlCVByOdvN9AodufXQqx6ZqZK4kW2Hus/6vwE8KlugKeaBc/5ciVYHZd?=
 =?Windows-1252?Q?nyVXXIPqWfrQ911/v7uQ9msfQIuUTsxPyRqQdBxf2CnoC/vXhazEG4QX?=
 =?Windows-1252?Q?aUkKyLYxMQ5Fww5/hbr1xahDhd5Iehq0Chfz2gwff/uX/Sw8CNGQu3o3?=
 =?Windows-1252?Q?jQUmJXfpFS6DRMMDwOR8eceWP7POr/ntmb9g0Y8W0X+NPXzUsWx8UhxD?=
 =?Windows-1252?Q?677QGY1bobBWS/VhkaQ/uXBKgfmRlRoipd5PYNNd5tYdu4AZ/Ik+zjZM?=
 =?Windows-1252?Q?RWq9U7ziZRzMJiGgD0D3BJeW+v1R9L8E9vxUR7IkfQov761cEG/soC5a?=
 =?Windows-1252?Q?J94rBLNLfpvneZD6+N4eY0Pu4bRW/kp9mDsK6TxHbF5EU8dMiTiD4Uqi?=
 =?Windows-1252?Q?7i/Llnc0xz59pta+RwSSRjkYHTq70y3ExLcj4EU0uWcMhFQaClfqI2BS?=
 =?Windows-1252?Q?LqIyWDv5IGI4vn1f+NT+zKPIn3Pu1pOaE5ZrwdlN1C0Ft2cw1aUGTw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY1PR15MB607818DFB03A6EF7D260F963F7DFABY1PR15MB6078namp_"
X-OriginatorOrg: CN.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR15MB6078.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aba5fd3-6058-45e9-fd99-08dbd5b3b204
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 23:39:56.5047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTG9GIn6IHdCas9RXzMRrjnGhPGf12L31GmD7NnDGXyIkbFyPPH8ZF74dUbS5S0Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5286
X-Proofpoint-GUID: jdz1xIPq9CXRAOzuj3q7klSPdVEF6ZkP
X-Proofpoint-ORIG-GUID: jdz1xIPq9CXRAOzuj3q7klSPdVEF6ZkP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_13,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250200
Received-SPF: pass client-ip=148.163.156.1; envelope-from=wucf@cn.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_BY1PR15MB607818DFB03A6EF7D260F963F7DFABY1PR15MB6078namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to use =93'throttle' block filter=94 mentioned at https://githu=
b.com/qemu/qemu/blob/master/docs/throttle.txt, however, it seems not work w=
ith the following steps, did I miss or mis-understand anything?

1. In RHEL 8.8, I created one vm

qemu-kvm -m 2048 -drive file=3D/virt/images/focal-server-cloudimg-amd64.img=
 -drive file=3D/virt/disks/vm1_disk_1.qcow2 -drive file=3D/virt/disks/vm1_d=
isk_2.qcow2 -serial stdio -vga virtio -display default -qmp tcp:localhost:4=
444,server,wait=3Doff

2. telnet vm

telnet localhost 4444
{"execute": "qmp_capabilities"}

3. add a new data disk ()
{"execute": "blockdev-add", "arguments": {"node-name": "disk7", "driver": "=
qcow2", "file": {"driver": "file", "filename": "/virt/disks/vm1_disk_7.qcow=
2"}}}

4. create a new throttle group
{"execute": "object-add", "arguments": {"qom-type": "throttle-group", "id":=
 "limit1", "limits": {"iops-total": 1000}}}

5. add a throttle filter to disk
{"execute": "blockdev-add", "arguments": {"driver": "throttle", "node-name"=
: "throttle1", "throttle-group": "limit1", "file": "disk7"}}

6. associate the disk with vm
{"execute": "device_add", "arguments": {"driver": "virtio-blk", "id": "blk7=
", "drive": "disk7"}}

7. fio test within vm (limit is 1000, while fio gets 2445 in avg)
fio --name=3Dmytest --ioengine=3Dsync --rw=3Drandwrite --bs=3D4k --size=3D2=
0G --numjobs=3D1 --time_based --runtime=3D300s --filename=3D/dev/vda

mytest: (g=3D0): rw=3Drandwrite, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T)=
 4096B-4096B, ioengine=3Dsync, iodepth=3D1
fio-3.16
Starting 1 process
Jobs: 1 (f=3D1): [f(1)][100.0%][eta 00m:00s]
mytest: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D959: Tue Oct 24 15:11:38 2=
023
  write: IOPS=3D2446, BW=3D9784KiB/s (10.0MB/s)(2867MiB/300016msec); 0 zone=
 resets
    clat (usec): min=3D3, max=3D131566, avg=3D399.31, stdev=3D3128.70
     lat (usec): min=3D4, max=3D131568, avg=3D401.12, stdev=3D3128.72
    clat percentiles (usec):
     |  1.00th=3D[    5],  5.00th=3D[    6], 10.00th=3D[    6], 20.00th=3D[=
    6],
     | 30.00th=3D[    6], 40.00th=3D[    7], 50.00th=3D[    7], 60.00th=3D[=
    8],
     | 70.00th=3D[   10], 80.00th=3D[   11], 90.00th=3D[   29], 95.00th=3D[=
   94],
     | 99.00th=3D[23462], 99.50th=3D[23987], 99.90th=3D[31589], 99.95th=3D[=
33817],
     | 99.99th=3D[43779]
   bw (  KiB/s): min=3D  896, max=3D248856, per=3D99.98%, avg=3D9781.85, st=
dev=3D26238.98, samples=3D600
   iops        : min=3D  224, max=3D62214, avg=3D2445.43, stdev=3D6559.75, =
samples=3D600
  lat (usec)   : 4=3D0.01%, 10=3D76.84%, 20=3D11.91%, 50=3D3.37%, 100=3D3.2=
9%
  lat (usec)   : 250=3D2.49%, 500=3D0.33%, 750=3D0.07%, 1000=3D0.04%
  lat (msec)   : 2=3D0.04%, 4=3D0.02%, 10=3D0.02%, 20=3D0.33%, 50=3D1.24%
  lat (msec)   : 100=3D0.01%, 250=3D0.01%
  cpu          : usr=3D1.32%, sys=3D4.32%, ctx=3D23971, majf=3D0, minf=3D11
  IO depths    : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     issued rwts: total=3D0,733855,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D1

Run status group 0 (all jobs):
  WRITE: bw=3D9784KiB/s (10.0MB/s), 9784KiB/s-9784KiB/s (10.0MB/s-10.0MB/s)=
, io=3D2867MiB (3006MB), run=3D300016-300016msec

Disk stats (read/write):
  vda: ios=3D0/660825, merge=3D0/17257, ticks=3D0/39116357, in_queue=3D3823=
6828, util=3D98.23%

--_000_BY1PR15MB607818DFB03A6EF7D260F963F7DFABY1PR15MB6078namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi,<br>
<br>
I am trying to use =93'throttle' block filter=94 mentioned at <a href=3D"ht=
tps://github.com/qemu/qemu/blob/master/docs/throttle.txt">
https://github.com/qemu/qemu/blob/master/docs/throttle.txt</a>, however, it=
 seems not work with the following steps, did I miss or mis-understand anyt=
hing?
<br>
<br>
1. In RHEL 8.8, I created one vm<br>
<br>
<i>qemu-kvm -m 2048 -drive file=3D/virt/images/focal-server-cloudimg-amd64.=
img -drive file=3D/virt/disks/vm1_disk_1.qcow2 -drive file=3D/virt/disks/vm=
1_disk_2.qcow2 -serial stdio -vga virtio -display default -qmp tcp:localhos=
t:4444,server,wait=3Doff<o:p></o:p></i></span></p>
<p class=3D"MsoNormal"><i><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></i>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2. telnet vm<br>
<br>
telnet localhost 4444<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">{&quot;execute&quot;: &quot;qmp=
_capabilities&quot;}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">3. add a new data disk ()<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">{&quot;execute&quot;: &quot;blo=
ckdev-add&quot;, &quot;arguments&quot;: {&quot;node-name&quot;: &quot;disk7=
&quot;, &quot;driver&quot;: &quot;qcow2&quot;, &quot;file&quot;: {&quot;dri=
ver&quot;: &quot;file&quot;, &quot;filename&quot;: &quot;/virt/disks/vm1_di=
sk_7.qcow2&quot;}}}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">4. create a new throttle group<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">{&quot;execute&quot;: &quot;obj=
ect-add&quot;, &quot;arguments&quot;: {&quot;qom-type&quot;: &quot;throttle=
-group&quot;, &quot;id&quot;: &quot;limit1&quot;, &quot;limits&quot;: {&quo=
t;iops-total&quot;: 1000}}}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">5. add a throttle filter to dis=
k<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">{&quot;execute&quot;: &quot;blo=
ckdev-add&quot;, &quot;arguments&quot;: {&quot;driver&quot;: &quot;throttle=
&quot;, &quot;node-name&quot;: &quot;throttle1&quot;, &quot;throttle-group&=
quot;: &quot;limit1&quot;, &quot;file&quot;: &quot;disk7&quot;}}<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">6. associate the disk with vm<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">{&quot;execute&quot;: &quot;dev=
ice_add&quot;, &quot;arguments&quot;: {&quot;driver&quot;: &quot;virtio-blk=
&quot;, &quot;id&quot;: &quot;blk7&quot;, &quot;drive&quot;: &quot;disk7&qu=
ot;}}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">7. fio test within vm (limit is=
 1000, while fio gets 2445 in avg)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">fio --name=3Dmytest --ioengine=
=3Dsync --rw=3Drandwrite --bs=3D4k --size=3D20G --numjobs=3D1 --time_based =
--runtime=3D300s --filename=3D/dev/vda<br>
<br>
mytest: (g=3D0): rw=3Drandwrite, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T)=
 4096B-4096B, ioengine=3Dsync, iodepth=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">fio-3.16<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Starting 1 process<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Jobs: 1 (f=3D1): [f(1)][100.0%]=
[eta 00m:00s]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">mytest: (groupid=3D0, jobs=3D1)=
: err=3D 0: pid=3D959: Tue Oct 24 15:11:38 2023<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; write: IOPS=3D2446, BW=
=3D9784KiB/s (10.0MB/s)(2867MiB/300016msec); 0 zone resets<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; clat (usec):=
 min=3D3, max=3D131566, avg=3D399.31, stdev=3D3128.70<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; lat (u=
sec): min=3D4, max=3D131568, avg=3D401.12, stdev=3D3128.72<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; clat percent=
iles (usec):<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp=
; 1.00th=3D[&nbsp;&nbsp;&nbsp; 5],&nbsp; 5.00th=3D[&nbsp;&nbsp;&nbsp; 6], 1=
0.00th=3D[&nbsp;&nbsp;&nbsp; 6], 20.00th=3D[&nbsp;&nbsp;&nbsp; 6],<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; | 30.0=
0th=3D[&nbsp;&nbsp;&nbsp; 6], 40.00th=3D[&nbsp;&nbsp;&nbsp; 7], 50.00th=3D[=
&nbsp;&nbsp;&nbsp; 7], 60.00th=3D[&nbsp;&nbsp;&nbsp; 8],<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; | 70.0=
0th=3D[&nbsp;&nbsp; 10], 80.00th=3D[&nbsp;&nbsp; 11], 90.00th=3D[&nbsp;&nbs=
p; 29], 95.00th=3D[&nbsp;&nbsp; 94],<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; | 99.0=
0th=3D[23462], 99.50th=3D[23987], 99.90th=3D[31589], 99.95th=3D[33817],<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; | 99.9=
9th=3D[43779]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; bw (&nbsp; KiB/s):=
 min=3D&nbsp; 896, max=3D248856, per=3D99.98%, avg=3D9781.85, stdev=3D26238=
.98, samples=3D600<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; iops&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; : min=3D&nbsp; 224, max=3D62214, avg=3D2445.43=
, stdev=3D6559.75, samples=3D600<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; lat (usec)&nbsp;&nbsp; :=
 4=3D0.01%, 10=3D76.84%, 20=3D11.91%, 50=3D3.37%, 100=3D3.29%<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; lat (usec)&nbsp;&nbsp; :=
 250=3D2.49%, 500=3D0.33%, 750=3D0.07%, 1000=3D0.04%<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; lat (msec)&nbsp;&nbsp; :=
 2=3D0.04%, 4=3D0.02%, 10=3D0.02%, 20=3D0.33%, 50=3D1.24%<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; lat (msec)&nbsp;&nbsp; :=
 100=3D0.01%, 250=3D0.01%<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; cpu&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : usr=3D1.32%, sys=3D4.32%, ctx=3D23971, =
majf=3D0, minf=3D11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; IO depths&nbsp;&nbsp;&nb=
sp; : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, &gt;=
=3D64=3D0.0%<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; submit=
&nbsp;&nbsp;&nbsp; : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, &gt;=3D64=3D0.0%<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; comple=
te&nbsp; : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,=
 &gt;=3D64=3D0.0%<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; issued=
 rwts: total=3D0,733855,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; latenc=
y&nbsp;&nbsp; : target=3D0, window=3D0, percentile=3D100.00%, depth=3D1<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Run status group 0 (all jobs):<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; WRITE: bw=3D9784KiB/s (1=
0.0MB/s), 9784KiB/s-9784KiB/s (10.0MB/s-10.0MB/s), io=3D2867MiB (3006MB), r=
un=3D300016-300016msec<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Disk stats (read/write):<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; vda: ios=3D0/660825, mer=
ge=3D0/17257, ticks=3D0/39116357, in_queue=3D38236828, util=3D98.23%<o:p></=
o:p></span></p>
</div>
</body>
</html>

--_000_BY1PR15MB607818DFB03A6EF7D260F963F7DFABY1PR15MB6078namp_--

