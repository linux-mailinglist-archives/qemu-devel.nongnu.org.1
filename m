Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0BB81CC6D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 16:54:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGhqH-0004u9-8D; Fri, 22 Dec 2023 10:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rGhqF-0004u1-Kg
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 10:53:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rGhqC-0005Jj-Iy
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 10:53:39 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BMFT6Rq010632; Fri, 22 Dec 2023 15:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=MAmJhjpS49q/BlK59jettEW1aAcnD8ibJF0/SivUPWQ=;
 b=Qqwt7Aa4NDdtGbYgDz2e5Y3u5PTU3PVb0bGiX8CZfjZGYu4YSVYTE4n0hOyr/lwD1TF1
 O0d+TO36gvTWGOGtwi3eR5oshDAA6Px+zLFEPlA8oVhDQB4JqJkgsDmghOUQrGTH2i9g
 cUih5UUIs4cuX11GPfZsKNJu0B7xoHvCn3bcz2M+jzPer2hljSQCJNGEo0jE/OpsFiTK
 F4NM7pWbkziKLZZiw5oLloR7OkDuwg7kn5yYA0cZIpkYxvNseA4w8KYFKF359T/Day3Q
 YJJwkoF5jtmrda3P+OHZ1OrjO3Mzc9BIKjLJggVDm8x76zva7aaFHwJZGNMADdAWf2CZ uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p4e1xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Dec 2023 15:53:32 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BMDvTo1004460; Fri, 22 Dec 2023 15:53:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3v12bm213j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Dec 2023 15:53:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRfiyYXUr5cYGpGpfEGxaJfUFMc0d5UsW4KVkkRouD3OEy89PX+JuUENZZomkknSODdNoX9pz/x5Ttx2DCQQEaCXvJNRmpNspEsYCro8+Mmq6tqUnBrMiBnfH+G/NQm1754h+Yb6/ruyM8rWyRLTL0RXgp+80QHXYM3cKWg3G62qrMIT/AQUtR5guiVAsSqG/oB0zeo6im5h4FnVzDItiehL5jbNu7ss2oEKCQIGeBqr0pHtInktVdOzCNsvEv7qpHevbw0/yiVyv3oP85O89182cCzNs2ZkxpoP66Yzj5nAIOlVMtgHcdhDYe+u9fnMCWDMYUlk8m5ahG8EvISLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAmJhjpS49q/BlK59jettEW1aAcnD8ibJF0/SivUPWQ=;
 b=GwCuUKMJNfdPT6HEnV54zkz/SQPKb3y33xMSHldmTtM9H/UoLqy6nGt0WpyuwRZ1blzyKnkmOsdIOmdgXdv/M++Q8yTgmmtO3Q83rdnnpx2UnU3lA4yg0D81u2gyX8Pyf1RBUb1ZXA1gYYa9GQUaAGGabAz0qmucKDZ7gYdN/oZb/r/QvK3tA9ZR6/gHe7CpC1fRAzOeEER/abN5xbUwq4QHAyPrX8c8y7RbmKfbz+UNxmkz7ckHFDAAF+EbGr1Oy91+WL+2KexTDuuh9KcAuvQpGHDJaFbt6Rq7hPQhPE+frUa8XQjoISbt2JEjjLfWyzy7FdZ3EPwjPkuaZgCGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAmJhjpS49q/BlK59jettEW1aAcnD8ibJF0/SivUPWQ=;
 b=CgZl/MgbLRWSBkIkFaKRznB5TOGswA8o7RFnWEfllhPU7N6ukWvxc1YUyjRWFmEH8owTP4LrtuQnWSf1Jtcx9vLJ6j6Vrn1aBF2sw9eH9W16eso0DOGX/YnCwouVopew+lnQI3IOmN+ceB7sky6lD1gBxp1c7EvLdnxJ3VIs/kI=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MN2PR10MB4271.namprd10.prod.outlook.com (2603:10b6:208:199::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 15:53:30 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 15:53:30 +0000
Message-ID: <9d613137-24aa-4323-aee1-0d38b91339c5@oracle.com>
Date: Fri, 22 Dec 2023 10:53:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 03/14] cpus: stop vm in suspended runstate
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
 <87bkaiig2s.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87bkaiig2s.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0649.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::9) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MN2PR10MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: a7803669-d321-4f29-887b-08dc0306249d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1B9+27cEIcDbfM8+d9D9bpOAoAlLVTChu92ZbqiaxQ0YeUpqtKwy/pngHWMMKLvFLpSX3gMtzb0bsSRN5Ws9eNOUKI468CKwILDD7hMY7N1ISyTFqDLoGXiX5eHmcMDesb3n7bjxHVarKo1bj1VICmhUc9K8VH99sObOx58LwEbs7hVW5yOdJxnLlviNdA+tKEn2gOhTbgcS4LsU32jwqz92ny4Db3f/w0mR/wWGk/T5XQ5RMFrXp+fFy7bj8vUPbwwOqGfZ/4RwIdq1fYhUZmhJOUg4Icb/KJ5FxAJ5dClOHtTrz626o8TqmIjezul9PHwU8UtKXY8fvpt7K6kvOiJOu+cQpTF8hgC5cDPkH4AvmlzmqLCsNtVD3/KBXcNLUOb8IZhzT5F/2GTB0ZGmY4BebWj0y9wS3HKOAFISGZdTG/hrjWBFLvQsUowHNYPnnV68cKUei99iJ5NaPnEJZBst9k/jr5XfOyXTE043z07fJtcsHpU8LuiKndc25NtfUGqK+0Hq0wE42wsbG62oow+pBMd0fK4X5tfFEF5EQyJZF3wWSP1q4KXA8ObtfnpZKOmzYBQGON64ga1Sk2dkzIrGnCEZNUV43wa09Gb1ZV9IncyxcgsoObBhqMmKaRx9ZoQcAqF1o0cbwUCh2KP3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(6916009)(54906003)(8936002)(8676002)(316002)(66556008)(66946007)(66476007)(83380400001)(2616005)(26005)(15650500001)(6506007)(38100700002)(44832011)(4326008)(478600001)(6486002)(36756003)(7416002)(2906002)(6512007)(41300700001)(53546011)(31686004)(36916002)(6666004)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3FLOW4rRkd3d2ZvK3MwSmVERUZTQXU5VmFJUEk4K0VuV0UzSXI3OUNjcVpa?=
 =?utf-8?B?SXZzRERBRkNTblhHTzRQdkpXSEY2dDU5akRiN2l1UktrNldZVzhYeW4zVXlX?=
 =?utf-8?B?Y1dWd0RhSGE3SkFmZnFXSWdGQ0xFOVpRblZGcm55Y3FCMDFnd2xDSlZYQ1Jq?=
 =?utf-8?B?clBOcWJOMTM3Snpkak96RmFLcXljRUg1R0VZS2VrRW42WksxSzJoem5WUDhY?=
 =?utf-8?B?RWEwTWJPMmkvMG5qN2pYNWJSOC9BdHpybVhRZzBCVVFraTJVSENIclBHOE5K?=
 =?utf-8?B?V0xCVUNXSDl3M1BOd0ZCemM5TTZEM3FaSWxlaDJEU1FCc3AyanJuNWhrMDhv?=
 =?utf-8?B?KytnL1A5VXJEbWREazNnYUlJR2tVTFVSK2Q0MnVmVCsrb3FXdm1CTW5ZVEhk?=
 =?utf-8?B?UUh4SnZnaGZoN0dsbkhtb01pMGw2QUhMNWh4NWdoZlpHZEJiMFVtSStqSnpG?=
 =?utf-8?B?WnIwelk3UGJ1WUk2ZDlIMURVWHJsUkpOMzlHcER0NTlzYThFK1hmazA1SEJL?=
 =?utf-8?B?VTlVMzVGWFZIYklrNk9Fb3VCYkhMblk0b2cwUk9uWDBFS2tMR2JPM1pvRXZq?=
 =?utf-8?B?WDJCcjZKMzhLV2Z5b3BtZE1YSTEyWThWS3NMQmQ1U0dtMmVVTnFKRk44U2xY?=
 =?utf-8?B?ZGxITDg1T2xrOGhteFFLVzNxc2hzUGN0WVFjOHRzQTdERzV1K0IvTXZxMUc2?=
 =?utf-8?B?UlJhWHBtaTRjQjhYdzgvbjE0VzY4ZkYzb1lHa1BRZW9TTU12cDUwN21mdHNC?=
 =?utf-8?B?aUhIR2pQRHViYnFMb2hXbFZDazRUYmlHTTJCTStlWWFSQTZ2VG9xa2xjOFhR?=
 =?utf-8?B?TlNsWXg0emJrNGN6YnVDY045Qm9vbVRsbmVyT20yYnJkemJDWWtDOE1OL01E?=
 =?utf-8?B?d1RTd08zVWI2Q0xaMHhCbjlBbGNtSURRc29XWUtVUjRDOWp6VHdOYXZvTjN5?=
 =?utf-8?B?dGlzMURVZlhXeUtPSW53SFVTVno4S2NiUThqU3IySE8vdzlHOXo3QlZoMkJT?=
 =?utf-8?B?Y2VrU1FIZlJvb0RGM2NJR054UnNLL2RDS1ZOL0JsTVNESENTQ0h3NENXWUVW?=
 =?utf-8?B?dUVRYWNKZXdEa3llVHdlcGdTbThXdVhyQjJ4cE5IMjVid2RVR3g1ckFwSk11?=
 =?utf-8?B?anZrcm52TlFMUlZ5dUF4dmpRei92OE1qWkE3UU5Ia2paODAvQmxpNElCcy9s?=
 =?utf-8?B?RExSU1NiblhqZGhGNXpmRnRIT1lmeWhOdHBTcHJadStFbCtDRnJ0aGtXbGN4?=
 =?utf-8?B?UE1VY3ZEOEdGYW5Ccnk1M1pnZHM1RTFjODhkM2RxR1lsR0lVYUs4QnVTd2kv?=
 =?utf-8?B?OTFBK1N1OGp1d0o4bEhQU1cxZ3lYR3dhQ2pFbzhsZTdGRmc4UCt5aHJsMmo0?=
 =?utf-8?B?WDhKL3dXUCs3WDA5VElpdkRxU2Qwa0lxZ2kwdWhPN1htSEVyWThsbWxTRGJ6?=
 =?utf-8?B?U2FQaTNwWkJLbDROUGRiSUdFNzZ3dGdLYjFiZHlJVENzenBtUU83ZEN2UjBT?=
 =?utf-8?B?MWo3VHk2VkRCSG9rQkFTem0wL1NQai9hZDhJOWVOWnkwNGlzWmkxV0J6b2FC?=
 =?utf-8?B?c3lrNk9WWWJNRDZldTJhdTBlTmVOZkVGSzE0UExtL0hjdUtUTGs5bXBUZ3R3?=
 =?utf-8?B?c3VSSCsybnNYSU10OFJraWhVYkxvQ0tTdVd5NkkxNkNQV1FUc1UwaXBsci9p?=
 =?utf-8?B?MEhpSGl3MGdUcEVlRGlxcVZVclp4MCtVeHBYZlVqMFVqRVNGVjVaT3JyTHNC?=
 =?utf-8?B?ZnJaOHZpTjc5cHNiTXBiY1YrMElhTnIzb0ZEblNWbSs5T1EyMVhvbnk3T3BV?=
 =?utf-8?B?LzR2Zjc4YWw4cm54UDBpeUFRM1lOUi9UVmppZnNjNEZXRG9JUXZGVnB3NXda?=
 =?utf-8?B?N1AwcmhvNlR3NmRvYld2VTVnK3J0dUhLdm54RjUzeUhqQ1ZXUXNXdW14VGhu?=
 =?utf-8?B?VEVuMUMxR3pKZFBzWUVpSUVuRXh5ZjRjZ2c4VCs3ZWllRW5zenZIRjRuQ0ZS?=
 =?utf-8?B?MlZRL0x3czZVWVVRazBNTlVMMVJTZkpPOXlSM3JrbUlhODZJdjZQWGNYalMx?=
 =?utf-8?B?VTVFTzdNdEFQcnltN2J0UjF3enY3UjNVUkVmejhlaWVPM251anhZQmxWaDVQ?=
 =?utf-8?B?ak9qT3VEYTNIcWpld0NpUE1NL0EwcS9ReFJDVktTY1dCWUFaVGlxbnVVajgr?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wJJInLsZGdwkxSKrN9+jm7B264nIONs8y21FJWgE8XjahPmLYmrw7yxqRhQ+yWEA80LeZoz7uLZJun11UKh3ToaKXM2Ir9PCbUvqX8geXr0gGdANW25o3B67/uz6Z5TPq+ryx+U/D59uzRB1IGo1bFZj7NPO6J6WRLfUyeEMD/4F4B73buvAU+dcyBWqEoyKd4ZTtK2M2+elki12ElnS8HbVV+2xTvPPBTBNI/rRd1iTI1T6n4ExVgvmr7vfa+rEipojcWIV9tWIqqBKkKH2qveyHnEQHPKIhg7lm7u3kXIgHj3zPpQ8lbntRqnB8VJ5CHQF/fhCNqeSkJELHMM60NN58dysVAmR1mp8ebUfIQSqj7n3OH6Gh8QQyXIzMlcyRqMk6nmIKt6PsEYeqWPbPoCylq3aKBs7+XOTxgbwOCiNOdhAPqzFRnCCej1g4oUeDit/0R6buyb/fU0Xrdur5l7paw7IHD6ymBCR4vi/v2USTwP55xcWbhJp4zYbuhd9ZXgoJLTIweSOmqmbU0hepi1XFAaDjEdXvXIJ0aLNcIOmTbWAjyhZvrUpMqeULHcZFGiJSf2xlHpspyCeqbExyzKwa0GOKM8InboDQ7ZjnIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7803669-d321-4f29-887b-08dc0306249d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 15:53:30.0817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zt08M4r4RNXGsEUOU8XUdda7FgcY7VmtuEv2mwwyuie27/dNZpxpRnnMYAwknfv3cIOPE7yLwobcr1q8uFrHp3Xnp+nHdytWZBPmzlug4MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_10,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312220117
X-Proofpoint-GUID: y8YB_y7MqaFLFIrs_tXw8QR0bE7Aibgu
X-Proofpoint-ORIG-GUID: y8YB_y7MqaFLFIrs_tXw8QR0bE7Aibgu
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 12/22/2023 7:20 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Currently, a vm in the suspended state is not completely stopped.  The VCPUs
>> have been paused, but the cpu clock still runs, and runstate notifiers for
>> the transition to stopped have not been called.  This causes problems for
>> live migration.  Stale cpu timers_state is saved to the migration stream,
>> causing time errors in the guest when it wakes from suspend, and state that
>> would have been modified by runstate notifiers is wrong.
>>
>> Modify vm_stop to completely stop the vm if the current state is suspended,
>> transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
>> Modify vm_start to restore the suspended state.
> 
> Can you explain this to me in terms of the @current_run_state state
> machine?  Like
> 
>     Before the patch, trigger X in state Y goes to state Z.
>     Afterwards, it goes to ...

Old behavior:
  RUN_STATE_SUSPENDED --> stop --> RUN_STATE_SUSPENDED

New behavior:
  RUN_STATE_SUSPENDED --> stop --> RUN_STATE_PAUSED
  RUN_STATE_PAUSED    --> cont --> RUN_STATE_SUSPENDED

>> This affects all callers of vm_stop and vm_start, notably, the qapi stop and
>> cont commands.  For example:
>>
>>     (qemu) info status
>>     VM status: paused (suspended)
>>
>>     (qemu) stop
>>     (qemu) info status
>>     VM status: paused
>>
>>     (qemu) cont
>>     (qemu) info status
>>     VM status: paused (suspended)
>>
>>     (qemu) system_wakeup
>>     (qemu) info status
>>     VM status: running
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  include/sysemu/runstate.h |  5 +++++
>>  qapi/misc.json            | 10 ++++++++--
>>  system/cpus.c             | 19 ++++++++++++++-----
>>  system/runstate.c         |  3 +++
>>  4 files changed, 30 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>> index f6a337b..1d6828f 100644
>> --- a/include/sysemu/runstate.h
>> +++ b/include/sysemu/runstate.h
>> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>>      return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>>  }
>>  
>> +static inline bool runstate_is_started(RunState state)
>> +{
>> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
>> +}
>> +
>>  void vm_start(void);
>>  
>>  /**
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index cda2eff..efb8d44 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -134,7 +134,7 @@
>>  ##
>>  # @stop:
>>  #
>> -# Stop all guest VCPU execution.
>> +# Stop all guest VCPU and VM execution.
> 
> Doesn't "stop all VM execution" imply "stop all guest vCPU execution"?

Agreed, so we simply have:

# @stop:
# Stop guest VM execution.

# @cont:
# Resume guest VM execution.

>>  #
>>  # Since: 0.14
>>  #
>> @@ -143,6 +143,9 @@
>    # Notes: This function will succeed even if the guest is already in
>    #     the stopped state.  In "inmigrate" state, it will ensure that
>>  #     the guest remains paused once migration finishes, as if the -S
>>  #     option was passed on the command line.
>>  #
>> +#     In the "suspended" state, it will completely stop the VM and
>> +#     cause a transition to the "paused" state. (Since 9.0)
>> +#
> 
> What user-observable (with query-status) state transitions are possible
> here?

{"status": "suspended", "singlestep": false, "running": false}
--> stop -->
{"status": "paused", "singlestep": false, "running": false}

>>  # Example:
>>  #
>>  # -> { "execute": "stop" }
>> @@ -153,7 +156,7 @@
>>  ##
>>  # @cont:
>>  #
>> -# Resume guest VCPU execution.
>> +# Resume guest VCPU and VM execution.
>>  #
>>  # Since: 0.14
>>  #
>> @@ -165,6 +168,9 @@
>    # Returns: If successful, nothing
>    #
>    # Notes: This command will succeed if the guest is currently running.
>    #     It will also succeed if the guest is in the "inmigrate" state;
>    #     in this case, the effect of the command is to make sure the
>>  #     guest starts once migration finishes, removing the effect of the
>>  #     -S command line option if it was passed.
>>  #
>> +#     If the VM was previously suspended, and not been reset or woken,
>> +#     this command will transition back to the "suspended" state. (Since 9.0)
> 
> Long line.

It fits in 80 columns, but perhaps this looks nicer:

#     If the VM was previously suspended, and not been reset or woken,
#     this command will transition back to the "suspended" state.
#     (Since 9.0)

> What user-observable state transitions are possible here?

{"status": "paused", "singlestep": false, "running": false}
--> cont -->
{"status": "suspended", "singlestep": false, "running": false}

>> +#
>>  # Example:
>>  #
>>  # -> { "execute": "cont" }
> 
> Should we update documentation of query-status, too?

IMO no. The new behavior changes the status/RunState field only, and the
domain of values does not change, only the transitions caused by the commands
described here.

- Steve

>    ##
>    # @StatusInfo:
>    #
>    # Information about VCPU run state
>    #
>    # @running: true if all VCPUs are runnable, false if not runnable
>    #
>    # @singlestep: true if using TCG with one guest instruction per
>    #     translation block
>    #
>    # @status: the virtual machine @RunState
>    #
>    # Features:
>    #
>    # @deprecated: Member 'singlestep' is deprecated (with no
>    #     replacement).
>    #
>    # Since: 0.14
>    #
>    # Notes: @singlestep is enabled on the command line with '-accel
>    #     tcg,one-insn-per-tb=on', or with the HMP 'one-insn-per-tb'
>    #     command.
>    ##
>    { 'struct': 'StatusInfo',
>      'data': {'running': 'bool',
>               'singlestep': { 'type': 'bool', 'features': [ 'deprecated' ]},
>               'status': 'RunState'} }
> 
>    ##
>    # @query-status:
>    #
>    # Query the run status of all VCPUs
>    #
>    # Returns: @StatusInfo reflecting all VCPUs
>    #
>    # Since: 0.14
>    #
>    # Example:
>    #
>    # -> { "execute": "query-status" }
>    # <- { "return": { "running": true,
>    #                  "singlestep": false,
>    #                  "status": "running" } }
>    ##
>    { 'command': 'query-status', 'returns': 'StatusInfo',
>      'allow-preconfig': true }
> 
> [...]

