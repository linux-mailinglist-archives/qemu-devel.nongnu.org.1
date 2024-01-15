Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8682D40D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:02:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPG3G-0001VP-Fs; Mon, 15 Jan 2024 01:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1rPG3D-0001Uu-6P
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:02:23 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1rPG3B-0008KA-4N
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:02:22 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40ELe1Ok029923; Sun, 14 Jan 2024 22:02:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=SEbPyB0239wjCiLEI0hbkmebueVoBDKB3MYAVh
 F0lT8=; b=UVN8NgCv8Kv/D2H02o2aJBEtC7AhOhNow9/B+jCRoNx6LbRepNc2vP
 3LbWp973T2UMFyPjPT7nFjCPcIBI+CPXeE0VJghQjYUynYNw/oRan2NczLQDuWYF
 BGDgtbUMHKg/WGmelduJcc0QgC1Xhx2aYqKAI7AZDwW4PCOIZKbhgU5sj0H63yRz
 aF8SCwKOkBHLxYUpXrrT92vg0PkDUIcFX4ctevWE0mGm47Fm3b17NYNcqOQgLXSx
 XLbqvXV8UBBQm0KTE+gfZbqt2yxySShGZx0WxMee45s+Bg39Vqb96wLJn4JDwFxc
 7FVRw9CZRrlufM/nRuduTzwd7B2MmIEQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3vktqfj7gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 14 Jan 2024 22:02:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lew47HedU/Uus6R2GlMnVAVxQPTfoJa5DSP4uEabXIlAM29d5xrz7B3XGQukk12+7gdq5IkZ3dDoIO9gGWxJSWy86Qzk72rZ6mluftbA4258De9tv2mSCzaqV3uP5v1BoOw3FGAzEuXcaZDEXTVQL0ndXe0CLzdZ7FQuXNLZ/1HDyx0sSkK3OA5Ey7bZdoRXUxmEVrjHyi+upEu/wIazgVEv+2SMEHI0qjXdwSbMO3u3ak6TmsdPtVkVIDhA0Tqcnw0tFANlHJlFk//iBx1F9je2bJfxiX+GnDaPLPjTioECw8E0c5k5lB8jCS5gbzE1T6PysIMu3l346ihFnw9Bog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEbPyB0239wjCiLEI0hbkmebueVoBDKB3MYAVhF0lT8=;
 b=mOdK5p6h16F5WtYnhoZUnrJX0LI6wPjQiczkQ5YVBKXx6BMiD6yeNheCLZZzjbonO9DkUo5Ngel6GXji2X6rDDF/h5Js5hJzy9rDo9xLvFmxeekblGV4sI5Pk8/LYSEc//uzLry39Xx6X8A17H+L8Z5gi71db9JNU3De9e9lGDSLatRKwQIE8R5SYpfAUmTNaVC3ESToId8Pmq0UzDHtXj1Kz/GKyAEeMnxbuVWUfb6ESe4T/Fs90yCEnGtmUK0GVdemcvch3TbtnHprVxAzlkoSjYe6S+QHeZ4dni+gneFNa1qLf6Ccf1zUqyDsnz1+tivZlRbLGyXWmgQxnK/4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEbPyB0239wjCiLEI0hbkmebueVoBDKB3MYAVhF0lT8=;
 b=yTIpAoAoEmCtC9XiB15aoIPKxmZg8i8JLP1wbuUnqajZ4Wm4+LxY6Vqxpj8VNhagPCI6YXYR15h86m2s6Er8PoSvgRaKYpYK/9PJHkiMjfnv8eLXtq53AaujKvBBCwXWXlNnU4AfY3LNZflkjIHKseJgE/hC1fphAXCUGCyTUHouHaOB3JWaSi77GqL/H14hSXy2uynQikareJh/tlHr6oPorRv//y1SkVZoVsk58t4nv/tRfGIEOhQvpz33TFFV4oQTcDAqS4lI5Ben4DkhGNHqpiNKmGiQpn0H3Ro5HvVlB01eBWkhC6GVIpkqCFwEr8UYp+UQyin1sYdML0pc9A==
Received: from CO6PR02MB7555.namprd02.prod.outlook.com (2603:10b6:303:b3::20)
 by MW6PR02MB9768.namprd02.prod.outlook.com (2603:10b6:303:245::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Mon, 15 Jan
 2024 06:02:05 +0000
Received: from CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::4a9b:daa2:2dff:4a60]) by CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::4a9b:daa2:2dff:4a60%3]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 06:02:04 +0000
From: Shivam Kumar <shivam.kumar1@nutanix.com>
To: Hao Xiang <hao.xiang@bytedance.com>
CC: "farosas@suse.de" <farosas@suse.de>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela
 <quintela@redhat.com>
Subject: Re: [PATCH v3 01/20] multifd: Add capability to enable/disable
 zero_page
Thread-Topic: [PATCH v3 01/20] multifd: Add capability to enable/disable
 zero_page
Thread-Index: AQHaR3hdZy8WJlT+lkmcBuQPaeEkGA==
Date: Mon, 15 Jan 2024 06:02:04 +0000
Message-ID: <22969801-AEDE-46EB-86E8-0E6F26E23397@nutanix.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-2-hao.xiang@bytedance.com>
In-Reply-To: <20240104004452.324068-2-hao.xiang@bytedance.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR02MB7555:EE_|MW6PR02MB9768:EE_
x-ms-office365-filtering-correlation-id: 168abf9e-db29-4a75-1e91-08dc158f7fa3
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6CEo/6CDSRBE69YlevAUoXy+ix+3mg/VmLvRD6tvmZ4dez4/h/8BNv7mX4SCeLmjSGNFFdpBlBIXVOOIIoDmbqHaj9AyuN0h8Z7yCTF3dtCn7iXt36bH6zjCdWgW8VlCd3rL8pCKstgAH0pNwOklrzK7pcRAXFPeFZs8Q1UCvdtP5QAViB9PyADmsUetu5c1Q/E7tS1DE0e55R1WJ/+t+lV+yYmKfP+SxEz4agGwKmyKvSDvM/6vngXSwEylgLMGdKZVnGOYcTyNpPD+5JOT3gs4F6sBtaPzKuddk7ipa/1e2QyqcxcK8Q+zUCtmDsK0kH9L+RZiMwg2ZGOIUt9erpB8XzxlDSGYkBzv/PGtyxX7oFGpQNFbH+I6ZDjkPsu33hD9Ndlvh7zI21avxxxx9WnxHzb4BF6PCoiajI8SUc8wnQuR4gHgRZci3XIK7bYzKNyXPnQ5wnM9YvBdO6rbH0PuXdn3pMI97Zc6XYVwCX/nNhBFqVwrY6lk+QDDakcFPqK6iSmxYqTL20M3mksytz0zGFbgtEX8UTP7qsMJ1I7X1xuvsRV0pcGgj8XxarwWBNMmvp8VdHh20roIMafCGnpdFNQKPg805EWLXP8C/LpDHwPaBG41zTzayH2Ckv94EIlAbDiruG0dsY1QOBfq7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR02MB7555.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(91956017)(66476007)(122000001)(41300700001)(66556008)(66946007)(76116006)(86362001)(316002)(36756003)(38070700009)(38100700002)(5660300002)(6512007)(2616005)(53546011)(6486002)(478600001)(64756008)(71200400001)(6916009)(2906002)(66446008)(8676002)(54906003)(4326008)(33656002)(6506007)(8936002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFl4NzJ1aXlPYk04YzZWUGlCVUlWQW9KeUFDdHRQejFhdjhhWXNSU09SdVUx?=
 =?utf-8?B?ZW1pMVNKS0pMVWsxbWlicVFoWGpaYnQ1dE1oM2M4WS96SzBLNStjTXlrUXZW?=
 =?utf-8?B?ZlBDSmxtR29NeldDVlpvc2o4N0E2OHVsb2dKNlVFTituaTdoTFNHdDA1djB4?=
 =?utf-8?B?bnlYbWZqSzR4Z0FIR3JVbHN5QVczMExUMm95ZTdyMWc5anJqRmR1aDQzSndL?=
 =?utf-8?B?Y3VGQjlrN09pU3V3cHl2M3g0WnFXQzdnNHFweXljMnBuYjJ1U3NKMWJFN2VB?=
 =?utf-8?B?VTdMNEZmaGdId0RBK1RKbk1GMStXcVI1aW1VbEdaVGh2ajI5QmxzZ2tWNUxP?=
 =?utf-8?B?ekIxUW5yOExXS3RiTlAxTi9LMGQwejNreW5peVUzWUVjQ2dUb255RStMV2pI?=
 =?utf-8?B?RVMrU2d2am1CdXJSRUlZa3B4VUdTRFN4Ymg2anZHWDV2TUh2UC9TTVBqQktE?=
 =?utf-8?B?NFlGMkNQQ0U3UUp2YVRGbTJud3BUNVVSNCtibWxWblJoYUVxSmExbXZzd3Fj?=
 =?utf-8?B?RVVkQTJLNHVUR29UNEpqaHNMS0JtV08vYmdzdWljcEU5SS83RThkWHUvdkVU?=
 =?utf-8?B?SEVaZkVjR0tnNnpjbEQveDFkZ1hvUk0yUXRnRFo0MVdCVWxPbWN6SDlSRS9K?=
 =?utf-8?B?OGVKc0dWSDN2ODMzNUdzSXBaTjNNN1BlV2pkOXgxQk56aGdrSFVnenJIeTJw?=
 =?utf-8?B?ODlxTVdHWVhqQ0E5NXNkR2hUMlhHZVJlSklUSjF3cEw1bElQMytlMExlZlhh?=
 =?utf-8?B?Mk1XeTRJM1hMV1JBSisvSWdIM29ZUDRiZHBoRTdnSTdFNTl3V2l6clJFekZy?=
 =?utf-8?B?VHpvTWdHb0lRKzVqbDdpNDdKbnBsNWRpZGZUSVdURXlXWkE5RUVUNHJtVEdo?=
 =?utf-8?B?Mkh4WW9IUXpNWlRnS1Y5Q3QyUDJ5ZXFqZWdFN1ZkWXEwZTF1WUsyVWQzTGZs?=
 =?utf-8?B?UmEzRjdQbFEwOWNxZDZZdlEyR091bEdERXJXTEZKQkRobEhRVURYbGRnRFA4?=
 =?utf-8?B?YWs1NXRkZUZ1WUpVMlhVSjZhYk8zMG1RVWhmYWJmcmNvT1JkeldPak9JbW43?=
 =?utf-8?B?TXlyR0ZtV010MXh4bWNsUDRaT0lIeTNMY0VBMDFaUUhFL2d6NyttNU05ZHNk?=
 =?utf-8?B?REtneXlWQnRmUGFZdDcraVZJajFGTW1pNURtaU9aT3kxd3lPNTc2WDNQSWgy?=
 =?utf-8?B?N1hCZTdOaWR2S1dyOXNKY3RuSzlmUC9aNXZKUEZ1VzErcjRPRldXMkZ4c3VO?=
 =?utf-8?B?cVVYOW5QVDNpV1ltcUFFKzV4Njh4Q21GYTNybi9PNWU4dGt5bW9DMEQrYVpt?=
 =?utf-8?B?ZFhTdy9iRkl4YkpzQUpVVVRoc044UUIrR0hwdzYxVzNLanA2bGxCaENBZ3o3?=
 =?utf-8?B?SDZoaUFaajF1QU4xL0ZkenZSVEo1TDZEMWFuWHhxSnNiQ0JCZDFxbnR6Wi83?=
 =?utf-8?B?MjJrY3FhdC9Pd3FsTFIwY2dFaVIvNmd3aXVvTTkxcEd6TGVTZzRCanovQzhk?=
 =?utf-8?B?SWdWMzU0TEFjaFNnWGFxR3l3NDZtNjBXSFF6UWpDdzBmR2thOUkzWk80bDhq?=
 =?utf-8?B?UUdRWnZiR2VCZnNaTHdLQlUvcW9XcUUrcWRLNEltT2hrbVRhVDJId005Y1Mw?=
 =?utf-8?B?Nnorc1dWdXBCWEdJamFvMEJkV3N2UndncFdMbzFad2xsVWkzVlFablYvT0lm?=
 =?utf-8?B?SkgwQzBvUjJiVjlTZDluME56ZU9zVVhKUVNsL1dRYnNyM0FOazZITUUrcEk4?=
 =?utf-8?B?VC82TUlNUkxoWWxXUGNRV2hqOGc3UkptL2d4am5iOEJRbTlqd2tqSmY1TXJz?=
 =?utf-8?B?SkRFdkgvemNxbmZSUGEvb2dHNklCeTV4M1RZVnVkN2c5SVNjUWRCdklWSGpB?=
 =?utf-8?B?ek9lbm5NUHBUN2pEbysxNFlxNUZWNjE5a3JySXBab3ZHUnNVeGtrUjMya1NX?=
 =?utf-8?B?MGd4WG5OTGFjTlVNdmVHb0VJaTlFSktxZlZoc0tPQ0prUHlXcngwUVdzSU8y?=
 =?utf-8?B?Q21nS2RJdzNQZDlpaUxpdzNvUm1hMmEzTThJbzE2bFdLc0pPZHhub0JCbkpv?=
 =?utf-8?B?TmNTeWszSFNtNzlDTTdTeVc5dGpoRnZ3dnZvaTVaOWpLdkdtdStZbWFRLzcx?=
 =?utf-8?B?NUtuZjU4TVRKdlI0L3FiNlNXK0x5UHhRYS9HTlR6a2RGS2JobDVFSGIrTEhH?=
 =?utf-8?B?amNpNy9UNGpvZDBkQzZuTzFrSC9CMC93Rk9iSHR5M1ZOL2dQYlR4dVNkQzdk?=
 =?utf-8?B?K1BSSUpSUmhTY0RqaEVuTjBKS0JBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19BBA9516D2E564EA84EB88B9B0800F6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR02MB7555.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168abf9e-db29-4a75-1e91-08dc158f7fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 06:02:04.5194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gd1t2d6yAzMOpc7vLDR/wd5qWCg2hrU0xe3jaVJEy1in+5VHc/W7chBJNg4DymtK+Q5U6o46AHdyP6Up27DawNqWUwjqQm61QmaBOth3Hjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9768
X-Proofpoint-ORIG-GUID: gB6VIk84XNlFKaMAW3imY5fEWn96maQm
X-Proofpoint-GUID: gB6VIk84XNlFKaMAW3imY5fEWn96maQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=shivam.kumar1@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gMDQtSmFuLTIwMjQsIGF0IDY6MTQgQU0sIEhhbyBYaWFuZyA8aGFvLnhpYW5nQGJ5
dGVkYW5jZS5jb20+IHdyb3RlOg0KPiANCj4gRnJvbTogSnVhbiBRdWludGVsYSA8cXVpbnRlbGFA
cmVkaGF0LmNvbT4NCj4gDQo+IFdlIGhhdmUgdG8gZW5hYmxlIGl0IGJ5IGRlZmF1bHQgdW50aWwg
d2UgaW50cm9kdWNlIHRoZSBuZXcgY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEp1YW4gUXVp
bnRlbGEgPHF1aW50ZWxhQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiBtaWdyYXRpb24vb3B0aW9ucy5j
IHwgMTUgKysrKysrKysrKysrKysrDQo+IG1pZ3JhdGlvbi9vcHRpb25zLmggfCAgMSArDQo+IHFh
cGkvbWlncmF0aW9uLmpzb24gfCAgOCArKysrKysrLQ0KPiAzIGZpbGVzIGNoYW5nZWQsIDIzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24v
b3B0aW9ucy5jIGIvbWlncmF0aW9uL29wdGlvbnMuYw0KPiBpbmRleCA4ZDhlYzczYWQ5Li4wZjZi
ZDc4YjlmIDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vb3B0aW9ucy5jDQo+ICsrKyBiL21pZ3Jh
dGlvbi9vcHRpb25zLmMNCj4gQEAgLTIwNCw2ICsyMDQsOCBAQCBQcm9wZXJ0eSBtaWdyYXRpb25f
cHJvcGVydGllc1tdID0gew0KPiAgICAgREVGSU5FX1BST1BfTUlHX0NBUCgieC1zd2l0Y2hvdmVy
LWFjayIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIE1JR1JBVElPTl9DQVBBQklMSVRZX1NX
SVRDSE9WRVJfQUNLKSwNCj4gICAgIERFRklORV9QUk9QX01JR19DQVAoIngtZGlydHktbGltaXQi
LCBNSUdSQVRJT05fQ0FQQUJJTElUWV9ESVJUWV9MSU1JVCksDQo+ICsgICAgREVGSU5FX1BST1Bf
TUlHX0NBUCgibWFpbi16ZXJvLXBhZ2UiLA0KPiArICAgICAgICAgICAgTUlHUkFUSU9OX0NBUEFC
SUxJVFlfTUFJTl9aRVJPX1BBR0UpLA0KPiAgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwN
Cj4gfTsNCj4gDQo+IEBAIC0yODQsNiArMjg2LDE5IEBAIGJvb2wgbWlncmF0ZV9tdWx0aWZkKHZv
aWQpDQo+ICAgICByZXR1cm4gcy0+Y2FwYWJpbGl0aWVzW01JR1JBVElPTl9DQVBBQklMSVRZX01V
TFRJRkRdOw0KPiB9DQo+IA0KPiArYm9vbCBtaWdyYXRlX3VzZV9tYWluX3plcm9fcGFnZSh2b2lk
KQ0KPiArew0KPiArICAgIC8qIE1pZ3JhdGlvblN0YXRlICpzOyAqLw0KPiArDQo+ICsgICAgLyog
cyA9IG1pZ3JhdGVfZ2V0X2N1cnJlbnQoKTsgKi8NCj4gKw0KPiArICAgIC8qDQo+ICsgICAgICog
V2Ugd2lsbCBlbmFibGUgdGhpcyB3aGVuIHdlIGFkZCB0aGUgcmlnaHQgY29kZS4NCj4gKyAgICAg
KiByZXR1cm4gcy0+ZW5hYmxlZF9jYXBhYmlsaXRpZXNbTUlHUkFUSU9OX0NBUEFCSUxJVFlfTUFJ
Tl9aRVJPX1BBR0VdOw0KPiArICAgICAqLw0KPiArICAgIHJldHVybiB0cnVlOw0KPiArfQ0KPiAr
DQo+IGJvb2wgbWlncmF0ZV9wYXVzZV9iZWZvcmVfc3dpdGNob3Zlcih2b2lkKQ0KPiB7DQo+ICAg
ICBNaWdyYXRpb25TdGF0ZSAqcyA9IG1pZ3JhdGVfZ2V0X2N1cnJlbnQoKTsNCj4gZGlmZiAtLWdp
dCBhL21pZ3JhdGlvbi9vcHRpb25zLmggYi9taWdyYXRpb24vb3B0aW9ucy5oDQo+IGluZGV4IDI0
NmMxNjBhZWUuLmM5MDFlYjU3YzYgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9vcHRpb25zLmgN
Cj4gKysrIGIvbWlncmF0aW9uL29wdGlvbnMuaA0KPiBAQCAtODgsNiArODgsNyBAQCBpbnQgbWln
cmF0ZV9tdWx0aWZkX2NoYW5uZWxzKHZvaWQpOw0KPiBNdWx0aUZEQ29tcHJlc3Npb24gbWlncmF0
ZV9tdWx0aWZkX2NvbXByZXNzaW9uKHZvaWQpOw0KPiBpbnQgbWlncmF0ZV9tdWx0aWZkX3psaWJf
bGV2ZWwodm9pZCk7DQo+IGludCBtaWdyYXRlX211bHRpZmRfenN0ZF9sZXZlbCh2b2lkKTsNCj4g
K2Jvb2wgbWlncmF0ZV91c2VfbWFpbl96ZXJvX3BhZ2Uodm9pZCk7DQo+IHVpbnQ4X3QgbWlncmF0
ZV90aHJvdHRsZV90cmlnZ2VyX3RocmVzaG9sZCh2b2lkKTsNCj4gY29uc3QgY2hhciAqbWlncmF0
ZV90bHNfYXV0aHoodm9pZCk7DQo+IGNvbnN0IGNoYXIgKm1pZ3JhdGVfdGxzX2NyZWRzKHZvaWQp
Ow0KPiBkaWZmIC0tZ2l0IGEvcWFwaS9taWdyYXRpb24uanNvbiBiL3FhcGkvbWlncmF0aW9uLmpz
b24NCj4gaW5kZXggZWIyZjg4MzUxMy4uODBjNGIxMzUxNiAxMDA2NDQNCj4gLS0tIGEvcWFwaS9t
aWdyYXRpb24uanNvbg0KPiArKysgYi9xYXBpL21pZ3JhdGlvbi5qc29uDQo+IEBAIC01MzEsNiAr
NTMxLDEyIEBADQo+ICMgICAgIGFuZCBjYW4gcmVzdWx0IGluIG1vcmUgc3RhYmxlIHJlYWQgcGVy
Zm9ybWFuY2UuICBSZXF1aXJlcyBLVk0NCj4gIyAgICAgd2l0aCBhY2NlbGVyYXRvciBwcm9wZXJ0
eSAiZGlydHktcmluZy1zaXplIiBzZXQuICAoU2luY2UgOC4xKQ0KPiAjDQo+ICsjDQo+ICsjIEBt
YWluLXplcm8tcGFnZTogSWYgZW5hYmxlZCwgdGhlIGRldGVjdGlvbiBvZiB6ZXJvIHBhZ2VzIHdp
bGwgYmUNCj4gKyMgICAgICAgICAgICAgICAgICBkb25lIG9uIHRoZSBtYWluIHRocmVhZC4gIE90
aGVyd2lzZSBpdCBpcyBkb25lIG9uDQo+ICsjICAgICAgICAgICAgICAgICAgdGhlIG11bHRpZmQg
dGhyZWFkcy4NCj4gKyMgICAgICAgICAgICAgICAgICAoc2luY2UgOC4yKQ0KPiArIw0KU2hvdWxk
IHRoZSBjYXBhYmlsaXR5IG5hbWUgYmUgc29tZXRoaW5nIGxpa2UgInplcm8tcGFnZS1kZXRlY3Rp
b24iIG9yIGp1c3Qg4oCcemVyby1wYWdl4oCdPw0KQ0M6IEZhYmlhbm8gUm9zYXMNCj4gIyBGZWF0
dXJlczoNCj4gIw0KPiAjIEBkZXByZWNhdGVkOiBNZW1iZXIgQGJsb2NrIGlzIGRlcHJlY2F0ZWQu
ICBVc2UgYmxvY2tkZXYtbWlycm9yIHdpdGgNCj4gQEAgLTU1NSw3ICs1NjEsNyBAQA0KPiAgICAg
ICAgICAgIHsgJ25hbWUnOiAneC1pZ25vcmUtc2hhcmVkJywgJ2ZlYXR1cmVzJzogWyAndW5zdGFi
bGUnIF0gfSwNCj4gICAgICAgICAgICAndmFsaWRhdGUtdXVpZCcsICdiYWNrZ3JvdW5kLXNuYXBz
aG90JywNCj4gICAgICAgICAgICAnemVyby1jb3B5LXNlbmQnLCAncG9zdGNvcHktcHJlZW1wdCcs
ICdzd2l0Y2hvdmVyLWFjaycsDQo+IC0gICAgICAgICAgICdkaXJ0eS1saW1pdCddIH0NCj4gKyAg
ICAgICAgICAgJ2RpcnR5LWxpbWl0JywgJ21haW4temVyby1wYWdlJ10gfQ0KPiANCj4gIyMNCj4g
IyBATWlncmF0aW9uQ2FwYWJpbGl0eVN0YXR1czoNCj4gLS0gDQo+IDIuMzAuMg0KPiANCj4gDQo+
IA0KDQo=

