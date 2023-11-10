Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D597E8269
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 20:24:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1X6O-0002a3-0i; Fri, 10 Nov 2023 14:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1r1X6L-0002Zf-Sx
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 14:23:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1r1X6I-0005fJ-3e
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 14:23:33 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAHiQrv023279; Fri, 10 Nov 2023 19:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=VT1IaNr0X5Ly5RbiRuJyR9Q0ZiP1qgsus7bBLMSN1Io=;
 b=mB5/JCHSpqcwAalWJjZvFY5Ccu+WWvH8h4TU5mD1wdBwYag1zMKbZ69JQ0uo33qcMv0M
 JJSrxPqq2lbdgZgnjAi+6u/UtomhWWP5xD1NLg7p8JX1MeNK/na5U3oCUAC/h8i09+iB
 pU/sLoHcXkoaFqn/RchVDBoe7vwiteiD31uzLaxQY5l29wZjMkdWOgq/ker2b8DyAbaE
 /BdTNEIZ3SnQQMhhfVgdC9XgLVOZ8N/KLPavXK9GYpz3K37ZYHDHyjLEgCc/t/MPHs/C
 wqYemKNPu9pk1Os6UCzHj84Qa9dt/nKRIHHBe+mVGfUrLIkWKWreasAXYsVndSQRjugg YQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w216wmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 19:22:58 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AAIPgHj024983; Fri, 10 Nov 2023 19:22:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u9fr77fwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 19:22:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCTYGLkfkoJmugrYIWPrtdBPb/lkz0uwcGrc13fTN9qVwJtJzADUuvULPynv1SdCkTt6iEDznaJULsdws9lsOPQwpzJczlksFJPd+XC2fxnDB6dw74EzqMjiUSquiN7LOr61JxljhV8mdJMCxlQKi1FgvbCkdlrcW6RyD4iVUl0Qx47+H3m90zc23QXPuTjsE9qoKV5NDnZALgS54xu6osLYk0ExCCyMQxpTIFgRz5O+/69n9ML900lSNIj4CIr95hpU1zhXnmlMP6F0EQwgD5KirTBHUWiwDe7JwqXu1+yH2ME2LcB4dXKWSL5VuA6xm6VU+MYUboU+1eyAQePOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT1IaNr0X5Ly5RbiRuJyR9Q0ZiP1qgsus7bBLMSN1Io=;
 b=A2zzTr7YfhYpd75ZNxinu030y2DBKlZ6ZlRVIqrldTLMSR3Ocjw+uoVXwb3WCzC5/vxzm+3yw8XxmydM0FJq4SndoFclBsf0rp2Zdf4/r/LGjNF+v+iEGLjYGq1IPk7RDbi/1URXHeWWqHIrefZr7l3Zxb8arL0+cd/wvIu2LI58wWa79IyVdpIgj1HLW95eohX+wh3fq5yFfuCDfyURgF2eELxo2bjvpO3OBuV5kWlHBJA/xpPIxEChteRPzGLJJUy+HLcF4uASTw6MqhAn4fCuLrrkU//VPchyvGPW99qU6yFEGt0lMkUTlQaz4c45fRZq59U1k9oy7/ottdU1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT1IaNr0X5Ly5RbiRuJyR9Q0ZiP1qgsus7bBLMSN1Io=;
 b=zEnyYi0z1fAW35djgR5T0hr9MHG0WBDFHB5eMGqmNur8q/Wnyz/vmbyDk2syd/DnxBD5TMFFgMSC91OMHzJg6pRMHkV9IELAYPctW1tClFdTG2Txek7aMtjKmRtXo1TFRwCw7Dug7tk2xLyWUDw1MNa26T61JP2Xnv9WLQ9/Vv4=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by SA2PR10MB4476.namprd10.prod.outlook.com (2603:10b6:806:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 19:22:55 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::448a:a2fe:44f7:3e90]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::448a:a2fe:44f7:3e90%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 19:22:55 +0000
Content-Type: multipart/alternative;
 boundary="------------HwKxFBMtz3PUrQYhSERwJR0D"
Message-ID: <43bea81c-cb7d-44e9-a9b9-3f059faf472e@oracle.com>
Date: Fri, 10 Nov 2023 20:22:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] migration: prevent migration when a poisoned page
 is unknown from the VM
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, pbonzini@redhat.com,
 quintela@redhat.com, leobras@redhat.com, joao.m.martins@oracle.com,
 lidongchen@tencent.com
References: <20230920235301.1622672-1-william.roche@oracle.com>
 <20231013150839.867164-1-william.roche@oracle.com>
 <20231013150839.867164-3-william.roche@oracle.com> <ZS1pSeL3hj4/73lk@x1n>
 <c0af41b7-56dd-4395-8c79-d630ece3b589@oracle.com> <ZS6ksf8o7dJ8mzUe@x1n>
 <d0c6b2b9-ab95-4b29-969a-85edcac3f8af@oracle.com> <ZUwBgzr1GcSIy0sJ@x1n>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <ZUwBgzr1GcSIy0sJ@x1n>
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|SA2PR10MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c9b179-d05d-40f6-d878-08dbe22270eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/dWtKdU6bWqlaJZTATKYwoV8Tm3FQAS6sr/mDCdEpd+0qANcgjftOb+tVxw0M+KOuhM5kur54LolCfVeFwsA7Mdu93QbzEbFY3wrs3V3ll0Ag7c6YUjoDbwYakTA1PXo40Ouy+NUpvdZ7NVsnZP4njqdWTlzTDseHhf8Z02pUNpTZeo74CzTave9noGv23NUDJnQWmE7XaobUtBYAKiy6XRNVLa29XAldZLDCQecdv8QXxaWlqVP3JsH1gnPypfIBGqDiN078c0SNM5Dpxtjs5Bkvo0Wt1TcEqKtkmjBsrCzL/8HGKajrASaBN3at3Cnc7QvFHJ3T7gIPVgydKiAcCUNyx8pDpPTDXrdTGmAqdNZuhDhGwO9TwqwRDOKGHzVFTj0fMocYFyy0rVR08+Yk2v4WTXWM3rGjrkzrG5dvLMlGZUuu3fwZG8mP86TvFv5m7o/PcJjEP9jh1tbt0qAltG+hR17v01DViRc/tJbHtuo7+o3mW8bWuFyzt4Heai5bUjpGwF2hLsyZhKvZr+fLdXTLlDIt8Cxgx4zcEICbg3dOMtdNxlkD+DY8ceUqOfbLkmLZcax2qDTeJNZeEjc9Pl2URRnLWHiVwIeJyUPEovrZAElABFdz9XZx03P2BimAtqrb5WHYtGZXhH+Z8rjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(66899024)(8676002)(44832011)(4326008)(8936002)(2906002)(31696002)(86362001)(41300700001)(6512007)(26005)(53546011)(31686004)(6506007)(6666004)(5660300002)(33964004)(478600001)(6486002)(2616005)(83380400001)(66476007)(66946007)(66556008)(38100700002)(316002)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE03NTVaWGpSQVVhYzVrT01hQ1psZW5YMUhzdWJ0Ny93YUdnVjV3RTkxcEtn?=
 =?utf-8?B?TzZ4bmhCS3B5MTJTQk9FYmc2cUkrYUZqK1dwMTZ0V3c1eHU1cXpMaC8rTVFI?=
 =?utf-8?B?UktKNFYzeDlSU0tDakt3Q21iRnhMeTcwS0FuUi9vMjhiZS95S2xOTlc0Q2dz?=
 =?utf-8?B?bk5JdHZvcDJVR0FpTWtRWEVpdnZrT3Z0M2ptUUpLZ3FnMUsyWCs1S1FMa2VJ?=
 =?utf-8?B?amJjRjU5VEt0L1pBaFdySmZzRGdzTjk1KzQ4dDhkZSs1TkgvajIwRloxMjNQ?=
 =?utf-8?B?cFVTRjBRVXV0dnlJWXdwRldUNVFPTlNRejdyNTBuQkt4Rm52RnpGQkJnQ1Ar?=
 =?utf-8?B?QUZhOTB3NndNQUR0OVBUb3RTMUxXd0gwK3VtZCtQL29iK1M0emNKVVMrbmxH?=
 =?utf-8?B?b3dwb2xoV1FYMkhXZjBLb29meitqcU5qZXVaQXhURWVmdThwSjVzTVNoa0Mx?=
 =?utf-8?B?bmFMY0NsNHRvakZGdjAwVmYxVHRvcWpUd0YwMHJsdU5JekxGazRadmxqTGV5?=
 =?utf-8?B?ME5vR2J5U0ZjaG8zWlVpMU93am11NWhxTGlBMWo0OHlOTDV6cnRla08wNVg0?=
 =?utf-8?B?Q3ZGNjh4ZUZVb2dxbEdYbE1wdGlVcitYRFVnZFArVjcvS01ONGJRbkFWdVdZ?=
 =?utf-8?B?T01JblNMK2MzN1hxRjRHdjNTZTVuQ2c2Q2c0QnRtdy9qaXhPSHB0dnhhdlR3?=
 =?utf-8?B?a0xSZ2l2NFVsUDFXTFgxaUt2ODhNWUxwZWZnWmY1dWJlcUpoRXFqU1hnT3ZQ?=
 =?utf-8?B?cGVIaDU0S3lZSFpmVWtEQ2hDTy9QRExEQUE1blNkdTRQQ3RyNTZHV25mZXNp?=
 =?utf-8?B?SklzMlErZG1EVFJiS3hkRHUwWUw5Wk12MnNObUtjZ2pDMUhHR3g5emNpaHI5?=
 =?utf-8?B?ZmZkNnE0dUowMkFrSnE1Si9yQ2ZmTmZEWlVmNVRFSC9oZDEvNGJPMk1NUFJV?=
 =?utf-8?B?aTFNb3RLNVBqRTdDQXZiZEQ3Ujc0M0tZQ05jN3NCZGs5Z1ROZEFEYjBaVTRB?=
 =?utf-8?B?ZWtyOE9HWklDbS95WDdFajBoVy96c1dmSG1NcEd4WnEvc1V4WFNZNnRvT0xN?=
 =?utf-8?B?YVZGZk1lQU5qUUFVMk81TVFlekxrcFdOcVZnb2VDTTdCMTRkUWU2VnVKQ1dR?=
 =?utf-8?B?SmZmOFhOOGZnVzlmdWhQMUhHd2JMWDZnaGUwK0I0TW9BVExkbG5Pb0IyREcy?=
 =?utf-8?B?aThKdnNsamFEWjdwcjhsMTNCOGFxL08xNHp3QklTbmtlZDR4M2ZoVVdDdWhz?=
 =?utf-8?B?RHVpVWNlM0xZRVhiK0lud0NVMFF0VE54aDJyTElaNlI4VkYyWGJkSG1IcnlD?=
 =?utf-8?B?aTd6ak1YYXk2M3owSHFSeEk1UTVrRnhsV2luZjR0cjNTN0xJeEFZZkNaU1pL?=
 =?utf-8?B?cnBEVXNLZDZrVlVndEIyZVM4RzhFQlZUL0htTkU5VWpodFpVMGtReDdubnk2?=
 =?utf-8?B?QmZFOFp0MW52dmlEeWNyVTcyczlBYVN1NHJ1dWZxNzFXRGdJQ0hOdDFoTFdx?=
 =?utf-8?B?bXh5TXJrOExnWUNYeFNaOTNrajB5K1RUZVlLWTZ6RnlOaW1ZdVJrSk1JL3lL?=
 =?utf-8?B?RVE1RmI0cWVKajB0Unl3a0MwYVR6Q0x2R3ZrT0VpNy9RTVk4MWEveWlqMXhN?=
 =?utf-8?B?dGljUjZkbUZiRG1Gd3NRVVRjWTY2cUN4Syt1anRtTk5KbU1WSDNMUzFqc1l4?=
 =?utf-8?B?NFhkM0hoekFqaHhPM09qTXp3TS9iUlZPbEw5R3ozN0sxR3krWFB0dllVbTdG?=
 =?utf-8?B?RldOSC9RRGUrUWlMQWJLVGZWVUphN3Btc1plWkpwT2J4Y1dLVzZsU2sveWhp?=
 =?utf-8?B?UzlJVHFQSFM1OUZiQ1BVcHdVcmdWRjI1SURjN3hNRkYxakpMelVmYjBLVDBT?=
 =?utf-8?B?alJLUTZ0a0ZZbmhvQ0FRRUd3eGVSRVNHTG00THZvNHM5eXhrTmRBNXNaU09K?=
 =?utf-8?B?NVFpTlVNOER1UXU5eXdaR3RUb081YjJiM3ZlNTdMV0tRNkRCQ3NnMUhVWHla?=
 =?utf-8?B?V3hNbHVzNExkRUZXT3JyY2VWS1RFblp1OEdpNzRmUXEvTUVXUFkzQ1dQUFAx?=
 =?utf-8?B?OCtlYUovUUU3bFVyUG5zSmk3NEFsRjFsSjNtczhTNGNpc09WbDloSWpuWlpN?=
 =?utf-8?Q?FNiwhYft3sjs9YeTjXx79H78E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: upnNpWF0y/yq2yERBDEjLbzszbID8J2KDwXZzhXKBLNoE385vuAoMyl7mnjoqedc2bV51y8eOEPNS5Kd+ibgIegBNxCsP7/HWWx7B98kef/+FTt5TSmXDodsgwkdoMf9PyeFyxLRtLHBF4m1gInoAIalaERPf5RTSr/71+or0t0UPKeCWXcgfUIQQcy/0zNNjj7reUELT+ow2nano3M7KVK7o7TtagL7e7rGofLf+J+36Pu/qBxY6gTyBjs60sGa3uy+Y6wfpzKdi023jrxUyc871oxEs4Qtr7vp8ae4wD+LV6vJaUgeAUrAMOLNsqfDDKH314QiMDbO6mezE0Sq+469AmFy25iXxzUWeFnvoTU3z8a1wmF5HT+catgsxZBSPOKnG35feDdnbRCENSuoG2MTFks9yDfdZMwdO3+SSOUxZ0tLQ2eUEE0cRY1ftokRqEciX0568qCXd+yBnXBNTg/GZT0yH4Cj9ws5fRGGj0rCbvdc//+jp+DPiCwJZV9AR1mxVTJHTqI7cTS+Z/qdA1SHE8yLRATu3R4BCYi65Ucf5++xEaNP6RRl1g2uiNnZ/R/Gy9t7xj2tB3HvriWj54b/ZwWDyBpM7kVHr6tMvA5DjwdHXdLGus9YB7m5Nkonw9QkasHUZKOx6VxPe1lRdSKRKJZZjzEy01pQgNpb6iF0kyTUK8JFfnHjzlgkRuDtB+UcVWsYlqwMvUi5qCz5HIPbMvHU3ATDt/nsh82GCLEDdR9lVL1ji+xJ5IHtaWK0kohP4c14+AuxxLSlrEpvItvH+rxQbGrxb9K2XsW2rOyrAonlLbUNf5M/Cuvng0+uqEY0G6FA7ilpIUaIeFtCIg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c9b179-d05d-40f6-d878-08dbe22270eb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 19:22:55.5580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTmEpoVIGBfn2Ku0uSxaakc60K0jqfkAbAC3ILSuOnpN1Y4FdSuwM+075N9CtvJyx1WeBfbo9pDEL8IypkmQpn+ujpaEnApojChP2BoXAVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100162
X-Proofpoint-GUID: q0EucTmyatttRAzKl6C-1_lzLzYYPBXe
X-Proofpoint-ORIG-GUID: q0EucTmyatttRAzKl6C-1_lzLzYYPBXe
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--------------HwKxFBMtz3PUrQYhSERwJR0D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/8/23 22:45, Peter Xu wrote:
> On Mon, Nov 06, 2023 at 10:38:14PM +0100, William Roche wrote:
>> But it implies a lot of other changes:
>>      - The source has to flag the error pages to indicate a poison
>>        (new flag in the exchange protocole)
>>      - The destination has to be able to deal with the new protocole
> IIUC these two can be simply implemented by migrating hwpoison_page_list
> over to dest.  You need to have a compat bit for doing this, ignoring the
> list on old machine types, because old QEMUs will not recognize this vmsd.
>
> QEMU should even support migrating a list object in VMSD, feel free to have
> a look at VMSTATE_QLIST_V().

This is another area that I'll need to learn about.

>>      - The destination has to be able to mark the pages as poisoned
>>        (authorized to use userfaultfd)
> Note: userfaultfd is actually available without any privilege if to use
> UFFDIO_POISON only, as long as to open the uffd (either via syscall or
> /dev/userfaultfd) using UFFD_FLAG_USER_ONLY.
>
> A trick is we can register with UFFD_WP mode (not MISSING; because when a
> kernel accesses a missing page it'll cause SIGBUS then with USER_ONLY),
> then inject whatever POISON we want.  As long as UFFDIO_WRITEPROTECT is not
> invoked, UFFD_WP does nothing (unlike MISSING).
>
>>      - So both source and destination have to be upgraded (of course
>>        qemu but also an appropriate kernel version providing
>>        UFFDIO_POISON on the destination)
> True.  Unfortunately this is not avoidable.
>
>>      - we may need to be able to negotiate a fall back solution
>>      - an indication of the method to use could belong to the
>>        migration capabilities and parameters
> For above two points: it's a common issue with migration compatibility.  As
> long as you can provide above VMSD to migrate hwpoison_page_list, marking
> all old QEMU machine types skipping that, then it should just work.
>
> You can have a closer look at anything in hw_compat_* as an example.

Yes, I'll do that.

>>      - etc...
> I think you did summarize mostly all the points I can think of; is there
> really anything more? :)

Probably some work to select the poison migration method (allowing a
migration transforming poison into zeros as a fall back method if the
poison migration itself with UFFDIO_POISON can't be used, or not) for
example.

> It'll be great if you can, or plan to, fix that for good.

Thanks for the offer ;)
I'd really like to implement that, but I currently have another pressing
issue to work on. I should be back on this topic within a few months.

I'm now waiting for some feedback from the ARM architecture reviewer(s).

Thanks a lot for all your suggestions.

--------------HwKxFBMtz3PUrQYhSERwJR0D
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 11/8/23 22:45, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZUwBgzr1GcSIy0sJ@x1n">
      <pre class="moz-quote-pre" wrap="">On Mon, Nov 06, 2023 at 10:38:14PM +0100, William Roche wrote:</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">But it implies a lot of other changes:
&nbsp;&nbsp; &nbsp;- The source has to flag the error pages to indicate a poison
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (new flag in the exchange protocole)
&nbsp;&nbsp; &nbsp;- The destination has to be able to deal with the new protocole
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
IIUC these two can be simply implemented by migrating hwpoison_page_list
over to dest.  You need to have a compat bit for doing this, ignoring the
list on old machine types, because old QEMUs will not recognize this vmsd.

QEMU should even support migrating a list object in VMSD, feel free to have
a look at VMSTATE_QLIST_V().</pre>
    </blockquote>
    <p><font face="monospace">This is another area that I'll need to
        learn about.</font><br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:ZUwBgzr1GcSIy0sJ@x1n">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">&nbsp;&nbsp; &nbsp;- The destination has to be able to mark the pages as poisoned
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (authorized to use userfaultfd)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Note: userfaultfd is actually available without any privilege if to use
UFFDIO_POISON only, as long as to open the uffd (either via syscall or
/dev/userfaultfd) using UFFD_FLAG_USER_ONLY.

A trick is we can register with UFFD_WP mode (not MISSING; because when a
kernel accesses a missing page it'll cause SIGBUS then with USER_ONLY),
then inject whatever POISON we want.  As long as UFFDIO_WRITEPROTECT is not
invoked, UFFD_WP does nothing (unlike MISSING).

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">&nbsp;&nbsp; &nbsp;- So both source and destination have to be upgraded (of course
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu but also an appropriate kernel version providing
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UFFDIO_POISON on the destination)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
True.  Unfortunately this is not avoidable.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">&nbsp;&nbsp; &nbsp;- we may need to be able to negotiate a fall back solution
&nbsp;&nbsp; &nbsp;- an indication of the method to use could belong to the
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration capabilities and parameters
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
For above two points: it's a common issue with migration compatibility.  As
long as you can provide above VMSD to migrate hwpoison_page_list, marking
all old QEMU machine types skipping that, then it should just work.

You can have a closer look at anything in hw_compat_* as an example.</pre>
    </blockquote>
    <p><font face="monospace">Yes, I'll do that.</font></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:ZUwBgzr1GcSIy0sJ@x1n">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">&nbsp;&nbsp; &nbsp;- etc...
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think you did summarize mostly all the points I can think of; is there
really anything more? :)</pre>
    </blockquote>
    <p><font face="monospace">Probably some work to select the poison
        migration method (allowing a<br>
        migration transforming poison into zeros as a fall back method
        if the<br>
        poison migration itself with <span style="white-space: pre-wrap">UFFDIO_POISON </span>can't be
        used, or not) for<br>
        example.</font><br>
    </p>
    <blockquote type="cite" cite="mid:ZUwBgzr1GcSIy0sJ@x1n">
      <pre class="moz-quote-pre" wrap="">
It'll be great if you can, or plan to, fix that for good.
</pre>
    </blockquote>
    <p><font face="monospace">Thanks for the offer ;)<br>
        I'd really like to implement that, but I currently have another
        pressing<br>
        issue to work on. I should be back on this topic within a few
        months.</font></p>
    <p><font face="monospace">I'm now waiting for some feedback from the
        ARM architecture reviewer(s).</font></p>
    <p><font face="monospace">Thanks a lot for all your suggestions.<br>
      </font></p>
  </body>
</html>

--------------HwKxFBMtz3PUrQYhSERwJR0D--

