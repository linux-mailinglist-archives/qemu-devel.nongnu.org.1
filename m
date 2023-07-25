Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDFA7622AE
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 21:51:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOO2f-00018a-4B; Tue, 25 Jul 2023 15:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOO2a-000188-Rx
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:49:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOO2W-0002MQ-UU
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:49:52 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36P9nZhg005772; Tue, 25 Jul 2023 12:49:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=Hdh2ZsZIxzwrpyvMbQwK9Y4VsYcX7enQWHDrNtVJ1
 G8=; b=Px4e+cqKooh+8NGCPkfa7lD1QBN9w/MHZGLcDwp17A4zzYfJUwdHTA/iG
 HSvoXzwDU62YcDudplTWGQDSMrmwHG7qk8SzQEAdTBKNRJqBz+5Lem4DRymUpHCq
 vHvCQdinkUTJHh8GBQwNaQf2A1Ugs5OmNlHP3hY+bE5PpbYCtpACTroFf5WyJm8d
 UkU3nJyBcrAwFXp5LLD5tZzZa+JFO3fVNJBLCvEMiSJgUt8qM34yAaTfG/ZJdSd2
 H2oCGKgu0QGnGfMr630T2rzBDfQ5oX9wHIzxDMdtsuCj96T5SCsOpbsKkBCIGGzA
 ++7B+vSHwDl9VXOQipQPVAheiXGwg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0beqxhx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 12:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifzZ4FA5CybpSFpJMhC/jXah0zqIy0yBNRxS0EGTha2ZJX9ghxzFbQejyOsmZCfoRPia/ZMmqjhjgfeOiHUhXq7WD91V1Y4ovK6fx42TJGVetw2s/WZHUR+V05HQOEKW/mGfR9J2y7F0y7P08xW10SLAshSvK/ObMVWyuq+bPg6gKfC5C684MycEW8B0/L8fTu5O9Ljm5QuXIpAwBPMV+UfT29VeRmtTAsLH3EMt71exyysmcOwnh+Pqoil7MUj2HeL9CsiC7dXb2wWYbVYcYHrW8IgVyVRIPj444AfVl2Mb6e5RZPZwNVWEpPOiJjjJLCEWG6zA5EX03lUx0Xc5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hdh2ZsZIxzwrpyvMbQwK9Y4VsYcX7enQWHDrNtVJ1G8=;
 b=NdNYAUVOB4MtIFC9PjDMaCZSWjS67SmfbpE0nyLoEuYJwpZFyv8UeGb8j31g+BtmjFPGSxndFtnZ7z7EYwTzOz02K3+VpvIGDuU4rW/2JTQL5Ayfq2wE76UIkpHD6GupN40CiPsHnmHq58kgApl5Bz+G236lVJKdB7/jo29je54ospO7pw9b9lLJKUIWs0i4tVNqbLaqoc4RdrB5ENINOt0lIDtxKVtjP71u4p2pJ57PjOxALyfahU6aHou2O4zfZRJy/BRO4VWm870Urlgf8grUCP0MH+E97kt40Yn+G2bSdwYRPQXL6wPW/VY6aP24ZIEVGYcN1j9mkah27xsMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdh2ZsZIxzwrpyvMbQwK9Y4VsYcX7enQWHDrNtVJ1G8=;
 b=iWl3lBmnU8trT5Qi1aptlWATHgnNecK+pLm3ftiA6AXQI23dZdSY9GmSZJfM9h+kLtc0rth8/Fk3R/NRIc+qUrKXdMg2RyK+yvczHK+KncPMpYFeT8WZZlsGzeNdisUaEX/qqnrJgSuzVuvGXMfl4x3OcKsiV3hHco5OIn5S/IfcKgdr/3QfeugFO1YLbuEWCQguD1eI1x8bcnzbCi3zuR2+thYb3xDhJ7kwN6iIE6GZebmBnVtSBjdGdpjzQJqidCQbYjmqBc+DBKvfhSHpQN0u3k7oYz562lMaaMuEA9N8wKjF3M1W9uLW2Xmm82zhzOMP0rBX5EzQhYoz1KG9Ew==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DS0PR02MB9175.namprd02.prod.outlook.com (2603:10b6:8:13f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Tue, 25 Jul
 2023 19:49:41 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6631.023; Tue, 25 Jul 2023
 19:49:41 +0000
Message-ID: <f4e4bc24-2a8c-b2ad-cc9e-e65ad4f4d3ca@nutanix.com>
Date: Wed, 26 Jul 2023 01:19:29 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v9 08/10] migration: Implement MigrateChannelList to qmp
 migration flow.
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Prerna Saxena <prerna.saxena@nutanix.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Aravind Retnakaran <aravind.retnakaran@nutanix.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
 <20230721144914.170991-9-het.gala@nutanix.com> <ZMAWpS7GsQUiDc7p@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZMAWpS7GsQUiDc7p@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::15) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DS0PR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca20fc4-6ca0-4b89-79f3-08db8d48494d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zf6yl3himDxBOfvNfYmTSCpwczhuPCkqa8s/iu9AA6Zg6qkmGs5e2b0N5xWg1qAwX8AbPUrOSxhn7enydbHH0NYsMXhMtYbpjtNx63kYoKRwtXPpBEJDO5sDOGQRXMEaeTO4krX9AxptJ9m/RlkrFe8sJgHgHOs05A1ZI4nmvH0u9xlFqelQQBZhkvZzHfPAH3INNJL6e+U29jgRsOKuqI9yHdquStq40kYPh8A3k1Mw7jYmjnbUPQLhYIfdYsh2zJ2cLBL1K38m7W3aJchEP/nA9biXHluPObXWED3N1HScHxUEWmRt4bpaYjIbdYdRxcE7Nlgnymi5GW9ECWAt5YPpnrUq1Gb5ui2P9qX9aeXLWL8mp/pRmI4cV4SqsM4Lg8Eb4yod01r2NthbBAGXJ83MZXdtzEXkre+H4//0W9b0TihEfDkiBE4K6OoPuorIcet/tS5uCpmz/Z09WqqpooNXXR5CdabAf5U99bvUSUg7BU7mHsiD5/ngHoKBMiDQqasqdnQIAd4THtsmKCR6x0C1XltdgpEKrdMVs9kyPni+x9qWDWUpa36dRHFfrdNYPlcBYk5kfeZ7JO0m/bcVZLLBsdWqTfcWqWMD9Dq2FTfC3dbwW+/yD0qH4v+9+gI3yAlBTPpzaLXFUnZd6k5WDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(31686004)(54906003)(478600001)(6486002)(6512007)(6666004)(86362001)(83380400001)(31696002)(36756003)(2906002)(44832011)(26005)(2616005)(107886003)(53546011)(6506007)(66476007)(38100700002)(6916009)(8676002)(316002)(41300700001)(8936002)(66946007)(5660300002)(4326008)(66556008)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNYNkF5SitCcWIvVEwvalI3bDBKeCsxZUU4N2JDdkdsRGhjci9tanBnVVpP?=
 =?utf-8?B?aERzQkRxMENMRkFPeGlrYm5vcTVGUXUvZ3lIUEZLbDhyOGFMYzE1T3pIdXNX?=
 =?utf-8?B?c0Y4SVNnaTV0NkM3bEZOME9SNnhWTjgrckZBTE9Wd1pndTVjNVdxc1VVT0Rv?=
 =?utf-8?B?ZHRYaXV4azBQVVdWWVNLYlBBMFByVGdGMk1vTmJwY29NWXgrcGJLWXh5a1BI?=
 =?utf-8?B?ZGFFajU2YThZMC9QSjBlK2Z6Z3VlYm5IVEJ5ek5IK2pzZFBITnV5QlAxSEZ3?=
 =?utf-8?B?MkFBS1l1WmNUZDdDNWw3RDd5ZytNbXNaREQwb0FCeit2dUNsTzJRUmRxeWQ2?=
 =?utf-8?B?eDVzdFpUOFRDY2t3eHVmaUIrQTlVZzI3RE1qK2RyV3NsdU44WjVWRTFTaUxh?=
 =?utf-8?B?YVZoUG1zVlhGTzVvSnBlZ2o4NGVxUzJDQm5rNG0xNGdRRDVaVmwyN3pBQVMy?=
 =?utf-8?B?UVdwTmFFNHYwSUlhMGdpYkxBcHJ6M2FyWjlGYjNiaXg4Sks0MDhSQ2k4S050?=
 =?utf-8?B?aFQvYTNmajlNclR1L3FpOCtjdHE3dDh2ZnNVZzdWTXJ4NDc0My8weEVZRXRR?=
 =?utf-8?B?QXRNR29FdjQxVldqRDVLeVQyamRoYjJHVkpjMFhVT0xTZVZLbjMwdVNVY3JS?=
 =?utf-8?B?Zm16bDU5M3VlUUFZeHlsN1FFNHFJMXBVVWNMaWI0ZG5tMzNnU0VzL3BNakpC?=
 =?utf-8?B?djFpNDIxaDFMckVXdWRlUmpicHBpc0o3SlU2Ri9mQjJiNklWVHUrNi8yQ1J6?=
 =?utf-8?B?enc5KzlQaHMzRFZ0MStXN3lxS2t4TUhYamhZdlp5QjdrRFUwTDJiaTNDMGpl?=
 =?utf-8?B?QzdPWnBTSmQ1NVlUQjhtVmVSZ3pMWkFwbThIa0RuY29EUEtsbFBFT2NZQlBJ?=
 =?utf-8?B?SjJOR0dJZ1BJU2hNallCUFJpd0hsc1pDQ29lZmpWSkJrcTF6dmoxYnR2NHpn?=
 =?utf-8?B?R0xCNUphUld0M01rZHQwWFBjOXR5MG05UGFJeG1OaHRTQVRwbVFFeFUyaHRx?=
 =?utf-8?B?Y25wZTJWU0xaaFRjT2hhMXBZWC9hdk1tYlJkMkYxQnVBMkt0TDQrZjUyWDEx?=
 =?utf-8?B?OC9ZWE9vNzlCTXFudmRueHF5eWNDaUhrclhkYUZ2NVNqM0xOWnlkWFpYak9D?=
 =?utf-8?B?Ykk2ZWRqZFNqT0lxVXBFaFl3aDB2MDIxMjZpcU1veGFvRXIzajMwOGlhTExz?=
 =?utf-8?B?N3pDUjJVVTgyN0VqNG9mczVFUXZyNUYzWXlQaFJNR2hJTTJnVVJUOHdpTWdS?=
 =?utf-8?B?Rm03OWprWkRsSWlPZ3dsN1N4M2pheUd5aWwyQ3VjZi96cmZ3NVhEUUhqZ1RO?=
 =?utf-8?B?OGExS0xHY1FBZm96SlJmREI5NTZRWjdYYnJDTzJaejUrT01LMG5jQmlGSUs1?=
 =?utf-8?B?UVNCTXNJNnlvdERBcThLQTRLeWJRL1lPRUw5eGluSDFDVTJyb2JCbU1ybVk0?=
 =?utf-8?B?MURKMXlPNko0aTV0RjF2YlduaGhOUXZFTXYzRENkWXdSa2xHOU1ETVhwU2x2?=
 =?utf-8?B?U1ZMNkFkM2p4dmRVWVE5V2l6N2k4MlkrUXdxSFZCNk00OGdRbVBaZjQ2RzA4?=
 =?utf-8?B?bU95SHZ6eFl5TWFnWS9YVzY3V1JpaXpEQ1ZtUHgvOHV5NmxSTElxNnVpb1NE?=
 =?utf-8?B?SUxhZlpRR2lNSVRsYnMxTVovVTB0dmRyaitRdW05OVJXT1dSOTcwQitldTJG?=
 =?utf-8?B?dENFRzVCaFVZcXhsUWRydkxzbStZcFZxSFBDWS9XelhTSVhJNVdtVWRYOU9Q?=
 =?utf-8?B?aWs0VjNHMWNqT2RIQzFZYjl1eDBTME44TG9KUm1NL3hMVU5BTkErYkl3SWFH?=
 =?utf-8?B?c2pVUzhNNVVudEI5VGthSXI2SlhzcjVJYzN3ZlZJUk50bGFIU2hIQ202eTZu?=
 =?utf-8?B?MnRsRXc4Rm9kOVdTTDg4SGluOUF0K3JCUzZYT1JNY1JpQUhQYkRmUi9vZWxS?=
 =?utf-8?B?YzBwQ09QSWJydWFXUGJzMmkyOUk0RldINHZsVHNUU3FhRG9wK2lsYVZuY3FQ?=
 =?utf-8?B?MWpHNk5XZFJGMk1YQXU4UU9adGhPenJObjZ3UkJEVkxqemhtUWtPUW5FL2Z5?=
 =?utf-8?B?VUF2QnhJanpiVExaOXE2QmtxT1dmckRsTytvZ2dsc3BZa2JSeWQvMDRURUdp?=
 =?utf-8?Q?jbWU9Gz7cvT8oA07UE8OpNT6l?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca20fc4-6ca0-4b89-79f3-08db8d48494d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:49:41.1947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dCjmJkwtrnpVDZKZdrFOkwmBbMqfF8ixZ3e6byxQXKZgx0vvGBa5VAMNZPTjF/B1f1K6ZAXEwGQLheJeLbQbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9175
X-Proofpoint-GUID: Qh0zWQYJon4XOa3MeRLhnod9-M29u3sS
X-Proofpoint-ORIG-GUID: Qh0zWQYJon4XOa3MeRLhnod9-M29u3sS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_11,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 26/07/23 12:08 am, Daniel P. Berrangé wrote:
> On Fri, Jul 21, 2023 at 02:49:34PM +0000, Het Gala wrote:
>> Integrate MigrateChannelList with all transport backends
>> (socket, exec and rdma) for both src and dest migration
>> endpoints for qmp migration.
>>
>> For current series, limit the size of MigrateChannelList
>> to single element (single interface) as runtime check.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   migration/migration.c | 77 ++++++++++++++++++++++++++++---------------
>>   1 file changed, 50 insertions(+), 27 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 6e0a8beaf2..acf80b3590 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -426,9 +426,10 @@ void migrate_add_address(SocketAddress *address)
>>   }
>>   
>>   static bool migrate_uri_parse(const char *uri,
>> -                              MigrationAddress **channel,
>> +                              MigrationChannel **channel,
>>                                 Error **errp)
>>   {
>> +    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
>>       g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>>       SocketAddress *saddr = &addr->u.socket;
>>       InetSocketAddress *isock = &addr->u.rdma;
>> @@ -465,7 +466,9 @@ static bool migrate_uri_parse(const char *uri,
>>           return false;
>>       }
>>   
>> -    *channel = addr;
>> +    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
>> +    val->addr = addr;
>> +    *channel = val;
>>       return true;
>>   }
>>   
>> @@ -473,7 +476,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>                                             MigrationChannelList *channels,
>>                                             Error **errp)
>>   {
>> -    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>>   
>>       /*
>>        * Having preliminary checks for uri and channel
>> @@ -483,20 +487,29 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>                      "exclusive; exactly one of the two should be present in "
>>                      "'migrate-incoming' qmp command ");
>>           return;
>> +    } else if (channels) {
>> +        /* To verify that Migrate channel list has only item */
>> +        if (channels->next) {
>> +            error_setg(errp, "Channel list has more than one entries");
>> +            return;
>> +        }
>> +        channel = channels->value;
>> +    } else {
>> +        /* caller uses the old URI syntax */
>> +        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>> +            return;
>> +        }
>>       }
>> -
>> -    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>> -        return;
>> -    }
>> +    addr = channel->addr;
>>   
>>       /* transport mechanism not suitable for migration? */
>> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
>> +    if (!migration_channels_and_transport_compatible(addr, errp)) {
>>           return;
>>       }
>>   
>>       qapi_event_send_migration(MIGRATION_STATUS_SETUP);
>> -    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>> -        SocketAddress *saddr = &channel->u.socket;
>> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>> +        SocketAddress *saddr = &addr->u.socket;
>>           if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>>               saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>>               saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
>> @@ -505,11 +518,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>               fd_start_incoming_migration(saddr->u.fd.str, errp);
>>           }
>>   #ifdef CONFIG_RDMA
>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>> -        rdma_start_incoming_migration(&channel->u.rdma, errp);
>> -#endif
>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>> -        exec_start_incoming_migration(channel->u.exec.args, errp);
>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>> +        rdma_start_incoming_migration(&addr->u.rdma, errp);
>> + #endif
>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>> +        exec_start_incoming_migration(addr->u.exec.args, errp);
>>       } else {
>>           error_setg(errp, "unknown migration protocol: %s", uri);
>>       }
>> @@ -1709,7 +1722,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>>       bool resume_requested;
>>       Error *local_err = NULL;
>>       MigrationState *s = migrate_get_current();
>> -    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>>   
>>       /*
>>        * Having preliminary checks for uri and channel
>> @@ -1719,14 +1733,23 @@ void qmp_migrate(const char *uri, bool has_channels,
>>                      "exclusive; exactly one of the two should be present in "
>>                      "'migrate' qmp command ");
>>           return;
>> +    } else if (channels) {
>> +        /* To verify that Migrate channel list has only item */
>> +        if (channels->next) {
>> +            error_setg(errp, "Channel list has more than one entries");
>> +            return;
>> +        }
>> +        channel = channels->value;
>> +    } else {
> } else if (uri) {
>       if (!migrate_uri_parse(....))
> } else {
>      ...error - neither uri or has_channels ...
>
> }
Ack. Will add this here.
>> +        /* caller uses the old URI syntax */
>> +        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>> +            return;
>> +        }
>>       }
>> -
>> -    if (!migrate_uri_parse(uri, &channel, errp)) {
>> -        return;
>> -    }
>> +    addr = channel->addr;
>>   
>>       /* transport mechanism not suitable for migration? */
>> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
>> +    if (!migration_channels_and_transport_compatible(addr, errp)) {
>>           return;
>>       }
>>   
>> @@ -1743,8 +1766,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>>           }
>>       }
>>   
>> -    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>> -        SocketAddress *saddr = &channel->u.socket;
>> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>> +        SocketAddress *saddr = &addr->u.socket;
>>           if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>>               saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>>               saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
>> @@ -1753,11 +1776,11 @@ void qmp_migrate(const char *uri, bool has_channels,
>>               fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
>>           }
>>   #ifdef CONFIG_RDMA
>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>> -        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>> +        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
>>   #endif
>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>> -        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>> +        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
>>       } else {
>>           if (!resume_requested) {
>>               yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>> -- 
>> 2.22.3
>>
> With regards,
> Daniel
Regards,
Het Gala

