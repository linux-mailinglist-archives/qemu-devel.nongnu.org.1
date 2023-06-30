Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F2743AA5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFC7x-0002Nx-QC; Fri, 30 Jun 2023 07:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qFC7v-0002Mz-7R
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:17:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qFC7s-0007kS-G3
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:17:22 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35U6FQdR028296; Fri, 30 Jun 2023 11:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=azagHk7GM43Z9Sh77HlBX7iUrHNM0A02fVNbJIWY5GA=;
 b=23vIVjHZ/yvSPp2G7BPEwPDe5ATgs1Bqw2JOhZHFQ7TxXWQXWgKagQM5453CH5zlDc9V
 Avbk26hcMvRZNv7DXzwGTNo4aNluR0xzOtZu1F+Cu+Vric2T8XUwW7FkpfHR5afb+tsh
 ppxFTLFSwxNOXw4ofXOfwxOCVXGoTyPRnRu5QBDKMDIOmLk24399Iwif+X0THLdMD7CV
 uL91fK92Xf05O0YN5XfD7OkuylpKN2LaXMyHnvwePa4F8Z32oTJ7/rh07crZvfAQnFx6
 H5R4STNI67+3aFAjbGu1nk49P291OOiQTJnO93SOmzQSb5BGNxGCVl96uWWKarv4Wqmd 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrcag2q8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 11:17:15 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UA5E5F029728; Fri, 30 Jun 2023 11:17:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8pyrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 11:17:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTpbkdScOH87e8CWxRLrdHsk7VWnvrekAy0DtZWW28I/f60yQQo+DbyYvfm7SCqWrMGu/TvEqxP2JcKg1QJKceXAg2x3SXQEYUfDQLl5317zKEcIB7xsVf3e8W7vnRs+giugdBguJKpOs2O1bdQ7nQi0hLqu/XXA73iXF3uCukW2UsxRjXgeuABYLqARExbQv/qcw6gmDGh4FJHeicu0/274uoAOLGvbbuZfG4XJT7l1ruXfbdkWqZxCuPRoJOlMTMnI8dtJxPgzal5qKs9RcEGMyE2loDi39yYZ9NvIrufhebkK0xEUyLmu6Z9pSHH46pFSQg0tot/boY8wGriwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azagHk7GM43Z9Sh77HlBX7iUrHNM0A02fVNbJIWY5GA=;
 b=YmaC250ZZbzAcumllWVnFy0S4M+fb5j0BybqgZV5sFV7yFEK7FDVeA7OMjSVk1nixVUu1oWygCmHLho+TSxBQ21I4chSATA/YVIkh2lCCDzyNzSW2IYJp9+245+eKgomYWO/n42h0DW7xbBoEzJjA4Qm30piVIKwz6YtID7alFIlc7LFTeqxKIpDOHXyevoNr2ECZbxfMUiu73rt/NlzSwZCLaDaegAu86EQn4Ww4MwfQPOLyCbr8ngz14QHHpzmvx5hhA977SOayhbIZRmkqqSHSzhelpiE2nrRVzgXJdXzS75oKWPzFWQScllcmhbkcP5zqmkZ5W4w2RyHP1UAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azagHk7GM43Z9Sh77HlBX7iUrHNM0A02fVNbJIWY5GA=;
 b=yAnTr8fh/xn8xcQSa6clUfWOGyW/OtxUNF7aYANRn47KCtAQHLAuDg6jIFBD/JhgaNqP14UOpL7QnN3OGw7tysocVCoPqJOb2OjZSSm5BcIH6NSh5N3cxU2lPOZyM6RJuWSe2rSAqw4nu/y04St7bgvuI6D6eWQzg1QCMpNoz6E=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH0PR10MB6434.namprd10.prod.outlook.com (2603:10b6:510:21c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 11:17:07 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 11:17:07 +0000
Message-ID: <f203dcf3-5af5-07ff-a1d1-59c70a31a8a7@oracle.com>
Date: Fri, 30 Jun 2023 12:17:01 +0100
Subject: Re: [PATCH v5 5/7] vfio/migration: Change vIOMMU blocker from global
 to per device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
 <20230630073637.124234-4-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230630073637.124234-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0220.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::9) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH0PR10MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db4b738-83f1-460c-5257-08db795b8a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaKOZgOCk+kNEm5JiFcd3G3OAkqD9d6xWu7wSj9AEEpoH8AyRYKSM/+NA3f8EycU4DYiGcQhuXXmJC99tjqAkN0P/YtSIPdwDQucPziKzpsItNYuPnN36s8HvnocqtcqGTwAitZYLt8GI8xMSqiWXOve8IlVJ+lDUeBkGK41mD2r/0edd8gXVKlUT8FL0QxMTRVlhMB5ut2ct40RNYEJOKIM1nl47mh/7rCYdc/raHJqkA19/CBi3eV2aYD9OH6fLyokF/ndAgizpeTZdOn3RFivqGJvL48/UXCKj8223PQ2UHoKycYsCtet4HOvexkelW1FfvJCZ9v/5Y/Vmsa7nZIIMEShAP1aay4TUIk8i5qkYnIaQzDegJgJFsdcsnFOk/rb60dNVhqN8mCPy0QbJeYJYPnHrUlJJ0sM/HtofSyC5aAyWaRw63LznIVKUen5fYdpb28upSo8ABlC+XKzjaMaJWpRu66VzsHLygS3l0/YN6st88YCB05Cg6OPk0nNzR4X9wN80Jz9vjHMpSuNnm+8+/Snjx9HXQKGyAluZ7nFkrDV4y6tJ4kzLcKYdQ2s/zWRcCdZND5xJQevKlvzmaXoRsx4Lwb6sp1l+z5Ifw1yPMjrezBFCZTCH1bsaYUM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(38100700002)(36756003)(83380400001)(31696002)(86362001)(31686004)(8936002)(6486002)(66556008)(6666004)(41300700001)(66946007)(66476007)(8676002)(316002)(53546011)(26005)(4326008)(6512007)(6506007)(186003)(2616005)(478600001)(5660300002)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzczNE5kVG9yM3ZBR0ZhWFh5L3QvcFBVclMybVhjQjRsVjJaQmZmamliWlZW?=
 =?utf-8?B?ajJPRFRYckRYMHQwV015Q0VZN2dXaXpDZ1JmZFBPZ1dvOEx1ZlB3SzRHVUZJ?=
 =?utf-8?B?TmZ3cWdKQ1dmV1BuWlZaRFp2Z2FuTzlOSEFrNEsyQTR1Z1FVQW5HLy90Zm9I?=
 =?utf-8?B?NmZnVTByYjJLbjVNY1RYV0x3NFE5b2lKSWc0N2hENHBSeThwZkVDUHkrM1F1?=
 =?utf-8?B?Y2QrR1Bvc2JLVFNHU1BOUlFxdUdyWVZSYlhieVV1M21QYzZFQXE4aE1VVTVV?=
 =?utf-8?B?UnErbFh0ZjhvZDJzcjRvS1RuWXJGTnB5UTQ5TThua0lkUUdhOEJ0NzBKK2dF?=
 =?utf-8?B?aXV0TDh0bnJoRGp5M2k4c3hiWXRGRW1CaVNhSXFjcC9IaDB2a0xSOVVyTWNy?=
 =?utf-8?B?eUJ6Q1l3Z2R1b3ExY2xzYS8veUpaR0tJeGFlVGZrWll4V0ZFUTA2cHg1SUtV?=
 =?utf-8?B?azNKQ1M4OGgxVFNWS0RURjA0b21rckN3cFREcm0vTy9QMTRaZzRXNXZIR01V?=
 =?utf-8?B?TVExZzIvQ04rUkF4K0tvM1Nyd3BGMU9hQnpUN0w3WEw3SVlZOFhZL3dId3dJ?=
 =?utf-8?B?dmRtdXdaaW1Qenlvc2tRU2xQWWZ1VkNBSkhVaksvQkpPR0VOdEl3bFVIbVZZ?=
 =?utf-8?B?MFZpd0Q4TWN4RE9HVmhtR0tpZnUwbGRmdGl0emJsMFg1dGdNVVhmNnI4MHFi?=
 =?utf-8?B?MnFnNU1jSHFVVFRSVGNNV01SZVJuUUZKMWQ4VnV6YzhWQTZORXJoang4SUgr?=
 =?utf-8?B?MDJ3RVZRMi9CdXRLUlU2NmRHRWl2Sm5UUklqM3ZaQUowVjAxc2owZUtaUnZh?=
 =?utf-8?B?VzdhajR4dFBWRWdjVWxlc0tKdnkzaFpiYlJHUUFJTjZFeGExVnFLOWdPVlVT?=
 =?utf-8?B?RkY0VzdBTml4QXcvSDVjeUVPSWYyQUNHR3NEdXBKbEhEZlY0TFRwamFSeXVY?=
 =?utf-8?B?Qko4ZUVWOGxWaU44dlhKc1dPRGRHTk1tOXhteS9Jd2lHOStUVFRiMHNuZ1Zm?=
 =?utf-8?B?bFZzb21wYVh4RkxzeHlzU1Y0VzZkd01ObTMwL29yN2pVTW4xUzBtTk5DNFNW?=
 =?utf-8?B?WWVPbk54a3VESHZQNkNqK3drRGlLZ0dnOWlXYUZUendQRlRxakNwUGQxeVVD?=
 =?utf-8?B?R0JsV3AzcTlKK1o5UWdwdnhQQU41MFFQR013VlJVTDF5cmxyYVc5U3BjMFFz?=
 =?utf-8?B?RHNPVE45cFZ3dDliVFV0dXI2S1NjZHpUczErTDZhVFpyV3QzYkJqUU9pdzk2?=
 =?utf-8?B?cjE4SGFlMDVaSTZyN2tiYXdxQVY0TFUydUNFeERBYkdvbmc5bHdMOU1IU2pH?=
 =?utf-8?B?MmJUNEJleWl0dzVHRFROMTVFaWRkYmxDbWNEUXJqOW1XUjBENmJoR1U5KzZ0?=
 =?utf-8?B?OVY3cVpxR3hmVU1NRm9ybHZrcTF2bU1RQmhCZ29Fei80M05zc09VZXBCQjlh?=
 =?utf-8?B?TVlueFNIY0tjcTc4VFRESUJWTGhMdXNVOW14MGtFTnpWNnNjeFhuMHloZUg1?=
 =?utf-8?B?MVcwYnU4a1gvRE1rOE13NVFRdlludEpDbjVFRmdNS2xrYmlVRk95c1dOKzY4?=
 =?utf-8?B?K0VzZHNrazBTQjI4UjUrVkRBM2dIV3NadkZiWHhtK3F4Q2FiU3pBMm4vdURk?=
 =?utf-8?B?R3NIeitMZjhPV2UyMjNYaFlNeXdOMnhFSWxKendtckpnVG4zK1ZKSUxDOWR0?=
 =?utf-8?B?TmE5K09KQkJMS0xsV1VibDJoenV3ZTJrR3dkOVJsOTZyUWNCM1l1c05sdUNN?=
 =?utf-8?B?OGg4MVJpWElwa2luQko1VHFweVR0Wlo1ZFpUTmZPUVhkQzhlMWpzaWw0aThv?=
 =?utf-8?B?dkNId3FuR1lYS1Y1Wlh2KzUvSHRGTVlXWjgxSVY3RlB0K3ZXSEhkZ0prTDkw?=
 =?utf-8?B?TjhRd0RhQmU5aHhBUkJ2Q05IU0Rqd3BUNTdwQmgxN05aQlFyQ2xHOW1ZSjJI?=
 =?utf-8?B?VHpIUno1NUF3MHlMZlRHOEF6S3JBYmxmcTFNMFBEKzB0N1Z5QkdqcG93SCtK?=
 =?utf-8?B?ZldkUDJqY3F0bEo4RmEwT0VKYVNnejEyWWhzUm9SY3FCRHhvbUhPK0FPamRK?=
 =?utf-8?B?ZStNdWQrSmRMSTI3UzlGU28xRkFxenpjcWNXYUE3WElzZlIvM2wybktFKzFh?=
 =?utf-8?B?MGpsWWxQZGwvOTZTcUs2ekh5V2JuN0xwUGVGc2NLc0Zzbzk3b2JGSTFOVEdS?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5QcuGeS6tDz4PkfUoizsRwYRr16EfkNc0giwPYRiCpEyzriXdiwIVQhL4GdtbKV3lCp5EFH5Ugs4YXXSix6vLxAv3olxhDR81/QskrsmQ0urfQ4FS4XQqBeoWgqSlbzLmgVQGfLE6L+k2Go5GklvRZ0KILZ3uokZNSmPyYbKxNcnl0aKIQDpykLsFyS05oUueNBr4JGDhk/7pQCfyogS9b2T/MCchCnEnK9M6n+uk2NuB5lQuESn+1ORZoSfX6qN7Th+W2seoOG7hxQxmHqSUJQKJ0tcB4cy4HWTpyI7wbND6uzttQu4WXHQMn8nzb1396ULjRL2Q3DzHWY8YTiRO9fIctNZHb0+q/ECehyABU9hPwwEwi5/dsUjsvcdwIeI9hD5Q/gS+sAvXHIinle33h6Qj2rrePsoZOCBUdoZakOo+hVmFR6DVlyNgiA2lcGduZSbHs4tH/fLjZMOc7gufBkB3K4EuJUbZZnCiE+ttugPzfM9ze333a/pN9fi3t1VJA2gKT27k2IcEoGMeI8R1en5IhtKN6BecnRG7F7d4OGcUjp42/Ky1Us2YWXAdw0QeTAny/muA169FNVNP6Q9gnsGBiXmCnDGr8tSf8pX+0/i08u1ycwm04S4kSzJuUlJBd22zhr9m7283I7bP517/UmrV+qzl7MOYu+51RxrKmeFEZLh1nKxXA4OHSPfHOCSPkFuJA3zR3M+DpTeNrKw47ShqXfc+6ZXqq9TpAXZFRaeDZ57zJ17kw9pKdMGIkp+HugDntM2R/Cukwz5thAFuiNSrbqfE7zJF8n71oSs3KJ6Gf+4mO+IFttiW9CK7cs9/LHIwMfQt66Mlj4oA5tzvQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db4b738-83f1-460c-5257-08db795b8a2c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:17:07.1667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsgBlRDT7yb+uH3ARouHCSHeXz/uCMSbWMFQBvUUzzN/Ofy0it26/B6R2DSrVrsW8BEPKVVrBhhCKDjU1oRCyS0Y50WBooAyew9qrPS/PAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=834 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300096
X-Proofpoint-ORIG-GUID: 48SCPGbHjuOFmOxvivJJRv0-lx92IycK
X-Proofpoint-GUID: 48SCPGbHjuOFmOxvivJJRv0-lx92IycK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 30/06/2023 08:36, Zhenzhong Duan wrote:
> vIOMMU migration blocker can be consolidated to per device default
> blocker, then some vIOMMU global blocker related functions and data
> could be removed.
> 
Perhaps expand to something like below on the why it justifies the consolidation:

Contrary to multiple device blocker which needs to consider already-attached
devices to unblock/block dynamically, the vIOMMU migration blocker is a device
specific config. Meaning it only needs to know whether the device is bypassing
or not the vIOMMU (via machine property, or per pxb-pcie::bypass_iommu), and
does not need the state of currently present devices. For this reason, the
vIOMMU global migration blocker can be consolidated into the per-device
migration blocker, allowing us to remove some unnecessary code.

> This change also makes vfio_mig_active() more accurate as it doesn't
> check for global blocker.
> 
Cool callout.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

With above adjustment:

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/common.c              | 51 ++---------------------------------
>  hw/vfio/migration.c           |  7 ++---
>  hw/vfio/pci.c                 |  1 -
>  include/hw/vfio/vfio-common.h |  3 +--
>  4 files changed, 7 insertions(+), 55 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 00fef5aa08be..a8439447b990 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -362,7 +362,6 @@ bool vfio_mig_active(void)
>  }
>  
>  static Error *multiple_devices_migration_blocker;
> -static Error *giommu_migration_blocker;
>  
>  static unsigned int vfio_migratable_device_num(void)
>  {
> @@ -420,55 +419,9 @@ void vfio_unblock_multiple_devices_migration(void)
>      multiple_devices_migration_blocker = NULL;
>  }
>  
> -static bool vfio_viommu_preset(void)
> +bool vfio_viommu_preset(VFIODevice *vbasedev)
>  {
> -    VFIOAddressSpace *space;
> -
> -    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> -        if (space->as != &address_space_memory) {
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -bool vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
> -{
> -    int ret;
> -
> -    if (giommu_migration_blocker ||
> -        !vfio_viommu_preset()) {
> -        return true;
> -    }
> -
> -    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> -        error_setg(errp,
> -                   "Migration is currently not supported with vIOMMU enabled");
> -        return false;
> -    }
> -
> -    error_setg(&giommu_migration_blocker,
> -               "Migration is currently not supported with vIOMMU enabled");
> -    ret = migrate_add_blocker(giommu_migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(giommu_migration_blocker);
> -        giommu_migration_blocker = NULL;
> -    }
> -
> -    return !ret;
> -}
> -
> -void vfio_migration_finalize(void)
> -{
> -    if (!giommu_migration_blocker ||
> -        vfio_viommu_preset()) {
> -        return;
> -    }
> -
> -    migrate_del_blocker(giommu_migration_blocker);
> -    error_free(giommu_migration_blocker);
> -    giommu_migration_blocker = NULL;
> +    return vbasedev->group->container->space->as != &address_space_memory;
>  }
>  
>  static void vfio_set_migration_error(int err)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 09fa4714a085..80509958f0d3 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -883,9 +883,10 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>          return ret;
>      }
>  
> -    ret = vfio_block_giommu_migration(vbasedev, errp);
> -    if (!ret) {
> -        return ret;
> +    if (vfio_viommu_preset(vbasedev)) {
> +        error_setg(&err, "%s: Migration is currently not supported "
> +                   "with vIOMMU enabled", vbasedev->name);
> +        return vfio_block_migration(vbasedev, err, errp);
>      }
>  
>      trace_vfio_migration_realize(vbasedev->name);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 31c4ab250fbe..c2cf7454ece6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3255,7 +3255,6 @@ static void vfio_instance_finalize(Object *obj)
>       */
>      vfio_put_device(vdev);
>      vfio_put_group(group);
> -    vfio_migration_finalize();
>  }
>  
>  static void vfio_exitfn(PCIDevice *pdev)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b3014ece2edf..3c18572322fc 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -227,7 +227,7 @@ extern VFIOGroupList vfio_group_list;
>  bool vfio_mig_active(void);
>  bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>  void vfio_unblock_multiple_devices_migration(void);
> -bool vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
> +bool vfio_viommu_preset(VFIODevice *vbasedev);
>  int64_t vfio_mig_bytes_transferred(void);
>  void vfio_reset_bytes_transferred(void);
>  
> @@ -254,6 +254,5 @@ int vfio_spapr_remove_window(VFIOContainer *container,
>  
>  bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>  void vfio_migration_exit(VFIODevice *vbasedev);
> -void vfio_migration_finalize(void);
>  
>  #endif /* HW_VFIO_VFIO_COMMON_H */

