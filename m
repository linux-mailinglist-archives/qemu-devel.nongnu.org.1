Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A280AAC5D68
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 00:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK364-0006nE-5j; Tue, 27 May 2025 18:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1uK361-0006mU-Bi
 for qemu-devel@nongnu.org; Tue, 27 May 2025 18:48:34 -0400
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com
 ([40.107.223.88] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1uK35y-0006C0-Kb
 for qemu-devel@nongnu.org; Tue, 27 May 2025 18:48:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBmCIx0i1/pAV/iTRwiciy0tG+s7iwxzm1M/WqK5JteoVoncRvfBwiX1aGa/w3uVoXGvr5PaYZ6cCSqYJ3YkNVvx6RRfTLq/XoCMwipARuDKahCCJxMBVINHzy4RNgneCILsUQgtKr70Wn9aQrjtfyPgv0wqedsJvMMR0rmnki7FNFEVGvmTnb6sujmYEPSbjx8KBCH6ZSHjKzepRlky/9xKLQLHJ3pVce7JqDLzsK7NPZRpg+mMZkTgLfK4YqXxpc2E2Ht63gXczr7Akj3ZkzXd1X42zbfuyZFBzClT1/4jMAIpDHtrzuMCXcJJAjNt3vqEOAK9OlhS8DF/jh61sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+FdjFqQjU/7oKyXLzwaf2fbmKo1e6mEXafOSrwus4I=;
 b=jdL9U5Om0IQjbH/I+Y3e/e93YVvUOGsDAWPMnEIqDtU5Ual+/DfTGodTIRysgvwf7AH0XfhDRNdOJ35caUZF15iu0fUSMe+cLMlWAT3K4vY4LkAJ8EG3R3zgQ5PdhrKoLE+xsENsM1PXBsDdRNhMbQdsx8dDw6IOpp3mtLb0nCm0E1yxoDChOikfF38aBqZfZ634tRLivkYZFwI7oAkByXii9TS3ApVT8UkhAy5qGmEDmgj6v7cYf3MRssRdc1YH71I9KKOjTk/raSBLsNrFsLseHNFCoJsZFKaQJUNopekWZ1GNoM/NSKdqiCFPhLNxo9YuCZFSSF0tsdrQlwC/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+FdjFqQjU/7oKyXLzwaf2fbmKo1e6mEXafOSrwus4I=;
 b=1Od9/x5XB7YHCLzor3dZ7p+ka6H7IACUUUpwHtzBaulGmI9jgPXk8m75bWXv+rj9JyG2HQppz6o7XNAfD8JLQcSyy9KsF5azuU+jbm3qRWpZhyTdqVBB76VLaoF2xeoszSkNaT9rFt4PIjiCfaCvqYJNOnkI6nALM2x9lUEhYLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 27 May
 2025 22:43:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8722.031; Tue, 27 May 2025
 22:43:23 +0000
Message-ID: <7ef6a430-e87c-470b-8b6c-58b11cc8a6a3@amd.com>
Date: Tue, 27 May 2025 17:43:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] target/i386: Update EPYC CPU models for Cache
 property, RAS, SVM feature and add EPYC-Turin CPU model
To: Paolo Bonzini <pbonzini@redhat.com>, Babu Moger <babu.moger@amd.com>
Cc: zhao1.liu@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru
References: <cover.1746734284.git.babu.moger@amd.com>
 <1a5cfe89-f7e2-4e3a-862b-5d5f761e145d@redhat.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <1a5cfe89-f7e2-4e3a-862b-5d5f761e145d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:5:174::39) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 803aa178-091a-4cf4-a2b9-08dd9d6fe329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHNlQ1kvQ1VNbU9QS1dDcUtSSUdOdHVGOHBrVDdlcWE5YXBFNFp0Znk0V1Bk?=
 =?utf-8?B?eStaN3lnUVM0OWJ6aWtrTGhYZnF5bWNoVk5TUVhxTVU5aHlPRnV4WnFEaXpS?=
 =?utf-8?B?cFdROVR5L1Bma29ZN2xIOUxjTy93NlVNckZINjVud1pnNnNrbXFvYWdCd0RH?=
 =?utf-8?B?c0ZpeTRZZDBzMDlteFhqZkI5WjVaK0ZFbG1vVjJTMFNVdmF0emJLTlpXVkZr?=
 =?utf-8?B?WW5rQ3FsdjkxdHBsWVdURjJ5dGFDU1lsaGc1U0RuREdhRTI3SXFVRkNtb1Jl?=
 =?utf-8?B?ckoxVzZMV2JmN3pTSk5QaklpNmhzdUdmVnI1UERvQ3ppMC9KcGJmZjB0aW82?=
 =?utf-8?B?RzVBb0tkUzRXdG5VTSttMytyK3FXT2dXUVFyQ2RUQWViVVZuSmp4VW16QkhX?=
 =?utf-8?B?WWtpVk5sZFovZG5ncVNLdDgrckdsQkNOV2s0ekpLZGZmOGhmUVZkV0R0SWtG?=
 =?utf-8?B?MTVLUUo2Y2xCVDV4SEF1K3lhekI3SXBhS1hJeTY0Tk9yRzBuRW50UE9kWVNk?=
 =?utf-8?B?T1lJZ2J1ZFVJenlyQWh0VGczZHB2UEJVOVVmVXFGNlpBRVNkamZDbURtSGZN?=
 =?utf-8?B?cnVUcVBvd1l4YktoZ29pM1ZyTUlrWHNBcm52T0Z2dUhQU29DeFVxczI4WmVs?=
 =?utf-8?B?aW5MT3NKazh4UElnTFBmbjdyZTVWTEdKbFEyZVpCLzZ5NXVRdnpnQkowMTE5?=
 =?utf-8?B?UE9LWDZYdlFZdzV5Y3c5Q01GRjhkdjdLYUJCNUttQ2h2c2IyRzNxZkQ1N3c1?=
 =?utf-8?B?bkFDcy9mUjMvSzBYR05wcHNFMFQxYm5DdW1uMTFOajZRbGdud3RxZlh5WVpC?=
 =?utf-8?B?aUlVM2Eyc2x3SzRwTFFYNzk1UEVqTEtBTE1wQUVUZU1HQVplNHpsaHZGcWZv?=
 =?utf-8?B?YmlTVVg0MkZDekY1dzZRbmV1cXRNSllpN0Q2cXJjYW44aERUWWFVMFJ3RDQr?=
 =?utf-8?B?aThWZzNaU2dQRWRtSmk5WjFrbG91UlhkMlBQaFZWbDlvaU92blJFLytKUHdZ?=
 =?utf-8?B?b2gvV3ZYeXlmQzlKMEpBeDJLZVBPMC9TSFZZb0Yyd0s4dEJGNXNLUWkwZVA3?=
 =?utf-8?B?QkZtVFRUZGM2cWh2WTNYSGdDYVk1NldtUks5NExpWmVzd29CSzMzbWkrd2lZ?=
 =?utf-8?B?amFXTUs5NjU0d3hSM2MzZ1FaUVBTeFR0d1BWc1hlcVVMQjhYK2syZUVUWGQ3?=
 =?utf-8?B?WVhNVENCZEQ5UzZmbmNsWEpQbVN4eGMrWjJ4dFZpZFVOTXRDMUNnditzNEMr?=
 =?utf-8?B?OHBBbW5ubm5EZzVhWjlDSVR6eXZhVFVhcDBKQnVlSHhxVXlDWkh1Ui9HZkE0?=
 =?utf-8?B?ZGVzYXZMRkJEWHBJV0d0cHVrc2grYW1tQmU5SkVFblZuak1ERjZqbm9HeXRa?=
 =?utf-8?B?SEJ3QkxNOTUvUGxjSjV3bU96NGVaRkttMVNNNmFHNUt0RWttYnpIWDFDQU50?=
 =?utf-8?B?cElqb1ZITHVPM0c3SGppU25OS29zWWl1czU1OTZGY0xhTlhKclg4V3NKbEUz?=
 =?utf-8?B?eWMvUFIralFtcWVhL3IrczJPQVlkNUtsaDQ0ZC94MW80RFJGNTV2TklPVG05?=
 =?utf-8?B?di9JMW40M2kzNWo5SEJSM0J3SW9vc3ZzY25STk1WVmE4SlRvSnpWY1pOcmpR?=
 =?utf-8?B?NTQ0bmhxNDM1Y20zOWVwdnYrdm1PdWprMVZqYWoyWWd5QmdHdjVKRkN4ajM1?=
 =?utf-8?B?SGg1WVlJTUZsVjVzUVJyQ0JOMzZvdVl2TEJIeG04UnNJNzVBMTNhdGNPNlNT?=
 =?utf-8?B?THdjcXBqLzFIYVlCSW92M2E3WjF0em54WStpQ01ab2RoSVlqRkRXQ080Rnhu?=
 =?utf-8?B?enFJYUQzUDNqaTlYdlBlME1HK1BLU1hZT01ueTliZnhHR2duRGpSdlpZc3g4?=
 =?utf-8?B?M1lpeVMxVFpMMDh2R3pKeGNTdU5BL0phZTkvT1NVeFJpS3lPbWJZdk1lTnNY?=
 =?utf-8?Q?Qz52TPu34zI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjVkWUVPNXRGVjZqVWg2djhGbExoNDhRSWFlejVSeDBDck5zc1FHcHlQK3gx?=
 =?utf-8?B?MzNxNVFBa2JLZkxxckZLdm45VndjTG5DNTNGeUUzUlVjU0xJcmk3WFpwKzFF?=
 =?utf-8?B?aEpTOUxoTWdBK3pYTjlHVDc1WmNmQ3ZtUlFMMnkvZHNiUjI0SDRaRG9oejZq?=
 =?utf-8?B?cGdmVGowZSs1U3JGK1RiTU5vSFc3SFdBN0JZRXg2TnMyMVhra2JlZlRqS1lx?=
 =?utf-8?B?UzJpcDNPdlZPcjFacGV0anlXUUl2UVJMWmw4ZXpLWmpTa3M5NFExWkFPdnMv?=
 =?utf-8?B?MEJWclVRMkVvcit3V0VRVU16andSSzc4VGh2MmxDMS9JOXA0VTNpMjk1WGNi?=
 =?utf-8?B?QkV4OWo1bU9ZS3dsei9yVDNCTS9iVEZRaW1XVWpGbGxwUUFMQWhlajVRU2FS?=
 =?utf-8?B?WGxqYlJ2Q1RaVnY4RzFERVNVNWZNL1Ewa1A3Z1p1RUFpM1A1K25pVjd0ZUk5?=
 =?utf-8?B?azVLSHp2eXBzZDFSTyt1WlBVRGRwSTlPdy93OHk4anQwbEpBdHRhdEU1bC8w?=
 =?utf-8?B?aFhzV0tyTEpPMERrN3dIdFhmQ2IyVzNocUlveGtwblBpRTFCejZldUk5WmFI?=
 =?utf-8?B?b0I2emlGakd4cHN0RWZYb1JYNmF2V0FpUEVseHZWZzQvbUpxK0MzWFV1bU5V?=
 =?utf-8?B?VmNvSzdxVWZ4YzVpQlptZ2xjTzcwSy82SENEZlF0QWRCWEVLVHViNXNOb2ww?=
 =?utf-8?B?bGZhN0ovQi9NUWpxSlM4blM2MkdFSTZ5dWpCZEgwN1NLNEpZV1BzWjVKQ2dt?=
 =?utf-8?B?ckZ0WkFGellJUDR2YlIxUjVzSkx3d2dnYmlBL0pVVCtWeStYRW9qdmxHK0Fv?=
 =?utf-8?B?N0xhOXh6ZHdUV3MxSTdvejd0azVqb3hBTGtXNnIrMlB5dWNNZG1RcWRSSUVG?=
 =?utf-8?B?MG5UMldraDVqMUNHUEk4Y1ZNU2dubnpFU1crK2VKZmxvUjlQenc0MmFDN1Uv?=
 =?utf-8?B?QXhEUmtzU3hrb2xDSVhSZXByZWF0VDl6Tks4TXM5dmpLQ3cxTy9QSll6L0Jt?=
 =?utf-8?B?ckxjMStYR3MvMTZKWSt4RzFnSkJvK2czSVN0RjN5bkVwKy94NlpRRUt2QU5T?=
 =?utf-8?B?Y0x3czYxNE9ydU4wc0FrMnNFZCtNMWdFMXlMdUtNY2thOFdIZDhIRGZJbXIr?=
 =?utf-8?B?WndGWmNJU2FkRGZjdmlqRkFJbW52QTR3VUc3eXcyYVh2blQrcEdRR3VhV2M3?=
 =?utf-8?B?dHhhRE8rbEtnY3h2S2J5S2VXS2lGdzJreW9BTlM4c0NvK3NOZzd5bERXOFBm?=
 =?utf-8?B?UlF5R21Zd0NyVldHTXdWRFAwTExKT21qZVlYZFNsWXJ3c0lzLzRSdS9JaENM?=
 =?utf-8?B?NlJ0TjNjOWJKVVY1Q2V3R1UvRFJYMnpneUhoT2dQNW03b1k5OWVCUDNGcnZB?=
 =?utf-8?B?Y0loczBBdm9hSHNzVUYxSUFBTGY4VG9UY2ptcjlKVEtVd2l5TWpWQXBYV0dB?=
 =?utf-8?B?UXgwWVdFYzBtZXZvblczZE80aERjd0RRVVdNRmxsdWQwVlpuaWg5TGpDcm1n?=
 =?utf-8?B?YWE0ODAvSnRpQXJLUWJGSHd2UFkzUFVUYnp0aVl4ZDhzUHR6UHVWN1NVQWMy?=
 =?utf-8?B?YzVkS0hld21ySVlsM0xOTWRkUlRxenM3aC9jZElPME5kSUV1Y1JvdWJHc2VJ?=
 =?utf-8?B?UnUzSW5HeGVucUMyVnV2Y2xDc2dCNStnRzZZUW9LU0lQcFZqV3lmdTVHZk5Q?=
 =?utf-8?B?NnVlMkRwN3dxWmRtM3FrUmFhR3NVQWJhdjlDZ1ozbDJ3MkppN3RDa3JuYjNE?=
 =?utf-8?B?TTY3cWVaZjlYd09SaFlSS0tCTEVIT0V4WjYxakJXV1c5eDFOejh4NlFlZWVL?=
 =?utf-8?B?ZkU2cERQbTZxOW8vcXVwWlROTzViWml1UlVwYVJpTmV4Zkp6Z2VGTUc0amdI?=
 =?utf-8?B?WnlsNGxlcXN2MzQ1OWV5L3JFRlFpeWM5eVIzWmJuSzRxU0d3VW9SVC9SSGdn?=
 =?utf-8?B?NHYyNS9VdFRnTks2WUJML2J4N3d2UHJDaE9SWFZRN2g3QnhnZnJMaUhBY28w?=
 =?utf-8?B?VVhaN2hXUTFZeXZzNkhlVmFDeUdza3BLdXJTREVIZDdHdHZuUWx6U29sajdZ?=
 =?utf-8?B?aFM2amhSQzBHQ2pKSStQdXJOUHo5RldpYlNwQ3htaU5hWHBhMXNjMngvWGlz?=
 =?utf-8?Q?yKh0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803aa178-091a-4cf4-a2b9-08dd9d6fe329
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 22:43:23.6566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so3RGvFAItMsam+uJ9AnOnrL8l0KRTKavtd5l2oL2HH/ByhwtTLvHQzuBaJAchN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
Received-SPF: permerror client-ip=40.107.223.88;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 5/27/2025 10:42 AM, Paolo Bonzini wrote:
> On 5/8/25 21:57, Babu Moger wrote:
>>
>> Following changes are implemented in this series.
>>
>> 1. Fixed the cache(L2,L3) property details in all the EPYC models.
>> 2. Add RAS feature bits (SUCCOR, McaOverflowRecov) on all EPYC models
>> 3. Add missing SVM feature bits required for nested guests on all EPYC 
>> models
>> 4. Add the missing feature bit fs-gs-base-ns(WRMSR to {FS,GS,KERNEL_G} 
>> S_BASE is
>>     non-serializing). This bit is added in EPYC-Genoa and EPYC-Turin 
>> models.
>> 5. Add RAS, SVM, fs-gs-base-ns and perfmon-v2 on EPYC-Genoa and EPYC- 
>> Turin models.
>> 6. Add support for EPYC-Turin.
>>     (Add all the above feature bits and few additional bits movdiri, 
>> movdir64b,
>>      avx512-vp2intersect, avx-vnni, prefetchi, sbpb, ibpb-brtype, 
>> srso-user-kernel-no).
> 
> Queued, thanks.
> 

Thank you
- Babu

