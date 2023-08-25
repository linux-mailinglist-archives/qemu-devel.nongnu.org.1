Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B00788E15
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 19:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZb31-0008Lf-EH; Fri, 25 Aug 2023 13:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qZb2y-0008LT-Cw
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:56:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qZb2s-0001qC-Fi
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:56:33 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37PGKSnl019039; Fri, 25 Aug 2023 17:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WZF9ZrY/ZNblOowy5fp/ftfR2/d1VTl9uNWVGmALzuc=;
 b=npSHSWLpLWbCIUVeyv2LwooYS8dWxMt6JaRGewjw3g0P/ad5wGdGcC1iFsbfCT9JS7px
 MuxJon0OiRK/5y4Jp00DRvrcBUmpM/ka1GqbwYlM/O4Pv5uMrVCiApaGlSRj3L6Pp8eM
 4HVQ8JUSrabBophiHCowUT5huqBYJRulSdJ5zyJSZ5KsJ/G68aMgR92fAVagNCzVIU4J
 QDLCeMB++er9Qbb1AWHCqkfsIHeRkUrCwUkl9gASrD9klkyOtmsiSUNbERBxIf8T+RPa
 u8GO1rAwAC3MJu0EHcr1Y7scdPR30Pv8TMclRXsDZzuAynILsX0n5vddjtkD4tVTkzx3 BA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yu732r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Aug 2023 17:56:28 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37PGUUuP002146; Fri, 25 Aug 2023 17:56:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sn1yydq22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Aug 2023 17:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwnbgfWyoyrBxDhCavd6px1fxsBVPCRvuYTVr0iAWc8BNaTYp3A2unqVracFyrpylFmNvoS1VBmgTyxQ+8pZC2nFil08dBdGJX9/59ruQGC6b4Dh+IyZeN/M9r9gKDONxu+dRRafEhzSXjLQuj1OLJbbEGkOsCibrVF+4s4sygGPPhY5Xx7tTdO3rrmIslNdFI2U02966/MW/iZUctmM65lBUWFNGT7gNEMwQrzh816vgZjM0z+w6Ncuz5uhiPkrRKw7hoVPSM2W78uK1p19y/m0lCPxq41SemKSt8zMBJMenStBe0QlYcoD60ttaUCJF1ygbyyJDOSJX6lTsnzI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZF9ZrY/ZNblOowy5fp/ftfR2/d1VTl9uNWVGmALzuc=;
 b=TL8qax2PGDye1b7vrD6gvaD2OTyrIJIdltDCkIz1QHbm/gHUfmF3ls6yZ9iJljFfh4PGja+82u4n9+dPmXpRYonOpN+ETgrFCBk+hwSmV8FO5QUXTEkZ7Nhw9aQhl4D5RcFQM2KwVaOBgf6KWGDf4fhrTNKqxJ/lQY/OYD/1h6kb9cwEpT3cEHbXat4m86Cd9AzANr6o2CMwtrPaeL6YVfZOEXVK6lVhWdWSCZqOd0164KJiiEJzxGtRlFQYD3dhdo6qdiisBTwnF3xF+HVNs6v2Fqy/gaPoL0oEWcUKbNBJmwL9GjfXLLhDq4Mb/Te6lDT3LyuLNWvZYWpP+C6w4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZF9ZrY/ZNblOowy5fp/ftfR2/d1VTl9uNWVGmALzuc=;
 b=K/5XB8RY4P4/P0dQr80/enxRo2RH5JcSxNraK925P5PXzLNmhtybVVXUNM52RzTh6/HcPXwbQkXGyM45fDSVW67hSc+Cw6WVaZWSBXH2g0nO6rW8/lJVLQ+LD+NziNkwpz+YDGFkj21MTyUQJLRIxbVJitIkFshGOrOqD0lpaXo=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BLAPR10MB5268.namprd10.prod.outlook.com (2603:10b6:208:307::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 25 Aug
 2023 17:56:25 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6699.032; Fri, 25 Aug 2023
 17:56:25 +0000
Message-ID: <7f0c0fc8-2848-06a3-f271-6cbecbd87f4b@oracle.com>
Date: Fri, 25 Aug 2023 13:56:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 00/10] fix migration of suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
 <ZN5lrPF9bY4acpvM@x1n> <f26b44e5-ef9a-60fc-1172-559ff5ea70de@oracle.com>
 <964c8871-174d-b94d-eb1c-a84f0882a351@oracle.com> <ZOjDmf/o77puC+OW@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZOjDmf/o77puC+OW@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45)
 To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BLAPR10MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c54914-5d2e-481e-1ca4-08dba59499a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwJShI/MoOuS8OMVHREYZ+GlHfrJx5j8it/32VRf01h7R93hevBB4/5m31UjAg2SX1jllokeolo9tDAk/WyFwrq0LP26CtnsS6s9XgraXMbUzFnXrfnbfMpzkbgIovpWPyCPMuek26Xx7s4C8QvANeECllMedqb08/PFhI0ZUVJrfM8UqWYL5oSh2GuOw+EyBx94O/QU98HOSHiY9B7tK3iow0V/A1o8azWXVSyH/ulNS5ReXjgZK2rCjWoscvSVu01cIpY8GftNHIFuogeTVP2/M0TtRkLam+ue8gCh38GreI4CEQMqUNpmwGE2gsyFU+QwuoS2vmayirWZMWPVHZbvjKTcU8/DE3ZKjiWxjSO4RZovyMQVTZCRXAZvBOt+pJP3BqltGK2LTfiFWr3YenfTzj8GJGFvTelTsCjs3sBt9BeIZ/iijk6uZ/umjJzndfJmTDAhUhWpAHRNb4iLYMaprayxAJvfKgM/0ftLJ+5QaANvgtDAd7loZnh/u22ZBlknQJE6JiMMQABAArMqAn2E8WzAakW41HvZNjZPe1YE7oVityRrULksr7EXujswfWbbapOBdteFDsBj6VjMZOULtay9kTsWZbV9AAhTC5kWJ0hQ+tu3UQEDW4S2EnutDhUC89N10wkqGUw2WWn/YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(186009)(1800799009)(451199024)(6506007)(36916002)(53546011)(6486002)(6512007)(83380400001)(31696002)(86362001)(38100700002)(36756003)(26005)(316002)(2616005)(2906002)(66946007)(6916009)(54906003)(66556008)(66476007)(41300700001)(15650500001)(31686004)(8936002)(4326008)(8676002)(5660300002)(44832011)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGVuNDlGc2pLby9NYWNtdkU0UWowOFdaWlNJMVQ3cThDVXZWVmMyWmJDV0lM?=
 =?utf-8?B?ejVQaUwySUtWY3FrRGFNQ1ZuNTRPTWRGVVZzNStKM1lCRDA0ZDdiNmlzKzZn?=
 =?utf-8?B?QjUxdDFMMm9USy9lUkMvQkVtYXQrWkdJNVFpckxlUEtkQlJvODVidGF6cnd2?=
 =?utf-8?B?cEYycnd2SE1zR3JlWi9kckZTbVJLY1duVmt6WERkWWhNcXN2Vkg3V1BRdGdH?=
 =?utf-8?B?Z01qdURYekJ4SjkveXE1NGJ6VWpURkh1YlFoWkJLMEs4UDBzd3lmUm5qN21C?=
 =?utf-8?B?NUwwRVZZVllmRHdRbnpBcW83dWFoREJISHJPYVZhRTRiZVVidVNMZm5YMnly?=
 =?utf-8?B?alhlTjIyVm5nY3dwV0JVdC9wVG4wM1J1TWNtSW9XSVJkdEdnNVcvK2dkNkl5?=
 =?utf-8?B?S1gvZ3RjY3BUcktnRHNOR3Q0UFh3N2tCU2dMZFA3V2pnRTN4WU16NDdNcUZn?=
 =?utf-8?B?b3lnTVZWR2N3ZTlicU5CRGt4b2d0MjNKVmtTQVZqcTFUSWdnTUFtbEFXRGZu?=
 =?utf-8?B?RmZ4S3J0dDJlMTFMcXJNWlkrazlEa0xwZDl2Z3lzbTIvb2kvMHZrUnhhMENi?=
 =?utf-8?B?V25Cby85ZTFFd3BXVDc4eFBHWnpxUUhKa1RudG1IY24xWVZ5TzloVzF0SHNV?=
 =?utf-8?B?emZNQWNpOExzaWN1VlRtc3NsTCt4ZmIxK256c3YvaDBabnFrc3FOcytsMmdC?=
 =?utf-8?B?V0czUm44UlE4NGJ2K3NTVTB1cXBuZVg0VEdDR0krR2tsUC9zMERXYXQ4UUhZ?=
 =?utf-8?B?cDc1Z1lzZW51UUZWdG9tQ0tHNVlVbXkwRDlyRnpQWlRNcloyOHZYQUU4Z2JX?=
 =?utf-8?B?TXIrbE00NjllbzBWdlZFN3cvVDVQLzhSU0tmWnZ5bXB1RWJTZnU4WWF0NndY?=
 =?utf-8?B?dkVpaktpZFNvNXlzckRYMzc0bk5YNFVjSGxvOUpaR0FEMGVjVzYrWjZueG9X?=
 =?utf-8?B?eDZ0bjhvcFM3S1ZuL0xFUjZCdjdRTndDRStPbS9TNml2V1J1TS96QWdEN1gy?=
 =?utf-8?B?eWtUSHhwNXBCWlZSM0JVZTUvYkhwOGVaRW5BUEgwRVBYOFpXUE1tMlI5ZHNK?=
 =?utf-8?B?V0o2UEU2TzBsa2hOU01USDVLMUJRRWdzWEx5QUJPUzJaYnRnekVMbk9LSTVz?=
 =?utf-8?B?RW12TVBiZEN5Z3l2QmNIWTVBa0NhRFNVaWQ4WHl5a1FHcG5mOVZ3UVI3VGNz?=
 =?utf-8?B?b2grZ3hTMFhxWFYvb01YMGg1TmZmRlh1ays0VFhOUEgzaUxWRGx2ZnpXdzBm?=
 =?utf-8?B?OVgxVmdwUGtPRjVENFBNNE85SW51SGRMVTdXNFlBRjd0SGFOS25aejM2T1JZ?=
 =?utf-8?B?RHNTbTJXTEZUdnNpYU9ObjMzMkRFcGl6VjVlRmNkUm1kdnhqUHJxTWNVMG5W?=
 =?utf-8?B?d01XNFRzTTJZb2lONlg3bWltQkRlVVZtSXBCeXc2cnVlM0psL2RNMU5kL0N4?=
 =?utf-8?B?SXhJZUxpeWtxZ1dJWnlxR0dXVGhMUGxCU1BWNTl6Y0YyOVIvUlMvUjhpYjZP?=
 =?utf-8?B?WXdRNFBSVWZiclV5TFZsUENzbHl3RmpPazgwelhSNkJiaGZ6d01qYlFOZDU1?=
 =?utf-8?B?Ym9ycEd3cW1Bc0VVSUpWYzh0VVg4KytjRi9NM0FKY3p6ZG1QYkdPc2kycFhQ?=
 =?utf-8?B?aTlaazRUZ0FaN2ZNUGlRWGRGY01JdENPRTZKdlBZQVRRSkNrd3ZFaHVLUWps?=
 =?utf-8?B?WUNBK1Bsb0JtN1NmT0dBNUgwcTk4K3NESzQ5TnB1Z1g5c2o3c1gzcHg5YWU0?=
 =?utf-8?B?UXAxdUpGQ3FzYURVa2JTMnNEVW5Fb2YwcmJHTTdXdXh0QTluU0IzcHpVVVV2?=
 =?utf-8?B?TjNrWXV1LzRROEx3NkZ6Yy9xUVF3NEJWU2dTNXlhMG5RbmM5bWZEL3BiY3Y1?=
 =?utf-8?B?OTA5dmZuT1hRTCt2UEp4RnFYRWtZSTN4RzJFV2pNWndEMEVnR3UxcFBkT1lR?=
 =?utf-8?B?UGpHQlRESTgvUVRuWTFlMktKbmwzNVB4anVpcGFuVHZUc0ZnMW1hcFFuTk1a?=
 =?utf-8?B?UDkvSTVWTEppc0VUaVdEbzkrY3dkOEk5bU5IYzJtSHl4ZFZLcHZ1YTdDSElk?=
 =?utf-8?B?dkswUll4dXRTKzlxZ2MydUNDY3FwRDd3eThONHBJeFVSVmZ4Yk5ySHAxS3Bv?=
 =?utf-8?B?eHAxNkNKUEl1M2lQK09UaWxydTJJU3VWckl4RXJZV05wcVdxRGl4dEZuTmta?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t9aeFKBA9qOdMLNwVf+olSkoQDjsv7MDfVlhZs7GN2omYjqPm/TyR6Dw0OUTDRjQfxoufAzUZdoTfg93y958E7zKXLejBKEDM5f+MQqZss/7HvW1wQ+9phcLXG0WQ11mE758hKHEpx/uOwslDnq2JAd/Pw5kFG2MSIzuhGIaFM9MBHJMtcgudiP6/hyDdxScgzEfMLddH1EJl7NpmnbnZlatn9SG/rW7MCKINti4A3RdA7fwMvNF+eP0HOeW/Wwy94+8Xj+b2uvFibgQE6I4DcBUzQDwiQa0VwxA/exnIT6xhm8dNvpRKkwsY6ZIXKXnF5oLu0RRTuOO1/OmZNWUQeIyjjpjKDZ6gbHLg6i27Rp0R2Af4zviTT1kXCdNmtIvk6FjwCVoENtgGX1jcBd1vjR8fW32pzA4PoCfGzkX4JMeMpcXiuCiNi8ZF7/AgVCAg216lFSr++QRQOSUq+W1AcE2ieh+8v0UrxkEEB2DFk+oKIxtW+VMEVGDOP5bcz2IE7ow4DHu7qyRa7BaxaBdTpNMAGuZOnbU58cCNy0e0A8JNhGSJnaR971zrR7QrcZ3CLNhhRoHNSY2bFMovXdPQSELLIF4YiGRrtwwxYpUcWAicSuZ22KmJv5wpPz4RaP6Uf3hQ14haObFcbYGMfZWWIS1aZlHnF1RW7/aItNMd7C+E1iUj1AOyDihlm5Nsj70U+csO/C11Ciw7xbE0LzeFu4TMnjD0eogcMymDIkkvVDpQsqQErZpKKzmDnF3kYt/mt/BtHOhRzpwQDwnwFurqQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c54914-5d2e-481e-1ca4-08dba59499a1
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 17:56:25.6102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XivL0nAOhLRCcCsn7PxAKM8VNU0hpA1icsLuAxhxnhNgl45/zss13oIL5YZqP5xvV24Ry3tgFfDYBE9jDF+XYIal7gCaI3yZ+u8fXjl4+Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_16,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250161
X-Proofpoint-GUID: iMacrVjzNrKtTKC39wp6yFQIHn6FeojV
X-Proofpoint-ORIG-GUID: iMacrVjzNrKtTKC39wp6yFQIHn6FeojV
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/25/2023 11:07 AM, Peter Xu wrote:
> On Fri, Aug 25, 2023 at 09:28:28AM -0400, Steven Sistare wrote:
>> On 8/24/2023 5:09 PM, Steven Sistare wrote:
>>> On 8/17/2023 2:23 PM, Peter Xu wrote:
>>>> On Mon, Aug 14, 2023 at 11:54:26AM -0700, Steve Sistare wrote:
>>>>> Migration of a guest in the suspended runstate is broken.  The incoming
>>>>> migration code automatically tries to wake the guest, which is wrong;
>>>>> the guest should end migration in the same runstate it started.  Further,
>>>>> for a restored snapshot, the automatic wakeup fails.  The runstate is
>>>>> RUNNING, but the guest is not.  See the commit messages for the details.
>>>>
>>>> Hi Steve,
>>>>
>>>> I drafted two small patches to show what I meant, on top of this series.
>>>> Before applying these two, one needs to revert patch 1 in this series.
>>>>
>>>> After applied, it should also pass all three new suspend tests.  We can
>>>> continue the discussion here based on the patches.
>>>
>>> Your 2 patches look good.  I suggest we keep patch 1, and I squash patch 2
>>> into the other patches.
> 
> Yes.  Feel free to reorganize / modify /.. the changes in whatever way you
> prefer in the final patchset.
> 
>>>
>>> There is one more fix needed: on the sending side, if the state is suspended,
>>> then ticks must be disabled so the tick globals are updated before they are
>>> written to vmstate.  Otherwise, tick starts at 0 in the receiver when
>>> cpu_enable_ticks is called.
>>>
>>> -------------------------------------------
>>> diff --git a/migration/migration.c b/migration/migration.c
>> [...]
>>> -------------------------------------------
>>
>> This diff is just a rough draft.  I need to resume ticks if the migration
>> fails or is cancelled, and I am trying to push the logic into vm_stop,
>> vm_stop_force_state, and vm_start, and/or vm_prepare_start.
> 
> Yes this sounds better than hard code things into migration codes, thanks.
> 
> Maybe at least all the migration related code paths should always use
> vm_stop_force_state() (e.g. save_snapshot)?
> 
> At the meantime, AFAIU we should allow runstate_is_running() to return true
> even for suspended, matching current usages of vm_start() / vm_stop().  But
> again that can have risk of breaking existing users.
> 
> I bet you may have a better grasp of what it should look like to solve the
> current "migrate suspended VM" problem at the minimum but hopefully still
> in a clean way, so I assume I'll just wait and see.

I found a better way.
Rather than disabling ticks, I added a pre_save handler to capture and save
the correct timer state even if the timer is running, using the logic from
cpr_disable_ticks. No changes needed in the migration code:

------------------------------------
diff --git a/softmmu/cpu-timers.c b/softmmu/cpu-timers.c
index 117408c..d5af317 100644
--- a/softmmu/cpu-timers.c
+++ b/softmmu/cpu-timers.c
@@ -157,6 +157,36 @@ static bool icount_shift_state_needed(void *opaque)
     return icount_enabled() == 2;
 }

+static int cpu_pre_save_ticks(void *opaque)
+{
+    TimersState *t = &timers_state;
+    TimersState *snap = opaque;
+
+    seqlock_write_lock(&t->vm_clock_seqlock, &t->vm_clock_lock);
+
+    if (t->cpu_ticks_enabled) {
+        snap->cpu_ticks_offset = t->cpu_ticks_offset + cpu_get_host_ticks();
+        snap->cpu_clock_offset = cpu_get_clock_locked();
+    } else {
+        snap->cpu_ticks_offset = t->cpu_ticks_offset;
+        snap->cpu_clock_offset = t->cpu_clock_offset;
+    }
+    seqlock_write_unlock(&t->vm_clock_seqlock, &t->vm_clock_lock);
+    return 0;
+}
+
+static int cpu_post_load_ticks(void *opaque, int version_id)
+{
+    TimersState *t = &timers_state;
+    TimersState *snap = opaque;
+
+    seqlock_write_lock(&t->vm_clock_seqlock, &t->vm_clock_lock);
+    t->cpu_ticks_offset = snap->cpu_ticks_offset;
+    t->cpu_clock_offset = snap->cpu_clock_offset;
+    seqlock_write_unlock(&t->vm_clock_seqlock, &t->vm_clock_lock);
+    return 0;
+}
+
 /*
  * Subsection for warp timer migration is optional, because may not be created
  */
@@ -221,6 +251,8 @@ static const VMStateDescription vmstate_timers = {
     .name = "timer",
     .version_id = 2,
     .minimum_version_id = 1,
+    .pre_save = cpu_pre_save_ticks,
+    .post_load = cpu_post_load_ticks,
     .fields = (VMStateField[]) {
         VMSTATE_INT64(cpu_ticks_offset, TimersState),
         VMSTATE_UNUSED(8),
@@ -269,9 +301,11 @@ TimersState timers_state;
 /* initialize timers state and the cpu throttle for convenience */
 void cpu_timers_init(void)
 {
+    static TimersState timers_snapshot;
+
     seqlock_init(&timers_state.vm_clock_seqlock);
     qemu_spin_init(&timers_state.vm_clock_lock);
-    vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
+    vmstate_register(NULL, 0, &vmstate_timers, &timers_snapshot);

     cpu_throttle_init();
 }
------------------------------------

- Steve

