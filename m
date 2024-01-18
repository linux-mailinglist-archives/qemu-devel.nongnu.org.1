Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F43831696
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 11:22:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQPVp-0005x9-NP; Thu, 18 Jan 2024 05:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rQPVn-0005x0-Sl
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:20:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rQPVl-0000S8-Oz
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:20:39 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I9i2Y6009647; Thu, 18 Jan 2024 10:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=E1eGVrrUtCMWzc/LIkOnQ3Kf2y7E45r/YKYKbC9aZis=;
 b=fTpYfzwxtxmnHfoT6fjArMkfEH9boNv3+8woKHyu0tVL+4dpCgLs7sYzk+BNuhWO2KQK
 qvsF0YtSLVNuX/o/szXMkJxA3DPX42JJMFzt4orzJV85HOtBqrxbJBSRFT3OFpdOBouD
 TFLWENey89bMySrzmTrNAOEw58YD3ujV4f53QmGZB3gE95/m/8ZcXNJ7F1q37JxyI4a7
 aBRn/Tfo/nxnK0Bhm/AkAWCkyyfb86jxUYM++7cfl3yeo2sf/gBUXRG1sORJZsHOLtPB
 B9CBuKHgoVo7uY3P8Vmk+zulg0JfJC1wCxoEaxd1+TqRqrT3ccwc821h4ejy+5zB5uYa 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vknu9t4k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 10:20:25 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40I9Z1sI009414; Thu, 18 Jan 2024 10:20:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vkgycbn87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 10:20:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INlOe5UpYnczlnzyXtF+E1E86dd8FYXzpXXizuai7Mkwik+JRg7D6uXJ4RrhF6AtVaHMStlKtnGwo9OSZ8jUnIozKwKadpedvXrvnlTU/PYmQnvjX9apWHG0TblmXL8oy3Fw74wgcLuhyRYgV2ynz7ZH9A1EjuNR6Ey4keRq2BxBzmPyhDJVb12KoeX6y6rI8K0iE5A1tCOA2FzE+6/EVIH6wTcTUWsCTnBpM712JPmH/jesDdZXmv66/8o+mc3LkLycCOLQ9moDrIcAaLBJRCMM3N2jswcNWvDxafTaKTWJpDvC4KiR2feNVhPj1K1Z1xi+MkhJm9Xq23quG3T5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1eGVrrUtCMWzc/LIkOnQ3Kf2y7E45r/YKYKbC9aZis=;
 b=P8j9/+p8pmGE/RUkHWs1NB+xYIv8umIl6KbXBP1rjCE/rpiFDuRNnUF5wivcoK5OlPupiXtMdxgG+rAq6J+BekYno4ZXtpNQo1f+FaWKVBYPgFwHp9uFJhgc5PQ16NxiblwdCahP0UsCYSTcrdH6pUTLgNTht4n7xjU21xTj6PCgM12QL2ddWTzLOCNaLBfOm5Nm+MKgWJ8vogLQnoxz0i3u9SUUSxjKJLdXwoAgpd8yWzWPcHG64O9pz2J96tSqMELrUbIe7hDSK9mBqlZSgSoR+01JA7fGWaYgNGFvCIYm5w/pm6J7FT7wFeKZazjTz8Rh+uhtk7APOpx7UMWTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1eGVrrUtCMWzc/LIkOnQ3Kf2y7E45r/YKYKbC9aZis=;
 b=ePEYdE5elYwQr0pgoRQPscOADszGEYCF+PTsCFnk/dmcCyT+nmaskyPFnPTRHQFfiDQoqdvA+uy6s9pFxGV1ngCoFkbx+6M5BIb/qy6Fh0vh29p/3ja75uzgGYhChKF0d7lwaMzmeC1mwUuoj+j6zSOXdr6O4mHqZWmjnf6ejMk=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 18 Jan
 2024 10:20:22 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413%7]) with mapi id 15.20.7181.026; Thu, 18 Jan 2024
 10:20:22 +0000
Message-ID: <23fe2406-fb54-4872-9fe0-c46a8df47820@oracle.com>
Date: Thu, 18 Jan 2024 10:20:15 +0000
Subject: Re: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-5-zhenzhong.duan@intel.com>
 <d6b4c54f-f24d-4e30-9e93-9c126a42e00a@oracle.com>
 <SJ0PR11MB67446801223842563733262A92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <d495ced1-7145-4228-8927-705646fc0303@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <d495ced1-7145-4228-8927-705646fc0303@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0697.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::12) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BY5PR10MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce2431e-bbc6-42f2-69f8-08dc180f1416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b2rbiMMjfEOz+QNNqqDtwB0X+mV7LWlMx3FqNBw7cn4OXWvq39J3o2uRPtNfjMLH4bpYSLOXlQcSqxxNlFHNFOeX+S5BPzABYqvcTpjofqpO6IVvfS7J9XHHoJ8VZ5dkiN4SE2teCemw+/KjeLtp31zACEJg0gsfUdqBUd7OtHGwhjwNLcVK+wHtDztc+DcUEOdsUf1wAVqW0A1Kx1x3HBO0bFGWLkz0DgFZaG+OC8W5dLlm5Qj8IUYA2yFVPKx4BmVWMgInLl+1k2sjz7dK9aLh4xE/YrnJPEBPC6qpr2MeJkcnr6HZ4F+OO2P1AgaSInX1gPFlVsXnBlS2IcviduXdaqEqGOncehwbGGKZYjwb++ErpA6bf8Am6BFnY/Uzxbf0xFJf8KDpEodeShsfH6uGcKU2+J0OphSgKAA5pJsX6+a3bPc17YGws98J6vHPN2tlHJfohG1c0rVYKN4eS5uYV12y96I03H3GjCVRdihhX39iMivcDCKg6fUc/3NLvXO9Jx3T90KLf5U7t1tWHLfk/l4wMH34wU2cJOLRwNLy+2IyvWuWFkRTRnfCIGN4G99QjutNwxkVeYifFORX9I2+SeQw6wjkkXl0B7bT+ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(86362001)(38100700002)(26005)(6512007)(66946007)(53546011)(8676002)(5660300002)(4326008)(6506007)(316002)(66476007)(7416002)(41300700001)(478600001)(2906002)(8936002)(6486002)(54906003)(966005)(66556008)(110136005)(31696002)(6666004)(36756003)(2616005)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdaRkN5dlpJT2RVcEZDLzJYVDNLdXdzZTZUSWF1Skd5Y2lVUW1pZnFnMHNw?=
 =?utf-8?B?T1ZHYzJoUlB2aTUyU1FtNnpPT2lWQWNydU5yUm9pZUJrTi9DQkpmN1FicnhJ?=
 =?utf-8?B?eFRtUjlDenlyVnhiTWg0SncwNzdlb25XSFkzSTN6V2xmcUVqU0JCa3IzbzhS?=
 =?utf-8?B?b3pnTmFCVVMvdktxWkxuNXNqdEVwRTFnMXB4Z0pQL1VnNXhobmIyN1cwSjM2?=
 =?utf-8?B?WVZIY3ZFdHJ1b3hXV25xQjlJc09lalZyU2l5aXYySXJnSmVNcHBsdzcySDRI?=
 =?utf-8?B?N3RhL2JWRHdEeGlGSXJHc1NQWFcyb01ya3ZCNVl1RC9MeERPZjZLdUg5d2pr?=
 =?utf-8?B?SkNsWTM0d2lJM0NkTzR3QlBaWEdDWHZFUm5tSUhGeXQ2NE5GNkVYdFlRV3dM?=
 =?utf-8?B?S0dDWDNVNkUzeVp1bnZ4VEFFTFUxa25POUw1N1NRcXFCNStsbGtQekdpY2No?=
 =?utf-8?B?M1hHZWFPSzNZc1Y4UTYweCtwd0c0TE5PRGxqYzhnZ0JVWWZaRnRndk1FWUU1?=
 =?utf-8?B?MUh2UEZnMnFPVWZFWG1vNjR2ZGJ4V0tUMzFLZ2xVR1dZbHIydllEM0NtelZt?=
 =?utf-8?B?SXRsVWpBUnU0eUVPMm56YmFDZmp4Z05ncG1iczZUdnJ3U2NwdStZNktTVXNr?=
 =?utf-8?B?ZExiWGM5QkpTQnAvU1pranI0RUxlNVppamcwcG44Nit2TkwyaXVuek9pbVBH?=
 =?utf-8?B?S3BsU0Ixb1V0bGNML0lqSU9rM0xSclNlTGhhQi9DbXFkWHVhd0tLMlhLOXBx?=
 =?utf-8?B?dXBBeENyNW14Q3A0S0hWOUl3VzlWd3BPSmVBL2F4d3VML3ZJbXovQnlCNC80?=
 =?utf-8?B?K0NjT2RtdEorMGx5WVM5N0lQV1FUUGpicjRCY0NKODdmMlNueU4zc0U3QUxR?=
 =?utf-8?B?QkVwbnh5a1Z1N2hMYTV6VHNSZjg3dWNmRUFlU3hKVVk4cEgvdkp5aFZtbS9l?=
 =?utf-8?B?QWRmMGhrUTdxYThzSlBpM1kwM2VRTVppbTI4UEpLa3JVYmZGWFpZYmtPOVAy?=
 =?utf-8?B?MHZjazdPdGk3dkd6OHlxL2lpcFkrbU5sR09JaHlmS3dDck9OTFdWanRPeE9k?=
 =?utf-8?B?N0pWd29SWHJMK3d6T0hIaDkxdStmOFZsSGc0YzhWM0Z6NmNZV1llQS8xU3Ra?=
 =?utf-8?B?Y1JRV3lnYkczV213THExbHUyS3hQemExZ0tYMmV5ZnJjOXFsK0w3LythMmRC?=
 =?utf-8?B?Yld0czROMDF1c3VvTm81RjNQS1RUNFFmamVoeWZDMlJkTzlrZUxOUnRYaVJI?=
 =?utf-8?B?TkVjT0hjYmgvbCtrdzVzRzdsRmpzckkxRXdrNDZJbmlTWWhDVzdHRmIzL2Y4?=
 =?utf-8?B?elpGT2t6ai8rakpLdWluc0N5MndGRDR1aWZpNlFadXYzKzNuQUpZQmtRc3lH?=
 =?utf-8?B?RW5rbVQyaXgwQVg4SEtuTTllNDRBdHU2QlZkNXFUdG1laGZOZWxnM0wxY0RZ?=
 =?utf-8?B?TDZVRnBsVElxdzA1TVVaTGRJSnEzY24xYWtaQVM0REpsb1A4aWpCdGZ6TXBZ?=
 =?utf-8?B?bGFFa3Y1c2UwT3BFOGlNUE1UWi9hd2xhaHhkMkF6djdZTFhvdjhLeDA4UHFB?=
 =?utf-8?B?QXQwUkw4eW50aGdZN1N3a2IzZHJjeHd2Sk1ZYWF1MFk5YjNjbDEvakxlZEI3?=
 =?utf-8?B?NDNhWmRHTUFzNHNkNUIyOUxsRUVUMFNQc0ZVNTAxOFkremgxUzliVUJueGdE?=
 =?utf-8?B?RWhhT2RJaVRXZmUraDZzdXJVYzM1NDY2WUNMMGVwLzdJL0V3bEhIL3V2ZU5I?=
 =?utf-8?B?K2h2WFhVL3dOQTEvT0YwY1lMaEl6ZDJnU3ljMllVV3V2aitva0Z2UERXNlFR?=
 =?utf-8?B?bjhYK0Z0di9MMFNaVGk5cDlZUjJBNTAveXU1RnQ0aDFEa3B4ZERMOGtvY2gw?=
 =?utf-8?B?L2FxRkEwUlpmdEJVNzhIako3NzN3M3BibEJZMFlOamdSNng5Y3pJZDBSNy9p?=
 =?utf-8?B?emgvc01OekRBS0U2TlZ2TDQxZE5ua3IvQlFRS2JpdnYza2h1dDluMG10MlVr?=
 =?utf-8?B?MHJRVFE5Y1F2WXlscUpVbEkyQXljaEQzcG5lU0t4ZEp3TmtOSGlocU5RVlFO?=
 =?utf-8?B?QmlqZXhDSVlKdGMzb0JHOXlseUpzN1JJMjQ5WC83dFpvbjN6Tzg1cTh2QnB2?=
 =?utf-8?B?QWZyd091TzN6ODFPNTY2REV2Vml4Szhqc3M0dG13SFYvbWx6OUpUUEltb29y?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KgiUGaxzmK1tetwDCAUYWglP7Com9Rnv+JEJWb9oXaRqNqYpaQBD6yxY1rVzc9iVcZa0cuAwBTgiQufY5OsWUVeU6hL5t0Apx9wr4N3rR2PViKB+sTep5sAj29ZPUL6TXtH26C7PScg50m6vRTdE9P7hcvMsvdTLIC0tE+4yD2Q3XMdJsaUK+vGnAbPp0wd1tgGu9fHmSgyGJZ07/Uc0enpdpfpsXm2lLoKl6FSRN1DucaIx4Rj3Qcr7t9KQkFk01wzW2iowwKKdfMDf0b5HS1q11vg58EmVzGi+N7fYYEJP9JQSSy9XDUUvsGdj/LUtpTUj/ouoOnmGg6oaLdt49gsTdbM86N4h0Go/z3I49dG4GrQWaUygeGD/VN+Y7ooZ78tqMKEscxZ2Vzjv4qmSs7igCphMPXIHefW8VXoVaCFkIFCnZisB4WpvwJtvNkLrQxj4YA9JFlr7JeKyHL573KnHooStPEXSItCrR29eFUdaIguTHm5UMrH7EP2ozCgTGZO8ho0dJWctmZXYYW3LzeVXn17Fzj3p7YhQXsHWftMYzgRF/KKM4NIWgwpx2NqEufwFnY/yjC1F8k+Ma1wbrULPJzgBK9jKEGPSWvzJVzU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce2431e-bbc6-42f2-69f8-08dc180f1416
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 10:20:22.3041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhO13MNv0NuG776DT14xgVC394AS7WGjsA9LSJCzS2ZAdv8qS9xgCAyzr0AjB3zTEJ5jdO1i3vGg8VVIFXJQqTLbAKkt6ix/C2rutCSpUZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_05,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180074
X-Proofpoint-ORIG-GUID: N5TpHfHPRDYXGABfkRU9HRrC6ot7-pTU
X-Proofpoint-GUID: N5TpHfHPRDYXGABfkRU9HRrC6ot7-pTU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 18/01/2024 10:17, Yi Liu wrote:
> On 2024/1/18 16:17, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: Re: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
>>> vIOMMU
>>>
>>> On 15/01/2024 10:13, Zhenzhong Duan wrote:
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 9bfddc1360..cbd035f148 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -309,6 +309,7 @@ static int iommufd_cdev_attach(const char *name,
>>> VFIODevice *vbasedev,
>>>>       VFIOContainerBase *bcontainer;
>>>>       VFIOIOMMUFDContainer *container;
>>>>       VFIOAddressSpace *space;
>>>> +    IOMMUFDDevice *idev = &vbasedev->idev;
>>>>       struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
>>>>       int ret, devfd;
>>>>       uint32_t ioas_id;
>>>> @@ -428,6 +429,7 @@ found_container:
>>>>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev,
>>> container_next);
>>>>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>>>>
>>>> +    iommufd_device_init(idev, sizeof(*idev), container->be, vbasedev-
>>>> devid);
>>>>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev-
>>>> num_irqs,
>>>>                                      vbasedev->num_regions, vbasedev->flags);
>>>>       return 0;
>>>
>>> In the dirty tracking series, I'll need to fetch out_capabilities from device
>>> and do a bunch of stuff that is used when allocating hwpt to ask for dirty
>>> tracking. And this means having iommufd_device_init() be called before we
>>> call
>>> iommufd_cdev_attach_container().
>>>
>>> Here's what it looks based on an earlier version of your patch:
>>>
>>> https://github.com/jpemartins/qemu/commit/433f97a05e0cdd8e3b8563a
>>> a20e4f22d107219b5
>>>
>>> I can move the call earlier in my series, unless there's something specifically
>>> when you call it here?
>>
>> I think it's safe to move it earlier, just remember to do the same for existing
>> container.
> 
> yes, as long as the input of iommufd_device_init() are available in the new
> place. And remember to destroy it if the code failed after initializing
> iommufd_device.
> 
In the way I am using I don't think there's any teardown as no new resources or
things are done. We essentially just initialize @idev and fetch some
capabilities thus nothing needs teardown. But I am not sure is the nesting
needs; perhaps destruction of resources is related to something to that?

