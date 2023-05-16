Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335307049E2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:57:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrPk-0005y4-Cm; Tue, 16 May 2023 05:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1pyrPh-0005xb-OG; Tue, 16 May 2023 05:56:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1pyrPe-0001f7-4x; Tue, 16 May 2023 05:56:13 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G6TC0a018842; Tue, 16 May 2023 09:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=H6jS1OUNMIOjs7n47GRz2/npoXe8CS+YK48jQRLJags=;
 b=i8J3zZZRpAjnFg43wPcdIZ/GtIdP+ZH9oj6+9wLCfJx/ltUi94OU+LR2+sbo+blxM2QR
 /KQaXf9T4nm84+ku3tSN8BDpxJ9mDBKLdQ1pRMi7tlYSrZ7efIsH5/Ya/HJa8jMHgqfH
 w++AqwJ5yrhrbkk/EAbZuowhNhnsC9gGhECKbiehjv4lpFUynIWgSf8JHsMBGR6boum1
 yBlxhgqNr8IS/q5BTKWfxTOo/yEZQ+LtZt44BiZIa63uTy0gLM8XR1nsYfKJxIMxowZ7
 kkFV8fq3e9bBXkK87IH1ZS31/NARvEWJGACwyyssJ5UilX0kWFhDknP23b2JVgXap982 qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdjrxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 09:55:49 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34G8HcWp038996; Tue, 16 May 2023 09:55:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj109uk1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 09:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG27hiKpjkC4TQO5NlOM/4XxgkJrr0Z6/d8nRb4TCjEzCXj8FFO7wK2ljYDoW0pP/5QV+9ROjSXVsY06sMhx+CMbkNChmB9rs9JYT31WXrM1ivEkjGHzSM8wInuCkeHjaBLw8rbGqtrZegMLPjYMW76xrgWSZg41WIm71QEzEHLV3s7dejsesJzgtmECjuN3bugnMuR/2Azh0Lo054RJWaMkw0qaAHWLYRyvYF3bfjnTpwHbn4eb6sTNdsEJNIE1cBs21w715PKYXGCy8JujSRnLPQQ3vBukN0ELgaJ/0F82kpA1AM/ovFskLUtK8EeF8Ph11PvZs2Qij0YateMueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6jS1OUNMIOjs7n47GRz2/npoXe8CS+YK48jQRLJags=;
 b=GyV9ytVoRz9F8M9QBoSfDMCo5wrzmaLwgrwm1JNCedhX9K7SHdYCN7Bd2WoMpAJHCyNaL7wZSBVNLRjgHraSgOzq2e+ZZ7GMVbp7NtqYlsOWJylSpmiywFlLEXvN6DTHWC0dItEIyXy36lNAzXZ3MiJKe8On0JEVLn1MIKItRJejNX/Df18xFIqMfxUa42kIc1koIh4Z3uOfbeNDnO0jEck4Hp2yJwCpU6/M8Gg8J5GGKJ9hhrTAfM3JoRRaVTvZZImgsx6VRcJl3HzqNFsfeFFAr0zuK3u2mJpyWybJAFIE4nyk4WAF8D5DTvgP81G5PhrmZ+xQniRJQuy0fRVkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6jS1OUNMIOjs7n47GRz2/npoXe8CS+YK48jQRLJags=;
 b=rHXTJXCxXBxCZFOjZLRLqfKh5O1B+ANnI2hKGovq0N+dugpP5vMR58KKhje7GgR3cD89m2hVyn9lGM+bEA24SZK5ClVTzpdQZMVt6h6ZBj6gysysBmZ+cuGQoIrMegt6CA9IxSCxyv5NA3bYY4DZGsleLG5CYkluI0s1qE/1rT0=
Received: from DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 09:55:46 +0000
Received: from DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::738c:b283:c54:57c0]) by DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::738c:b283:c54:57c0%4]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 09:55:46 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Greg Kurz
 <groug@kaod.org>, qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, John
 Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, Daniel Henrique
 Barboza <danielhb413@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, David Gibson
 <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-block@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 01/16] migration: Don't use INT64_MAX for unlimited rate
In-Reply-To: <874jocy6gb.fsf@secure.mitica>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-2-quintela@redhat.com> <m2fs7w4p0u.fsf@oracle.com>
 <874jocy6gb.fsf@secure.mitica>
Date: Tue, 16 May 2023 10:55:39 +0100
Message-ID: <m24joc4n38.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0237.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::20) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|PH0PR10MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ebf4ec-d9d0-49dc-50a9-08db55f3b814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUqDz5hc6FQhprkaSOPb/kuhupfJwc0wkogkkn0A6tke5CGlDVnxnntc/Ogek0vWbnLEmSR80mocUv0Kbe8cvcoYRYaqPjTxRlCuL/EwdHuJLfuzU6H8yTL7bF248CcIsHoZW8D9r7uckJljEolJdPckymrYt4wqD7DmnnsLUKK5pC99yQ4ao+yQX0tZtAX5tYxrrEHnLon5FcY5kM/yyKaTe3I2lLxhvBMd52Qvtva8YLp4P760OHbCooQYhWUco/zjApHyn+N6ZtifnP4kfNN5tWq3OxKt4eLrBVes6Ub56M/kc41qaopo3di6gITKciu7fZ/ChmjOpvYi5KNRG2acroM/3P6FIAd4XMYC9OnYozYcJPjmsp1v4UDgTZCt8U2Wyz0FfE2VnHGmJIuuuTg56EtFAAKPI/QMOTf1O3/9fJUjNT6SpvG42CXsAZmcCnIr2ADUlSWUq6makEK3e2LoU7OL/vZ76SXjzL8fXopC6OtBsenkl4euJRDYW84mZR4FqbKuc/nZlosnOPXqFrniYM+2W6C1/u2VUDhz0SXr98cQT1vtxusCeiB8E+lw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4926.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(36756003)(6666004)(6486002)(2616005)(26005)(83380400001)(6512007)(6506007)(186003)(44832011)(5660300002)(7416002)(54906003)(38100700002)(86362001)(41300700001)(66946007)(316002)(6916009)(66476007)(8936002)(8676002)(4326008)(66556008)(478600001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3dLSHptWWpCQjNJMWZZZWFQOERhakNzRUxvM21LUnRQS1ZpWkNYUENOZjhP?=
 =?utf-8?B?aFRMVmRYUmNCVVJhRFA0aGlxUHMzWllEeW9jZ2psQ09Cc3MzZWxiQ09lcmNQ?=
 =?utf-8?B?UjlMMVMyYTdnVkV2a3REUXJGNHp2dlEzU0dSN2pkUGs4VXdIQ3dvOHRZMExL?=
 =?utf-8?B?ODNOeXF1OGQxcTNXUFdheml4bmU3SG95V1Z3czAyaHpFZlh6RURzWldKNjY3?=
 =?utf-8?B?OGU2Um02WjVheTc4NnFUSjBrZjNaY01zZTZPcy80RVNBSFpDeUZZWkUyb01o?=
 =?utf-8?B?UlZPRkx2aG8zbTJtTEJMOXpUanExQTBVdWhKMDRHYUdGcFdnNFpUL3pnTWV6?=
 =?utf-8?B?U0orQWQrVWdKY1lZeW1ESHJhcS84UDJNTmswbnNqSXJXK0R6dC9nMzR3S2g0?=
 =?utf-8?B?SjM5dkwxdEdlUWh1RTN6NFpUN0tZdmNMNzNCSEhnZzV4dlZVYXVjdm5CNVNE?=
 =?utf-8?B?K0V6OHJrZDliTjJFQ3p3bUFqVnFacWtpM0llcFlvRWxZZ0dvT2dtcUZGV2xr?=
 =?utf-8?B?TmVaUlBGS2pGYUozY2RidWhUTGdheEJqa3RiODJtbjVVMmRzaEJOYXRjcVJx?=
 =?utf-8?B?a1RVK1FuNnhDb3JWS2dWR2Y5REZyVFFGeXFwSVZMUER5N3d6LzJoNzlTODN2?=
 =?utf-8?B?UytDNXNjcXNoRFlESEw1VE5yOVRzZ1ZCd01kaEtHNjFaa0hDL1NKV0FUVjlM?=
 =?utf-8?B?M3lsLzJYNTIvdmFET1NxblVTRFBRbmVxRmtBOFFsMHBFQm92TXdEb3ViVC9s?=
 =?utf-8?B?TmFhclBKcmg0UzlrcTdieFJWdGc0SkdRNkc1ZmN5SEJJU0pWOWZEOXZudFFP?=
 =?utf-8?B?RHBnekZSSXBXQUloNGl0dDk5SVBBQkl3S3hvRmFQeGVCWmJ3MDRySDh0ek0z?=
 =?utf-8?B?OUJFNUdCVmRKT2Z2TGhnOFoweFg1WFdXM2t2M2phV2RXTTgwdGVKQnRSNUdL?=
 =?utf-8?B?NHJvOXl0NGpqdnh5TGdFSlAxblBTdmN5TnpLMDVFeCtLVmpNWjhQMWRiZ0E1?=
 =?utf-8?B?Z0ozQmRMWlUxTjhCam55Rm9zc293MHAxRnY4SzJud0V3eldReHBLTkg5L1Ey?=
 =?utf-8?B?K3NWRFFFRmJYK0VoZDRoSnc0czg2RW1BcmRIcW9TOG52ZlNsSnV1Ti9rTnBR?=
 =?utf-8?B?b3VZQXB2UUN3NkdCeWlQODZ6Z05oSlkwQ3ZBWnBsS0R1dkltS09VSVdGTTkw?=
 =?utf-8?B?OTlHT2hYK2pDSFFTamlWVUhuMHQ2NXZPekdhRlU3TUpPaHg0elBpR3J1QTZ6?=
 =?utf-8?B?VnR5amF6aG1WNmszczMwRlY5cGVEWktmbWR6NnRRS2x3cG9EUG1uTEZlZFBz?=
 =?utf-8?B?L3FxSG1NS1FPdnM0QWNxZVBoTVBhS3BTeTJqSHNpaE1lTk5STjdmQ2t3RU1J?=
 =?utf-8?B?aEFxWG0xT1RqMUE4T0lHRSs1NHZGMjA1ZHg0alN2TFd0RFZQSlpYaUcxdkpm?=
 =?utf-8?B?anI2QWdPdW1TajBaT3B1RVlLRmxua015SUR6Q0NDSDUyMTVPUnY4aWlVQnhH?=
 =?utf-8?B?SHFDNGVOZCt1S25oTlk2dGdLZU1GWDlsN3RMTFdoSm5pMzBsV3FmTmVEcFoz?=
 =?utf-8?B?QWdwNXdVZ0VtUHFJVDlkWTYzNzl0VnQ2SkVyOG1MVlMwK3doSWRqNmQ1QlVk?=
 =?utf-8?B?aXRydHF0eWZkQlRSQTVCSmpSbW82emVqVDFkRmxHSm1Yc0YxZ3ZsTHpQcTdw?=
 =?utf-8?B?REZ5M0xUeXFMRjBJK085QmlvMFFPSmRLQ1VKai84cnVjekh1WFdITXlXbzFq?=
 =?utf-8?B?QVdoQzhCaUI4UkdHZ1o1Y2V6c2QvSUE2bnN5VEs1eThrTXVnRE1Wc05IQmgv?=
 =?utf-8?B?WFNmZ1crWmdQd2ZXSXJaWmJPVG82dUhuS0ZTbm0yaEVGMXhDK3lDcjhodHlS?=
 =?utf-8?B?TU1PRG1oaVZ2a0NLL2Rjc1V4YVVBaVA0N3pJZ1NZQ01YdGp1QU43MklhbkFi?=
 =?utf-8?B?dmVTdmdpcGZCZWM1UDV6VXZDNHR5VzZWSGptRVhDUUtFbllLNjJKZ3FZdXVD?=
 =?utf-8?B?UlVFWlhJZ2lJeklhMGtwaUJ6dnk2bG9wNDVPMnJIbjcwOVdNcmRTS0FXMGRP?=
 =?utf-8?B?bHhRaG5uSHlrRVFRem1LVVRoYkpvNDN6RkdJQ2wvS29vYlM5MXB5QllKdk5u?=
 =?utf-8?B?di9veWRJQnlnbEJGVndnQUk0dVd1Mnp1bkphUTE2RWdLOW1LWUE0NmREbTho?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c1gvOENYaXZxT05pQUFQeDlOTDNHaW44dG5zdnZDQTZrREs4MWJNZ29lc3Fi?=
 =?utf-8?B?T2Rhck5vMlNYSmRDbHZMd29YVzJ0bG9RTVN1ZGhGNEhLQkZVYk8wK1lQcUNa?=
 =?utf-8?B?NkZTSnZBc28wOGdxQ2JiMnBvSTd1SjI0THliZzNVTHErazU4OWtGSnIyT2Np?=
 =?utf-8?B?M2lwL0pzZWhvdmpXMXBaYzBuK3pnSGUxcjVrT3Q3ZkRNUEdVUW9GRVIrcWIv?=
 =?utf-8?B?WFlDb3VKdVRNTWxMbXlnNFljR2FFQVlOdHpidmlBL0RZUWpVZWNCZU0rcjZn?=
 =?utf-8?B?WUxSN2k1WU04dXpxMERqUUVSTDg4d2NRRkd5eThwSE93WmEySjVmM1gvTi94?=
 =?utf-8?B?T2xMV3lpYmpUOGpJenU3TXBpTjl1NUNLc1J1TXpYNlJ4Ym1DUlQrK3dJUDF5?=
 =?utf-8?B?K3ZVVmN4U3J1WUhXMnNGQVZLTytiM3ZkRlk1ZjJLUUMwRXM0bDJsbUdZbzhx?=
 =?utf-8?B?bFpFdisvRC9YQ2dJeWVkbXF2dGhObWlRQ0UyNi9iUDNFb2djUHEyY2pNTW0z?=
 =?utf-8?B?NHdxUmhsSEdRcGxlOEg4dzRheVRWQk52MjQ0a2NwRUNiMHFKZW5LbGQzRXFr?=
 =?utf-8?B?REk1blVWQnhHWXBMYUxaOUd1RkhrTmZCQlluVVhSYUF2UDg3V2gzeEhCWXJI?=
 =?utf-8?B?SnpWUzlGT3dsbDAvYU1kcmZkditOeDVIclQ3MzNCM0xBZjZ1Z2s0d3p5bGx1?=
 =?utf-8?B?NDN6TStjc2lxUnlSREhYQWtuSlRLRXJ6TnRwWWw4V0V5bXplbVl6RWZ0K3Na?=
 =?utf-8?B?ajQ2bnQwaDJnYUZzODEvcDViUG9CZlBzSTQzSjdaMFpQL2l4MTVhN0xFTEF3?=
 =?utf-8?B?QnRSNjFJbm5sVmhOaE5Mc0tuaHNzYzRzcXUxNGYzQk5oSmFDUnZhcmJQYVVi?=
 =?utf-8?B?SUc1VUlYRVozam42b3MvN1pjSTlmSW5mOWZSdGR5VDk0cVBSU1k2Zy84bkNT?=
 =?utf-8?B?bXR6eGN5M3FxVTNuTjcxYm5Wb3ducEtmcWlBVURNTHY5aEltazd6MUtMTTVv?=
 =?utf-8?B?K01HMXlaaHdPdVFPaTc5WWdERHZrWDNwbHdsN1VtN2prajk0MUdzcnZiOWxz?=
 =?utf-8?B?bUJGb0FBUW9mb3VPTmhQcXVBLzVWcWtmT0JxSWk3bmI0V2x2QU5LYi9XM1Ru?=
 =?utf-8?B?SC9KQWZRT0JRSm5UV21ZRjM5VHo4bngwQnQvWDQ2c1ZMQlZLVm9lT1U3QmJt?=
 =?utf-8?B?RkNkMmtzRnAyWDVodGc5dUVSSkZ0SGF3ZXhJM2dzZ3plUGxEVzNWNVJDbjI0?=
 =?utf-8?B?L3psRGVKR1VlVGNhMGtuTTdiK2srMU52M0duMzh4eEFMV0dXdEMvRk56Q1Vh?=
 =?utf-8?B?bGJRSkRLVHpmanRaM1gvNmxRME5oVlBOMkNMdXJLMXMxSk0wanBuSGpLQ0s5?=
 =?utf-8?B?OG4xalN6RmhHd0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ebf4ec-d9d0-49dc-50a9-08db55f3b814
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:55:45.9485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgyIJfC3EXThSq9tWI+yCUJcFQQq1PSVwDjVbbYT3DKLLEcEAImRuzhWZpXS6PUrbU37rZFmuuoewM3l+2+AQRLO7w93sFb9a+XDtWqwtME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160084
X-Proofpoint-GUID: FVlbIFdCwuDLjkjh9GW6zi4Mwi0FaEJb
X-Proofpoint-ORIG-GUID: FVlbIFdCwuDLjkjh9GW6zi4Mwi0FaEJb
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=david.edmondson@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Juan Quintela <quintela@redhat.com> writes:

> David Edmondson <david.edmondson@oracle.com> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> Define and use RATE_LIMIT_MAX instead.
>>
>> Suggest "RATE_LIMIT_MAX_NONE".
>
> Then even better
>
> RATE_LIMIT_DISABLED?
> RATE_LIMIT_NONE?

RATE_LIMIT_NONE sounds good to me.

>
> Using MAX and NONE at the same time looks strange.
>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> ---
>>>  migration/migration-stats.h | 6 ++++++
>>>  migration/migration.c       | 4 ++--
>>>  migration/qemu-file.c       | 6 +++++-
>>>  3 files changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
>>> index cf8a4f0410..e782f1b0df 100644
>>> --- a/migration/migration-stats.h
>>> +++ b/migration/migration-stats.h
>>> @@ -15,6 +15,12 @@
>>> =20
>>>  #include "qemu/stats64.h"
>>> =20
>>> +/*
>>> + * If rate_limit_max is 0, there is special code to remove the rate
>>> + * limit.
>>> + */
>>> +#define RATE_LIMIT_MAX 0
>>> +
>>>  /*
>>>   * These are the ram migration statistic counters.  It is loosely
>>>   * based on MigrationStats.  We change to Stat64 any counter that
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 039bba4804..c41c7491bb 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2304,7 +2304,7 @@ static void migration_completion(MigrationState *=
s)
>>>                   * them if migration fails or is cancelled.
>>>                   */
>>>                  s->block_inactive =3D !migrate_colo();
>>> -                qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
>>> +                qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MA=
X);
>>>                  ret =3D qemu_savevm_state_complete_precopy(s->to_dst_f=
ile, false,
>>>                                                           s->block_inac=
tive);
>>>              }
>>> @@ -3048,7 +3048,7 @@ static void *bg_migration_thread(void *opaque)
>>>      rcu_register_thread();
>>>      object_ref(OBJECT(s));
>>> =20
>>> -    qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
>>> +    qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
>>> =20
>>>      setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>>      /*
>>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>>> index 597054759d..4bc875b452 100644
>>> --- a/migration/qemu-file.c
>>> +++ b/migration/qemu-file.c
>>> @@ -27,6 +27,7 @@
>>>  #include "qemu/error-report.h"
>>>  #include "qemu/iov.h"
>>>  #include "migration.h"
>>> +#include "migration-stats.h"
>>>  #include "qemu-file.h"
>>>  #include "trace.h"
>>>  #include "options.h"
>>> @@ -732,7 +733,10 @@ int qemu_file_rate_limit(QEMUFile *f)
>>
>> Given that qemu_file_rate_limit() is really a boolean, could it be
>> declared as such?
>
> I wanted to do on this patch justn $Subject.
>
> You can see that when I move this function to
> migration/migration-stats.c already do the type change.

Thank you =F0=9F=91=8D

> That is patch:
>
> [PATCH v2 05/16] migration: Move rate_limit_max and rate_limit_used to
> migration_stats
>
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index 3431453c90..1b16edae7d 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -22,3 +23,46 @@ void migration_time_since(MigrationAtomicStats *stats,=
 int64_t since)
>      int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>      stat64_set(&stats->setup_time, now - since);
>  }
> +
> +bool migration_rate_exceeded(QEMUFile *f)
> +{
> +    if (qemu_file_get_error(f)) {
> +        return true;
> +    }
> +
> +    uint64_t rate_limit_used =3D stat64_get(&mig_stats.rate_limit_used);
> +    uint64_t rate_limit_max =3D stat64_get(&mig_stats.rate_limit_max);
> +
> +    if (rate_limit_max =3D=3D RATE_LIMIT_MAX) {
> +        return false;
> +    }
> +    if (rate_limit_max > 0 && rate_limit_used > rate_limit_max) {
> +        return true;
> +    }
> +    return false;
> +}
>
> Thanks, Juan.
--=20
I was better off when I was on your side, and I was holding on.

