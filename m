Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F499758DEE
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 08:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM0mM-00089K-Sf; Wed, 19 Jul 2023 02:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qM0mK-00088v-Fh
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 02:35:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qM0mI-0008ET-8S
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 02:35:16 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36J5wtNT007757; Tue, 18 Jul 2023 23:35:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=BJqct+rEp0y2UM+zT8R95oKcAqdzUmKvTihYe3ha0
 Q4=; b=1p/gdoa+IbE0hk4CfjupL4XcCDsV9qBAV6lLIpZ5EXf6DmIrnx4I300kT
 RqRwm0tSWxwU1xSW2ss+OZ2USMXyDjungsN+fnJBLobCZ9tydkG7Vb/9M3YwM9WZ
 r46sgPpvNEG6cjqPmtgQXEGORtJOfoVMw25GcVwAf6miU8RPk9ZWhAhbjtvyivTa
 vIk0xdG0L5i43+KNuYSQa4hDSslvbHu3dfWj3z4qpqguxng2WVPNaLcmmDVC71Lh
 51EnV8P5/yConJ2OxvukZIc7UMRLR3GkzByAmk5tcWe4HOkWbUnbh7MqQ621Xabf
 6j5+DwORfXBuTMQN2DL0vdO7w03/A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx2wn0u8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 23:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3c2w9NsfujmrNCSXNu5qWFWC/QqMSREWVnFXvWIezkeJXYNtDYk2wH8bLo18kIZoLXeqZdIGVQIa1DbT6dj6FvgHIGmfybxzCx8UQg2woL0j1DRnWs7lXZl/pnznDLwh4pvoa2AduGyLaADmc39qcZav1mdbhQn0fOfg5OSLFArzwOWPrFCJo4zbIrgqnPPyfwV631R0LPxKhQe1DwiHj8vW0z5LnIk0gfbnRBe2yIehkxKdJ9Bi8LRwvYs6eu6P61UWr0T1VNFza5Pu8mq5bxVwyqWWUjUns+y8qeBIXoO6vlv9ptVxfOKgJbCtIVHE5nWv8nKRLflDzX3dj/Ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJqct+rEp0y2UM+zT8R95oKcAqdzUmKvTihYe3ha0Q4=;
 b=YlSuUZlMdDgmKSi1r/y/QXFMT4vlmtSnZpC5uvBouBAEOOvkkMhochkOnRKHpfA9omLeRiMhRGyFMquC1CQ6frG+dkeWMxuD0WILJmfkBGlMq7jGhth6ZGokB6wJR8MRRZIKhvL807KO+VZwLH1hDXzp+v40hkGRUqsmVQEzJPFYymoD/1mDG6DIVIOA9GSZtOOxcY2fpkwkPIgIGP7shD/cJpUCmHejFtmQ+kJgKiqGHIjmrBnZ4b8FRSnm/GwGOS6hcvbCVe61OKDjZ9fLi61i9IhBgnB5q+Db+7O+Sdh9iV1bT6tm17VKheGX2x4YfOjDqitCH2RL9TVjzIRsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJqct+rEp0y2UM+zT8R95oKcAqdzUmKvTihYe3ha0Q4=;
 b=H5x2RtjWvptzqR0fO+ujUqwkTFu8ce7FPEOm6f0j53bihFHiF29S/9Am9sdChMjCAM7jqzIKWz4H/spDGz5YJCm7EfTl8ix6FNPbdPocdqy60PbtK67osJrZNzWBzqYjCPI2p15gX/Dc3EpYtQ6Pq8+cFhM6OUy3uc75h4jg5iy7RMhlEN6AsaJv8deBD8GthXllNXvOvWt8Agx7LUIOefJ9tOE3rA12mCH/bNE86CPSpdZQmHjb223Hh6Q011BsM9C8msWBRYCV92mCgAhsdvRrn5HgBwKGn5CvlIQR6wjGWEmWh8pvAmIyGB5kZxezbS0Drfp3NhedhaPkAYWjMw==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by DS0PR02MB9572.namprd02.prod.outlook.com (2603:10b6:8:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.22; Wed, 19 Jul
 2023 06:35:08 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::82a3:a948:abf6:8676]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::82a3:a948:abf6:8676%2]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 06:35:08 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Shivam Kumar <shivam.kumar1@nutanix.com>,
 Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v3 2/2] migration: Update error description outside migration.c
Thread-Topic: [PATCH v3 2/2] migration: Update error description outside
 migration.c
Thread-Index: Adm6CylU5upkHJpCzkSEe+TkelQnLw==
Date: Wed, 19 Jul 2023 06:35:08 +0000
Message-ID: <20230719063455.128000-3-tejus.gk@nutanix.com>
References: <20230719063455.128000-1-tejus.gk@nutanix.com>
In-Reply-To: <20230719063455.128000-1-tejus.gk@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4806:EE_|DS0PR02MB9572:EE_
x-ms-office365-filtering-correlation-id: f87b120a-bd1b-4167-1337-08db88224bd1
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vM9OtfXZKJvAk121NcaG51j7xlLBG4kBdt7bcu0f/Bo95n594ZJWrKjPafCy/wzmUy/Qgisyrj6ca1WmD83S+rnOUeaoPvyOEq/YXUtlFsVC4fwkHSKcPBR59lQuwzuuGNr261Q9NGIggfGj5fAlFaqVfpKCW7vfa0H95WWlyC7cNq7hMS1aTPynasUXX4s7rGBWzZaNSs6vFnIyTI/VAAb315ejAe8kMr2Nbk1d9CXpCbJy+vl5f55ZBPH62PIBSCiEG3KTkrzbi6AP4q4X6MxinPW94r7VS5yrNWngNegyt8QfFQYSqakos85hTVOHOAerK6uduZI5DO+rM8eibBbtIlkJYXSK3DvCq64rLiBtzlS0w4NtdnAbJ8wrkHROVHABDMu07vBPTxIWBP49VlcYDm3W99P3WUYyekRGPTbio+mAwGPt7aehXk+cyvUsVqzl3sBQIBthbxBLF0SI8rjbKkqKA2XCNS1xiSGsSAbWKMsDuF1KK9NTMwCNZWvX4qZz1aeRnDboGHsO0SFkgNj81DQaNxiTNouECNlyBtiH9J1oWYviUvwjs2+B+yA7wiHxT3pdvsIEcpZfvyaGC/giK1TNzxk3az7LJxU4sVUUw4WxaIC2uWa4ilWeoQUM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199021)(107886003)(6506007)(71200400001)(83380400001)(1076003)(38100700002)(186003)(26005)(38350700002)(478600001)(6486002)(54906003)(66476007)(6512007)(41300700001)(8676002)(66446008)(2906002)(8936002)(66556008)(15650500001)(6916009)(66946007)(316002)(4326008)(5660300002)(36756003)(52116002)(2616005)(64756008)(122000001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXJDQ3h0RGkwSmhMRDZydXhSbGRWVzI3bUFyVmw1MitJejBCYURBbXprUU9X?=
 =?utf-8?B?UXRQQmRWR0gxbmFqOVNvV29Fa2gvb1BYSEpad0gvMFVTdkM4bks0T3pHQ295?=
 =?utf-8?B?Y095cUtDSFRET2pRWnJoSDBXTklCYjZweHZyeHNobjJFY1JSNFR3YjRGazNN?=
 =?utf-8?B?NXZEMkZIVWw1NHVodC9HSDFLOVRWQWJCeU10SGcrV21WQUNHbjBmRUIybHJO?=
 =?utf-8?B?L1I5QXUwVFZjTmFCdDV4ckVUMDIxYlQ4QmFQRnZaZUdsL2U1bXB1ck0wWUFO?=
 =?utf-8?B?QWJ6emhHSG13Qkw3NDVQOGRIeW9Icm5xVnNmb2dhci9oOWdUbTFLdGJsYkxW?=
 =?utf-8?B?L1hBTlE3SFVMVUNzSzJPRXJTZ3d0bE5uV0NXTi9XcnhCOExIanlUbGtEVGc3?=
 =?utf-8?B?MkR2elpxMktrUUs4RXlUK3ZjYnpKbUROTGxmcnhleHZOZWZSVzM3ZHA4OTR3?=
 =?utf-8?B?dm5qUFdnRTZxS0JrUVAxSDF1OFVwQWwxeHdkZGNzTEg3YmZYQWNEZm52Tm81?=
 =?utf-8?B?L0UzZjRkYVl5OUFHQ2xjcWdwTWVlT3ZNYnpKYUxualhpOEpHclJvbWlUZVgz?=
 =?utf-8?B?dWxzVU44cGJ5TEVwTm1CYyt3bW9zV2JTNXhZUlBHRVpBOGRkVTZzblJ3VkMr?=
 =?utf-8?B?UmxwUHIxaEJBb0pqNldFK3hHU0NsT2VGTU01UVRRaVdZNFF6RGx5UFRramVM?=
 =?utf-8?B?clczdWJHQW5hTTRlTEliMHBCNHdBL2RPWFM5dk5zNkpJMkFhZ0swWGxwWXVR?=
 =?utf-8?B?bGgvVFVMNy91UnhZR09IOUdRWm5MVWJyQ0x4OTVNa1pGTUJvQjF4U3MzbnRI?=
 =?utf-8?B?SU5PRlpoazBhN3ZkSUxOVGg1RG9oQ2dYbGRRblN0OWhWd0IxTzFKUm9PaTlk?=
 =?utf-8?B?RlRLMjVzTGtEbVVkdlBWYmZvOHdlcDVONWgrQ2FuWDNSRklFa0l1MWtIc0lt?=
 =?utf-8?B?MGpsUWR2c0xqYXdWakFTNVdEZjEvNUh6QXVNUmZQdlQ0UWtGNnprMzZvSnBR?=
 =?utf-8?B?Tlg5NVBMNTI2UUp2azBqZ0hoUGtWSi9MVDdjL25vdnpJZnlZWmNKd0dES2Zi?=
 =?utf-8?B?WHN2WEpaeEdZdWpCRGZZTzVvck9sU2R3M3NHaytYQkJaOWJoc2J0dEtGZC9E?=
 =?utf-8?B?cTg0aTd0WTlWTXY1TXFiRjdJR1p6OFhXdmdZRHFHR1BDanB0dTEwTDhkUVMy?=
 =?utf-8?B?MHkyQTQwaTYyb2tWV09kdXVXZ3pra1lYN1Y0Tml1c0dLK2dOYnJYUW5jWGlr?=
 =?utf-8?B?UlR0bStoS3QwNzQ3QVNvSlFxbHlBcXRObloxL051TlJSOXVQWC81WnpFdFhj?=
 =?utf-8?B?c2FPa0VtdENZUno2dlc0NlU2cWcrZks4aEhMNkVNcmJNZjR4dWZhL01aRFl1?=
 =?utf-8?B?YmN5Z2lKSk16N1Rjb2R3UmMwa1NUWmtVTFlCd1hrcE9BWUJ0NUtNMmQ3aUc4?=
 =?utf-8?B?MmxsR0xSWi9ZNEdSYmtnQzFEMUFuc0pkdWZ2amRUNTNmN0RNeHNTV2dTM3R3?=
 =?utf-8?B?dkY0YVkyTHFxNU14ZE52QUpVN291UHdJSlNaenorY0ZxckNER0pYSSs3MEhJ?=
 =?utf-8?B?ejJKN1ZSU08zUnkwLzV6VVhtYVVabjNPa3ZMNFFJeDlxdXowLzBmYk5Zc1l3?=
 =?utf-8?B?K21sMTk0UG5nMkJZSGVBMzR4RzhqU1hIVHdRL1NDcTdYNlhkQzNSNGgzVlpM?=
 =?utf-8?B?SVJ6MDNNR3lvUU4vWlZBMm83L3pQSHZZSDJjWnVxRUh5RDczME9nNzNHb0h0?=
 =?utf-8?B?ei8vN04vZlRCSUtPUXlzM3UxMTVDcGhCUFIzNWJxQ3piQXM4aVV3SW9pVnJD?=
 =?utf-8?B?ajZNZTNLODR5Tko5OFZldWdoN0FsQktBb3B5VWpPM3hKbGtqNHlZR20vcWZT?=
 =?utf-8?B?Y2JENE1nazdqM0ZhbURxejhsbHpTUWRORzBkaDBHanlXZWg4Z1p2QUxtd1cv?=
 =?utf-8?B?ZHcvaEpibHg1ejJuZm44OEJVd0paNDZ2d3cvWGNNajE2UXlzWmJsNHhObmZz?=
 =?utf-8?B?WDNxWFdrOXVNQ0xxTGV1RnZPRFpMSGF6MVZEZGtlS2t0cTZTaWdKUjE5ODc0?=
 =?utf-8?B?ZmtXb1cyUStleW5sQ2VzcW5SemJDeW5VWi9ncktVU1ZBcCtrSmFBSGM3MTRy?=
 =?utf-8?Q?0cMiBKykARyWir1HT0vV+bZMv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87b120a-bd1b-4167-1337-08db88224bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 06:35:08.5028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaPKo3+BsuBV1JDIfHnrFCqoo5AxSfpWVVOvWOmqeqJlpVGc62pmuNe57Z5frVo73M7etHTcHUciTHuLZpRIlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9572
X-Proofpoint-GUID: c2J-u9K3xqv5xOxzUDxopzekwc6NBMav
X-Proofpoint-ORIG-GUID: c2J-u9K3xqv5xOxzUDxopzekwc6NBMav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_03,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

QSBmZXcgY29kZSBwYXRocyBleGlzdCBpbiB0aGUgc291cmNlIGNvZGUsd2hlcmUgYSBtaWdyYXRp
b24gaXMNCm1hcmtlZCBhcyBmYWlsZWQgdmlhIE1JR1JBVElPTl9TVEFUVVNfRkFJTEVELCBidXQg
dGhlIGZhaWx1cmUgaGFwcGVucw0Kb3V0c2lkZQlvZiBtaWdyYXRpb24uYw0KDQpJbiBzdWNoCWNh
c2VzLCBhbiBlcnJvcl9yZXBvcnQoKSBjYWxsIGlzIG1hZGUsIGhvd2V2ZXIgdGhlIGN1cnJlbnQN
Ck1pZ3JhdGlvblN0YXRlIGlzIG5ldmVyCXVwZGF0ZWQJd2l0aCB0aGUgZXJyb3IgZGVzY3JpcHRp
b24sIGFuZAloZW5jZQ0KY2xpZW50cwlsaWtlIGxpYnZpcnQgbmV2ZXIga25vdwl0aGUgYWN0dWFs
IHJlYXNvbiBmb3IgdGhlIGZhaWx1cmUuDQoNClRoaXMgcGF0Y2ggY292ZXJzIHN1Y2ggY2FzZXMg
b3V0c2lkZSBvZgltaWdyYXRpb24uYyBhbmQJdXBkYXRlcwl0aGUNCmVycm9yIGRlc2NyaXB0aW9u
IGF0IHRoZSBhcHByb3ByaWF0ZSBwbGFjZXMuDQoNCkFja2VkLWJ5OiBQZXRlciBYdSA8cGV0ZXJ4
QHJlZGhhdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBUZWp1cyBHSyA8dGVqdXMuZ2tAbnV0YW5peC5j
b20+DQotLS0NCiBtaWdyYXRpb24vc2F2ZXZtLmMgIHwgMTcgKysrKysrKysrKysrKystLS0NCiBt
aWdyYXRpb24vdm1zdGF0ZS5jIHwgIDcgKysrKy0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9zYXZl
dm0uYyBiL21pZ3JhdGlvbi9zYXZldm0uYw0KaW5kZXggZWExY2MxYTI2Yi4uNjdhN2VhN2JhMSAx
MDA2NDQNCi0tLSBhL21pZ3JhdGlvbi9zYXZldm0uYw0KKysrIGIvbWlncmF0aW9uL3NhdmV2bS5j
DQpAQCAtOTc5LDYgKzk3OSw4IEBAIHN0YXRpYyB2b2lkIHNhdmVfc2VjdGlvbl9mb290ZXIoUUVN
VUZpbGUgKmYsIFNhdmVTdGF0ZUVudHJ5ICpzZSkNCiBzdGF0aWMgaW50IHZtc3RhdGVfc2F2ZShR
RU1VRmlsZSAqZiwgU2F2ZVN0YXRlRW50cnkgKnNlLCBKU09OV3JpdGVyICp2bWRlc2MpDQogew0K
ICAgICBpbnQgcmV0Ow0KKyAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCisgICAgTWlncmF0
aW9uU3RhdGUgKnMgPSBtaWdyYXRlX2dldF9jdXJyZW50KCk7DQogDQogICAgIGlmICgoIXNlLT5v
cHMgfHwgIXNlLT5vcHMtPnNhdmVfc3RhdGUpICYmICFzZS0+dm1zZCkgew0KICAgICAgICAgcmV0
dXJuIDA7DQpAQCAtMTAwMiw2ICsxMDA0LDggQEAgc3RhdGljIGludCB2bXN0YXRlX3NhdmUoUUVN
VUZpbGUgKmYsIFNhdmVTdGF0ZUVudHJ5ICpzZSwgSlNPTldyaXRlciAqdm1kZXNjKQ0KICAgICB9
IGVsc2Ugew0KICAgICAgICAgcmV0ID0gdm1zdGF0ZV9zYXZlX3N0YXRlX3dpdGhfZXJyKGYsIHNl
LT52bXNkLCBzZS0+b3BhcXVlLCB2bWRlc2MsICZsb2NhbF9lcnIpOw0KICAgICAgICAgaWYgKHJl
dCkgew0KKyAgICAgICAgICAgIG1pZ3JhdGVfc2V0X2Vycm9yKHMsIGxvY2FsX2Vycik7DQorICAg
ICAgICAgICAgZXJyb3JfcmVwb3J0X2Vycihsb2NhbF9lcnIpOw0KICAgICAgICAgICAgIHJldHVy
biByZXQ7DQogICAgICAgICB9DQogICAgIH0NCkBAIC0xMDY4LDEwICsxMDcyLDE0IEBAIHZvaWQg
cWVtdV9zYXZldm1fc2VuZF9vcGVuX3JldHVybl9wYXRoKFFFTVVGaWxlICpmKQ0KIGludCBxZW11
X3NhdmV2bV9zZW5kX3BhY2thZ2VkKFFFTVVGaWxlICpmLCBjb25zdCB1aW50OF90ICpidWYsIHNp
emVfdCBsZW4pDQogew0KICAgICB1aW50MzJfdCB0bXA7DQorICAgIE1pZ3JhdGlvblN0YXRlICpt
cyA9IG1pZ3JhdGVfZ2V0X2N1cnJlbnQoKTsNCisgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7
DQogDQogICAgIGlmIChsZW4gPiBNQVhfVk1fQ01EX1BBQ0tBR0VEX1NJWkUpIHsNCi0gICAgICAg
IGVycm9yX3JlcG9ydCgiJXM6IFVucmVhc29uYWJseSBsYXJnZSBwYWNrYWdlZCBzdGF0ZTogJXp1
IiwNCisgICAgICAgIGVycm9yX3NldGcoJmxvY2FsX2VyciwgIiVzOiBVbnJlYXNvbmFibHkgbGFy
Z2UgcGFja2FnZWQgc3RhdGU6ICV6dSIsDQogICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18s
IGxlbik7DQorICAgICAgICBtaWdyYXRlX3NldF9lcnJvcihtcywgbG9jYWxfZXJyKTsNCisgICAg
ICAgIGVycm9yX3JlcG9ydF9lcnIobG9jYWxfZXJyKTsNCiAgICAgICAgIHJldHVybiAtMTsNCiAg
ICAgfQ0KIA0KQEAgLTE0NzUsOCArMTQ4MywxMSBAQCBpbnQgcWVtdV9zYXZldm1fc3RhdGVfY29t
cGxldGVfcHJlY29weV9ub25faXRlcmFibGUoUUVNVUZpbGUgKmYsDQogICAgICAgICAgKiBiZHJ2
X2FjdGl2YXRlX2FsbCgpIG9uIHRoZSBvdGhlciBlbmQgd29uJ3QgZmFpbC4gKi8NCiAgICAgICAg
IHJldCA9IGJkcnZfaW5hY3RpdmF0ZV9hbGwoKTsNCiAgICAgICAgIGlmIChyZXQpIHsNCi0gICAg
ICAgICAgICBlcnJvcl9yZXBvcnQoIiVzOiBiZHJ2X2luYWN0aXZhdGVfYWxsKCkgZmFpbGVkICgl
ZCkiLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgcmV0KTsNCisgICAgICAg
ICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCisgICAgICAgICAgICBlcnJvcl9zZXRnKCZs
b2NhbF9lcnIsICIlczogYmRydl9pbmFjdGl2YXRlX2FsbCgpIGZhaWxlZCAoJWQpIiwNCisgICAg
ICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCByZXQpOw0KKyAgICAgICAgICAgIG1pZ3JhdGVf
c2V0X2Vycm9yKG1zLCBsb2NhbF9lcnIpOw0KKyAgICAgICAgICAgIGVycm9yX3JlcG9ydF9lcnIo
bG9jYWxfZXJyKTsNCiAgICAgICAgICAgICBxZW11X2ZpbGVfc2V0X2Vycm9yKGYsIHJldCk7DQog
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCiAgICAgICAgIH0NCmRpZmYgLS1naXQgYS9taWdyYXRp
b24vdm1zdGF0ZS5jIGIvbWlncmF0aW9uL3Ztc3RhdGUuYw0KaW5kZXggMzVhOWI2N2FmYy4uNzFk
YzIxYzI3MyAxMDA2NDQNCi0tLSBhL21pZ3JhdGlvbi92bXN0YXRlLmMNCisrKyBiL21pZ3JhdGlv
bi92bXN0YXRlLmMNCkBAIC0xNCw2ICsxNCw3IEBADQogI2luY2x1ZGUgIm1pZ3JhdGlvbi5oIg0K
ICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KICNpbmNsdWRlICJzYXZldm0uaCINCisj
aW5jbHVkZSAicWFwaS9lcnJvci5oIg0KICNpbmNsdWRlICJxYXBpL3FtcC9qc29uLXdyaXRlci5o
Ig0KICNpbmNsdWRlICJxZW11LWZpbGUuaCINCiAjaW5jbHVkZSAicWVtdS9iaXRvcHMuaCINCkBA
IC0zMzYsNyArMzM3LDcgQEAgaW50IHZtc3RhdGVfc2F2ZV9zdGF0ZV92KFFFTVVGaWxlICpmLCBj
b25zdCBWTVN0YXRlRGVzY3JpcHRpb24gKnZtc2QsDQogICAgICAgICByZXQgPSB2bXNkLT5wcmVf
c2F2ZShvcGFxdWUpOw0KICAgICAgICAgdHJhY2Vfdm1zdGF0ZV9zYXZlX3N0YXRlX3ByZV9zYXZl
X3Jlcyh2bXNkLT5uYW1lLCByZXQpOw0KICAgICAgICAgaWYgKHJldCkgew0KLSAgICAgICAgICAg
IGVycm9yX3JlcG9ydCgicHJlLXNhdmUgZmFpbGVkOiAlcyIsIHZtc2QtPm5hbWUpOw0KKyAgICAg
ICAgICAgIGVycm9yX3NldGcoZXJycCwgInByZS1zYXZlIGZhaWxlZDogJXMiLCB2bXNkLT5uYW1l
KTsNCiAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KICAgICAgICAgfQ0KICAgICB9DQpAQCAtMzg5
LDggKzM5MCw4IEBAIGludCB2bXN0YXRlX3NhdmVfc3RhdGVfdihRRU1VRmlsZSAqZiwgY29uc3Qg
Vk1TdGF0ZURlc2NyaXB0aW9uICp2bXNkLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2bWRlc2NfbG9vcCk7DQogICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAg
ICAgaWYgKHJldCkgew0KLSAgICAgICAgICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJTYXZlIG9m
IGZpZWxkICVzLyVzIGZhaWxlZCIsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dm1zZC0+bmFtZSwgZmllbGQtPm5hbWUpOw0KKyAgICAgICAgICAgICAgICAgICAgZXJyb3Jfc2V0
ZyhlcnJwLCAiU2F2ZSBvZiBmaWVsZCAlcy8lcyBmYWlsZWQiLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdm1zZC0+bmFtZSwgZmllbGQtPm5hbWUpOw0KICAgICAgICAgICAgICAg
ICAgICAgaWYgKHZtc2QtPnBvc3Rfc2F2ZSkgew0KICAgICAgICAgICAgICAgICAgICAgICAgIHZt
c2QtPnBvc3Rfc2F2ZShvcGFxdWUpOw0KICAgICAgICAgICAgICAgICAgICAgfQ0KLS0gDQoyLjIy
LjMNCg0K

