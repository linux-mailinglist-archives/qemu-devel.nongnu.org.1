Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7207830F5
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 21:34:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYAe1-00088c-30; Mon, 21 Aug 2023 15:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=159767b703=lesikigor@meta.com>)
 id 1qYAdq-00088N-1Z
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 15:32:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=159767b703=lesikigor@meta.com>)
 id 1qYAdm-0004FF-8Y
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 15:32:45 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37LJ9t4d016650
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 12:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=6Ua8zCmAApXp44uv/2AEMd2nrg5PG5V8QaPpnpVvaV0=;
 b=Ocht+42VlznDG/PvWOD/P3xUTPD79y3yfBWnbk2YolQI30Uu44PQ2DzimpYSrqDV59Hn
 CKRf+fv756Y9Fll38XTI9AuTUY61ezWmJ75rpBqrVCYOArph1RuO7G2r1uXweC6nH59d
 /7fvQDyzibzImbcS4Fap74R/FqncrMQAzqo9cGPlBaZdudezipSKJLCXCRe4FUEJlNr3
 SYfFLHxPP9gaa/BiUQrqYlpYn+U4dFZomjy2py0MA9ZUZBxCFwCch0+PY8O6X+b/U+op
 4mDMHYWmyhexfcJS9CVT125OrimsReSyc2+V0CxGw861En0QUPfEIDLrmcGAzZaZAMjt yA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sjujxxmkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 12:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdAi6HIS485HfM9apA33wTJCui10G6L7aF1E7uCbWbvw/HPptT59XIp1neVfLoFkAwecA5ofpzpnsoAqbiU9fvZdh1CcYerQkLfYlUN0E2PHR11gHy5Xxgxos8o15NydfNTF3qTJLmXUx6EZk6s/vXdFY+wAvs0zL5Y5nnYNOshFWmn85mX/XwjgbfHXfG4S93xjt1CwqnX9rtTzIIZiGuPkR44AB7vskCzknFYLu+Cd3phviAtlqtyX1oddM6FvEJbx4W2Te49aYRYhLBN6FHI/lkZdsqQ9rE0Y4zRrbKoxj/vr/lpOzyrqGX82i1X+mD0hWXuluWe9UJNlS0WsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ua8zCmAApXp44uv/2AEMd2nrg5PG5V8QaPpnpVvaV0=;
 b=L1KgLL3LL/QbAUAfe4gjIGxU/P/Fvbwva4rxnatC5QqnpV12dqn2R0pUsAzbMLuVFlGjs8MSx8X5Wu5a46dFVlF3WFiwzuFKqkAEiXoEsYXDbuNg9gZOhTcP5mGbYLHD3Xf3ITcvRrdPulBGEIWlZYIZyDxWZIscu8NF0FMO7B20WZDw7tZxLLuaUXlTt72+yvYsVGijO9h8R7+yXFDVKsXd3JrrglIpoPnmawzT02+MF1lsxyLYAJv1Ob8Buy0T2xEEzNW+I56hvkdb+XGdSz03t9FoDBy+oVj2AhwA//yZPgmIiceAlhlf16TDKbbzyOyPXNtktpiZYSk4TN8SWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN7PR15MB6086.namprd15.prod.outlook.com (2603:10b6:806:2ea::20)
 by DS0PR15MB5494.namprd15.prod.outlook.com (2603:10b6:8:c5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Mon, 21 Aug 2023 19:32:33 +0000
Received: from SN7PR15MB6086.namprd15.prod.outlook.com
 ([fe80::939f:246:ceed:c9a]) by SN7PR15MB6086.namprd15.prod.outlook.com
 ([fe80::939f:246:ceed:c9a%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 19:32:33 +0000
From: Igor Lesik <lesikigor@meta.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: trace_exec_tb(tb, pc) does not have cpu index
Thread-Topic: trace_exec_tb(tb, pc) does not have cpu index
Thread-Index: AdnUZhb37C6OonbwRsC9uEVQBId8IQ==
Date: Mon, 21 Aug 2023 19:32:33 +0000
Message-ID: <SN7PR15MB6086C79340695F5915F00F20C31EA@SN7PR15MB6086.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB6086:EE_|DS0PR15MB5494:EE_
x-ms-office365-filtering-correlation-id: fddbe66c-404e-46fc-4a3f-08dba27d5e02
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q/xNRxlPXph2/8EqQy2fnNfcamYKTmrelSp1UWbqyMBoH+NlCb4MZ01RwVSR/KsSbBhy8C7zHEXPvkLopUCE6ggHzj9WXIc50wlLgUHc7PspzxSUmjJdN0xs7rdVOvDm+5zQ1HTCLHR4AcVY9yOB+znAIrHLgyDLySei++KdT6fAEHjjZ3iNEHXggmev/s3+0zAd/cB+rlX5atzdNN+ikozxxfZQavV2Z29f9RTakCcfY0XE0+b+oHbvTQi1Dos01cS1H6aEDntX9lqFsCpJaravPZlLdBgaBUlRLPFYbtyDgKMLUxpMQR87k6H5OPxKX1VjB4Vd00bA0fSSzpFrfLaav20RLpe1YSKQAsjbkEUiIyP0jEEBcin5nORVSGmwyP22IIKBhx9L4l96PB3Cs6XoEYWTPzVbKD6vL1VCLj9YrwJPjx2v6RXj5HWMMFcdpSHLgtaLgKz1zwxTouS3F3og7B+MqUkF8raavYSLnL3L+ZMbLBMmhi2+iBtI0cLrRnCIFLqTmXwuwGqKMG0XYRpaohNnBSLXhbokfIDvijLYe0SkqRPxCog9FmP6OrAhj6QD7bDVFZbaXl/PqNcVUd8mXJIuzfOMCvDbY7H5CH2EtCfdtLcYFf8921hPy0b8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR15MB6086.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(4744005)(6506007)(7696005)(38100700002)(5660300002)(52536014)(33656002)(38070700005)(86362001)(8676002)(8936002)(316002)(9686003)(66476007)(6916009)(66446008)(66556008)(66946007)(76116006)(64756008)(478600001)(122000001)(55016003)(71200400001)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TxzjDqZIiGkJ7vfqYsuwAtSyk0ZCZfh9UGOL+Rbqv0uhAG3litsVtLfnmgcX?=
 =?us-ascii?Q?aMzCqrDWIDXats1DZXqT1RNM/nL5PC/mEXIC0kuuEKvFZsQnp8lkyc44ZQnt?=
 =?us-ascii?Q?yonFqzKiKmjHrpwF7pYFSZm0YZIwanDqS0D0KsYBhg5OOCMxaZYBLbsQHz9W?=
 =?us-ascii?Q?7oawothu5GUQGNNW/7LZjtCbONXmp0YH4wg9j6IR8Fch1PXR1KtbZVZoKCgY?=
 =?us-ascii?Q?0GjML0tsTNraEb8p2lVqD5obDRV7BDo+ta+fpQAq8y5f06CTZQaeSK7iSBmR?=
 =?us-ascii?Q?Wt1nEuTnipjN6QQoFALlpYAdlIt78hdgNFr3Hzd9DlvgCgK6S+ji1ZBipSK1?=
 =?us-ascii?Q?H5kmmQuNTM5tKFaj/KlzXlg99Xj1osA+a5erohG5Emh7j+0R90oYV+Ycyxw8?=
 =?us-ascii?Q?MKxTVPKeHMKEEU5mvmtolk3WW6v/fguY6gJnas2OYicz5mLXy32U+uQdwYCZ?=
 =?us-ascii?Q?dn6Muh0rzJx85mxJ+A8Qm1iYPJcNjHrbYikNMwcjzybaAvnvy54/+NNoXoaa?=
 =?us-ascii?Q?a5/U9FR1NKz20q+zfgjHtntqiXDSgZTR0HYjQfUyed6mt1bxj034btPLKbRe?=
 =?us-ascii?Q?Ifyw58qXFjUplhmNwk06JxTZ9TReh/2gAlurmMIr1H1TQCfiyHbvWGiAYTkG?=
 =?us-ascii?Q?XvvqFOvscgrXJD/h8k3Om3zaZSPvdFl5ynFH9RMv1xowqr+vR3VjPv2EyTxf?=
 =?us-ascii?Q?fmJwBNKX59cRm9JjKRw88CxfVzgZNkpQMlD3Gv7qe7u4B5E+sVpOfdtqiQ7v?=
 =?us-ascii?Q?tvxB3jyI0O+ybePHP3k1CkSHD1mC1YAxSl/SK+7WhcEEEpyIq5gIHzMsml5E?=
 =?us-ascii?Q?nQRJt+kHdLqi//JiYczOjk5SDv6RPUp48fTcwkp/WamPUFPNWW42x42GhC3X?=
 =?us-ascii?Q?/mfWnJi5zQQOAepFr3DsTorihFU4G1XLubv5+45Del1suKkajcirIvfCVcHP?=
 =?us-ascii?Q?ZFkEkgoWNCIMrbjO9Tvkeq6wr9eLUgkv8wyPjQmR82wpE43r8aej7AD9orVh?=
 =?us-ascii?Q?7DdWXJGL0zs4Tdvfbf0Cy2XI8G2JqXgzlSU6IQNDi6z/Wk6qoYxN8uiiIdlY?=
 =?us-ascii?Q?XTVxx7QOX1zRuEUqrlKGRglbjJ/QuJp0CRZmwCHCStAAoF4DrHEfk/LLQfA+?=
 =?us-ascii?Q?2rmEgdTfgtKAynt36a5EBcS8IQV/AjAPpJnCgv4gMvsuIwPy10e6YJecmk/1?=
 =?us-ascii?Q?AsDPR/kKE+Czwai7L0N8owKKcWG3+qN/OAIYOSq/R+rgYdnsKmbsJH8CphlP?=
 =?us-ascii?Q?RMDP6RNWUyCOib01Py00gNqvqFmOxLjIUu/csDvDgfIvwq5JyUY5176MJB6a?=
 =?us-ascii?Q?iE66O03yEWlG/ZZ1WVwXjypu/E9ae9PxVrIxXzGcOKPqglyexG2FS+lYmHDf?=
 =?us-ascii?Q?oo6q0GFb9GkmkFzdQwto3j8b7G34VtvoQiCgDLq9VJVF9zIUOvIu2WFgJWAR?=
 =?us-ascii?Q?AATUK7g+CpEJMtZD/65nquimJfArEC/RpFud6eR9dCA25LUCxuJrNJIfdfku?=
 =?us-ascii?Q?kYSckZcc2U5tNd5YsjftkQ2OZvh/N7CPgviNUP+2zr0BIeSdTzamZwn6sMVM?=
 =?us-ascii?Q?bNXfP0nJkK87oUigLvp4doy9zh1UX8RiL7A3K2P2xkhqgr6ZRYdTk4z31UvL?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB6086.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddbe66c-404e-46fc-4a3f-08dba27d5e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 19:32:33.4312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FLv3SN7QPJ7uo7SC13LoCQJXWpJmBrXrjJcY3vpQ56jPVzGCSUCnDcW49Pb/JnMZCzVEv3n4hIj72sC6YDkcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5494
X-Proofpoint-GUID: jatP4wuqKf6rngqPabpMNVgY9guACbOL
X-Proofpoint-ORIG-GUID: jatP4wuqKf6rngqPabpMNVgY9guACbOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_08,2023-08-18_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=159767b703=lesikigor@meta.com;
 helo=mx0b-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi.

I am wondering why trace events like trace_exec_tb(tb, pc) do not have cpu =
index, how to make sense of the trace in case of multiple vCPUs?
I have changed it to trace_exec_tb(tb, pc, cpu->cpu_index) to read my trace=
, and now wondering should not it be there by default? Am I missing somethi=
ng?

I am using "simple" trace backend.

Thanks,
Igor

