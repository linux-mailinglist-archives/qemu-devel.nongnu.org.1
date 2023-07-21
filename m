Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1275CA90
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:50:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrRn-0002j5-I2; Fri, 21 Jul 2023 10:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRg-0002ew-JK
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRe-0004lW-Tx
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:28 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36LCwUEq028352; Fri, 21 Jul 2023 07:49:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=DZoVG4Hyk9lWJBTZiGUC+AfIlKGUOqYEFcO/lc
 HEz/M=; b=TdcBgdow6S32GzS2a6P34qju5l6C//JuH4i7d5AdUxIUNFUSpprEEn
 in6MO3EKQJEpZO+y6mKBQGWLuwPcPuu7Ji7huWn5s9mlRJy3pb7gCK1Z+/srxDsi
 FFDTH6TmkON/OMwKhjCiWeRuiZxJ5JZLTYPQWGT8w6kNaBKJ96NfyM/Hmv8VoFAm
 PFDvTZ5zK0rptUWqL0DTPX/ntU7FOrkoZoQKLRM2XIZUBXe2JdVAIuRu32KHc++6
 K25nTVbig2iG2tWQuKlntsWCO0TLXoucSHZfScXas/IwV78KjZxBf7DAHCA2flL7
 5wCJVGQmeXaZEIhLhXsWr1uFuxZzG8oA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx3fmxgf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 07:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEvLT5zhdmGfbykpiqepyGzWopLwhWbdojgjZsJrvzVy2q7aOzN+zxXbKaGku/LvGEx4Dt/bq2/HGBixXh8S0Ed8ZZ/un8si/BQTGuVeGDzEo/gdYaCOIqP4hmmoFdzHikKot/BxHv2Snr1aV5JJfv5DRPdCeuEg3nL9/W7VIMG95RlMIH7aPP69e9Zctnk7kJYzg8ZQ8ltYaMk8roZlKd7AhGXyL9tmM/5MMG7At2wx3TJ2VvesrmWE/1Ouh/dyWOSi1e8PKSzryU4ak9k1d0VD4EclcYV8OO1PevQAzBhfpvfLPBJefEzragJgiBc8yyHZAY97ckzB9lgSeMLvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZoVG4Hyk9lWJBTZiGUC+AfIlKGUOqYEFcO/lcHEz/M=;
 b=mTG9fswANoEwIbbtsHGMMJd3XvTqN1PMI8xZpdMPUOz9UGb+CX6y+DFxGtW6xU1EwLNEonRL4IxmUTxK2kuvSMBnEF12j2OEMZX6Dt6OOFVCj7VRpmtrZbl6UcMJT3shwd4XI6fOxakmdiODFYbCrY0VgEdTmn6+iBbp8505ALWbcZyOxxuqbRX6ZFO+DiZpgEpvh8l+46QfkrQBdBJcxpCg81Dp2P1na6+koohRpcgzPlRMv/L3x4ShGwZ2aJdvbL3suHqJmigetdj9MSE4c3ytPDLMBgFaPSgNtaP/3lrv3oLGMOI8uPfhfWnSX/5eKusvv3n00shlXroH7hNTlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZoVG4Hyk9lWJBTZiGUC+AfIlKGUOqYEFcO/lcHEz/M=;
 b=VTFDGyhjeuurZzy677C2UrCVveIKEmR0vgHmHW4Qy947dXHc6pO3K3RwCwNN1MoD4QoSXuS1toCGHoeln6w9iSo0mTa8x013OHsZlab1ayK/c9k88n7iruNKvLw9jcUVJcx8hQAqJ4nF1qq/5O15As8W4i/lkqY73QHKenQqryuqGx4lHn8z2QnpuE8iXHd0YqneOAaN/gZfpjxwEv4n9ZnkjQPmIP1dHsoS0Y6Jrm9S2JbcP73PGvDzMDTXYEg1PLlEqGHK8T1cT6UY8QhrJfIveGYVyutDJNPIhfMSIIKeOTkyhq/E4ZEZV2DXtLcbAqdPRQIsY3RfciTW3DkFwA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA2PR02MB7561.namprd02.prod.outlook.com (2603:10b6:806:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 14:49:23 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 14:49:23 +0000
From: Het Gala <het.gala@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Prerna Saxena <prerna.saxena@nutanix.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v9 01/10] migration: New QAPI type 'MigrateAddress'
Thread-Topic: [PATCH v9 01/10] migration: New QAPI type 'MigrateAddress'
Thread-Index: Adm74omRkBS4AYfqEEK9gSKYOnRtWA==
Date: Fri, 21 Jul 2023 14:49:22 +0000
Message-ID: <20230721144914.170991-2-het.gala@nutanix.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
In-Reply-To: <20230721144914.170991-1-het.gala@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PH0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::17) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4343:EE_|SA2PR02MB7561:EE_
x-ms-office365-filtering-correlation-id: 87a18a9b-dc40-41c3-69b9-08db89f9ac10
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KHd+uSRoy2JBPalzVLtU+5CvGxlZ41irAm7F72rbI1nygoGmpV7isYP+Vhn+gFe9g9CaHcDg46VergPXOMMvTh6j0FNTXMX8WhQB15IJtQTp95e1lmzY5zoJKZMdmaMjuIUKlWWnauvrPy1VVPHjnb8mJpeCLCKRXwRMicgRGIUJOu7D00YdHodMm6xHtt6sST2NstA+XyqdBjs1Y8DbODMaikbI9iiYXLFDR17WAO0wKbKwxUfnDD1LHy2fvfpRoiRz+gQ+fCnQsL6N/eKPKQkkaP1YOAQBkyBKTJEs9xJkP0bxqH5LON+QKHqcRs1gWIEb3n85T2LasVjLoUoPzrzexA/qTDsMXqmfrqk+jubKgi4H9Zfy0082q/+D5hxfCmp/eD15JPVT6PF01g7sJuJ2cKtHQ1wlCl24sZWqbifsNnA29qL8ChvXFijGu/H2zPL8GRjnaJ3rmIspWE9BnMZPQGbIkCpRh9iorhRPhuZV9EKVysMM9tRQ008pKhZNvUoner24ZGrlUIvAt1goBQZ1wJQJCxnxoVf7FtXGgOwGYq0C90+haKg1sA3xSzhhIfYzHJN7kiKsElSIx+ln+C++plY31epRzFFWJqNR60IdH9P/ekFbUmBJbB048pF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(2616005)(66899021)(6486002)(52116002)(6512007)(71200400001)(478600001)(86362001)(26005)(1076003)(107886003)(6506007)(36756003)(5660300002)(4326008)(44832011)(6916009)(41300700001)(8936002)(8676002)(316002)(2906002)(122000001)(38100700002)(54906003)(64756008)(66476007)(66556008)(66446008)(66946007)(38350700002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEhiRVc1cVMva21lUmt2NXZQUXBLRjgyRzg2OXNCcWNTMzJrdnE3bk5Yb09l?=
 =?utf-8?B?NmwyaEd1Q1Ivc0tOQUZzR0hjbUUyM1VZYXU5aWJvdEZQNEhwV1BMNG1tUjAy?=
 =?utf-8?B?aUlqdXhwV204WE1IR2dEb0RBOTFTSmp3TnRWVmdBaWVDYjZkb0k4Sk15VXc5?=
 =?utf-8?B?cmtmdUJoSUR3M0xoNVJMY0dqVlo0QnNvWEFiMTZRRk5rYTFnblA2TkdxU1Np?=
 =?utf-8?B?ekVsaUpZRnpaV0xLNWw4YjhzMkNLaGFES0doMEtUS2U3Z1kzd2l2Skh4SFlw?=
 =?utf-8?B?djNTZ3VTNUQ5RVgxMTFIVk1mODBuMVBISXBvdmhrU0gvOGpqL053NnBMWCtP?=
 =?utf-8?B?eVhXTEVhQVl0enFlQVlXN0hQL2RmTkxYQlk1dWtWYml4bW9qeExDUnpzZ2g1?=
 =?utf-8?B?bVBrVFF2U0ZYQXNyd3huZ0N4bkVGaUVpWWZmUTZWc2VNR0xDWElKS0RmejB6?=
 =?utf-8?B?Qm9CbEpLdHdLK3hYNGs2YVBLcEF0SmpZRHNXUElLR3dTYmwwUzNaSURDS0li?=
 =?utf-8?B?UDhTcTV3V3RiVHdkTXRkUkNIZnJWLzJyWEdKQTZyd3NOb3I3U1VqbnF6WktV?=
 =?utf-8?B?NnFsblVvRC9RNjBnSGtRS1c4WndBTHpHbk14R21UZkg5dUQ5NzZ4a3RWYlJJ?=
 =?utf-8?B?TWVZQ0NFOHI0dDhhZ0RkYjdpcDVKREpaMmQvSDF3YzM4bU45Y0NITklhTDE3?=
 =?utf-8?B?UnFaY3B4bmRnWVN0L0YyM0VuRmFtSkNXK2hBSWwzMndOUmd3ZmlGMFZ3cW1u?=
 =?utf-8?B?eXAyWk5TUGJ6ZU1tUzVCN2pNbFE4cmJFcTdaVWd1RGxIZGwzT01Ud0w4b1R4?=
 =?utf-8?B?QlY3K0ZHSXM1SlVETlBxdzF1OFB3RDBtOEFOdEF2T0NZbXU4b1hpSHFaSXds?=
 =?utf-8?B?cTJ3Z3NSalpld0UwcHBXRUFjaGZWaEtRN1pUZWFqZThuNkQvS040V2IvUXFC?=
 =?utf-8?B?a2R3aFZHQVI2YTRZaFdMVVN2OHJ4Qkl5VmJuQlBtU21qS21sbnR1VytGZXpm?=
 =?utf-8?B?UmRYWmlCSldseHhqT2I3cnROWXUwVk5YTWJIQ2o2bGdJNFNvc3pZN09NOWhi?=
 =?utf-8?B?Z28wK1h3M01MZGNjclJYRnJpVlRpaVRRcHpRazBuM0VJZHVhbS9tQVBQTDRk?=
 =?utf-8?B?UVVWUGw2NUt6b3FGOHB0Q3Z1ckVHbGV4OFd2bmEweFF4SDJZL20xMFRYbkhG?=
 =?utf-8?B?b1FxZGUzUmE5c0VrOHo0Y0FDNFJ1amZLcUJxa1hKYWpHL2pQbnRSaTlLNDl1?=
 =?utf-8?B?VHNuaEtncHpMMEFrVFZSMnRVVlh4cnlleUtXVThEZWQ1Q01PTzZjWmhvREZG?=
 =?utf-8?B?MjBwRmE4cWpRUWdtZ2lZTDV2aG5ZdUE5aG44dlVUci90RXZkOURIRlU2S2FM?=
 =?utf-8?B?Qjl4Z1AzZWR5bDhJa2dqelRpRkxCTHlobHVNY29ZY3V3c1IzeW9wOEF6UFY0?=
 =?utf-8?B?MlZjY0hqRjIxQXR4OUh5WURBVnhuOXQxejBaQ3p6MjcvaDlvc1JTM3VxOC9t?=
 =?utf-8?B?MnJKNFFHWHkwaEUyUUZrdzh2UWh6bVZXTEpDWmd2T2pRZXJ3d1k4b2FZZ1dX?=
 =?utf-8?B?cGRJQTI2Z3UrUEd3ZTZXS3Voa1NQKzZxZHEzN1FjK1dWOG5xNkhmcmpKVzdu?=
 =?utf-8?B?cnk3TWdZSUh5ZDVwdUNBWVNydUdxOFFtaGhhSGJZcnVPSG56Z1ROaHdBWUd1?=
 =?utf-8?B?eFF6VkZlTkdTT0NvUFBZNll3THNDZmJqZnVCVkZkRHYwSG9Lb2I0VFRnU29m?=
 =?utf-8?B?QlFnc2Q1M1JydmVUVk9iOTB4aDM3ek14SG5Cd0JkbXd5SW5uWnRFazluZUlF?=
 =?utf-8?B?cnhVOGx3aVcxYXVqMVhScUNsZ1dQbWlOZ0diOVo4aCtJcGxHVEIwc2ovSUhY?=
 =?utf-8?B?MjhsZGhTMVZkeHErNHp1a3BXRVBxS1ZYd2lEdHJibmd2OGJvbVlUb05sMk12?=
 =?utf-8?B?VEN1aWhIS1RsZ1hweXl5Y2pJanlPV2g1UURXZkN3NmxPWEE0QVBaQWM1aXRx?=
 =?utf-8?B?RkxHbUNOWUdBcERocUFaUkNxT0JBc2VSQVFZbTVaUnN0MUdpQW1zYXFoZGFs?=
 =?utf-8?B?elR1ZS8ydTVNS3lxa3Rrc0RhR1NiSm9oNHJpRkJBYiswN0JaUWRCbEsxVHRk?=
 =?utf-8?B?UTVCcEFVNmVhR21Uelo2WGlucUZpdzFGc0RKV1kzd0IyMXFxSXRVZk9CMGxu?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37ADCAD0E7AF7A4E9F9DBC360AE2D896@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a18a9b-dc40-41c3-69b9-08db89f9ac10
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:49:22.9288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJ7CHijSKEh+mSZEi1NJp5v857hGzhY3FgB6tyO8lSO9tpNPpILIlyF5Rof3XVXW/ubJvdzMqjb3kr7ictWX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7561
X-Proofpoint-ORIG-GUID: y2V6RjeAwAzYqzFAwp_rK65x7RbmQzvY
X-Proofpoint-GUID: y2V6RjeAwAzYqzFAwp_rK65x7RbmQzvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

VGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHdlbGwgZGVmaW5lZCBNaWdyYXRlQWRkcmVzcyBzdHJ1Y3QN
CmFuZCBpdHMgcmVsYXRlZCBjaGlsZCBvYmplY3RzLg0KDQpUaGUgZXhpc3RpbmcgYXJndW1lbnQg
b2YgJ21pZ3JhdGUnIGFuZCAnbWlncmF0ZS1pbmNvbWluZycgUUFQSQ0KLSAndXJpJyBpcyBvZiB0
eXBlIHN0cmluZy4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZm9sbG93cw0KZG91YmxlIGVu
Y29kaW5nIHNjaGVtZSBmb3IgZmV0Y2hpbmcgbWlncmF0aW9uIHBhcmFtZXRlcnMgbGlrZQ0KJ3Vy
aScgYW5kIHRoaXMgaXMgbm90IGFuIGlkZWFsIGRlc2lnbi4NCg0KTW90aXZlIGZvciBpbnRvZHVj
aW5nIHN0cnVjdCBsZXZlbCBkZXNpZ24gaXMgdG8gcHJldmVudCBkb3VibGUNCmVuY29kaW5nIG9m
IFFBUEkgYXJndW1lbnRzLCBhcyBRZW11IHNob3VsZCBiZSBhYmxlIHRvIGRpcmVjdGx5DQp1c2Ug
dGhlIFFBUEkgYXJndW1lbnRzIHdpdGhvdXQgYW55IGxldmVsIG9mIGVuY29kaW5nLg0KDQpOb3Rl
OiB0aGlzIGNvbW1pdCBvbmx5IGFkZHMgdGhlIHR5cGUsIGFuZCBhY3R1YWwgdXNlcyBjb21lcw0K
aW4gbGF0ZXIgY29tbWl0cy4NCg0KU3VnZ2VzdGVkLWJ5OiBBcmF2aW5kIFJldG5ha2FyYW4gPGFy
YXZpbmQucmV0bmFrYXJhbkBudXRhbml4LmNvbT4NClNpZ25lZC1vZmYtYnk6IEhldCBHYWxhIDxo
ZXQuZ2FsYUBudXRhbml4LmNvbT4NClJldmlld2VkLWJ5OiBKdWFuIFF1aW50ZWxhIDxxdWludGVs
YUByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdl
QHJlZGhhdC5jb20+DQpBY2tlZC1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQu
Y29tPg0KLS0tDQogcWFwaS9taWdyYXRpb24uanNvbiB8IDQxICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL3FhcGkvbWlncmF0aW9uLmpzb24gYi9xYXBpL21pZ3JhdGlvbi5qc29u
DQppbmRleCA0N2RmZWYwMjc4Li4wZjRhNTRhN2VkIDEwMDY0NA0KLS0tIGEvcWFwaS9taWdyYXRp
b24uanNvbg0KKysrIGIvcWFwaS9taWdyYXRpb24uanNvbg0KQEAgLTE0MTcsNiArMTQxNyw0NyBA
QA0KICMjDQogeyAnY29tbWFuZCc6ICdtaWdyYXRlLWNvbnRpbnVlJywgJ2RhdGEnOiB7J3N0YXRl
JzogJ01pZ3JhdGlvblN0YXR1cyd9IH0NCiANCisjIw0KKyMgQE1pZ3JhdGlvbkFkZHJlc3NUeXBl
Og0KKyMNCisjIFRoZSBtaWdyYXRpb24gc3RyZWFtIHRyYW5zcG9ydCBtZWNoYW5pc21zLg0KKyMN
CisjIEBzb2NrZXQ6IE1pZ3JhdGUgdmlhIHNvY2tldC4NCisjDQorIyBAZXhlYzogRGlyZWN0IHRo
ZSBtaWdyYXRpb24gc3RyZWFtIHRvIGFub3RoZXIgcHJvY2Vzcy4NCisjDQorIyBAcmRtYTogTWln
cmF0ZSB2aWEgUkRNQS4NCisjDQorIyBTaW5jZSA4LjINCisjIw0KK3sgJ2VudW0nOiAnTWlncmF0
aW9uQWRkcmVzc1R5cGUnLA0KKyAgJ2RhdGEnOiBbJ3NvY2tldCcsICdleGVjJywgJ3JkbWEnXSB9
DQorDQorIyMNCisjIEBNaWdyYXRpb25FeGVjQ29tbWFuZDoNCisjDQorIyBAYXJnczogY29tbWFu
ZCAobGlzdCBoZWFkKSBhbmQgYXJndW1lbnRzIHRvIGV4ZWN1dGUuDQorIw0KKyMgU2luY2UgOC4y
DQorIyMNCit7ICdzdHJ1Y3QnOiAnTWlncmF0aW9uRXhlY0NvbW1hbmQnLA0KKyAgJ2RhdGEnOiB7
J2FyZ3MnOiBbICdzdHInIF0gfSB9DQorDQorIyMNCisjIEBNaWdyYXRpb25BZGRyZXNzOg0KKyMN
CisjIE1pZ3JhdGlvbiBlbmRwb2ludCBjb25maWd1cmF0aW9uLg0KKyMNCisjIFNpbmNlIDguMg0K
KyMjDQoreyAndW5pb24nOiAnTWlncmF0aW9uQWRkcmVzcycsDQorICAnYmFzZSc6IHsgJ3RyYW5z
cG9ydCcgOiAnTWlncmF0aW9uQWRkcmVzc1R5cGUnfSwNCisgICdkaXNjcmltaW5hdG9yJzogJ3Ry
YW5zcG9ydCcsDQorICAnZGF0YSc6IHsNCisgICAgJ3NvY2tldCc6ICdTb2NrZXRBZGRyZXNzJywN
CisgICAgJ2V4ZWMnOiAnTWlncmF0aW9uRXhlY0NvbW1hbmQnLA0KKyAgICAncmRtYSc6ICdJbmV0
U29ja2V0QWRkcmVzcycgfSB9DQorDQogIyMNCiAjIEBtaWdyYXRlOg0KICMNCi0tIA0KMi4yMi4z
DQoNCg==

