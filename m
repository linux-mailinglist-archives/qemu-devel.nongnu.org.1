Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5DA74A587
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 23:09:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHWCH-0007ew-Dn; Thu, 06 Jul 2023 17:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qHWCC-0007e6-Lj
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 17:07:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qHWC9-0005Va-Cg
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 17:07:24 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 366K3c2Y001874; Thu, 6 Jul 2023 21:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=n8gd3lsobNQqpiM/Engl+8PBzJiaeOKfr7gGhLv99Z0=;
 b=yfdLDx+yuO7ulLxaonH+La/sLinJuZcfhd97bmShW9xeqCLbCShTHbAjFehWIITKpsmL
 o3gxtYCNAcibgR2I5Ei4x1OEc/FlwlfLCH83hX8QGP5HdDBS/Qmd7rKJ/giOIEVllWDP
 ZVzUaq2ZRFuiILRK7iZCUbUIBMtNZnKjzLYJhamYCWEFDAi5Hwsn7hZIl5d8wN1HRm2g
 xdA0bPkIhu75lGjSkLyk0lSE1PVqHh30fZjC2IzJ+FyEFBSzOA2DrvgmVqJTek2Ra6jj
 JXn7cL+SSqwYDtKhuirdcN/KdFH/5YhcNcJb27X5GjVzv/mA5pbOvRyNIlZpbm8zjuft VA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6csve7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Jul 2023 21:07:13 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 366KkDhk033451; Thu, 6 Jul 2023 21:07:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjak7swyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Jul 2023 21:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b048qKgmG33zZUpc6jUKugNtreoaZM10Hw70VT94gKOHblXU2NefVkEos74wd6skNLiBqOu3VyyTCJuQ0C44EkJ1FzV2jIAT93KcRBGLFzLNHwS1YafPlWBFOyoCHxFjAxHq13pwy9SJVcidYkFffs2dFf4DtUu56/K1SWfy63vxu8NWxM6JAPeP3+ohBYnF/wt1G3pR238GIi28MY9GLJ3HVwj0rj0kUScQ4wkhmHEFTmKJe0XV6ado777PmNCFZG/w4vc+E27ym4/+NY/ubLF4k7HZ2cRoHHm3FpYQB6Nr7FO6XvwUhuZncR0EB28slGBjlMK/KZe+CGUnqX3ZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8gd3lsobNQqpiM/Engl+8PBzJiaeOKfr7gGhLv99Z0=;
 b=nH/SKGGK+RfE6hV9dVljfXW5KAf0Ek5D2/Rd+8AIh3T4VPgrQV17vIRSDg3C3ynnvBNzC6/ltwsRjhMOV7GSD5/L9UgIynfbNIG/Mfd1+PTMGY+Bn+IDp9eyIrfw+ExxK4KQfkdXsXsYbXvc2cwAtPWRXLu7R092erWG2nZhsVlkbg39TJb5CqxYoAefz+RQty4d5/ECc74pobXg6i3W8ZJaoxbX2YHfJruc1++IFowjKSBJQ1xUC4gZF5nMZS/CwLm+anqLV/UCGsx5biCk1cH95VX/5EI6mPcMSpfExVOHA+lwa+j0pnhMNCWDNqYhhu/95Nsh7aUlTiqmcA235A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8gd3lsobNQqpiM/Engl+8PBzJiaeOKfr7gGhLv99Z0=;
 b=b6Ry1LJTiq1ROBrPuW5Zmrd3PpoN4ufPQaELb+tG/fZXRo9eZA3ml/xdhg4swhv3c70nJfxRZiXy8mlwBdJ/L/oUeQre+Df8uF3xOXZA1icZkWWeTq3HJtHe9J77c/Oe5N3te4DZh7fR45AaX+nSFCk1tsS5VX767HNCWLNIVEg=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MW5PR10MB5740.namprd10.prod.outlook.com (2603:10b6:303:19a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 21:07:10 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 21:07:09 +0000
Message-ID: <df7f0910-a872-f764-5f15-ade4d6ef77f8@oracle.com>
Date: Thu, 6 Jul 2023 22:07:04 +0100
Subject: Re: [PATCH 1/2] i386: Add support for SUCCOR feature
Content-Language: en-US
To: babu.moger@amd.com, John Allen <john.allen@amd.com>
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, qemu-devel@nongnu.org,
 william.roche@oracle.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230706194022.2485195-1-john.allen@amd.com>
 <20230706194022.2485195-2-john.allen@amd.com>
 <10122c07-3c46-3aa4-890a-0ae6e5a51900@amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <10122c07-3c46-3aa4-890a-0ae6e5a51900@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::20) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|MW5PR10MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5cc3c4-0b4c-4f58-ede3-08db7e64f617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOSoRVDtxr0Cz0mkrTt19NZUQmGin3c1Tax1+lzNNa/gwyTE0DDGobaVYMe9CnsEQqBjPSzOCxy5TsuPJ0wz7PMq3CNUA5yo/44iPdV4CZqkkTJOModdJUaHCqEfOWJorG6yp/ghrNS9nsvdiioill9LfVqd1mSZUwoN4pZ2str2HN2yk00wPvrD9dGCP8936HAtub9Ma2ZbGrjZ69UVZrMFcgxzwp+58UDPVm8xGkMiMk+s0k7YVKulf2LxVzJCSpsCZZ96O++TQr3SXXVWcmRjU2oddRbNWeOCKnwCbhFXKTfqkwPZAel8mSJjFcruHXIdtxKK+GmRT6/Gh+WgBj/zR9yqv95U7B2kR3reOYMI9u5rbzeCyvwr/5mob9n/xcVN+TlVwGlunzxpbAqnYyPkpeJU9O3fzH9Q4EFAgmAgCzgagFkKp17ZNKabX3Th1KaEKor2GJcrx78C4mHdCdt3f29o6Lb7wGEH3hz4sGoNrYeuNm6JU+etvn+35yx+0cOAs6r20XtCnHLvzxz41dDDSB3QC4X8S05gVsUjRYI1038ceibdapNfs0aBEsfWZyTLkyOEq+3onXub/Ay1YDdgYgMGCDpSy1h3/ber/BjGJOBN8mragOrb9UVKbaUe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(41300700001)(66476007)(6512007)(478600001)(54906003)(86362001)(31696002)(38100700002)(6666004)(6486002)(6916009)(66556008)(4326008)(66946007)(36756003)(83380400001)(316002)(2906002)(8676002)(8936002)(2616005)(5660300002)(186003)(53546011)(6506007)(26005)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1lTaS8yTWJRYk9tcVhvMDRHVyt2NU1PODA2RHFLajVkMUkvT3JTOGJTVnN4?=
 =?utf-8?B?UEl5V1o4cUZKQ1VqaWsyZXQvUVlBejdzOTZhbFNSVGRnN2FQR1BneHp5dUdO?=
 =?utf-8?B?dzVmRlNvUXFQejFHU1BvcjN5SDJ0V3JlTU9yT1pibHo3alkzdmdKb0hiYS9t?=
 =?utf-8?B?M2E3ZnhvVkppU1UwR3o2d0ZkSjJ0QnZXQkkwUUd6VU5HamFTbHNLc3crdE1P?=
 =?utf-8?B?RklhWHd1RVRZblQvMDRxVjFHWEhCaUxDRXR5VXp4a0tqQ2Q1djZBWGxTeUpw?=
 =?utf-8?B?TFZxUnhtc0lrUlM3eDh5TUhneHRZd1M3T2w2NjFEZ0xQTnRKMEFrRDBwNDBz?=
 =?utf-8?B?SHpVUStmK1lZQ0xKT0R0TXliMTlNdWxKMTE5RVVSU2x3OVliZnI3dlRLTTJO?=
 =?utf-8?B?T3N5UmFiVEFjQ3VKYzgxYUpNMk5JajhDOHBySlJEWExLdzZJd0dxTW1oYVBw?=
 =?utf-8?B?L2RHdWcwUlN5ZDVBVC9neDFMTG93OGJhTkcvN2crK0ZxekxrVG9XVGZ4WWJp?=
 =?utf-8?B?NFRnZDIzNTZnaDBucjlka2Mzc21USkUxb3RVUTRHaEpoRWpGRytJalhoblAy?=
 =?utf-8?B?WDNHSnpxQ1Z0MzEvWFVyemhVNlFtWU5QNFlWSGlvMG5qYkR0TjlPTlVKaEgv?=
 =?utf-8?B?ZHJOSWhzd1pYMnBpSW1iZXpwa2JEWGVUekJ3NHFjK21BYTRjNzhwOGpaNmdL?=
 =?utf-8?B?bzVUVnVDR2x0aDRrS0tOaEZwdmFMN2txdFF1VSs2ZzU4aTJPNzBKK2ZXTHFK?=
 =?utf-8?B?NkxpZmpVRzk1UVVZYVZER2VWblZ3dzZWRXUvR3VweDNZNVBiVTEvM3lzU3BZ?=
 =?utf-8?B?dElxSkhXWSt2cnJTOUZLbXp2bjJSQjhDNTRkMU9qVmlYcFd5NHBWQ2JoSEhz?=
 =?utf-8?B?cFRvQlAxTCs1bndsWE44SjBjWG9OS1lyQ0ZjUFBjekZxNkZYNWdqcXQxaXJW?=
 =?utf-8?B?dWNTbzU0KzBrQldpQnh6TERCYVhJT0QzbXJoZEd4SGRNdXVobmVoNjFVNWlH?=
 =?utf-8?B?dTdWTjZaTTM5cnJ5Z3JXZkRZMy9RWDlGRklSQ1h5VFdCTUoyZDZqb1d5dkcy?=
 =?utf-8?B?TDVPV0VwQUZzWmlYTUhZcitPbzZtVDBHa0tvVzR5ekpiZmJsZjloWDFvSDVZ?=
 =?utf-8?B?ckN4R1pkZnNhbUhFSWtlSUs4TFFnRVF1N1gwbjhDdHBKWWhoczJVeU9FaWQy?=
 =?utf-8?B?UzZRd041N3ZLMC9yZ1RsNCtLdENUZWxtQmdoOXJrd21BNlVUa1EwUzBJek0y?=
 =?utf-8?B?Qks0MWgrbWJjMUNCTkc3YlR3TGpxdFhZKzdUdkticHNneEhyNVN4Y0pyOHAy?=
 =?utf-8?B?K0RLLzVJS2VrL0NMRkh1SGVYUTQ1QlhvaU9CVGQ5UHNVS0JONDJOcEF3Q1Bw?=
 =?utf-8?B?Q2QxU0dXTUZyZkJqWVRzWUNaMDFIb3haL1RzRkpqdiszZlljZFBjM2s2bHlQ?=
 =?utf-8?B?YzluOEc3VEdya0tUK3oxVXZFcFZjVUtvamxTK1NKZjlhZE1KZWlJTlRoWlNr?=
 =?utf-8?B?UHdSdTY1aUJqbERJZG1sbUJYdDNPL0w4eWRGYVVKS2V2UTJiQTZKWElneVRh?=
 =?utf-8?B?N0ErV2xBK21oNFVrdXlZNjcrU3J1WEFrMTlCUW1DZXJxaFNlZWZ0N1NCS2RN?=
 =?utf-8?B?di93K3lob3BOdXZtdE9WS0wvMmVPN0xWZHNaUW1ickIvb0ZzVDRjRGgrWUhI?=
 =?utf-8?B?VmRLdkc1ekJGMFV5KzFiUXB0SmlCRWRYQXU3ajA1bEZvbTFqbkppNEd5SU5r?=
 =?utf-8?B?U0ptK0RyK1RxK09MU2dUWE5oYWQreHNOMUttY2JwWmJNUUJXS0Franl4Uzhq?=
 =?utf-8?B?dlVmT1M5cWcxdHljNWhUZGJhaW8zY3FjYmkxM3hydVRMenRkUnBpckc5RHRp?=
 =?utf-8?B?SXFjdjdieDArcExmVS9XSC8vcStaeDhhUGRocE50ZzduVlBYWUNrRkpYakRv?=
 =?utf-8?B?OHRvL3l2a2dSbFdKU05rTEVpZi9ISUt6WFQ2b1lsUUkrQmEzamRoVDhxeWUv?=
 =?utf-8?B?YkJRSXpCZnRBb3Z5SHZ6QzJXWFEwVVVvL2MzK1lVVkp2QlpwY1duWExpdDVu?=
 =?utf-8?B?R2F3OFl0S1NMTlVON2w2bzhuMFdjaWZ1cWIyUXlhRFViVGZ5cVFmQm9IMWN3?=
 =?utf-8?B?QU9Udlk5elk4VkM0Zno5SExxaXJDanEvTG80VC9JT05FM2RXbkp2UXlHdzgv?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RPxU+UsC7cPT2Vb7PLrC4ktykOAAKGFRWFqkc7OScArCx6npNADIoaekPureR9q56Bttx7ryGqELme925TtUOaxMc8mgfFbBVk/AJw9epfRANu0jiC9AH0FdF2HBU71pRrvgL+2OlC5aE2U6rveL1juWgHoI/lkMLb/mue4C9z2cK/JJb5MzImSKsgqFnZYT/Ic1iC91484ghdrf4UeoRv+UCch5KIHOqlMbOtg5AsnB+QOrHyK3jMFNpfHu5ec3H6m59r5Lm5lCQGA4AduzNJ5G6FpR4BOqaF/FeJicVAVhjIOAwjoe9d1Mz0P4LvjGh/sZzR6SQhHPbvDNHv48w0rzozBIuWC/c0SmLRI1Fh2oI1Kj2wlGNuOhWat9RXSOobNitIJkf7ZXcpTvaEEl7n7nnse22nOSts3kkh2TME5TPlTBKMXsoVHW42EJ97nOkXLhv8gK+adLQwwbtbDEPds5AVw4hv6H3/3X7IozFcVkbGeplZ0lFAAd76FsdGHVvzBkOIimudRhMmiE08Iccrbezx9j1nTvBsaMsdbVhrBRL+f4nhqoIxDd6TtH6Cc3xe2eq+ImbAAxcHxmwI2+qBPQfJivLntK2rc0E/KglyqyXYfBwNm9KloWyK4mdSwR2XK10GKmPudmMZUcge+y1WouzE8lFWuys/GGYJYYItiWBUY20+h8VkmLNPi/R2ng6SzMjWXR7IRufhhecHkGf9u7X7kvpysUyQn0eT6hHDYH9UmzNUe0JTpayqPPUrfO6+21DhWHD+Twa8AAIS52jazLo1nyE8gUg5A7DGLLiyOZ6YVB9dCNpPRxawJw0ShA065KHsT3+PtfZzZvxoyMGH2cx1HH1mYdEiKFJHze6pc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5cc3c4-0b4c-4f58-ede3-08db7e64f617
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 21:07:09.7640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYoUD0j0V21ZqkK93itD5LFc5GzE4oD7kjno5OwLT9AVU6AgiLA+kwAUQxFsKaX8mXl+zWIVL7T7iNOvqc/kx/C0vKv6T4ikyTa+Jmig3UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060185
X-Proofpoint-GUID: NSFqZJlCLZgjWauj0kdtPP6fijZLVuWr
X-Proofpoint-ORIG-GUID: NSFqZJlCLZgjWauj0kdtPP6fijZLVuWr
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

+x86 qemu folks

On 06/07/2023 21:22, Moger, Babu wrote:
> Hi John,
> Thanks for the patches. Few comments below.
> 
> On 7/6/23 14:40, John Allen wrote:
>> Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
>> be exposed to guests to allow them to handle machine check exceptions on AMD
>> hosts.
>>
>> Reported-by: William Roche <william.roche@oracle.com>
>> Signed-off-by: John Allen <john.allen@amd.com>
>> ---
>>  target/i386/cpu.c | 2 +-
>>  target/i386/cpu.h | 4 ++++
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 06009b80e8..09fae9337a 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -5874,7 +5874,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>          break;
>>      case 0x80000007:
>>          *eax = 0;
>> -        *ebx = 0;
>> +        *ebx = env->features[FEAT_8000_0007_EBX] | CPUID_8000_0007_EBX_SUCCOR;
> 
> This is adding this feature unconditionally which does not seem right.
> Couple of things.
> 1. Add the feature word for SUCCOR. Users can add this feature using the
> feature word "+succor".
> 

The feature requires no specific SVM/KVM support, it's really just a bit
enumerated to the guest that's used to tell whether AMD MCE handling is
supported, instead of blantly crashing outright. So I think the thinking here is
that GET_SUPPORTED_CPUID won't return SUCCOR and the feature gets filtered out
if it's declared as a regular named feature like you do in the CPU models.
Making it relevant for any hypervisor kernel.

> 2. Also define  CPUID_8000_0007_EBX_SUCCOR : In this case, we can add this
> feature as part of the EPYC Model update.
> 

how would you set CPUID regardless of the hypervisor enumerates should it not
require active emulation by the host? I am sort of interested on what is the
right way to do this, as it would be better to do this regardless of the gets
advertised by ioctls alike.

> Thanks
> Babu
> 

