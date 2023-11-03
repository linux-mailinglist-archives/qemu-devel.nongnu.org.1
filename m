Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A97E0A42
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 21:21:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0dw-00050J-SY; Fri, 03 Nov 2023 16:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qz0dr-0004zp-IG
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:19:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qz0do-00020c-VD
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:19:43 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A3G7PZg014659; Fri, 3 Nov 2023 20:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+yaGsLWZamB4bR71jb4v60jW0eb+YynKd3j9/fiAYa8=;
 b=MIVB0gLo9++WQcKKgJfWsaBYGOYpzAV/nOZ22MzFC3WPN/ZBUnS5IC847JwI6/X9hahi
 S6yecHMrDQp6TERKlM52LTf6vqkBJ8NB2hAO45phhVHXQqnJRXrUZwIQCru7yhCeGIOl
 3EbxZFeDFUjIZKSNVdC8GHo3zL0P0S/8x/bB5vV4EQZv7Sxg15oMoIDWQ5nOyg4c/H9L
 4pKqO5rmu+J/tDXM5Rzy2t4lhFwyuUgA21fND0CzkwnxJEZKhurR4U8D0QGIGMDfxj3I
 7WxmgtC1E2ocIl7MJQ2Ws8FojmijwVjjpH7xug/IN9N4VXmJVWbWlDQ2ucEjehzeg5Ap JQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6bcp02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 20:19:33 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A3ImETT009173; Fri, 3 Nov 2023 20:19:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u14xaevhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 20:19:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL5Va8/Aq6l3dw3dXLyadhRhI9ANETkH7uL8kF2Lg86aXD3T6is1z4NzJRGAA1MWGykuUraiXyMHWf3cQFEULl/mO4jTEvL6M8ZdQsQexOs5afKNNSrFAice/OUdz9KouyxvpYgmeLJp04zkOf6D8IFBSXiDCt1003U6L3eVj//vSLWyWBnIrtO1RrMG5ccYNOTFe8ll8icve74fNHCN2mazsyGWaT8l9M6PyLsXXAStiquSMv6p8XtJpbDVrdZTAjypsH2wwo2efSCqKRXu9jtSP1dKNZHukqyh3UI3AFdM+AZLp0CxdCtSCxk9PtwhQoGkCjq3rDsceLEfF1dVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yaGsLWZamB4bR71jb4v60jW0eb+YynKd3j9/fiAYa8=;
 b=lQLAkWynFGKryFcU/fIUfZmRGp87ZdhShqPQHWfCkP0Uc8vG2h4VzLpJWWasFKJ9W8l6CebsfiRGH2XInagI9OJbkG+BSmvwqhkmKYBBNCiGxbnocPC/64ETH4mESKBETf8dPZ+639luX5zcEu5iOykkOlKtOJt4KQzmLdSvIz8gbBaXYmaHTRXQb2ETxYQ3BaAjbu+Vuzn7zoYKDzJ6FREIO1gxDMD0/0ac7EKmNrwc0/uzxozUDu+4Kfj+eevnCx4LX6KHlLy5QX9d7+2lVWEQ3ERMwuqGAlvg62zO75fjc+80GSZhNWc0VvUzuwrqSgFk4I/GD3BkMkOE1nwiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yaGsLWZamB4bR71jb4v60jW0eb+YynKd3j9/fiAYa8=;
 b=Y+WiefENCbU0LyCRYbZamdFh4BjAn8ODPti/iaKJ+pH2Tk44pjFrK/hiYq4WI+Geb1G6KNpNiMogK6OpMEmZA6vukXsu7ColuOmP0HnNUF0VZN2zyPJU4TsjZqRiVAJ2/7n1vA3KLUYUikBI4o2ob872xZ7fepNsFyjE2ii2gfA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM6PR10MB4315.namprd10.prod.outlook.com (2603:10b6:5:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 20:19:28 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 20:19:27 +0000
Message-ID: <b4cdaabd-45b1-4ff7-a267-05230a754588@oracle.com>
Date: Fri, 3 Nov 2023 13:19:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] Map memory at destination .load_setup in
 vDPA-net migration
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Shannon <shannon.nelson@amd.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gautam Dawar <gdawar@xilinx.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <1e565b27-2897-4063-8eff-e42cfd5934c2@oracle.com>
 <CAJaqyWeOG0Eoc8W9FYFzJ9r1ENd3Cd1oLGF=ggJvWth2xD6u9A@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeOG0Eoc8W9FYFzJ9r1ENd3Cd1oLGF=ggJvWth2xD6u9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::18) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM6PR10MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 22410ff0-914b-43a0-5b20-08dbdcaa2dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Re/rSEjJ9eFnMW3o5NUFvPXewIT97eaUL4uIticYNwm0P8ya6dTraKYzgkYZTBAXqaP4jWy/O+egVplEIpPtjLJw7M0/Cy93g5QTkrUdDYB6YcHau13leWI639GPa8pZ4DXSkWpBqGgEN8dTaJvtWxD2tclIkAjLJd3DZPSNdeQJt4pJgVJl8vjKEfbY+sUNTWZ4jJsrnH+kznhxSEOWlH2jganKp72WYD9jL3k4lFgBeCyF1t6LcrA6qk8ZZ2Rx2LZydQNoIk1W3Sb+pvWjeFAkhRsg34WYdTaL9SpQ711EaQuxMsqOn9eIBgFSR4cc3WvGYNRXS37EGlaDVNNjbXD1IgddDxscyNNnu8bxpSo7lq4MCpI8Erw13+bzghk1m8fCZnfbiM0k0FcZ92IwxcKz+WXB95GGx15gsxCWa8k0H0i/LvJVTUz/5HLGN5rQ4ALE2onjlB1MKwpGZXSTbKP4rHqx6zavzWhc9yeBYeQkeNcPq8bsK+H2mqHrMME/WGZalwU5osouLymRe5sLKrAIBXBX6jGHvG9wJ0um2h6irnJyBdW/ly2rpZXwHIOvMsalKIfhdsPmaVDG5sOwdhRZO6axLlUtZKoCJ7uCRM7jBJK1s4Y6cQwvy0j7chnbpnmWDFsnmogAEPhms86syzqd+xdtWaQVJHloRamvWaCGbuB7D7nkxPr8ytiArekEI2FGPEynjRh2R+AuYqa3iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66574015)(2616005)(66899024)(6916009)(26005)(8936002)(31696002)(41300700001)(8676002)(2906002)(86362001)(966005)(6486002)(7416002)(66556008)(478600001)(66946007)(54906003)(66476007)(316002)(4326008)(36756003)(6512007)(36916002)(6506007)(6666004)(5660300002)(53546011)(31686004)(83380400001)(38100700002)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEdRVmcwUWpTd0RQMDlhU2JPKytVeUJzVVlEVXduY2FxKzZYRUpGZERydG8r?=
 =?utf-8?B?c0tGU2JFQWgxRlZUd24zamtXT1ZZdzZlR0FFU09jL3h6UFg3akpSdEcyQk9I?=
 =?utf-8?B?WS96YXNBbjE3QW5sSTh6MFUxbnFaNnIxNW5HVzdiWWdIUFZzZkg3RmdZV3o3?=
 =?utf-8?B?alBFa05XNXdLSmhpNmhNbUJaUFUzOFpnWXZ5OExkMzVZSDl3dHFuRHV5SStU?=
 =?utf-8?B?dHZVaXQzQlh5bjRMeHA0Y2k4MzZXdW1wSlNBMldLTlU0OXIzVnJYN24ya3lY?=
 =?utf-8?B?L0dhZUoxd1Zjc2x1RXdHbStNQ2w4eTJtUklMUDhHT3ZlTmREQXNaRVNWd1Qy?=
 =?utf-8?B?VkQrdE9EYXYvaVdXMU5KRmV3SXNGdjlnejJGeTd3eElpbytxYUhCeUNMekpy?=
 =?utf-8?B?RkZGdGhxODBRWmI0UW1RcEtRSXJsdHFoRFA0UlVBMVZQY0RCSlBoMEVIOWs0?=
 =?utf-8?B?YkdGb3c1R0NMWnFFNVRtMmRSakVMKzdZQWRpYXUxVHI0SG96cTcvemtld1c2?=
 =?utf-8?B?ODZJN1FiMnVsZkx2dWt4NFgwU0xpZElSaGNHNXdTSkh4WGovOUc2MmZIdXdG?=
 =?utf-8?B?RGJnVFp3NWxrRnpRWUVzYnpvaWZuN2VHcXZhT2Z4MTJMYzd1b2NvVUZvdmRI?=
 =?utf-8?B?L3dmZjF1L3JpREdXUTZMRjh5b2NQb0RXaEY0aW55UzBzMDlPYjNBeGQ1bFdz?=
 =?utf-8?B?NVFYVXpoS1RmcWNrZDEwM01QY1hCS3dLN09NVzZTMGJSSGpHVWp2d0dBUnR4?=
 =?utf-8?B?Y0V2aVpiOTJYYk0yWGdtSVFuQnVOMkMzQlFqOFZZMWRpK1F0LzJMV1pkNWdn?=
 =?utf-8?B?WFQ5TzlpWmd2SHY2Qk1BWVozMU9FTCtqN2xSb0cvZUY4Y3EwUjdudld0TWFp?=
 =?utf-8?B?WDJpVmcrcnpIeEFaNmlyY3pmeTdwYzJWYy9UcXZuM2xDRjN1ekJpekIrbUUx?=
 =?utf-8?B?OTRnOUN6ZEFlRUdaOVhzZUFKK1ZocVFScUdJbXpmcnJGUXo2OHd6TG5kOEFa?=
 =?utf-8?B?NXZBaXl3eE1wU2hoM1dubnhEczdveko4RTAxaWVwck9XVEQ1RXk1TGJkMWVO?=
 =?utf-8?B?V2dFL3N5UkVlZUpOUEFoTEtlVmdoR2ZpNzZwT0FTdkoveGNmb2o5UlpDVVFY?=
 =?utf-8?B?RS95NmtqdElIdmVrTmRvVTBMc0Fwcm1wTW9Fbm9pc1dNMENvc0FPN05XVUph?=
 =?utf-8?B?dHFZVzlGSkwrRG5uN215dkFxM1QwOTFyTUo4czVlc0xacm0vWkZadzN5STkz?=
 =?utf-8?B?VHFHZXB1bzRPQlpReXRYdjZDbXRuOSt4NVd1cEluWGdpT0dXQlZTcVVUVW9C?=
 =?utf-8?B?emlpUVRxdlN5V2wwdUQrV3FaYWVoUVpBZ2ZORmdwbkR4TldDNU5FZENkK0ls?=
 =?utf-8?B?b29aSzlOWk9hRDRBMERvSmdTYXFEUVY4NlkwODF2S240cnI5dnA5MWRObTU0?=
 =?utf-8?B?MVkyQVFVM000L01NbzUrellseE5tRE9waEJwRlpMQ3dqMzF2UHdydHpWMEo4?=
 =?utf-8?B?VnpPT0NLSDM3L2grWVN6MUdaMVZhdE0wdDZyZG5HaEZyR1RiYnhvSlZRQmVP?=
 =?utf-8?B?SzdpajdUMzdvL2FmZ25OcU1PK2w2RHFjVC9TaTZaT2pjbkk2R3RWdWZXbGN2?=
 =?utf-8?B?ejFaRk5WTEliWkV0aHQ5RWoxQzI3QWl2QWlYK2lIUEpoZTVMMnJ2NHdENlNV?=
 =?utf-8?B?K1lyOFFCdjJvdGF6bGdydll4cEdGU3UvY3J2QU5VcWhXZ244cGRWL3hRbUo5?=
 =?utf-8?B?T2lRUjZCRkoxK2FmVEx0aUhwUDVRNmhMb0RIMWZGZkx4NGlscHlFTHJ2M20z?=
 =?utf-8?B?L2Y4cTd2ZWJlbHc1cWJYdTJITUNWeVpjeXIvZXlaTXJmS2VMZkZTbFFGQXMr?=
 =?utf-8?B?bGVHQnRGOHpqL2VVanV1bGk1ckcrUVFaTFo5R3g4S0czbjBVREphVkJNRHdW?=
 =?utf-8?B?YkRYS3dteFNGc2s1WXR2UDlBRlFTa1RvTC9Yb3F1NFR2UVZLVXljZFFlWG9N?=
 =?utf-8?B?aXlkdXl4Zk0vR21QQ1RoQjEzUGZUZEZmaTlkbXJTVmgxMFRvUXJxYS9BY1Qy?=
 =?utf-8?B?MFhuZnA0aDZ6cjV6aGZSeElsRTZqYzl0blFtekFJc09qOTkwdzBFZHdnMFlP?=
 =?utf-8?Q?zeKuZO/ozNyKtku1p5HkpPbp3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L01iOWJjREhlUkdoUnlISFhKRmZZd1Y5SlE1NlZmTDR0aUpmQ3ZqOGxSaTdB?=
 =?utf-8?B?SFpqN3VIeXUxTVY3Q2I1TGRyN2lIVktRVGlOZFBXWFJLV2Q0M2JZVUdYR3B0?=
 =?utf-8?B?cmRYVHBqM1I3cHBCaUE0OUFnR3lyWVM3M3VnUlFkUVFVckEySkVidXJ0Ty92?=
 =?utf-8?B?OWJyZ2lQdVVKbUdwU1E2bk0vNCtUeERKbEdmclhYVTBOTlpxUWdTZkNoS2Vi?=
 =?utf-8?B?OGhMbWduck4vVDFRSTBySkY5d2FyeXhoQ052bDlpQklod2dvWVNaT1EyQzFO?=
 =?utf-8?B?QjNvcWdCSTNLWkZBTUZ0bDgxUUwyQUQzVnVJcFZHZ29EWEo1S2pKc0s1WHU4?=
 =?utf-8?B?TUNkMkxGZzVXbWRoKzFiZ0YwQzN2QVNDRHdtS0N3UDRwZDBtN201RmpGeXBm?=
 =?utf-8?B?ZVFuelBraHRUcWRyZWdDU2tHNGFWOVJKV1pYcStQL0RWRzc5b3VEdWhEM3hS?=
 =?utf-8?B?a0dCSTQ1by82MHhZcjgvU1NRR0ZJZHRXeVpVMmxWZTc5bTQwc3A5anJvMnc3?=
 =?utf-8?B?SXE0MmttaDJQZGg0ZGVwT1R6L08yNU0vbFBPeEJHY3VRWURrd0NOWk5Lcmpi?=
 =?utf-8?B?d2xIK2V5WHVPcHV1ak14R2dwVm4xbjJGK3NveGN1N0lRVitNb25KUU5SNXVr?=
 =?utf-8?B?QWJ1WXFlOWlMOUF5b255MUVGU0VYaXpDenRMbmlxVVZpek81VjV5VDNVVFFH?=
 =?utf-8?B?aGk4a3MzSWdxNUZlWXhhY3hSM2hiTTlmYW0vOVR5V2MySEdVVlRZUEc4MnFC?=
 =?utf-8?B?K3dRb3I1Tmg3clk3UGtVdHZObzBjdXBtNkxUWExWSHFQWi9wS2pMRElZWDFk?=
 =?utf-8?B?TFEyNHFlYk4waCtUTHQ3cU9oVlc1ZlptU25LS3lFcTVSbFZuUVJINGQxVUQ0?=
 =?utf-8?B?QmpadDFicWhLeWVsd1EyZTVVTHVQYmRJdVFwcjhuUmFqc3ErUE5BLzlVaGVw?=
 =?utf-8?B?c0R5TmcwOWFIUkJ4NDJwQ3E0NnN0TFd2SS8vWjZzNXhBSmgyZnN1bW9EME02?=
 =?utf-8?B?bWFwMFRDVStmKzRhNDBQRC9Dcmw3T1R5UXhxUEl1UEZHZFI4OThreDlWamp3?=
 =?utf-8?B?b2U0WXJiMGNHdWlZT2J1cG5Tay8wQnluVDFMWGx6QlJ5WTErNHhwT2N4dEts?=
 =?utf-8?B?eGFEckRKa3JtK3M0aDI5cSt3YXJuOExiQ040cFRaK085cEUyUldvQ2xZMzhW?=
 =?utf-8?B?WnNqdEZ1c25kaUowMWFZYnNQbDB2clZneXFyS3lOOVVxbXBVVW5ySDJOM2xT?=
 =?utf-8?Q?szz8dh38OXOivuJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22410ff0-914b-43a0-5b20-08dbdcaa2dee
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 20:19:27.8512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHTWHyr0QtjkFTUE1mAdWniAeRqnlhR/oi/ijsLdSKheyqfgJrg51bQ0Gxeun2zJbmKExT3jIK/mmsBR+u+ENA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_19,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030171
X-Proofpoint-GUID: NnYzv4sWNHR9eSSdCx5XJ2UyhOj9EQG0
X-Proofpoint-ORIG-GUID: NnYzv4sWNHR9eSSdCx5XJ2UyhOj9EQG0
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 11/2/2023 5:37 AM, Eugenio Perez Martin wrote:
> On Thu, Nov 2, 2023 at 11:13 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/19/2023 7:34 AM, Eugenio Pérez wrote:
>>> Current memory operations like pinning may take a lot of time at the
>>>
>>> destination.  Currently they are done after the source of the migration is
>>>
>>> stopped, and before the workload is resumed at the destination.  This is a
>>>
>>> period where neigher traffic can flow, nor the VM workload can continue
>>>
>>> (downtime).
>>>
>>>
>>>
>>> We can do better as we know the memory layout of the guest RAM at the
>>>
>>> destination from the moment the migration starts.  Moving that operation allows
>>>
>>> QEMU to communicate the kernel the maps while the workload is still running in
>>>
>>> the source, so Linux can start mapping them.  Ideally, all IOMMU is configured,
>>>
>>> but if the vDPA parent driver uses on-chip IOMMU and .set_map we're still
>>>
>>> saving all the pinning time.
>> I get what you want to say, though not sure how pinning is relevant to
>> on-chip IOMMU and .set_map here, essentially pinning is required for all
>> parent vdpa drivers that perform DMA hence don't want VM pages to move
>> around.
> Basically highlighting that the work done under .set_map is not only
> pinning, but it is a significant fraction on it. It can be reworded or
> deleted for sure.
>
>>>
>>>
>>> Note that further devices setup at the end of the migration may alter the guest
>>>
>>> memory layout. But same as the previous point, many operations are still done
>>>
>>> incrementally, like memory pinning, so we're saving time anyway.
>>>
>>>
>>>
>>> The first bunch of patches just reorganizes the code, so memory related
>>>
>>> operation parameters are shared between all vhost_vdpa devices.  This is
>>>
>>> because the destination does not know what vhost_vdpa struct will have the
>>>
>>> registered listener member, so it is easier to place them in a shared struct
>>>
>>> rather to keep them in vhost_vdpa struct.  Future version may squash or omit
>>>
>>> these patches.
>> It looks this VhostVDPAShared facility (patch 1-13) is also what I need
>> in my SVQ descriptor group series [*], for which I've built similar
>> construct there. If possible please try to merge this in ASAP. I'll
>> rework my series on top of that.
>>
>> [*]
>> https://github.com/siwliu-kernel/qemu/commit/813518354af5ee8a6e867b2bf7dff3d6004fbcd5
>>
> I can send it individually, for sure.
>
> MST, Jason, can this first part be merged? It doesn't add a lot by
> itself but it helps pave the way for future changes.
If it cannot, it doesn't matter. I can pick it from here and get my 
series posted with your patches 1-13 applied upfront. This should work, 
I think?

>>>
>>>
>>> Only tested with vdpa_sim. I'm sending this before full benchmark, as some work
>>>
>>> like [1] can be based on it, and Si-Wei agreed on benchmark this series with
>>>
>>> his experience.
>> Haven't done the full benchmark compared to pre-map at destination yet,
>> though an observation is that the destination QEMU seems very easy to
>> get stuck for very long time while in mid of pinning pages. During this
>> period, any client doing read-only QMP query or executing HMP info
>> command got frozen indefinitely (subject to how large size the memory is
>> being pinned). Is it possible to unblock those QMP request or HMP
>> command from being executed (at least the read-only ones) while in
>> migration? Yield from the load_setup corourtine and spawn another thread?
>>
> Ok, I wasn't aware of that.
>
> I think we cannot yield in a coroutine and wait for an ioctl.
I was wondering if we need a separate coroutine out of the general 
migration path to support this special code without overloading 
load_setup or its callers. For instance, unblock the source from sending 
guest rams while allow destination pin pages in parallel should be 
possible.

Regardless, a separate thread is needed to carry out all the heavy 
lifting, i.e. ioctl(2) or write(2) syscalls to map&pin pages.


> One
> option that came to my mind is to effectively use another thread, and
> use a POSIX barrier (or equivalent on glib / QEMU) before finishing
> the migration.
Yes, a separate thread is needed anyway.

>   I'm not sure if there are more points where we can
> check the barrier and tell the migration to continue or stop though.
I think there is, for e.g. what if the dma_map fails. There must be a 
check point for that.

>
> Another option is to effectively start doing these ioctls in an
> asynchronous way, io_uring cmds like, but I'd like to achieve this
> first.
Yes, io_uring or any async API could be another option. Though this 
needs new uAPI through additional kernel facility to support. Anyway, 
it's up to you to decide. :)

Regards,
-Siwei
>> Having said, not sure if .load_setup is a good fit for what we want to
>> do. Searching all current users of .load_setup, either the job can be
>> done instantly or the task is time bound without trapping into kernel
>> for too long. Maybe pinning is too special use case here...
>>
>> -Siwei
>>>
>>>
>>> Future directions on top of this series may include:
>>>
>>> * Iterative migration of virtio-net devices, as it may reduce downtime per [1].
>>>
>>>     vhost-vdpa net can apply the configuration through CVQ in the destination
>>>
>>>     while the source is still migrating.
>>>
>>> * Move more things ahead of migration time, like DRIVER_OK.
>>>
>>> * Check that the devices of the destination are valid, and cancel the migration
>>>
>>>     in case it is not.
>>>
>>>
>>>
>>> [1] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/
>>>
>>>
>>>
>>> Eugenio Pérez (18):
>>>
>>>     vdpa: add VhostVDPAShared
>>>
>>>     vdpa: move iova tree to the shared struct
>>>
>>>     vdpa: move iova_range to vhost_vdpa_shared
>>>
>>>     vdpa: move shadow_data to vhost_vdpa_shared
>>>
>>>     vdpa: use vdpa shared for tracing
>>>
>>>     vdpa: move file descriptor to vhost_vdpa_shared
>>>
>>>     vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
>>>
>>>     vdpa: move backend_cap to vhost_vdpa_shared
>>>
>>>     vdpa: remove msg type of vhost_vdpa
>>>
>>>     vdpa: move iommu_list to vhost_vdpa_shared
>>>
>>>     vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
>>>
>>>     vdpa: use dev_shared in vdpa_iommu
>>>
>>>     vdpa: move memory listener to vhost_vdpa_shared
>>>
>>>     vdpa: do not set virtio status bits if unneeded
>>>
>>>     vdpa: add vhost_vdpa_load_setup
>>>
>>>     vdpa: add vhost_vdpa_net_load_setup NetClient callback
>>>
>>>     vdpa: use shadow_data instead of first device v->shadow_vqs_enabled
>>>
>>>     virtio_net: register incremental migration handlers
>>>
>>>
>>>
>>>    include/hw/virtio/vhost-vdpa.h |  43 +++++---
>>>
>>>    include/net/net.h              |   4 +
>>>
>>>    hw/net/virtio-net.c            |  23 +++++
>>>
>>>    hw/virtio/vdpa-dev.c           |   7 +-
>>>
>>>    hw/virtio/vhost-vdpa.c         | 183 ++++++++++++++++++---------------
>>>
>>>    net/vhost-vdpa.c               | 127 ++++++++++++-----------
>>>
>>>    hw/virtio/trace-events         |  14 +--
>>>
>>>    7 files changed, 239 insertions(+), 162 deletions(-)
>>>
>>>
>>>


