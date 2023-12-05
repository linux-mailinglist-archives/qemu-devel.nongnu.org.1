Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 217538056F1
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 15:15:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAWCO-0005wL-31; Tue, 05 Dec 2023 09:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAWCL-0005w4-ND
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:14:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAWCJ-0007vF-H8
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:14:53 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B5Cs8eg012790; Tue, 5 Dec 2023 14:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aH2QRV2RJmbp8RThunsKrxArHFuGIbevq8Kgj9yl1eY=;
 b=Rh9vOgckDm/Z/cSZ/7ubL6scfOUnoZB6KQ297qlwTQTaf2stmAuk9ALs+/ZWM7Oi97NV
 90S2HTrHJ79fT1R+LfJ+HBreyvaT9fVq93gIO48abAjZGdRJCKod+BEoLaHlVcogE+M9
 zIRy2vqhObVfWqGdjTd0igOUFwphJT3WnJA1/yRy3/eSqIWQHkMQia/0mcWOvYvDdViX
 bJmyLOu07piV1yPc4xt6QwXSQq4vgakq17f6qR06VBs2I3A2eMg4OY3nhBUloylb82Tn
 p/ijZIvcPil1RuRQ90Cv33Wo9I4nKy1vf+YLLjldxmBPFMScKzcrDdwCDs6OhpRsnEtU pQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut15n0k5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 14:14:48 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B5E8YPK039692; Tue, 5 Dec 2023 14:14:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu17jn91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 14:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmgkitF4LsrAft/yxZFqNQvR3dEbMqKY/xDpWiVAd8fSIOyBIBPR5VimQkFEf8Ljeb2Z1UZSapuw/tfBEFlfiFW/ir1FRvWB1mEFUQl6p4flgAzrhwbFa4eA9gMlMN5Li3gt4hHVLXJ/YsyBHC4b0tC7c96y3mNJGdnPcOcbiQnB1Oa9KnFKb7UVVFUE6ldA1AWAdRKNlWf/9XC2slNUZ2SrR0v/+Y5ni5e4YQlNHfpZEGEqqYuIjaMexZFRxNi+sz8yndCC0MD83anhPPGQvTgeZV0/mDffBRv6WQqdEVQMv0phfvmW+iEkvK7yArzjWF+PdhSSC4pTs1ADkHRvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH2QRV2RJmbp8RThunsKrxArHFuGIbevq8Kgj9yl1eY=;
 b=Z5SPAEgtGVOy95xA6WJbjaWPshnV1lk9RIU2i6XEyYhCmtKxcFbVY0sdyuBdTPN2KdsWuaseSerWUzv7Mcp7T+9ldDuRHivAjapov7q+o1qcS6yi6CkJ9oONF37NqBNkVdqw4JY1oyHL9IbKxh3ydkhinjo61Z0pooHmjRP0wlHrrnBwqWS9b8P+YbDsTls76+tjnsoacCUULliRv0KJ7g+JFFbhu+J0/MqVcR4CBXNgDEVjd5SmBw6t809S1mlHwMHOhFUV0QZRgV/1RxmsFSi4FBS6uROE+Vdty5P4i3N/Y+4GSm7EY7cxARgVzc+j5eg69TVhwMUmaNaXauiD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH2QRV2RJmbp8RThunsKrxArHFuGIbevq8Kgj9yl1eY=;
 b=uuheYPSVNQ531M/Tb2+Y7vWzG7vhAuHD03LG+GBtFQSIW5KC3/m79OoPWh8FkKCIvf5EmbNzXCsqIsgvzpiCn3s8jw51038fDGbKRLSHxFkVeQ3wMniB9HZdQ/yn7vmgFkzkkwlcAajYiVYeEsPSNk8bE+leJ8EFAaMA4jjAByY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS0PR10MB7320.namprd10.prod.outlook.com (2603:10b6:8:fe::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Tue, 5 Dec 2023 14:14:44 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7046.028; Tue, 5 Dec 2023
 14:14:44 +0000
Message-ID: <126e688e-4d53-4b34-a867-04517f24a439@oracle.com>
Date: Tue, 5 Dec 2023 09:14:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n> <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
 <ZW4LX9FpfTj77TZv@x1n> <87r0k1n4r7.fsf@suse.de> <ZW4wTK0dld9pPCtX@x1n>
 <87o7f5n08z.fsf@suse.de> <ZW5M19173nTZTLv1@x1n> <87cyvkn7j7.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87cyvkn7j7.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS0PR10MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 957b3701-d667-42ba-f50c-08dbf59c87cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsfcL+boA5pRM69T3CSLSo2CEEpMTSUjVBBakQMpitc/nAOWe1pKqecvCghSUnsDQuGlQsu7KKSX07+jIK8gq4b7HvESIp2djsUxQl8LRlxuz6NDaTrqzwPEYdFJKU2+BD+a2DgMcdjIU/OQHcvem16YljUkBcRyeOAxPjmNLS2VgytI3cDkKdHtxKXcAWp8bQxLAiyuE+9RuGSV8yo+ARI9zZFOSduUcOa/o2LlKOwYoxTUfv19h1G6dmdMBkE2H8SBP73e3+tWCw/USxUhFmZq4YYaYKNvYjSUcNFozLcJUE9HqjwnNuQ+1okzuXQS2dpubuAH+epvJynKSGSjiBn8bE5dQlO7hE1r5iUmgMljBzbzt5LvsB8gmTDPfBknnonLi03NhGMSNulGZ5xbYx0b5h6iBXpfDjWc0WB6tuFFgZLU9xRVnFkwwF5piyLW8+0suUuCKbGRkRuHA4m/uFbZ1NKn5MovU0mQoH3CqScMtkBHLF+wETiZwHzybKA+Vxs/yZbMI3Cz+wBVctX/W+WVSUg0NL6+0f4DUFSv3l4ziYBM7q8woKpcvVuJpTFWiU9hPMn2ZbBRrnBGDPh9wh+Dy1/ul7auiMYMgZwVscwz4dxzljc1ouG7WyA5JW4noVOz6Pp5wvxX8LQxsmS9iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(15650500001)(2906002)(6666004)(6486002)(478600001)(8936002)(8676002)(4326008)(44832011)(86362001)(31696002)(66556008)(66476007)(110136005)(54906003)(66946007)(316002)(5660300002)(26005)(83380400001)(36756003)(41300700001)(31686004)(38100700002)(2616005)(6512007)(36916002)(53546011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWtHaTFtZUszMUFVUWpTY1BxTG5UaWdHQkhuMGErdjhVbXBTeENmUmFJSko3?=
 =?utf-8?B?QkNOOEpEakc4RGNidkd5UStoUXRXbERIWUhNRmJoMnhreEM3QTNReTc3b1RW?=
 =?utf-8?B?bk5jbkV2Mzg4NnpHcTBzbUJ3YTh2dG4wR3UxVE1NVG5vUW9EQlVlS2NiWERG?=
 =?utf-8?B?b0p4NVo4dUoxdk5KZVRCY096TFJJV1pjR0pTNUtTNHV4cGZVdmZaSmJyQXBB?=
 =?utf-8?B?UGxZNHJSVFg3T1JhaWZVa3o2bll0dWNvK0wyZVlEY0gwZjVQWTJzejdxQlpt?=
 =?utf-8?B?dG54VGpNSUtOL0s5N3BtbkR6TXBxOWZBbHJ3Y3NNWkFabElCVTNwYUFyM04r?=
 =?utf-8?B?R0NUQjNmWDMwSDFhSElmMjRpODRyQ0JtMUFQUXFWODA4NnJIclBRVkYrNzRH?=
 =?utf-8?B?N2xPUm9jWjEycCtKclE5bDU2cCtuOTkvUXY5Q25ZLy9xS21FM24yamZ2dlVl?=
 =?utf-8?B?cExPa0JPSzkrSkNOeTh3dFNUNmhVNmdicTV4SDB0NDZZUk1hcDRyRXJuYysw?=
 =?utf-8?B?Z3dkSlllcEErNkEyYjMvYTl2bmpHTWRXczErMTFqQUlQclA2djFuTHhmWTcz?=
 =?utf-8?B?Z0FBU2Q4cUtlcU5IampYMTkxNU92VkZ1VDFVMWNqUDQweWl1SEZtenMrRHd2?=
 =?utf-8?B?NjEyS0M1bnpNcytnelhFV1Y1cjBuYXBvSW50dlM1cm5YNmFSRjNNMW82V0t4?=
 =?utf-8?B?S2Z5akhDdnVIUVhnM21LUS8wZlJVRzYxTWJHLzk2Q3p3K2p0Vk5kMkl1Qldo?=
 =?utf-8?B?bXE3bHdmZDdkQ245RjZubisrejR4NW5Pd2U5cHpPaXVIYXdTRlZLKzZJbXls?=
 =?utf-8?B?QWZ3bkpJdDJTY1I0UnlUOE4rd1JtN2tUUkV5Q1BKbUNWdVI2eGtkN0RTcG5K?=
 =?utf-8?B?SVB4UXIrNUZ1cGc4b2Y5OVptd2k2c1FMZDBmaUpZUzllN0cxUkZvMkgvbGhh?=
 =?utf-8?B?YjBSMHptbjlGQXlqL2s1V3plV3V6MDJZcWlnK2RHUTRuZFN6Tzg0SWtlTWJr?=
 =?utf-8?B?QXJzQXdPUWlVdWRKcGhzWUZIYkZHZXNXNVFvQ2dNMVNOR1Zybm5GTEVMajFl?=
 =?utf-8?B?VWtGdlpLVEpZTDlKTCttMkduYnl3SGo0WFdyTDV5eXYvODQwRjFGZHBCd3NC?=
 =?utf-8?B?NTdrK2hsV0lZUmZzRlBuNTMxcFhjaGdLY3VxY2dHMmU4RmIyZFlRWjVhZUI5?=
 =?utf-8?B?SUdQTmdhb3U2RXRnZFpWMWhwM3EwS0g1R3czYjFmOFBMeVJJRkdJT3FTR1R1?=
 =?utf-8?B?Yjh3R2Z0bGNlQVU0YW53YjNNckJTSG5jSGQ3NDBiL0oyd0l6QnJQVVV6M1I4?=
 =?utf-8?B?M0hSK2lWRzFxemsrRE11QU55Z2VmbmFyTnVOQitLYXpDK051aHJOR2NPcysw?=
 =?utf-8?B?cEdTOWNDZktCRFE4eXI0WENWUVQ4SXY1d1VEbHJIMjNhL3dQb2wvOFJPTC8r?=
 =?utf-8?B?OFVobDJjL1lVWklleXFLY2JqNzBFMFNoRTk3OTJDejBROGlYTFhTSXRvajlO?=
 =?utf-8?B?MHFQaE1tNnE2NTB3aEU4QkR2T1NXbnpQWWRrTmV2dW1qcEYvbWZ5UDdKQ2xi?=
 =?utf-8?B?Z3R5ZHViVXpSbGlXU2FnbXB5eFpaeU5OTXhVek9iQXlvUi9CQ05yZWkzYW1L?=
 =?utf-8?B?L2tJYWNEd1ZuQUtDOTQraERoSzc0RUhHNWlVV2VGblBoK2RpVFJoY2xSRnNr?=
 =?utf-8?B?a3hkcVA3NWhLRlVoeDlxRWVVaklKdkovMi9VQU53bDRyallUb0lqUWRnVFZQ?=
 =?utf-8?B?bzRTNTdWNlcyRHJDcHR0VkhjNUFFenZaR3A3cTMybC9Pb0dnckF2QnZqTWZD?=
 =?utf-8?B?YUw2YjNXVGxST0JjUDdYWUFFWjA5SzZBY3dlWVdLUDgxd3dtTGdDc2lHaHNX?=
 =?utf-8?B?S0t0K1RZcUZIODdFUGMvNUhnZU5sVkVOK1hFZHV3TVZmSXBKdThvNnFQdW1P?=
 =?utf-8?B?a3lFZmdiU3g2MjhWNzg4a3NFZGl4a2FteWZUOHVtL09SdkM1SUpRNWFmWTlC?=
 =?utf-8?B?cHNoNGRaamJZWk1EZy82UXVwUUVnaWFnMEVMSHlkVGJ4S3paRHFQNWtnanR2?=
 =?utf-8?B?MGpaNVduUXF2QmJraU55V29RczJYV0pvL0xjbkhkdUVldmZTL3N6TjhnUDBQ?=
 =?utf-8?B?ajNmTm1BckFKY3czSmZzcFMwV3U1dElscGFsWnRkdTBFSTh0NU0vWnIyWk41?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wIU+tBdT50+JCEnelfCTznHdOxD36EAsWDrE+5rJhFH31iuz57sROgl5J5Z6QdXUzCEiJPrmeUR0DErcofFQKT0gulyf9HnK3dV/oGlN5HlMDAm0PxeabvSsBZeQGzFMNqmLxBil2bbtjLYphYso7HtbuzOJLNvlwXmw/lbKYMRCr9ierivEFggX7gjDRhsYAlNQVcNXaKfqHSH68QH49Gdlo+T1S1IphGnwxYCDTHKRaa+XwJ7P2BOXEP1+0MSgyHveG0KLzhV/7VWtFpDMkdUSoANZi3eAs1uJhKG5VYVkLQBvKehuRWyFttH0Ycu7MJqr+OvKwZudXxLuddUjltZQa0KACZYTxFt9B+lHHOMuIf84A795sZxUBbolQDRE+/8hxPmxQzuNROqXkrW/W0pCoDEiDvodvV4jNc0KlM87MdRGu4oF/msBBCEwNYLYNTz3EOm/A8vWzUJry60BonppcIwNwP9D8STW5LBL5+nOVxMwuFROQ+WeHKRDHpuXEKASm6JOioSjGXHMqezEhTNGU3IbV2nUR3N78Iit+TBehI0vE2W7rn4AjQY/86aMficR+3IBcdZECsh7/vHj4urNUeTHPJ9dovOzOikuwVfnJNxkfeBjsTmzhLRwnIznm0KlY6SJlbHXASGAKzdcjyF3ciB1pzdSBcaPwa+Bcqvn0YPBJ/FXTHHoaJ35b/vBmb7H9L6GmOW780MRkcTvel2QnbqhKrFGmheMLs/idGtoWt0zaU0GUsEwybJYPFKXNGnLyTNKnOIKVD767SurVxbuVozrsP/Beqyudgh0wKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957b3701-d667-42ba-f50c-08dbf59c87cb
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:14:44.6758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgD1w1nR//XAoXJlndQbJcAzos1T7AOX3pMETwbKAkiyxApkAcreDWpq5leMletUOsvvaEbT/srW8eHtj8zNRclKFMt4XrWGC3GUXaA/eb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_09,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050111
X-Proofpoint-ORIG-GUID: FmtB990cz7f6xoYyY5lrsTOlg_NsNKBz
X-Proofpoint-GUID: FmtB990cz7f6xoYyY5lrsTOlg_NsNKBz
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

On 12/5/2023 7:44 AM, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Mon, Dec 04, 2023 at 06:09:16PM -0300, Fabiano Rosas wrote:
>>> Right, I got your point. I just think we could avoid designing this new
>>> string format by creating new fields with the extra space:
>>>
>>> typedef struct QEMU_PACKED {
>>>     uint32_t size;
>>>     uint8_t runstate[50];
>>>     uint8_t unused[50];
>>>     RunState state;
>>>     bool received;
>>> } GlobalState;
>>>
>>> In my mind this works seamlessly, or am I mistaken?
>>
>> I think what you proposed should indeed work.
>>
>> Currently it's:
>>
>>     .fields = (VMStateField[]) {
>>         VMSTATE_UINT32(size, GlobalState),
>>         VMSTATE_BUFFER(runstate, GlobalState),
>>         VMSTATE_END_OF_LIST()
>>     },
>>
>> I had a quick look at vmstate_info_buffer, it mostly only get()/put() those
>> buffers with its sizeof(), so looks all fine.  For sure in all cases we'd
>> better test it to verify.
>>
>> One side note is since we so far use qapi_enum_parse() for the runstate, I
>> think the "size" is not ever used..
>>
>> If we do want a split, IMHO we can consider making runstate[] even smaller
>> to just free up the rest spaces all in one shot:
>>
>>   typedef struct QEMU_PACKED {
>>       uint32_t size;
>>       /*
>>        * Assuming 16 is good enough to fit all possible runstate strings..
>>        * This field must be a string ending with '\0'.
>>        */
>>       uint8_t runstate[16];
>>       /* 0x00 when QEMU doesn't support it, or "0"/"1" to reflect its state */
>>       uint8_t vm_was_suspended[1];
>>       /*
>>        * Still free of use space.  Note that we only have 99 bytes for use
>>        * because the last byte (the 100th byte) must be zero due to legacy
>>        * reasons, if not it may be set to zero after loaded on dest QEMU. 
>>        */
> 
> I'd add a 'uint8_t reserved;' to go along with this comment instead of
> leaving a hole.

I'll use this scheme, thanks.  It is a clearer than implicitly packing strings.

- Steve

