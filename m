Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF3975A3A5
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 02:50:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMHrL-0005jr-8w; Wed, 19 Jul 2023 20:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qMHrJ-0005ip-7x
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 20:49:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qMHrE-0004gQ-DK
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 20:49:32 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JFOPL8029602; Thu, 20 Jul 2023 00:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=X3VdXgslomP1AALzrak1r926IvIuwhheZV/wPTMSzlk=;
 b=dHt95zHKxiGQPPphkkMCdKHiu/Ne09iPkk1HS0lxR5pIAOk7klAtJU34yCY7J3Xuseyt
 JNtuJB7ldfBkNLkAVmGgX+jJ6FoESaeb+QOaQYICTpSbNNBkKufYaQJtLbNvlzWDODJo
 RjfF8L4jnPRdrOJW9wo+TaUvM5kmaRSE54IVo3RjW7fzTbVYml+zzBV27DkbPvJsgidi
 Bp9kGSi+Ytw/GY8sf/9WxGxxu8LCsmr/1qjKUUiBoT2xaZ/6IHlJhghIlLPe6lVFxhu3
 Xu8DF2BLtLV/QovDvkvOqVxwNeAUWNWMV7zk2v6NZUKe5P+LuYglVFx2s2KlcPS9HQJB Lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88rrw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jul 2023 00:49:08 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36JNjgrg007848; Thu, 20 Jul 2023 00:49:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw7hpdt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jul 2023 00:49:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKQu9pjoAiqFvfAVHGJhe6X2BTZ+Ad5f+wQ7CFjA4Tl62zQLpXHYk3ajMOBFkRyMS6FvLaEMBu/tYA3tRL/MHHd8C+5+A5Ehuhpx+sfBj9JrlLZ82Yd6RLJ2TNuvubsJAgX6bsy+nfR2fpEJaYsiEPpadfpt/ZCzREikXaOii0tUehZm7Oje+sodTlun2R3WygASUZgYKN/RalddmPj/uE13OfyhgM8m3PdtAM+o2q/0r2SIN5UWRJQ3WkFznp+Vo5tXGaVTOCDYHeuIUNQrlw8pSLkjOTuL8JQvIO3Py47SXcBzsb+xnHLpBU+ml5R1yhaPUatE1kY68h8BW9gwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3VdXgslomP1AALzrak1r926IvIuwhheZV/wPTMSzlk=;
 b=h6hOLv9Y/xpPq+62/GoevlgJCvuCncM2MlOvKF6Dq7tmqDLhDr1IZB2IZbX9K9VRWR4OgtSlb/pb2Wf3bT+Ki1kbpOo8GXA91AVem05jkDCvrEEsN6Fj4LBZwlO8WfokHVoIkmETPFCSUN1MADC2EM5ry4+TuzTCjydjMV6L9jZIWZj3sEr1P4sHKbY2DUESTcutnxkJ9x6lz+1/JLnKt2XNlf1VsAZEHCKc3IuVjQ5ti5mawoxgiH2ereQ+gtWEHiHD96KxC9kQZv/AYUfZHJgc6PRRO18Pzf7Uq4B4LyE78ABTcUPIF+EVsfQdmn3Ip4oDBptTz+29cX/Qke/5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3VdXgslomP1AALzrak1r926IvIuwhheZV/wPTMSzlk=;
 b=Qn9XSdJTW7UPDfV7s3zRG/g/n/mFex+sFjzt0i4MeyGqOXn5IHsmJ/mb30/I/9MCJt5AnMgmi1kYDadNduabqb+cDiaQOfi8qbt4ql4Sz0BWzvt2wolygGsnXVV+sr2BnjpXh1GR2FkjLLvR4ASK/77WeGYd7tCZpYY7KhswwBg=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BN0PR10MB4983.namprd10.prod.outlook.com (2603:10b6:408:121::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 00:48:57 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a%5]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 00:48:57 +0000
Message-ID: <f55d3d5a-e524-c1e2-1b00-c7f4dc6dc886@oracle.com>
Date: Wed, 19 Jul 2023 17:48:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Reducing vdpa migration downtime because of memory pin / maps
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael Tsirkin <mst@redhat.com>, Longpeng <longpeng2@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, David Gilbert <dgilbert@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
 <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
 <bff286b8-0103-1698-c77d-736417396405@oracle.com>
 <CAJaqyWcwFgEH3MCOAhHe20P3oy2_aq2BUkTA9_7wePsT8=GoAg@mail.gmail.com>
 <8db2b6cf-1e32-67eb-f6c0-fe3a4175b410@oracle.com>
 <CAJaqyWd_wb5eXcTi2R+-n=AriP=rwKTCwObz1sZ45eRrpLw_wQ@mail.gmail.com>
 <a73797a7-a71d-9ac9-f92b-6bfad2c79058@oracle.com>
 <CAJaqyWcDLG3zG3-4Ht=ebWh-yAXY=srazwuOv1jy3sR-+dPfqg@mail.gmail.com>
 <88be4f76-f03d-fd50-8eaf-c6f7f7d31810@oracle.com>
 <CAJaqyWd-Zbe3dSo_biV7z_gQ=stk738B1qS6R8cnoz2RR_awHg@mail.gmail.com>
 <8f3d011a-457f-a104-e7a8-4a3e430acd5e@oracle.com>
 <CAJaqyWdaHmDHoZ4SuxsJdNgvh18jMoZkEgC8dhCB7NGZM-S5wg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWdaHmDHoZ4SuxsJdNgvh18jMoZkEgC8dhCB7NGZM-S5wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BN0PR10MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a58aa2-df80-43b9-2281-08db88bb1999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yB+NT33cEng21eDQ9ayUyOhrtJViKxetQaVA8r80s4UIB/KtZBqfa2TYOyolYX8xYJCdcUGwYMX7h/0HYWAiV8IRgM+78uw8DVdyXhIgHTSvGcYXIdah2qGQQSz8oOqUKt5oZUfLLm/8PB0DS9hQAm1GMRn9ndCNan78rzU1R3S/Xw1o5hP52GeET91THFui+rrEm/VRg7Njv6IlkRp3JR3hjhIoY8B+f0YbldXCXa4FEVkCptKsyFNOg3HBHYf+S3iSJZ7BGXJCpPkUdtDTX6Cr2RRf0c3Pt+KgiI45Gf20LyM1fToAy5mEXgd8AncWUsq1h6busCoVp9pA/pmlub5iBRvR7mGvu4a4mizZRxoqfc3hVC3cgkqh07rZGQG9wHyrLyb3Wvn7ea4HpeUDKWDUi2wYFVIPgLZmZPZZTl+Mc635IpAhY2yDB4NPKFEXCWyf2u7NqcXnFilpgeMNHQ0xC8m3R2cbCPFTPzO/9SzsIGKcwcYZvGbVjhzjyK+LFbljKgZk5I7SN6qnRAbvnH0+SaUKRtY+7ReZbs0wqcF5+I/Y6xW5s5uHQMMbnLPSnrhL377bzwqTaEM2uDfYf7zxpv+GW+uuiyZAguGrH1AHbL0m1BpjY3dYQPugJtfeCSa/8Vj9SGWyCF5AOp1eiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(8676002)(316002)(31686004)(41300700001)(8936002)(4326008)(6916009)(66946007)(66556008)(5660300002)(66476007)(83380400001)(38100700002)(2616005)(31696002)(478600001)(86362001)(186003)(2906002)(966005)(6506007)(26005)(30864003)(53546011)(66899021)(6666004)(7416002)(36756003)(54906003)(36916002)(6486002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Njl6ZkJrTVo1Z1gwbkNhN2pMUVB0YlpPSS9iNktieGJLOHBjK3pXeUZ5NDVj?=
 =?utf-8?B?Z29oemdkb1lNdWs5VjVGd0tmbXVIcmVQS1hTRkdxOEh1bjBMeG9QaHJFekRs?=
 =?utf-8?B?ZmViSGhSakpjbHF1UER1ZktrdU5OTzhhRjBBL3kzeCs3c0hTNnl0M0dvVjd2?=
 =?utf-8?B?SmNyZ2dSd1dPaEdmZkJvRVhmdzhpMXFGYmZoeTQwTFFQKzhueFZuTlhCNHV3?=
 =?utf-8?B?d3J2KzNJNmZ4eU5uc3BLMFJKb0d6eXBra0J3d3VSckl0VytLUTdVWENrUEdi?=
 =?utf-8?B?UktRR3NhU1p0WFJOMmJzZ3lPT1p4bmJid1lEaGtIeFdSUVh5dnJpVjkrRTRa?=
 =?utf-8?B?SXI1S2RPNWVRZVQ5VUNXTEJ2NDQ3d1g3b1N3TldTRFlyZjUwckN3RFJtUW5y?=
 =?utf-8?B?czFZRlowM3ZnWkZUUzZ3bGkzcUg4MFZzZGpoOGJrY1Y4Uk9sa1B6aG10WGZ6?=
 =?utf-8?B?R1RPRVViSTRRaHVLcnNmU2FCU2E3ZnJkQUNQZFZpVGlnSVlRd2FUUUxaNnhZ?=
 =?utf-8?B?K0JaNGRLeXJTd05wOE1sNll5Vmg3KzhnTE5SdHdYeDlReWEydVQ1N3RjOGdu?=
 =?utf-8?B?U3lXd3I0dXAvaHZ1K0V4QUZjTVh6dXBXUUlQb1diRlRyWlV1eVNiY1BkVmNT?=
 =?utf-8?B?S09XZEkwdkthN1BLcWw1NmdtKzAvblB1OWxDdU0raEt5OUFsZmExUVhLLy8r?=
 =?utf-8?B?Y2YraC9ocEx0K3FNZFVnNGdtb0xsK25Nd3VpQ3pTRGkvVStuQSthMms4VmEv?=
 =?utf-8?B?VnJWQ0ZnL1ErcGtYa0xrUkNINFhoR3AzWDBscFY0dVZKaFZvYzJGRGtuMXdV?=
 =?utf-8?B?amY5RzJTR1ZFNVJkN1VGamJmYXRTU0k1YXl6RWlTVDdvMjgzNHoxMWhOaFEx?=
 =?utf-8?B?clBJaWQwUWtoYnhGQ0hvb3JKWGt2TXdraVJrR0tjMjdDeTJMZy9zQUp4VHcv?=
 =?utf-8?B?TVY0ZU9JUmhzQno1SjlkVmZCcXhGbGROYzhrV0pPa2tqTWdCUitKejZzRkFH?=
 =?utf-8?B?ajN4YTRrRXl0cWFSZ29nUEtNN0RVSU5Mc1NPeGlxNll2eFUveVpUOXJXNDI5?=
 =?utf-8?B?SUtuTnpVVFNveU9vV0dNOStjNlYzRTk0MGdveng3UndUbHdXc2UzQXV6ZjBQ?=
 =?utf-8?B?TVowWlplL3BBTzczbVhvb0FtcWFjNDdRN1AzSVdrcWVZWHE0TU1PL1VZSUU3?=
 =?utf-8?B?V2dTb0hpd3NsOVcwTnVqQ0t2M3dOMWRNYmhyWitmSE9TbUpNMVZybW5teDFu?=
 =?utf-8?B?UWlPc3RicWxQVjk4QjZvMktlVEZXeEZWUTNYcmt1YUhjZHd3R3p1TVRaQ0RW?=
 =?utf-8?B?M3I1R0Z5L0RjUTRBakQrQThld0F5cXk5cnlMWERLc1N2SUh1NVU5di9PMTJG?=
 =?utf-8?B?K2xWTTVMdjhEczZhV1I2ZWdMQXVyNlU3cmhHelgzdDYzTkNvQmJ6emxrMExK?=
 =?utf-8?B?NExVNGZQQ3JuT01wL2wxVmxBVEs4VkV0UjFsZkJPRDBrNTNFREl5MFN4MDJV?=
 =?utf-8?B?cm5PRU5ncGVpNlpxM0czd0k4dzMxNWMvcy8vNzhMZ05kQ1loSjNQTWNSbWFR?=
 =?utf-8?B?b2tNNnlXc2N2RU1XSkJFS3FodmJqVmRLOEt2aVAvTzB2UGFVeUI3S0I5d0pH?=
 =?utf-8?B?SWdvejhXM3N5YzhiLzVlN2JUdlBuVGlZLzdTMzlpaXNVR2RxR3pzeU94Mk9L?=
 =?utf-8?B?TlgyQm1FQUpUdVVCVUFHTTA3R0FmRjM1ck0zRVdHWWpmdkZpVEp1d1ZnNVlP?=
 =?utf-8?B?YnZQWEE3V29ORjJYWDlmSWI3Z09EaHRrbmRUak8yRDF5NlhlM2VNR3ZSdHl1?=
 =?utf-8?B?ZWpZcFNpRFRmdURqS29LOERRMjZnVU9tVnpJdDRNeU1zeHp4VnRTVzBmTFFo?=
 =?utf-8?B?TW03bnRod1B3ZlFDTmMzVEM2dURyc2xUWWU0V3lUeFJpa1F2ZDByVUNYRjVQ?=
 =?utf-8?B?MXBaaVowY3luanh0UERRK1BUNHNxeThDa1dnQXBHNVZ6M2pBSjMxMm9ZQTdo?=
 =?utf-8?B?bmZkR1RFejVnZlU4ay8xWXRycEVhTmJMUzZYQ3l1ekZVbHNMR1AyTmJnYXNm?=
 =?utf-8?B?WExRdDZ4QmlLKzY1ZnhtRDdhYWhQMVQwZlliOGJ5TVNta3dmeEZRazhYRldB?=
 =?utf-8?Q?mLmyDGKfxYtPFo3Vo+fblMz7L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xEbp/9v9eE1W5dycnX3slpBpWI0Dx5FW+ZVL8Nia2px4S9dO0Q+aGhpbk0z1zWg2g5gWRXct3IyPddxeDn3xVojHnJ4iRGMmWQjGOBvuHLfZSbMSbnekRJMOMOK5kKY1RB8O8iIoA79Msa4CXyGY6aFY+gyh16ORvQmuL4WMEM6Boog6xlZVv5/an7tq/+ishFmA2aaR/GXaimk9hw1jGjmsoyJe+5GsYMnsoblzzJCSy5zVFIf2xD1qJmlv/nRsEFsVE0auZ+vT/RA03QAzfISerrQwgKqza7JeOVtUCuWy8vDywk1exDyGh4foqS7lgBjQ3VaAc6xFu3E2mtTrJt1ViHOIqTpP/bdr29SALfUpFnBkcGnIy2GUmtFAJM4OJz7SS4AE307iqvEVMPMoe15eZAnhqRTa9AwJaPo/evEznNVTyqvqyZ9nMxsvnixiYQwyzkWrJHReSbK03FkCe8SGw68a9MRLwzROw3uW1QWbu4gMFyJehxzfPIi3+MVkYkMCyk3UtRmqgxjrsx/6CkUEcMqEu/H6cA7PiWVZGI5rcfjwmYt/gCvC2zvAKOAwyINAXImoeUMrQ6HXtkOOOmTA0faSxiXvIa5t2fXfrPmJEa3CO1xrBW+eS4w6Y+cz7wwDfLrxg3zYCfmgtwL5GsAmGFBkYORqusdh8VAngLA+25HKTj3Zgp5RP+ZGmTNDwcUojJd7m0bFtrtezPDa99SpETD2cbHYAVIWywMzTBDwbqgiX2ITuJZ9sy5C9YyZBh4hL7e/YM2ohykHUHQ2wo1ZMGBEqN1kO8cV73kBCGkzkAGqQ3nm3y5NkiErnBs1kHQFihXueK/qY6f5QZvxSg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a58aa2-df80-43b9-2281-08db88bb1999
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 00:48:57.4591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqKkIJXrdsHChaijRx/qrqQjBzQnaJWEbrnvlwAReeSdghHOyQKpEV7ji7ilVmWS+6Kgax3+PxgoqFDh95FhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200006
X-Proofpoint-GUID: GeII2aWIjxFSc1VBuq9PxEoN5nHBUAN9
X-Proofpoint-ORIG-GUID: GeII2aWIjxFSc1VBuq9PxEoN5nHBUAN9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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



On 7/19/2023 3:40 AM, Eugenio Perez Martin wrote:
> On Mon, Jul 17, 2023 at 9:57 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Hey,
>>
>> I am now back from the break. Sorry for the delayed response, please see
>> in line.
>>
>> On 7/9/2023 11:04 PM, Eugenio Perez Martin wrote:
>>> On Sat, Jul 8, 2023 at 11:14 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 7/5/2023 10:46 PM, Eugenio Perez Martin wrote:
>>>>> On Thu, Jul 6, 2023 at 2:13 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 7/5/2023 11:03 AM, Eugenio Perez Martin wrote:
>>>>>>> On Tue, Jun 27, 2023 at 8:36 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On 6/9/2023 7:32 AM, Eugenio Perez Martin wrote:
>>>>>>>>> On Fri, Jun 9, 2023 at 12:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>> On 6/7/23 01:08, Eugenio Perez Martin wrote:
>>>>>>>>>>> On Wed, Jun 7, 2023 at 12:43 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>>>> Sorry for reviving this old thread, I lost the best timing to follow up
>>>>>>>>>>>> on this while I was on vacation. I have been working on this and found
>>>>>>>>>>>> out some discrepancy, please see below.
>>>>>>>>>>>>
>>>>>>>>>>>> On 4/5/23 04:37, Eugenio Perez Martin wrote:
>>>>>>>>>>>>> Hi!
>>>>>>>>>>>>>
>>>>>>>>>>>>> As mentioned in the last upstream virtio-networking meeting, one of
>>>>>>>>>>>>> the factors that adds more downtime to migration is the handling of
>>>>>>>>>>>>> the guest memory (pin, map, etc). At this moment this handling is
>>>>>>>>>>>>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, the
>>>>>>>>>>>>> destination device waits until all the guest memory / state is
>>>>>>>>>>>>> migrated to start pinning all the memory.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The proposal is to bind it to the char device life cycle (open vs
>>>>>>>>>>>>> close),
>>>>>>>>>>>> Hmmm, really? If it's the life cycle for char device, the next guest /
>>>>>>>>>>>> qemu launch on the same vhost-vdpa device node won't make it work.
>>>>>>>>>>>>
>>>>>>>>>>> Maybe my sentence was not accurate, but I think we're on the same page here.
>>>>>>>>>>>
>>>>>>>>>>> Two qemu instances opening the same char device at the same time are
>>>>>>>>>>> not allowed, and vhost_vdpa_release clean all the maps. So the next
>>>>>>>>>>> qemu that opens the char device should see a clean device anyway.
>>>>>>>>>> I mean the pin can't be done at the time of char device open, where the
>>>>>>>>>> user address space is not known/bound yet. The earliest point possible
>>>>>>>>>> for pinning would be until the vhost_attach_mm() call from SET_OWNER is
>>>>>>>>>> done.
>>>>>>>>> Maybe we are deviating, let me start again.
>>>>>>>>>
>>>>>>>>> Using QEMU code, what I'm proposing is to modify the lifecycle of the
>>>>>>>>> .listener member of struct vhost_vdpa.
>>>>>>>>>
>>>>>>>>> At this moment, the memory listener is registered at
>>>>>>>>> vhost_vdpa_dev_start(dev, started=true) call for the last vhost_dev,
>>>>>>>>> and is unregistered in both vhost_vdpa_reset_status and
>>>>>>>>> vhost_vdpa_cleanup.
>>>>>>>>>
>>>>>>>>> My original proposal was just to move the memory listener registration
>>>>>>>>> to the last vhost_vdpa_init, and remove the unregister from
>>>>>>>>> vhost_vdpa_reset_status. The calls to vhost_vdpa_dma_map/unmap would
>>>>>>>>> be the same, the device should not realize this change.
>>>>>>>> This can address LM downtime latency for sure, but it won't help
>>>>>>>> downtime during dynamic SVQ switch - which still needs to go through the
>>>>>>>> full unmap/map cycle (that includes the slow part for pinning) from
>>>>>>>> passthrough to SVQ mode. Be noted not every device could work with a
>>>>>>>> separate ASID for SVQ descriptors. The fix should expect to work on
>>>>>>>> normal vDPA vendor devices without a separate descriptor ASID, with
>>>>>>>> platform IOMMU underneath or with on-chip IOMMU.
>>>>>>>>
>>>>>>> At this moment the SVQ switch is very inefficient mapping-wise, as it
>>>>>>> unmap all the GPA->HVA maps and overrides it. In particular, SVQ is
>>>>>>> allocated in low regions of the iova space, and then the guest memory
>>>>>>> is allocated in this new IOVA region incrementally.
>>>>>> Yep. The key to build this fast path for SVQ switching I think is to
>>>>>> maintain the identity mapping for the passthrough queues so that QEMU
>>>>>> can reuse the old mappings for guest memory (e.g. GIOVA identity mapped
>>>>>> to GPA) while incrementally adding new mappings for SVQ vrings.
>>>>>>
>>>>>>> We can optimize that if we place SVQ in a free GPA area instead.
>>>>>> Here's a question though: it might not be hard to find a free GPA range
>>>>>> for the non-vIOMMU case (allocate iova from beyond the 48bit or 52bit
>>>>>> ranges), but I'm not sure if easy to find a free GIOVA range for the
>>>>>> vIOMMU case - particularly this has to work in the same entire 64bit
>>>>>> IOVA address ranges that (for now) QEMU won't be able to "reserve" a
>>>>>> specific IOVA ranges for SVQ from the vIOMMU. Do you foresee this can be
>>>>>> done for every QEMU emulated vIOMMU (intel-iommu amd-iommu, arm smmu and
>>>>>> virito-iommu) so that we can call it out as a generic means for SVQ
>>>>>> switching optimization?
>>>>>>
>>>>> In the case vIOMMU allocates a new block we will use the same algorithm as now:
>>>>> * Find a new free IOVA chunk of the same size
>>>>> * Map this new SVQ IOVA, that may or may not be the same as SVQ
>>>>>
>>>>> Since we must go through the translation phase to sanitize guest's
>>>>> available descriptors anyway, it has zero added cost.
>>>> Not sure I followed, this can work but doesn't seem able to reuse the
>>>> old host kernel mappings for guest memory, hence still requires remap of
>>>> the entire host IOVA ranges when SVQ IOVA comes along. I think by
>>>> maintaining 1:1 identity map on guest memory, we don't have to bother
>>>> tearing down existing HVA->HPA mappings in kernel thus save the
>>>> expensive pinning calls at large. I don't clearly see under this scheme,
>>>> how the new SVQ IOVA may work with potential conflict on IOVA space from
>>>> hotplugged memory - in this case the 1:1 IOVA->GPA identity guest memory
>>>> mapping can't be kept.
>>>>
>>> There is no need to maintain the 1:1 for memory mapped after the
>>> pinning. The bigger reason to maintain them is to reduce the downtime
>>> because of pinning.
>> Yes, if guest users don't care about SVQ switching downtime there's no
>> need to maintain 1:1, and SVQ translation like today should work for
>> them. However most live migration users who care about downtime during
>> live migration also care about the downtime for SVQ switching - you
>> don't want to say that brownout time like 300ms or so in the mid of live
>> migration at the cost of complete service loss of 4 to 5 seconds at the
>> start of migration is a win to them. What I said above has the
>> presumption that we both are looking at (the possibility of) a
>> generic/software way to optimize/reduce pinning overhead on the downtime
>> - say what can be done at QEMU level or host kernel to avoid pinning (at
>> SVQ switch) rather than put burden on every hardware vendor to implement
>> a separate ASID for SVQ.
>>
> Your assumption is right, let's talk in the example as I think it
> would be easier to continue this.
>
>>> After that, we can reuse the method we're using at
>>> this moment, looking for a new free hole for the new map. ew only need
>>> to pin the new map.
>> Consider this sequence:
>> - initially host device uses original GPA for guest memory mapping
>> - live migration starts off, QEMU's iova tree maps guest memory GPA 1:1
>> to IOVA
> GPA is already mapped & pinned, there is no need to map it again. all
> the remapping is done at the moment, and what I'm proposing is to not
> to do so.
Right, depending on the specific term but what I was saying is IOVA to 
GPA translation in QEMU's IOVA tree is 1:1 as is.
>
>> - SVQ new maps allocated from a free hole on iova tree that happen to
>> fall just above the IOVA range for guest memory GPA
>> - new memory hot plugged to guest while migration is still going on in
>> source host. although this hot plugged memory region sits right above
>> the guest memory blocks in guest memory space (GPA), it will get new map
>> in a separate range (not 1:1 mapped to GPA any more!) from the QEMU iova
>> tree. Since QEMU mediates and translates virtqueue access to memory via
>> SVQ (all guest memory maps to the same IOVA for SVQ), so far so good
>> - for some reason live migration fails before VM is able to be migrated
>> to the destination host, VM has to resume from the source host immediately
>> - since live migration had failed, QEMU will unmap SVQ vrings from the
>> IOVA tree and then stop shadowing virtqueue access
>> - the host vDPA device now has incorrect passthrough GPA mapping for the
>> part of newly plugged guest memory, as that belongs to the IOVA range
>> where SVQ translation is in use
>>
> I'm assuming we can also support <300ms downtime in that case of
> memory hotplug, and that the pin / unpin of SVQ regions is bearable.
>
> As a first step, we can also move the SVQ vrings IOVA in the event of
> hot-plugging memory. but that would require a restart of the device
> unless RING_RESET is supported. Would that improve the situation?
Hmmm, this may help somehow but restart happens to run conflict with our 
goal to remove any (device) reset in favor of suspend&resume for better 
downtime at LM migration source, and in this case SVQ vring movement as 
well. As mentioned in the meeting, device/ring reset usually falls on 
the hardware slow path, reset latency grows linearly with number of 
queues. It's still being evaluated what will work best on the specific 
hardware, but just want to let you aware that we'd like to get rid of 
any latent scalability blocker from the performance path.
> Another solution is to effectively be smarter in the case of a DMA
> remap, and not unpin memory that is going to be pin anyway.
Yes, that's the goal, though not sure what the "smarter" solution that 
could be. Does it look like what I said below with complex IOVA tree trick?

Thanks,
-Siwei
>
>> Although it might not be easy for SVQ vrings and plugged memory to
>> collide on the same GPA/IOVA range, this is something we should prevent
>> from happening in the first place I'd assume. You can say we only look
>> from higher IOVA ranges to map SVQ so that the lower range can be
>> reserved for latent hot plug memory, but this still needs complicated
>> implementation to deal with IOVA range fragmentation and special
>> collision prevention from breaking the 1:1 map to guest memory space.
>>
>> Regards,
>> -Siwei
>>
>>>>> Another option would be to move the SVQ vring to a new region, but I
>>>>> don't see any advantage on maintaining 1:1 mapping at that point.
>>>> See above. For pinning avoidance point of view (i.e. QEMU software
>>>> optimization on SVQ switching downtime), I think it's crucial to
>>>> maintain 1:1 mapping and move SVQ vring to a specific region. But I'm
>>>> not sure how complex it will be for QEMU to get it implemented in a
>>>> clean way.
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>>> If this QEMU/vIOMMU "hack" is not universally feasible, I would rather
>>>>>> build a fast path in the kernel via a new vhost IOTLB command, say
>>>>>> INVALIDATE_AND_UPDATE_ALL, to atomically flush all existing
>>>>>> (passthrough) mappings and update to use the SVQ ones in a single batch,
>>>>>> while keeping the pages for guest memory always pinned (the kernel will
>>>>>> make this decision). This doesn't expose pinning to userspace, and can
>>>>>> also fix downtime issue.
>>>>>>
>>>>>>>      All
>>>>>>> of the "translations" still need to be done, to ensure the guest
>>>>>>> doesn't have access to SVQ vring. That way, qemu will not send all the
>>>>>>> unmaps & maps, only the new ones. And vhost/vdpa does not need to call
>>>>>>> unpin_user_page / pin_user_pages for all the guest memory.
>>>>>>>
>>>>>>> More optimizations include the batching of the SVQ vrings.
>>>>>> Nods.
>>>>>>
>>>>>>>>> One of the concerns was that it could delay VM initialization, and I
>>>>>>>>> didn't profile it but I think that may be the case.
>>>>>>>> Yes, that's the concern here - we should not introduce regression to
>>>>>>>> normal VM boot process/time. In case of large VM it's very easy to see
>>>>>>>> the side effect if we go this way.
>>>>>>>>
>>>>>>>>>       I'm not sure about
>>>>>>>>> the right fix but I think the change is easy to profile. If that is
>>>>>>>>> the case, we could:
>>>>>>>>> * use a flag (listener->address_space ?) and only register the
>>>>>>>>> listener in _init if waiting for a migration, do it in _start
>>>>>>>>> otherwise.
>>>>>>>> Just doing this alone won't help SVQ mode switch downtime, see the
>>>>>>>> reason stated above.
>>>>>>>>
>>>>>>>>> * something like io_uring, where the map can be done in parallel and
>>>>>>>>> we can fail _start if some of them fails.
>>>>>>>> This can alleviate the problem somehow, but still sub-optimal and not
>>>>>>>> scalable with larger size. I'd like zero or least pinning to be done at
>>>>>>>> the SVQ switch or migration time.
>>>>>>>>
>>>>>>> To reduce even further the pinning at SVQ time we would need to
>>>>>>> preallocate SVQ vrings before suspending the device.
>>>>>> Yep. Preallocate SVQ vrings at the start of migration, but before
>>>>>> suspending the device. This will work under the assumption that we can
>>>>>> reserve or "steal" some ranges from the GPA or GIOVA space...
>>>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>
>>>>>>>>>> Actually I think the counterpart vhost_detach_mm() only gets
>>>>>>>>>> handled in vhost_vdpa_release() at device close time is a resulting
>>>>>>>>>> artifact and amiss of today's vhost protocol - the opposite RESET_OWNER
>>>>>>>>>> call is not made mandatory hence only seen implemented in vhost-net
>>>>>>>>>> device today. One qemu instance could well exec(3) another new qemu
>>>>>>>>>> instance to live upgrade itself while keeping all emulated devices and
>>>>>>>>>> guest alive. The current vhost design simply prohibits this from happening.
>>>>>>>>>>
>>>>>>>>> Ok, I was not aware of this. Thanks for explaining it!
>>>>>>>>>
>>>>>>>>>>>>>         so all the guest memory can be pinned for all the guest / qemu
>>>>>>>>>>>>> lifecycle.
>>>>>>>>>>>> I think to tie pinning to guest / qemu process life cycle makes more
>>>>>>>>>>>> sense. Essentially this pinning part needs to be decoupled from the
>>>>>>>>>>>> iotlb mapping abstraction layer, and can / should work as a standalone
>>>>>>>>>>>> uAPI. Such that QEMU at the destination may launch and pin all guest's
>>>>>>>>>>>> memory as needed without having to start the device, while awaiting any
>>>>>>>>>>>> incoming migration request. Though problem is, there's no existing vhost
>>>>>>>>>>>> uAPI that could properly serve as the vehicle for that. SET_OWNER /
>>>>>>>>>>>> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection against
>>>>>>>>>>>> introducing a new but clean vhost uAPI for pinning guest pages, subject
>>>>>>>>>>>> to guest's life cycle?
>>>>>>>>>>>>
>>>>>>>>>>> I think that to pin or not pin memory maps should be a kernel
>>>>>>>>>>> decision, not to be driven by qemu.
>>>>>>>>>> It's kernel decision for sure. I am with this part.
>>>>>>>>>>
>>>>>>>>>>> I'm not against it if needed, but
>>>>>>>>>>> let me know if the current "clean at close" address your concerns.
>>>>>>>>>> To better facilitate QEMU exec (live update) case, I propose we add new
>>>>>>>>>> vhost uAPI pair for explicit pinning request - which would live with
>>>>>>>>>> user mm's, or more precisely qemu instance's lifecycle.
>>>>>>>>>>
>>>>>>>>> Ok I see your problem better now, but I think it should be solved at
>>>>>>>>> kernel level. Does that live update need to forcefully unpin and pin
>>>>>>>>> the memory again,
>>>>>>>> No, it should avoid the unpin&pin cycle, otherwise it'd defeat the
>>>>>>>> downtime expectation. The exec(3)'d process should inherit the page
>>>>>>>> pinning and/or mlock accounting from the original QEMU process, while
>>>>>>>> keeping original page pinning intact. Physical page mappings for DMA can
>>>>>>>> be kept as is to avoid the need of reprogramming device, though in this
>>>>>>>> case the existing vhost iotlb entries should be updated to reflect the
>>>>>>>> new HVA in the exec(3)'d QEMU process.
>>>>>>>>
>>>>>>>>>       or that is just a consequence of how it works the
>>>>>>>>> memory listener right now?
>>>>>>>>>
>>>>>>>>> Why not extend the RESET_OWNER to the rest of devices? It seems the
>>>>>>>>> most natural way to me.
>>>>>>>> Not sure, I think RESET_OWNER might be too heavy weighted to implement
>>>>>>>> live update, and people are not clear what the exact semantics are by
>>>>>>>> using it (which part of the device state is being reset, and how
>>>>>>>> much)... In addition, people working on iommufd intended to make this a
>>>>>>>> "one-shot" ioctl e.g. CHANGE_OWNER instead of RESET_OWNER+SET_OWNER:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/kvm/Y5Ibvv9PNMifi0NF@ziepe.ca/
>>>>>>>>
>>>>>>>> New uAPI to just change ownership of mm seems a better fit to me...
>>>>>>>>
>>>>>>> I'm not sure about the right solution here, but there are other
>>>>>>> proposals to batch ioctls. But maybe creating a new one fits better.
>>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> -Siwei
>>>>>>>>
>>>>>>>>> Thanks!
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>>> Another concern is the use_va stuff, originally it tags to the device
>>>>>>>>>>>> level and is made static at the time of device instantiation, which is
>>>>>>>>>>>> fine. But others to come just find a new home at per-group level or
>>>>>>>>>>>> per-vq level struct. Hard to tell whether or not pinning is actually
>>>>>>>>>>>> needed for the latter use_va friends, as they are essentially tied to
>>>>>>>>>>>> the virtio life cycle or feature negotiation. While guest / Qemu starts
>>>>>>>>>>>> way earlier than that. Perhaps just ignore those sub-device level use_va
>>>>>>>>>>>> usages? Presumably !use_va at the device level is sufficient to infer
>>>>>>>>>>>> the need of pinning for device?
>>>>>>>>>>>>
>>>>>>>>>>> I don't follow this. But I have the feeling that the subject of my
>>>>>>>>>>> original mail is way more accurate if I would have said just "memory
>>>>>>>>>>> maps".
>>>>>>>>>> I think the iotlb layer in vhost-vdpa just provides the abstraction for
>>>>>>>>>> mapping, not pinning. Although in some case mapping implicitly relies on
>>>>>>>>>> pinning for DMA purpose, it doesn't have to tie to that in uAPI
>>>>>>>>>> semantics. We can do explicit on-demand pinning for cases for e.g.
>>>>>>>>>> warming up device at live migration destination.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> I still consider the way to fix it is to actually delegate that to the
>>>>>>>>>>> kernel vdpa, so it can choose if a particular ASID needs the pin or
>>>>>>>>>>> not. But let me know if I missed something.
>>>>>>>>>> You can disregard this for now. I will discuss that further with you
>>>>>>>>>> guys while bind_mm and per-group use_va stuffs are landed.
>>>>>>>>>>
>>>>>>>>>> Thanks!
>>>>>>>>>> -Siwei
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Thanks!
>>>>>>>>>>>
>>>>>>>>>>>> Regards,
>>>>>>>>>>>> -Siwei
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> This has two main problems:
>>>>>>>>>>>>> * At this moment the reset semantics forces the vdpa device to unmap
>>>>>>>>>>>>> all the memory. So this change needs a vhost vdpa feature flag.
>>>>>>>>>>>>> * This may increase the initialization time. Maybe we can delay it if
>>>>>>>>>>>>> qemu is not the destination of a LM. Anyway I think this should be
>>>>>>>>>>>>> done as an optimization on top.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Any ideas or comments in this regard?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>


