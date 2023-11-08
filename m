Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 728BE7E5131
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 08:38:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0d82-00062T-F0; Wed, 08 Nov 2023 02:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1r0d80-0005zq-UU
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 02:37:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1r0d7y-0000bp-Rz
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 02:37:32 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7LJdxl029149; Wed, 8 Nov 2023 07:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=R2Y1D+wwzGUMZRfeUU2RxDX051aS4KpUwbawOq5kIZ0=;
 b=Sv3bzREdm+mBoIjrpVJ/TLq2IgMIHk6V8z5agfam72rzSyanpu85K9Ac92LIKkCNJGXi
 NdAhUV35hpJ1/LFr+VSL/DzpNHao+d+VTn+zKGJs/eIlonbnt6CQv0ObDoxnXkYFprvd
 ybL7CB7QI8E7e1UkJES1uBPKcu13Y6nc4LvxKz0Rmq9MO6Z/gzGX3H9m7/C7XWSRy4JY
 ftxCqERM7nRkM/u4dkJZpAJNUVz/JIuEil67g6WyfkL1CPJpktI/6Ohp60eZ6kvw5FER
 w+/+CH3/fGODvKqWhdWUk7gZO4FSzEPtodRH9No5NVOcFY0FcBWd/o4NWy9YOiGFO68S gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w230tt4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Nov 2023 07:37:27 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A86KWG9011175; Wed, 8 Nov 2023 07:37:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u7w1uaw0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Nov 2023 07:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx8RHIxRP7Z8gX5qVUFnfbj/HsQyNhoeMyDIy7rOvv4YyYrefhv6DqJeX3hJ3ScoTdZZjSLmjcZADNFzOaJQ9EvBPXpkoEKORiABB668JvkV6q8rYamHgiPLDsdynoCEOw+UUREhsxWBi+nypqbHFozx2tNOgLCLOl6f/n2fjeooVn+MDRFiUkgz567GbsJiHWH4gwexB6uvV+mhV+RSjvKuSfQYgejwRpFjVidCJLZWQOtzU2iI56Yr+3yX/wge7/4gvmRKn2HAbVhq98t/8Ol/6716QCYqD9vxC3ilqPblMOkZ4TMobROwkQEXBoAvDaiVbHAwg7Tcg5+O8gQuwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2Y1D+wwzGUMZRfeUU2RxDX051aS4KpUwbawOq5kIZ0=;
 b=gseRCve9UGmxF/I1OM7z72+g5lJo30i+YsfWGh4xg5r9PwAhQ9uobL4l6tMgYIYXfG/tObwk0W4W2FAFlxVIOnGQbIzrwF9JG6chvR1rFPurCQefTfBwcDlHNtg3bLAd6/S15WarFurhRfJIVllgq2yQaaDxLNpa7pK2P8bmFeZW48mAW5G+SmqHD06384h5/m3hap21XskoCyWqAd5lS4oIK1tJWhod4OeXt+xpn8GNqI2Pcggu7CtaT1PdvLoODhyz6LrxNIjI3Hw9dOvByLYGRNSFl3WFsg3OQejDIPfThDug0R6rbWtTyz6TVyClmNH0lEgiZ2SMFcVaHGTqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2Y1D+wwzGUMZRfeUU2RxDX051aS4KpUwbawOq5kIZ0=;
 b=FJtQ4fM+VPJoFRwtzCsDxSRv+BDmPBPV2TTOcuVIjPnbvLpq/cEIKH6NtFaVsygyAniLxq4nwxTA/maBnQ0DRIY7zT195HC5uohFnqYIvYvZ2ZUyoHgbUvlPsvvCRKMfJM595Nli3PaSK3abw8VfI2MSrd+spP+bJzxThXFIg4Q=
Received: from SA1PR10MB6590.namprd10.prod.outlook.com (2603:10b6:806:2bc::13)
 by MW4PR10MB5839.namprd10.prod.outlook.com (2603:10b6:303:18f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 07:37:22 +0000
Received: from SA1PR10MB6590.namprd10.prod.outlook.com
 ([fe80::cebb:4172:b91f:abe9]) by SA1PR10MB6590.namprd10.prod.outlook.com
 ([fe80::cebb:4172:b91f:abe9%5]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 07:37:22 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Dr.
 David Alan Gilbert" <dave@treblig.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, richard.henderson@linaro.org, Beraldo Leal
 <bleal@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PULL 3/8] dump: Add command interface for kdump-raw formats
In-Reply-To: <874jhwerc9.fsf@pond.sub.org>
References: <20231103070136.437557-1-marcandre.lureau@redhat.com>
 <20231103070136.437557-4-marcandre.lureau@redhat.com>
 <CAFEAcA9Pzr_bHom6hy8g8ARS6kbaqLZ8i0wCFT_yjrvBfJu9tQ@mail.gmail.com>
 <874jhwerc9.fsf@pond.sub.org>
Date: Tue, 07 Nov 2023 23:37:20 -0800
Message-ID: <87wmus3dcf.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:36e::10) To SA1PR10MB6590.namprd10.prod.outlook.com
 (2603:10b6:806:2bc::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6590:EE_|MW4PR10MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: c84f7328-62c5-4d3f-d75e-08dbe02d8b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQnnieOfyIDuWhaOOxfpWJN0eT+ei66YppfpqS5b9kBKzVADWHmCfbhKESOJGr9yXkUFIri04u1vZsew65n7X5S0DEJrcf3q+tlAjL5/o78/rSP/245NJexSS4YTi5pJCBBW5hl6JAA52GIgbMVaESsxKW07gf3vAg3Ad3sF+MzlMiolipljq6sCedF6Q7JUibmQGUu2M/XK7Tv7eb/19GbiR10h0i+Pjf2DpyLIhIUE9UE7kSqS9XSEsAPD7XCMb7v8vKrtWZcmthfK/nqKbSAhSs/i9fhxQf8zAW97+TEsbruHyZtNV+k3+Ur/7M/Z5hdgsqk2lAbjoGgOKTxeHfNiouqiW5+4FYlZwxsywXjrjlEFzGCOQ6C2X5KVPrstnkyRRrw1YdcNPv4NDwwuqsjdmUI5Gdc23EYljgIUHB7OOLZ3i1hV1E/BThDtgg4GDkQF3twacqpO6yGK8RorAxfDrfifUykFvETd43tQ8R85kGKxsHzGj1NUziB+54jkrD2DIghjCTtDKUkskJpTjE0Kb8BbEWovyUlrzilEBEYUwQCsmc6rfNVjtMvmLUy5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB6590.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38100700002)(2906002)(8676002)(4326008)(8936002)(41300700001)(5660300002)(83380400001)(86362001)(7416002)(6512007)(2616005)(110136005)(316002)(66476007)(54906003)(66946007)(66556008)(6506007)(6486002)(478600001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUtlMGtQdGlFM1BOaCtEQW9vM3FneXk2MzdzSjlxKzhpYWdVNWlrVEFwUXFJ?=
 =?utf-8?B?WmR5OEk2dVpGYkhORnhWSkJtR2VJa3cvU3lTU0FLUWVPeDUwMUhMbU5hanZu?=
 =?utf-8?B?ZmtvNFdLZFhtY24yTytGNFA2anhyQnRmVkVReDFzTWhYTFM0c0lZVnlER1FQ?=
 =?utf-8?B?RkR5dk1tL2k5aFpadXFsRGdvM1J4UkFrK0hJSGN0Z1VwYjdvTzRHMEE3ZURy?=
 =?utf-8?B?cC82Nnl2dWFSYXIvSlVqMS9pUmUyRnF4Sm9VSVJ5MlRMSE9ZTFRla2JKRW9y?=
 =?utf-8?B?ODlpRGI5QXh0d0hxcjI2dHFSaitETk9XV2h1SEliZ25MQU84NDgzTXA5c1hX?=
 =?utf-8?B?TUkxMDhBS3FnaU5UL3czS0tWa00rQjIyZTBGbVI4bWFGeE5GalRJeHdzWmJQ?=
 =?utf-8?B?WXl0ampETzdkMkFVbmZ6K2thWnVQanp1UlBqZUdHTnVISlNlb1liZmlqVnJC?=
 =?utf-8?B?dUp5VzBEKzB5UVdTMng2ODZ2bzBEUjA0TG5IQ0VjVmR0NXBvU05IcDdSZE5w?=
 =?utf-8?B?a0ZCdnRNNlJmdmpqZ0VzNXEvdTdUYmJkOGZYRXZ6dlhoQ0RVZFhmdk5mTDEr?=
 =?utf-8?B?cCtLZFp0NXc4MlBaUExxZThxUUFQYzE3ZFhmcXJhRjBxSTRuWmJicURhbDNC?=
 =?utf-8?B?NEI4eFd6R1hKWk9UQ2JIeVM0aTFiY1dBUS9tWFVIL2hEdHRjZFRDb1RwZlBJ?=
 =?utf-8?B?Z2pEL2dHZDBxQU1rM0E5MG4yR2wvK1pGZHpBMEtFUG1Hd0N2eENybFQ5MWht?=
 =?utf-8?B?U0R2a0o5ODc5ZGtKZjBWWTZvbEE3Y2JnZEhjR25ZNXVVek10aVJzbU1UU2JT?=
 =?utf-8?B?WWRJTVhlQmdhakRrMUVhNWFHYXFUYzlsb1RQTVhmVFlEWUZkSkZlV1RyVkYx?=
 =?utf-8?B?WVFYdlZSblJGeWdLYkRaOXRsZVRMeUVxSTBGY294ZjNTYURCS2hiMGd1YlZU?=
 =?utf-8?B?V3lqV3c1ZmRSbG1iOFlFTCt4ZFJBRWpITDJFY291QmkzOHRGN1RWZHpmOG5h?=
 =?utf-8?B?RGE2cW50bFNiYWxPWGswd1VTejVOQjJGa2dRaTVUelNIbEJSem5ZS1VvWUhX?=
 =?utf-8?B?cUROa2ZIVFF2Q05RSmt1UThtanNEMXlITEExMlJvTEpTTGhQUHhSYUIyZXBx?=
 =?utf-8?B?Q1lSanE2MTc5RlVWckNScm16VXdJZFJPTjg5R0NtMWo3R1NIZGpmek90TFNU?=
 =?utf-8?B?dkdYcUdiVGxkei90dU5UdFZCZFNjemNpeisrWURVQXQ3OFVBTVpqV1VROE96?=
 =?utf-8?B?c3hRc2crK0xyVXVHSEtWUTdiMTRJR0RUVG00aFhJZ3BVTTNVakVEdG1vVmdM?=
 =?utf-8?B?czBwcWVMR0dUVXNWclJOOXRaa1A3czJkYzJUV21DeERsZmxDZTRUUnlYRjRm?=
 =?utf-8?B?QjNHY2tmSmJqeXgxMVpFTnFrZEhiSG55ZUprcDQzT2hWbzdDNVhXTjlsMlJK?=
 =?utf-8?B?MDcrRm1jYXZUVjdidGlUTys4S1hSbUo5QnJoVmZPOE91SG5PTk9jeGJGL2F0?=
 =?utf-8?B?d2prejZTcjRMQ1FkRkVueVpxaEJNbDQxcFhzaWZObnM0ZGl2MnppNXFyR0dj?=
 =?utf-8?B?RnlFVUlXd2c4YXJxeTFqcmM2OUNDL29SU1RHcnB2Y2lMVGRYdGNjYzZjWkIw?=
 =?utf-8?B?UlhyWC8xekNRQUo0Q0VUREs3bnFaak1SZ1NabDZ3cVZJeDB5RnJvT205dnov?=
 =?utf-8?B?TnczY3RCcUk0SmVhaC9LNlRRc052RDVGYU1QdUNjei9aTFBzSG91dXVSZFY4?=
 =?utf-8?B?Y2dUdGkwSUoyNjJKS1V4aVRhbGNWeE44TUx5blRwb3NaOGpESGNPMFllMmNp?=
 =?utf-8?B?R2poMkpESXBsY3phOFZtYldabC8xUTM2WWg2cm5IQ1gxVVMrRUhIbTlOWkc4?=
 =?utf-8?B?RzNoZTF6YjlOQVJTZlE1US9LTjRRTjJJUWQ3Smx4VThGUzkzMVA5T3F3dUI2?=
 =?utf-8?B?Smp4M2VCOG95Ukp6Tk1tSDFEejJ1OWNsQVNRYkx1ZjVOMEs3VlRKbkRmVDdx?=
 =?utf-8?B?VGI5eWZmbWlDSW9ZT1pWMVYwVkZPMnBkM08rSWRQQUdiNGwzeE1pYkM0WkRq?=
 =?utf-8?B?akdOYW1pa3lVL1Uyd1AzYUFGaTJNamZnTUQ0RFZxbkc4cUkzYTcvSDBNcnVw?=
 =?utf-8?B?N0lFazN4MUpkWmJHWjZuaHU1TjREQTBnQnZWUUl0VGFtWFRmTldvUGtPenJZ?=
 =?utf-8?Q?fO2HIzaBoujqB7/lW6YySUo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /ffCr3TOs2iKHx08NdiIfSnz682LRsw6tIG8aCXVqd6FEzlsZg0Y+Uat84br6cx8TZkCdgjTETQYTa+NXIioiuigTZxo6VacGZ4OX0Dwn/p0QAX/28+pm7gAIWZE7mW4iCn8T2jff+Yv3KjMnmBtUEub1zOd18TIY9zaJ/l5UqC69yqNQFqaaUq58nWY0upsHtLpGfOsgvCb+tP696tTYRtkGlImSvh7/LPavt9PwLrn1RvUDYISmgrMIryRzEbWyE2QlfkAI1ZREIhXYnyUaSbOmjCKHbsHl5c250dsm0g4OIzE7dtpM08jQhf/dV1rm0Fy+aOlDltAg4xMluuIiTkfRHj0YxDoI0zeB4eyAGbUhWvmy3GPS0LUILLocpUu+KMXbgWb5WPJMt2zc1BtphFjO0ve1Mt/sVNc5YtwTh0x3Ih08L+F8ZFrr31CJzvHHfJkWIzsuCyKL5FzM9vzeQIuuYilKLBKvKsT/SJ9Sp8N6qEZp6o0asjoyXYHRSpm8cQBstIJUDJi4DI6EgAKOrN/X4EDB6Tzy9NOWuqfUxHS0VAneRkSjSPU3c3QG3LZGFD0CotSSXsHYXyXlbtc8rHJ5SlGRMfHydh6pBFSJpavaT+OGIdydTuDQe/kRxJCtUdypba8SkqAM8Yb3WDVhtYBcy7kpY+D5lvpezGOVsPa9SdoBwiakGN9rBR0NA1n/sUU5NLODDsYL8nmRImoIwwSO48KQwKqqhv8iSwFbiE0bgbiHeo0aR76hZxkfeHZLe5NBrd8/2Awi41X603hfit+ogxs/3WRBK8MBY2tLDXQU5g3qCT+6mJ7U/kyUq1WIsnr/cR0RMx4W+VjCRm/mw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84f7328-62c5-4d3f-d75e-08dbe02d8b68
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 07:37:22.1684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2t804XcrXNtvZUSxiMVMYDpoLhwaGULrI/wIKhffPmzURr3uMltApOOvsKDyjy9PKSCN3ZwuunTwEqAod3ln2tpTqEBkMGB7SNZcG4WGK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080061
X-Proofpoint-GUID: qfjrjQZjmrLZN2MVKfD_mtUNSN30X0TW
X-Proofpoint-ORIG-GUID: qfjrjQZjmrLZN2MVKfD_mtUNSN30X0TW
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Markus Armbruster <armbru@redhat.com> writes:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Fri, 3 Nov 2023 at 07:02, <marcandre.lureau@redhat.com> wrote:
>>>
>>> From: Stephen Brennan <stephen.s.brennan@oracle.com>
>>>
>>> The QMP dump API represents the dump format as an enumeration. Add thre=
e
>>> new enumerators, one for each supported kdump compression, each named
>>> "kdump-raw-*".
>>>
>>> For the HMP command line, rather than adding a new flag corresponding t=
o
>>> each format, it seems more human-friendly to add a single flag "-R" to
>>> switch the kdump formats to "raw" mode. The choice of "-R" also
>>> correlates nicely to the "makedumpfile -R" option, which would serve to
>>> reassemble a flattened vmcore.
>>>
>>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> [ Marc-Andr=C3=A9: replace loff_t with off_t, indent fixes ]
>>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Message-Id: <20230918233233.1431858-4-stephen.s.brennan@oracle.com>
>>
>> Hi; Coverity points out some issues in this commit:
>
> Proposed fixes:
>
>     Subject: [PATCH 0/2] dump: Fix issues flagged by Coverity
>     Message-ID: <20231108053731.112043-1-armbru@redhat.com>

Closing the loop on this, these fixes were exactly right. Sorry for the
extra work here folks.

Stephen

