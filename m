Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8AD743886
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:42:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAde-0000B9-8C; Fri, 30 Jun 2023 05:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qFAda-0000Af-At
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:41:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qFAdX-0005IS-LC
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:41:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35U6Xffu002881; Fri, 30 Jun 2023 09:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3OtB8zWMRofgla6+p+P/DmvHEYIANbtCFqDK4JEkxiY=;
 b=0IgJwpHeOvYFQa5FDtSoTYTZRJC5flxAk6wDlvhFMaCSuDUT7Qgag/G/nlLm4kcTsTBX
 UxB3uTGO37vVg7KYI7O9d/5vYD1TyBQHAJ15nNuIYBnpyFqwGOiAyC7YMIyALjN1TFZP
 iB0NwiiFDOj7RH2GkgQ8/dF62mMHkSsZlqFL+Xd/FHkN3bVpkCHO0P2mXbh9S4GKw2lv
 yKr83NmSCptB0lgRYrZWtN9s+m/DZXgkNJSl6+Zs3vsZaIGTJD+KLAuDQgQSBhPtdo69
 EROTiLN7OgNZlApLlDzV5h7/cBePuDVFELoYFLa0yn7gRP+ZgsUhyPLq/zNmksQHP19P KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40ee9r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 09:41:52 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35U80i1o029607; Fri, 30 Jun 2023 09:41:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8m3nb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 09:41:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/UIWG1Hh8NGSHntMz+EpHElGoA1I6avivav2pd0nFCJTlo0/0C5lp8KWueNxRe6j/cvNC/vjKMKxUaqhBgA7u2hhSSXnJsi4lQzcwBvqc7L0FCyHwLj65kduA/LctOlk40tn/fSDPsFLKQ1e3X+1fyrlJ/3B4mP1p0bc3FnbnTro5ipTGmaGB5C3fZLRXwp3Zx5t+8cAdRgK9c28DpO1wnJSH18s30XZZIkFNDqnQ8NyPn2no5PiQ4Fvm/htBQP/qBbjzpg6jxZESf4lhnf8vwoyS78DNMy5kqeU65jH2G3+1c8+PDUjOAVv4l9iDh2TQokMwIG07bcBm36VctnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OtB8zWMRofgla6+p+P/DmvHEYIANbtCFqDK4JEkxiY=;
 b=FsO9NtqtoD1FJpLDcgjMryVDvp31Nwrr4z3w1db0krkBoU7F+QDYA4HvqljTpjhe5hQ7qIVT9Yfk14pmCvwopwGPs9cAZTKKmlV6VwReBwTinATXWoWUeBu4/eZSxc35/lJHXT/BtXWgES8radRsJpi+fcK3r//vchQvU2i0PvSwGAFBZHDxg6UqKcYf1mY1rLrz7VLEBea/hqRiV1er84/taJ0ib44jvPNc6Q4LFiCzqkUf1N916VF0K/gax6w7MlsItcs9DHyC+aDbJRfyE5c82J6cgOCBOlcFzq6Q2xwUC77D5OL8LHHfLJYA1K9LoeJRtTPUAcYBr3xxYeQN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OtB8zWMRofgla6+p+P/DmvHEYIANbtCFqDK4JEkxiY=;
 b=U/YBgKBNlhbU0Di8QBi7vZTvCnyPwLSnJTmLS2/KMNjnEEZ9kkv0ZT6CJSKDwg23fH4QLwPQ3PmkVhSWcGBsq1BzHQHsbFYgPcR7/X8QKbtcJHohft2FrhMkMsnMtok8wnMxm/+7COBcHiro2NvEQ+hPBfmEm7zvovhhlDMNC7I=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CH0PR10MB7481.namprd10.prod.outlook.com (2603:10b6:610:192::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 09:41:48 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:41:48 +0000
Message-ID: <db62516c-5ed4-85ad-3134-59a2cb1943a4@oracle.com>
Date: Fri, 30 Jun 2023 10:41:41 +0100
Subject: Re: [PATCH v5 3/7] vfio/pci: Disable INTx in vfio_realize error path
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
 <20230630073637.124234-2-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230630073637.124234-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0408.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::36) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CH0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: f650bfed-ce6e-4c66-0511-08db794e399e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBQ/8Rh/l0gjodxH9hL4D8b0MNsCa/FI+AuCeRAU1szSW+qddA4OBMqKwqfo2RS1MEwcjeX3yYhWQhNaF0ubQTJASk8RrEAUpw/S3MvvtFZTAx9q+7eppuQFaG5PFaYjsQ8rzaruAQ6aRsPUFtNIPdE7ZjYmB+So1HXj7ofUkYKuTv/N9JbnYvpvIy3xZRiaxySFmvo4f8xtaXh5d85bnmPLnx9XsinwfbnrcVBY1liwuDTKNPoJuInXmyPnAUZPn+Dl22R8W2i+IJG9Z5cNmCgFIJp9i3bmsgMlTS3OG5P4S0co05fBeO1Bve7n4NUBCijjSQAP8woUSkoG63QF6vZA1fMBakABWYVbI7sPuwsI9Qp0ufQkfMg1Dg4g1FrLZq152oWpOAxLj53W1rQ6pF2a0un4jIe9v67qnMoDgQxeE/OXeqrzgwQ1szco/EC9baNp1Rn4GF6dKngX4NXBvaHyqEiN1KqvJPZZCRMtqgLbgSSUonAToaby7gDIJ6YLxSz5xGBM7p3qpvq7bKytctpJ/Xfus0xkNuVBwiu6SVlltCbRWtRRWTVx+UPkHRZopxXQUm7IrugZ0i7zg9xfDTdJ/MrCmvNCdhLCdFDW7TmrdotnMuEUYxKNiXwxsYcb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(6666004)(4744005)(53546011)(6486002)(2906002)(83380400001)(2616005)(38100700002)(26005)(186003)(6512007)(6506007)(41300700001)(86362001)(31696002)(4326008)(8676002)(5660300002)(478600001)(66946007)(66476007)(8936002)(36756003)(66556008)(316002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clhKdnJ2c3Y1REc2VWRkSTdCczFyOThGQ1AwRTM3R2hwVHNtZ3oxVksvZ1hR?=
 =?utf-8?B?eDl0NnphcHB0dm5iV3M2TmdLcFhRREhKT0paLzF1UElCaW9aUXh4ZUljUVll?=
 =?utf-8?B?S1RkSE9LeDdyaFczczZhRzBuU01oMHlEK0ZWMzRId3diVGI2MmlJTmFvU2Fr?=
 =?utf-8?B?KzhEekp5V2RzSUxwZUJQWWwxNlBZYmwvQVRFSmhEM2F3Zmw5T0taaVRoY2s5?=
 =?utf-8?B?VGJDTm52OVhDWWlmMEFvUlBsNjRRT01PYXBtNVZUZFZ1MGFJYmxydzhTdDFP?=
 =?utf-8?B?VTNrS2RERkRHNmlHT21qYUdoY3REd1ZIamdxOXdrRXQ5WUpVK2RzUThYdFpQ?=
 =?utf-8?B?M2hQWU1QUkNnbDVmZ2Q3R0pHcWM2MHdROGh3YzhMUFBFQmRUeElZVTRvZ2Ru?=
 =?utf-8?B?UnlGbEhzamRWVDFvREN2bnFENTNXMGpEY0I1M056RWlJanYvRW1tbkVPV1F5?=
 =?utf-8?B?ZjFoN2J6ekNrZ2Z2eUFkLy81blY1N2pPcDlBY3VwZE8xMlEwT1JFazhjQmwv?=
 =?utf-8?B?S055aDNMS1JhUzhTaWUwWHkwSDB5VmxvSktKUzlVdTh5c3VmWWdUdDFNT3Jp?=
 =?utf-8?B?MGJ4Z1QwQlVZL3JEb3ZLalBUZFB6TkU1N25hb1JwSkw0T28yOGhyTFU0N1hx?=
 =?utf-8?B?bXF6Qm5CUmM0MnNxWXdreXduaVBEY3VubE9xZ3d5UHFGRzEvSFVFS2lhakRo?=
 =?utf-8?B?aGFwOSszTTNteGIwUitSenJTcWZyWFIrV3diY3VrTTc5T2xwbElLdjFrQ2U4?=
 =?utf-8?B?VmpnZ1NnTnMrdTBmUE1TbU5IZVVuc3M2b2prUXJJK1pzYTVrczQ4TEtrZTFl?=
 =?utf-8?B?MEpFYVp4ejAwR1QyZFcyaTlNdTN5QS9nNUlybjJiYXBwb0ZIMmwvWlZBUCsw?=
 =?utf-8?B?eXZqWTJYTGJKcnFBWi9CRG9MY3NVNFMyZVdPMVZ1OFYwUVAxbmdsZ0ZYVTRN?=
 =?utf-8?B?UWRxUjVBMTVWdDcwT2lpTVhzZURRSlNkbUpxSDVsL3RGazBZQWkvYWwrU1ZV?=
 =?utf-8?B?Mk5SbjlleWJGbEIvMDhCRmtjc2FENG5UYUVTbUJDNlZ3MjBvRGljMFE1a3l4?=
 =?utf-8?B?dXJjY2NwbHE0aFVSTWxhMnlYbjFYK0RqaVZYOHE0eTVZTTlrcDBVdFhWMExt?=
 =?utf-8?B?OWs0MmhJQm9WZ0ZsbXhqaG5sc3o1WEZYMTJzcFMveVU2OHJNMC9CZzdJRW5t?=
 =?utf-8?B?NStzK2IvK1doRlR1Yk1lY1Y1L2U2bWZTdGVJTG9CdW9pQ2k4dGxQWG1FUUpH?=
 =?utf-8?B?OUxxRlBLa2M0bU1iaVlLSjZJQS9GU3VDUFlERFdYVnVBTks4NlMyRTlvNlpP?=
 =?utf-8?B?Rll1MXZlNDJMSG5FTmYzYndOa2FNUFJlRHlYRGcwbDBUejZmdDcyNGdreXdr?=
 =?utf-8?B?c0x3OG9IUDV4VklvVU16Y0RQZmRSdG1rWVhBWi93ZlhJTWU3MjNhNEk4RTM5?=
 =?utf-8?B?ajFaOE8vVFpjV2tYaGRraWxYbTZid2k4Q1lhVzBTWDFKeUJKS0xFRzQ2Sjdj?=
 =?utf-8?B?WHRGSXgySFg0NTdtQVQvZWlzMXdvV0FwRmxOd3dVUnIwamFQZHF4T1NGOWZk?=
 =?utf-8?B?TGw0VTVTcU1ZUDFBN1Y4ZldQVlNCdlBJc0lFendhUWdlRHlWdXR1Y0JPQjZw?=
 =?utf-8?B?S0gyazFZL0lzNEdGZDdsanVFQnZVbTh5RVZ5VUdsTFpCNWZHMEM0a0tWa3pB?=
 =?utf-8?B?T2dWaXE2dDRVdC9WdFlpS3lISFZLM2xaY2YrR2xWK2psZkd4MnlPeTRNZVhZ?=
 =?utf-8?B?dHV3ekNWZ0ZEUXRKTmRHaFFXV3Q2Nzh5S1QrWCtNcUxpSjhEVUR5ek9kQnNV?=
 =?utf-8?B?SjhQc0F4UXFHYkFJUDBBZFhZbGlQVGhmMlVQd1RscERDYzZTYlQ0SjJKVnZi?=
 =?utf-8?B?ZnFneG9HSDNSdTRabW80S2VjaFJ5RXhzWE9tYXFPbnJES3Q2RkdGNEtwVGdE?=
 =?utf-8?B?UUF4K1JzQyt4VGdITGRIdVkzR0Z1VEVzTnF0dnlyWmd4bkRValN2TE9kZ3Yr?=
 =?utf-8?B?S0xkcXd2aFJUbGNqUHdvNU4zaE84WER4dGlhbkppOGVwb2JUcS8zbnlQWFgv?=
 =?utf-8?B?U2hXVWhreUpuNWtBTEs5akpYWXp0UTBXa2NTQUpGS05oYXFYNEVBUjlNcWJT?=
 =?utf-8?B?bUV5VmU3ZnM0WkZUT3g5TUVjdTI2UlkyZjM0MjJISEMyTVdmVnRieUx0c3lO?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IprF76rKc2H6bojeyRf6jwzWrNgV42dXAi92SOTLVGzTxmlUD1YzxSfTfb/yWTzhLgFP9oLY7rjhv7zU9qw2ifhR4DbZKmtQA63ML4Lko/6dNUJdpoeoPTKvZYLzaSofI6MA2vColrhfWnhAX5YpxshwRiuk+KLyKuuEIM15TE5OYYxfPOmQtkLaU0ZzdQHqno54PsMhg61n+n2OMpvxQF1iaBSNx+r5lqzC+WOJE1AMCeT4Xzuy5WMt4J9OLMuG/IcFgQB5dCx9l1bhmERbRfhe0meWWdJHgPXaZUhTCDLefEtdtnpgbwaTDbbOUMUfnYcqVlMOhEt0j+DCIksciaFbYXVixF38q/iWHHQasJkn6KlthL094uRfySKrpAqp9u8XisD0RL+ECJvwKEhalHK1oHXkzMHT8SdyJRX54Za7mSRt69tRvzQhOmZzSVRDG0Q+MB4mGVdds+L114AypKwkp5m6ZHyKTa1XuEUF6N6PEgDnx1SvsYqRpWrCPkM/3IqFDK3fXvHNc1IRRikSAvitAJtgmSF3J6V0I0R8k4KFtrAz/LZG5+K/UxaPPFqcY9x6pls5NvzaBgCrXoI2hS4OkSexm/i3Sme7CExt+B85bJvkyrFHUY63aA8ciWgqo/nk0X2d5dndhmb5U6INeSm9yvCl0PsZL/BA4ulnEX0v5A+89WV7kl3Wa7RgWYnH/jlKLeGdoS/M/AmRY6E7sqXcdjFv6xXXwXzbuymVxsVvmZgaxu2WPyb5+izJlweaNsCiClj9gg2rjI2ZDLHNi5LDi0EMR3ajtY3rPoLWJdS9vlYhOdgoNctkNGqWng9V0s7VM+j4lezbs9fpVbr8BA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f650bfed-ce6e-4c66-0511-08db794e399e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:41:48.5876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5G/A6nsgsW6BjUYdENWRdOm5IB7uf59Nh7ND6uIFz2mK9gIVajHGTnuw9CV47cCM4JCDGiKrnGtIM/grN+DF/bqa2tPw24GugZwoFjlz+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=646 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300081
X-Proofpoint-GUID: s-AIX_WlYnHkXqFv5D7zUnjCNP2no9cw
X-Proofpoint-ORIG-GUID: s-AIX_WlYnHkXqFv5D7zUnjCNP2no9cw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 30/06/2023 08:36, Zhenzhong Duan wrote:
> When vfio realize fails, INTx isn't disabled if it has been enabled.
> This may confuse host side with unhandled interrupt report.
> 
> Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ab6645ba60af..31c4ab250fbe 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3220,6 +3220,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      return;
>  
>  out_deregister:
> +    if (vdev->interrupt == VFIO_INT_INTx) {
> +        vfio_intx_disable(vdev);
> +    }
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>      if (vdev->irqchip_change_notifier.notify) {
>          kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);

