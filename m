Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D49758DED
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 08:36:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM0mK-00088Z-8P; Wed, 19 Jul 2023 02:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qM0mG-00088E-KZ
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 02:35:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qM0mE-0008DA-8j
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 02:35:12 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36J1DfmB017982; Tue, 18 Jul 2023 23:35:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=proofpoint20171006;
 bh=TP4EfPhSMHwM9eRNDGmysr0mUcKDQuXso44/cVGG6uI=; b=DoQxYnQFByaN
 gR9aVsbchMgWQd4CnE0mKzuAIFCn+TWz9QT8y0yFCGpAAyXT8ko+UKZfcYKii5MQ
 lnPrgTnS/beuHSe0r9wOQKDxbMYuz666BjnlceB/In9IgMpZQgj0376ihprrtAbU
 pdwSs9bQkSs6RZivFDGQRLTnWjIWxsIFj2lzz2gC+2dxITyfaTumgERDIqmaedxw
 WFnQqcYBn/1V5NL8TTFqmBPqC3CtvTSF0imC6ZyzIvva+QJKJ20VCf1KZoaslOE/
 wBzHBrDPGi0ZGvm4wC1dgQHRIXWZ+usExt+2WCN+UbtyH8t8WXlNZCkk7ftJ8FaT
 kMLOBH1svw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx2fdrvnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 23:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsKRmhozv4bKfarQS7dwOwLsw4SzunRN3Ak6X/QVv/teIi/XQyaSOmZAzTZh9+CEEar1NNhzbpfAWfwnMqy/YwIqYYjPfoigq2qlXD6McQG6LpkAmqTIviG9/0ue0zcHKTCP89GGIlhWpyhOHCFZPuwdBSxuuScQRBFhFwOczn5PSoAqxWj4cg6KPH0xZvnnjsnvf/LTYUJiK+Yu79y/mq+UKvSA0cPYqHR/7pu6vLrqrFmlpR9dsN7g5gIVfY52PlI+z7qsFvK6XH+GMjJS1Wu01zH3AdyUdP7kZPoz33O3Zs5wvIlmxMucipX0uMvwCgyFy1r1ltJUhUmz75Xegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP4EfPhSMHwM9eRNDGmysr0mUcKDQuXso44/cVGG6uI=;
 b=jMMa6Z9fnfD1j7zLo1j4pMfbBLJItDA9nKejBQjVWLF0R3CcOomtFwbq6w2+XrGl7coZ+MqtID3qNpR7s1f8JlLbNYUwj7WnKtv0dcdAYcNUU0yDXK6j/EEocnmJ7iFQOedBZ1m0Y/4DXApi0BAZ3Zv0h6cs+HjRM7T3MGdmh3PafUPGSvmx64CTeD3yXHCwR7/Jx8mMSzBWsZVUwvoIP87jR8rSh8Rpn/c2zVeeetq/HJGg7hIsDlxLl+LYITRY+LeAMw/HoxFH8B6vRbGH0lZWyJP0oxQlhTxdSub662loSmHz0xd2I86nn9zwQO0XDYLt59RN4OaWdfeDVAydvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP4EfPhSMHwM9eRNDGmysr0mUcKDQuXso44/cVGG6uI=;
 b=BT1UaEb/VLDrK/9O3nuLSpSpoSLMxXVLuj4XDyyjcF3rVqVlapEBdb/qJD0Dv+lxz2oYRPYVEMps2bY8D+IYPyciBNEF14ASIxGlM9GnhfuWBfftKCMpQNchbRt+FEahiXN5kQcaWmGA/O5JGYieW6Ff4HaGRi0UoQofvVeSjocHHDB5q5stIJ1sU7yGLFsar/+clFZ91K63db/k9T3t40NPM9hWTZlwU8acjnAWDAZrpOLiNYEraKkYxjlBIIq3eTTYXZV1WT13BqwFt/iqMTkLyT5o+yfHV/iJcd+Z9X/2Jwo5uXNF7VBjwtyyuSdAKxfjo7mRfR7jmwUfIHsyUw==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by DS0PR02MB9572.namprd02.prod.outlook.com (2603:10b6:8:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.22; Wed, 19 Jul
 2023 06:35:02 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::82a3:a948:abf6:8676]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::82a3:a948:abf6:8676%2]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 06:35:02 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Shivam Kumar <shivam.kumar1@nutanix.com>,
 Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v3 0/2] Update error description outside migration.c
Thread-Topic: [PATCH v3 0/2] Update error description outside migration.c
Thread-Index: Adm6CyWS6nNbte65xEGX7GvfShzCAA==
Date: Wed, 19 Jul 2023 06:35:02 +0000
Message-ID: <20230719063455.128000-1-tejus.gk@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4806:EE_|DS0PR02MB9572:EE_
x-ms-office365-filtering-correlation-id: 3508f664-8cb4-476e-14df-08db88224815
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P0tVBN+LGEFyLqx5hhG0O80hESGg9ZKfjGwv7zSANrc8ZG3xoKy56GZnd1+grP+CuDoRqLtXGA5ACp5ZfMkFLPCkV0bbmbih0gMDGQhfb+RAirj1xZlqCMnwkAaGIL5fS5QspXVyUKf49vBvfG6WpAlkiUfipatvB/dJDVOK/+jH1mtFbLKZ9hQ4YIs8tDajeFrfediUZ9ylqP4/SrYVVgs/k0J41mF+fiLpCXMV0Hi6yXHP3kmOYhcod1CXwXXF8TLPP8+8NNo8IEGl1K8sZrmAwt9zEKksGwtGFYsF7yO+E1/FcavtbtaUmaCCEn4s3YCCSLiuUkb1TSmkqhI1ZXvifS7yl8YG1jp2WoN7YBI5E1YGbqpkHSLloNalmgFXdgZdRmliEEEV9iflB94E06waZunECS/E0LufaaAktBXBwJUrLxLF4Sz8fwpSd/FucrkX5cl3LjGWu4HZPrheh/zhrEQNQ71192tJsQpZiavzXdiGKN/lEv6s56a0babiCaAJkJpbWG5lzwJRKkLPHFcY7k6Wc+h+HmVAEbckhNmFDJDDrCZbBJQRGUdHnLMUOLOXsaGBL1UlIk+cA7jJDYvIyJ49AEyVt/TsZZre/ZTmGTKYzWId+Qw0Uw2R/U3j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199021)(107886003)(6506007)(71200400001)(83380400001)(1076003)(38100700002)(186003)(26005)(38350700002)(478600001)(6486002)(54906003)(66476007)(6512007)(41300700001)(8676002)(66446008)(2906002)(4744005)(8936002)(66556008)(15650500001)(6916009)(66946007)(316002)(4326008)(5660300002)(36756003)(52116002)(2616005)(64756008)(122000001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1F6cFRIV2J5eEJlZ20yMUFXcHp2aEcyZ2YxRnlBaVY5eHFTUkdCaC9OY0Fm?=
 =?utf-8?B?OFdrYlI3eWpkZ3NldjduZTF6cTFWaS9BKzZuNStsVDZtMDJWbUxINS9kb1JE?=
 =?utf-8?B?UGJJUXU2WGsxUXg5WVg2ZlZmclVjRkdreUh2UzlOckxmcXVNWnNaVUsrbkVa?=
 =?utf-8?B?U1Bnc0hyMkRTZStRdU5Vb2dlckgrcTNab09ON1JPZWRBcnFtZTgvay9wYjZq?=
 =?utf-8?B?eCtybmlDOXRLamNWWkpIQ0syTG9ldzhheHh0d2Nhdll4UU84MFJvay9RNjA0?=
 =?utf-8?B?NFhUaE1QY0oxbDlzQzBTVURZL3ExZHBRR0hOd2hwUEcwMWhldnRybkU5ampX?=
 =?utf-8?B?alAxMGQ0YnRzeEhGSTFXaFJVaFJxSGlJclNTWUNvVW1NZGxRTkE1S2RKMHZF?=
 =?utf-8?B?K3lXZWs2b3AzSlhxU2pvKzZmdnFxMENsalZqNnkrTFlDWVVJK0FrUmd6Unlv?=
 =?utf-8?B?dTdWK3o1NThJWENiOXJrRjVvSHJ4OHFJSS9XWFlJcUlVQWg3S04rUFBVRjlI?=
 =?utf-8?B?QzBTTlJnTmFXMXRhWjlDSHVWek9jaW9IMXhHQy9vOGFGR1E3T3JDMkZHVjNV?=
 =?utf-8?B?RisvUDk4VGt1K25CUmtxb1RWRDZLSkJYcUVWalN4YkFkR1YyZXliZk05b1ZH?=
 =?utf-8?B?ZGZ1M21wbFNrL2hnekJLbm9xWUwzMEpGS05OanJtQUEvYW1OckQ1UWd0aWNP?=
 =?utf-8?B?K0czS0Z1TjJ3bjhXR2J6ZGlTTUNkK3hBb3RqdTNQOVBCY25KUytjU0U1L3FB?=
 =?utf-8?B?dVhuN1A3VUUwMnlKM2tCMG4xUGFJdGo5L3I2MGUxL3MvaVdOSlRJNjhiZFh4?=
 =?utf-8?B?RTBiNi9NRlpnSjNzSndPcFpFajJkcDVLZjFTZ2FGaTQ4em8rZDU1Mlo1dzc2?=
 =?utf-8?B?anV6c294TElsRlViaVh4UWMwUUJDc0ZnVjVleHVFU21VTlEwMGNMSjBQanRo?=
 =?utf-8?B?Q2xRV00vR1VHS1lsZUgxVGh3K1RqcXRRdzhsL3hBNXVUVXBaWFd6d0F5L0pr?=
 =?utf-8?B?WU5xdWdXaWhGZ2hLVktFZ3RKZDF1SnhldDkwSG1SYUNSRHN5Um9IT0MrOG9h?=
 =?utf-8?B?VDZRM0NqdkRSa2x5M1R5THdNd0k5MnFqTGdxRWt6ZWdVUTBEM3hOd1JCSFZq?=
 =?utf-8?B?Qy9ucXJyNElEMmM3Q1Jac0lkNU12WmI4WjRNbXZMYVAzRzlMU0pmZWJBYkZ5?=
 =?utf-8?B?b0xmQ01uVWZqN2NFTjhQWnRDWWNOWmh0cmdqQ0FweTFxTFlOYW5ENnZXVkdS?=
 =?utf-8?B?Q05BNE9ldytyR21zRG52NVVMZCtFNXhQdHB1UzE2Q3FmRVl5UUlPbnVBczNv?=
 =?utf-8?B?QmU0eFRaTVVQWmRBQWs3bXZkWjRnd0plYXM4dWFNeXlMRWhrQVVJZnB4N3ZH?=
 =?utf-8?B?MG5mL2ErbzVuakRyNWoxVXRrSXRZcmlHQVJudVY0VFovQllHQ2RjSkwzZEtP?=
 =?utf-8?B?Z1JHSUpCbUI5SjhOaStuR3lrbURYaC9Bbi9hUVBQS0IrYVRua3RXQjFBODNK?=
 =?utf-8?B?eW52OEk2ZE5HZlVwN292MjQ5aFZBcWtlMFlrYjVzcERweWhXTkJQUm8zQUh6?=
 =?utf-8?B?ckpEWXAzclRJWW5RRXJOWnBaUCswcDNjaDFXK1JEcWRmVEt6V1NqalVjek43?=
 =?utf-8?B?dFV5ME5TRGxjQkMvbEdxYmh4ZGVuemIxck1TOEk3dGttVW85cHZ2bmFxT2Zq?=
 =?utf-8?B?UGpXR2lrQWhseTlaY29FZHh0UHNZbjh6dTJOdXl2VHJRdEpWbWdseU1BZFZj?=
 =?utf-8?B?RkJpejg1TnQrcTV1L1BIN2NpVG1NU3hiREFmamRYa05oSXVBT3JMaUZiKzhU?=
 =?utf-8?B?bzFGMkY3cWp6bXVJbDBMbnBzM0tVb2NjOXpTa0QxNndLTmMvTXVDQWsyWmh5?=
 =?utf-8?B?dDRkWWcvVy9udnErRlBCbEcycTRTRnhMWE1NWjJubDl4ZjZKODFHQ044c1p6?=
 =?utf-8?B?OG13QU83Z1VqQ2lyWkRqN3pZeHI1UWl3eFdtd1ZMWkpVeHlIdFdSVDBXbitI?=
 =?utf-8?B?c0t0cElEVmJ6VFV5cFZIZVJsVmcyM0xIeXZuTklrc0RERWlMc1hDTTRwNUUr?=
 =?utf-8?B?YlVEUElQK0NWRnUrMXJ1dFcyS21lQkc4Rkd6VHhSa3FOSWZNck1OeTVvMGJI?=
 =?utf-8?B?d0d5VkhNMDA2aVJFMk1QREFXaUdmOU5LQllOUHJEWE91TDVJM1E0cmNSVVpm?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3508f664-8cb4-476e-14df-08db88224815
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 06:35:02.2275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFWeM42P6f/el3+9Os4XCJtpxVbnk969mTN2eMTwkQ3DI/Lc+/xUyJ+64vieXFMZkVV0eyth4RnDmgVJuJjZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9572
X-Proofpoint-ORIG-GUID: QBgZm1AVTpKphP05IERGilWVwhR9k6QP
X-Proofpoint-GUID: QBgZm1AVTpKphP05IERGilWVwhR9k6QP
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

SGkgZXZlcnlvbmUsDQoNCkknbSBzZW5kaW5nIG91dCB0aGUgcmViYXNlZCB2ZXJzaW9uIG9mIHRo
ZSB2MiBwYXRjaCwgcGxlYXNlIHJldmlldy4NCg0KVGhhbmtzLA0KVGVqdXMNCg0KDQpDaGFuZ2Vs
b2c6DQoNCnYzOg0KLSBSZWJhc2Ugb24gbWFzdGVyDQoNCnYyOg0KLSBSZWJhc2Ugb24gbWFzdGVy
DQoNClRlanVzIEdLICgyKToNCiAgbWlncmF0aW9uL3Ztc3RhdGU6IEludHJvZHVjZSB2bXN0YXRl
X3NhdmVfc3RhdGVfd2l0aF9lcnINCiAgbWlncmF0aW9uOiBVcGRhdGUgZXJyb3IgZGVzY3JpcHRp
b24gb3V0c2lkZSBtaWdyYXRpb24uYw0KDQogaW5jbHVkZS9taWdyYXRpb24vdm1zdGF0ZS5oIHwg
IDQgKysrLQ0KIG1pZ3JhdGlvbi9zYXZldm0uYyAgICAgICAgICB8IDE5ICsrKysrKysrKysrKysr
Ky0tLS0NCiBtaWdyYXRpb24vdm1zdGF0ZS5jICAgICAgICAgfCAxOSArKysrKysrKysrKysrLS0t
LS0tDQogMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkN
Cg0KLS0gDQoyLjIyLjMNCg0K

