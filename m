Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BAA36B0C
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Feb 2025 02:35:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj74M-0003xu-OF; Fri, 14 Feb 2025 20:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1tj3ij-00085M-Ex
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 16:59:37 -0500
Received: from mail-bn8nam04on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2408::602]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1tj3ig-0003hw-7F
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 16:59:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCZ18cN0pDJZoiueIdQduDYf686jpHEbs/gQDI7f0VbEBs+anZ2vvaKQ7dDyMV7rsd/76YCg3QogLoW0vxCh90PlkxiBtZmfZ46oLFA/d051Hc6nRQ4RKpGQcLXAwTgx+PJo+841kQ16Bkx2yjxWFnyFQZ2uFsHmzMgh7YyFXZIPw7tQFwXt7BwV2jmeUFajTvVt4CTPbvGsotHv/5+ej1FEAfRBQUI+c7ABGmd+WJhALa5vp3ziV1NFRCgFFFsPyzsVKhQf8VDPRBb258OGLso4hCvpYquT1coS2b5JmossR4ewGuHmIKd238ovsUnH61vBK8C+5HkWk3Yemz79DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRUyrMWURhZhi8dxg9Ovq22tDTN0YpHtD+7uRQioOuw=;
 b=iOvlgJfTUij4of8HjXu1NXGaGq7Kt1nfsN7N8BwVm2pYdt2aD1axh2f6dzvjDdFfyQxQ6/x1ZpODVdlrgnlhNTW598Gqa5mLv+sXCLfnAWCblrwpCyixE3xmgHwfjW72YgMCQYSUtbq3xYc0+PMINro5T/2RYSWI2NJxlXJqhwJmkbBG1QSKt1rWMaW4FqYfhrqxPIlGZC51707HtMOtLy1xaqDZ3Qvy2RQgqtq+YrmWFtOsO0gmGxiFh8NBAQHMRnFRweWR8hMd3hhyIHrHIpBytYwn0iITN+QX6Ve3NHkHl9dVufs2yb65n5kVwYwBDObYHBYXYZi23aUSg/Vrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRUyrMWURhZhi8dxg9Ovq22tDTN0YpHtD+7uRQioOuw=;
 b=3uA+5dUrEuZzx6EDC28emqn3lmqJoXTgwHfJR5tEIFq8gRYltNsN7CD8onDPSMC+gOIIBHivzW0n1oEv4Q3+3/Xoos2jDOUZzCETk1jwMXkEsFmR2749TyNhn2co9jXu6kRF3IHBQ5hgGiZBVJTy7m6RflBCfa5EL76+084Bric=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) by
 MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Fri, 14 Feb 2025 21:59:27 +0000
Received: from DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::66d2:1631:5693:7a06]) by DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::66d2:1631:5693:7a06%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 21:59:26 +0000
Message-ID: <9066c1cc-57e7-4053-bb33-dc8d64a789ba@amd.com>
Date: Fri, 14 Feb 2025 15:59:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] KVM: SEV: Configure "ALLOWED_SEV_FEATURES" VMCB
 Field
To: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Kishon Vijay Abraham I <kvijayab@amd.com>
References: <20250207233410.130813-1-kim.phillips@amd.com>
 <20250207233410.130813-3-kim.phillips@amd.com>
 <4eb24414-4483-3291-894a-f5a58465a80d@amd.com> <Z6vFSTkGkOCy03jN@google.com>
 <6829cf75-5bf3-4a89-afbe-cfd489b2b24b@amd.com> <Z66UcY8otZosvnxY@google.com>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
Organization: AMD
In-Reply-To: <Z66UcY8otZosvnxY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0113.namprd05.prod.outlook.com
 (2603:10b6:803:42::30) To DS7PR12MB6263.namprd12.prod.outlook.com
 (2603:10b6:8:95::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6263:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a6e9f5-5239-45bd-2107-08dd4d42d937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTNhU1IxOU4ydGdKcEpYZUZTU0pYeThiRHh5Zlc0L3R2SXBqa2swcHcyVlFP?=
 =?utf-8?B?VHJCaTNlaDA4U2Zlemp6UVNYanVHWmVZRzF5YkdVWE93M3NrWGJRMmthSkxv?=
 =?utf-8?B?QjZnR0V1Zi9IQnVBTkxyWnFlU3pBU1hQZ1l3MCtKbjJDclJuQnhnTnY5dGZZ?=
 =?utf-8?B?SjFNSm9vMGFkR29waUd6dzB0VERTM1ZKRm1yTjV6NFRaalRSRktIckx6SEQw?=
 =?utf-8?B?LzZNanZ2MWdEY1FKcVJSSFpHckJWN0wvYkJjeW5SMS9WSTYvRzdNN0ljclR5?=
 =?utf-8?B?bFBNNGJDR1Z1aWZ1c3l0NFBxVDJZUDhVOXVlTTZVbzJmQUc2eGNoQzRiRWV2?=
 =?utf-8?B?ZVFJRzd4VHlaT0hkOE9wZkMvNER5bHRyd3pXT1RiMTJsSWliSlB3VEltRmk1?=
 =?utf-8?B?Tk5ESmJxbnNJeGZmcEE2U3BrTHVQTHFUbW9DeE9LWE1xUWZVVFpiMWJzdTBH?=
 =?utf-8?B?cVBpK05wNWV4cndIb0wwMTNMQ1liekxocWNPZUNvVG1FVThpOFp1T3hPTzNh?=
 =?utf-8?B?RjZobWx0RFRYYlg1Z2ZjWWwwcEFsL0lNZDQvUmZnKzRkVFFNTkdOWTdiK3Ba?=
 =?utf-8?B?YjRpZjEydll6aG9lRE45UVhlWnlnUVVibjJHUktiOHBwdE9Oc1lud09RY0p4?=
 =?utf-8?B?Z0tQNE9EVEZDWHBTR0dqWkMwVnhvU2RvQ0JIVVdFNHowRzJ0cU5BUUNHVHg5?=
 =?utf-8?B?eFE5VEVCcDNoVElMaG9KNThlbEE0TWorL1VQeU9XWUVnTUh5WmxvMURKUm1B?=
 =?utf-8?B?VEJXNTRqa1N0Yk9lc3kyQ2hpSnBON0tpaGxNbUJHSUk3QkM4RGtWR2dYdHMw?=
 =?utf-8?B?WUdsMkg1d3JBcFhjblMwOHpySks1T2tSSjZDc0pwRjFzS2FqYTU0Y0RMTEhs?=
 =?utf-8?B?Mk1zaEE3ZVZvVytrbDEvZEhoV0dKY21DZDVyVU8zQlhrMExvK3Y4NU03TWpI?=
 =?utf-8?B?NDVxTWJkdUdOOHpXVi80WFgwZ1BmOGk2czJnbERLQ05nSHVhNVlMOC9SRmJX?=
 =?utf-8?B?MlljNDI3MWgrZDRUSWtjSzh4OTFzcTJtN05jRVVUQjk4eHJacmZRSDBLVmtP?=
 =?utf-8?B?QjVvSjVETmRtTXZ2YlVkY0t6cUdXVkdpRi82WmZETUprUHQ2U3RxN3FoL0JX?=
 =?utf-8?B?VlJ3WmJldCtVTXVYSjh6MGwrY0o2OGtwQkJNUmVTV3dZamFJeFlXTHRZRjZ0?=
 =?utf-8?B?TE84dlpJK05ZYnIzd1hJQlZybytMdnlIMHNZNjhpYXFXVEFsR3RST0NHTG9s?=
 =?utf-8?B?T1RaL1ByQUt5NmNUTnJiUXo4T3pWNmhlcjllSVR2Sk8rWmU2WjI2dEhMcnRn?=
 =?utf-8?B?c2pKUnVEVkhWWW4vTHdlTVlKYUNIY0lWaEpvUUxJZ0ZOQWxUVjZpWU52eWNI?=
 =?utf-8?B?MU5Ldk1CaEw5cmZ1U25FWWNQc3dreFVFMWZ0azZYUFpCWFRWRGg5UjR3N3BI?=
 =?utf-8?B?RDFrNGptaDdlTEpkelhEOXRtWE9jbzlOY2dkejNLaEFMaHp6TW9HRmtNb2dG?=
 =?utf-8?B?dUJPYVRCV0NacDN2K0JFTHhIN3FTRFVSYjJPcFVodmFCMGdVTFBBZndobGdx?=
 =?utf-8?B?L1pQdlN0WWZ2bHRBd0l3UlN2cGc1R0pNb2U1UE1ubktFQ1NMLzhYUEhUa1VX?=
 =?utf-8?B?d1A3SHUyM0lmVjd6cnRkdHc3Y0pNRE0xMy8wUFlmd2c3ajkzcXpoQ0RIZnJx?=
 =?utf-8?B?WUd1eWxiTjNyN1p1Yk90b3VqbG1Lb2hzSUdmalNKQkZFR1JxUlYxUzl5Tktr?=
 =?utf-8?B?QzVmdHV2UHFNQjBjVjNpendMNXgwdjZiOUhzU1lFYmFuMldvRUVkYmpybnFW?=
 =?utf-8?B?RVhEc2tFM1p6RDlwa3pMVTdHS3ZWT2FxZ3hXeTVOb1FWMXZHa0xDeU04a3Zr?=
 =?utf-8?B?ZzBOcGhlSnUybGxGRVFYNklRcEV3cnBKM3RVbUV3R2Jldnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6263.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFkzb0tCRnhya0lsZ0wvaXQ2azlPaUw5YzVIUVA3YTN2ZjF6em5aZU9rNEZI?=
 =?utf-8?B?TFp1VTg0NU9UWGhIT09DZDdGcW9uTEVBbHJreWVseE1yYUU0VXk2YlVobUlN?=
 =?utf-8?B?N0lobGtRV0NNb3pWUmQ3UEMxUTkvZGg0Rmc2WEQ5anlqTkQ3MjEwRVp1ZVBE?=
 =?utf-8?B?aTg3QzdzajVCN2QzU29NcWlYRVdtUnJ3Z0xKN2h6TUIzd2pZRTBLQ1lPMHp2?=
 =?utf-8?B?NFBEcHEzNWZwcytFRGpGVTc1MlNwVnU4TVQvM0VkUENsTW92aUMvQVlZRlV3?=
 =?utf-8?B?SnhMdlQwKzB1eGE3WEsxZmNFVEJ2endQRFFrVFdDNFV1SUYvMGZBajhmekFx?=
 =?utf-8?B?ckxNRWZHaTY0R3NhS2lWLzlZVHNZV0JDSERGTG8xMHdpRzh1TEI1dVpEQWE5?=
 =?utf-8?B?dUF0ckFiMUo1ckFhMU1GcmhOS2x1YklyeXVCMG1sZUZweWV1Z29VdnhqMFVh?=
 =?utf-8?B?SEUvNktsZitMWkVCWUpIaHVTbnRRa3dEZ2tuUm5ic28xRUxYb3pxRno3c2JH?=
 =?utf-8?B?TVlzYmxPY2NxRDBQcC9aSC9BczRjYjdGTHRPZWtNRUNZN1pIT1ZKQVZmMWhk?=
 =?utf-8?B?SHRqMGtPOFNVVVl4dmhWdWVEMjNJU0wxVlI4Q1BHeFAwOE5LR0ZNQ1pxc1k1?=
 =?utf-8?B?VHBHUVZSWVRNUGtaV2srMlMyWXlOaDNaR1l4MWJtRjh0LzhCY21NOVFya2Uy?=
 =?utf-8?B?YUF5VzZ2TDB6TWd6VDM0Tmh0TEFISVZwK0F4T3dwYmNLRTRsZmRjM3d0ZXp2?=
 =?utf-8?B?ZEtMQ2J0UFl2NCtURFJaamhEVDIvdUdJbDNmUVBIcW1yeXRNWG1QNXB4blp2?=
 =?utf-8?B?TlFSMVlhdkc3UXFKOW8rQy80R1NDWjlQZERGRXlRWmsrSnc2eU00eXBZd0Yv?=
 =?utf-8?B?TWhvaWpUd2FFUVN1RlJZZUcrczVsWnBiZjV1TXJVRWxCby9BdlMyWlNmdENq?=
 =?utf-8?B?TzFyTTFVenhyU012QlhjK0pESHo3OURqdjVlZUxLSFcxRzBGRnRyUWNUNGJQ?=
 =?utf-8?B?YXNrSGduaUo5MzBpOTRjTGtjRENGZmpMS29QRVRva3hNc2VkdTROeDNMR2xr?=
 =?utf-8?B?Z214TURPRWUyUXZrc1F4NmJ1QTRvOWh2MjIzUjVDRVoxRDEzd0VCK09mR0VV?=
 =?utf-8?B?V3JsQ3hTNG9YY05HMG9ZbFNQaG50SFBWeHorR29hL2prWkJuVVYySW5iUm1n?=
 =?utf-8?B?OWs3ekpFbTRYeERGeEp2STdEZXBSQmRadWJYdkdvSS96UzBkUVhJaDk3Y1ZD?=
 =?utf-8?B?QUhVUHFISFArVFUvWTEwMFBIbXF3TGR1cWJsdC95Szd0WGRiZlczeWJwQ2lv?=
 =?utf-8?B?UVYydGZ5SVI3dHcra01XQkVnYXdHZ00wa2NjamlzYVZzd09iMFptdUNiMlYy?=
 =?utf-8?B?cWdNUk1UQXNNSlU0RHVpSVZucWIxbXRVOWJlM2RZSUJOM3NZbnRNRVdreTB0?=
 =?utf-8?B?OGtrR2lTVW80Y2srV0s3UmlDeXB6eXQyVGxuamV4SFFlZjBzTWI5RnFWR0Vq?=
 =?utf-8?B?Q3ZkMVhVQ2Nxc21TazA3ck82ZkNhelpEekRjLzUwTlVaNFY2MHY1cGxMajBP?=
 =?utf-8?B?cmYwZGE4K3pDeVR0UFgrUktJOEU3OEdBUGF0bVVsN3d4VytVbERUOGVlTVIv?=
 =?utf-8?B?TVpEcUNwZE5wb0QybWdNbkVBVUVjTWhyQnY0aWQ3SmEyY0R3eVNaQVozeWZr?=
 =?utf-8?B?Z2F4MlVvMFAvcWNDd0N6ZlVZOUtuUkg5OEVsODBsOXRPSXBGWFhoMnRNMjFE?=
 =?utf-8?B?c21Ka3gwSWZEU1UvZmN2aWR4WkFTOEE5OElxR21taEtJZzhrZXBzY0Nhd1pJ?=
 =?utf-8?B?Z0dUZ1lmS3dXRlc0dEJzeXEvZ0t6Umk0aXRLQnM1dzN1ZGRhWjVEQ29MUHp6?=
 =?utf-8?B?VjJMb21PYWF1dm40S3o4VlFwMnp5VkdWSW5nYkttbVNTYTVqVWp2cHBncHFS?=
 =?utf-8?B?US81aVVmZXQ1Vks4ZzgxR3JFZU85R0ZOdnhlRUcvTDdyc0R0WEhTcHNrSi94?=
 =?utf-8?B?Q2F1bEgyTEhDUGE3dlRLZkhSQlBlaGV0THgzK2lzZDVSV0IyUjNEcXVac1Jk?=
 =?utf-8?B?Rm12OGJCTldQRmJTOXdsTHhhUW9nQmVXVU1aN0YzMlBLak50ajkyTlkvbHJn?=
 =?utf-8?Q?mQT55kentVyC0SsjEZVRXkeoE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a6e9f5-5239-45bd-2107-08dd4d42d937
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:59:26.5578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sthabkv5wASXVQjCipwRLbu8euMVSP1xT6oXJe9uj/ySSl/+RKASg2ioJHBLjNO93ISPVkAugxs/9ztGx/36fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239
Received-SPF: permerror client-ip=2a01:111:f403:2408::602;
 envelope-from=kim.phillips@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/13/25 6:55 PM, Sean Christopherson wrote:
> On Thu, Feb 13, 2025, Kim Phillips wrote:
>> On 2/11/25 3:46 PM, Sean Christopherson wrote:
>>> On Mon, Feb 10, 2025, Tom Lendacky wrote:
>>>> On 2/7/25 17:34, Kim Phillips wrote:
>>>>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>>>>> index a2a794c32050..a9e16792cac0 100644
>>>>> --- a/arch/x86/kvm/svm/sev.c
>>>>> +++ b/arch/x86/kvm/svm/sev.c
>>>>> @@ -894,9 +894,19 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>>>>>    	return 0;
>>>>>    }
>>>>> +static u64 allowed_sev_features(struct kvm_sev_info *sev)
>>>>> +{
>>>>> +	if (cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES) &&
>>>>
>>>> Not sure if the cpu_feature_enabled() check is necessary, as init should
>>>> have failed if SVM_SEV_FEAT_ALLOWED_SEV_FEATURES wasn't set in
>>>> sev_supported_vmsa_features.
>>>
>>> Two things missing from this series:
>>>
>>>    1: KVM enforcement.  No way is KVM going to rely on userspace to opt-in to
>>>       preventing the guest from enabling features.
>>>    2: Backwards compatilibity if KVM unconditionally enforces ALLOWED_SEV_FEATURES.
>>>       Although maybe there's nothing to do here?  I vaguely recall all of the gated
>>>       features being unsupported, or something...
>>
>> This contradicts your review comment from the previous version of the series [1].
> 
> First off, my comment was anything but decisive.  I don't see how anyone can read
> this and come away thinking "this is exactly what Sean wants".
> 
>    This may need additional uAPI so that userspace can opt-in.  Dunno.  I hope guests
>    aren't abusing features, but IIUC, flipping this on has the potential to break
>    existing VMs, correct?
> 
> Second, there's a clear question there that went unanswered.  Respond to questions
> and elaborate as needed until we're all on the same page.  Don't just send patches.
> 
> Third, letting userspace opt-in to something doesn't necessarily mean giving
> userspace full control.  Which is the entire reason I asked the question about
> whether or not this can break userspace.  E.g. we can likely get away with only
> making select features opt-in, and enforcing everything else by default.
> 
> I don't think RESTRICTED_INJECTION or ALTERNATE_INJECTION can work without KVM
> cooperation, so enforcing those shouldn't break anything.
> 
> It's still not clear to me that we don't have a bug with DEBUG_SWAP.  AIUI,
> DEBUG_SWAP is allowed by default.  I.e. if ALLOWED_FEATURES is unsupported, then
> the guest can use DEBUG_SWAP via SVM_VMGEXIT_AP_CREATE without KVM's knowledge.
> 
> So _maybe_ we have to let userspace opt-in to enforcing DEBUG_SWAP, but I suspect
> we can get away with fully enabling ALLOWED_FEATURES without userspace's blessing.

If I hardcode DEBUG_SWAP (bit 5) in the vmsa->sev_features assignment
in wakeup_cpu_via_vmgexit(), such guest boots successfully with the
kvm_amd module's debug_swap parameter set.

The guest *doesn't* boot if I also turn on allowed_sev_features=1 with
qemu and this patchseries.

So, the answer is yes, always enforcing ALLOWED_SEV_FEATURES does break
existing guests, thus the userspace opt-in for it.

Thanks,

Kim

> 
>> If KVM enforces ALLOWED_SEV_FEATURES, it can break existing VMs, thus
>> the explicit userspace allowed-sev-features=on opt-in [2].
>>
>> Thanks,
>>
>> Kim
>>
>> [1] https://lore.kernel.org/kvm/ZsfKYHFkWA-Rh23C@google.com/
>> [2] https://lore.kernel.org/kvm/20250207233327.130770-1-kim.phillips@amd.com/

