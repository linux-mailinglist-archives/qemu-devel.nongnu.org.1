Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD913A09CB9
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 21:57:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWM49-0001Ry-AT; Fri, 10 Jan 2025 15:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tWM3t-0001Il-Gb; Fri, 10 Jan 2025 15:56:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tWM3r-0008Mt-LP; Fri, 10 Jan 2025 15:56:57 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AKtpGo004800;
 Fri, 10 Jan 2025 20:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=x0+2lf7luJLROKPcBhf09gvAwgMp9Ef3ikvz6ht4mJg=; b=
 f980fjZVTrqjaiVt41RVjmuCtV0S+BcQcq21ZK8tfQfht+8GEfQhkA0jahL5Rksj
 UG4aCIp/nPldicF4lBEFsmf86hCpojp52mos7JY9BWPYKTQUWxkz8ORMVHRLrLjS
 VEN2JoSsNPB237p8E1ly2zIjQLvwYT7ZsrZcIpeAwwsSO6rRYBd4Ov2efPzNSJLq
 EONM3HrGve7KxZDFXHVR1o/Qo9+cHKy8l0R9MT0QSoFVbiUfmke8wgRvUqxZ5Fn9
 C3b9i47oi1dOJuLOM57YYZXewZkScvRN4GoWoHkdjygAc2REts+5WnUUBiwASROl
 mTIFlqydeNyrMQTzk33xRA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk0c2cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 20:56:48 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50AJxOG3025436; Fri, 10 Jan 2025 20:56:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xued54j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 20:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s37feJV9DQRV9V5Brw5P/oeaE55S4aO1H4TnAFJf4nL+ibTekReJs5XNkjGaDfXLVTkHypahvJ3TC1LqMl2KWlGEDx3ZubpbsPzD/YiVi9Lt/TQWz+CyPrX7khohpOmBAMVZlYPqBC2q8GLu/pRXJDeXud2WKSQ6YDPHWpeE8fEjjpmzIS7kvq0/+d8T3cdGPn2r6BBEmlnp39tq79C9PdQw7LrSFoKNG2XvXmCj8ZPJqVZFq80d9HfJMeXGro1POSx/VyPfcGLPBDe5PvuO2OWHtem+ASPxRJaDZwVxTSBWlxDw+tiGkqE95FZiuwsju/KWB1FbonxaLhJJYd6NXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0+2lf7luJLROKPcBhf09gvAwgMp9Ef3ikvz6ht4mJg=;
 b=Pqir6FbQRcfIAvzaKboUwq3k8bmukfF9d970BJs4147BCIwJa0V858B7eX+UO23YwgKEF1+boVv07OT7g8iPB0oCZZVkrICXgFFPGZgqo6y7z9jeAmwCrrL6hyXRYLme4jJB9ZhTmBR/tSHs9AROctB2I7+0RN3VJHPTX/yVbPOS3Apt78XhXtVu1iQ+H3wflmQC98vmatYOGW4eRHRDvdD7PThaM8wNnb5yUx5FEYB5MUXqFuEGZyWZhk6wBv5Qo2jYKOw/edfOfmLceb3Ica1lVa4t77HmnQuhTZmS32c9h6Al34ShFpsWAGAXve7TraLFTyISQ9qRyjiZdqMwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0+2lf7luJLROKPcBhf09gvAwgMp9Ef3ikvz6ht4mJg=;
 b=zohf515neP5BB0rpkgobc4jxuwZJBOn4fWfsecOF/rDrJ2eO4wfAn1OCWODKG0B3PQjJU+lYro6NkUOmrJMvguqPOXfJxsXBGU7eEuiG1Zu8urxy8/0pnrOnTLcHo/xJZWNT55/QOXREOQRS5t7N3tLso71F0Jzj+kyGz/K4gM4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 20:56:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 20:56:45 +0000
Message-ID: <9d1ed0f2-f87a-4330-bf5b-375e570a74e1@oracle.com>
Date: Fri, 10 Jan 2025 21:56:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] system/physmem: poisoned memory discard on reboot
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241214134555.440097-1-william.roche@oracle.com>
 <20241214134555.440097-3-william.roche@oracle.com>
 <15d255c8-31fb-4155-83f0-bf294696621b@redhat.com>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <15d255c8-31fb-4155-83f0-bf294696621b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: ff879e4c-4f4d-4924-a9cf-08dd31b94af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3ZVV0ZnVXkvMitZd3dQNjVSaHlSUnY2d3pubnFhY01OYjhTMHdsMHJ2Z2F3?=
 =?utf-8?B?eHFaWkZLekFQYUduV3dZaytTUG43OFc0Zk9RT0tuOEZXcVV5WldZaE40bGNY?=
 =?utf-8?B?TWl4TUMralg4aGlvUmptSmdCeHdRd1NnOWY3MzNzRnMzbDJyMkVDcGhNQVdY?=
 =?utf-8?B?RUx4Z3RHdmlGWUJib0ltZTZRSmM5bU1vZldsWEg0LzhQTVNsaU9uaVdPSjRj?=
 =?utf-8?B?TWpHUDNYNUdxWnRKTG1SZlVCM3Q4eGhBNFFEUTBLSmlnTHMxdXdMa1g4bkpv?=
 =?utf-8?B?bk5GVCs3M2NpdmpXc254bW96SUpuV3c1R2dKRDdpMnJmSVBPdU13d2Z1Qldz?=
 =?utf-8?B?TTZMK0lxWkVCcTdqZnZqQnJVbVE3QVhCOHBuV2VFZ3F3RmZ5TGNwdGM4eHBJ?=
 =?utf-8?B?RFNyR0Vaa0RxZUtUazBRK0JJV2duQ0xLYnZoaWRhSnBMdXRnTmJWcGlkUGZ6?=
 =?utf-8?B?aThUT1h3bDhtQjdHZmJNbXExRXNQaE9lQ3dqMWNrQUR1ZU41K0VuS0lTQko5?=
 =?utf-8?B?Sk5TMXlBMzJqQmF5QmRUc0luWTFnTEdGS1VxOThyd1g5ZFhwYXdDL202Z1Vt?=
 =?utf-8?B?T0VBeUJyK05DSXFuWmQxODB0eElrMHB6OXhETk5iWisvWTgvQXdka21HMSt3?=
 =?utf-8?B?c2pEUU5FbkZ3N0ZRSFVqaTVoYjNnNDhTSkdsdUJhcGZxYWV1STllZTdnbUlZ?=
 =?utf-8?B?MTZOenc4QmdYY2hoSFRtc3BWbG5tZk1uNlpISmltc1dYYkw0KzBSemZzUHVJ?=
 =?utf-8?B?LzVpUUR4ZFYwUCtVTm5uREYvb2xJekN4RHdnRG1LNm5iRDBJSzVZSlZrUUNZ?=
 =?utf-8?B?Umkvd3B5M3FXVUUyeEZaVEROU0tyVTlxeFQ1djNsSnorS2s4d3p5VkowZk1R?=
 =?utf-8?B?ZzlsSXRDQlNSbHBrQkpZKzEyK2FwalpKaWxDU09tMWhWY1h0Q3lXVEs2bWVm?=
 =?utf-8?B?czdFTWF0THdUUlRRazVCNFI2dVduREtSTFpzMHRLcnEvUXV4WlFVYU50cFU1?=
 =?utf-8?B?bUwyd2FiZEFsUUtBOWVmNndIV2s1VVRNb1A5bzhBOEZKVWtPRHVRYWVmOTh2?=
 =?utf-8?B?QU1CTFpneEw4OTBlT291UkhZOTg4UEVvWGhFQ3l2d3JKbmJkR3NWSTE3Q1Vy?=
 =?utf-8?B?VnAzTGlMMDF0R2hrNXpPVXMwNjJ1R3Nycjg3MzhkTDFkZ1dVaUVpbmpINGRU?=
 =?utf-8?B?RFQ1VmNoUlpNU1BieHQ1WGFkeWt4ZlNRejlSK2plSkpVV1VTdnZYb3c0eFcw?=
 =?utf-8?B?SXRobGtSL0dJLzY2VVFCQzBObGhabW9GVktTWTNveVZrNnhEcGwwVCs1NXUy?=
 =?utf-8?B?bWpSd3JqRFR4WFRUUTNxVTluUXlWeHczb0c4NWhGeTFreXJYNEpBRzc5bG1l?=
 =?utf-8?B?WU50YXFrRGwrOWxXSnRuMlMyQkVLMzhSVzFFa1FYZUc4UXVvWjcrbVlqRlZj?=
 =?utf-8?B?Zk1zVE1FdlRneE5LMklyaGRBUmg0VDU2M2dPVG5keTlDTlArMGlhRmZlYUJv?=
 =?utf-8?B?cTVzWW42b0NJN1FnREN4MTBCdk9Lb2thaFJsOWdFTGpYQlpNbnBOY1ByTHRS?=
 =?utf-8?B?UlFWczQ4Wk1weFd2TDRsOUVtbE4zWHlYdHlMWGl5S3luejdCdXZEVUR2aHQ1?=
 =?utf-8?B?WU16OC8zYjdVVEgxUGVKemRpanY5L2J6bThROVFmSUFvZ21YaURRMW9sYVZC?=
 =?utf-8?B?bkNjdlhPeTVqc3NPOElINVdyNDJvOEkwZjFXSnZZcWwreVNlckVWWHlyYkpT?=
 =?utf-8?B?eURpa25yRkFqbDhkNzBNOUIwcGM3d055QllhWGdyVUFSOHdlcE44NVIvajJF?=
 =?utf-8?B?K2hCTGN3ekh0M1NHTldHTXFESXZURXNublUzK0Y4YWo4SWdCN1RkNnYyR2Nv?=
 =?utf-8?Q?UuscVJzf+cbp9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RytUSTk0SE85Q1Y3SjE3R1k5U0lONnpCSzNjM0J2Z2t3NjdsRUpza3QyUjNU?=
 =?utf-8?B?MkgxZWhid2dLMDRtQjFybWxWc3A1dFVpVzArMUhJOTRzTVdpVXYrNFdScG9K?=
 =?utf-8?B?R29hV2FoNjkreUpad054S1RsVkl2U04zWGVJMHo4aXQrNmxxS3AvRTBZNGts?=
 =?utf-8?B?VFJQenMwUm9UZTJyOHVXQmNkNGp2RkpYY0VMNUdTamZCby9heDRRajNxN3V4?=
 =?utf-8?B?Y1dxVXk0WUpOdDhwVGtsTjA4Mmo4aTY3OXBFOEgvK2Jqa3dmMCtWR2d1SWsx?=
 =?utf-8?B?c1BUYVNVWmtXNU9tR3lqZEU0cm9RRE9yejFFZ21JZGl5V3l4NDZhTGRHZmhH?=
 =?utf-8?B?ZXRCcFgwc2k3NkpOUDZmemo2OXdjOUZQYjhPdVoxWDRQekNZK256V2drS1Vl?=
 =?utf-8?B?NVpsbVVyamNHdWR6RXMyTU41THdNbHY3N2RKUmYxZTJrd21oTFpuT0lvMU5T?=
 =?utf-8?B?dGRBajVIYjNZTko1aGhoOUVXSCtrbTQ1S2Fhb0dsbStmaW8wTUFJSkR4MHMv?=
 =?utf-8?B?c0JMdTNyVVJVZDg0RjZnVTYva1pFRXVENFlCczhvMXlTSDVyOVNDUk4ySGo1?=
 =?utf-8?B?cEZPVmZJdGVFRmRVUk13bWcyWG1oRC9PMG9DclVjdC9jK09wQmJEeEJGMXdI?=
 =?utf-8?B?ZnBCNVlNSWNlcjFvUUd4S1NCQUF5QW5KVW9uQjg2M2MvbzRDM2lDNzlhaXJu?=
 =?utf-8?B?NlBIZXBSY2NIQUp5UzcvcllnZHBPOHdlQS85TC9uNmRtYVhvcElxRmQ4cEVx?=
 =?utf-8?B?TjFvYW1ScS9rUGozS1ExTmlXYnRtTE5KN2FIQUlKR29ObDVvdmkwSHJHRjVD?=
 =?utf-8?B?UnBiWFRWb1h0YTV5MitQUEpjbXE3cWo1aUlXZnJwS2s4cTRWaG96bVFmaGpk?=
 =?utf-8?B?bDRDTFJ2ZWNIakl6MzBXQmliSlpCSVRwc01qRVhic1ZuU09mc2VQWjkvS25q?=
 =?utf-8?B?RWcwdCsyR3ZCOUV6L29DNGxLZnRpUW9JWjVSNXRMR2tJaUc1R2NSSDk2bHdy?=
 =?utf-8?B?SnRZYzVGMTlVQUs4enk1T1NYbEUxNCtKMVp4aVJLUENjWmM5em12SkwrNzNx?=
 =?utf-8?B?TElxZHN2MFd2YTc4SUdjTmp0NVJEMzI4bVJ1enFnMTM1TkZ4eVdNK3poTkhY?=
 =?utf-8?B?UUs0T2diM2c4amVremVBSTZSYmZ5b2RXSW1VYStURHVIVytNYzN5K1JjMTdu?=
 =?utf-8?B?ZTJPS3M0RHhjTjZWNmQ4OGttYUMwZmRFOEczSDM2Mmd0QUx3Z2VVRTAwd29W?=
 =?utf-8?B?SjZMazNTVmV4Z2RlM3RhcGhMMWZySmtpK1hUTUxLUm9GZEhna01IN3YrUjRi?=
 =?utf-8?B?S3ZOMTd0V0o3TXVOSEFpL2h5L3ZqN0FyNlJEOGNsMkdqNnAreVV5VFZqWXcw?=
 =?utf-8?B?c0JoODN2T0diTWNUR2lVNytDQmlHTXBmdHg0YW10R0plSzZBR1JjdXZ3RDRL?=
 =?utf-8?B?SWliZTJsV2txSGJCbk9uNWl3bnZtTTJZaXU0RCtLRDNxYk5JWXVzczFvZzhY?=
 =?utf-8?B?QitzTDB0UkJUWGwyTTJBQVBQdStZOHdMQ01WZjg2aGMrSnZ4NFhjOHlXV2lN?=
 =?utf-8?B?QUFHSktRdEROd2xEYzBHRjF5dHBSMWIxd0F6NU1laG04Mk9yS0VhTlp4NUMw?=
 =?utf-8?B?N3QvYXBXS2dVSXBxUm50NFVQS3NmU3N2SkUyWFgydGRvMzQ2b3RMRVdsa3ZB?=
 =?utf-8?B?MjlCUEpQNXpYMHFxcDlRbWsyMVNQWVdBcmpYQmxyRWx5QXp2dHNoL2M4Z3Fk?=
 =?utf-8?B?Y2dDWk5jbUhTd1RCQlMvZmZJQnVSUFNUNnMwcGNVNWgzT1BCd3NxWkJtUDU2?=
 =?utf-8?B?dE9TQTFodWRDQ1M5N1dIU2FhMUJWNFdoTUg2YTM1YWlZOXpnNThoOHR3NkZw?=
 =?utf-8?B?d3FjOEk2NFBNVm85ZEpKaUxldURieHFpMXdrS3EzVUU5K2NHUWV6QlhNbDls?=
 =?utf-8?B?L2NoemR2VWVtSU5lVXlvYTZYKzYzYUZUTy9lS3ZYdUlZV1BicllBdFplakFU?=
 =?utf-8?B?L2tBWlNrNnhkMUxVLzBwalNKZVo2aUNFZlZIZzJuamRqeGFxTm4rU3ArK0dv?=
 =?utf-8?B?Y3lkQU4xR2tTTk53a3JUSWI3U3dVNTNCZnhsTk1oNDVLYWx4MlB1U1pES0FS?=
 =?utf-8?B?TFgxVjRPZTRTeFBSWHVWZXdTQkF5cGJ5VkYvblJVNHdxMnkxV24vWnh5cGgx?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: osI/XQ3wa4IgIdhvTgcUw88mIOAh8BoQVjleXc5PBr1NzAnquVwRciw7hZ8mY1FvGWqFvVaB0YO9Fh0UCDX16FDay9/PgXT+qsZ7AIA2gMFIUBdcDxObC3szrs9wfrq+PXYqjCNZjjwizpwMvX1wOG/FmlJB3x9ZsNIP5i5wS4j4bFyP5AS0Rgxlcdu0R+xn1iDSu3Nea5sN9YANyEpw6695a5U4G9GSTYej/ZDJKpjTUCgaNFwkaqsbW+S3OtV6dLVI+FZ6dnu5Y3weP2+NIiaCNKT6LJsQDtsPKC7ZNYfp+Wqmw8jmdzlYC7Pk0P1/5uIY7CdUXnhgTqKshL0TRRkNsrwcAnmg3OQDXl9CYSje/rMu/Cj/GGzsrbviTG8KLLmfWl1vzDTs1dvn/G3xV86wnfcr4V0wF55O19TniGeISStitw1VuyX3bQ2+rmOGg0lgvXl9Af5Ttu5Q7nv4xGCm9DaJFD6BXGHqAtkXIo++WttiwfPAzS6wlQKfjQEZ5BODYOgv7xZHk4iNbe/JudogHwgvx3/m4PlUbFQaUrE+QB/34aASSVQhyQEJgWb4cDuCn6sPaqa3H5xQkOihC9oXCNl+c+cT1PPpAfa2rrY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff879e4c-4f4d-4924-a9cf-08dd31b94af0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:56:45.4693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHRhZca1XjzeduTCCDFReBNvd1xRTl9pKZliCiFgdeh+R+4WzrZ/G+y2LhKyFFg9YyLKqDrAs54T0+M8b9YWarCcYsC3HO0LWId7XAZ/Ot4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_09,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100161
X-Proofpoint-ORIG-GUID: JdXgfxc7d5xH92TCCiCNATcw4Tz0DQEx
X-Proofpoint-GUID: JdXgfxc7d5xH92TCCiCNATcw4Tz0DQEx
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/8/25 22:44, David Hildenbrand wrote:
> On 14.12.24 14:45, “William Roche wrote:
>> +/* Try to simply remap the given location */
>> +static void qemu_ram_remap_mmap(RAMBlock *block, void* vaddr, size_t 
>> size,
>> +                                ram_addr_t offset)
> 
> Can you make the parameters match the ones of ram_block_discard_range() 
> so the invocation gets easier to read? You can calculate vaddr easily 
> internally.
> 
> Something like
> 
> static void qemu_ram_remap_mmap(RAMBlock *rb, uint64_t start,
>                  size_t length)

I used the same arguments as ram_block_discard_range() as you asked.

> 
>> +{
>> +    int flags, prot;
>> +    void *area;
>> +
>> +    flags = MAP_FIXED;
>> +    flags |= block->flags & RAM_SHARED ? MAP_SHARED : MAP_PRIVATE;
>> +    flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
>> +    prot = PROT_READ;
>> +    prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
>> +    if (block->fd >= 0) {
> 
> Heh, that case can no longer happen!

I also removed the used case of remapping a file in the 
qemu_ram_remap_mmap() function.

> 
> assert(block->fs < 0);

And added the assert() you suggested.


>> +                if (ram_block_discard_range(block, offset + block->fd_offset,
>> +                                            page_size) != 0) {


Studying some more the arguments used by ram_block_discard_range() and 
the need to fallocate/Punch the underlying file, I think that I should 
simply provide the 'offset' here and that block->fd_offset is missing in 
the ram_block_discard_range() function where we have to punch a hole in 
the file. Don't you agree ?

If we can get the current set of fixes integrated, I'll submit another 
fix proposal to take the fd_offset into account in a second time. (Not 
enlarging the current set)

But here is what I'm thinking about. That we can discuss later if you want:

@@ -3730,11 +3724,12 @@ int ram_block_discard_range(RAMBlock *rb, 
uint64_t start, size_t length)
              }

              ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | 
FALLOC_FL_KEEP_SIZE,
-                            start, length);
+                            start + rb->fd_offset, length);
              if (ret) {
                  ret = -errno;
                  error_report("%s: Failed to fallocate %s:%" PRIx64 " 
+%zx (%d)",
-                             __func__, rb->idstr, start, length, ret);
+                             __func__, rb->idstr, start + rb->fd_offset,
+                            length, ret);
                  goto err;
              }


Or I can integrate that as an addition patch if you prefer.




>> +                    /*
>> +                     * Fold back to using mmap() only for anonymous mapping,
> 
> s/Fold/Fall/

typo fixed



>>                   }
>>                   memory_try_enable_merging(vaddr, page_size);
>>                   qemu_ram_setup_dump(vaddr, page_size);
> 
> These two can be moved into qemu_ram_remap_mmap(). They are not required 
> if we didn't actually mess with mmap().


These functions will be replaced by the ram_block_notify_remap() of 
patch 7 which is called no matter the ram_block_discard_range() 
succeeded or not.
So we should leave these 2 function calls here for now as they mimic an 
aspect of what the notifier code will do.


