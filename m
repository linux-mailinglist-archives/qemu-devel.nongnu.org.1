Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1E74B5F4
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 19:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHpV1-0001h9-16; Fri, 07 Jul 2023 13:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1qHpUz-0001gy-6G
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 13:44:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1qHpUv-0002DT-Fh
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 13:44:04 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 367HVxIh029681; Fri, 7 Jul 2023 17:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RFTRaIu2arhdTbTedQi1BjiQeXgKcfaWhzdgQVZjN7o=;
 b=pJA3WAPgqFWAB79EgqeQjl4cZsXfSosYjQO7Y5XFR7R+FYjUXRR1Xne4mg4u2nu4eMHW
 U2sdqZcReuURLgy1ke/s8kyLcsu8dl01nnpKNMayfbte0ludoZHKHtSUk3Wshvc7zhvW
 YR23k9XnrnL/qX/70Ruzk2xl0YPE8YLFj+ghorR7PwY2rkreMivI0iMYhlZqJ2QEdgPe
 1cuxzmhWWVtaXDNTmAy2aggYYjd0sdVLLs7mzITK6CMLEJ7xquOIPreF5OxNqStc0Xc8
 Mw5Rv9plfLRjoK65VxP4o/AK4O+Z/bfXar7q7UsGJrozk3kB5Bb1B5AL/tpMshhZZBY+ 0g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cuhkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jul 2023 17:43:57 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 367HCYx6013470; Fri, 7 Jul 2023 17:43:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjak8rnb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jul 2023 17:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWEC9i88WOrQMhkeBZoyd8MV10m3bC0hXJ2FA71s7d8fcU6SqFmvAJ80aHUW9kfQ5SMTjSVW9xs71E+/wsJ97HcgCOCXxxZ+sWEMG1bCluqQ6w9In7te3o7kKC8YPLtdKhNz4J994N2GHjzrPectGg1NvzbE0+yCq9uylXzN80xUfDOOROhByHQIY+vzFDpP7913NHBLw9QT2KcicWbDjoBNjSlEMetlFu7568R8f0qPDHaJv9RE2DkcUSErD2LS2J9WKHCXgvlCP5PcsdRWjyF5vs24tel5qO4PF4N2S4U3uPbnPRKeAQmK6fDiGSBATVNjFVmZ5wEH6yIGF5B62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFTRaIu2arhdTbTedQi1BjiQeXgKcfaWhzdgQVZjN7o=;
 b=YIHJ0UE2Z1i7O7FH8CV9LiFDF+j91wfXFNYLfIoFPZbo5MxjdF6l8xyyoysNU0toiqyFaP0MSMKCo8/KSHJl/5nvlkBkKgiXCWSh0LAIxBl2RXk2aKK423bODTFaXhn0mEmIdJswIN+KB3Wopnp7ysfWIehkaueVKoSagEFUc++MVvrVUjywVuOqD2NCN9iPzqzGoqhYM2yVlUofKu9Iwa+LShWn1JRa5rxNoxqm2XeXhDDuF0NSLE0sJzO340r95nSbAxWdwlfR+dQVUCA4O7Cf31+Fq/KYwi+HPuHdmrFDv1fUr0hZDi+nUDFQHUjZ/8osNdMaeqos9Bsbdf856A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFTRaIu2arhdTbTedQi1BjiQeXgKcfaWhzdgQVZjN7o=;
 b=vr/fDGQU64cmya7D7eNrVCN8gPPLZyq6su0yb+R1YXtX25BL40MshDzHs4gFs+Xu9iQWBcIRWLCt1VXpHqQiNyNGI3OYfYDKP+TAwBllgPWSu34BVh+EQ7HEJKCqrXniCBG4TVYroUv38u9iLT6lESE6KJssCoW7voyNTtMM+60=
Received: from DM6PR10MB2523.namprd10.prod.outlook.com (2603:10b6:5:b2::27) by
 IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 17:43:53 +0000
Received: from DM6PR10MB2523.namprd10.prod.outlook.com
 ([fe80::6b3b:9ef6:47cb:76c3]) by DM6PR10MB2523.namprd10.prod.outlook.com
 ([fe80::6b3b:9ef6:47cb:76c3%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 17:43:53 +0000
Message-ID: <8581b04d-5e9d-33e6-7918-d5f771dd2836@oracle.com>
Date: Fri, 7 Jul 2023 13:43:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [Qemu-devel] [PATCH] acpi: Add emulated sleep button
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
References: <1500543086-26588-1-git-send-email-sf@sfritsch.de>
 <20170720165957.743ccf1a@nial.brq.redhat.com>
 <1a70f9be-e3ca-7311-a078-f55fe56ad0f3@oracle.com>
 <20210920095316.2dd133be@redhat.com>
From: "Annie.li" <annie.li@oracle.com>
In-Reply-To: <20210920095316.2dd133be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::11) To DM6PR10MB2523.namprd10.prod.outlook.com
 (2603:10b6:5:b2::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB2523:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bd6b37-06e4-4c25-a8a8-08db7f11ba89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBzJGVauluvzkKIEZwrPiabjOo/vUNNed6q51FfEPvNcBUFRRctcgYFH6XFOCpV6l80/FUIxmoV5ZlxVzE073t3yAX6ghSV8oRHo6dlYdjK72LBqlF8kQEkmSWF4aJxIPkDlv9xDdGNKx6zIX0tTIJ+AbIZxURM6xzr7pum+5GCIKCwwa+bMkkNxpQpjhntpNGLAVWDd9Ao2sURdETfTy5LxF5O7kayi+MoX5V9DICa+SObXh7Kr8yYx6LzYLFBQmOwFitjqTTLP4IXTxpmOsMWQ1BQTc7+l3LcecqRNA4YQe/G4E6FmlSTOvCkDEc+KTp6YqWXy1sPEA/TB44uF1GiiOYjXDFM5ctSu6ly+RlWjCWM2t2zr/SGsUqA4bIqR415EWAjsm96bzFtPRBTa3jAPPCCzItJW1mbHZCp+9CFmAJyEaxWsd4cfBRKFo8k7HTLLAwzcnCrI3tjwJHwM091WJzrL+OCwIrsSTUw/CFqYrZwieZ29UrtyMmX7wW/XaxcXa+CEAvtjcLXa7YJlmiJiH/B/eyFtWt5xqS1MwG9er0M9Clq3Z/IPl6k0ctwWxfQRB9WH5d9DnH5X5OfqznCWZw7JcH6w9/pA134Gz/d4rWNgyJvdY0LJvI7eyqMd2CkongxE66h5AkpdsJ0vrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB2523.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(66476007)(41300700001)(30864003)(6512007)(86362001)(54906003)(31696002)(38100700002)(6486002)(66946007)(6666004)(316002)(66556008)(36756003)(4326008)(83380400001)(478600001)(6916009)(2906002)(8676002)(8936002)(2616005)(5660300002)(31686004)(53546011)(6506007)(186003)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2xWSnhWWHA1VElzbUxDNU8vZG1qWU9pNEpmdXFOSXZjeFoxOTd0S2FzV1dz?=
 =?utf-8?B?SHU2SXhhWXViWDRUZXpFUmFSTTBhemxITDRPWjloSnRPc08wWmorNko0RlFT?=
 =?utf-8?B?VG8rQTJqUktvT0diaHFHR082V0pEcDZ6ME9PalRqVjJ0T3hlWll1SnNjKy9W?=
 =?utf-8?B?R29hS1Erd0owa0tXTnRXdWZ6UkhEcVRXb2EzczFpMTJzS3JNZ0t5N2g3ZzVQ?=
 =?utf-8?B?OXM0dmJCYXFVY2UvUWMwSDg3cnAwL0ZFeFpXY3B3OEJJT2FFWXVuUEhCa1pa?=
 =?utf-8?B?b2txMUlJUThpRnU3SGZOK0JralhTQlRFS3BwcDAyZjd5UEFnVUlpRlJyOFd5?=
 =?utf-8?B?TnRCbDRaTVcxd08wRzl5cUdvRk1sY1ZIV3BRdkhJbXBPZWlQVkx6VUFDeXVU?=
 =?utf-8?B?NFplN0x2bDRic2JBSnhYRHVxRGZqTU9JZkR5OUc4NDh0SHIycGlQZ3AzWmdp?=
 =?utf-8?B?Z213R1AwQ1lJdGlXNGNZYXFHQ1pnTWFjcmxNWlpBQVNaY0ZlOGpTd1JYRUIr?=
 =?utf-8?B?cUNsY0tkMjIrcUI1YThKZDg0angwZm1wYUJ4RlVMUjRCMlBTYXEyZGdEeVh6?=
 =?utf-8?B?OW1tRHdCcWNQRWJKYnJIRE00RXI5TUNSeW1ybFZLdUc0VHRYOU1NMjFya3BJ?=
 =?utf-8?B?dm0wTWt6ait0bWNocEdUVGQ2Qnh5aEVQNTAxZUxRYWd1ZFdaeGFtZncreUFq?=
 =?utf-8?B?TGwra3lyT29nd2hQTko4ZEFhVGRFSDE5eFloa29rZ1lDT3JqNllxN2YrQWFy?=
 =?utf-8?B?VzRXU0xsWk9RUDFrUldVN2Y4b1NmbzN3elUzR2kzcTFTUXllNFpLZmJMOUJv?=
 =?utf-8?B?SXRwYllNL0RiTnI1VFB1RWllci9IWFM0WjlGZ2JUNzRtWGtPQjFqbERuL0cw?=
 =?utf-8?B?RmZFK0V3WFFrSGhyUXA3TXZ3R0xOdjQrNFhhbjZwS3FpTWZRZ2Fla2p3cmZt?=
 =?utf-8?B?NGNlMi9ocEhCcnRkVkE0WUR4aHNSVlk1R2N4cllLQTM5OVc3cC9nSkdpc0h1?=
 =?utf-8?B?eWh1UFFpMWpkM09qQUloYlNabEFiNWlnNy84NUhaeDc5dDhkTjFxVjRQVTE0?=
 =?utf-8?B?VTZhK3haei9lenZMOVBuQjZpajZxcExSNkpqdURpODZMQVVydkxLaStGYWJP?=
 =?utf-8?B?Z2dBelhYbnNBdXM5S3cvajNZMXZXdU16WTE1ZnpVdkRFb1V5MFh6WHJRUERF?=
 =?utf-8?B?VjRoNVhhSGlrRmdQUXZZdU90VEhOUUNCMnVRNG51a1N2OXNpNGZRNWxkcVFk?=
 =?utf-8?B?Qjk3NE9QbG4rdk54dTFGV3RIMHZpcjh0eFRvV01tSTY4RnlyRGdFTlcxY0ph?=
 =?utf-8?B?RVZaaVF3ZkR1NFdLWGl5N2N2WFRaQmNGTnNWVUw2dkVOYllGTit2amZoSDBi?=
 =?utf-8?B?R3JDdXhFRzVVVzNjSVByNFJmcHZSOWVBaXNXNkNzU3V4Q2Uzd0ZQYWdYSE5w?=
 =?utf-8?B?Z3NRdWtiek1UNGRhZXVGMXBTN295aHJjalIzeEJHSzMyaXArU2crZU8rS2l2?=
 =?utf-8?B?R1dXSWtHdDF5MVgwVGkwSG9Jb0tKdFk3NERaZWx4dCt2ZUlyVi9PaWRWYkxL?=
 =?utf-8?B?K3dZWEFHUGlLRFQxaitGWHFnTDh4VDJkOTlDS1QzQ2hNbUlyazZlL3hCOFpN?=
 =?utf-8?B?UjBVaVVPODh5eDFnQ3JMSHNPZll0YnVzTDhGaWZoNW5UT2h3SjdKRk9BVTlP?=
 =?utf-8?B?TXZ0ZWlMY0toTjUvcjFSRHBnMkVwenBpVjIrb2JNcmRhWXlFaVF4NjZ6Vjdt?=
 =?utf-8?B?VFRXeXg4QmF0Smxwa3VoaW90UklmRmtObzlnSmZLVlpmTmQ5ZFJvV1JOVXJz?=
 =?utf-8?B?Zk1GRzErbUxlV1l6UVd6YmlxSzFDSDJ1V3dSVnFJUnM5dkQ1VFJlU0J3ZzFl?=
 =?utf-8?B?L01RZTJIcTNDeDYwR1JrYkp2NjliYjA4WDIxMVIybW9kSWpReDBGdWRRNlJU?=
 =?utf-8?B?ejMvSUFTdFlTRjV1NFRvanQ0UStWakZHWFJ0Unk0b0NBVGRBdXQ0eGZEVXdX?=
 =?utf-8?B?S05Md2gzcjlqWDlVVEpWSWV1MUQ2Mjhlc0MzWktzSldkTk5uUFFGNWp2SWdK?=
 =?utf-8?B?RHBxQ1lnUi9LdXVHMVB5VHdITUFobFhrNEozL3RDb3RkQTdxU1l6UmtodjhZ?=
 =?utf-8?Q?U5y/QO1AhPKwA6FkrQ0vBIdKY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MOyGZ9nteJdqDZsQV5aQWQRpDuPAtvAtafezodDV6KTaTWiRh6R2uk34yQNO0jJE+CT5znUgV7OcVPEsD/tsGIXY+51JfgJoejYYzc1kiCzz8K0X5EVPvKn/uV0byOa4dbCVIuMbQO8+K0gQAszULxDVLycsXRav7M6CFNcxBV1XV6t5OOXe+uecHiyZHuhAQlN1S/ZKIOVY+JvQllNffnS8EzItm3sede5aRhCAn8vJ9uJwok5j7y7QzPaGwshii3TLD8kWljdJAp2vJ5Gqp6KcQQXicea+TzI+9eU8aNfhHn+tNMT7fRwPC/ijH547hA0VD8ne1u51Ca0xD0CNh/z5qggldcK+EE6PUnvHn06YouXkXjP1EO4HW0e/DrfB5ZY3zDlPqj1JvzfjoIBZzienQp6TGOSrWGU0C2dqvfFNatzgm/XajPVpBGqZc3oFEDbZN4O+YHNX1j7VwRNSY7JQc+Ue6HKu/r/MUStWyHA++xDtD+I8e5AnM8iZANTRjUVo2IDP8vPiloHhxfzmtDkbuqACTuIUPgqqCmElvgnCmT4OBTUDj50YePrviUc6Tc2eYs5rmifhIEGO0nuou4ZV8edVlU94G31IPWtIqsrLSUNyhDjHcBdbr9ZHGnQHivq7WnxXovlf55OnzInd1bCw0IkTad0ji+UUM6G/6nEWuGN5nWy31obqJfIANLJmlx0gtWhUnBCEKApKstH5NHQSGKZLU46IT+PeSAv8rwY+MJ+vJqRsvoC6FwBiagh7XFaxl2xLu5hpZrG5yP/7D8vQqI1p5Qs5o2on79a1gFY79nt2m3a2jNFD+fCKasp5w/vh+HnOZCvWFC57V5RudQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bd6b37-06e4-4c25-a8a8-08db7f11ba89
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2523.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:43:52.9891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47NnK2/pzV4/oWzMOzd03tNi/BhE0vxfhcBtzacvm5M4PB20A1XL/sRgfDAQ5po9W7tB6IPb/Jrslgi1fHFCGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070165
X-Proofpoint-GUID: gjSGLWQ5rVa0xIq0hNJMNVEYbokV3VEh
X-Proofpoint-ORIG-GUID: gjSGLWQ5rVa0xIq0hNJMNVEYbokV3VEh
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

Hi Igor,

Revisiting this thread and have more questions, please clarify, thank you!

On 9/20/2021 3:53 AM, Igor Mammedov wrote:
> On Fri, 6 Aug 2021 16:18:09 -0400
> "Annie.li" <annie.li@oracle.com> wrote:
>
>> Hello Igor,
>>
>> This is an old patch, but it does what we need.
>> I am getting a little bit lost about not implementing fixed hardware
>> sleep button, can you please clarify? thank you!
>>
>> On 7/20/2017 10:59 AM, Igor Mammedov wrote:
>>> On Thu, 20 Jul 2017 11:31:26 +0200
>>> Stefan Fritsch <sf@sfritsch.de> wrote:
>>>   
>>>> From: Stefan Fritsch <stefan_fritsch@genua.de>
>>>>
>>>> Add an ACPI sleep button and QMP/HMP commands to trigger it.  A sleep
>>>> button is a so called "fixed hardware feature", which makes it more
>>>> suitable for putting the system to sleep than a laptop lid, for example.
>>>>
>>>> The sleep button is disabled by default (Bit 5 in the FACP flags
>>>> register set and no button "device" present in SSDT/DSDT). Clearing said
>>>> bit enables it as a fixed feature device.
>>> per spec sleep button is used for both putting system into
>>> sleep and for waking it up.
>>>
>>> Reusing system_wakeup 'button' to behave as per spec would
>>> make this patch significantly smaller.
Current 'system_wakeup' sets the WAK_STS bit and PWRBTN_STS to wake up
the system, the system_wakeup 'button' is the power button. So(Correct me
if I am wrong) reusing the system_wakeup 'button' means reusing the power
button for sleep. See the following code of setting WAK_STS and PWRBTN_STS
for 'system_wakeup',
     case QEMU_WAKEUP_REASON_OTHER:
         /* ACPI_BITMASK_WAKE_STATUS should be set on resume.
            Pretend that resume was caused by power button */
         ar->pm1.evt.sts |=
             (ACPI_BITMASK_WAKE_STATUS | ACPI_BITMASK_POWER_BUTTON_STATUS);
         break;

Per the ACPI spec, the power button can be used in single button model, i.e.
it can be used to either shut down the system or put the system into sleep.
However, this depends on the software policy and user's setting of the 
system.
Sleep/shutdown can not be done through the power button in the same 
scenario.
If the system has configured pressing the power button to put the system 
into sleep,
system_sleep will put the system into sleep state through the power 
button, as well
as system_powerdown. Pressing the power button will not shut down the 
system.
In this case, system_powerdown has its own issue, but this is different 
story and
let's just focus on things related to system_sleep here.
>> About reusing "system_wakeup", does it mean the following?
>>
>> 1. when guest is in sleep state, "system_wakeup" wakes up the guest
>> 2. when guest is running, "system_wakeup" puts the guest into sleep
> yes,  it could be something like this
>
>
>> "system_wakeup" sets WAK_STS and then system transitions to the
>> working state. Correspondingly, I suppose both SLPBTN_STS and
>> SLPBTN_EN need to be set for sleeping, and this is what fixed
>> hardware sleep button requires?
> yep
>   
>> I have combined the sleep and wakeup together, share the
>> code between. But Xen also registers the wakeup notifier, and
>> this makes things more complicated if this notifier is shared
>> between sleep and wakeup. Or this is my misunderstanding?
>> please correct me if I am wrong.
> you'd have to fixup xen notifier to handle that
>   
>>> If you like idea of separate command/button better, then
>>> I'd go generic control sleep button way instead of fixed
>>> hardware, it would allow us to reuse most of the code in
>>> ARM target, plus I'd avoid notifiers and use acpi device
>>> lookup instead (see: qmp_query_acpi_ospm_status as example)
Implementing the generic control sleep button for x86 does align
to the generic control power button implementation in ARM, but
it doesn't align to the current fixed hardware power button for x86.
Should sleep button be implemented as generic control sleep button
to reuse code in ARM or fixed hardware button to align to the fixed
power button for x86?

Thanks
Annie
>>>   
>> Do you mean the "Control Method Sleep Button" that needs to
>> notify OSPM by event indication 0x80?
> yes, in addition to virt-arm machine it could be reused by
> microvm which also uses 'reduced hardware' acpi model
> (i.e. it lacks fixed hardware registers like virt-arm does)
>
> maybe while adding button to pc/q35 you can look into adding
> it to microvm and virt-arm at the same time (should be trivial
> on top of pc/q35 support).
>
>> Thanks
>> Annie
>>>> Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
>>>> ---
>>>>    hmp-commands.hx         | 16 ++++++++++++++++
>>>>    hmp.c                   |  5 +++++
>>>>    hmp.h                   |  1 +
>>>>    hw/acpi/core.c          |  8 ++++++++
>>>>    hw/acpi/ich9.c          | 10 ++++++++++
>>>>    hw/acpi/piix4.c         | 12 ++++++++++++
>>>>    hw/i386/acpi-build.c    |  1 -
>>>>    include/hw/acpi/acpi.h  |  2 ++
>>>>    include/hw/acpi/ich9.h  |  1 +
>>>>    include/sysemu/sysemu.h |  2 ++
>>>>    qapi-schema.json        | 12 ++++++++++++
>>>>    qmp.c                   |  5 +++++
>>>>    tests/test-hmp.c        |  1 +
>>>>    vl.c                    | 29 +++++++++++++++++++++++++++++
>>>>    14 files changed, 104 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>>>> index 1941e19932..8ba4380883 100644
>>>> --- a/hmp-commands.hx
>>>> +++ b/hmp-commands.hx
>>>> @@ -638,6 +638,22 @@ Reset the system.
>>>>    ETEXI
>>>>    
>>>>        {
>>>> +        .name       = "system_sleep",
>>>> +        .args_type  = "",
>>>> +        .params     = "",
>>>> +        .help       = "send ACPI sleep event",
>>>> +        .cmd = hmp_system_sleep,
>>>> +    },
>>>> +
>>>> +STEXI
>>>> +@item system_sleep
>>>> +@findex system_sleep
>>>> +
>>>> +Push the virtual sleep button; if supported the system will enter
>>>> +an ACPI sleep state.
>>>> +ETEXI
>>>> +
>>>> +    {
>>>>            .name       = "system_powerdown",
>>>>            .args_type  = "",
>>>>            .params     = "",
>>>> diff --git a/hmp.c b/hmp.c
>>>> index bf1de747d5..b4b584016c 100644
>>>> --- a/hmp.c
>>>> +++ b/hmp.c
>>>> @@ -1047,6 +1047,11 @@ void hmp_system_reset(Monitor *mon, const QDict *qdict)
>>>>        qmp_system_reset(NULL);
>>>>    }
>>>>    
>>>> +void hmp_system_sleep(Monitor *mon, const QDict *qdict)
>>>> +{
>>>> +    qmp_system_sleep(NULL);
>>>> +}
>>>> +
>>>>    void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
>>>>    {
>>>>        qmp_system_powerdown(NULL);
>>>> diff --git a/hmp.h b/hmp.h
>>>> index 1ff455295e..15b53de9ed 100644
>>>> --- a/hmp.h
>>>> +++ b/hmp.h
>>>> @@ -45,6 +45,7 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict);
>>>>    void hmp_quit(Monitor *mon, const QDict *qdict);
>>>>    void hmp_stop(Monitor *mon, const QDict *qdict);
>>>>    void hmp_system_reset(Monitor *mon, const QDict *qdict);
>>>> +void hmp_system_sleep(Monitor *mon, const QDict *qdict);
>>>>    void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
>>>>    void hmp_cpu(Monitor *mon, const QDict *qdict);
>>>>    void hmp_memsave(Monitor *mon, const QDict *qdict);
>>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>>> index 95fcac95a2..2ee64b6878 100644
>>>> --- a/hw/acpi/core.c
>>>> +++ b/hw/acpi/core.c
>>>> @@ -422,6 +422,14 @@ void acpi_pm1_evt_power_down(ACPIREGS *ar)
>>>>        }
>>>>    }
>>>>    
>>>> +void acpi_pm1_evt_sleep(ACPIREGS *ar)
>>>> +{
>>>> +    if (ar->pm1.evt.en & ACPI_BITMASK_SLEEP_BUTTON_ENABLE) {
>>>> +        ar->pm1.evt.sts |= ACPI_BITMASK_SLEEP_BUTTON_STATUS;
>>>> +        ar->tmr.update_sci(ar);
>>>> +    }
>>>> +}
>>>> +
>>>>    void acpi_pm1_evt_reset(ACPIREGS *ar)
>>>>    {
>>>>        ar->pm1.evt.sts = 0;
>>>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>>>> index c5d8646abc..3faeab4d2e 100644
>>>> --- a/hw/acpi/ich9.c
>>>> +++ b/hw/acpi/ich9.c
>>>> @@ -260,6 +260,14 @@ static void pm_reset(void *opaque)
>>>>        acpi_update_sci(&pm->acpi_regs, pm->irq);
>>>>    }
>>>>    
>>>> +static void pm_sleep_req(Notifier *n, void *opaque)
>>>> +{
>>>> +    ICH9LPCPMRegs *pm = container_of(n, ICH9LPCPMRegs, sleep_notifier);
>>>> +
>>>> +    acpi_pm1_evt_sleep(&pm->acpi_regs);
>>>> +}
>>>> +
>>>> +
>>>>    static void pm_powerdown_req(Notifier *n, void *opaque)
>>>>    {
>>>>        ICH9LPCPMRegs *pm = container_of(n, ICH9LPCPMRegs, powerdown_notifier);
>>>> @@ -299,6 +307,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
>>>>        qemu_register_reset(pm_reset, pm);
>>>>        pm->powerdown_notifier.notify = pm_powerdown_req;
>>>>        qemu_register_powerdown_notifier(&pm->powerdown_notifier);
>>>> +    pm->sleep_notifier.notify = pm_sleep_req;
>>>> +    qemu_register_sleep_notifier(&pm->sleep_notifier);
>>>>    
>>>>        legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
>>>>            OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
>>>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>>>> index f276967365..15e20976c3 100644
>>>> --- a/hw/acpi/piix4.c
>>>> +++ b/hw/acpi/piix4.c
>>>> @@ -79,6 +79,7 @@ typedef struct PIIX4PMState {
>>>>        int smm_enabled;
>>>>        Notifier machine_ready;
>>>>        Notifier powerdown_notifier;
>>>> +    Notifier sleep_notifier;
>>>>    
>>>>        AcpiPciHpState acpi_pci_hotplug;
>>>>        bool use_acpi_pci_hotplug;
>>>> @@ -371,6 +372,15 @@ static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
>>>>        acpi_pm1_evt_power_down(&s->ar);
>>>>    }
>>>>    
>>>> +static void piix4_pm_sleep_req(Notifier *n, void *opaque)
>>>> +{
>>>> +    PIIX4PMState *s = container_of(n, PIIX4PMState, sleep_notifier);
>>>> +
>>>> +    assert(s != NULL);
>>>> +    acpi_pm1_evt_sleep(&s->ar);
>>>> +}
>>>> +
>>>> +
>>>>    static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
>>>>                                     DeviceState *dev, Error **errp)
>>>>    {
>>>> @@ -535,6 +545,8 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
>>>>    
>>>>        s->powerdown_notifier.notify = piix4_pm_powerdown_req;
>>>>        qemu_register_powerdown_notifier(&s->powerdown_notifier);
>>>> +    s->sleep_notifier.notify = piix4_pm_sleep_req;
>>>> +    qemu_register_sleep_notifier(&s->sleep_notifier);
>>>>    
>>>>        s->machine_ready.notify = piix4_pm_machine_ready;
>>>>        qemu_add_machine_init_done_notifier(&s->machine_ready);
>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>> index 6b7bade183..06b28dacfe 100644
>>>> --- a/hw/i386/acpi-build.c
>>>> +++ b/hw/i386/acpi-build.c
>>>> @@ -294,7 +294,6 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
>>>>        fadt->plvl3_lat = cpu_to_le16(0xfff); /* C3 state not supported */
>>>>        fadt->flags = cpu_to_le32((1 << ACPI_FADT_F_WBINVD) |
>>>>                                  (1 << ACPI_FADT_F_PROC_C1) |
>>>> -                              (1 << ACPI_FADT_F_SLP_BUTTON) |
>>>>                                  (1 << ACPI_FADT_F_RTC_S4));
>>>>        fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_USE_PLATFORM_CLOCK);
>>>>        /* APIC destination mode ("Flat Logical") has an upper limit of 8 CPUs
>>>> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
>>>> index 7b3d93cf0d..51cf901ef6 100644
>>>> --- a/include/hw/acpi/acpi.h
>>>> +++ b/include/hw/acpi/acpi.h
>>>> @@ -78,6 +78,7 @@
>>>>    #define ACPI_BITMASK_PM1_COMMON_ENABLED         ( \
>>>>            ACPI_BITMASK_RT_CLOCK_ENABLE        | \
>>>>            ACPI_BITMASK_POWER_BUTTON_ENABLE    | \
>>>> +        ACPI_BITMASK_SLEEP_BUTTON_ENABLE    | \
>>>>            ACPI_BITMASK_GLOBAL_LOCK_ENABLE     | \
>>>>            ACPI_BITMASK_TIMER_ENABLE)
>>>>    
>>>> @@ -148,6 +149,7 @@ void acpi_pm_tmr_reset(ACPIREGS *ar);
>>>>    /* PM1a_EVT: piix and ich9 don't implement PM1b. */
>>>>    uint16_t acpi_pm1_evt_get_sts(ACPIREGS *ar);
>>>>    void acpi_pm1_evt_power_down(ACPIREGS *ar);
>>>> +void acpi_pm1_evt_sleep(ACPIREGS *ar);
>>>>    void acpi_pm1_evt_reset(ACPIREGS *ar);
>>>>    void acpi_pm1_evt_init(ACPIREGS *ar, acpi_update_sci_fn update_sci,
>>>>                           MemoryRegion *parent);
>>>> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
>>>> index a352c94fde..2073eec168 100644
>>>> --- a/include/hw/acpi/ich9.h
>>>> +++ b/include/hw/acpi/ich9.h
>>>> @@ -48,6 +48,7 @@ typedef struct ICH9LPCPMRegs {
>>>>    
>>>>        uint32_t pm_io_base;
>>>>        Notifier powerdown_notifier;
>>>> +    Notifier sleep_notifier;
>>>>    
>>>>        bool cpu_hotplug_legacy;
>>>>        AcpiCpuHotplug gpe_cpu;
>>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>>> index b21369672a..00f54653dc 100644
>>>> --- a/include/sysemu/sysemu.h
>>>> +++ b/include/sysemu/sysemu.h
>>>> @@ -75,6 +75,8 @@ void qemu_register_wakeup_notifier(Notifier *notifier);
>>>>    void qemu_system_shutdown_request(ShutdownCause reason);
>>>>    void qemu_system_powerdown_request(void);
>>>>    void qemu_register_powerdown_notifier(Notifier *notifier);
>>>> +void qemu_system_sleep_request(void);
>>>> +void qemu_register_sleep_notifier(Notifier *notifier);
>>>>    void qemu_system_debug_request(void);
>>>>    void qemu_system_vmstop_request(RunState reason);
>>>>    void qemu_system_vmstop_request_prepare(void);
>>>> diff --git a/qapi-schema.json b/qapi-schema.json
>>>> index 8b015bee2e..c6ccfcd70f 100644
>>>> --- a/qapi-schema.json
>>>> +++ b/qapi-schema.json
>>>> @@ -2314,6 +2314,18 @@
>>>>    { 'command': 'system_reset' }
>>>>    
>>>>    ##
>>>> +# @system_sleep:
>>>> +#
>>>> +# Requests that a guest perform a ACPI sleep transition by pushing a virtual
>>>> +# sleep button.
>>>> +#
>>>> +# Notes: A guest may or may not respond to this command.  This command
>>>> +#        returning does not indicate that a guest has accepted the request or
>>>> +#        that it has gone to sleep.
>>>> +##
>>>> +{ 'command': 'system_sleep' }
>>>> +
>>>> +##
>>>>    # @system_powerdown:
>>>>    #
>>>>    # Requests that a guest perform a powerdown operation.
>>>> diff --git a/qmp.c b/qmp.c
>>>> index b86201e349..bc1f2e3d7f 100644
>>>> --- a/qmp.c
>>>> +++ b/qmp.c
>>>> @@ -108,6 +108,11 @@ void qmp_system_reset(Error **errp)
>>>>        qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP);
>>>>    }
>>>>    
>>>> +void qmp_system_sleep(Error **erp)
>>>> +{
>>>> +    qemu_system_sleep_request();
>>>> +}
>>>> +
>>>>    void qmp_system_powerdown(Error **erp)
>>>>    {
>>>>        qemu_system_powerdown_request();
>>>> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
>>>> index d77b3c8710..3fa850bf1e 100644
>>>> --- a/tests/test-hmp.c
>>>> +++ b/tests/test-hmp.c
>>>> @@ -67,6 +67,7 @@ static const char *hmp_cmds[] = {
>>>>        "sum 0 512",
>>>>        "x /8i 0x100",
>>>>        "xp /16x 0",
>>>> +    "system_sleep",
>>>>        NULL
>>>>    };
>>>>    
>>>> diff --git a/vl.c b/vl.c
>>>> index fb6b2efafa..6a0f847dcf 100644
>>>> --- a/vl.c
>>>> +++ b/vl.c
>>>> @@ -1608,6 +1608,7 @@ static ShutdownCause reset_requested;
>>>>    static ShutdownCause shutdown_requested;
>>>>    static int shutdown_signal;
>>>>    static pid_t shutdown_pid;
>>>> +static int sleep_requested;
>>>>    static int powerdown_requested;
>>>>    static int debug_requested;
>>>>    static int suspend_requested;
>>>> @@ -1618,6 +1619,8 @@ static NotifierList suspend_notifiers =
>>>>        NOTIFIER_LIST_INITIALIZER(suspend_notifiers);
>>>>    static NotifierList wakeup_notifiers =
>>>>        NOTIFIER_LIST_INITIALIZER(wakeup_notifiers);
>>>> +static NotifierList sleep_notifiers =
>>>> +    NOTIFIER_LIST_INITIALIZER(sleep_notifiers);
>>>>    static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
>>>>    
>>>>    ShutdownCause qemu_shutdown_requested_get(void)
>>>> @@ -1838,6 +1841,24 @@ static void qemu_system_powerdown(void)
>>>>        notifier_list_notify(&powerdown_notifiers, NULL);
>>>>    }
>>>>    
>>>> +static void qemu_system_sleep(void)
>>>> +{
>>>> +    notifier_list_notify(&sleep_notifiers, NULL);
>>>> +}
>>>> +
>>>> +static int qemu_sleep_requested(void)
>>>> +{
>>>> +    int r = sleep_requested;
>>>> +    sleep_requested = 0;
>>>> +    return r;
>>>> +}
>>>> +
>>>> +void qemu_system_sleep_request(void)
>>>> +{
>>>> +    sleep_requested = 1;
>>>> +    qemu_notify_event();
>>>> +}
>>>> +
>>>>    void qemu_system_powerdown_request(void)
>>>>    {
>>>>        trace_qemu_system_powerdown_request();
>>>> @@ -1850,6 +1871,11 @@ void qemu_register_powerdown_notifier(Notifier *notifier)
>>>>        notifier_list_add(&powerdown_notifiers, notifier);
>>>>    }
>>>>    
>>>> +void qemu_register_sleep_notifier(Notifier *notifier)
>>>> +{
>>>> +    notifier_list_add(&sleep_notifiers, notifier);
>>>> +}
>>>> +
>>>>    void qemu_system_debug_request(void)
>>>>    {
>>>>        debug_requested = 1;
>>>> @@ -1899,6 +1925,9 @@ static bool main_loop_should_exit(void)
>>>>        if (qemu_powerdown_requested()) {
>>>>            qemu_system_powerdown();
>>>>        }
>>>> +    if (qemu_sleep_requested()) {
>>>> +        qemu_system_sleep();
>>>> +    }
>>>>        if (qemu_vmstop_requested(&r)) {
>>>>            vm_stop(r);
>>>>        }
>

