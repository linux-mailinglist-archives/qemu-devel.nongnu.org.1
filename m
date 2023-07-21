Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264475CA95
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:50:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrSL-0003R0-Dk; Fri, 21 Jul 2023 10:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRu-0003CB-3e
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRs-0004oO-6X
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:41 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36LDgFEB003513; Fri, 21 Jul 2023 07:49:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=QuamT8b2m+DSk95YHQXf68ZBLIgCfdfVMMoJRmVec
 vg=; b=pmJfR41fqDFERMihA0+QkLFx+sksO2GfEsYmbGyJqNpd/jGoU+NoD7hrA
 C8/gM0F2iqdlHgvX/1wwbO94E/KTtq9lVGQBqBzMoKY6UrrhHr75OcQMN1+sBGBp
 sI7ANnGwo3gCkCKtVaetu1eYVcuhZWE8JBquE6FbFQAtTTXEGzGKDaZom3JZFB0z
 doAmaDdRZL/zKBtyGcQVV4tZ16gTfRz4DiINRBVuz5IkvYyp4C1HFv6Xl7JYNfAN
 z+PHHfTOHf1AMuRrGH/luEjJ+luvds2o/9gNXmz0LwiuwZWNIfsQ7baLZDbCexUw
 FoTHJEva2AWeUkY/yogSCmDX3rfuQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx2wn73f8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 07:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKJzP6IbLoxWD7aCYATAL5pysTqxvo/D2L4pH0CVoCtro9YPSHyH5vWKM2TwdPmhXk+P7HfIyShWqlS7fnnK96m79MATYFqdC0asapNSRhJiqeeifnYcJaCwfQ30NU1XGDyjhGI7ZjzLskyy0XcQWAlm9IV2rGS/ltbGw8C2r4yNBxDi2k1QWck7V8Rw+FgJpxVtw0Pb/iYmLCJsQFiZiXhqTGpNp7eiAkvyQRIIeo8nIurBUbzvFDLI3ZIFlOwa3FYUk2gnnti8lBokn42i3Hg0LrubF2JZAsFyf6b3bISAC7tbILKKtIlrpWAV5lCZSkXW7KEzvlPWhm1iJMXbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuamT8b2m+DSk95YHQXf68ZBLIgCfdfVMMoJRmVecvg=;
 b=GtVHXWio0ojt2y9GabBydyPZSuy/k8ett0jWdTs+lTQOajL6q7i7FwsgCEhahpbsKZewAxF0VDdM7Q4Bb/LQS3NQB5A2uwUpb+glncvWTOAWb0oHktElZZUFQwL3FfPbwWXcxgH69PDrD1voaFire97PXgIKaZ8gnHTFo5gUJA2fx/0SL9beeiC1QfQeBXWRfddCWHWzKA8OoSxINneemNgIbiklfTO3AM3lvHVErJo0lhjaim5dwmO+z2zTK6hfYM4qHzm8iCTfbMt18qw1O4J3GKiALc9R4NYjyT4WijN8iFuPTAwGZ/gV10HdOv0i3OBXM7W116AlBFvwirXH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuamT8b2m+DSk95YHQXf68ZBLIgCfdfVMMoJRmVecvg=;
 b=Jdq0g0O/XxT6qfDVUcCygbxllA0Uxvz8v/9HK0H24ZdQujHtDJZCsrZuZjs0qQuXjlvunDqU1e/JQV6nYjLjnlOV2o1b3ACNlF1gupkyystdqQsexn7TZBgNkocjpP72pf7ipF/P1tYwIrt96KNGv+g/I43Ws4qjnqk8leIKLA3wGjh2hrmHw/gXVRzO69LMPHr/eoKubGdPp1FckXfFmh6r9fHAThAen3oKh9SeStrKwqknAKzT8F+gR9kDHBUT+u/y2/AzWScL0501LyACOFpm2uoVyXPoD3l7Umxf9nmpD9/aJ8kSFkstEUq4e1V2h/RVJ9EaBQDS/MVR1qikvg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by BL3PR02MB8020.namprd02.prod.outlook.com (2603:10b6:208:35b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16; Fri, 21 Jul
 2023 14:49:35 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 14:49:35 +0000
From: Het Gala <het.gala@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Prerna Saxena <prerna.saxena@nutanix.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v9 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Thread-Topic: [PATCH v9 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Thread-Index: Adm74pENx+Hg9MV+v0CyZYjqfF2pSw==
Date: Fri, 21 Jul 2023 14:49:35 +0000
Message-ID: <20230721144914.170991-10-het.gala@nutanix.com>
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
x-ms-traffictypediagnostic: BYAPR02MB4343:EE_|BL3PR02MB8020:EE_
x-ms-office365-filtering-correlation-id: d5524c9c-e3c0-4ae2-6482-08db89f9b388
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUjHy91hg6n6gI/P3SpEQ5H66szWayYy5OtS6jQcFCkm/tuxUtyi9bCHTfHZtlFGDmj6Nh60aYm1b2tgBS0BLI0onuxPyAKxxxNvtx8BI9ZvXU3AfYBqXXGQ41fU9NTxIeTLWbt/LSFwgr3pEsWo+tiHzYbSWOaAvJdYjBncV9igitLFcffcf+5ijVjn7Ktx+8Cys4Mcf7rMAuAIZckWYeulhuXiI9iYx8idK2hwmx326hDqAY4v71rG8nFDKdcbn/2pWFTrbKfHkPr1E7L4QXSQD3RpnS0/TdiwtY33ouFf7sHn0Ow0b9Y/CpIOFzcLniZw1gi0kEuzBzoA3DSIFxImh03N/OUmjL71O44eVLDZ+DC1+6ouulrjtiHcawnyLnepqZwcRlkiZYCo7NcvyVEcEPYd7QBFN7w6pKhkbgfKkm9LoxBYYCwGxWD92bQagdmtFe8opErBddQMb3gVVe3ccQXOimMH7sWIiPOzMDLukC/KBzIKFcAnxmywwmvn4Tjxgdv8TtoDeOdurpmy9EuEtKVrq6ajeCNckdTZHVaWc4UoKeX65dDNhSGT5+0C7C6eyqFaHsrgcN9q/xIVjM6HKsKzYc5XqGEHS4SHBws+BohkHSxqdZsT46aCPJReN0uTOt+jX7zOAEijVvaXwg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(6512007)(1076003)(122000001)(38350700002)(38100700002)(83380400001)(186003)(2616005)(6506007)(26005)(107886003)(44832011)(2906002)(8676002)(8936002)(5660300002)(71200400001)(36756003)(6486002)(478600001)(316002)(52116002)(64756008)(66446008)(4326008)(6916009)(41300700001)(54906003)(66476007)(66556008)(86362001)(66946007)(66899021)(309714004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEtXbUxzS2NTeldRd0xmbFJFeFpaVDhFeHBYUGNwVUtPS3pHSnN2b2l6V0pi?=
 =?utf-8?B?ZTY0N2Mzd3RJaWlGMGY3ZkVOeWV0OWVUU2VSWmNhaEM1b2lQbWx0dWIzTzN6?=
 =?utf-8?B?b1gvT2UvQTgxUHFpc2IwZDU5UkxuZllBaHBwSk04OVlzVVZZWGcwbUh0K0Fl?=
 =?utf-8?B?UnhNVmtXb0VWSDRZNmlwVzJ1MzhkdXpXNWNzOG9FUHJYQ2l1bHN2UWRjL0Zt?=
 =?utf-8?B?MGtiUjRkNGRTS0RwNVdGWEtnV0oyM3h0MFpHRURJNS9wYWR0cnlmVWpnZ3VG?=
 =?utf-8?B?aGFGOFdjbG5ERm4yUTF2VFZqbUxvNi9jQkhGQ1A3NFU5Q2x2VFJET211WHZB?=
 =?utf-8?B?MjEwaFNaVTFjUWVxVVYxVkJ0dWptMytvTzUva00rVVBXVW9rVTB3QlBXTHlm?=
 =?utf-8?B?TEg0NXlhK1phY25ORGhObkk0ei9jL3ZVMy9zVEZqZDl0dWZBWUtSWDg2Y3U3?=
 =?utf-8?B?ZVZjc3BWVTFFM0VjeVRQYkZHRDNpencxUHhkdmc0MGV4NWszYmtlYjVmRFh4?=
 =?utf-8?B?TFF0Zm5kVDBHeU1iWXh6TVBvTmdyMzhSUUNQVWpMZ25EWEpnVVhRWm1YWVp6?=
 =?utf-8?B?L1lDYzFnMWcxRFREcnZaM2swL0RwTDUrZjk1WjNmWmtXTmthR3I0dWpibWdW?=
 =?utf-8?B?RzR2V3oxZCtWZXhYLzJKMzZaS3A4R3Z6b2JvLzRFOUhVWkRDektGZ2puNnBZ?=
 =?utf-8?B?S0pHR0pUaTlETE9zVG8vOHlxRGp2cE5NOVkzYlNCa1NvVG8zaWpTS1NyQmJP?=
 =?utf-8?B?NVIrZmtqajJ2dFV2R09UYTBPaDZ2L0c4VkZXK1oxU2xLRkNNSnRPemMxbjVH?=
 =?utf-8?B?TzJ6Sjg0eUlHelFRRXBwNm95Zng1dUgzQVg5TXI5SjBjZnZNTVQ4Zk5VY0pm?=
 =?utf-8?B?K0F2dDFUdVRIemhJKzViMmQ4czRacUpzZXhRc2RVZHB3MmV6OVpveXBxTC91?=
 =?utf-8?B?WDZXQkcyQmlzOFpmODVDcDlFdHNkZTk0SXVxdXFHN2VPRDhHbXpYdGUwaFNI?=
 =?utf-8?B?WDBjMXYzUHRjTUZPNjRIQjRyZjhveHNmWkdwdEJpMlR2RE85OTdoNWRpWjBu?=
 =?utf-8?B?ajE3RHNRa1UzRmNtWXR4Y1dZWTFka01OakthbjJDSGV4d0RJTjBOZVZTMThp?=
 =?utf-8?B?ZytZTjdRK05QYy9XY2dsTGxLT0JyZ0ErUWJ4dFBaY0ZDUmYvK01mU2FJU2ln?=
 =?utf-8?B?S1RnenlnZDNzRmlGS1VyVmFDZTd5aUZjSGlWRW5ROWNZbE9hRmtTa3dmclNK?=
 =?utf-8?B?REhkdi8vc2NKUzliVndpeFVJbi9MQmR3aHlkM0dLZUt3M1ZXRWVuS3ZpcHFV?=
 =?utf-8?B?cG1sTlJSRVpiNkNJdktreWN0Qyt2UmdpNnBEUm5JRzFsdGlYSkNlaFBXVWV4?=
 =?utf-8?B?clNza3pkUmloS3lXNXA5cG41Z3hwMU5JZisrMmhBM3dWeFRGR3JqYWdVc0Fo?=
 =?utf-8?B?ZndBZ1JINldSL3BOYStvNkVGM2ErZHBRR05xQTJNMDVGQjRvakZ6eW4xczNZ?=
 =?utf-8?B?S2VDVHpLdnV0MkVxMTRZcUFHaXJUNEY0bEQ1Z3Raand6aHhNcW9Dakwybzg5?=
 =?utf-8?B?bGNVUTB6RlRLK1daK09tNHVTOW9DSTlQN1dWQ0VHRHRxSHc3VG4zY3QwblZa?=
 =?utf-8?B?YUc2N1JmRCtOTDM5MytsanFMbGN3QnVMMVRmbytZSmY3U2x5SHV1S05DcEth?=
 =?utf-8?B?ZnJ5K0NQZlo1cFZHZENvT0o1V3l3NUMxbm00RVV6Y0gxd2xYM3dESXp1UmpY?=
 =?utf-8?B?ZVNWRDdxeVRvWE9XZlVlQ0pYRk1BOEo2TUx3bXdBV3JONitaQnR6czYwdnJE?=
 =?utf-8?B?SUdRc29FazlIc05lcEx6SjdBQm5nYkZMb2lrckthRTlWN0pydTBneTBOWko5?=
 =?utf-8?B?ZTh2ell0bGt2WGh1bmYrL3AybFlhZ1lZSk4rSmJXbXZqUW1jNkR5WlpCcnJH?=
 =?utf-8?B?dmxHc3liTXc2YlJxZkdDNWlVOWN2UzZCS0JxWUxsenY2S0xLYmo3dDhmOEVD?=
 =?utf-8?B?VFppOHdVa2hwOGZKU3hLZ08rb2o1VXU4TXBUZm5PdnFVWGdSRnJuaW9ZRTRG?=
 =?utf-8?B?b0ZnT01ZUTJGMlZxRWp1d04ybytIN29PcHFkM1BrZ3VvZkpjdXA4a2NFL2wr?=
 =?utf-8?B?QzlLZlNwdkQ2R3dHb0w4RndsWWx5azNUMTI0Z3VaeHYvemlIT2szbnZ1TVU1?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5524c9c-e3c0-4ae2-6482-08db89f9b388
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:49:35.4866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZFVKhmyJoOvofFGPWmbN6W78TiGNd3haj/8gPSqVwb8zegOlA7Lfi9Mfd4vMbI6Rd1PIjYRid+jgFhs+e5HxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8020
X-Proofpoint-GUID: 0DuSJfWA-2F6nWDoDR23iZCwA5HI2udN
X-Proofpoint-ORIG-GUID: 0DuSJfWA-2F6nWDoDR23iZCwA5HI2udN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
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

SW50ZWdyYXRlIE1pZ3JhdGVDaGFubmVsTGlzdCB3aXRoIGFsbCB0cmFuc3BvcnQgYmFja2VuZHMN
Cihzb2NrZXQsIGV4ZWMgYW5kIHJkbWEpIGZvciBib3RoIHNyYyBhbmQgZGVzdCBtaWdyYXRpb24N
CmVuZHBvaW50cyBmb3IgaG1wIG1pZ3JhdGlvbi4NCg0KU3VnZ2VzdGVkLWJ5OiBBcmF2aW5kIFJl
dG5ha2FyYW4gPGFyYXZpbmQucmV0bmFrYXJhbkBudXRhbml4LmNvbT4NClNpZ25lZC1vZmYtYnk6
IEhldCBHYWxhIDxoZXQuZ2FsYUBudXRhbml4LmNvbT4NCi0tLQ0KIG1pZ3JhdGlvbi9taWdyYXRp
b24taG1wLWNtZHMuYyB8IDE2ICsrKysrKysrKysrKystLS0NCiBtaWdyYXRpb24vbWlncmF0aW9u
LmMgICAgICAgICAgfCAgNSArKy0tLQ0KIG1pZ3JhdGlvbi9taWdyYXRpb24uaCAgICAgICAgICB8
ICAzICsrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9taWdyYXRpb24taG1wLWNtZHMuYyBiL21pZ3Jh
dGlvbi9taWdyYXRpb24taG1wLWNtZHMuYw0KaW5kZXggNDliMTUwZjMzZi4uMjVmNTFlYzk5YyAx
MDA2NDQNCi0tLSBhL21pZ3JhdGlvbi9taWdyYXRpb24taG1wLWNtZHMuYw0KKysrIGIvbWlncmF0
aW9uL21pZ3JhdGlvbi1obXAtY21kcy5jDQpAQCAtNDIzLDEwICs0MjMsMTQgQEAgdm9pZCBobXBf
bWlncmF0ZV9pbmNvbWluZyhNb25pdG9yICptb24sIGNvbnN0IFFEaWN0ICpxZGljdCkNCiB7DQog
ICAgIEVycm9yICplcnIgPSBOVUxMOw0KICAgICBjb25zdCBjaGFyICp1cmkgPSBxZGljdF9nZXRf
c3RyKHFkaWN0LCAidXJpIik7DQorICAgIE1pZ3JhdGlvbkNoYW5uZWxMaXN0ICpjYXBzID0gTlVM
TDsNCisgICAgZ19hdXRvcHRyKE1pZ3JhdGlvbkNoYW5uZWwpIGNoYW5uZWwgPSBnX25ldzAoTWln
cmF0aW9uQ2hhbm5lbCwgMSk7DQogDQotICAgIHFtcF9taWdyYXRlX2luY29taW5nKHVyaSwgZmFs
c2UsIE5VTEwsICZlcnIpOw0KKyAgICBtaWdyYXRlX3VyaV9wYXJzZSh1cmksICZjaGFubmVsLCAm
ZXJyKTsNCisgICAgUUFQSV9MSVNUX1BSRVBFTkQoY2FwcywgY2hhbm5lbCk7DQogDQotICAgIGht
cF9oYW5kbGVfZXJyb3IobW9uLCBlcnIpOw0KKyAgICBxbXBfbWlncmF0ZV9pbmNvbWluZyhOVUxM
LCB0cnVlLCBjYXBzLCAmZXJyKTsNCisgICAgcWFwaV9mcmVlX01pZ3JhdGlvbkNoYW5uZWxMaXN0
KGNhcHMpOw0KIH0NCiANCiB2b2lkIGhtcF9taWdyYXRlX3JlY292ZXIoTW9uaXRvciAqbW9uLCBj
b25zdCBRRGljdCAqcWRpY3QpDQpAQCAtNzA0LDkgKzcwOCwxNSBAQCB2b2lkIGhtcF9taWdyYXRl
KE1vbml0b3IgKm1vbiwgY29uc3QgUURpY3QgKnFkaWN0KQ0KICAgICBib29sIHJlc3VtZSA9IHFk
aWN0X2dldF90cnlfYm9vbChxZGljdCwgInJlc3VtZSIsIGZhbHNlKTsNCiAgICAgY29uc3QgY2hh
ciAqdXJpID0gcWRpY3RfZ2V0X3N0cihxZGljdCwgInVyaSIpOw0KICAgICBFcnJvciAqZXJyID0g
TlVMTDsNCisgICAgTWlncmF0aW9uQ2hhbm5lbExpc3QgKmNhcHMgPSBOVUxMOw0KKyAgICBnX2F1
dG9wdHIoTWlncmF0aW9uQ2hhbm5lbCkgY2hhbm5lbCA9IGdfbmV3MChNaWdyYXRpb25DaGFubmVs
LCAxKTsNCisNCisgICAgbWlncmF0ZV91cmlfcGFyc2UodXJpLCAmY2hhbm5lbCwgJmVycik7DQor
ICAgIFFBUElfTElTVF9QUkVQRU5EKGNhcHMsIGNoYW5uZWwpOw0KIA0KLSAgICBxbXBfbWlncmF0
ZSh1cmksIGZhbHNlLCBOVUxMLCAhIWJsaywgYmxrLCAhIWluYywgaW5jLA0KKyAgICBxbXBfbWln
cmF0ZShOVUxMLCB0cnVlLCBjYXBzLCAhIWJsaywgYmxrLCAhIWluYywgaW5jLA0KICAgICAgICAg
ICAgICAgICAgZmFsc2UsIGZhbHNlLCB0cnVlLCByZXN1bWUsICZlcnIpOw0KKyAgICBxYXBpX2Zy
ZWVfTWlncmF0aW9uQ2hhbm5lbExpc3QoY2Fwcyk7DQogICAgIGlmIChobXBfaGFuZGxlX2Vycm9y
KG1vbiwgZXJyKSkgew0KICAgICAgICAgcmV0dXJuOw0KICAgICB9DQpkaWZmIC0tZ2l0IGEvbWln
cmF0aW9uL21pZ3JhdGlvbi5jIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQppbmRleCBhY2Y4MGIz
NTkwLi5jZjA2M2E3NmRmIDEwMDY0NA0KLS0tIGEvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQorKysg
Yi9taWdyYXRpb24vbWlncmF0aW9uLmMNCkBAIC00MjUsOSArNDI1LDggQEAgdm9pZCBtaWdyYXRl
X2FkZF9hZGRyZXNzKFNvY2tldEFkZHJlc3MgKmFkZHJlc3MpDQogICAgICAgICAgICAgICAgICAg
ICAgIFFBUElfQ0xPTkUoU29ja2V0QWRkcmVzcywgYWRkcmVzcykpOw0KIH0NCiANCi1zdGF0aWMg
Ym9vbCBtaWdyYXRlX3VyaV9wYXJzZShjb25zdCBjaGFyICp1cmksDQotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgTWlncmF0aW9uQ2hhbm5lbCAqKmNoYW5uZWwsDQotICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KK2Jvb2wgbWlncmF0ZV91cmlfcGFyc2Uo
Y29uc3QgY2hhciAqdXJpLCBNaWdyYXRpb25DaGFubmVsICoqY2hhbm5lbCwNCisgICAgICAgICAg
ICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCiB7DQogICAgIGdfYXV0b3B0cihNaWdyYXRpb25D
aGFubmVsKSB2YWwgPSBnX25ldzAoTWlncmF0aW9uQ2hhbm5lbCwgMSk7DQogICAgIGdfYXV0b3B0
cihNaWdyYXRpb25BZGRyZXNzKSBhZGRyID0gZ19uZXcwKE1pZ3JhdGlvbkFkZHJlc3MsIDEpOw0K
ZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9taWdyYXRpb24uaCBiL21pZ3JhdGlvbi9taWdyYXRpb24u
aA0KaW5kZXggYjdjOGI2NzU0Mi4uYTgyNjgzOTRjYSAxMDA2NDQNCi0tLSBhL21pZ3JhdGlvbi9t
aWdyYXRpb24uaA0KKysrIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5oDQpAQCAtNTAxLDcgKzUwMSw4
IEBAIGJvb2wgY2hlY2tfZGlydHlfYml0bWFwX21pZ19hbGlhc19tYXAoY29uc3QgQml0bWFwTWln
cmF0aW9uTm9kZUFsaWFzTGlzdCAqYmJtLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKTsNCiANCiB2b2lkIG1pZ3JhdGVfYWRkX2FkZHJlc3MoU29j
a2V0QWRkcmVzcyAqYWRkcmVzcyk7DQotDQorYm9vbCBtaWdyYXRlX3VyaV9wYXJzZShjb25zdCBj
aGFyICp1cmksIE1pZ3JhdGlvbkNoYW5uZWwgKipjaGFubmVsLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgRXJyb3IgKiplcnJwKTsNCiBpbnQgZm9yZWFjaF9ub3RfaWdub3JlZF9ibG9jayhSQU1C
bG9ja0l0ZXJGdW5jIGZ1bmMsIHZvaWQgKm9wYXF1ZSk7DQogDQogI2RlZmluZSBxZW11X3JhbV9m
b3JlYWNoX2Jsb2NrIFwNCi0tIA0KMi4yMi4zDQoNCg==

