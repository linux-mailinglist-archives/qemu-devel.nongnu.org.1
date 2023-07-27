Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAA376585E
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3Eq-0002Kl-QH; Thu, 27 Jul 2023 11:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qP3Eo-0002Ka-Tz
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:49:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qP3Em-0006Go-1f
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:49:14 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RFOFPp020253; Thu, 27 Jul 2023 15:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=RyBWoQNYwoUjvVjDhmWnvSbNRcRGd/KmEysSv0kkRUU=;
 b=uXtI8f37XGXhzxlPys1Oouuh/3XH7kPRa6S7lWU4bHYGUyNtIp0VBEIvFtIVQICVTUhu
 0GTtW1CgNCcTZnBw/jM+pUnmZ/ABxDnm8+ph5NnEKDrBq9E33COsIo2BnsD6Ae+3rFYr
 C75S+7HGDBwEYmcT6onVKe+LQiHMEZTOy1jaPI6y894uLw1HJlCMp8y4ySwxyzoNDF46
 /qSWKgG761Wt43PhjtUNJlh349zHU2sVz1h/5PDTHbz9qHLVGEHNzGxYOGcLMeO0BNhU
 YckjRLuIN315NBn2f6TgTm7k+lrqZgk94m3L/oeTQ3rHuDlzBmvFLiQOCYfssT4jZoig gA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3t244-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jul 2023 15:49:08 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36RElbFT029421; Thu, 27 Jul 2023 15:49:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3s05j7tun0-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jul 2023 15:49:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i74iq7AdUlqtXPRYS4DkXrNYIqoxHBI/szPlhP5dik1X96T9i3P9/Eg2CwAkr5LTPahbtb+7jlYCYaHlEM1bp03YNl5rubu3W8N7dAGSucpUdMYQ6ECvzsJooJcs2XeBHYlOsSjY1C7L1JuDY7IoKJDe5LlBRELJZuC2HBRcC4sIeNCpgAkYP1MhvLHew9YfvnczVM9ga61Mc6DBZgwA0/HG7yxve8xxO4qlRu9E1cSDO59gLLYLAhsSbmYm9pQAYqULIQwBFeTQC/WzqGHSwicez7xwmkZygDP5KSeYy1s+9qBpvoFT3Cb1v0Ke9Bhcd33ztvsJwgwdgnmO9mmBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyBWoQNYwoUjvVjDhmWnvSbNRcRGd/KmEysSv0kkRUU=;
 b=IEb0WPGqpJFnTl/cWTRsGhNU9fr1bCyv7w7BlWdDYivQFjlWkcFG+CnXYCsoCRMCCXNOqmi+sOOb1IE3+YA56JGW8GQZk55HGT/hVOYh3jq2BP/CsBfW6zpTXij2z77eriDsP3wXTuPgYoEhtk1fcStWOz/DHgEv1Nr+S7zQfd61cgUyJktpTDiIOe8hvcJwlKM+HebTccUg9XJA9QsPRyAixyYjXLQ3dR2cA0J+apO3M/+/YATf81s2yW9rqZh32i/SVsL5ADXz1qLyko+4LdHmr7ItsHcCj8IDjQyBA4l6ubCrlHFPt/S5uzHhpxPevXKZi9RTImvXg2fRdDI2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyBWoQNYwoUjvVjDhmWnvSbNRcRGd/KmEysSv0kkRUU=;
 b=WADBAVL3SZZDoQ/TlMLRtBJ0WDwqCb+JNqZRbPpRTwcFCGvN9v9mBc6nBkHzlT7ke5OFEr18+hwfr0+u2amt17hNoZ+V+/W7jZ8EbZbw4buV3YsthWyRVNN1d308TAw93rhWTYJALEbhRLq8Go9JeFRjsMAaWbiX3qST/Mb4GoI=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by PH0PR10MB7025.namprd10.prod.outlook.com (2603:10b6:510:283::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 15:48:58 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::8912:968:6292:45b8]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::8912:968:6292:45b8%5]) with mapi id 15.20.6565.028; Thu, 27 Jul 2023
 15:48:58 +0000
Content-Type: multipart/alternative;
 boundary="------------7mqsMon0z0iWHNrGEvG09pJA"
Message-ID: <03140fad-05ee-07a6-eade-4598722e0adc@oracle.com>
Date: Thu, 27 Jul 2023 11:48:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] qmp: remove virtio_list, search QOM tree instead
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 mst@redhat.com, boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 eduardo@habkost.net
References: <20230609132040.2180710-1-jonah.palmer@oracle.com>
 <20230609132040.2180710-2-jonah.palmer@oracle.com>
 <ZMJY+auV/NbIjfmh@redhat.com>
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <ZMJY+auV/NbIjfmh@redhat.com>
X-ClientProxiedBy: BL0PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:207:3c::36) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|PH0PR10MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 89772080-92f3-4424-9a7f-08db8eb8fdc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHPzmmFpxQm2+r6TDYwDjpOjXgoLTegjcF04X9LW4vm1jYlYYRMdPLC4XtUSQSJD3wsCbvTqPIMsNvJ3AFkDbakIweZT1HfPixEYlb84CO/u2l+LM9lBdiYSHFRSRd5dno06jMNbbWtIWWNwYGapwWsjZNJr8IsKBnk/TkwpsWlwiVv54SNLAtZ2jXKmjkyEnHR7K+EzExAOAJzhBiQ6nOcUPygnYqIhoTHpQ8ENd5mMoEGa8NGlqCjLeaGHLGsLdLZdGkerdlh1q25hF1bv+kVFo6tss7hcUBv3eBbyPEIimUNQki+5JuCvQynFlB8ArC/VOocNhvG9zoyatP596CbnS/xcLSptlGS9TUj7iKok8Fpy/zJPoJocbqKgPyFwiw2CRy6OL3zSQtgtRFlhzmHiNS23PiKmnVLLYcl1j7m6Q/woVkmVBCyrDlYX071jCMvWffrm+ZL18R42NkJ8QkSBtPlppXGwiLnjYTKEdjv3xmcMLqR3MOs9Yp0qGzlT6X+v/BOCa43lZ2L8MoJugEQwrRJgr0vfoL/2VREaNt7NwQSBE1T7Ob6MUAh108H+fGtwXLa43mSHmwmjuhSU9KkKYoAmLXPswrrKBH0Yo1+tW5+r93b3gtCH2Q8OmXcS1DWsRmdlQrRnzc5XggVgKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(31686004)(30864003)(2906002)(83380400001)(2616005)(6506007)(26005)(186003)(53546011)(33964004)(6512007)(6666004)(6486002)(478600001)(66946007)(86362001)(38100700002)(31696002)(41300700001)(4326008)(66476007)(66556008)(7416002)(6916009)(316002)(8676002)(8936002)(5660300002)(36756003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MERvMGNuVDErc3hSR0ZHTHN6a0pPcGFKZm5ONWpWYndjdTBRbjIzbXZNR21u?=
 =?utf-8?B?Z0x5L1FwVnZicFpQd0FtVjJFL2Nwc0h3c0dMTkVNOUR0ajVjK2Q3bnNSZXNK?=
 =?utf-8?B?MnFNSnc1MXAwejM0YTVLTDNCbmZGVTVvTER3SjZKUU1XNHY5VSt6QnZzN2dI?=
 =?utf-8?B?SWlIalgxVVdDMlViQVhqbDNpanFOaUdwVFJvdE1ZZmZXZk44aUtqaWN6ZVg2?=
 =?utf-8?B?WDlEMGdWNWVWVkJrVVZ1UUIza0xqS1RmVTNtZlJ1WmoyaE54TTh4UXRhOWFs?=
 =?utf-8?B?enhqYm8ybDNhUCtZdVRHNTJ5V0REYkhoemJqcnl2ZFhHTnE0aXlnTlJPS2ZG?=
 =?utf-8?B?Z3VwSDJOTEhzOTJYbE9FbS8xb2FPNnc1MlIwZlhnUEpoTkUvOXFzY3BiNnRI?=
 =?utf-8?B?SkUrcTJ2TzJOZlRoR3BkMEFtQXp4cExQMjl1MnBBZ0xFRzJic2ZrSTluNDFZ?=
 =?utf-8?B?bU5ENWprWmlwTVc5RE1SMU9YaUtzTjlnS0hsRUNrbHBJbGpWYmJYNlFwMFZ0?=
 =?utf-8?B?NDZoVTFWYVpCM0MrWnpIY09NQm5MT3VVblk5Qmo1OXhjb3YyWndkT1ZWOG1p?=
 =?utf-8?B?cVY1QkNaeGJRaFNIQVczWThsQXJSWEVydnNuYldmY2h0L0J3Rkl2NnZEbUlW?=
 =?utf-8?B?NXJXVTZiUWtOcXpYVVY3MCtxeDVxcXpRaHkraXZwL1RidjAvMk5BeVhXbUNr?=
 =?utf-8?B?WjhMaysyVEllTEhIM3NzWWR4NHNPdXNZcFB3NjNJRDZDQ2dzaVNFbUl2cWlM?=
 =?utf-8?B?Tjh1WEZOSWo5WndVL0tMaTVoRTFIU1V2ZzhxWWZ6aGExcGNkM21MK1lVYUFG?=
 =?utf-8?B?azN6bE5wandJZVNPcHlSbk1MSWJrTWhZOTNwaHlrT3ZMUlkyeCtPeU9ydEhM?=
 =?utf-8?B?V01IU2IvZjU2end4N0M0a2czWFFWMm5ucXVLa2JhOS9Id3B0b01iV3hudHpw?=
 =?utf-8?B?b05iSExKNFZkMldKVnlnSXRZUWpoM20zQ3dvdTZzaW13QzFxTTN5aHdQVVll?=
 =?utf-8?B?eGZuTWRYYkdyZ2dSSDF5YXR4Uk93NFA5TElpOUpKckYrb2dvZjU1dW42WnQ0?=
 =?utf-8?B?UTNJMDhWRG9IR1RhbFhId2NDWUFrUU82TDlVaEQzUDBtMmplYy9GcHRFbmRn?=
 =?utf-8?B?WDJYd3VJOWdNbzBqNGdsQzFJMVBMR3oveXBKWnNhNWNuVElmK01SNldwTnYz?=
 =?utf-8?B?aDdsb0I2b1B6NTdHV2ZON0N2OUMvT09xekI4aG55dDZacFdKTVMvb25HcFRp?=
 =?utf-8?B?bXdYaVYvWisxYmxIVW9zT0l5dTF1c2Ixb0F4UnR2bmhHQ1VNc2VmNFBkSnds?=
 =?utf-8?B?RlhpZnhwQ25sRzZpMU5lVGppQzZwVzkwSVl4K0w5ZWJuRWVVUjhVNzhTMGF6?=
 =?utf-8?B?a2htMTRhek55b3l6a1JTWS9hak5tRlJqR2ZJQ3B5MGNPVHl4a2JHMGhvWFBV?=
 =?utf-8?B?UExpMFV4UTIrTmlHNmpXQ3hHdWR6M2ZQK1diZ1p6OVVBdHdwSkhBRSs5Z081?=
 =?utf-8?B?MFUyNVZJcVAwTjcwZGgwTkcwb0ZUSitoTnJWVWRPb0x2NGxGYit1Y0dpekhw?=
 =?utf-8?B?RTFNZEVNeHpLWVNpbUtQd3Rud3gzVmh5ZkdzWjNGYVYyZEQzQ2pxV0QwWlRY?=
 =?utf-8?B?TFhZUFBMSmt2TWJleVJ4U3ozQ0VqNWNBUG9QM2tYa2JRN2c0SHRLN3NqbFlO?=
 =?utf-8?B?Z0l2cWJhcDNmYnUvcVNzaHZndzlabW9ZYXRZZmt3dDczZHpsL1dueXRVcFV6?=
 =?utf-8?B?bmpiNTkrdHFjekFGS2dDWDVmalovNVNsajhFcTB1RVFsdnZnVmxTN1U1TFBq?=
 =?utf-8?B?Y1dCSTdQcElTdkFVUXRCdDVjUmpUNmxnSlFsV2x5NHAvSXhHOHFSZDZlZ2Vr?=
 =?utf-8?B?YjZCa3hXQVV0Q3NOQWRFaXRRazBISG5NU3RUYW9RaTNmS3hMZ3U4cjNOUjF6?=
 =?utf-8?B?bTROdXcyYUhndHBJV2Jvc0hFZ1F1UHFvejBaNktydTIzbWh2YUhIMG1RYzc2?=
 =?utf-8?B?OWZXQ2p2dXJCUGVkOGd0VzFtbGsrRkJJOU41bDhrZ1ZwUUY5VVR2eXFoNFhV?=
 =?utf-8?B?TVNuMm5Kc2xLcUF3NVdjbzdHTmpTZkxzOHFPS29mT1RiV2lNSWErNys2QUt5?=
 =?utf-8?Q?JPFeMKpYfiwIkTxQBFRB97jCt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ng4YndBRPyv2sIwFSpNw/c7PX06HmKMlwsED0vRFpi8SB8z7E/wwBrsItja8LbvlZDz//WASBSk7kXSQkgI5gOXD6fXlCLnvPW2XNQKBQbH1dafoUvgCrVlh/+YdxVFa3vDOCWLz4VI2zpXg72Atl2bgqn9/6SGp2HxcmD5G0jqlXEL+VKM44al8lhpKL+TCbRTcxHjV/ICFa6U1GBww9ULws1mAgvgJinGFsSa/S4uW76OvgSORyPaHF50RA7ocB6D7iCusr6VZ38ecewJe28JdCa5+FQtNDtwx8MogPKEApxYbfJnnepY294yoSWRq1mbNFas4HRyfDh7T+dsYlkHuiRwnza6kTfcGI48zBItEivqb1zPLK4mmcjPt4tQezOKZclcpkRC9bFLNS1q+cxcgAOFM4vMXr25t1VxcnvppcFWs+MWHPpvNtUWOpzVg+CzQjocSrA24rW/CS3kUvSy0+kAZUTIG16KxV9U2+mUnzLswx1T3diYIR5zLZhp7STgIYty7PIWLEYE67/xNKU9uCSVEkqghWQn3kXEY6vppDDcManmTjTV+NWxgWu2o4dd6lBFG1/iLb2yn0e8hOE3ae7bLDbt5tnaXnijdCGtbiJTXROxWt5L1PBtN65LKVNiqzt1kg8AhuG/7IKN6ruNGHRfNd/2mznCRYBLW9oHaa2udYrg6wOa0xfexsKWDrDZe0uRO0i3iBdEEf5WnFJ3+HGNUJUkHw7hnx+WDBzpRuhcPMLJ7F39YoURUlwKGZLJ9HTwWAqLaKyirNpGLmw423jZSiZkE9PLoywzYSZNLgxN/iVWOg5Za7VyE2ptEnJv+DGgfl6221ytra1X6oRH+uuksZbQcZ5pjhYXTLXUn8s76/twLzz+2zmNP/oyH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89772080-92f3-4424-9a7f-08db8eb8fdc4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 15:48:58.8787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XNTTJzeHxH6nD8xn+w5SrtCeElt/8MtFkiJwTzvhPGKz+TQYgtq1iE2hV64rsfShveekcCbw0PPGAnpbornuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270143
X-Proofpoint-GUID: NtK2-bhQLDgMwNaak0JN9JvYhac9d6N9
X-Proofpoint-ORIG-GUID: NtK2-bhQLDgMwNaak0JN9JvYhac9d6N9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

--------------7mqsMon0z0iWHNrGEvG09pJA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/27/23 07:46, Daniel P. Berrangé wrote:
> On Fri, Jun 09, 2023 at 09:20:39AM -0400, Jonah Palmer wrote:
>> The virtio_list duplicates information about virtio devices that already
>> exist in the QOM composition tree. Instead of creating this list of
>> realized virtio devices, search the QOM composition tree instead.
>>
>> This patch modifies the QMP command qmp_x_query_virtio to instead search
>> the partial paths of '/machine/peripheral/' &
>> '/machine/peripheral-anon/' in the QOM composition tree for virtio
>> devices.
>>
>> A device is found to be a valid virtio device if (1) its canonical path
>> is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.
>>
>> [Jonah: In the previous commit I had written that a device is found to
>>   be a valid virtio device if (1) it has a canonical path ending with
>>   'virtio-backend'.
>>
>>   The code now determines if it's a virtio device by appending
>>   'virtio-backend' (if needed) to a given canonical path and then
>>   checking that path to see if the device is of type
>> 'TYPE_VIRTIO_DEVICE'.
>>
>>   The patch also instead now checks to make sure it's a virtio device
>>   before attempting to check whether the device is realized or not.]
>>
>> Signed-off-by: Jonah Palmer<jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
>>   hw/virtio/virtio-qmp.h |   8 +--
>>   hw/virtio/virtio.c     |   6 --
>>   3 files changed, 82 insertions(+), 60 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>> index b5e1835299..e936cc8ce5 100644
>> --- a/hw/virtio/virtio-qmp.c
>> +++ b/hw/virtio/virtio-qmp.c
>> @@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>
>
>>   VirtioInfoList *qmp_x_query_virtio(Error **errp)
>>   {
>>       VirtioInfoList *list = NULL;
>> -    VirtioInfo *node;
>> -    VirtIODevice *vdev;
>>   
>> -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>> -        DeviceState *dev = DEVICE(vdev);
>> -        Error *err = NULL;
>> -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>> -
>> -        if (err == NULL) {
>> -            GString *is_realized = qobject_to_json_pretty(obj, true);
>> -            /* virtio device is NOT realized, remove it from list */
>> -            if (!strncmp(is_realized->str, "false", 4)) {
>> -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>> -            } else {
>> -                node = g_new(VirtioInfo, 1);
>> -                node->path = g_strdup(dev->canonical_path);
>> -                node->name = g_strdup(vdev->name);
>> -                QAPI_LIST_PREPEND(list, node);
>> +    /* Query the QOM composition tree for virtio devices */
>> +    qmp_set_virtio_device_list("/machine/peripheral/", &list);
>> +    qmp_set_virtio_device_list("/machine/peripheral-anon/", &list);
>> +    if (list == NULL) {
>> +        error_setg(errp, "No virtio devices found");
>> +        return NULL;
>> +    }
>> +    return list;
>> +}
>> +
>> +/* qmp_set_virtio_device_list:
>> + * @ppath: An incomplete peripheral path to search from.
>> + * @list: A list of realized virtio devices.
>> + * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
>> + * or '/machine/peripheral-anon/') for realized virtio devices and adds them
>> + * to a given list of virtio devices.
>> + */
>> +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
>> +{
>> +    ObjectPropertyInfoList *plist;
>> +    VirtioInfoList *node;
>> +    Error *err = NULL;
>> +
>> +    /* Search an incomplete path for virtio devices */
>> +    plist = qmp_qom_list(ppath, &err);
>> +    if (err == NULL) {
>> +        ObjectPropertyInfoList *start = plist;
>> +        while (plist != NULL) {
>> +            ObjectPropertyInfo *value = plist->value;
>> +            GString *path = g_string_new(ppath);
>> +            g_string_append(path, value->name);
>> +            g_string_append(path, "/virtio-backend");
>> +
>> +            /* Determine if full path is a realized virtio device */
>> +            VirtIODevice *vdev = qmp_find_virtio_device(path->str);
>> +            if (vdev != NULL) {
>> +                node = g_new0(VirtioInfoList, 1);
>> +                node->value = g_new(VirtioInfo, 1);
>> +                node->value->path = g_strdup(path->str);
>> +                node->value->name = g_strdup(vdev->name);
>> +                QAPI_LIST_PREPEND(*list, node->value);
>>               }
>> -           g_string_free(is_realized, true);
>> +            g_string_free(path, true);
>> +            plist = plist->next;
>>           }
>> -        qobject_unref(obj);
>> +        qapi_free_ObjectPropertyInfoList(start);
>>       }
>> -
>> -    return list;
>>   }
> This is all way too complicated. AFAICT, it shouldn't require
> much more than this:
>
> static int one_child(Object *child, void *opaque)
> {
>      VirtioInfoList **devs = opaque;
>      VirtIODevice *dev = object_dynamic_cast(child, TYPE_VIRTIO_DEVICE);
>      if (dev != NULL) {
>          VirtioInfo *info =g_new(VirtioInfo, 1);
>          info->path = g_strdup(path->str);
>          info->name = g_strdup(vdev->name);
>          QAPI_LIST_PREPEND(*devs, info);
>      }
>       
>      return 0;
> }
>
>
> VirtioInfoList *qmp_x_query_virtio(Error **errp)
> {
>     VirtioInfoList *devs = NULL;
>     object_child_foreach_recursive(object_get_root(),
>                                    one_child,
>                                    &devs);
>      if (devs == NULL) {
>          error_setg(errp, "No virtio devices found");
>          return NULL;
>      }
>      return devs;
> }
>
Ah okay, I will give this a try. Thanks!

Jonah

>
>
>
>>   
>>   VirtIODevice *qmp_find_virtio_device(const char *path)
>>   {
>> -    VirtIODevice *vdev;
>> -
>> -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>> -        DeviceState *dev = DEVICE(vdev);
>> -
>> -        if (strcmp(dev->canonical_path, path) != 0) {
>> -            continue;
>> +    Error *err = NULL;
>> +    char *basename;
>> +
>> +    /* Append 'virtio-backend' to path if needed */
>> +    basename = g_path_get_basename(path);
>> +    if (strcmp(basename, "virtio-backend")) {
>> +        GString *temp = g_string_new(path);
>> +        char *last = strrchr(path, '/');
>> +        if (g_strcmp0(last, "/")) {
>> +            g_string_append(temp, "/virtio-backend");
>> +        } else {
>> +            g_string_append(temp, "virtio-backend");
>>           }
>> +        path = g_strdup(temp->str);
>> +        g_string_free(temp, true);
>> +    }
>>   
>> -        Error *err = NULL;
>> -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>> -        if (err == NULL) {
>> -            GString *is_realized = qobject_to_json_pretty(obj, true);
>> -            /* virtio device is NOT realized, remove it from list */
>> -            if (!strncmp(is_realized->str, "false", 4)) {
>> -                g_string_free(is_realized, true);
>> -                qobject_unref(obj);
>> -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>> -                return NULL;
>> -            }
>> +    /* Verify the canonical path is a virtio device */
>> +    Object *obj = object_resolve_path(path, NULL);
>> +    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
>> +        object_unref(obj);
>> +        return NULL;
>> +    }
>> +
>> +    /* Verify the virtio device is realized */
>> +    QObject *qobj = qmp_qom_get(path, "realized", &err);
>> +    if (err == NULL) {
>> +        GString *is_realized = qobject_to_json_pretty(qobj, true);
>> +        if (!strncmp(is_realized->str, "false", 4)) {
>>               g_string_free(is_realized, true);
>> -        } else {
>> -            /* virtio device doesn't exist in QOM tree */
>> -            QTAILQ_REMOVE(&virtio_list, vdev, next);
>> -            qobject_unref(obj);
>> +            qobject_unref(qobj);
>>               return NULL;
>>           }
>> -        /* device exists in QOM tree & is realized */
>> -        qobject_unref(obj);
>> -        return vdev;
>> +        g_string_free(is_realized, true);
>> +    } else {
>> +        qobject_unref(qobj);
>> +        return NULL;
>>       }
>> -    return NULL;
>> +    qobject_unref(qobj);
>> +
>> +    /* Get VirtIODevice object */
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
>> +    return vdev;
>>   }
>>   
>>   VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>> diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
>> index 8af5f5e65a..4b2b7875b4 100644
>> --- a/hw/virtio/virtio-qmp.h
>> +++ b/hw/virtio/virtio-qmp.h
>> @@ -15,13 +15,7 @@
>>   #include "hw/virtio/virtio.h"
>>   #include "hw/virtio/vhost.h"
>>   
>> -#include "qemu/queue.h"
>> -
>> -typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
>> -
>> -/* QAPI list of realized VirtIODevices */
>> -extern QmpVirtIODeviceList virtio_list;
>> -
>> +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
>>   VirtIODevice *qmp_find_virtio_device(const char *path);
>>   VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>>   VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 295a603e58..83c5db3d26 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -45,8 +45,6 @@
>>   #include "standard-headers/linux/virtio_mem.h"
>>   #include "standard-headers/linux/virtio_vsock.h"
>>   
>> -QmpVirtIODeviceList virtio_list;
>> -
>>   /*
>>    * Maximum size of virtio device config space
>>    */
>> @@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>>       vdev->listener.commit = virtio_memory_listener_commit;
>>       vdev->listener.name = "virtio";
>>       memory_listener_register(&vdev->listener, vdev->dma_as);
>> -    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
>>   }
>>   
>>   static void virtio_device_unrealize(DeviceState *dev)
>> @@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
>>           vdc->unrealize(dev);
>>       }
>>   
>> -    QTAILQ_REMOVE(&virtio_list, vdev, next);
>>       g_free(vdev->bus_name);
>>       vdev->bus_name = NULL;
>>   }
>> @@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
>>       vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
>>   
>>       vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
>> -
>> -    QTAILQ_INIT(&virtio_list);
>>   }
>>   
>>   bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
>> -- 
>> 2.39.3
>>
> With regards,
> Daniel
--------------7mqsMon0z0iWHNrGEvG09pJA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>
</pre>
    <div class="moz-cite-prefix">On 7/27/23 07:46, Daniel P. Berrangé
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZMJY+auV%2FNbIjfmh@redhat.com">
      <pre class="moz-quote-pre" wrap="">On Fri, Jun 09, 2023 at 09:20:39AM -0400, Jonah Palmer wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The virtio_list duplicates information about virtio devices that already
exist in the QOM composition tree. Instead of creating this list of
realized virtio devices, search the QOM composition tree instead.

This patch modifies the QMP command qmp_x_query_virtio to instead search
the partial paths of '/machine/peripheral/' &amp;
'/machine/peripheral-anon/' in the QOM composition tree for virtio
devices.

A device is found to be a valid virtio device if (1) its canonical path
is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.

[Jonah: In the previous commit I had written that a device is found to
 be a valid virtio device if (1) it has a canonical path ending with
 'virtio-backend'.

 The code now determines if it's a virtio device by appending
 'virtio-backend' (if needed) to a given canonical path and then
 checking that path to see if the device is of type
'TYPE_VIRTIO_DEVICE'.

 The patch also instead now checks to make sure it's a virtio device
 before attempting to check whether the device is realized or not.]

Signed-off-by: Jonah Palmer <a class="moz-txt-link-rfc2396E" href="mailto:jonah.palmer@oracle.com">&lt;jonah.palmer@oracle.com&gt;</a>
---
 hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
 hw/virtio/virtio-qmp.h |   8 +--
 hw/virtio/virtio.c     |   6 --
 3 files changed, 82 insertions(+), 60 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index b5e1835299..e936cc8ce5 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> VirtioInfoList *qmp_x_query_virtio(Error **errp)
 {
     VirtioInfoList *list = NULL;
-    VirtioInfo *node;
-    VirtIODevice *vdev;
 
-    QTAILQ_FOREACH(vdev, &amp;virtio_list, next) {
-        DeviceState *dev = DEVICE(vdev);
-        Error *err = NULL;
-        QObject *obj = qmp_qom_get(dev-&gt;canonical_path, &quot;realized&quot;, &amp;err);
-
-        if (err == NULL) {
-            GString *is_realized = qobject_to_json_pretty(obj, true);
-            /* virtio device is NOT realized, remove it from list */
-            if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
-                QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
-            } else {
-                node = g_new(VirtioInfo, 1);
-                node-&gt;path = g_strdup(dev-&gt;canonical_path);
-                node-&gt;name = g_strdup(vdev-&gt;name);
-                QAPI_LIST_PREPEND(list, node);
+    /* Query the QOM composition tree for virtio devices */
+    qmp_set_virtio_device_list(&quot;/machine/peripheral/&quot;, &amp;list);
+    qmp_set_virtio_device_list(&quot;/machine/peripheral-anon/&quot;, &amp;list);
+    if (list == NULL) {
+        error_setg(errp, &quot;No virtio devices found&quot;);
+        return NULL;
+    }
+    return list;
+}
+
+/* qmp_set_virtio_device_list:
+ * @ppath: An incomplete peripheral path to search from.
+ * @list: A list of realized virtio devices.
+ * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
+ * or '/machine/peripheral-anon/') for realized virtio devices and adds them
+ * to a given list of virtio devices.
+ */
+void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
+{
+    ObjectPropertyInfoList *plist;
+    VirtioInfoList *node;
+    Error *err = NULL;
+
+    /* Search an incomplete path for virtio devices */
+    plist = qmp_qom_list(ppath, &amp;err);
+    if (err == NULL) {
+        ObjectPropertyInfoList *start = plist;
+        while (plist != NULL) {
+            ObjectPropertyInfo *value = plist-&gt;value;
+            GString *path = g_string_new(ppath);
+            g_string_append(path, value-&gt;name);
+            g_string_append(path, &quot;/virtio-backend&quot;);
+
+            /* Determine if full path is a realized virtio device */
+            VirtIODevice *vdev = qmp_find_virtio_device(path-&gt;str);
+            if (vdev != NULL) {
+                node = g_new0(VirtioInfoList, 1);
+                node-&gt;value = g_new(VirtioInfo, 1);
+                node-&gt;value-&gt;path = g_strdup(path-&gt;str);
+                node-&gt;value-&gt;name = g_strdup(vdev-&gt;name);
+                QAPI_LIST_PREPEND(*list, node-&gt;value);
             }
-           g_string_free(is_realized, true);
+            g_string_free(path, true);
+            plist = plist-&gt;next;
         }
-        qobject_unref(obj);
+        qapi_free_ObjectPropertyInfoList(start);
     }
-
-    return list;
 }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This is all way too complicated. AFAICT, it shouldn't require
much more than this:

static int one_child(Object *child, void *opaque)
{
    VirtioInfoList **devs = opaque;
    VirtIODevice *dev = object_dynamic_cast(child, TYPE_VIRTIO_DEVICE);
    if (dev != NULL) {
        VirtioInfo *info =g_new(VirtioInfo, 1);
        info-&gt;path = g_strdup(path-&gt;str);
        info-&gt;name = g_strdup(vdev-&gt;name);
        QAPI_LIST_PREPEND(*devs, info);
    }
     
    return 0;
}


VirtioInfoList *qmp_x_query_virtio(Error **errp)
{
   VirtioInfoList *devs = NULL;
   object_child_foreach_recursive(object_get_root(),
                                  one_child,
                                  &amp;devs);
    if (devs == NULL) {
        error_setg(errp, &quot;No virtio devices found&quot;);
        return NULL;
    }
    return devs;
}

</pre>
    </blockquote>
    <pre>Ah okay, I will give this a try. Thanks!

Jonah
</pre>
    <blockquote type="cite" cite="mid:ZMJY+auV%2FNbIjfmh@redhat.com">
      <pre class="moz-quote-pre" wrap="">



</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
 VirtIODevice *qmp_find_virtio_device(const char *path)
 {
-    VirtIODevice *vdev;
-
-    QTAILQ_FOREACH(vdev, &amp;virtio_list, next) {
-        DeviceState *dev = DEVICE(vdev);
-
-        if (strcmp(dev-&gt;canonical_path, path) != 0) {
-            continue;
+    Error *err = NULL;
+    char *basename;
+
+    /* Append 'virtio-backend' to path if needed */
+    basename = g_path_get_basename(path);
+    if (strcmp(basename, &quot;virtio-backend&quot;)) {
+        GString *temp = g_string_new(path);
+        char *last = strrchr(path, '/');
+        if (g_strcmp0(last, &quot;/&quot;)) {
+            g_string_append(temp, &quot;/virtio-backend&quot;);
+        } else {
+            g_string_append(temp, &quot;virtio-backend&quot;);
         }
+        path = g_strdup(temp-&gt;str);
+        g_string_free(temp, true);
+    }
 
-        Error *err = NULL;
-        QObject *obj = qmp_qom_get(dev-&gt;canonical_path, &quot;realized&quot;, &amp;err);
-        if (err == NULL) {
-            GString *is_realized = qobject_to_json_pretty(obj, true);
-            /* virtio device is NOT realized, remove it from list */
-            if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
-                g_string_free(is_realized, true);
-                qobject_unref(obj);
-                QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
-                return NULL;
-            }
+    /* Verify the canonical path is a virtio device */
+    Object *obj = object_resolve_path(path, NULL);
+    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
+        object_unref(obj);
+        return NULL;
+    }
+
+    /* Verify the virtio device is realized */
+    QObject *qobj = qmp_qom_get(path, &quot;realized&quot;, &amp;err);
+    if (err == NULL) {
+        GString *is_realized = qobject_to_json_pretty(qobj, true);
+        if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
             g_string_free(is_realized, true);
-        } else {
-            /* virtio device doesn't exist in QOM tree */
-            QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
-            qobject_unref(obj);
+            qobject_unref(qobj);
             return NULL;
         }
-        /* device exists in QOM tree &amp; is realized */
-        qobject_unref(obj);
-        return vdev;
+        g_string_free(is_realized, true);
+    } else {
+        qobject_unref(qobj);
+        return NULL;
     }
-    return NULL;
+    qobject_unref(qobj);
+
+    /* Get VirtIODevice object */
+    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
+    return vdev;
 }
 
 VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
index 8af5f5e65a..4b2b7875b4 100644
--- a/hw/virtio/virtio-qmp.h
+++ b/hw/virtio/virtio-qmp.h
@@ -15,13 +15,7 @@
 #include &quot;hw/virtio/virtio.h&quot;
 #include &quot;hw/virtio/vhost.h&quot;
 
-#include &quot;qemu/queue.h&quot;
-
-typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
-
-/* QAPI list of realized VirtIODevices */
-extern QmpVirtIODeviceList virtio_list;
-
+void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
 VirtIODevice *qmp_find_virtio_device(const char *path);
 VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
 VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 295a603e58..83c5db3d26 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -45,8 +45,6 @@
 #include &quot;standard-headers/linux/virtio_mem.h&quot;
 #include &quot;standard-headers/linux/virtio_vsock.h&quot;
 
-QmpVirtIODeviceList virtio_list;
-
 /*
  * Maximum size of virtio device config space
  */
@@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     vdev-&gt;listener.commit = virtio_memory_listener_commit;
     vdev-&gt;listener.name = &quot;virtio&quot;;
     memory_listener_register(&amp;vdev-&gt;listener, vdev-&gt;dma_as);
-    QTAILQ_INSERT_TAIL(&amp;virtio_list, vdev, next);
 }
 
 static void virtio_device_unrealize(DeviceState *dev)
@@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
         vdc-&gt;unrealize(dev);
     }
 
-    QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
     g_free(vdev-&gt;bus_name);
     vdev-&gt;bus_name = NULL;
 }
@@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
     vdc-&gt;stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
 
     vdc-&gt;legacy_features |= VIRTIO_LEGACY_FEATURES;
-
-    QTAILQ_INIT(&amp;virtio_list);
 }
 
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
-- 
2.39.3

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
With regards,
Daniel
</pre>
    </blockquote>
  </body>
</html>

--------------7mqsMon0z0iWHNrGEvG09pJA--

