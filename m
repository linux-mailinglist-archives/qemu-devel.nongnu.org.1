Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0F27BC910
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 18:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpA7L-0001mY-Pf; Sat, 07 Oct 2023 12:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qpA7I-0001mO-U6
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 12:25:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qpA7F-00060W-Qe
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 12:25:24 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 397BfbZt027121; Sat, 7 Oct 2023 09:25:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=XMUFPoXHu1HR
 fTaUq/zsyF1rOVAwJ2fQ8GLT/bwy/IM=; b=FBL4SdkJWVxyzt+AnZCqbTjCdeXU
 WIDe6G72ySjDfQj7xNMJ5an870EKvfNNXOOjGj6vtkiDMJvrvBQzINRUgSiA/cbw
 pxbMMINYxqtTzB41mx2Y9uOme7NyfM5HTSYG0RgqCHPyiJ90QVqEX0LNDo4EjKnh
 yYu25Gjm5sHwVqIK3iBaGGs3PxVsRNKjO8In1xuN01cOduY04lKbB8a8QdAnkhDC
 jyxK1qHXICLNVHSARooG/6IrrN5kjoO1lu787fqz4D+7YUq0WxRaE6UjWbISCJMx
 olk4vPrHE2cikx/s69RzJ/O7Rf+tRFUMrRybojp4oK6miMMeF+5mcs+bPA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tk6nc8a28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Oct 2023 09:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUaKeEptq+uX1KMlGaGqZ1Dn45dktIVTitlfDCNkkbVtuCfLbpth5rmnRg9yF18r+6BdkfJqCC08kTPNnfHXNtMc+qWMH37cjFepb7k+YcUcus4ApMyz8sQ2KZfptB1SVBk1hkNZ92akBi2i9fs0H/m+7gQpjEQT9FqcOg4MCSdhgmgl9orXnyXTXYX432DLW4lxFSYpw+ikENE5UwsOVjy9P2S//NG1XXsC1wUI6nT9CJ6uNFaDGmGA6ZVICUabkGM+ZpiZ/wxgUom/1KG4dP62M6i7i31r7b+/2w6Ji3LsMFoMayCPdkpXPz8ryUCiOxcbnyEp/n03kL9gfsYlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMUFPoXHu1HRfTaUq/zsyF1rOVAwJ2fQ8GLT/bwy/IM=;
 b=lxF1qea6MPa6aD0MuKAhvRsshOsJmBLCvMLsRHpMq7DTWUsLMPKKblPhQ/rCqQfNFd6oYPfusCOIJssYI6x4ulsTF2KMU0DZdxpjuD14zViil9sxKSmRiEXq2QoYdFD6DEHm7Gkdtz1n53SlojPaq7sQqOc2CXYRqMxAmFnN9QvNDjVhzTg2Rfn3RSukl+QWaoH7B/gUkiQzPbecCe4paAr+IMg0vFsMFb3DqfRM0z8iXVEOT2NhQ91NdIB/kW4P1YARNGnmcua26OeXh4fweJOBiqCsymkZLJhlWwcaMiqgDqje7gA4zBPCdUIR1HjTe5614XBpaxVMFzNoDiGiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMUFPoXHu1HRfTaUq/zsyF1rOVAwJ2fQ8GLT/bwy/IM=;
 b=RsVI5zcR30/ut1cYR3HpPlF9Vrpj4tA3JmZFX0l9+Mgcsf3Mh84LZSh1lNt5gGmHlxN/aulozRX8MsywjPgE0rtDz2SChFfdwXNIU5CThBAacczOrC92b/qL2CkzoqR0L2jdKBaO2TSGpCEiVmiwa8L7VOCA82U4uLY0HS+/xeoAH9EexT+uVKg8iYTEKyN65s7dpqCABAgz7LZctdFQcf4HQtg4kBnlZ9FSHQM/zKbgNSAtGQdNMd5V5zkWu0eROTAcJaT+cEc51OVefKk62XtogqAHPSm47IasTu7RLOo1bpUtxLskJJ6ISb08t7pxfo75EqaaLDshyCCPwEgt2A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MW6PR02MB9820.namprd02.prod.outlook.com (2603:10b6:303:23c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Sat, 7 Oct
 2023 16:25:07 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.039; Sat, 7 Oct 2023
 16:25:07 +0000
Content-Type: multipart/alternative;
 boundary="------------VwEKXSly57UZ06P12CUgB7gQ"
Message-ID: <1fa0fa5d-0989-43df-8f58-881b859f3f09@nutanix.com>
Date: Sat, 7 Oct 2023 21:55:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/10] migration: Implement MigrateChannelList to qmp
 migration flow.
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-9-het.gala@nutanix.com> <87ediapg58.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87ediapg58.fsf@suse.de>
X-ClientProxiedBy: SJ0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::11) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MW6PR02MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 13353d47-43c4-4a43-ef57-08dbc751f6f2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PL0RlaHIGhGABCPwl+FDLXLzcWbbFasC+2wg02lkMvG1lin2DHbr5KhH6dkvlfwCoDD+dM0UFaB16xng6nrw6QrTxSzUVoVNLoN8w0CGDKQ2NiKlUzb2LhIJTxTgQtS3p/4bRXD1k+HJubhF2vL9UN5aKHQx7sdhBtbiCB94G+MKji6XWMLn+cEY06ltNl2G1AYB9sHWPvlW2TbJdS254TXrmPIuF2a407CiNdtYGRQMYVFg52ArzaEbx3jq8GBXyj+4slR7cGrMW9wWrqIeh3xc9PYY0E80/3B3ahfi7hwRfsgLXGrLhthjpmSjKThAtn1/oL6rWXZyvwWHg1r2C6RKSZEItjh+t0yGoj+BFGzAcdq247dEUVwIWuOuDgb2te836w2EiLMoVSCKDzxmxumhWJYCl6G1Ak3ipef8C/DnWHF/AdLaQ2sZ7HJQ89PwuH5n/A52osWcU9LYr8pqJsf1lXc26c8JdDvef5VH7QE/8v1cREhkmrweG2pcEi0mqCkInTRu8BQxWf1wZOawl88C1ZXr0RUM4pUQVleA5/Dyni9+eGPqouLy+uGNctNljUfnkCF80ORrvd7M08WHumlJ1jZtkzV1aoCs5Wcs1peUJX+YUvxLbvy+7Tzmev2lnvs2uDrgbJ/4ZZ9FSZ35TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38100700002)(31696002)(86362001)(36756003)(31686004)(2906002)(6512007)(6486002)(478600001)(30864003)(5660300002)(41300700001)(8936002)(4326008)(8676002)(53546011)(6666004)(33964004)(44832011)(83380400001)(2616005)(107886003)(6506007)(66556008)(66476007)(66946007)(316002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFpCbkRacEdQcFJSODMyYnhKVGVBWFpPTUtncDZSNGVISU15WTB0MXNFRVNv?=
 =?utf-8?B?VHk4OENHeXl6K0ZNNjQ0cnpFQ3ZXQkpHcjhHUkNDVUdiZHN5cXRKN0FQUXFp?=
 =?utf-8?B?TkpsYUZMKzJqSE9TNHJSSUdtazlFTlJnRXhpbXhyWG9VNkxHZW5XZEsyd0lv?=
 =?utf-8?B?bkwzUVpmdzJQa1VPc29LNGMvTDFVUXFMWGtIK20yT1FQcmZyMGRPbGovN25t?=
 =?utf-8?B?cWFQMHNjUDM4RHFOSXdnV21ndkNYajhBQy9vQ2g3cjRIeUhoOFBJV3Y3NC9T?=
 =?utf-8?B?VjNSOG4vVXloSHdUdFAyM2tZMk42bXJ3bVlhRElITG1Zck1NRm1USFVyVkI5?=
 =?utf-8?B?WmNvY1ZxM2JJUlV3d1d0ZHRCelhzd2xJcmpBR3VFblhaL29yTWc1c0R6MFNV?=
 =?utf-8?B?QnA4ZzhSV3FWZW5XbnN6cHd5QXBobEJSY0RYN1RYd2pwdXROTEU5QlEyVDhW?=
 =?utf-8?B?cStpdy9Id21zK0NKLzA1T0FrTUYvMnNqMVh4VlpCU0xtN2FuUGZ4ZlNtRVg4?=
 =?utf-8?B?UTRRVnpxM0s3SzNIUTlVTENZaG1qVmY0bFEzOHZuZjBLLzNKZDVaRU1BOXhj?=
 =?utf-8?B?TG9TdERieVFQTW93NWExYktqdnlwWkZmUndYSTZyOGVrK0RQT2tId2tpSDdR?=
 =?utf-8?B?b09nRXhrQXp4N1pIdSs0Y3BBb1ZlQmRLUitoMkYxMzh2K1NYS1duekJIMDda?=
 =?utf-8?B?WW10N1l2OWd4YWV1WC9uck5Lbk5CNldzREpvb05WUkZGUDVONXZReFFoM1Ir?=
 =?utf-8?B?TzhlTmxlSzhnZXhoYmFWQUttcXhpVkxsc1BXamdYZk9FVFp0UzNxSWxFVWN1?=
 =?utf-8?B?QVhRSk54VTlxU0x3QXlwanNRbU5aOGR5ZnMyUks1QmdWVXgzRlJYSDRUeEp0?=
 =?utf-8?B?d2haMUowS0NTRGFxODhxOXJvRXBGZkF5MHNjS1pqUy90QWZhZ1JmTUQvZ1h6?=
 =?utf-8?B?M3dMT0c3bC9OYStGcmNOSEpiTjNCMXB3Mmh0U0lnL1BFQ3RQU21FNi94T0tn?=
 =?utf-8?B?d3p6ZGdvMzc5dWc4alZkSzBWQzRqTm9sU01wcjU3Z3RpRGhSOXRXc0tzeGNP?=
 =?utf-8?B?MTZOTERoQ1ZJczlZS0QzUnhzbUpyQVlUcitwdUJvM2F2aGFjQzcvU2RGczVK?=
 =?utf-8?B?RS95bElNVXl6c01lbzc0ZWppaWNMUmRpSWMraE1WeVBocFZMVklzY0IvYVRp?=
 =?utf-8?B?NUF6OHhOYUpiSlZ4clJyZzJjWHZmQ3NXTmVhSEJjdHM0eFdyNHF5ZkVzdVlU?=
 =?utf-8?B?cGROeVg5d3dJOThIbkRYMzlJZ0ovODEyYngwMTd4d1BkV1dkTm9tN0J0cHVF?=
 =?utf-8?B?dzd5OFVGZGFxeWkwSHl3ekdvcW9IOXg1TFRUNkl3c0Uxa1lQV2h3ZW9wTE5Q?=
 =?utf-8?B?U05EMnBuelJjN0N1bEs0cHBlenhFZVVHUlQvdU0wbVdPcDZ1R3Z3MHRvS1lC?=
 =?utf-8?B?ZEtkSmcra1pCTU9iNy9KajBGQ29teHlNWEtVL0hYWDNoejM0Z1AzSUM5dWQw?=
 =?utf-8?B?aExQOXhjYlZEdXJlTXk4OUozM21JYys2RXpTeGdSbk52eFBONTZtTGRINVVp?=
 =?utf-8?B?SzdmdDg3ZHdJNGkvNnZtS0xJUXNma0hqekJJSXNDZ0NqSUdhNk9yT3QzWXFh?=
 =?utf-8?B?TjRNSjduRkhzNndoc2ZpTThkNzhqRVhGUUMzaVdUT3RyZVl2dGlDMGlrLzhL?=
 =?utf-8?B?K0VVNG9RbEx0ZHJLTVJaaXo5VDVudmg3b3NLb2wxSW93ajhlMWEzWjA5Smto?=
 =?utf-8?B?ZEF3eXgxZ1VxOUg1TEx3Z1pYZjZZaCtUM2tlMEdLMHcvc1I5eDZhVTFzQWVQ?=
 =?utf-8?B?MnJTSS9HZzFxUEk3NGIyMkNRM2lUS0xSeWw0Mi9mSG9tWU1wRW1yUzhLaENs?=
 =?utf-8?B?MWlZdU4veGlLUWhvMEt4RDB3YzNGWlo3NGpRMTV6dTlvT2ZxZklScFVkNHYx?=
 =?utf-8?B?WFMxb2Q3clBRWUJuTzM3Y3VYZzRHNUdjVnM2K3hPWThlSzBFUmQ0R2ZudEVt?=
 =?utf-8?B?eFFadVRGOVFnYUlXa0pGayt6L0pkT1A0Uzc3SGxTZ09ITUlwRXhxa3BvcWFN?=
 =?utf-8?B?WWw1VU9zUVFhRHg2bHJSUDlrNitnVTAvYWFuSUwva3Y3bEFzS3BPK0xYL0FL?=
 =?utf-8?Q?czIiFv9njUiS3LTR8ahb4smM2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13353d47-43c4-4a43-ef57-08dbc751f6f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 16:25:06.5542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNXu+LiokdJoy5+pmMRE4p1Xd7Bff+cqVVuhzQVnFi/cG8xsZrzLt0AcVjUAddGW7YykTMDKczCyKQctSeR1IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9820
X-Proofpoint-GUID: CJojVcgFApPG6geF9XWi7uOCPUeRCk_S
X-Proofpoint-ORIG-GUID: CJojVcgFApPG6geF9XWi7uOCPUeRCk_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------VwEKXSly57UZ06P12CUgB7gQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/2023 8:51 PM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Integrate MigrateChannelList with all transport backends
>> (socket, exec and rdma) for both src and dest migration
>> endpoints for qmp migration.
>>
>> For current series, limit the size of MigrateChannelList
>> to single element (single interface) as runtime check.
>>
>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>> ---
>>   migration/migration.c | 95 +++++++++++++++++++++++--------------------
>>   1 file changed, 52 insertions(+), 43 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 6f948988ec..3eae32e616 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -432,9 +432,10 @@ void migrate_add_address(SocketAddress *address)
>>   }
>>   
>>   static bool migrate_uri_parse(const char *uri,
>> -                              MigrationAddress **channel,
>> +                              MigrationChannel **channel,
>>                                 Error **errp)
>>   {
>> +    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
> Here val is passed out of scope so it shouldn't be g_autoptr.
I guess, same as for 'addr' we need to go with adding 
g_steal_pointer(&val) here too ?
>>       g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>>       SocketAddress *saddr = &addr->u.socket;
>>       InetSocketAddress *isock = &addr->u.rdma;
>> @@ -471,7 +472,9 @@ static bool migrate_uri_parse(const char *uri,
>>           return false;
>>       }
>>   
>> -    *channel = addr;
>> +    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
>> +    val->addr = addr;
>> +    *channel = val;
>>       return true;
>>   }
>>   
>> @@ -479,41 +482,44 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>                                             MigrationChannelList *channels,
>>                                             Error **errp)
>>   {
>> -    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
> Here we want just the pointer, no allocation, no freeing. For both
> channel and addr.
Ack, same as channel in patch 2.
>>   
>>       /*
>>        * Having preliminary checks for uri and channel
>>        */
>> -    if (has_channels) {
>> -        error_setg(errp, "'channels' argument should not be set yet.");
>> -        return;
>> -    }
>> -
>>       if (uri && has_channels) {
>>           error_setg(errp, "'uri' and 'channels' arguments are mutually "
>>                      "exclusive; exactly one of the two should be present in "
>>                      "'migrate-incoming' qmp command ");
>>           return;
>> -    }
>> -
>> -    if (!uri && !has_channels) {
>> +    } else if (channels) {
>> +        /* To verify that Migrate channel list has only item */
>> +        if (channels->next) {
>> +            error_setg(errp, "Channel list has more than one entries");
>> +            return;
>> +        }
>> +        channel = channels->value;
>> +    } else if (uri) {
>> +        /* caller uses the old URI syntax */
>> +        if (!migrate_uri_parse(uri, &channel, errp)) {
>> +            return;
>> +        }
>> +    } else {
>>           error_setg(errp, "neither 'uri' or 'channels' argument are "
>>                      "specified in 'migrate-incoming' qmp command ");
>>           return;
>>       }
>> -
>> -    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>> -        return;
>> -    }
>> +    addr = channel->addr;
>>   
>>       /* transport mechanism not suitable for migration? */
>> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
>> +    if (!migration_channels_and_transport_compatible(addr, errp)) {
>>           return;
>>       }
>>   
>>       qapi_event_send_migration(MIGRATION_STATUS_SETUP);
>> -    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>> -        SocketAddress *saddr = &channel->u.socket;
>> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>> +        SocketAddress *saddr = &addr->u.socket;
>>           if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>>               saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>>               saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
>> @@ -522,11 +528,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>               fd_start_incoming_migration(saddr->u.fd.str, errp);
>>           }
>>   #ifdef CONFIG_RDMA
>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>> -        rdma_start_incoming_migration(&channel->u.rdma, errp);
>> -#endif
>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>> -        exec_start_incoming_migration(channel->u.exec.args, errp);
>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>> +        rdma_start_incoming_migration(&addr->u.rdma, errp);
>> + #endif
>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>> +        exec_start_incoming_migration(addr->u.exec.args, errp);
>>       } else {
>>           error_setg(errp, "unknown migration protocol: %s", uri);
>>       }
>> @@ -1750,35 +1756,38 @@ void qmp_migrate(const char *uri, bool has_channels,
>>       bool resume_requested;
>>       Error *local_err = NULL;
>>       MigrationState *s = migrate_get_current();
>> -    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
> Again just the pointers.
>
> We'll have to make another pass and check whether we're missing freeing
> something. But for now let's first clear all the errors then we can look
> at the code working and do the necessary changes.
Ack.
>>   
>>       /*
>>        * Having preliminary checks for uri and channel
>>        */
>> -    if (has_channels) {
>> -        error_setg(errp, "'channels' argument should not be set yet.");
>> -        return;
>> -    }
>>    
Regards,
Het Gala
--------------VwEKXSly57UZ06P12CUgB7gQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 10/4/2023 8:51 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87ediapg58.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for qmp migration.

For current series, limit the size of MigrateChannelList
to single element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <a class="moz-txt-link-rfc2396E" href="mailto:aravind.retnakaran@nutanix.com">&lt;aravind.retnakaran@nutanix.com&gt;</a>
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Reviewed-by: Daniel P. Berrangé <a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>
---
 migration/migration.c | 95 +++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 43 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6f948988ec..3eae32e616 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -432,9 +432,10 @@ void migrate_add_address(SocketAddress *address)
 }
 
 static bool migrate_uri_parse(const char *uri,
-                              MigrationAddress **channel,
+                              MigrationChannel **channel,
                               Error **errp)
 {
+    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Here val is passed out of scope so it shouldn't be g_autoptr.</pre>
    </blockquote>
    I guess, same as for 'addr' we need to go with adding
    g_steal_pointer(&amp;val) here too ?<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87ediapg58.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
     SocketAddress *saddr = &amp;addr-&gt;u.socket;
     InetSocketAddress *isock = &amp;addr-&gt;u.rdma;
@@ -471,7 +472,9 @@ static bool migrate_uri_parse(const char *uri,
         return false;
     }
 
-    *channel = addr;
+    val-&gt;channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val-&gt;addr = addr;
+    *channel = val;
     return true;
 }
 
@@ -479,41 +482,44 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Here we want just the pointer, no allocation, no freeing. For both
channel and addr.</pre>
    </blockquote>
    Ack, same as channel in patch 2.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87ediapg58.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, &quot;'channels' argument should not be set yet.&quot;);
-        return;
-    }
-
     if (uri &amp;&amp; has_channels) {
         error_setg(errp, &quot;'uri' and 'channels' arguments are mutually &quot;
                    &quot;exclusive; exactly one of the two should be present in &quot;
                    &quot;'migrate-incoming' qmp command &quot;);
         return;
-    }
-
-    if (!uri &amp;&amp; !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels-&gt;next) {
+            error_setg(errp, &quot;Channel list has more than one entries&quot;);
+            return;
+        }
+        channel = channels-&gt;value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &amp;channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, &quot;neither 'uri' or 'channels' argument are &quot;
                    &quot;specified in 'migrate-incoming' qmp command &quot;);
         return;
     }
-
-    if (uri &amp;&amp; !migrate_uri_parse(uri, &amp;channel, errp)) {
-        return;
-    }
+    addr = channel-&gt;addr;
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (channel-&gt;transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &amp;channel-&gt;u.socket;
+    if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &amp;addr-&gt;u.socket;
         if (saddr-&gt;type == SOCKET_ADDRESS_TYPE_INET ||
             saddr-&gt;type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr-&gt;type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -522,11 +528,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             fd_start_incoming_migration(saddr-&gt;u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel-&gt;transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_incoming_migration(&amp;channel-&gt;u.rdma, errp);
-#endif
-    } else if (channel-&gt;transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_incoming_migration(channel-&gt;u.exec.args, errp);
+    } else if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&amp;addr-&gt;u.rdma, errp);
+ #endif
+    } else if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(addr-&gt;u.exec.args, errp);
     } else {
         error_setg(errp, &quot;unknown migration protocol: %s&quot;, uri);
     }
@@ -1750,35 +1756,38 @@ void qmp_migrate(const char *uri, bool has_channels,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Again just the pointers.

We'll have to make another pass and check whether we're missing freeing
something. But for now let's first clear all the errors then we can look
at the code working and do the necessary changes.
</pre>
    </blockquote>
    Ack. <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87ediapg58.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, &quot;'channels' argument should not be set yet.&quot;);
-        return;
-    }
  </pre>
      </blockquote>
    </blockquote>
    Regards,<br>
    Het Gala<span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------VwEKXSly57UZ06P12CUgB7gQ--

