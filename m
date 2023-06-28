Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1298E7410EC
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEULC-0005t8-Nd; Wed, 28 Jun 2023 08:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5364a0850=roger.pau@citrix.com>)
 id 1qEUL7-0005sL-Jr
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:32:06 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5364a0850=roger.pau@citrix.com>)
 id 1qEUL2-0007UG-MK
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1687955520;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=D+6OJplv5JUAMhmN6j3VqFnR9mqTzXWwurstxxPVW5c=;
 b=bhdBDFJFlIe+gYFqjrDrYRz73b0jTB4HnSXPsCBiYMMU3wcu4kyuhgTJ
 hhuMYyGd5M42NBeN07h21uKxWq9wjIwU2XQc5Ss03qjnlgQWQaBvD8P0A
 b4M6IYEViHyLmnrVTKJkDhsuooZ3Maa43/QwZRr9sNzcd0Xo70Q3E7uHQ o=;
X-IronPort-RemoteIP: 104.47.70.106
X-IronPort-MID: 117020760
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:oKPw763Ka5pnCIz55PbD5dhwkn2cJEfYwER7XKvMYLTBsI5bp2ZWx
 mofCm2DM6mLM2ejfI0gPd628R4Cu8XVxoBhSFRupC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb8XuDgNyo4GlD5gJkNagR1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfIkxJ6
 6IYIzk3a0qDluKan72rUrVjmZF2RCXrFNt3VnBI6xj8VK5ja7acBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxouy6KlFIZPLvFabI5fvSQQspYhACAr
 3/u9GXlGBAKcteYzFJp91r137CXx3ukBtp6+LuQ+/4222K2/E8pSzoJekSKsejjqFW3RIcKQ
 6AT0m90xUQoz2SpRNTgWxyzoFafowURHdFXFoUS8QyI1+/Y7hiUAkACSThObsFgs9U5LQHGz
 XeMltLtQDZp77ucTCvF8q/O9Gvsfy8IMWUFeCkICxMf5MXuq50yiRSJSct/FKmyjZv+HjSYL
 y22kRXSTo471aYjv5hXN3id695wjvAlljII2zg=
IronPort-HdrOrdr: A9a23:vDFgKapIXyHqKEgmLWUnIlcaV5rveYIsimQD101hICG9Evb0qy
 nOpoV/6faQslwssR4b9uxoVJPvfZq+z+8W3WByB9eftWDd0QPFEGgL1+DfKlbbak7DH4BmtJ
 uJc8JFeafN5VoRt7eG3OFveexQvOVu88qT9JjjJ28Gd3APV0n5hT0JcjpyFCdNNW57LKt8Lr
 WwzOxdqQGtfHwGB/7LfUXsD4D41rv2fIuNW29+OyIa
X-Talos-CUID: =?us-ascii?q?9a23=3A037882gFUqFd1S/Y5KCeEq8ImzJuUVDa0inQKEa?=
 =?us-ascii?q?CDDxpWb25FlCA4P9rjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A9eJvtQ/bkq6F7Z1hrPx8HB2Qf8pov/+RLXouq9Y?=
 =?us-ascii?q?hpOabBDxhYRWGhSviFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.01,165,1684814400"; d="scan'208";a="117020760"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
 by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Jun 2023 08:31:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuT5lCarCMbtTDXkyARhko8fne75c6LkqwOCfwfB3etuiVRwvn2svUTznT02+vS+MB0W/xpIDcEVpwzD8MQnMl6u4AoYMXD29Qi0H3hs4UavnYZti3huPw4UMQzzkk/vmKxmrHk3xlG4vfR7qhV6iWWJ2N0w/fV3iBRYKTh+VJEpCs26obOjAZOTN99jk4+Qy1ylI3CGSM8WKhnl08lXxzI4v4c5uC8C+q0xnpM/DSN3AwRhKHfX67bm7THRaCRsCzPQ1Vw2A1uqsumlBC0JMgNOktBEoeXxep4e+i4mAYf4zHZyarTRmwrq0dCUzgatDTJ7NkAWBCYMgGdOIY9dkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82Mn9ufYnVtMUVjb2N3I9U6nNr79656QGF4SV/QKWHk=;
 b=lKiZqvQ/MWSVsk2w1iWPAnmwiX0o0XJANNIu2xfFIhrVBtsMPgAIkNNpFEEf3eBOZJ0S+Imbj08hD3N5IXXlG8R8TW81ylw5AZd99ZtkkHjYoJxmSLUjGr7e+Fo0Q2GunKUPnt5EfpY7+VJZWslSwR4AuagkTvtKdRYOTPU3Qzd1smyRIfQD82wJuDh0xBBRdQCUIdXcdJl+kajc2+/jPAPyQhSOk5fsw5tE18KM4ftfiZn5CRH6aAXNZatrh9fTFoO3eloNpOczSc5spU1jcxlsdKtSE6zFCGH4mXVobZLKzudMSUjI1oXEkInZRnR9S5MLGWJvhvg2EAOouQJmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82Mn9ufYnVtMUVjb2N3I9U6nNr79656QGF4SV/QKWHk=;
 b=qxenUcLWbeLiOOGdts1LaNKhwhn5PvlQYbNQP5dhjcFZB8JK2qCNDq/ha2EaU9eTy4Z5KaPCWOlLRiNOHSIpJnuayQbjb08S4Dv08FdFvrZbC65JWb855mnNMykLsMn3GD9WlfPLuECVmkxWYer/1umtLb052ozIBJ4bxGuoGp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by BY5PR03MB5048.namprd03.prod.outlook.com (2603:10b6:a03:1e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 12:31:45 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 12:31:45 +0000
Date: Wed, 28 Jun 2023 14:31:39 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Jan Beulich <jbeulich@suse.com>, qemu-devel@nongnu.org
Subject: QEMU assert (was: [xen-unstable test] 181558: regressions - FAIL)
Message-ID: <ZJwoK50FcnTSfFZ8@MacBook-Air-de-Roger.local>
References: <osstest-181558-mainreport@xen.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <osstest-181558-mainreport@xen.org>
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|BY5PR03MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 08888aca-e1df-40b4-3b81-08db77d3a242
X-LD-Processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEfC+J1qNuKUbE47XeZ/qxYUvEoqhotQPYjhyAhmQ+689gsPrSBudnynH0EgLOSyUBRXzNhltmliw7S+oDPAWKEX9Hpug9WUaYMpV1PxK581Ovfo6aN5Z3jC6mztQ1IcpVnHogq+v1s9kwiPjNDow9EOI1yqHN0h6AgLKIkP5Z6RL7xZoNsT4Im1fGD9iMBZnlJi43staQ//ksVt3mTzp1JWN40ws7jBXpRXUo+FckGsbpkblPa216l07LAlmw0TJBHcoGM1KE9XVFEsALOPczCULXb30tSxQKHR7aT+YyFD7hsVk//l6ofHekA+2hhk9wcZMM9aYPc5hKC60JpsGcf/gSaubCjb7n2DCNt/ppX7RViGC62QcTAMrv7iU9TD7VhMG+rUmpQeHrtpG+yyOwOQXzMhIBS1XKjTfKd2H4DRb0nDgPJNolWodHenFKVci9VV6ZkaxpQiGLPVPcycz+EjvTzzutriLgyWqSRdiHYEzB80YsMdqYCJsqW/NaEbkcIwQvopFeGYqNpjauPDpn5m1TcpWE6vVRvzcsyAgDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB6423.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(6512007)(6636002)(66556008)(4326008)(316002)(66476007)(478600001)(8936002)(66946007)(85182001)(6862004)(8676002)(5660300002)(2906002)(86362001)(966005)(41300700001)(6666004)(6486002)(6506007)(186003)(26005)(9686003)(82960400001)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dktYbFdvK3JIT1EvMDVqMEp2MXI3NXhpNDVEWFEvME5laXRDKzhRcmpmRW4y?=
 =?utf-8?B?cXE0Uk5jZEZSNFhhbUY5N0FIRmduZk1qcDAvZGFRc1FnSWFCSjdEUnc4YW1O?=
 =?utf-8?B?M1BEeDZNNE1PejJmUk8xWlpPOEZTeklVVmRyL3NHYXhCKzYzOU9acUZWRk1H?=
 =?utf-8?B?TTYxL0VsOGl3M3ozSzY4S1VhVXVGc3lHNWhhZDgydnUrcnA0RjlxcW1nK0VQ?=
 =?utf-8?B?Z3V2M1Y3RWpDZnBZY3B2M2ZFdjUyL1hxdUp6M3BaV2lnODBhVEdKZWc2NDNM?=
 =?utf-8?B?d1dwUmZtUStVaHg2L2JaaDZuNUlKQTFja0VMOWV0Z2hvNmVpbHJzR3dYb2oz?=
 =?utf-8?B?UEliVTloMm5UU2hiL3FDejRBVTkrOWNoMHFRQXdYem5oN3NSVHlLdnUzb1Vn?=
 =?utf-8?B?cVhIanIxUndScDUxVENmRk03emNzL0w1WnBHOXBQK0tWbHpIaktFd1hwWHRu?=
 =?utf-8?B?Rk1JUkx4NncvM3JFdkRYVWlpbWdwM1JTZENqeGlBODdwWjJOWGN4MWdJTTlv?=
 =?utf-8?B?RlM1RjFxanZVSW0rSnpXTTJOMmlIMXlvNDVZaGpqRHdqdTRMVmtNaWd5ZFdS?=
 =?utf-8?B?Q3JKbmNLa1ZEbjdka3VpVjZweVV3bTVhQ3JPN0dOYjYrOEx5c2RIZ2xFOTlX?=
 =?utf-8?B?aUdqWHptSUFLbm54QlkvTTNkZEJLc0hMRVJtRkZMS201QmZ2SW5BL1Ivb2gv?=
 =?utf-8?B?dnFFem12VWF6MldiY3RwRkRNZGxtbDBFVW5WVGFMSzlzbitaYW5XTXRydThK?=
 =?utf-8?B?MzFEUHIzbXhnSXpIUGEyZ1dRTTU0Vk5yTW9Yajcxc2FVUFBWZEcvY0J2b1I5?=
 =?utf-8?B?VzU3N1hLS0VUbklkMnZ1MFE4QnJBL1R6R2FQdTdmSklnYVZpVXAyUSsyNEZi?=
 =?utf-8?B?SzVTQWw3RmlncDVFQ3RFaDNlMFl5dEVGclBsTVVDQjhLNENtaVhpMW1oSEl2?=
 =?utf-8?B?WlR6YnhqQkh3c0ZMZmV4OHUxMmM4blhXWlF0eGVXeVp3UC9kcmoyRytDVkRE?=
 =?utf-8?B?QlRyZWsxSEpyUENldHp0d2U3YngwWUxsRHd0UE5GVHhJUXozVUNmUTd3M3hF?=
 =?utf-8?B?QnRxY20xcDV4Z2EydVJlRTBqK3pMUWo4b0htZE5BMGJxeUgwYTM3NDRtZ3c3?=
 =?utf-8?B?dERVSFBjU2tGUzFSbDRLVU1ISDdLVTNYWW9pYndudUUwSFVvVTM3VFc4NVM2?=
 =?utf-8?B?dnNiTXZoNVpCTHF6MllzUS9xMThnTGtvZzNGMS9relFramE3N2t6T1hONEEz?=
 =?utf-8?B?RDFkS2huNmZUS2UxZ3dMNVRzenhrUUFSZkpqdkRNK09NVElJeVFUbVMzejBp?=
 =?utf-8?B?bllJMitwL1A0bmhOcVpQbExNWDdibzdtN0dqYW5RNC9JVW9JdTVyUEgwRkJU?=
 =?utf-8?B?dk55K3g1SXR2RE55K05VZUhDT2pCQUdFciswNlFwTk1pRG5TNTZCVW80ZXpB?=
 =?utf-8?B?ZldDUDlodzREdzRrVTBGR0NrdTByOFgvblNXdjVIZFc3TnR0Mkswc0J1SUhE?=
 =?utf-8?B?RERudjZMb0JxcmdLL05WK0lLNlg3YisyWEJPMk1jN2EyTStOWTNLMmU2NGNa?=
 =?utf-8?B?by9BMjYweWNSRUlQUmpGZm9neFFVY3hxNnNQR2k2Q0RoRFpLS3VNQmNsRGdh?=
 =?utf-8?B?bjZwSVNPc00xeXMwTHdWYlJRTUoyaG4wczNuMlRjalk1UDJ1blZKWXhVL21s?=
 =?utf-8?B?K2daazEyUzJWMXVPdDVWS1lpVWgvdTNOT1hSNDlsaVgvazdGcWVXR3F1bXZl?=
 =?utf-8?B?dys0bGZFSWl4T3BDaCtmcnA3Z2pabnZ6VFJmNHByQ29jeGhTWEhSTVhSaTRG?=
 =?utf-8?B?cW9NMTBIaldCejZRbVFQTkhLVmFlK2pJL1lqZTFZZDRsRmg1ZjhBb21MWk5x?=
 =?utf-8?B?V3dVMjE2ajRNR0w4NTNtRWJsRjhYdTB4QmdDeUFRTk9CbWhxMUd6UkhnbG5x?=
 =?utf-8?B?SVhWelhpbjEzYXREMm4yaXZvNTZjb1kxc0ZQZ3pXZG5nVDIyVGNRTWV0VHph?=
 =?utf-8?B?NEVtWjAwelZXN3BJSU9ia2pjaWRmWkNkZ0JmKzh2UjJGSnZGVFF4bFZ0RFl5?=
 =?utf-8?B?TDk3VjFqUXlwOG9OWHZCd1JkZGlFU0RzWFNJODRleG1lK1Awb0NKaGVNZGdu?=
 =?utf-8?Q?V0OEWgP/1UIjTtkaMr/gGgrC2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yRRDLAlRZoJ2jst4Yf+YzwoLDM3Wbtc2m1hODdeLr1xAiruIxlkvs+g+5ZvHSV3nTrJf7fA9PrbvWmVU1VaxxF5pPKVoJYTkO1x94+yLj+nlukic/MnnuvrFStikeI1FmJdmnbV6cPF3mDKQhLSJp/hidAXgxfT9OVGagXhO0a3xrdL54Vn58iKEelolj9YR7lLI05pa5NR6bTKm46QzvzGPVpmbxtT1AqWtKhjiCTS53vwrit0urxd+Qil/0/SWDBMzsSBdzXv+CJ3AwTL5p8463x20nxGTGnWJicpfJS8Snox/rcFiaOn+Dn02iy+Go0gOtyaBt1O6VA71rYduuqF0FKE2u2oXKQVCmlTOp+prqEZ9xXPGQ+BhI5LB0grUSscsVibXrHoCtCnAojuKgaC4w85bBvJ305sMxNryOx8P/siS0757J6Q1qdQt7IhYtbDx3H6WsQaB2HZWXLknFeM87L/9oG+B5GaFeR21NWNVG1mjQm1lsrIcLRQT/O/owM56/nbBU1/GnjAJm/us9tl0oriAr2sJFft83IHyLE1vifDO9v0mC/zQYpdp3o/axACR7V0ewBqFBgVuPD2nYldY572xsrAEPIJABnIKqC99u6Z8TcYBrZw7d09wpyszRtZKG8UYKKUhgfM3ttjHcLF/KvUTI4sM/QLJ11V0Rvp4IehWNApPU5FaFi/MWjX42sDXtd/dtHnCs1UuwPteXAP3c9uzLolIZt9NDDD1ZJfCczAYvpB1x4OLDHIHDYsEkVKOk2Fn4CNgYV2eMbG10Q==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08888aca-e1df-40b4-3b81-08db77d3a242
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 12:31:45.0344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMq4uafsQelTau+s8G+XQyA/N6tUzt+TYnVZeY29fPM+d43ZhILy71ifAaKZhpWSeFxAceLvcJmpNF3XM8DrSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5048
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=prvs=5364a0850=roger.pau@citrix.com;
 helo=esa4.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Fri, Jun 23, 2023 at 03:04:21PM +0000, osstest service owner wrote:
> flight 181558 xen-unstable real [real]
> http://logs.test-lab.xenproject.org/osstest/logs/181558/
> 
> Regressions :-(
> 
> Tests which did not succeed and are blocking,
> including tests which could not be run:
>  test-amd64-amd64-xl-qcow2   21 guest-start/debian.repeat fail REGR. vs. 181545

The test failing here is hitting the assert in qemu_cond_signal() as
called by worker_thread():

#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
#1  0x00007ffff740b535 in __GI_abort () at abort.c:79
#2  0x00007ffff740b40f in __assert_fail_base (fmt=0x7ffff756cef0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x55555614abcb "cond->initialized",
    file=0x55555614ab88 "../qemu-xen-dir-remote/util/qemu-thread-posix.c", line=198, function=<optimized out>) at assert.c:92
#3  0x00007ffff74191a2 in __GI___assert_fail (assertion=0x55555614abcb "cond->initialized", file=0x55555614ab88 "../qemu-xen-dir-remote/util/qemu-thread-posix.c", line=198,
    function=0x55555614ad80 <__PRETTY_FUNCTION__.17104> "qemu_cond_signal") at assert.c:101
#4  0x0000555555f1c8d2 in qemu_cond_signal (cond=0x7fffb800db30) at ../qemu-xen-dir-remote/util/qemu-thread-posix.c:198
#5  0x0000555555f36973 in worker_thread (opaque=0x7fffb800dab0) at ../qemu-xen-dir-remote/util/thread-pool.c:129
#6  0x0000555555f1d1d2 in qemu_thread_start (args=0x7fffb8000b20) at ../qemu-xen-dir-remote/util/qemu-thread-posix.c:505
#7  0x00007ffff75b0fa3 in start_thread (arg=<optimized out>) at pthread_create.c:486
#8  0x00007ffff74e206f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

I've been trying to figure out how it can get in such state, but so
far I had no luck.  I'm not a QEMU expert, so it's probably better if
someone else could handle this.

In the failures I've seen, and the reproduction I have, the assert
triggers in the QEMU dom0 instance responsible for locally-attaching
the disk to dom0 in order to run pygrub.

This is also with QEMU 7.2, as testing with upstream QEMU is blocked
ATM, so there's a chance it has already been fixed upstream.

Thanks, Roger.

