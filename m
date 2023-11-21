Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A37F3839
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 22:22:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5YBb-0001JK-8L; Tue, 21 Nov 2023 16:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r5YBZ-0001J6-1u
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 16:21:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r5YBX-0000c3-44
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 16:21:32 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALKx0t0026141; Tue, 21 Nov 2023 21:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+FEa0wL/FEvicmLpVZ2Nk9w4bNcBRJjYZ7vpo34azpE=;
 b=ZH8glT4xsuWn4tDlTgKDYer4h4/0rac1aUiZo6xttiAH8pwFk9RC5HQcNNXEzJe+IX5j
 O5gDjQ473DjMb8pIrhtPsoRrcBLa2WxBG6qYCuzx/RdFuNvP1j/Dp/axltJuzEfgoLqn
 kq3V0+vZ7f7VXaz8MH4NLpmMpzHwqY40RvdHyT2VAcNsoSHk7tsXd/0oUv6PfFI2qNEf
 rb/b2hme0VchhY1HNBBHjVx1aTLC0oEuo2DSTuLosP968SuBvOSrO8g3804BnQgeEc1Y
 lwM06OEajB1IxlG0BMs/caQSoAQs6p/q5RucqtRJ0li6gg2WsPcXYNcGGqfDm1PJCPd6 mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem24x4y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 21:21:27 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ALK5GeE022554; Tue, 21 Nov 2023 21:21:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uekq7es0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 21:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbvdzGpX9WTTn2wb7Xv5a0dnoQQQcDGwVjH74CKEbjbb0V+1ueEvow3Cmbtv8F0vB/ONBrMMOr3AmbIKJRuMNg4h2YaYF9tw1D9LYPaLmb5fBvHcwpQIhsmZwWwESD4ydKxtCU/8/G0ONmUKDsH0HWscPBt31E12VN3F+CDhO2cxCZvqrZ3yKdg14WfgQ+54AwX5K5S18IkiDKV5TKYTjGyAGhwAIkE6dfnxHu6vJjk2wJB49ArMPr0+W+mftmQPjgwMsvFWTEkFoj69TiaJgYFsUBgH14u0Q4h8lSo4nrN+9pIXDN2mW59HiMyHI9PnVuc0bL2LGJmLH8WjfjTMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FEa0wL/FEvicmLpVZ2Nk9w4bNcBRJjYZ7vpo34azpE=;
 b=U+8pGP7nhxsYWJFts1LeeJ0FeZjUtA45nNkbXC/MhvB4RBZO03wyDZ1ihV3MGK7XztxWXmFm8n6hSw+5AEXCe4Nni6mPB8q9wgg3ZRu40AIANhifn21xfXo8z0PlQqwHsDZ7+pob0XLuzARDLhHyU5Xo2vdyoVX4Dh8URQhHF/08jgXWJ2CICjGtr/G9Mcp/oda1Geeno7EgBbCfmitkdxWyQ2l4Dw/GQzqoFlKzfx2O4xaEGOwia+8wMEmHoNbDizIRfoactMycVqbF+uBBC45N5SVeZ/zyetGQqjio5isV2ZGJH2b8atnSZZwC7mwIMtQQZaxr6rn5Ht7LzKNu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FEa0wL/FEvicmLpVZ2Nk9w4bNcBRJjYZ7vpo34azpE=;
 b=Cu3NmMZ6nwkx4mGIqoMNaKFMO+0ahrf4EHXKrtLeoIzUjujlVrhVMlnWL6R7P49/ctMVxbKZqbI34Kew8MYSmtRAsK6+qageEIgQFgdNOo8OjrpoP2Z3Zb800aNcpc2FJKM4L9sNj8NNUceB6ePLigSc6rvNwoBdYER9JD0tPyg=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH0PR10MB5340.namprd10.prod.outlook.com (2603:10b6:610:c1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 21:21:24 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 21:21:24 +0000
Message-ID: <54f3f649-5b77-4b6c-92c9-495656031984@oracle.com>
Date: Tue, 21 Nov 2023 16:21:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
 <ZVu6ohk8_8xzyL-x@x1n> <e32d4434-c877-4f98-ac76-da8fa292395c@oracle.com>
 <ZVvTUuNYzGgFcg4m@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZVvTUuNYzGgFcg4m@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH0PR10MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc41843-ef08-489b-2f4e-08dbead7d068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOd8HkWKzAJ6MbSkUIo0f4JBJvsRunLK55e+llDW3FjSc55KCmvSXfAnDO0dYMMjBVG6j4ao9UZuyMevO3famFgBIP0CTHOtHSCzQuXeSML0JmBLkFAYUnAdai18+Xf9aiUtLXtF4VZdkms0iPF9Np+IUb09ibqEtJo9pUPrnQ11VFJqKPzf9r0FnvoIOlsOig4e8Nfk7hvI5u5b13HkQuSAXfW0NJr68B2SnuahC3iHvNb/u1WAm8mlLwEqNrykeiuX03T8yZ71TIMI+4B41vMmoLeG/5cJJGhFXvKTHvWn1C37TcBc1mCF8f6BN1C0YODWPzUlUHCmDfwY3qr8ggC6XDFEArhdCCIPhWHJB5yCR3qXmwQVFwpGwqL+FpfF99dg8SFm6AlCjlja57NNicS7k3odEU72dVemT53Joeocs9XxN7IFPSqsj4KFq8uTUEqg4zuvDBySDaK96bJqxTHvEJX4zIy5ookQZ1pZ+qyxbrOJaRxB7d9q2YUfhTwoCesbTrVu3IPSszYG9iKx+zOav/6nhLnoPKqgNgwHUWB47Z3d/sXOFD+g7Dl7TnpRHrPRNEs1XPtAt3mC6fvwtgsBemy52rPgxP+3xcViV1fmQ2WSF/ixskRc+7OviWG41qAFlMCckR8lWckBHKIRVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66556008)(66476007)(66946007)(54906003)(6916009)(316002)(53546011)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(478600001)(6486002)(83380400001)(36916002)(31696002)(38100700002)(86362001)(5660300002)(44832011)(15650500001)(31686004)(2906002)(41300700001)(8676002)(8936002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWpqbjhFaFFxNURwdGo3SjZyM1JsRGNlT2Rpbnh6WHFIVnZyMzlCL29uaGoy?=
 =?utf-8?B?UUlkUmVLWGQ0aUM5bE55bGJHYUVZODdoSkxhKzgrak5TNTdZZStCQ3BRdVRa?=
 =?utf-8?B?Qkk3ZlJoYWxoUnhwWUdCU0RZc0gxR0E2MWc2SCtsdTNEa3hyYkdxZkw5ODRr?=
 =?utf-8?B?L3Z4MXNJbGhJZnoxUXlNWTMrMXNITkNjNWQzc0NVTU52QS93aVBYS2NwMWxV?=
 =?utf-8?B?RWlEZmZZNXFjUjlURDIzSHJLazFZUHB4TTNON1JmcFZzNVM3NUU1YU14RzJo?=
 =?utf-8?B?NzNWZTR6NzRvSlo5VXd0WUpiV21BbW45STdvUXI4eEFWOHBUV0VzWExpR2c2?=
 =?utf-8?B?bEhreUxyQkMzSzI2RG1qc2h4Q3pwTGUrK3RrMmFTTWtOZ1FwaFEvSWxKZkFk?=
 =?utf-8?B?UjFxNVJxVXVEUGN4ZXNnRTRUS1N6MFJvdnIzTW0ySEFyK0EyRVdkYUNRUzFY?=
 =?utf-8?B?a1BDc0Z3cFBIUHlkM2Y5ZXZzTkYrZXFvU0FGZzYvcXVxbkx1OUgxeEdPNTFx?=
 =?utf-8?B?cWJaMHlUekFxclAxVm5RNzZZY0I4NktyN2EwaVhuRXNwWWRId0haaWdNb1Bl?=
 =?utf-8?B?aFEra0Vnanh6ZS9GbXM0bWFyMHZuYVpSMkpsZ0tjN2FJKy93UStoRkJ6V1Zo?=
 =?utf-8?B?WFNQOEZFVXdsQTFiUFFNRFR2eG9wN2NFdlE0d2t6NWJKbFhUMmtpN01HM3Qy?=
 =?utf-8?B?SEJTcDJucC9vZFdBMS9IREZOZnB2aVlnaU5xNDJLbndaV3FZT3g5ZWw2RlRQ?=
 =?utf-8?B?WmI3SzA1aXRyYXA1eHcyQjZqWEppQVMvNnJsQWdTZnFlVWxiZitUMEJ4d28v?=
 =?utf-8?B?a3BmTWQ4djRmVXBsNVNMSWgwbDlLRWZaTHQ0VGloZW4rWFdqVVR0YkRJTm4z?=
 =?utf-8?B?NE1FL2JhdUUyYzl5SlZKd3Ridlc2elR5eFJsZGczc1N0alpPemI4ZU5peStq?=
 =?utf-8?B?MExYQzNWWHEzTnFzYjlCL3MrTTVuMlV5VUJVWVoyeVBWZTFwL3Y4SXZWWTUr?=
 =?utf-8?B?SnhpNUFBNml5VzdQVXdoUGczeHQrZlo4SE51d09XZlNmdzRMQnNRN1J6a0py?=
 =?utf-8?B?VFE5VmJQRUt0VThkTll6S1NyVVJDYWM3ZGhRc09qUTFET3FnV0ZQenBlUXpn?=
 =?utf-8?B?MTRMUmlpWVFjaGRITWtsRlRWb3E2b0ZCVmZ4QUxVb1JqQ2xJU0hrbHZkQ2kz?=
 =?utf-8?B?NFhQWGhkdEJPc2I1Y0ZJT3NwM01rNlp2cDBiL2N4VWk2YTBHbndLL2JxL2JK?=
 =?utf-8?B?ZTVzbTVCUjJ1U0VTeHVKdElLajZmdll2YStTckhwZXhCQ2RBWWg5eWc3U2sz?=
 =?utf-8?B?eHZRbEJZcTM4ZHZkQWw4S2pYNmR5QzEwUFJqVFRRN2cyblloTHJwRlpML0xw?=
 =?utf-8?B?Zjh6SmFmREpFaU5TN3JQQUFkSUpnTkxNcDRHWENod0UyOWxFd1VUdDczU0NS?=
 =?utf-8?B?UmZHR2tFNUNKTSs4NVhBTGNHY1I1T01SUjY2K25RMmZwaEFEYXJuOU1DTys2?=
 =?utf-8?B?MERmZWNkblp0ZFV3eFV4SXE0OGdsS1BYRktKQmZvdEc3UmN1SWxFVXNiaXAw?=
 =?utf-8?B?VzdyaDl1U3kxS0J0OTJhK1lWdHFWZUpPZTZuTW9oRy96RWQ4S1RjRlR0TVFP?=
 =?utf-8?B?cVdmVDRnZFVYY2YrS0NORUlrRm9HSWFmZnNEYld5d3VWOW5acmIyZTJubVZi?=
 =?utf-8?B?VWIwZ01YWmd4cTZzc1c5S01LczRzNEcrdzh0Sk80aG1JTkQ4TGxBT2ZnUFZa?=
 =?utf-8?B?TW84QTNQWGZmajBDajRyUnJkVEpiaUk5Q0x4TlhhanpCL0VWOTZRdExqSXNG?=
 =?utf-8?B?RmJLT2UwRGJFMjMzOSt1VHFHdHJnV0htb1Q5THlzOGRZSnRyWmtiM2F4YVd0?=
 =?utf-8?B?YmtmdFhMNjlLYkJFSmZ4L3RzVlphOE1sTzJOM2tsaUUza0p5NlZWN2crczFQ?=
 =?utf-8?B?NHdSQUFNU1BZS1NXVXZSOVovQkE3aWRXdzRtV0RhOXByNHNwNVVkNDhxUTZ4?=
 =?utf-8?B?NHBqTFVldHVlTjNBa0QzMlpyUFhpQUJJWXRaaElqSzhQR2NiMXZnQUxCZzVL?=
 =?utf-8?B?WWE3TlZNNWxUNUFqelNGWE05UmpkOWY1SnBjWTVmVGUzVkZlUEJsczlGKzRl?=
 =?utf-8?B?VTJWdW02SGlWMkIwUHVneUFSVXUreEptQ29ob3lnbzFOeTNIWEZUUThWU080?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6I+6Xl6n+N01lEm2eMubP86P9nzZRwHrmCK8bmcy1+hnipgVP0KkEv7SxxBl0i6tVsPWV42610rOh8BB9PJjTvTbtmfk/DFHYj14cKHIvo98AMYso6t70jk/h+iwtc+1TqTlmp6pQOKPNsYmqfAw5swRhFpw4nWt7iJT5tXncT6ns0ckYI4aUhwXTJjFK11Vebj9qaHzYdCqdQiZQhXp7/fhkWEXPHnUgXEyTN8jLYOjqY1/PhLCL86Fwoog/qGUgD+uHvAZfjTQMVTixEvXhcxSPskcXkc7R43Q8saQXTyWmCF/E2Y5+YheR7ZbmKH+wAkJpRf6swZwozNlSmbMrr4FaERSup/6oW5Ze2fliGQ+se2G0eeuUpqRC4wQZ4R1w3nKS0ovTTwMQLfX5T0hhBef/fyJmKrGNNUHJdgpnzV/Tcks6VGa8OBDINTRpPh2yvat14xyqC81ov5ikFnVes/mNczG7nYaXHXKeXmZx6CZ3mQ9gjeqi8Bj0bQdnndq3P3dVxJ1CG3f12a+cDRtHR9zQ50tv/WQPrIqH81p+7iPugrU8HLJJRyFcOYPelTQcLrcrXR3yCcxQiY3fZ3S0zHpI3VMWlkNU8AWKiqmDg9RV1PNNIlXGyZaN6MNNTS5ISAMV8s8EvTDpYKoeoUPUHZHAk5NtE4D1Y/a+oRXygsyaBjqH/erZ+QB1kNUeAEKBEWDJrU0MG4S4+D5aAvfub9Ox2Lyzjn+H4cMPjk2+03HZp2bmAJi+1hor7kbY1zBi91ZBlEmkplTkt7ZauFIdbzSmWnJvQ97YW0rMr6QiO4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc41843-ef08-489b-2f4e-08dbead7d068
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 21:21:23.9731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VS2NesoL5nsgsAilv3E/vvGgyk5Ve3bZKhr2YFOQnrYwxR75T8mkwyqiP9vQtFhutSM2z/U7qcAK+ed+UZ9/TVgkpVX4VVWfIcsAjaZPGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_11,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210166
X-Proofpoint-GUID: kGR3EFkloD4KYpxa4eBHD5UhYnGpgIbd
X-Proofpoint-ORIG-GUID: kGR3EFkloD4KYpxa4eBHD5UhYnGpgIbd
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

On 11/20/2023 4:44 PM, Peter Xu wrote:
> On Mon, Nov 20, 2023 at 03:55:54PM -0500, Steven Sistare wrote:
>> If we drop force, then all calls to vm_stop will completely stop the
>> suspended state, eg an hmp "stop" command. This causes two problems.
>> First, that is a change in user-visible behavior for something that
>> currently works,
> 
> IMHO it depends on what should be the correct behavior.  IOW, when VM is in
> SUSPENDED state and then the user sends "stop" QMP command, what should we
> expect?
> 
> My understanding is we should expect to fully stop the VM, including the
> ticks, for example.  Keeping the ticks running even after QMP "stop"
> doesn't sound right, isn't it?

I agree, but others may not, and this decision would require approval from 
maintainers in other areas, including upper layers such as libvirt that are
aware of the suspended state.  It is a user-visible change, and may require 
a new libvirt release.

>> vs the migration code where we are fixing brokenness.
> 
> This is not a migration-only bug if above holds, IMO.
> 
>> Second, it does not quite work, because the state becomes
>> RUN_STATE_PAUSED, so the suspended state is forgotten, and the hmp "cont"
>> will try to set the running state.  I could fix that by introducing a new
>> state RUN_STATE_SUSPENDED_STOPPED, but again it is a user-visible change
>> in existing behavior.  (I even implemented that while developing, then I
>> realized it was not needed to fix the migration bugs.)
> 
> Good point.
> 
> Now with above comments, what's your thoughts on whether we should change
> the user behavior?  My answer is still a yes.
> 
> Maybe SUSPENDED should not be a RunState at all? SUSPENDED is guest visible
> behavior, while something like QMP "stop" is not guest visible.  Maybe we
> should remember it separately?
>
> It means qemu_system_suspend() could remember that in a separate field (as
> part of guest state), then when wakeup we should conditionally go back
> with/without vcpus running depending on the new "suspended" state.

Regardless of how we remember it, the status command must still expose the 
suspended state to the user.  The user must be able to see that a guest is 
suspended, and decide when to issue a wakeup command.

If we change the stop command to completely stop a suspended vm, then we must
allow the user to query whether a vm is suspended-running or suspended-stopped,
because the command they must issue to resume is different: wakeup for the
former, and cont for the latter.

This change is visible to libvirt.  Adding it will delay this entire patch
series, and is not necessary for fixing the migration bug.  There is no
downside to drawing the line here for this series, and possibly changing stop
semantics in the future.

- Steve

