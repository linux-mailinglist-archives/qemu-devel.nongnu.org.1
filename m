Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B5B7DE490
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 17:27:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyE3K-0006hD-Se; Wed, 01 Nov 2023 12:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qyE3H-0006ds-4c
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:26:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qyE3E-0004x9-Ku
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:26:42 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A1As9V5028337; Wed, 1 Nov 2023 16:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=S815EplMSdvceCmwfFVHHBOuYmSo0LuBnJ+yWxCb7eU=;
 b=N6Bz4IR9YPdMA9D5lPWTIHnAAKcp7HPHYOQxOsawZaV99gd5YFsMvkWu7eg0CbfLtI5G
 NrvNx5VDmSUNEO2ou9qiejctit7Ne8w0g/v/W72eRRQMqnXW1lGXxliP072+Jy/NJkFw
 lV1xhTqRPgn9b/ueJxbdWBAzhVNT9gVDJ2iJ6fw0cFGP5uMG6EOCsEfR87AQJwSyiz0z
 XIXld0SfZRHbJqOdpnRVIkqR/nRBWz3MWdUypd3VdEkMO96THak4DnNmzEvKKx6HxCmJ
 Ff/KN6A5RqFN/wvOXlUJTfBXQbfO+qbglz57vbHFhmkLS41PmhWUuVYTie+qIAExwqiO /w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7byu23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Nov 2023 16:26:37 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A1FYc9o001060; Wed, 1 Nov 2023 16:26:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rr7ma5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Nov 2023 16:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoQT1oJ+py91EP5EML6CL1Ngpm68iIoAECumPJd66ojvkq7pQOhF9PHZ+Om7uCpAwMNStu7WSRtXO/lOioBXO8dbA0X8Zw2RjdCaZuiFESO61YZHJtuIkvjp7s9gF+jF7VujnxOkNIcni2ECCJq8v40jW2Vrqbg8LYi8S4RIaqV2UWltCzXPXvDdq8W4Fx5B6pNJVp45h6FrGbVsUmx4cbI30BWQEToVgiewDXWJkVKiYJZ9N859gJ/brBniznWi3epPz1fNCpmo2KdbGCnqgmw52beSGro+ajqycKzLqghesAL+OBiO0u1aIzmEtA6ZQDBbX6rIigKblAg/QfEzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S815EplMSdvceCmwfFVHHBOuYmSo0LuBnJ+yWxCb7eU=;
 b=RjjKBSOiOyX8P/pbZ5vK3urWzwCA2gh7XCDGx4fkc4fOlfRCbP1EaenN90Gxk/GxCYe/tZuWQALukwGyTzSGZOdJf7HNAMu0MTVMzC85fOeOhv74EzzR9sSHlffIZr+AEHudBbKx5Q1HqKk6LoqzYiGbPG+A4x2RxrSHA8A5Zlw3YY6IgF6MR5MVFQ3c77N7iTER9LlvD9Chk9g/eeWFZ8q02dj/ibwEJE+o2+gsDz2GxrgCSX0iK0aBE0LFFHCRp2RLkUmUldBhBtmSxr1khbpfL137i/VVRKXm13r07ABh/Kbgo93xLTiwN0rFMlf44HeJ1etKRdDIG8DvxTd+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S815EplMSdvceCmwfFVHHBOuYmSo0LuBnJ+yWxCb7eU=;
 b=i+mIUcokd9X8d3BrzXRY/qNLl4x9WaLuWaJiNi0BiYwxuQQLgNAI/4N6JM0rj+qVwOPAzxo7MH/U7JlCv926udlipFbmNn/3A1Zf0BcFF4knGagh3FS/ySrGTBBnOlIlkWcobmZktIB6ouQ4Q7wlNavT/AcOcLKOd1GTwq2Oq/4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 16:26:32 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6933.022; Wed, 1 Nov 2023
 16:26:32 +0000
Message-ID: <4c70d707-d33a-4f33-bd1c-a0811776daed@oracle.com>
Date: Wed, 1 Nov 2023 12:26:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/6] tests/qtest: migration: add reboot mode test
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
 <1698263069-406971-7-git-send-email-steven.sistare@oracle.com>
 <87ttq5fvh7.fsf@suse.de> <19355543-0534-4f9e-b85a-54b8f46e73b6@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <19355543-0534-4f9e-b85a-54b8f46e73b6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b0d1c8-b9b0-44fa-b2ed-08dbdaf74f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smKGxNeVwSweBUJvyD//f/oCzXHxagTiMos/KmMR7y0PS3frdvszSPBuitMyN4I7TGoM4QhJIcnyYr2ncSZS0WWNNLGi7Wd4U6p7XAMxn21jIdIxrkiJ8DGllWVlhw1eMWUorUtADVTkyFV4qHUTb07NNdIEgMDx50hT69itTK1EGi3ReGoA9plL1n+MNPysmEwszueODwCfUnSPZwg0buKoZKJbY9aT1xUS9mBnFQ6OQwDRA9oR+xAX4vBLJetg9OsmUDPlr5lxNEF1sYM8wPmJh9OiK+OzbTG3bs0zM/tT6ESiqAx75P2wV5ROMjRoqb7VrpQJq7fmcDFN0OyeGnpiW1I8BKlUo3Xirj8qgAh8dZfGp2V5mUUI5dxeWdu8oBbUP9nqbidiBbW7MEr84rMI3ccpUTK/1AR2QdY4J28bJSdTNbAzkepgml0SC5QwjQ86PFhydcSHTuumjsbzHFYTLs+IFvIvObu7N4cn/2qluptKTTuyuSk2YxsAtSgpzzOgBmVCQ9pZOkOUP1UcamWjYJKX539VMbtQD/SqUCyop0xGcrrny3UKTDcZ9wMuly9shjQmyKusGlfO+S1ZTLzbux3ORtW5qOvCb2WJWMveFZlgQSipsFf81tvAw4HDA/ze4s6v68hhfeQrrUwiUh70IbNEVx7Y+PTd1Fbc3YKkizNSgV6RX3MQgn/tau4l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799009)(36916002)(6506007)(478600001)(53546011)(36756003)(41300700001)(6512007)(44832011)(38100700002)(66556008)(66946007)(6486002)(5660300002)(8676002)(4326008)(6666004)(8936002)(31686004)(31696002)(2616005)(316002)(86362001)(54906003)(26005)(83380400001)(66476007)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWwwRlZHQk5pZGVvNlhIWWpyS2lkbUU5Q2w2RGNmTjlGSmRCK3ZZRm1CcUJD?=
 =?utf-8?B?LzliZnJ4a3U1ZnIvaXFEN2VVblV4Mm9HV3htczZpbkNYamRYcnpKOERGZkpD?=
 =?utf-8?B?QVZHS2xHN0FiMEh5UElENDBTMjFIVjBJV002MTN2ZUVvRjQxWi9QNkVEb1pv?=
 =?utf-8?B?RG9sY2tETW1JNFlzMW1pOXJuakJaN2wydnZ4bEs2c1NobkIwaFdGMzRXT1Ey?=
 =?utf-8?B?YXlBaXJSTDhheFEwVkFTTTRHMjdLODBjck12VDZEZUtJY25JcHZFNnpZQVI0?=
 =?utf-8?B?VG4xZGJKeERNVTh4TEc4czF4azVlYS9sY2I0cnN3RWRQR096aTVCNllmTDV0?=
 =?utf-8?B?NHhHd3JrdDVZQzFkdWFmUy9DNVovL1B2RkNMWSt1dm1WOUZWU2FiVVdQNks0?=
 =?utf-8?B?Q1hORkM2TlA2SGRBZlRZMnN2cXFReUpuallwU0J4QmxRN1FTRUlMVUJlK0pS?=
 =?utf-8?B?amxLNGh0eC9zZ1V1Z0x5TisveXNCL3E0ZkliUEhJUmNsc09xd2R4VTRtUXhD?=
 =?utf-8?B?RnFoQzMzVXNJcGlrZFBTSjd4YmZ4Tk1ZQzVmbnZsQmxyMFZFb3NDRDRVMnhK?=
 =?utf-8?B?eGJ6dmlmN01yWWlHSVhoQUwzY1p1aEViZXlLR25WaDgwYldzWjZuZGNmT2xF?=
 =?utf-8?B?Q3hIeVJ4NktIU3RKUU9DOTlVOFhWb2dRcXNHY3dHZzJxVStIRjZQU1FyM1dP?=
 =?utf-8?B?MFpPQkt3bVk3dk9FVTFKdzUvUDhyV2oyK2dCNzJzZkZ4VFNDd2RSb3Rhdzlp?=
 =?utf-8?B?enFaemF1L21tRFRrL2dVa3RSMndRNmdsdlNNOFVUQkRxQWg3Ty9XeVFmeFNH?=
 =?utf-8?B?bXlOekt2dkFPNWVoNXhpYnVKQmJlTWsrdHJWN1BORVVIeDZYWHBYSVdpTlc0?=
 =?utf-8?B?ZDY0NGNqOTlWeXlJQ283dEhkTityUnZpeGRpQWR4RERBemV1SVd5WC9GTUR4?=
 =?utf-8?B?UVBOSHB6S1RrdEJodHdhZWJvZ0RoMW83QUZnc3FLdEpPK1M5dDJpU2VrSDlv?=
 =?utf-8?B?VzZFdnl6RUEwcW1MU2Z6ZXpSbE5DODVXL3FoYS9MKzZNRlQzUkFsOGdCYzM3?=
 =?utf-8?B?S1oyRkg1NDh0ZnNPL3JubEs2cTAvQWdlaVh0WGtnZDJUemdLb2NkSTVDeVJl?=
 =?utf-8?B?ZXFJNmNuWExBZjNwb1BpSXQyekpFdk1ZeExGWFpScEpFQWhpYXBkYUFPRmV6?=
 =?utf-8?B?ZTB4WGhycTYxNzdQRHBNYW5KYlBPbHdJR1hoVWtGZi81OUppZ3drTXNaTWly?=
 =?utf-8?B?REp3VUNCR05Dd2dTY0pNUHE5MlFma2xhTkwyeXo4aVJySnRNQ21uV1ppczhN?=
 =?utf-8?B?TnFCV0pKaGlVZ0hrTG5tcjA2T0ZzdlRGVlVuM1hNelZoSnBaSnNpdjlGSjNR?=
 =?utf-8?B?NUg0cHN0SU5Gd2szL3pab0hNQUtzY0Z1V3U1d2R3OHFnNjJldk10aTN1NWdp?=
 =?utf-8?B?d011WjRtd0hvWk53MjVTQ25MRElzRTZtdG5pM1ZMYW80NHk2em5rNnZUOEUw?=
 =?utf-8?B?a0ZqVUNqa05vajFKOVBJVWptR25LM214amUrUllvS0NoRmJOMkhGeE9oZ2pL?=
 =?utf-8?B?SzMybTdIWUNia3oxeUdyRy9JaTVVYU42aE53cUtxU3Q5NC9UTXMzdkQ3S052?=
 =?utf-8?B?bURpS2F4NFRaSVp4UGlYNDdRZndydDJvTDl1YmR3ZXpNUmVWT0IyQXlkMXhT?=
 =?utf-8?B?NkN4L1p1Y05aT011SG5QdXNRNTJYZ2VhcHRBT0M4NGpoRHR0LzFCbUZQNTha?=
 =?utf-8?B?UUdjNkVGSTRBNFFRQ3BZL09EZ3Bod1U3WkN2NWg0SVdUTGJ5VU5UQUJMTTBv?=
 =?utf-8?B?V3drU3JWb2tyUFlIOHVSQ0Q0MkNmcXhaY1RhQ2l5bCs0U2VxV002UkRSd1pl?=
 =?utf-8?B?dThVYkNKN2taakROTEJiWlVwSnlSYVoyeFB6SXFVbEpHOWI2WVBFVUhBSWVN?=
 =?utf-8?B?cEEvR2l4bytRSEttdjY5THdRQVlYRHliQkFpSFRJSFl2aWJVM1pYMldWcnZM?=
 =?utf-8?B?UHI0WDBFZGdiUDJDVThEYUdNLzJjUUQwYm9RSXJTWWdhUXUvNHRLQjJXaWlI?=
 =?utf-8?B?R3k2Q3pzM0RUdEVQRjhUdE15bFM3U1IxL1NBUkJpeGE0T3NVVXNEMi9xd2h0?=
 =?utf-8?B?MDZDMTkvdldnQW4zNGI4c2NGSzRTc1BTbW9WaG5YVUZwWmsybjBGa0tnMTJD?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iz3QOG5FgNXtsInP0nmZkMyWT4uVUksWRue7lLaRp9beuSdnLmxGtPeMjKTV2ZQRK/4Z7y4VJfA4JuA/jACxAuG5nbnG4KUaFwp9r7hQZUTzpOmFUdESK6FxmIDsdHLrbe1BF/Vrj+DFnkrkSjIUlIKoVdKe02pcEqFeBVnp4itCtMYRWeqN+VE0Blm1G2Lo1CbtlF20Br9yDnsxrDCyduDlQucbaJFlf9RmSN99AQqDqQt15aNJ1dOD/cPUPULT66g5SXXK7epj4bypv6UwiWzZ+IEKj4kdjy21XW3eZF58YUjaOskt85GcEqfBuW2wUIyKNbsLmpgLp3FqnSWJlfsmtUBfnqUTXQEY3EBl0zqFWKzYahrVvk0Q5TF3cqwksjU7iTwQF52RSw3VVChZMIgpCUN4nKcfOj8LMt0bstqO2KCfBWWFXFJ8rBNf+iuxw0ZChyot4lRa818y0qS8SUrh0oF0q6MlXhmFbj15Ln95ZL6ExwkXnwBUwfWkNqsnQ4Zt2IBfyjReWfAgfqRi4Wov6a3tSP2gszqxnO4d1wn92/NeFAS6funVmeYaugZHaFsULr/+MDZGaHC38vsMgaQmnKbyFA29K9Pym956fHsWoUR5RaZSkt7nsDWfO4hy//C4vVAKBrvxWLILWhBIg0g1h9YEGIBcH284A/b4qZYnsq0mRms/rm2GY5U4ojZlI7v2DkQ7HD7qqtOp5NOalk5dJkq6AvBmq/zDlPZkrkQe+8NDBMp1DYKNj17XZHhMpvngXgWKQLqqvLmFuiCRR4TIs1FluvHCyB5/54GNkmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b0d1c8-b9b0-44fa-b2ed-08dbdaf74f25
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 16:26:32.5256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBzje/8g68TN51MIDq/4ZaIRMcF70u69EobiUUwYNDZ6VPJQDiiz4ZeZtXuAYGNMsWX7HOCsMUA6F6n6C6ZdYP1KVBmnkHJNL7LcDpkiIfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010129
X-Proofpoint-GUID: JVleNvx86mdofZXmFLeSzoHBwgyArCfW
X-Proofpoint-ORIG-GUID: JVleNvx86mdofZXmFLeSzoHBwgyArCfW
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/1/2023 9:57 AM, Steven Sistare wrote:
> On 11/1/2023 9:34 AM, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>  tests/qtest/migration-test.c | 27 +++++++++++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>>
>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>> index e1c1105..de29fc5 100644
>>> --- a/tests/qtest/migration-test.c
>>> +++ b/tests/qtest/migration-test.c
>>> @@ -2001,6 +2001,31 @@ static void test_precopy_file_offset_bad(void)
>>>      test_file_common(&args, false);
>>>  }
>>>  
>>> +static void *test_mode_reboot_start(QTestState *from, QTestState *to)
>>> +{
>>> +    migrate_set_parameter_str(from, "mode", "cpr-reboot");
>>> +    migrate_set_parameter_str(to, "mode", "cpr-reboot");
>>> +
>>> +    migrate_set_capability(from, "x-ignore-shared", true);
>>> +    migrate_set_capability(to, "x-ignore-shared", true);
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +static void test_mode_reboot(void)
>>> +{
>>> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>>> +                                           FILE_TEST_FILENAME);
>>> +    MigrateCommon args = {
>>> +        .start.use_shmem = true,
>>> +        .connect_uri = uri,
>>> +        .listen_uri = "defer",
>>> +        .start_hook = test_mode_reboot_start
>>> +    };
>>> +
>>> +    test_file_common(&args, true);
>>> +}
>>> +
>>>  static void test_precopy_tcp_plain(void)
>>>  {
>>>      MigrateCommon args = {
>>> @@ -3056,6 +3081,8 @@ int main(int argc, char **argv)
>>>      qtest_add_func("/migration/precopy/file/offset/bad",
>>>                     test_precopy_file_offset_bad);
>>>  
>>> +    qtest_add_func("/migration/mode/reboot", test_mode_reboot);
>>> +
>>>  #ifdef CONFIG_GNUTLS
>>>      qtest_add_func("/migration/precopy/unix/tls/psk",
>>>                     test_precopy_unix_tls_psk);
>>
>> We have an issue with this test on CI:
>>
>> $ df -h /dev/shm
>> Filesystem      Size  Used Avail Use% Mounted on
>> shm              64M     0   64M   0% /dev/shm
>>
>> These are shared CI runners, so AFAICT there's no way to increase the
>> shared memory size.
>>
>> Reducing the memory for this single test also wouldn't work because we
>> can run migration-test for different archs in parallel + there's the
>> ivshmem_test which uses 4M.
>>
>> Maybe just leave it out of CI? Laptops will probably have enough shared
>> memory to not hit this. If we add a warning comment to the test, might
>> be enough.
> 
> in test_migrate_start, I could set memory_size very small if use_shmem, and adjust 
> start_address and end_address. Can you suggest a safe size?

Ugh, I would also need to dynamically change TEST_MEM_END and ARM_TEST_MEM_END in
a-b-bootblock.S and a-b-kernel.S, like I do for the suspend_me variable in my
work-in-progress patch "tests/qtest: option to suspend during migration".

- Steve

