Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59080199C
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 02:43:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9F1G-0007ME-Cv; Fri, 01 Dec 2023 20:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6700ee1bd8=volodymyr_babchuk@epam.com>)
 id 1r9F0r-0007Ls-GS
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 20:41:45 -0500
Received: from mx0b-0039f301.pphosted.com ([148.163.137.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6700ee1bd8=volodymyr_babchuk@epam.com>)
 id 1r9F0e-00057G-1p
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 20:41:43 -0500
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 3B21X1Ql015641;
 Sat, 2 Dec 2023 01:41:25 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3uqa3aucrx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 02 Dec 2023 01:41:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPCq5cApV2L0Lfv6BPPWFNNGzRV2tvw83/8a3m+PiSRpMfc1fPNLy4Oc0nLmGO1YtfC3hB3Lfxrh+xgoqbo5+hTgkG8iUPtZEYk70qsIEqc6PCnyz7KIUvfh6SPweEwthMhwIkC9lbmTyKfKS8YXyEV62vexIgVBt9D7S1ijLvDBnmliprMYPOG0EMcZlzIqVygYq4hFeZP6wThoBWiop/2zuHI4JfmkeYgBIIwZoG+doK5vXOU9hrtxQf6gf7u/fsi41vnlf3/Ra/oRDmFEOB4pgMZd7+BAAfdnSjW9Bi73qtPHK8isqHKjK+eO2ih9zb0v5iW8V4OEZDgySlHFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFni0Ra8TgZ/MP1e/lKEN7Dum2s00i624JyONQZgGXI=;
 b=FjrqUwMg2j7fqnzbrAb3JvT4O1MqZ9uu+2cZN8uiBOTY1O1dh/W+aoIX8RsU8MpdBJK2I6VzDOLHAeiCosf0h/NRKM91sCCc8BGHLfE1qpuhK/fC5KwW8mKLvPFU755DHUbT7TN204U1GlAo1Ey3FSbuHxiWk5V6qxzPrGXMgGbsXdY2sVJ/7NGdpxUOyKYOSbVPp9i9m0QO9hYz4PX3zZRxXSZ/YDJhpmZ75pgLaO3sarl9ekyW4b880qZqzG1wh0+J1o8ou/7wytpGYAGUIdH7LbChZtGEVcUbh3Z/FUDxyQYn1CeeiiGgOGrg/a7McCrJCVzPl2iz5qUe44QsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFni0Ra8TgZ/MP1e/lKEN7Dum2s00i624JyONQZgGXI=;
 b=Fgch3NJNi4fGvP+kJRO+yVPYxVa8YjPb92ATD5i1G0lDE68zsAmBpt5vhVpmYvj6cP80gwQYea6x8Kbae05dJcK/I+H8W1wWqCoryGtx3YyMnYeBQ11WRAzkq1FI01D+4GSOztNRpmkaDizGk/laY8a92wf17OBozxTwuXRBo8TN5/A+ktscXGkkoAJ0Do1awvt0l7wJmIrWvhdbGbCeGU8Ib47TFbmSrUIAu24u10b+6cutHcVm5Ri+4i/hoV4on0MxT22os2Zo226yEAeVodCvVBuxyNXyQ23EJYJD5ee4MDSXUSSDn35C42ZLiHlSzs9RjAJJ4qjqZE9mUiS/uQ==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by AS8PR03MB7285.eurprd03.prod.outlook.com (2603:10a6:20b:2ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 01:41:21 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822%6]) with mapi id 15.20.7046.027; Sat, 2 Dec 2023
 01:41:21 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Stefano Stabellini
 <sstabellini@kernel.org>, Julien Grall <julien@xen.org>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>
Subject: [PATCH v4 0/6] xen-arm: add support for virtio-pci
Thread-Topic: [PATCH v4 0/6] xen-arm: add support for virtio-pci
Thread-Index: AQHaJMCm4g6j3oktWEq85Lt1Yl1BFg==
Date: Sat, 2 Dec 2023 01:41:20 +0000
Message-ID: <20231202014108.2017803-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.42.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3710:EE_|AS8PR03MB7285:EE_
x-ms-office365-filtering-correlation-id: 6bc364b5-8b90-40b4-2da3-08dbf2d7c92b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vfs66eBm4jlm2dU/jKfNk7VVQiLLqiIaeAWt7yMiCCPD9YmIA2RHhlw4qcEL0/J/BxxfGPZL8ml5QSlP/r5m5QP9W1Zrx1PNElbxuwd/s4aZ8vYvS0tSLkT8IHEdWtf7DRxXMfQn/gPCogvI6jIXVNLlSVMbbebSqzg4XbASO5BsJaRKzo4sg/onKxfsKeYtN4MIXIi9kkgclr6Rh0Nv8FQTz8FWcNwu5hGKiAIOTg0N0QOaN/yTni5MLATN8+mfqRtKRhglFUxiT7S2crY6n/5/dM5Hdx1aGzmp3h8QUr58uhbO7W6/CCVb1FP35P+0a2XV4wDkAPEJLGmAizQcCub4VNa6VNfgza0ag5Auv6/Rwqw4fTk9wtxH5V1jAXLlQZr5LKPLN771BFJqwql3eEAZCbJs9Y612DQsRhusiWD5l43rVW2GmgRLd3TWrVA4qcfdqGY2/6iGGlMgRAzOvyLgZfwuoE7n1KZxW+QGGFl10W1noDyu93d2IsTYsc2aJvgpoo2nycfppRhyh7hpe+4YA7BmKOMsIRkkRWLOF6aOLppZiEyhdbNm5uiy6MO9mHIZj4rS5nA1iu8si0r/exgbK8INmHU8V3A51BIwv3lsOMLh2c5nIbrkVN3RClDk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB3710.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(122000001)(38070700009)(41300700001)(2906002)(5660300002)(83380400001)(71200400001)(55236004)(38100700002)(107886003)(6506007)(6512007)(1076003)(2616005)(26005)(66556008)(478600001)(91956017)(6486002)(36756003)(76116006)(66946007)(64756008)(66446008)(8936002)(6916009)(54906003)(86362001)(66476007)(4326008)(316002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFYyK3d0ZmdrWUo5cmdNS09oUXExM1hvV3RSWWZOQTRrN1BFR1htbjlxS09m?=
 =?utf-8?B?c09xdVFBcjRSTjFUK25IUE5YbStLZk5Ga0NDVHpkY1hMUXNXSXovbWdJYmtv?=
 =?utf-8?B?cFk3ak13dHFTMHVLWXRyQXV2U01XdXpXQUJERFNaRkVGNGpHNkN3T3RmVjhz?=
 =?utf-8?B?bDNQMDA0bU5UMlp6MEI0T1gra2h3RUxZNXlTRHVaK2xvSWszUU1la3lkK3Rv?=
 =?utf-8?B?cktwRk55NW1IYTBZY01zQnlNV29HL1gxZ1QxMmRoNE82c3NxWkIzN010aXRu?=
 =?utf-8?B?eURYKy96L2l3MGpIK1BPb1RSbC9hTmRMczJnL0htTU1EL3N5WFZMT3RJRk5q?=
 =?utf-8?B?SlhKUFpsL3RvK2ZsVmo4emUzYTRXYmhrc01pckc3QTV3a1pOcEdyaU8vL2tG?=
 =?utf-8?B?SW1OOHRpaGFQNzl3MTZoemx0ZFVXa1c2aTdSY2JvWldrTW5rZmdzN3QwZThX?=
 =?utf-8?B?c1d0QVNIa3lXRDFKRFBlN01jNWhIRk9pWHNEY2I5NGtBMHBCZXpwRGhyVDhx?=
 =?utf-8?B?a0kwanlIMTNuVU9hNjJkZmtBNHpOcTVqdVcwcGhtZlhDejgvNkQ3KzBneUlQ?=
 =?utf-8?B?SDVxQ1RQVHRRcmVMaWtBZXBZTVR1OGRPMS9PTmYwOEVtMVdNNmd1bThLUmhJ?=
 =?utf-8?B?V01WWWRCb0xRd3JhWUN3cGtQcHMzWGRHRzlidDl5ZEZET25UN2VvUDJzV1pO?=
 =?utf-8?B?dXY5QkF4MnNnRXdLVkpEUmE2dFFDVUx4bER0dVlickdEV3Z6OWs4Q2p0YTBX?=
 =?utf-8?B?ZTFYWmhhTk1qSkFYM255eEdmWGFDZ09pRFg0Mnlmd3laQWR3NEJOdEs5amZG?=
 =?utf-8?B?bW5kZDY1c1RlUFMzbXh5MmJGL0dudVZ4a2JlSDljQWczdTl6bGlUZHZDMTM3?=
 =?utf-8?B?VWJkV3V0dGk5ZGltKytRcFNnMVhTaEZxbSt0b1psTmFtVnVXOU1wNy83a3RC?=
 =?utf-8?B?L2ROb3htOFdaQkpuQnQ0VCt1aTlub2F5NUpTTFBxZUJ2OUpoUkd5VDcvL0gr?=
 =?utf-8?B?WmFYejhVUkx4ZUVETndrRFlkL2tXdnJYNGNtZ29kVDNDQUlFUWpLRUVYVjVL?=
 =?utf-8?B?U29WOEJuSEJ0R0kwaStoU0JyalhDbW12YWVnQWFxakw2cDNodno2bmg3TVlu?=
 =?utf-8?B?Nm9TWjFPQUFSdCtkTitYOUFVdTVOSWRoVTRHU3U1Z2ZyQ0wxeGE4RkdaYTlS?=
 =?utf-8?B?d283MXpPTXNyQjR1OUorSkp4YmtKV1pDanRGQ0ZDRFRpQXZpNG9hT2RSYkJl?=
 =?utf-8?B?QkcwRGZkMWt5aGZoOGNxcGdxV1cvTCt1MWlMcHBKeWtET25OcTZEWlI2T3kv?=
 =?utf-8?B?aldLUFdkVW5UTEdzV3FGQSs5VXNCOGdTTmpmWXVqZnR1cERXZW9jWkxFKzNL?=
 =?utf-8?B?TzNpcEVGTERhdHZGQ3RHZzlIemp4ZjdpL2Z3TUVKV2lrK1cxeHc4Um5QM0Iv?=
 =?utf-8?B?K20wME1NZEpSejAxZWllNng1Qy94SEt2dGwxb2NWTnJVajRoWUNaU2llM0xN?=
 =?utf-8?B?blZpcy9XRWNENDRYRndkb3BLcS90RGxHSmdnVWcrUjZzVVAzL2FjSXVYczdl?=
 =?utf-8?B?bTdwMTViNlRWaE11SVhKTjhZYXR5bFl6T1pmUVJldnM4RCtYUnMwTDlVSGFM?=
 =?utf-8?B?YnZ5c0dUS2hoczQ4Y2lZZWprUFJ6ZklYVHBnWGR0NlRkeVBGOXRQb0RRRUZ4?=
 =?utf-8?B?RGZiTnJ2ZlgvS2YxUTRYQlB1bUJuYTIrM3lzaG5UNS90YWZVR3pyYldxWlRL?=
 =?utf-8?B?Vm5hUFluNExtbWNtTElPZHZONFRsRUM2ZXBZYXZHSVFmVnVsTHJZOVZMSDBP?=
 =?utf-8?B?RVJncXFMc3pIblJDeEFEdDVNYytlcWV2RS9NQTBDb1BQSEZVbVlJdmxwT2h3?=
 =?utf-8?B?U3lBL0FvMVlybFlORlZxNjZJejFTcFpZV2ZXVGlPc1pjQzJVRG5lRGdmMUNw?=
 =?utf-8?B?ZWVMNk1jYjFFeENUdmQ1WkhWbWMzVjhxZllFSWZ1Y2pMVzhGbWhjdGEzNlF2?=
 =?utf-8?B?dnR6VDNFaUs3TzRVVzhsRUNkMWdJMFNUWUxBQWNFRDBvM3FDWFRaUVdaeXJK?=
 =?utf-8?B?Q0M0S3A4MU8xK2U5d0RSaWhNdEt0aWNaS0g3NkR1RVFWMjVWUVVtZjFFM3hr?=
 =?utf-8?B?Q1ZyS0RMeHNxTlM0U2dNZm93Ym81bWVyRGx6MUZEZEgydGdZTHRPRnRrWVRG?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F28FC2508F63345917AF8D3F8FA78A9@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc364b5-8b90-40b4-2da3-08dbf2d7c92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2023 01:41:20.9964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/IJ9BFR7AdbE2T+CDvSNDJtT81GmHOyMfUrz3BY1OzVcUfBgl4/0TO+iicsK8Pz0clkF9lbDMs70BNWqNKv2Eb6eLjOYFUTQl6uRxUbefU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7285
X-Proofpoint-ORIG-GUID: _kHarvLgHOVRkNALeOEe8zMEEXX-TTvJ
X-Proofpoint-GUID: _kHarvLgHOVRkNALeOEe8zMEEXX-TTvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_24,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=996
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312020009
Received-SPF: pass client-ip=148.163.137.242;
 envelope-from=prvs=6700ee1bd8=volodymyr_babchuk@epam.com;
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
Cg0KTmV3IGluIHZlcnNpb24gNDoNCiAtIFBhdGNoICJ4ZW46IGRlY291cGxlIGdlbmVyaWMgeGVu
IGNvZGUgZnJvbSBsZWdhY3kgYmFja2VuZHMgY29kZWJhc2UiDQogICBpcyBmYWN0b3JlZCBvdXQg
ZnJvbSAieGVuOiBhZGQgb3B0aW9uIHRvIGRpc2FibGUgbGVnYWN5IGJhY2tlbmRzIg0KIC0gVXBk
YXRlZCBwYXRjaCAieGVuOiBiYWNrZW5kczogZG9uJ3Qgb3ZlcndyaXRlIFhlblN0b3JlIG5vZGVz
IGNyZWF0ZWQNCiAgIGJ5IHRvb2xzdGFjayIgKHNlZSB0aGUgcGF0Y2ggZGVzY3JpcHRpb24pDQoN
Ck5ldyBpbiB2ZXJzaW9uIDM6DQoNCiAtIFVzZSBjb21tYW5kbGluZS9wcm9wZXJ0aWVzIGluc3Rl
YWQgb2YgeGVuc3RvcmUgZW50cmllcyB0byBjb25maWd1cmUNCiAgIFBDSWUgYnJpZGdlDQogLSBJ
bnN0ZWFkIG9mIHRyeWluZyB0byBmaXggbGVnYWN5IGJhY2tlbmRzLCBqdXN0IGFkZCBvcHRpb24g
dG8gZGlzYWJsZQ0KICAgdGhlbQ0KDQoNCkRhdmlkIFdvb2Rob3VzZSAoMSk6DQogIGh3L3hlbjog
U2V0IFhlbkJhY2tlbmRJbnN0YW5jZSBpbiB0aGUgWGVuRGV2aWNlIGJlZm9yZSByZWFsaXppbmcg
aXQNCg0KT2xla3NhbmRyIFR5c2hjaGVua28gKDIpOg0KICB4ZW5fYXJtOiBzZXQgbWMtPm1heF9j
cHVzIHRvIEdVRVNUX01BWF9WQ1BVUw0KICB4ZW5fYXJtOiBBZGQgdmlydHVhbCBQQ0llIGhvc3Qg
YnJpZGdlIHN1cHBvcnQNCg0KVm9sb2R5bXlyIEJhYmNodWsgKDMpOg0KICB4ZW46IGJhY2tlbmRz
OiBkb24ndCBvdmVyd3JpdGUgWGVuU3RvcmUgbm9kZXMgY3JlYXRlZCBieSB0b29sc3RhY2sNCiAg
eGVuOiBkZWNvdXBsZSBnZW5lcmljIHhlbiBjb2RlIGZyb20gbGVnYWN5IGJhY2tlbmRzIGNvZGVi
YXNlDQogIHhlbjogYWRkIG9wdGlvbiB0byBkaXNhYmxlIGxlZ2FjeSBiYWNrZW5kcw0KDQogYWNj
ZWwveGVuL3hlbi1hbGwuYyAgICAgICAgICAgfCAgMTYgKystDQogaHcvOXBmcy9tZXNvbi5idWls
ZCAgICAgICAgICAgfCAgIDQgKy0NCiBody9hcm0veGVuX2FybS5jICAgICAgICAgICAgICB8IDIy
OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQogaHcvYmxvY2sveGVuLWJsb2Nr
LmMgICAgICAgICAgfCAgMTkgKy0tDQogaHcvY2hhci94ZW5fY29uc29sZS5jICAgICAgICAgfCAg
IDIgKy0NCiBody9kaXNwbGF5L21lc29uLmJ1aWxkICAgICAgICB8ICAgNCArLQ0KIGh3L2kzODYv
cGMuYyAgICAgICAgICAgICAgICAgIHwgICAyICsNCiBody9uZXQveGVuX25pYy5jICAgICAgICAg
ICAgICB8ICAyMCArLS0NCiBody91c2IvbWVzb24uYnVpbGQgICAgICAgICAgICB8ICAgNSArLQ0K
IGh3L3hlbi9tZXNvbi5idWlsZCAgICAgICAgICAgIHwgIDExICstDQogaHcveGVuL3hlbi1iYWNr
ZW5kLmMgICAgICAgICAgfCAgMTUgKy0tDQogaHcveGVuL3hlbi1idXMuYyAgICAgICAgICAgICAg
fCAgMTggKystDQogaHcveGVuL3hlbi1odm0tY29tbW9uLmMgICAgICAgfCAgMTEgKy0NCiBody94
ZW5wdi94ZW5fbWFjaGluZV9wdi5jICAgICB8ICAgMiArDQogaW5jbHVkZS9ody94ZW4veGVuLWJh
Y2tlbmQuaCAgfCAgIDIgLQ0KIGluY2x1ZGUvaHcveGVuL3hlbi1idXMuaCAgICAgIHwgICAyICsN
CiBpbmNsdWRlL2h3L3hlbi94ZW5fbmF0aXZlLmggICB8ICAgOCArLQ0KIG1lc29uLmJ1aWxkICAg
ICAgICAgICAgICAgICAgIHwgICA1ICsNCiBtZXNvbl9vcHRpb25zLnR4dCAgICAgICAgICAgICB8
ICAgMiArDQogc2NyaXB0cy9tZXNvbi1idWlsZG9wdGlvbnMuc2ggfCAgIDQgKw0KIDIwIGZpbGVz
IGNoYW5nZWQsIDMyNiBpbnNlcnRpb25zKCspLCA1NCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjQy
LjANCg==

