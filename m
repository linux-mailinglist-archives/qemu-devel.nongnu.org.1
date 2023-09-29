Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBF7B2A06
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 02:56:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm1mx-000201-6D; Thu, 28 Sep 2023 20:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qm1mv-0001zm-5u; Thu, 28 Sep 2023 20:55:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qm1mj-0001ou-Sr; Thu, 28 Sep 2023 20:55:24 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38SDnHm4009425; Thu, 28 Sep 2023 17:54:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=FUTdUKQ8je1EeoMf0RD52bfGMk0CKojMIAsjwg
 aq4gQ=; b=ggGgMQ+Dnr7kx0MrQ8RqCX5bb6XuAAV+fCdHel9TPj7vnkO/pctt5+
 6MYdUikXfYmAi6uANviwyAI+HbFnNgg7ckMlj5nmuqv7r0t+mBX9OF6Ju6YW3cEx
 yNoh+vg0ggjomVi3CUvGVtion6Khdx4pQevByde/0pYkfi8yedeFgi+Zruow12gi
 4ih7qMU9KPfVNjN8uIM8X2pomN95vCVX6Ctbh9dTe2QWom+uUNQuh44xSJr9QJiH
 P5yYjOdjoOrmxGNaYLe6Ljnn/oF3dWCy0nTriP0uFAZx2NVzdDMzSx0AFKM2IQG1
 VBgqT/33Jf7oYj+2szov8ZFEQbnPSavg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3t9yjvastj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Sep 2023 17:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHvZ1uggNieWWVpJAbC3f9fr3uj4Is4JltbOk16Z281nkv586uzzsYhcwWM9T03GWVePaGkp+eCNN9fmAjCX9UTLz4Rs2VpI/LXWs3qEx9JM6hnDd3egfG25ldliBVULaOkXVUVQC+RbPZnLnvhEEmn68ml7GEGmFVraRUAZ0r9VrduOoL+bMFL8YUOajX063cj+BZLJqNVu5tMwMe5fwNKNnzpB8ba4J6h+/FMdtaU/73PTEDC5mOw3xnKK5Lfx+uj3oyU0gcYN+WeaLIT5nUgRDnP7zT3E/6evL5lGe70xNcYNetaThpR1LEShbg0ezCKXtRrrJNEKEDy0FDtrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUTdUKQ8je1EeoMf0RD52bfGMk0CKojMIAsjwgaq4gQ=;
 b=YuwgHNAZB8w4AMkDhqTMjlFxnC/vzo53gjHC0Lcgs5t048egEMg+NRQM31pPMxmvcxmckJKx76s77r5CiKK/i1Inm7WHwocQG31oM+xBBGyVvCR4miu1L2u4+mrcA2vDQCrrKOTEpCmZ6DM5VK59l0aRPjUmUFsg+mp6nhFXepmXmBStSAfOlLIgEtAeO2my6D2vNHXHpRJtnVM2Z1iHwS6f6LHyqd9693AmPI5muB05Z7R/xBr8zaYlk8vz7bOrg0oN2VHWz/I+2OWNE08FhKsyV9QJsL0FHvcy2N41JaZdW6DaO064ghuWexEN+zr+ieDQP6Sf5NHSpDVH54T1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUTdUKQ8je1EeoMf0RD52bfGMk0CKojMIAsjwgaq4gQ=;
 b=tNqNeuYxYSRXyg26CPKVdVZIwVq5u3rlXgN2G1s3C9NcO/+f8iATOoQC7CzmCC/TXdmFxDWSPLAhzAYP5nYGx+3+ksZfVKmPIGlIm5EBxVQQpUA2Yco3xKwOKXzJvN9iMdaJ2mcE56UN5r/4Ft9m5TqW7cAp/NS/wgydBNKiTiOZtMk88feTLSBMiKscYMMvdx5YluWnyau7CV1GwEZsUdQYTBoIADnrWY5+CBvDM39wHElgg1aquKwswiNgds37xDeGJbl5Y2GFZuzdi1Vony/JeZrfNeDQhMwG0QB5o7k56f47q1iU97FsfrQubPFgGA6ZDc0WdBB1OYxVFsxp7g==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO1PR02MB8348.namprd02.prod.outlook.com (2603:10b6:303:163::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 29 Sep
 2023 00:54:53 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::136e:4c43:97d6:6c8d%7]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 00:54:51 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng
 <fam@euphon.net>, =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, "open list:Block layer core"
 <qemu-block@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/5] vhost-user-common: send get_inflight_fd once
Thread-Topic: [PATCH v6 1/5] vhost-user-common: send get_inflight_fd once
Thread-Index: AQHZ7UqL16VpdX350kuSQSVN6q0TkrAxBIQA
Date: Fri, 29 Sep 2023 00:54:51 +0000
Message-ID: <D5AD3E2E-8C4B-4ADA-B054-B42E2B030808@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
 <20230922114625.5786-2-fengli@smartx.com>
In-Reply-To: <20230922114625.5786-2-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO1PR02MB8348:EE_
x-ms-office365-filtering-correlation-id: 0390d0ad-d55a-46c3-2748-08dbc086afd4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1asJgFL34YP3z5r1IEXF6eRTKXd52LBrt9Ct+eKs5gHkO6RlUPOh4HMqsH6f0VGrte8Ezh9vq+mfL8iJSOsV2F3EKdPurSHz3ZtG9jZCR0fNYdgoiWjTZUx2dgxXg3v38gRPSaocFcleMK59RYPcY4abI7xfbUlBZg0VeltlQrgPEwdJCjNtkH/upav4uYOM1j6Lt7FIyF0Ki/EwW9iL80S031qKCdK9XJs3Wheo+T8iPBTXdYr0c+C7mzmKqCjoJz6oQERuL7FSmymDI+f58lE872AQHg2CBonqJ+IkeLZDKJUkSUe+Oi/iut/tdjNW61ocJpJ3PTa8xgRKKJsVIcBf5TVQwViqJDMM4+BHjjkV9FXY/l1xlmfR/eAE1E3oLaFfkYAygEDQUucrAYoy4cu4cImL1d8+anZJvEvVerHCqcxvrh3lxt2m3ZbR4MLzAfXOeJ6lfuKz+GtV+7K27vAtBlMeEAJdx9n/DHcY5qJGAbwV8DzXI3AwffImoz17nmTtDASNfwHuMauMUJgf6luw2X8VAbdE3K6215a/nyuNkgtWtjQ0Z1C+eiRKzCrg8/9BIfyI6YqmgY4+JXFsaemWlI65YY27urBu4lY6tmiTxiH6Etgkx6d7/KYV24xkehj4rXvvTvw/biABxg9cGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(71200400001)(53546011)(6512007)(6506007)(6486002)(8676002)(86362001)(36756003)(2906002)(76116006)(38070700005)(64756008)(33656002)(38100700002)(4326008)(83380400001)(8936002)(478600001)(5660300002)(316002)(122000001)(66946007)(26005)(6916009)(91956017)(41300700001)(44832011)(2616005)(54906003)(66556008)(7416002)(66446008)(66476007)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDFoUWhTay9ZVEZrUHZ2SE5jZGtmRk9hOXhuMGE4TVVnWm52QWZ5ZlJpcm5h?=
 =?utf-8?B?YlVXNWh6QTA4eGVubTg5QUY5U203U0Q3NnNoQUJleEhUcUdRaytnWDE0UC9R?=
 =?utf-8?B?aHAzL0pJVjR6eDhGM0J5Z2V5S2QzdVRyaFNSWTZsMDZuRWdSZk9oVXB1QmhM?=
 =?utf-8?B?b2FwSUdIRlFhZ1JmQlI1ZkR1Q0hwNFBWMGU1TUhkWWpTcnRUa2hodDVvU2h0?=
 =?utf-8?B?am1zV2JpV1RCQlhyZTgxdFA0ZW5adU9IZThEcVMwblRBYjFLZmpRVjdWbWdy?=
 =?utf-8?B?d3V2cURnU1JrTkNuMXMzK2Q3S2pUbXNaTlYvR1FhWDg4ZGZsTW5UNEs5c1o1?=
 =?utf-8?B?V2E0YTNTTkJmMFpjNkRmcVBWSmMrb1V1aFBjbzZyN1ZWRGdQMEZJTm85OE5Z?=
 =?utf-8?B?SnROdE9mSWJaT3lSQ0xqN01QTk5uWEdrcUc4djFya0pWV2N5RnhQTXZhQldp?=
 =?utf-8?B?SVJPb2p3bG95VHAxM1YzQWZTMzc4UldFdVdoeUdSeWR5NTFKM3p6YjRlTGRM?=
 =?utf-8?B?ZW0zM0ptODBmcDFDTUQrdUVWcGJFbkUxT3RQVkM4cDdpVkYvYkRzd0NrUytU?=
 =?utf-8?B?VmtHb25rbzk0UGdEb2V3cWdHL2ZmbDJMQUVCRjg3bFhXRFRVcWtIS1FiRHRO?=
 =?utf-8?B?OVhUQ2laZVNZaTVETTNZby8zT2hSYUpGenZQRXZwYUcrdTRuQkwyUW5kUzZO?=
 =?utf-8?B?anhsTlp6by9VY2trNDd4SUp2N24yZTRaYlErSTN4VmNPaW1zVFlzS2ErS3cw?=
 =?utf-8?B?clQ4ekR3SGJpcjdTYWdOK042TVdyc3l0QVBoUVorWHhjVzJEZEk5MElFVzRt?=
 =?utf-8?B?bEtpaWN6Yk4vR1Bka2Y0S25wWC9PM01PejE3N2swekI2aU92dUtEdGlSVERK?=
 =?utf-8?B?Ymo0NWtXTTdhR204RUxhZ3hHSkp2bmlHNlZlRVA1N1d4alU1Njc5SnFPUGNy?=
 =?utf-8?B?MmZWWjdUcHZDTjMyNHFsZ2Z6elYzc2hRajRIOFN6Nys1QjljdnhFVkhGckkw?=
 =?utf-8?B?c05xR1NRbndXSjFEK29Oclp1R1NBVXJvL29aYkdodjFkclVMakl3d2RKUEEy?=
 =?utf-8?B?b0VlK2xsOVNjTzZTSzRSTEQxeldjaVFsblU1RDdub0tSRWEvL2hwRTh4UDhM?=
 =?utf-8?B?eDk0OXYrNS9KUzlSUFNaSnIrUDBETjl4NUp3YWwvVmplMmxJd2Y1cEw1K05T?=
 =?utf-8?B?TldmczlIeWUvN2Ztb2xxZm9LYTU2T29SczBwbi9oRXF0L0srM3N2d1o4Z0E0?=
 =?utf-8?B?dGVNZUU0amJtOUdSTXpvNEIwaFlhSlQzZzkrTzE1eHdCUnNtUUx6UGoyVkVi?=
 =?utf-8?B?aWVQaXE1dkhzV05ERUhBRWRmSWZTTC9pci9JTUUzMTdjVkJjaGpHWWtGRzZx?=
 =?utf-8?B?bTRRa2VLL2RtQnhJVmpGTlhxLzAzU005V3NSWXg0TnVBK096YWVzYzFwZ1Rx?=
 =?utf-8?B?MmQ2L0JxdUJWMTRrTS8zN0tUdWpPamRZZ2FoNHhyejBpb1pObk1FOEdnY1hl?=
 =?utf-8?B?bmViSXcxNkJTY1FxOTVNOG00WkdsdXJOQll2M1BPU0d6dEx5TVU0LzF2TWx0?=
 =?utf-8?B?N01TUW1PSUtpdElQL0tyN1JzN2Jjb2VnT3JxUWNsUUkvTGpTVVU2aFFxRjBx?=
 =?utf-8?B?eG54am9DUS9GeGxnK0N4WFBMSXkyRkNwYVN0TDVFczdMVTJCcXNLNGh5Tmkv?=
 =?utf-8?B?dzZCQkRyeDZlNFVKanJDT2lWVnJvUm5Vd0dHMjREVFRCSE5ybTBXanpxdzBW?=
 =?utf-8?B?V2xBbTFzSW5FcVI5cXhlTE5EY1JIUk1QTlJoK0ZzSVlJaGdVc291aU9wZGNK?=
 =?utf-8?B?dWRpKzVNL2FpYm9OWkVSMGFodlVqdHlSU0pZYWJLT0NKRGJhL05OTjBqTkVN?=
 =?utf-8?B?NWcway8xZjlkTnVlMXVCTXNYYk5QbmZ4eEpYUTdyVGlKNldpOGc4cUlleHlk?=
 =?utf-8?B?MHZWMklTMXp5S21BQ1F3T05Wbm5jT2QraFNxdi92SHRQVjlDQ2NWU1BpVDNT?=
 =?utf-8?B?RXdzbGs4M1Bwb01lUklZQW5qZWc4K1NMczhNZFBLM0d4bzliRWVVOVZzQk55?=
 =?utf-8?B?RjcwU1VFYWl6bjBUMngvVHF2RHVMMEhNWVgxUVRGdExlR3l4VFcrWkpzNnpF?=
 =?utf-8?B?ZDFtTWdpR2pSMDU1T0k3Z0k2WWZSY3VTQVkwWmQ5TUxSL1F3YzNDVXRNcitB?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E29B44E61C07D84B87816AA2533B7021@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0390d0ad-d55a-46c3-2748-08dbc086afd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 00:54:51.0821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tO7aE/gS/3mYpkcQuGgnh+f79NrxDVhxBzn9xcChnUSdtV1pmySMAzFUhZYJIr/cNzgFLW5savXnJGfBFwft5Y+hNrZSo79fmn7M0Artoas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8348
X-Proofpoint-ORIG-GUID: GbocKuL_GaxUlRGoaMhGCIhk4HYOlHD-
X-Proofpoint-GUID: GbocKuL_GaxUlRGoaMhGCIhk4HYOlHD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_24,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gU2VwIDIyLCAyMDIzLCBhdCA3OjQ2IEFNLCBMaSBGZW5nIDxmZW5nbGlAc21hcnR4
LmNvbT4gd3JvdGU6DQo+IA0KPiBDdXJyZW50bHkgdGhlIGdldF9pbmZsaWdodF9mZCB3aWxsIGJl
IHNlbnQgZXZlcnkgdGltZSB0aGUgZGV2aWNlIGlzIHN0YXJ0ZWQsIGFuZA0KPiB0aGUgYmFja2Vu
ZCB3aWxsIGFsbG9jYXRlIHNoYXJlZCBtZW1vcnkgdG8gc2F2ZSB0aGUgaW5mbGlnaHQgc3RhdGUu
IElmIHRoZQ0KPiBiYWNrZW5kIGZpbmRzIHRoYXQgaXQgcmVjZWl2ZXMgdGhlIHNlY29uZCBnZXRf
aW5mbGlnaHRfZmQsIGl0IHdpbGwgcmVsZWFzZSB0aGUNCj4gcHJldmlvdXMgc2hhcmVkIG1lbW9y
eSwgd2hpY2ggYnJlYWtzIGluZmxpZ2h0IHdvcmtpbmcgbG9naWMuDQo+IA0KPiBUaGlzIHBhdGNo
IGlzIGEgcHJlcGFyYXRpb24gZm9yIHRoZSBmb2xsb3dpbmcgcGF0Y2hlcy4NCg0KVGhpcyBsb29r
cyBpZGVudGljYWwgdG8gdGhlIHYzIHBhdGNoIEkgcmV2aWV3ZWQ/IElmIEnigJl2ZSBtaXNzZWQg
c29tZXRoaW5nIGNhbiB5b3UgcGxlYXNlIHBvaW50IGl0IG91dD8NCg0KDQo+IFNpZ25lZC1vZmYt
Ynk6IExpIEZlbmcgPGZlbmdsaUBzbWFydHguY29tPg0KPiAtLS0NCj4gaHcvc2NzaS92aG9zdC1z
Y3NpLWNvbW1vbi5jIHwgMzcgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaHcvc2NzaS92aG9zdC1zY3NpLWNvbW1vbi5jIGIvaHcvc2NzaS92aG9z
dC1zY3NpLWNvbW1vbi5jDQo+IGluZGV4IGEwNmYwMWFmMjYuLmE2MWNkMGU5MDcgMTAwNjQ0DQo+
IC0tLSBhL2h3L3Njc2kvdmhvc3Qtc2NzaS1jb21tb24uYw0KPiArKysgYi9ody9zY3NpL3Zob3N0
LXNjc2ktY29tbW9uLmMNCj4gQEAgLTUyLDIwICs1MiwyOCBAQCBpbnQgdmhvc3Rfc2NzaV9jb21t
b25fc3RhcnQoVkhvc3RTQ1NJQ29tbW9uICp2c2MpDQo+IA0KPiAgICAgdnNjLT5kZXYuYWNrZWRf
ZmVhdHVyZXMgPSB2ZGV2LT5ndWVzdF9mZWF0dXJlczsNCj4gDQo+IC0gICAgYXNzZXJ0KHZzYy0+
aW5mbGlnaHQgPT0gTlVMTCk7DQo+IC0gICAgdnNjLT5pbmZsaWdodCA9IGdfbmV3MChzdHJ1Y3Qg
dmhvc3RfaW5mbGlnaHQsIDEpOw0KPiAtICAgIHJldCA9IHZob3N0X2Rldl9nZXRfaW5mbGlnaHQo
JnZzYy0+ZGV2LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnMtPmNvbmYu
dmlydHF1ZXVlX3NpemUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2c2Mt
PmluZmxpZ2h0KTsNCj4gKyAgICByZXQgPSB2aG9zdF9kZXZfcHJlcGFyZV9pbmZsaWdodCgmdnNj
LT5kZXYsIHZkZXYpOw0KPiAgICAgaWYgKHJldCA8IDApIHsNCj4gLSAgICAgICAgZXJyb3JfcmVw
b3J0KCJFcnJvciBnZXQgaW5mbGlnaHQ6ICVkIiwgLXJldCk7DQo+ICsgICAgICAgIGVycm9yX3Jl
cG9ydCgiRXJyb3Igc2V0dGluZyBpbmZsaWdodCBmb3JtYXQ6ICVkIiwgLXJldCk7DQo+ICAgICAg
ICAgZ290byBlcnJfZ3Vlc3Rfbm90aWZpZXJzOw0KPiAgICAgfQ0KPiANCj4gLSAgICByZXQgPSB2
aG9zdF9kZXZfc2V0X2luZmxpZ2h0KCZ2c2MtPmRldiwgdnNjLT5pbmZsaWdodCk7DQo+IC0gICAg
aWYgKHJldCA8IDApIHsNCj4gLSAgICAgICAgZXJyb3JfcmVwb3J0KCJFcnJvciBzZXQgaW5mbGln
aHQ6ICVkIiwgLXJldCk7DQo+IC0gICAgICAgIGdvdG8gZXJyX2d1ZXN0X25vdGlmaWVyczsNCj4g
KyAgICBpZiAodnNjLT5pbmZsaWdodCkgew0KPiArICAgICAgICBpZiAoIXZzYy0+aW5mbGlnaHQt
PmFkZHIpIHsNCj4gKyAgICAgICAgICAgIHJldCA9IHZob3N0X2Rldl9nZXRfaW5mbGlnaHQoJnZz
Yy0+ZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZzLT5j
b25mLnZpcnRxdWV1ZV9zaXplLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHZzYy0+aW5mbGlnaHQpOw0KPiArICAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4g
KyAgICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIkVycm9yIGdldHRpbmcgaW5mbGlnaHQ6ICVk
IiwgLXJldCk7DQo+ICsgICAgICAgICAgICAgICAgZ290byBlcnJfZ3Vlc3Rfbm90aWZpZXJzOw0K
PiArICAgICAgICAgICAgfQ0KPiArICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgcmV0ID0gdmhv
c3RfZGV2X3NldF9pbmZsaWdodCgmdnNjLT5kZXYsIHZzYy0+aW5mbGlnaHQpOw0KPiArICAgICAg
ICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJFcnJvciBzZXR0
aW5nIGluZmxpZ2h0OiAlZCIsIC1yZXQpOw0KPiArICAgICAgICAgICAgZ290byBlcnJfZ3Vlc3Rf
bm90aWZpZXJzOw0KPiArICAgICAgICB9DQo+ICAgICB9DQo+IA0KPiAgICAgcmV0ID0gdmhvc3Rf
ZGV2X3N0YXJ0KCZ2c2MtPmRldiwgdmRldiwgdHJ1ZSk7DQo+IEBAIC04NSw5ICs5Myw2IEBAIGlu
dCB2aG9zdF9zY3NpX2NvbW1vbl9zdGFydChWSG9zdFNDU0lDb21tb24gKnZzYykNCj4gICAgIHJl
dHVybiByZXQ7DQo+IA0KPiBlcnJfZ3Vlc3Rfbm90aWZpZXJzOg0KPiAtICAgIGdfZnJlZSh2c2Mt
PmluZmxpZ2h0KTsNCj4gLSAgICB2c2MtPmluZmxpZ2h0ID0gTlVMTDsNCj4gLQ0KPiAgICAgay0+
c2V0X2d1ZXN0X25vdGlmaWVycyhxYnVzLT5wYXJlbnQsIHZzYy0+ZGV2Lm52cXMsIGZhbHNlKTsN
Cj4gZXJyX2hvc3Rfbm90aWZpZXJzOg0KPiAgICAgdmhvc3RfZGV2X2Rpc2FibGVfbm90aWZpZXJz
KCZ2c2MtPmRldiwgdmRldik7DQo+IEBAIC0xMTEsMTIgKzExNiw2IEBAIHZvaWQgdmhvc3Rfc2Nz
aV9jb21tb25fc3RvcChWSG9zdFNDU0lDb21tb24gKnZzYykNCj4gICAgIH0NCj4gICAgIGFzc2Vy
dChyZXQgPj0gMCk7DQo+IA0KPiAtICAgIGlmICh2c2MtPmluZmxpZ2h0KSB7DQo+IC0gICAgICAg
IHZob3N0X2Rldl9mcmVlX2luZmxpZ2h0KHZzYy0+aW5mbGlnaHQpOw0KPiAtICAgICAgICBnX2Zy
ZWUodnNjLT5pbmZsaWdodCk7DQo+IC0gICAgICAgIHZzYy0+aW5mbGlnaHQgPSBOVUxMOw0KPiAt
ICAgIH0NCj4gLQ0KPiAgICAgdmhvc3RfZGV2X2Rpc2FibGVfbm90aWZpZXJzKCZ2c2MtPmRldiwg
dmRldik7DQo+IH0NCj4gDQo+IC0tIA0KPiAyLjQxLjANCj4gDQoNCg==

