Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED5E7BB360
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:39:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogMG-0001Ic-CR; Fri, 06 Oct 2023 04:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogMB-0001I8-Mu
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:38:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogM8-0002AV-FX
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:38:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3967sEdf013181; Fri, 6 Oct 2023 08:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Azb4XmriCEStv24NrbfHT06HaHGCVYJD4cViSHshxFg=;
 b=oFjdl0uj95/kivfA2KoPMG2xpX9/8hRMzpo38dJuxEWC+ROSF09MJSly3Md+F6xdEuf9
 Wvzl7hNoxLyRiLaU1yitjwGM8BNdON85FlQP1K3rXh9e7plB9NM8ysAndv93iBEW2512
 gNAX3G1T3SoNDQCA8e9XZ3H8qW8SZSilhynZ/EUUXHCxutNS6j8Rvj5WcJY88ALlTRdp
 fdUPrJf8/FusZV9wcQm4zUmLN8nT2uzWdtdrQtdBos7L7Vg0uV18hwzpC2EUEH1kqvIb
 oryQdd9aOWQl2ZCxNR5pMeo4In9HgJSfCeireBNSXb4kxRXBDx+NPmmaixZOdLjwJQFm aA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf4be94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:38:26 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3967U8G1003038; Fri, 6 Oct 2023 08:38:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4a9tde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEgjMAefDoYaM7xYvpVSLqx/lB0sUAiWgv94sxgJadHxykASQ7Lj5JuFd/v6wDOlxV3VobbV6t3iEfDhkKIQ3lR0oELeQaQxJ3/tF0RbRvrX86siIsGzSX8FyrrHVvZJloJ+Nz8pivrOjylLc+Jv1mhUNxgNQyfUfvZwcXJ8662u2tyZeHLXIHEIB2bmJ4TJA1sXNXo3BoLDC0h+hmCS6vv1/Agd9OxEMUlsYHe13Smd+G27NP5K7Ux/kmBp/WbAcVtEfkZ+YKUf0HtoGJwutSoEJ2nFWnpywdKm2bxD+H7rfDnO/ZKJxW4nVetXWfjaongGcqc/c9Bi9y8kfWe/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Azb4XmriCEStv24NrbfHT06HaHGCVYJD4cViSHshxFg=;
 b=TEhd49alROADm8JsnHJ/beNghS5g9TRpGBANUNAWqR5twt3ZEYreWOf/TxnPFL82GCSPgDTo5TipCXMxiwn2Hqz2Cp+RlK3iOQXgBitZfm4RdFPzx/yybJV1lDr9misPit6hqIoOk3pRROsQk9IiB9ERANV572446YqUyIF2yHOiZVmSLQ6khNl/jeTAerzQAyvsfpQx6HFxMGV2LUZdPjKAAeLKrRqb1hDkmZqHrnFtkCz8VEe8LaspLFBSi+CykQuvpdhf6KqAwEyCiPxS0SAgiG5GPcL885IIkpl3KLd4YSwe9rindhbxBOArSfphza0aeZPs1yV4yLWgoNVcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Azb4XmriCEStv24NrbfHT06HaHGCVYJD4cViSHshxFg=;
 b=RGGnsAlvXPZBmIaysPz94JGL24dpl+0Q9rSpnpUoQrqioSArtwuFugvdEzoPhOifZ9T9IunvvCVfa91KyFwh5SKkN1HeIzTsi9ol6GyIle7vANXt2ZRl+5L+JGyQuqhTWqh66JFh5z8M4Iiyfl8z8ZlWacSjBaI9aepPLtnxmh4=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM6PR10MB4378.namprd10.prod.outlook.com (2603:10b6:5:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 08:38:12 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 08:38:11 +0000
Message-ID: <db965f35-e568-44bb-9da4-2c2888928eb8@oracle.com>
Date: Fri, 6 Oct 2023 09:38:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] hw/pci: Add a pci_setup_iommu_ops() helper
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-2-joao.m.martins@oracle.com>
 <18343982-d554-61b4-fb17-b6955245e9b0@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <18343982-d554-61b4-fb17-b6955245e9b0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18)
 To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM6PR10MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3a5dbc-d6fe-4042-7a60-08dbc647930d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvJMbxDN3BIMCACxxT4sAi0oJ/YF/1XQ0RX7wUPhYj7iWZpUNecCWIErtk3KCRhK2ytnXh5UvINZ5eIf3x0ItD4lgx87cBf9w+D4NF9wrAArnYWvv9OM9ut3oREQCEZ+ke0EfsjliO/+ASM4yQse64DwMXAxD31B9DVJCNIw4NYnTFbOtMZWSTVAIUxcDyAMPlQwKZsr679zVfmVSHpGlVrf9uALTCWSLJWCPyPgXNG7y4jBXk8igmhFfAejkM92InJh9E80qlyCPu0izjt2eOMOfzWzo9zHnos1RCd6OsyH6vI/w5RgYh03EhJiXjLu8D08q2+DuQIk3BYHXXhVIjXWt0/U1j9FIU+W3oRvNwQ4McmM+PEBTG9TdZgtqkfo7nHpeEA7YaB8HaeaZUGYVuCaetxsVUIW90S9kI19wBab+yXh+3jmDlGltVoUJcPYjD5czPB2g+qGgHMcOUfmnFtOtqvfWDvjO6/937wMtcyLn8n1Y1oVdijvdvkInllSL4bLDoadWYs6m/MVNBL+nvfr0wmDJcpkZhuEjt8JmXFKC/g7585LCExjYoMjVC3+z8iHeD3ipN2lk1dRCmNI62+5hQ8cce1Ecbx9CK9r1tRaIAJ7XrH7F3ybQ39G/GdJu7+LBJmCNXCpBxNC/D7BWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(53546011)(2906002)(83380400001)(7416002)(86362001)(31696002)(38100700002)(36756003)(316002)(6512007)(41300700001)(66946007)(66476007)(66556008)(54906003)(6506007)(966005)(2616005)(6486002)(31686004)(6666004)(66574015)(8676002)(8936002)(26005)(5660300002)(478600001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azNoQ1dhbkdGVkkybFVndHdkb0cxRmN5M1hSSUx1eUJyWmN4L2paVHhySnlq?=
 =?utf-8?B?SG1zaWgzYXBIU24zbzRRTThMaUpFaFNNelQ2cG5PdDdnRE5Gd3lrTFYyRGw2?=
 =?utf-8?B?akl1UnRCMHJ6VUEwN1d4YmxBcVZSRHZZK3hvMFBvOWdJNkhINkpYUzI1cWxG?=
 =?utf-8?B?VXk3WmRTWnpmSTlhTEZiazI5dTlpVHlkK2cyK2NNNGVOMTVsc2xLQU9NUlMx?=
 =?utf-8?B?UitVYWt1MmY5Z0xBOVFnbVBRR080dGxwVGJya0ZGdXBrNjhBbnkzV2I5ODJX?=
 =?utf-8?B?cXp1djR0VEsxN09ObzdWNlE4WGNoYzlLWkxvanpGNlROb093RWNXQUpzNmw4?=
 =?utf-8?B?eFZGN1FNcHdYbTNHZjBTekMwd1hKNW9oaWp2cE9zT0FOQnVFSEduVU5xaG0y?=
 =?utf-8?B?bElWdVlFVTN0N2tUakQ0cFA4NVNpcitnSlEzQ1ZxU0U5WmpFM0RBc09nZDdo?=
 =?utf-8?B?aE1FbjA0SUVSc01xSGRpWlpiWGtjbU1yZCtZN05jQWFJaTJWV0VpcmRYdUpx?=
 =?utf-8?B?ZHhHaEtWbUU5QVN3djEzM0N6RUpWRHlBdXVQeStKWUluM2Vva1EzNUJzb3ov?=
 =?utf-8?B?aTJtbHJFem5JeG1URkl3RmpGWnR1a2YvYkdCdmdWb3FlQUNPWlRBd0pBQWlU?=
 =?utf-8?B?cS9CRWd4aGs5OVVmdGJad0lVTGplUzVybklsVStyYzQvaTE5bCtvRFBnZVhV?=
 =?utf-8?B?QXdGa0ZodnFKcVBaMnhlaW94Wm9SWXlSTGhSTDRwN1l5T3RINzM3SGNUMmJ3?=
 =?utf-8?B?SkVucy81dWpURkVkSnAzcjMvbTNCaTVtLzJFSjliNUpqNm54UEVSOEFYVUww?=
 =?utf-8?B?SEtYekVzdjhrVnJRcEJjOTZia3BpQk9CNFpuc0UwOWNvbnBwU1V1V3BXZE1H?=
 =?utf-8?B?dk5yZW4yMVUzVTdxbm9jUVhzNzRLWmVQY0RxZHFlbjlJWUZhbzBmWlIyNHd3?=
 =?utf-8?B?VmUzenVyaDRQdDNmRmlIR2hXNXB6TlZIUHBsQnNtaUJHQ2pKM0plT0JXbUJr?=
 =?utf-8?B?VUxyME5MOURZSkZTYTBQeEcwUE92OGVORk5BVm0wMDFEVkFsZm4rV01za1ZR?=
 =?utf-8?B?OTUzdnFqTVBXVDUrRGtFVjZjcVlNMmdJQTNPcGZwUUdEZFFQOVY5a1BjYkNJ?=
 =?utf-8?B?aWJ0NHVMS2lpVGo0U2c5TXZIR2RwUlJRVjFqRmdxMFNXRmduR25ybXZrWVlC?=
 =?utf-8?B?UDJ3c1JZWmxoMVlzRXJjdW1Rd3JXa2Zjck9yRDNPNkhuQk4yZ0JrYmdoaS9F?=
 =?utf-8?B?d05lREYzUXVJb2IwdGZ5UHlOeW5IbnpTT0g0SGVhM094eDVwR0VYYkdJMXlH?=
 =?utf-8?B?TFg3KzBrbWx2cVZXd1dVUGNtZHFPSys5a0dQc2lTUG1OS2JmTFI1VW02bFU1?=
 =?utf-8?B?aU1EaTR4VzV0ZzNDQkNRYi8zbk55Wjl4VEpsWFV6dC9aWjlPRHFkRWUvS2do?=
 =?utf-8?B?c1RneEVSaDMwQmJBT2Ztd0lQNGZONnZLcVYyaEpUZU9WQkt6MUtRNjByOGoy?=
 =?utf-8?B?c3c5SldWYWVsNHBhL0JOSHpUVTZWdmwwdDhwQzdDRGhpTjhXWGkvN2VtajMx?=
 =?utf-8?B?T1NKb1hDaHhXM0YrQlNWcUZxRHhjVG05TElQbU16b1Ziekh2TG5lOUQ1QnZv?=
 =?utf-8?B?K0lWZWZBTjBPa3pFcmsrS2phNVFaY3ZQYkRueDdySXRJOWF2dW12U0dDcnFj?=
 =?utf-8?B?ZGYxdlFobFZZZlE5UFNxMHdCWVRlSEZyZ04vSzVDeGRaSWhud1o5ZTZKTkIr?=
 =?utf-8?B?cTJzQ2FTaS8wQTBSM3JKaHR4anE0VFVXUWNqRVJmeEJicnZiUm4vdUZmNkk4?=
 =?utf-8?B?S0h2dEZwRkpBd24vM2RrVmRrV29nNVdYdzZSbGlWL1dUQlJOSEhDRERJQnJB?=
 =?utf-8?B?bmpJMTZ2ZmtPNUpjRFVkUjBlMTYzZ1ovZmlESlVKd1dZZFBXZDRMdWlRWnVR?=
 =?utf-8?B?VGcrZ29RU3ZZOURjRHhKRGhzQ3hNUkJPNXpERnZOTEtUNkJPRFJCdG1uWmJy?=
 =?utf-8?B?MnVYaHhjTStWREhHZEZuRUdoNGlwSmFSWW1jOUlBSG9qSjVaazhhb3c3UUlr?=
 =?utf-8?B?WjhpL09HK0lWcmVOOUM3Y0loWjBtbms5OEdCRjEzMnRhbnh6bk5UNGhOSHV0?=
 =?utf-8?B?QitHZkorTStQdURBUXRaUklsVm5GT0dQZUpJUi9raVBwZ1R3REhSUlgxOTht?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +15YweJTM4+MIZ86GLyKZMTIUyt+PjoXX4WGSudxU2U/klYnOQ8jBWUGxmRv/+NmCdKh7qL32nskziWEFvawZ4OtVFUvSbYIjevs09bjHoo2NBu+lh1VYuCLWYxGYY3Xb82vXenqP498XgEkQ8GTFFBeTGdUp2DcHqr0qpqdB2N9b94GRzLuQ55XjEXCrcuWJnSozjhnABa/IUlljPguUqp6Wj+bUg09oxkA6RYOM6gkQN0/JcOlh4i1svSIy31594zNGX1j+uvHgkU/rN/8q+zvBxaFg2hIFJyKJXTsNzY1ZD5kB4+hL3hZhhU+MGQflYHqhfg578Nit/xhytxOuaxAvq39M11zGNjNIjvxabmsClNqvBeoVRIXbK65VQkR+5OtV4FZ8EhAh0NWGPvkjizgX4aNQnSmgkNCx9HEg3nSSGVApqXxu+XX858UofttLbB2HP+aXS26Ry2YB/BX18c1uxzqZ9Pa6q2MFbkyOqUsxy9a/NmauoeH8ffS594AAkR9BiPnEPm3ipkXZLhUrX9X+aXzDGmz/b1q9bM+4A0RgfLRCaIrg65vp7Eh77JX5uW79gbMKLXlo76RtVeT2O7cqCWGXvCwnps3D7GCvaxzUT9ufQwHvLunzRMQEC7D6zjKJ+GJZn7vSv/tzJDj+13RKY8y7naDSIfW/fzvHLFcByku1eayOcs0QRi4yOZvu9b01CD70bS1BRX0xb/RPNbVPZ9vuieKJMtxnlBARiSpoeodbhnqx1fl6zWgdAsypmc7JnfSwbJZMpJ8KR3VoXMlt2ijjg7YA7dqFu4AqCzyzwUkurm6n0cVrVMWXOvl3SeVSRnz7mgbAqlS2Fxwkoryr//Clw1+q0B1lDiONfexen0Vri3u/6MW61blwAdPRjxntgdrPNKaqlDDIv9LoKuzVjjeeaGNbHNzCmB9z/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3a5dbc-d6fe-4042-7a60-08dbc647930d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 08:38:11.9038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7kxCtJQFJTjWxnkwuxSPAK/qR8GQTJCy9Oh2igjroBRP7T3AWMZ9UoPlVLvcZ9l0TCfHc613mXXEuStstsyHkjHkvuts1YXuhuMWRlbVHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_06,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060061
X-Proofpoint-GUID: Pobqvg-hS7V14zq2I8V9mic9IJ9DqkjT
X-Proofpoint-ORIG-GUID: Pobqvg-hS7V14zq2I8V9mic9IJ9DqkjT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 02/10/2023 16:12, Cédric Le Goater wrote:
> Hello Joao,
> 
> On 6/22/23 23:48, Joao Martins wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>>
>> Add a pci_setup_iommu_ops() that uses a newly added structure
>> (PCIIOMMUOps) instead of using PCIIOMMUFunc. The old pci_setup_iommu()
>> that uses PCIIOMMUFunc is still kept for other IOMMUs to get an
>> an address space for a PCI device in vendor specific way.
>>
>> In preparation to expand to supplying vIOMMU attributes, add a
>> alternate helper pci_setup_iommu_ops() to setup the PCI device IOMMU.
>> For now the PCIIOMMUOps just defines the address_space, but it will
>> be extended to have another callback.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> [joao: Massage commit message and subject, and make it a complementary
>> rather than changing every single consumer of pci_setup_iommu()]
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> v1: https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
>> ---
>>   include/hw/pci/pci.h     |  7 +++++++
>>   include/hw/pci/pci_bus.h |  1 +
>>   hw/pci/pci.c             | 26 +++++++++++++++++++++++---
>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index e6d0574a2999..f59aef5a329a 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -368,6 +368,13 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *,
>> int);
>>   AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>>   void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>>   +typedef struct PCIIOMMUOps PCIIOMMUOps;
>> +struct PCIIOMMUOps {
>> +    AddressSpace * (*get_address_space)(PCIBus *bus,
>> +                                void *opaque, int32_t devfn);
>> +};
>> +void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void
>> *opaque);
>> +
> 
> I think you should first convert all PHBs to PCIIOMMUOps to avoid all the
> tests as below and adapt pci_setup_iommu_ops() with the new parameter.
> 

OK, that's Yi's original patch:

https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/

I went with this one is that 1) it might take eons to get every single IOMMU
maintainer ack; and 2) it would allow each IOMMU to move at its own speed
specially as I can't test most of the other ones. essentially iterative, rather
than invasive change? Does that make sense?

	Joao

