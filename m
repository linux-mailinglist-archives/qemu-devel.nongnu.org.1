Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC875CA86
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:49:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrRh-0002ej-AE; Fri, 21 Jul 2023 10:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRf-0002eT-3Q
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRc-0004jg-B6
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:26 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36LBrkwg002308; Fri, 21 Jul 2023 07:49:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-type:content-id
 :content-transfer-encoding:mime-version; s=proofpoint20171006;
 bh=/Evv5V+WWG2T2oOTO5Wc4QFgvTOfT8VC7OyaY2z5CXo=; b=eYQBm+ZvUMbz
 5FkBux8WUmJCoIzGJaHSBV0xafvcPfOeCQtC09tVJXxYd7Fvp2QECi+HjRXEMHNl
 tBDb/Q7AO+PQdTu8rhbp1oy8nMscNh4hd2jWnMHQajH+40AiRzUJmJDA3n6ChGGo
 MgZUYOInhvsa241cv60suHnemRaNdjsk/+VKqoypUnclhJhwBv6np18jb+JE9o1P
 cNfiJyPNQ9uX9OKVOjAxWt6XfSBD5xFK+Ww+/0DZZlFYyEFxKj+bVVFgw/oCBsnW
 jForx8PAo2QQSZBUqayMJMG4v0tTI/QFE7BU6QBdf9bmuhRpB7gLKu4sfGpP0gqC
 eTAaMLUNpA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx3fmxgex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 07:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5r9Y4YKJ5LfncM01fwkaciApFjW/ygTlTT1QIUU2S/IUWpJ0ORkMhGVCJwTXmSkSBgUtviggaSxF4Hy2eHy/0wJgftuGzUNHU1H6Zf7t+xNKK039G1UPqPrNmbKA9HQLebkHGQ5c9B7I6fmc7LFHaD055jZdIxIdyGDiY/7pnrxqLKyfRGi2fLso7XrIgfKMg9N4nPvID8n83z1SZvFkTVtHWbHq0EyGepiz4l1/p42+YNZitDJLCLngyGaQ45X//tdRYEW0oeZXz2hp3FznXoaqsnhjhrOvHpjZ7R33EQSeRopDQmvx8Fi+VELXdaBe/+ojDm1fawsOAT4Gksu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Evv5V+WWG2T2oOTO5Wc4QFgvTOfT8VC7OyaY2z5CXo=;
 b=K7ChnV+oGWF0aOICRDwx/GqlkEeTHQBko15FiJHmFoJ7WGCRLo+16VU/eWNLZ/1zpirPFhbe01Oc5JRSu8rQ6nOeaoLwpQvKno9JMeFX7X5bM2iZcel7DgBQA3g1XbmuGu1Sm7kHyzWHLBWJlwCPIV81hAs88dUG+PZG0lMWRlaYZSm7Rr+IUg7DFSi09FTeVY+V1kQbLkkaaca2sjJ3+wuwq1eFhSzRsR4sQdqqlpnOVQ+zxaBHH2duR3f7BxPisEuuavAfVn4FTSI4DL+wAQWsyyUh9ZJg+CYi7VcOMIez4uuofhMgWgq4R+whfWmGv24NUhj4Ok529uEhPvSJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Evv5V+WWG2T2oOTO5Wc4QFgvTOfT8VC7OyaY2z5CXo=;
 b=kOKmwCa9e+odNXfAcDekjOfqQqdFZHLR8DWVrx0szuxT65VEWM+uiQePoTBlxE+j1RkXsdOj2HAZsFZJ6f1W+vjiI32AFKwUJqRyyAGB9M4Wd3zIEh2eW+pK/2lPxmrwcPCcGQXeJx8mgh5a+1Oh/QrOQcOQAP0Mlf6Cnt4qTWDCx+i3rrjdSEZBbM0k50ycf0Vyt+h1wqLdVuy5MBViOa+YWkHPaKRfw5GD+jEzyvXwZ53QKAX5GPUKHVvlS+8CA3Z6U6IjdhycuszPuI3Wy2zRZDIn30NKMDiXYWvMVmGJwAz/zK4McD2a2RjFgb9UGQThTHBOZO394erQ5Q5USw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA2PR02MB7561.namprd02.prod.outlook.com (2603:10b6:806:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 14:49:19 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 14:49:19 +0000
From: Het Gala <het.gala@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Prerna Saxena <prerna.saxena@nutanix.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v9 00/10] migration: Modify 'migrate' and 'migrate-incoming'
 QAPI commands for migration
Thread-Topic: [PATCH v9 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
Thread-Index: Adm74odMJpnQKwO+s02xoTRypXkLxg==
Date: Fri, 21 Jul 2023 14:49:19 +0000
Message-ID: <20230721144914.170991-1-het.gala@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PH0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::17) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4343:EE_|SA2PR02MB7561:EE_
x-ms-office365-filtering-correlation-id: 19c863b7-fedf-45c6-dd8e-08db89f9a9d1
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A1HyuKaDwE5YDgIIX3KsA5QwtcTb6HM3d6gh8V7ywIy8xiTBc1fjbIr8lzGNmcPIbO39dlE6H0d70Xxr8j3fRzAQBPZjtuVecN5r3Xd8b1QWt+WGbJG38F+SMQVZizGFQzc7ArVTrOOBi3KvewvOzos1SJs+87OKjetYsJZyG8Kvq2TzALTng55PFXSndQnMiIqBuK6rue8uHxoWos+TQ99Ixq8cvUZi3OdJJLK/MpD+wFw+A5Md0zhoqC7i646abMn19teHYXirP1jnczDfDvZbyPHiEO19nlgf7u0bkDydlsP/SKb0VmRdixB5i4KfcWCjpviUg0b7hfxbEcQTEA0mjTg5T2qry7A5/dkD4BuulAKuoD6UBPrM+l+7nvj6mGChw1dbyqs6Ku0VhV7CDnalAzN3zkvENaRzb+RRv2s+ZRaVjEidFSiz3xop+Hqvzul+Q8pETkzF8MfltcLiN1zH5l2A6KoiIY+73qm/7Ri5h8HxvsBkXe55PiRX8d8VxT2BzFv34krOB2cwoXGvqOYHnnQKQLf++zwXRjstyo9kypYfLEoOKj6MZ+L4gBkZbLALH8C/CiFy5+/GlfghSq4ncVORYGr0O13TXaVz5lTKZZqenqy4wEq/bdPWfKmIDII3W5ON+ACBRmF/evvl1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(2616005)(6486002)(52116002)(966005)(6512007)(71200400001)(478600001)(86362001)(26005)(1076003)(107886003)(6506007)(36756003)(5660300002)(4326008)(44832011)(6916009)(41300700001)(8936002)(8676002)(316002)(2906002)(122000001)(38100700002)(54906003)(64756008)(66476007)(66556008)(66446008)(66946007)(38350700002)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGxtQXl4TUhrWlJYbS90MytNL2JMRTZYK2VtclB0eXFhbW05WnU4cUpxd1RB?=
 =?utf-8?B?ZU5xK1hiNGc4SGFzNzAxMVNnQzFZeEh0ZFI3MWRiTDJEakR4Y3JRK0lkdmJi?=
 =?utf-8?B?c3VkOG5Qd3VJRTVQS3hmbUloakNIN1p0b0RBM2VJUFgrOEJjNllDbHZIT1Rn?=
 =?utf-8?B?Mk43Q3BsVDhHVzYxOWdFMXVnTGhGbUFoQ2Vrd2xINm51UndTN2JrRkdJbkhy?=
 =?utf-8?B?M1dVZlJTOVBtaVRpRjFtK1dwM044YWdPUkRuR1lHdXAxVzg5Y1J4SXFaWWQx?=
 =?utf-8?B?TnJzd01iaXdkZHlYdGRvSU5QUVdVSnFFWDlGNFV2WkdmN2RlaTFtZGZvcHZh?=
 =?utf-8?B?Ty82MERTZWhySTIzNUNxWjhIZ0hid0V1NnZ5dERacy95T2o3eXZlZkRsZDdP?=
 =?utf-8?B?UTVrQzBOblNuZmVleFJpR3B4T0lpaVBWeVRQYm9aUkZEYVpiQW9CTlZsYU1l?=
 =?utf-8?B?dXhtWGJhOFhzVTdONTdWYWNCYTRqYXdURFozTk1GYXI4eTYwWGRJODdsZGFO?=
 =?utf-8?B?WHVsWmdTK3MxcW1lUzZBcGJYM2g3ZnZnUVltdmNuRUFIYUl4Tk4zc21XZEQ1?=
 =?utf-8?B?TXhXdTNEcnhWb3MxazlPNlRjUG1qbFVwVEtWWlRVdXcxN3I1dkJDUjVjM1Vo?=
 =?utf-8?B?clZDR2dRQ0ZzcDc0REtMQ1dPcE5XdjRoSmlQR0dhSVpLNmtEYmxPa05mancw?=
 =?utf-8?B?NFRES2xCaGVTWDZRQ0tnaEh6N0IrT1M1Z0FZUUZZNmgyK0NWZ3hnc3ozd2Vt?=
 =?utf-8?B?anZzd3BQZFk1WXdwZDdRbERNRkJ0ZndqQS84KzdGQWp0bkV4dnpwRmUrOHY2?=
 =?utf-8?B?eUVjUWlsc2lhT25ycHlQZjMyN08wMCtuQzB3MDRZd1YxSGlkYTNTMjhNNjZm?=
 =?utf-8?B?MUo3UmVTYjFKQzRnditWdVU2RzRmamROVGxCaUhFelI0bHFISHRnWE9XODA4?=
 =?utf-8?B?elJ1U0ZlZnVmWkVQOWRrZGliRW94R1pjSWhoQ3l6UWMwdGxnd3ZrMHNkT2JS?=
 =?utf-8?B?MUliaUIwTm8rT0tDQml4bFFrTDJnZFh4RXFScXQ4aDZDUGRGS1VRWVVVcDZo?=
 =?utf-8?B?NEppQjVvVE1aQ2Z5N1NPSWpNUjVQNWVPNXQ5QkpVM1FLT1I3T2tGRzhPNGwv?=
 =?utf-8?B?bGV5VEtxeTBHL29ZSXZFbnlGcUZvc0pJQ3JYcXFIcVpJek5XRTJNbjgxVC9O?=
 =?utf-8?B?R0I5c2tmR2doQ3lLM2pBN1dWTXQxN3ZiQlZNMm4wWXlyNHlHc2UxNG5DaDRB?=
 =?utf-8?B?YU5PSXJjTnJncjVOVXE4cURlUDlYdTJCTE1yMDBXalpRU2tvOHZnSHVyL1JJ?=
 =?utf-8?B?aWJRQWsxYlVwRUdBbUpJd0JhVXBJZnB6K3hJU25oZlhMYkhZVmVtS0Zndktx?=
 =?utf-8?B?ZXFuNW8rRXU0Nndtc0hTVnAyMWF3eG15TS9GdDV1UEZHUDhnY3l4SmszNnhk?=
 =?utf-8?B?VVdnb2ZQenE0MkcrTHdRdmFpa1FBZ3Q1dXF4RWFYbEo2NC8rNVhFcytidERS?=
 =?utf-8?B?ekt1SHFTR2N5dVh4eVlwZ0xLOVp4MlFKbjVVWGtmQ2xEcWM5MWlEUjZIcHZQ?=
 =?utf-8?B?UlhuVFNLQ1RQZzY4T2NYR05VRjhieDUzaXNwTVFyOVFXQ05HSmZ5YnZqbDU0?=
 =?utf-8?B?bXNQdCtwUGxoTHMxYjhvOXFPQmRKTnQ1WjZHNHY0eDhkZ0Q0bGNMUXNMV0Zy?=
 =?utf-8?B?NmJKb2RUQ0tnVmlBRkVXQ3BuRm1rY251VVJjaE1TQnIrZ1dTRDJyUTJvYTJy?=
 =?utf-8?B?dVRjOWZ2cWhlZFkvQXdtem1sRmVRd1BWVHE0RERZL0dPMXdndlo3VkdwNDNz?=
 =?utf-8?B?b1VvSURjTXk4QlBCOGxZcmkvZXJQTXV2ZUlvaXdEdFlDL0lWVkNQdFhkTWJH?=
 =?utf-8?B?dHhmOVo2Zjc0U3U1ditxQ01vcUZLdlFzZXZtcm9oMU9Ya0Fnd3pBWGtuSHpO?=
 =?utf-8?B?QnZSQTREdlU1VWhTUEFJSGwzd1lsb2UyeFdDNC8yeGlaNUJKTVluamJ5WXNL?=
 =?utf-8?B?bUxuSU5JTFgzMDMraGw5MTZTaWdDT3JuK0cxc0NpSTFZenJYcDQ4c3JvNkRN?=
 =?utf-8?B?ZDh5aEloSmpZbEtjbEFOUTI4UE5OSTZobmI1emtiMml3WDZCT1ErcEljbnFB?=
 =?utf-8?B?TStCcjJqWCtQeHhDdEFnZVRqV1lRY2l2OXdETXFSdGl4VitoY0ZiVW1PZzNw?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A66623FB8444D4FAA747D826884EB68@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c863b7-fedf-45c6-dd8e-08db89f9a9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:49:19.1458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcs/BpW9z9/ZEe1W4Lpvd+cY1OqD3Q9XgoKY/pJREQptHwkcDGXz63U0ASvl7c1ly8giw4N+lur9o9EW1kM6qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7561
X-Proofpoint-ORIG-GUID: 019Anx_-X_8uVfMHPuXrz1tTvN_an-JD
X-Proofpoint-GUID: 019Anx_-X_8uVfMHPuXrz1tTvN_an-JD
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

VGhpcyBpcyB2OSBwYXRjaHNldCBvZiBtb2RpZmllZCAnbWlncmF0ZScgYW5kICdtaWdyYXRlLWlu
Y29taW5nJyBRQVBJIGRlc2lnbg0KZm9yIHVwc3RyZWFtIHJldmlldy4NCg0KV291bGQgbGlrZSB0
byB0aGFuayBhbGwgdGhlIG1haW50YWluZXJzIHRoYXQgYWN0aXZlbHkgcGFydGljaXBhdGVkIGlu
IHRoZSB2OA0KcGF0Y2hzZXQgZGlzY3Vzc2lvbiBhbmQgZ2F2ZSBpbnNpZ2h0ZnVsIHN1Z2dlc3Rp
b25zIHRvIGltcHJvdmUgdGhlIHBhdGNoZXMuDQoNCg0KTGluayB0byBwcmV2aW91cyB1cHN0cmVh
bSBjb21tdW5pdHkgcGF0Y2hzZXQgbGlua3M6DQp2MTogaHR0cHM6Ly9saXN0cy5nbnUub3JnL2Fy
Y2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjItMTIvbXNnMDQzMzkuaHRtbA0KdjI6IGh0dHBzOi8v
bGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIzLTAyL21zZzAyMTA2Lmh0
bWwNCnYzOiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAy
My0wMi9tc2cwMjQ3My5odG1sDQp2NDogaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRt
bC9xZW11LWRldmVsLzIwMjMtMDUvbXNnMDMwNjQuaHRtbA0KdjU6IGh0dHBzOi8vbGlzdHMuZ251
Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIzLTA1L21zZzA0ODQ1Lmh0bWwNCnY2OiBo
dHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMy0wNi9tc2cw
MTI1MS5odG1sDQp2NzogaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRl
dmVsLzIwMjMtMDcvbXNnMDIwMjcuaHRtbA0Kdjg6IGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNo
aXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIzLTA3L21zZzAyNzcwLmh0bWwNCg0KdjggLT4gdjkgY2hh
bmdlbG9nOg0KLS0tLS0tLS0tLS0tLS0tLS0tLQ0KLSBQYXRjaDEgOiBjaGFuZ2VkIHRoZSBxZW11
IHZlcnNpb24gZnJvbSB2OC4xIC0+IHY4LjIuDQotIFBhdGNoMiA6IGNoYW5nZXMgZm9yIFdJTjMy
IHJlZ2FyZGluZyBleGVjIGNvbW1hbmQuDQotIFBhdGNoNiA6IFNwbGl0IHFtcCBjaGFuZ2VzIGZy
b20gaG1wIGNoYW5nZXMgKFBhdGNoIDkpLg0KLSBQYXRjaDggOiBRQVBJX0NMT05FIG9mIFNvY2tl
dEFkZHJlc3MgZGVmaW5lZCBlYXJpbGVyIGluIFBhdGNoMy4NCi0gUGF0Y2g5IDogaW50cm9kdWNp
bmcgbWlncmF0ZSAnY2hhbm5lbHMnIGluIEhNUCwgYW5kIGNoYW5nZSBpbg0KICAgICAgICAgICBp
bXBsZW1lbnRhdGlvbiBmcm9tIGVhcmxpZXIgcGF0Y2guDQotIFBhdGNoMTAgOiBtb2RpZnkgZXhp
c3RpbmcgbWlncmF0aW9uIHRlc3QgY2FzZSB3aXRoIG5ldyBRQVBJIHN5bnRheA0KICAgICAgICAg
ICAgaW5zdGVhZCBvZiBhZGRpbmcgbmV3IHRlc3QgY2FzZSBhbGwgdG9nZXRoZXIuDQoNCkFic3Ry
YWN0Og0KLS0tLS0tLS0tDQoNCkN1cnJlbnQgUUFQSSAnbWlncmF0ZScgY29tbWFuZCBkZXNpZ24g
KGZvciBpbml0aWF0aW5nIGEgbWlncmF0aW9uDQpzdHJlYW0pIGNvbnRhaW5zIGluZm9ybWF0aW9u
IHJlZ2FyZGluZyBkaWZmZXJlbnQgbWlncmF0ZSB0cmFuc3BvcnQgbWVjaGFuaXNtDQoodGNwIC8g
dW5peCAvIGV4ZWMpLCBkZXN0LWhvc3QgSVAgYWRkcmVzcywgYW5kIGJpbmRpbmcgcG9ydCBudW1i
ZXIgaW4gZm9ybSBvZg0KYSBzdHJpbmcuIFRodXMgdGhlIGRlc2lnbiBkb2VzIHNlZW0gdG8gaGF2
ZSBzb21lIGRlc2lnbiBpc3N1ZXMuIFNvbWUgb2YgdGhlDQppc3N1ZXMsIHN0YXRlZCBiZWxvdyBh
cmU6DQoNCjEuIFVzZSBvZiBzdHJpbmcgVVJJcyBpcyBhIGRhdGEgZW5jb2Rpbmcgc2NoZW1lIHdp
dGhpbiBhIGRhdGEgZW5jb2Rpbmcgc2NoZW1lLg0KICAgUUVNVSBjb2RlIHNob3VsZCBkaXJlY3Rs
eSBiZSBhYmxlIHRvIHdvcmsgd2l0aCB0aGUgcmVzdWx0cyBmcm9tIFFBUEksDQogICB3aXRob3V0
IHJlc29ydGluZyB0byBkbyBhIHNlY29uZCBsZXZlbCBvZiBwYXJzaW5nIChlZy4gc29ja2V0X3Bh
cnNlKCkpLg0KMi4gRm9yIGZlYXR1cmVzIC8gcGFyYW1ldGVycyByZWxhdGVkIHRvIG1pZ3JhdGlv
biwgdGhlIG1pZ3JhdGlvbiB0dW5hYmxlcyBuZWVkcw0KICAgdG8gYmUgZGVmaW5lZCBhbmQgdXBk
YXRlZCB1cGZyb250LiBGb3IgZXhhbXBsZSwgJ21pZ3JhdGUtc2V0LWNhcGFiaWxpdHknDQogICBh
bmQgJ21pZ3JhdGUtc2V0LXBhcmFtZXRlcicgaXMgcmVxdWlyZWQgdG8gZW5hYmxlIG11bHRpZmQg
Y2FwYWJpbGl0eSBhbmQNCiAgIG11bHRpZmQtbnVtYmVyIG9mIGNoYW5uZWxzIHJlc3BlY3RpdmVs
eS4gSW5zdGVhZCwgJ011bHRpZmQtY2hhbm5lbHMnIGNhbg0KICAgZGlyZWN0bHkgYmUgcmVwcmVz
ZW50ZWQgYXMgYSBzaW5nbGUgYWRkaXRpb25hbCBwYXJhbWV0ZXIgdG8gJ21pZ3JhdGUnDQogICBR
QVBJLiAnbWlncmF0ZS1zZXQtY2FwYWJpbGl0eScgYW5kICdtaWdyYXRlLXNldC1wYXJhbWV0ZXIn
IGNvbW1hbmRzIGNvdWxkDQogICBiZSB1c2VkIGZvciBydW50aW1lIHR1bmFibGVzIHRoYXQgbmVl
ZCBzZXR0aW5nIGFmdGVyIG1pZ3JhdGlvbiBoYXMgYWxyZWFkeQ0KICAgc3RhcnRlZC4NCg0KVGhl
IGN1cnJlbnQgcGF0Y2hzZXQgZm9jdXNlcyBvbiBzb2x2aW5nIHRoZSBmaXJzdCBwcm9ibGVtIG9m
IG11bHRpLWxldmVsDQplbmNvZGluZyBvZiBVUklzLiBUaGUgcGF0Y2ggZGVmaW5lcyAnbWlncmF0
ZScgY29tbWFuZCBhcyBhIFFBUEkgZGlzY3JpbWluYXRlZA0KdW5pb24gZm9yIHRoZSB2YXJpb3Vz
IHRyYW5zcG9ydCBiYWNrZW5kcyAobGlrZSBzb2NrZXQsIGV4ZWMgYW5kIHJkbWEpLCBhbmQgb24N
CmJhc2lzIG9mIHRyYW5zcG9ydCBiYWNrZW5kcywgZGlmZmVyZW50IG1pZ3JhdGlvbiBwYXJhbWV0
ZXJzIGFyZSBkZWZpbmVkLg0KDQoodXJpKSBzdHJpbmcgLS0+ICAoY2hhbm5lbCkgQ2hhbm5lbC10
eXBlDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgVHJhbnNwb3J0LXR5cGUNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBNaWdyYXRpb24gcGFyYW1ldGVycyBiYXNlZCBvbiB0cmFuc3Bv
cnQgdHlwZQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkhldCBHYWxhICgxMCk6DQogIG1pZ3Jh
dGlvbjogTmV3IFFBUEkgdHlwZSAnTWlncmF0ZUFkZHJlc3MnDQogIG1pZ3JhdGlvbjogY29udmVy
dCBtaWdyYXRpb24gJ3VyaScgaW50byAnTWlncmF0ZUFkZHJlc3MnDQogIG1pZ3JhdGlvbjogY29u
dmVydCBzb2NrZXQgYmFja2VuZCB0byBhY2NlcHQgTWlncmF0ZUFkZHJlc3MNCiAgbWlncmF0aW9u
OiBjb252ZXJ0IHJkbWEgYmFja2VuZCB0byBhY2NlcHQgTWlncmF0ZUFkZHJlc3MNCiAgbWlncmF0
aW9uOiBjb252ZXJ0IGV4ZWMgYmFja2VuZCB0byBhY2NlcHQgTWlncmF0ZUFkZHJlc3MuDQogIG1p
Z3JhdGlvbjogTmV3IG1pZ3JhdGUgYW5kIG1pZ3JhdGUtaW5jb21pbmcgYXJndW1lbnQgJ2NoYW5u
ZWxzJw0KICBtaWdyYXRpb246IG1vZGlmeSBtaWdyYXRpb25fY2hhbm5lbHNfYW5kX3VyaV9jb21w
YXRpYmxlKCkgZm9yIG5ldyBRQVBJDQogICAgc3ludGF4DQogIG1pZ3JhdGlvbjogSW1wbGVtZW50
IE1pZ3JhdGVDaGFubmVsTGlzdCB0byBxbXAgbWlncmF0aW9uIGZsb3cuDQogIG1pZ3JhdGlvbjog
SW1wbGVtZW50IE1pZ3JhdGVDaGFubmVsTGlzdCB0byBobXAgbWlncmF0aW9uIGZsb3cuDQogIG1p
Z3JhdGlvbjogbW9kaWZ5IHRlc3RfbXVsdGlmZF90Y3Bfbm9uZSgpIHRvIHVzZSBuZXcgUUFQSSBz
eW50YXguDQoNCiBtaWdyYXRpb24vZXhlYy5jICAgICAgICAgICAgICAgfCAgNzIgKysrKysrKysr
LS0tLQ0KIG1pZ3JhdGlvbi9leGVjLmggICAgICAgICAgICAgICB8ICAgOCArLQ0KIG1pZ3JhdGlv
bi9taWdyYXRpb24taG1wLWNtZHMuYyB8ICAxOCArKystDQogbWlncmF0aW9uL21pZ3JhdGlvbi5j
ICAgICAgICAgIHwgMTgyICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KIG1pZ3Jh
dGlvbi9taWdyYXRpb24uaCAgICAgICAgICB8ICAgMyArLQ0KIG1pZ3JhdGlvbi9yZG1hLmMgICAg
ICAgICAgICAgICB8ICAzNCArKystLS0NCiBtaWdyYXRpb24vcmRtYS5oICAgICAgICAgICAgICAg
fCAgIDYgKy0NCiBtaWdyYXRpb24vc29ja2V0LmMgICAgICAgICAgICAgfCAgMzkgKystLS0tLQ0K
IG1pZ3JhdGlvbi9zb2NrZXQuaCAgICAgICAgICAgICB8ICAgNyArLQ0KIHFhcGkvbWlncmF0aW9u
Lmpzb24gICAgICAgICAgICB8IDE1MCArKysrKysrKysrKysrKysrKysrKysrKysrKy0NCiBzb2Z0
bW11L3ZsLmMgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiB0ZXN0cy9xdGVzdC9taWdyYXRp
b24tdGVzdC5jICAgfCAgIDcgKy0NCiAxMiBmaWxlcyBjaGFuZ2VkLCA0MDEgaW5zZXJ0aW9ucygr
KSwgMTI3IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjIuMw0KDQo=

