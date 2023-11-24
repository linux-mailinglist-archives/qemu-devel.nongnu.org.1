Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E18687F86A3
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 00:25:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6fXJ-00038O-0b; Fri, 24 Nov 2023 18:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569229df20=volodymyr_babchuk@epam.com>)
 id 1r6fXH-00038G-I7
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 18:24:35 -0500
Received: from mx0b-0039f301.pphosted.com ([148.163.137.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569229df20=volodymyr_babchuk@epam.com>)
 id 1r6fXF-0003dF-KA
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 18:24:35 -0500
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AOMwAPF014042; Fri, 24 Nov 2023 23:24:27 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3uk2wmr6b0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 23:24:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCppyEzxa8lFJBtiG6ZuzWvF76k0EGTFjhAlANH/UPTQqKeRxJcTpYVMjIHTAhij+FBxs+CyKAGBtsd+nN+/8PiLjWxIqyqCaBZi2Yh97pEHbZ4Isu+AuHeYuEjxhzGGtw5GH1CqpX2bUJJcz3AfgZOd8tDnIEGU/OlKFCIBzV9GvuNhhc+3e4N+/I1HbQUbzr5Lq2NLpf3I7sV0oA+gvp6+b8iqt32PFk89P7uZCprve8Bzp4+1M46n41EtftmOczJpemdP62trjjMuGch8bog5qj4MNEhC6D4sIZLiQ4s4CZfB0JUYAlGWGRH3SL2yqxNnUxMbLj7pCqEMyEi6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZBO15g0MzzrmI/JICZczZV+fx+qK8Wj6HQbYNMx9Ts=;
 b=ns1RHWXMn15aFLCM8VrR2k8qhPhlmbJLwJmTe6+QOxDfoKiMRAZarYB3a05d3IOzXnaPLKM0G6SDer/7jDCckDeSrSrr6c0Hp195wk2EinHefG2upDMCfv3YR9RxBJsxeaUvie2w9pw7331m/7hWBngH2J/uOKyLrTq3GV0WLmY6G6PDP9UwcMG2k8wI0e5KMBK+uJgYnDDYn2I55O4lNjfGmUS3VOPdBjmz3oyc1C25pJxbpkSW3UYX6aFlqafRi8PUjAUCRiLBydHIzRK77OasK98Uu84x5LCn/twpQqQVDzjo5vMwqcu+oYmBafVEuMu4EP8CEvG7sA/WssNpGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZBO15g0MzzrmI/JICZczZV+fx+qK8Wj6HQbYNMx9Ts=;
 b=Z92zS295D4jJ57GdwxqgQMz25sBsYK4j2SsyA/V4vVkMM+ym5e1JhRKMkAfnnursk181QMzTWctGi5n/JrRbtesDAR0mJSb/d0682zm/rDowMAXZ1bAXLICwI09d6GJdmmgrKdZvho1XuEWYX115CqYPWilswmVHOrww7YVjGPiOlsqH5YnUhzuw1L7rWoenXs2FH9pmnNdG4/CjfKsJjHjt0FkgDJ1jLt686Vy4KwovH1QPVcr6BTE3mt9T6I/NhsLrJFtkGZLiWDVROZaQ6vwUoHRMfDQShTsTnWMlZG9OnRtOK7jj7flfUDHq3vJLvoXuSxHt/zf7WOseUrZS6w==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by DU0PR03MB8551.eurprd03.prod.outlook.com (2603:10a6:10:3e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 23:24:22 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822%6]) with mapi id 15.20.7025.022; Fri, 24 Nov 2023
 23:24:21 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Stefano Stabellini
 <sstabellini@kernel.org>, Julien Grall <julien@xen.org>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>
Subject: [PATCH v3 0/5] xen-arm: add support for virtio-pci
Thread-Topic: [PATCH v3 0/5] xen-arm: add support for virtio-pci
Thread-Index: AQHaHy1a4DItqlva2E6FE9Ek6bro0g==
Date: Fri, 24 Nov 2023 23:24:21 +0000
Message-ID: <20231124232400.943580-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.42.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3710:EE_|DU0PR03MB8551:EE_
x-ms-office365-filtering-correlation-id: bebf273e-77f8-4348-3d48-08dbed447d2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OdMVdhRozmLFnScQYq2HlXL0Py0TG0gxCmu7gGDnSIuYLfa8H/6/DPt0VDlHEb4CGU1CZqXHy0Z1AxoXj6/W0nut9V4Y5z1miF+2E2atXi+95cjo39rE50KX8PChrTyckDZLHaqIO3LFgX8c9g+jeDqvOFsot1mHCL4H5rM0VAAh3cqQuRRunBEs0+eBEy34iAmqhk8Eok5ZmRhqAcklBoNwfbcNoKTOP/U1yNPREq52eVkHEMhKaEisC/ExE+X1OMqGakcO/PyuMKsHmX0EYTLLpuBgVXSUBEJLNLlwEP1VKBThnbsDIBo7sfpqTNYiewBmapAJVT7dmkdgXh6PEdD/JSCLsbZ6op8nimmYJvUyqdr5CaxeVb0OR7HVQK7DCa0b1Toe6dwioCZzwdqQ0sYEgEN34GCOoXWuqJGhhxitzV5gYjosIYGLm/9zuY7oWUY2A8261I5NUuHnrrefq7nCvQBqR84MZFMhVBZNChdGk1znXIMt7nMcIoOvwBUEiqHoRQKgZ5p9auK1ebCNcuP+4Jj3Uqqy9XjJE4Ms/JnOq/4jcKadr7yoijU2bBsScdRoUrcOKUHzo4bs2TIfOo0hvVBW9WUxOIDYKIHqG5jmjxMHaxI8GLufxAep8+Eu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB3710.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(1076003)(6512007)(83380400001)(2616005)(6506007)(107886003)(55236004)(71200400001)(41300700001)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6486002)(2906002)(6916009)(316002)(91956017)(66476007)(66446008)(54906003)(64756008)(76116006)(66946007)(66556008)(86362001)(122000001)(36756003)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmhPVzR6UUJqR0VSKzZEY3RFRXNOQWxscmZCaURWbHl5VUlLRXp3ajI4YzhT?=
 =?utf-8?B?ZWRYcU1tL1lDdmZuYm01K0hWR2JzMkE2aEpSZ20xOHNqYmlpVlRlaVdnbUJ3?=
 =?utf-8?B?OWp1SlhMaDU1SnlzM1ZIWWxWdkFSRktxQWJHellVWmdWdHYzdlpnWkRrMnVF?=
 =?utf-8?B?ZFFzUnQwbCt1SlZVMXdIUExGN0g4ekZGL3NoK3pUK1pwQ1VNL2dTWlhMVDA0?=
 =?utf-8?B?TWhBdW1PZ2grWitEMll0RExiZnIxSXVJbjMrZjRiUER6N01tV0pmV3ZhY01k?=
 =?utf-8?B?RFEvd0dQMVNBOVdmRUQ0WDd3VU05a3ZjbldmbUJ0VlhkVDBGeUFVMDFSQUZY?=
 =?utf-8?B?bWdlWHFTcjhKeWk2RUF4TURubExBN3FVdnI0WG4xUUNpclA2My9KYng5UXM1?=
 =?utf-8?B?Y3pSTmx3bjE3UGxJTi9pNzFQN0NmMVRCdElRanc1L3phd3J0aVJod2dBTDZY?=
 =?utf-8?B?QmRvRXUxREVSQmFOUjhVeExEZWdUckh5UWhtNGRQRHJnWjdkTFp2NXdUY0lU?=
 =?utf-8?B?RUIxcTE0anY5SmhreHMvMHF6a1RhTTBsT2EvVEc3eG9Ub3RIVFFQZ29yYWhL?=
 =?utf-8?B?dGxjZ0RNN2J4cHhjZFFEMHEyRHMvQWltMjl2aFBNS1VLblo0UVUvVEM4emtD?=
 =?utf-8?B?WEdHeTFiOGVsbzZVYmo4dFhwbTZyOS9SOVRtUGRjaEhScUNtTlJncGVDLzV2?=
 =?utf-8?B?VEM3VkkyYUhQRlZENUVHVjRMUDd5QWh2MHFGVE9uRzlGWEFWb0tDaVRHdHFz?=
 =?utf-8?B?blhFR2tsT0o3ZUkvQmF2MG8rSGxpU29kd2dHWlAwNGZhbWozV0JUQ01uMGR4?=
 =?utf-8?B?aGppWWYwYWlkSHV1dy9iYnVCWGlLbWJROUNRd1B4SFNtMHRpbVVSM2lvMjRD?=
 =?utf-8?B?VERDMTNyU2hCend1bFNia3FHYThZaVllZzRkYlp1bnltRUlKdjJVd1o3a2to?=
 =?utf-8?B?b24wUXFZMmJIVU1vVDNONk50blJhMzFsWndUS2RiNmZNQW1leno0L2U4RmJY?=
 =?utf-8?B?OWlMd0Myb2I5N1lHNmNvNjRuMnA5S1FyZGhxd1BtTEQ3QTdEMVZBeHFDRWFh?=
 =?utf-8?B?ODJkSk5pZnpEa2V3bzZnSHFqc1F4eWY3RXkrbTIveG1iQmRXMmdxdjhFbncv?=
 =?utf-8?B?YnJsWmtiNXFZdlM2UW5CbXZIOTZ4Z0N5MGRpc2k4T0RQNVYyU2d1VDRGZy9a?=
 =?utf-8?B?SEJZeFN6TVBkRmtKUGFwT0tvSnFwODJMWjdwMzAxTmVmMXBaTStoVXpmdE1y?=
 =?utf-8?B?SjQvRi95Q3lVVTlEaXRkUzRic25lNFZ3TWUwR0NkNjRBbUlZeFB0eHo3TEIw?=
 =?utf-8?B?V2tuemhDbjJhWVVCNEJsQ0pHRkxuNHJtRnJqL0g2Wkt1eDBGQ2N5NGZOb1VZ?=
 =?utf-8?B?MThVOFhtTFM2aW9xY09vOHBPSUQ3NjVwVjQ5TDVHN0ZYM282MGpZbStEMzVm?=
 =?utf-8?B?d0xHMXNpV1lGMGkxQktrdENTRGNuN1JVZUdFZTlSS2piNU13VnRPRjVVMkpz?=
 =?utf-8?B?S3hiZ0tDeTQzZ2x2TXpYK0RiRThKNUM3MTBiRXB4YTBsbVFYR3JOb3VFMkhh?=
 =?utf-8?B?Ny92QVZPdlBJTzRBWHJNNkhRcVhSUk1iVGpQRHdtM2l1R2dpeXRVM21ZKzJX?=
 =?utf-8?B?TkJRSDdRWWVtYy93MWUwaHgxUE1xa0xXUzBmZ3N3a0VVVnUrQ09sSDQvMkNZ?=
 =?utf-8?B?MDRyWEtqSkxhb0xWUnpjS1dxazV5UE9GVWJ5dXhwRGJQbjhHTnF5ODFYcmor?=
 =?utf-8?B?VjY3SThrRnJiZmRxWVI1NDM1WjVEcGhaTFBEWjRxaHdibUp5bDdWakFHUUlH?=
 =?utf-8?B?YWh1eXk3VUVBQklBRmdjV1NmaHQ3Vm9ibkI0WTVISXNYSS94UHNzc1FXODVZ?=
 =?utf-8?B?MThUSkRySEE0amR5d0xVd1M1ZWdya0Y3UWxaN2NUbWpKeTdZVWJkWlU1c1ZI?=
 =?utf-8?B?VXFsT2RHTFZ3T0N2SGozdEplZ1U2NHhNSmJPdVV0cW81MTVCVnRGTXA0WDlv?=
 =?utf-8?B?UnFQT3EzZWRKVW16T3NJU2NTdkE0VjUvYjBuMHFiWm1jRnhUaGw4S0NYSEZP?=
 =?utf-8?B?anpHUHI5ZXQrMExmQnZ3bVVYTTBpWWxaQzdvalY5YUY5RmVvNXV3dVFJMDZ3?=
 =?utf-8?B?VGtBNzk5VWFKc3ZhZzZrVVFTclpzaUp5Q2Z3ZXhzU3pFcUtrNW13QTJCMGpS?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97987F5A3C78494CB46B7CD45BCA5F38@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebf273e-77f8-4348-3d48-08dbed447d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 23:24:21.6139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uL+ObeDygzMk9mVD6DhGVoU19wU1EuKFv/uskCoxJm0rngGBo4UwqJ7kBHK0QL5pPvvKCHYfIHDNcXiHgaAavzFsGFxfwFnf7QTiTz6fe+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8551
X-Proofpoint-GUID: V-0bXz6-WetLd4Yn9Ucf-XaLgwmHaV1C
X-Proofpoint-ORIG-GUID: V-0bXz6-WetLd4Yn9Ucf-XaLgwmHaV1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 mlxlogscore=926 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311240182
Received-SPF: pass client-ip=148.163.137.242;
 envelope-from=prvs=569229df20=volodymyr_babchuk@epam.com;
 helo=mx0b-0039f301.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGVsbG8sDQoNClRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgdGhlIGJhc2ljIHN1cHBvcnQgZm9yIHZp
cnRpby1wY2kgZm9yIHhlbi1hcm0NCmd1ZXN0cy4gVGhlIG1haW4gY2hhbmdlcyBhcmUgaW4gInhl
bl9hcm06IEFkZCB2aXJ0dWFsIFBDSWUgaG9zdCBicmlkZ2UNCnN1cHBvcnQiLCB3aGlsZSBtb3N0
IG9mIG90aGVyIHBhdGNoZXMgYXJlIHJlcXVpcmVkIHRvIG1ha2UgUUVNVSB3b3JrDQphcyBkZXZp
Y2UgbW9kZWwgaW4gYSBub24tcHJpdmlsZWdlZCBkb21haW5zIGxpa2UgZHJpdmVyIGRvbWFpbi4N
Cg0KTmV3IGluIHZlcnNpb24gMzoNCg0KIC0gVXNlIGNvbW1hbmRsaW5lL3Byb3BlcnRpZXMgaW5z
dGVhZCBvZiB4ZW5zdG9yZSBlbnRyaWVzIHRvIGNvbmZpZ3VyZQ0KICAgUENJZSBicmlkZ2UNCiAt
IEluc3RlYWQgb2YgdHJ5aW5nIHRvIGZpeCBsZWdhY3kgYmFja2VuZHMsIGp1c3QgYWRkIG9wdGlv
biB0byBkaXNhYmxlDQogICB0aGVtDQoNCkRhdmlkIFdvb2Rob3VzZSAoMSk6DQogIGh3L3hlbjog
U2V0IFhlbkJhY2tlbmRJbnN0YW5jZSBpbiB0aGUgWGVuRGV2aWNlIGJlZm9yZSByZWFsaXppbmcg
aXQNCg0KT2xla3NhbmRyIFR5c2hjaGVua28gKDIpOg0KICB4ZW5fYXJtOiBzZXQgbWMtPm1heF9j
cHVzIHRvIEdVRVNUX01BWF9WQ1BVUw0KICB4ZW5fYXJtOiBBZGQgdmlydHVhbCBQQ0llIGhvc3Qg
YnJpZGdlIHN1cHBvcnQNCg0KVm9sb2R5bXlyIEJhYmNodWsgKDIpOg0KICB4ZW46IGJhY2tlbmRz
OiBkb24ndCBvdmVyd3JpdGUgWGVuU3RvcmUgbm9kZXMgY3JlYXRlZCBieSB0b29sc3RhY2sNCiAg
eGVuOiBhZGQgb3B0aW9uIHRvIGRpc2FibGUgbGVnYWN5IGJhY2tlbmRzDQoNCiBhY2NlbC94ZW4v
eGVuLWFsbC5jICAgICAgICAgICB8ICAxMyArLQ0KIGh3LzlwZnMvbWVzb24uYnVpbGQgICAgICAg
ICAgIHwgICA0ICstDQogaHcvYXJtL3hlbl9hcm0uYyAgICAgICAgICAgICAgfCAyMjggKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIGh3L2Jsb2NrL3hlbi1ibG9jay5jICAgICAg
ICAgIHwgIDE5ICstLQ0KIGh3L2NoYXIveGVuX2NvbnNvbGUuYyAgICAgICAgIHwgICA0ICstDQog
aHcvZGlzcGxheS9tZXNvbi5idWlsZCAgICAgICAgfCAgIDQgKy0NCiBody9pMzg2L3BjLmMgICAg
ICAgICAgICAgICAgICB8ICAgMiArDQogaHcvbmV0L3hlbl9uaWMuYyAgICAgICAgICAgICAgfCAg
MjAgKy0tDQogaHcvdXNiL21lc29uLmJ1aWxkICAgICAgICAgICAgfCAgIDUgKy0NCiBody94ZW4v
bWVzb24uYnVpbGQgICAgICAgICAgICB8ICAxMSArLQ0KIGh3L3hlbi94ZW4tYmFja2VuZC5jICAg
ICAgICAgIHwgIDE1ICstLQ0KIGh3L3hlbi94ZW4tYnVzLmMgICAgICAgICAgICAgIHwgIDE4ICsr
LQ0KIGh3L3hlbi94ZW4taHZtLWNvbW1vbi5jICAgICAgIHwgIDExICstDQogaHcveGVuL3hlbi1s
ZWdhY3ktYmFja2VuZC5jICAgfCAgIDcgLS0NCiBody94ZW5wdi94ZW5fbWFjaGluZV9wdi5jICAg
ICB8ICAgMiArDQogaW5jbHVkZS9ody94ZW4veGVuLWJhY2tlbmQuaCAgfCAgIDIgLQ0KIGluY2x1
ZGUvaHcveGVuL3hlbi1idXMuaCAgICAgIHwgICAyICsNCiBpbmNsdWRlL2h3L3hlbi94ZW5fbmF0
aXZlLmggICB8ICAgOCArLQ0KIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgIHwgICA1ICsN
CiBtZXNvbl9vcHRpb25zLnR4dCAgICAgICAgICAgICB8ICAgMiArDQogc2NyaXB0cy9tZXNvbi1i
dWlsZG9wdGlvbnMuc2ggfCAgIDQgKw0KIDIxIGZpbGVzIGNoYW5nZWQsIDMyNSBpbnNlcnRpb25z
KCspLCA2MSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjQyLjANCg==

