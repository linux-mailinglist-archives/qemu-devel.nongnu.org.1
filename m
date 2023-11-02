Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DCD7DEE53
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 09:49:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyTNk-0005rp-6g; Thu, 02 Nov 2023 04:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qyTNi-0005qY-CF
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:48:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qyTNf-00023m-GI
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:48:50 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A283N6F015629; Thu, 2 Nov 2023 08:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MrnqzSLT3vH668LMQfwCDlrpU4Yhk36hJxoYQThRC20=;
 b=iJOX2vW23xSnScDvP7kTvNJG/0NTHn9/IKIJVyOsFM2emPYd+Pw3ORPki8TV8nOaXKUS
 VSLSmIaW2xEQQmbHH4gVOk9OaxhfrPAFe1drxrO74awy0pVuFFCY3Fj4RrKfcYkEMoov
 1wWotv6pS/+awOogP8o9ua/c4MpRu+xgqIwLdfo1J5iMBGZM1od7xF8VPal2Yw573v/8
 q0FTRCgOe2rsRRGHW3iAJ5c2mALGICfl369zn+m7utS0rMUEkYStj43wzM+fZMZm/1KJ
 5rwaYDMF8fYcZUvidML+43BQRsJO1O/aP2ebXqrNmoOTLnjt9dOATQV8cZd9ca/t4PBF xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7c16sp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 08:48:38 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A27mW3V020109; Thu, 2 Nov 2023 08:48:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rrefavq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 08:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adKLlpG7rruTxLzh4z/wUVJY8cpG+WvmXcwOEVA5ZTEAjwygMLXSTX0z5jqN0T94ywiC+0ZqWSf402lzaD+FEvJfgKtP3unl32/IiYLGvMc4L95tV1mC21QBabEATcttS1AdORzv0rPIVLK/aeYDbyowy7S5Qud6qis/AQ8PqqFV5k33gAttb7cbk1SPNGLv7lPr8WVYKdHGY2ti+F/0PxyoY1faVZzvflUwoNKOzAVkNZEtsZ0R7TELif2jrR7lXAhzH6yTyBCdwSxOMyjJ6ocOBf8UQf+K2tUNhFdbLx7xAEr/94Pn7JkXMnwR1byRAuFYLqwf1Pri5JHXhw1ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrnqzSLT3vH668LMQfwCDlrpU4Yhk36hJxoYQThRC20=;
 b=fz9DTRbNN2+TEvwAFh0r2eWvoqpZET4QrWCNRaKG7coY/QbTYRosssydUnggxq98e/YYC2i56NMbTKcVtoxdZK/Rzo5/jvRUst5o6FaY9JGfjvhy3OW5ErFDVSNQt7iS6VjAHvlE3rPv2PqmgI6lDf8Yr0ZGrNvTV7KmyAZkUaDw1oKaJCznR4/1vdIjwqz93jxGObdGRVNg5sQuus/zdktrcB64paeUQhNXy+JK34sgcV1Q8DnyiY/12S8JXHagx6p1Ob7RjpSIRm3EgNJw8l4blXl/GoEODkxe+9S2Cl63nxiD17R5Tq8yytvZorzMuHiQhtvsvMYbzp1mAQ6b/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrnqzSLT3vH668LMQfwCDlrpU4Yhk36hJxoYQThRC20=;
 b=CjaQF3hUca2QcQA3NvtnNSAyW6W3DyN2lZw7kW83DM6URmX42yw4eM1HJlH2paYTVzHvs01UDdZof8piuYnrjoNQPZnMZ9U0ZWdrFiOZNRDmB26GU5lJfEDWKBQ+p1jxGtaPje6oGzivQ7w6NxL7l5REQazLo6zRG4O/KnHOPfI=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CY5PR10MB6190.namprd10.prod.outlook.com (2603:10b6:930:32::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Thu, 2 Nov
 2023 08:48:24 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 08:48:24 +0000
Message-ID: <00fe0c0b-267c-4d1f-8f0c-efdd8c166002@oracle.com>
Date: Thu, 2 Nov 2023 01:48:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/18] vdpa: add vhost_vdpa_load_setup
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gautam Dawar <gdawar@xilinx.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <20231019143455.2377694-16-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231019143455.2377694-16-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CY5PR10MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb95b64-c060-4195-fbd5-08dbdb807956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCH23qjWdcLKtcf2ioxBbb6LqVvmXyVQ8OzZsohDlHX8NGiO4LWUvF4/mIdCxoaZ8Xhen4ZjFB0fFp/0wrsvSxFRB4Y0FquW+xURq5Hn7RuOCOCacehdfJv2FYvBYFsf8UOlbtbUD2BveJk9ZrNqqpB2bb8kfy86uxv1ltfIIHmcGcJSSH6ttu/u0hoOLIbTUvejmugfpFhQ3oNTc1FkUu8SaDEvPvIBYHEyo6sk7mRq89wjeuEvzZ8xintR3Ehk+lXZ+ZEMt0pX44vUp9S2rAuD+1QLRTdgej4D7U/9JBSvYfi5V7ydCujayBNMfny2CiWzCrDcoc7o1oszctcxwfs1sDVoEvs2RxhFhaXBdToBreb25Ssv44VG6d/lrBpU16plMsyYsCra1mJqJ5IYnBEWWfIZrSmlpczV+d/0xVsdAzcBr38JcXgSpQTRSZEuQMT5ij4Xch5hsSLROEHKHQbL2+ko2Z3XPwHjB0WT81lTZu2nHeyb9VH6QBhROcRrymUAY+yXOfZNdApaot+bA+GWIV1czrZvVJNrl744gDYI2PkzM2eXHc2JV9B4kwUAWdPIGP2jJj8C3Cq15Ws+S/H+VwRJO7PqX7hH007gC/WJEpIBhQYdjQr/WS3vaPcqtazJ92c7RH4BJvBmWmC/WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66574015)(4326008)(7416002)(31686004)(6486002)(53546011)(6666004)(66476007)(6506007)(36916002)(6512007)(38100700002)(478600001)(86362001)(36756003)(31696002)(54906003)(2616005)(83380400001)(41300700001)(2906002)(5660300002)(26005)(66556008)(316002)(8936002)(66946007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG5xZWJjbFljYy9DaHpvR242bi92UnAxSzZCMDVhVitmTG5PQlJ0dkZZUWsr?=
 =?utf-8?B?OS9EYXduWk84UnNQNU4rRkFySmV4UUd6b0xrZkZjQnJWeURmem0rdCtsK3VF?=
 =?utf-8?B?aGZZVmpDaW1lQ1FCTm4zTHA1UndrcVVRWEpZUjk5MUNNeFpIK0VEeEVPMkY3?=
 =?utf-8?B?TGhkdmRGWXB1MjlBYTFnTXRHNzBUeHMyUWdMZ3NDUFBzOXFPK0NMTWpjMEg4?=
 =?utf-8?B?ZER5TDh1U0taVDRnR2FDYThway9FS2JESDVjVTlmcml2NzJVd0ZIV2lpc0xt?=
 =?utf-8?B?VFQvZWdhajArN0Q4ZUNKcGtsQWV2TG9yRzZiNlJaOHVSMm0wR2I5d2lOOS9s?=
 =?utf-8?B?TTF2NVA1QlcyQStLclBCVS8vS3JseFVDYXFKM0FqeVFyd1NmWkVTSU54MTNX?=
 =?utf-8?B?MlcvdVc4YURET3o5elpaR3lZQ3cycTlRdndSa084QXpMS3NLd3l1NXJPa1h1?=
 =?utf-8?B?UlErUEJQdTV1ZzVDN2J6U0NNZWEwVXVWbk1GT0tNQVNBdCtNSk01aEw4OVY4?=
 =?utf-8?B?VlRWeTl1TC9QZEhZQjd4ZDBmRHJGdHVkU0N2MG56bjI4RWtTZnA4TUhWM2FG?=
 =?utf-8?B?cEFUUFhxNGt2cDFhZG0yVkhycXl4SVkwdC9xMXhreFdrRkg0Zlc2bFZTODZv?=
 =?utf-8?B?bWNRdHJsbE92R1AzUm5Lb1ZhQzVZblVnSmpjNFhvZ1JyZFIxd25FaTBZRXQy?=
 =?utf-8?B?TnIxZDErSytLNWd6NWI1eTVtcjRHanZSSFRmOGVLNjRxQUxDWlR0c09jSUVE?=
 =?utf-8?B?VHBMK2ZKL3NadzBHL0YveGpSSGVnMHRCbUNoejRldzBVd1BrTHNRSS9ORHI0?=
 =?utf-8?B?bkwwK1YwVWVGbktGNGc2VTdQa0ZyV28xZkpKZFY0Mk0xcDlHMmNUelBXUEJp?=
 =?utf-8?B?Tm94Y2JnY3FmUGpOQkhTVTA1S1NYQ0RrQStvM0pGallzdDFxWWxBT3AyR015?=
 =?utf-8?B?UDhEMVlmTjlrZDdvekhQcjNXd0hLZHRxaFVYeTF6cFlkV0JPVmtLY1ZJYThP?=
 =?utf-8?B?UVNJZExEM1ByQVoxYk1zbWxzR3VhSldGRVQzcnBnMk9zdEJrZkVsdHpyOGI2?=
 =?utf-8?B?TkhHUXI1ZjFNcTRyeEgwa2hFVE5SZVdSU0x3WTVJMzRWcVVaRmx1K3Y5bTY0?=
 =?utf-8?B?VTczaXNMS0RmVlRpT2xwOVpibStua0VSVWdZb1ljMTdEYzh5ODN0aXdTTSsv?=
 =?utf-8?B?ZVl5eHNGdHdsZDFCS3JtVkV6SFBFZGx6Z2JyNkR5UHRZd0NtV2k2TDdUTThM?=
 =?utf-8?B?ZS9xdU9DdVo1QzZKdmUzdW9mSmszVTFsYy9vSFNkQkVFUllOSWtsUTBvMStv?=
 =?utf-8?B?VkczMUxQV3NjckxkNUY0Yzd3cVVTbGFFbG9XL3pYUVZENFhjRG1jZjFCdDEr?=
 =?utf-8?B?VGRBcldWZjZaMXZoQ0JvTUc2UWN4YXlUNytqemV5QWNQVGdpbGNsTGV3NGxQ?=
 =?utf-8?B?UVdFSVMvWGZQOXBwZFIrbENiejVRYU1JTXUvaGNCckhwa0dlZlNKZVJYdmE5?=
 =?utf-8?B?Ly82bURqVzJYOEJpQWFIdnNjMWw3YzBVelRKK1l4Tk8vM2F3VHJPY2JGUDY3?=
 =?utf-8?B?emNwWnJLZ1Y5UWdCd2dkb1BubSt4QXJOLzcxNmU3QTNuVktud3RyY1B5RjQz?=
 =?utf-8?B?Wk9Ra2VUMDlCWFdBdUdLYzhvRGR3anBmdEU2S01uTXVmTHZoT0paUVAvVnVU?=
 =?utf-8?B?dys2ZjFibmRiQ1JEMVM5SG1hL3l1SjY2M2YyNklzZDhLSHYrMy94ZVk3d2Iy?=
 =?utf-8?B?VnZKZXQza242ZXI5QVhaQU9WRWRTdlZtYitnN3RnM2VaYTBRK3c1WjAxazk4?=
 =?utf-8?B?R0NTSFhyRXgvQTR1a2dyeVkzYng1OGtjd2d2RndRKzdIcXBQWUlKdDBMYnJE?=
 =?utf-8?B?SUtoRlZCY0poZEJjVUk0SjRicUdFSVAxeStXZXB2TjI5Ni90V1pReVJ1VkZS?=
 =?utf-8?B?T1gzZUFWU1lzalNXalBYNnArSjgzYUFWaU5CcktRRUp0Z1lxUUUxd3daanMv?=
 =?utf-8?B?RmxYZnZiMVd3cWUxQWFoODJsNitPdjNvZGQ1bk5pcncwL1pOSG8rNDMzYTJX?=
 =?utf-8?B?emZ6NUJXS2xRSHB3ZHkrcmlzcVNCSHBDVVN1K3pGV05WenFDYk10cFZWWmox?=
 =?utf-8?Q?xAu903CMemk8Q/ySf88nshYO+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q0x1TnBUc1hHblFrVEdnYXFiK1lXSlQ1dGNHODAxOGhqODlRSnFKREVvYzE0?=
 =?utf-8?B?OFRlRWduYXdlQTNUUHA5emxkU2hEL05UdmtoaGJhZ041VWJzRW96eEJyZE04?=
 =?utf-8?B?WnE2RjZPVk9maCt2cFRtdzhnSlR4eXgyeEpibjVSS0xFMkZ2UHZoQnRDVUJy?=
 =?utf-8?B?MVc5SWExekJUOC9HSWdkdzRMYXJCZ00wRGNwS1R4OVNsajZ6TG1Cd3ZrOFRM?=
 =?utf-8?B?ckRaUjl4S2VZaEd3UG9UcG5nQUQ3VGVlZjRoUnhScmJqL0JiQ3RBSDZYeHln?=
 =?utf-8?B?ZEZ5YTZha1VoSW1GUm1oQ3ZmcGc2UlVWcHc2LytFbTA2RnljNzRVdGIwU3Iz?=
 =?utf-8?B?WldaMkxhc0dYNmRlRjBiaXJRSmYwelRyQmJsQitPSC9PU0hLdE1QQSszT0Mx?=
 =?utf-8?B?eFBkQmRSV05vaDd4K0g1WmpEZi9ubldkb1NPZGJqV0xDa1pDL0tHeVFwekVm?=
 =?utf-8?B?SDZ5T0IzWStNek1vTFVuV2dKRWR5R1dlcERRVXRuTGFTZUFhdG1kQnY3R2RU?=
 =?utf-8?B?TGFhVjh4RzVaRm9KVWxRYTVYSm1IUGFaTjdzTEZHdUVkaWRJUW5jcGlkdTl5?=
 =?utf-8?B?bDM2SGFiUW9pYVpWUXc2anZrT1g0NzdJUnVIdEFlNndPTU04ZGtXc2I4d0xy?=
 =?utf-8?B?QmtHbURKa1FPZkxmeWp2d0lEY1hvclU3N3VFY3YzVm5lVVdBNmd5MEJUeG9j?=
 =?utf-8?B?aWlsYjYrK3dXSkdCN3MvNEZ3NGNHcHBHeSt6QVo4TTNJSi9IbmtXWk9pdXo3?=
 =?utf-8?B?WVE2NFNGMG5VdExnOXUyUERjeGxkWFRHczREaTBzLzBCYmhDK05maHBJdkNr?=
 =?utf-8?B?VDRwMXpRVWNjTm9JcWh1SWpsUFdXWFd0MjBydUF6SE92WHNsdll4WFdVZEJ3?=
 =?utf-8?B?N0s5c1VXMUNmYk1Rb3pJZGkxRjVpMWJyLzRuWTZPbUsvc3h1ckhHcXUzZ1dE?=
 =?utf-8?B?bSszZU0yZ0hMSVlWWVBIRWxvd2xNNDgyWFpSdEkvUjVXSW1MRUt4OFRGc0o5?=
 =?utf-8?B?aWMrZ1ltWmNtdkIrWU0vWEpTTGxxa2ZxY0lZb2FvOE04YS9SaE1xQUl1bk5D?=
 =?utf-8?B?UlJuY0ZpM2VHZkQyYU1KbWRKQ2JGWDdjdEd4TFlIMGZ6azM0YnM5dDJwMW1j?=
 =?utf-8?B?NS8rZ0pZNXJYQlhFVDI5aDk4aFc5UFFaSHlSZ3N0Vnh4RGVnQUx4YUtEYzcw?=
 =?utf-8?B?a3JPcjAwRDlZRTJyMkx2VGQwK016dWVsSERJNWNWb3h5OU1HYVdSeGR4ekN4?=
 =?utf-8?Q?pJMLdIw5+QWSqbY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb95b64-c060-4195-fbd5-08dbdb807956
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 08:48:24.1995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mgr3woaWBo4+rKdzIqDKJAdadLwoPIMqYATrZAMAE1N4q4gfkMtzFkj6oFaf8L4SGOlQ1LyIidaEMixNwim4uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020069
X-Proofpoint-GUID: Fx7hrgL5UDdYgaX23Zmve4Czfkov96_t
X-Proofpoint-ORIG-GUID: Fx7hrgL5UDdYgaX23Zmve4Czfkov96_t
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



On 10/19/2023 7:34 AM, Eugenio Pérez wrote:
> Callers can use this function to setup the incoming migration.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   include/hw/virtio/vhost-vdpa.h |  7 +++++++
>   hw/virtio/vhost-vdpa.c         | 17 ++++++++++++++++-
>   2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
> index 8f54e5edd4..edc08b7a02 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -45,6 +45,12 @@ typedef struct vhost_vdpa_shared {
>   
>       bool iotlb_batch_begin_sent;
>   
> +    /*
> +     * The memory listener has been registered, so DMA maps have been sent to
> +     * the device.
> +     */
> +    bool listener_registered;
> +
>       /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
>       bool shadow_data;
>   } VhostVDPAShared;
> @@ -73,6 +79,7 @@ int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
>                          hwaddr size, void *vaddr, bool readonly);
>   int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
>                            hwaddr size);
> +int vhost_vdpa_load_setup(VhostVDPAShared *s, AddressSpace *dma_as);
>   
>   typedef struct vdpa_iommu {
>       VhostVDPAShared *dev_shared;
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index cc252fc2d8..bfbe4673af 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1325,7 +1325,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>                            "IOMMU and try again");
>               return -1;
>           }
> -        memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
> +        if (!v->shared->listener_registered) {
> +            memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
> +        }
Set listener_registered to true after registration; in addition, it 
looks like the memory_listener_unregister in vhost_vdpa_reset_status 
doesn't clear the listener_registered flag after unregistration. This 
code path can be called during SVQ switching, if not doing so mapping 
can't be added back after a couple rounds of SVQ switching or live 
migration.

-Siwei

>   
>           return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
>       }
> @@ -1528,3 +1530,16 @@ const VhostOps vdpa_ops = {
>           .vhost_set_config_call = vhost_vdpa_set_config_call,
>           .vhost_reset_status = vhost_vdpa_reset_status,
>   };
> +
> +int vhost_vdpa_load_setup(VhostVDPAShared *shared, AddressSpace *dma_as)
> +{
> +    uint8_t s = VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
> +    int r = ioctl(shared->device_fd, VHOST_VDPA_SET_STATUS, &s);
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
> +
> +    memory_listener_register(&shared->listener, dma_as);
> +    shared->listener_registered = true;
> +    return 0;
> +}


