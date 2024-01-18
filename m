Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F171B8312DC
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 07:50:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMDD-0005uO-L6; Thu, 18 Jan 2024 01:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=17470a300f=kai.kang@windriver.com>)
 id 1rQMDB-0005u1-0R
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 01:49:13 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=17470a300f=kai.kang@windriver.com>)
 id 1rQMD8-0005rm-RO
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 01:49:12 -0500
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40I6RsCK020591; Wed, 17 Jan 2024 22:49:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 PPS06212021; bh=GETJak9UoToftTHQsx9vqaoMneflnDBRxy098DEL0vs=; b=
 kKpb1rvaqtpzokbvi3tpOFPcPu9WYchYINFxn9rd4ze412X96rqHnZ7zoHIaQmJ9
 cItn+NnoU0S0z7UG4JR/VUP3GmXZOsiJGfr379c+bVbgq0phsgRVVTcpiPi8UZJK
 aaYHotEzpQDQOSMqUSuKGnD8jW+Ka9BQWWEqpHBTLyeR4W66GqiKCTIikBuAZprS
 WHOZ8QulFxfZhX6VBjsUNjgfx7TIOLJulRIzthRyJ7RSvd8nlivX0PA3TnL0e/7P
 qWXb4KNGm8I6l5fEblv2TWWwy3U5Kx/hz6ag3gF0TWTsYL2n3MZxGaPnNDlT/0hj
 Hkg2z7WnFRQO52TZNqaThw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vkpp4589j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 22:49:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfz/MPAnwJ79L8tSjU7BiqPxmdYvNnDHPOvvewGaS8TQfDyu4UM2RvtXcW5Z4iYfFTZxMAwZ6Y8QxR+B8WpM45oSDkBtQV8CkJVvQoODPHViTB+r0ij/I6RgMlKuPAtl4FoCWmp1IsuOXUC/+V65HGZCYyXIr3xqdlqQscYsTa3VFkzG7PFBQPQvh2Pah6wUfVsul8AzXt/sdkW51lysyG349TX3OWUjD4g4ekLupf4rrCbY7/lqh1ses5EBlDPnRVR7/AX4qQozluzYdv0DDx/Up8crM3EhbSnqOwROh6x8hBREK6YUsH5JBAz2hBjXc0IIf4euo4Vjx08Td83nRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GETJak9UoToftTHQsx9vqaoMneflnDBRxy098DEL0vs=;
 b=LiCHpOE2v8Jbf4yhjZ5iqdX0pNW89tRjAywsat4zm54J3r5tct5wMrsb6TRU2HR9CtyRQ/M8jqBQzCR5blQH/w67P/LugkTcBDTw+8kDuTw6MoDDfoC0+SkVCvEgrMd3oIv035GFN66Gzt+TmB+MwlXrzCFsYM2wD2shOF71Pa9xRdWUr6PhoFdtAsOEPF6AHMiWD79/BHKMaE9ScSUqVzzPdlvEGBuj+nkmgjjNYLS+PwtVFRNyTfxgKsmnM9JLP3eC77SFcU/LS81JznI+KzkI5X8fF5rfLW0aoL8TmAbHE1/Xu75wxDKUOewn81bfZ2QME6YwzbTO+FMasMThrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) by
 SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Thu, 18 Jan 2024 06:48:58 +0000
Received: from DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::dca9:26e2:b46:2372]) by DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::dca9:26e2:b46:2372%3]) with mapi id 15.20.7181.022; Thu, 18 Jan 2024
 06:48:58 +0000
Message-ID: <1db86e7c-9d4a-6c7d-9e6b-52054b2382cd@windriver.com>
Date: Thu, 18 Jan 2024 14:48:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] qdev: not add devices to bus in reverse order
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240109092015.4136865-1-kai.kang@windriver.com>
 <CAFEAcA9LBXMxOzJwmXYEVj+q0hTzMQZrpZHOOKFYWZDKXFyHig@mail.gmail.com>
From: Kai <kai.kang@windriver.com>
In-Reply-To: <CAFEAcA9LBXMxOzJwmXYEVj+q0hTzMQZrpZHOOKFYWZDKXFyHig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To DS7PR11MB6064.namprd11.prod.outlook.com
 (2603:10b6:8:77::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6064:EE_|SJ0PR11MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6778a8-53ba-4c79-75d9-08dc17f18ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qsHkmdqn/nZaHPqjAbJVuUtq+6DGLDLaSz947PwcJMyqU1URgsYAGPEkkIo0hh/ttBx9JHp+CCljb0qudfa0jbYYDd72QVvBj+qrEWch6NE6eLTNjihXY8UGeWE8uB81lTqEWuwWECoX+ZuIU9w4ARYeaOmss++jCsOcRH1Ox5goLQQ1PyF/tzGX+R/RTtk+TFXO7dtQ4zdlVU1kAt63NrzTxm1pZCbOOrzToBroKneFoHG19tRKQBrlE4u5bS4JG51jKxpOMvmdQOVDPK+LJGE2wV1JQKBXU9iXVh/n5P1Jbkju/3KPeBUWIeEGvRYZQKjX+P+GqZvXFmPPaQOMCnkvobBZcNpIuvHi9umvitwWAt1aqoVv+SGqxkAUR3kzU/RKz4uDIRBOx3riPN45TVxrqfr02M/R0Seu8VlOUOzib09T6bgdKx9FMAzjYCotp1bQEqSD8Zu3qlOqvc5a8uqe7rOTa0HUAqtOs0V7hfpLNsQBSB0HBtJK+JqBzPVKzEKrXtScJagJGI+jqNyF33oGnN3A0lIlQu/Fgrc+8yH+C+bEnSiRN5mtMfjQzo3oDqK4ZbW+f7AMchJfPMe2aN8j6IMm0oTGydNekosuTKjVi/SNDSDx2pqdgJXXHRXlZtD9e9f8J2dti/g8E2Lew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB6064.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(39850400004)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(38100700002)(83380400001)(36756003)(31696002)(86362001)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(8936002)(8676002)(5660300002)(26005)(2616005)(316002)(54906003)(478600001)(6486002)(6666004)(6506007)(6512007)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXVRT0RNd0lmelFZUE0yL1YvTlljRmgzSlk4Sk41TUNkZ21jWTZSVkROOFo2?=
 =?utf-8?B?TXd2RVNuMVhPblpyNEtFZyszUlk0UTFzSGFNeHlRN1dhMzViWnl0eTE3aTNK?=
 =?utf-8?B?Y3JGcUp1Z1FpaFAyTFozUFVPSWxrQVNCMDRJcytONzhZV3AxajE1YkcvUG83?=
 =?utf-8?B?Rk00V2t3amF6UllLZStQSlJCRjd2bkZjVzFDZXVPNENYZXVUM0ppbGJzNGFY?=
 =?utf-8?B?d1BpVWRndHNzdGRkY0xCZE1oTGtVQm9lbVRVejluSFZ1S2FSdnIxWEZSN21I?=
 =?utf-8?B?QW5JNi9uVmdTZHNhZGpzK0F4OWp6TzBya2QyWStpU1ltWkVlTm9QUmlsenc5?=
 =?utf-8?B?T2hGOFlHZ2JQbFpnNTY4MnpMTkxILzhBNWx3a1ZkM0k4cTQ3REltN2NqNFJC?=
 =?utf-8?B?bWZyZDBtWk1mendsZTB5Y1RkeU1VNFFFUXpuYVI3L0VUUDhIeCtMRmZUSEt3?=
 =?utf-8?B?Vmc5VlZyaHRwTkZCYlh3NTIzTzIwZjM2UXoxdURNQi82WElHY1lCc0lwVGZt?=
 =?utf-8?B?NHg5ajdDY3I0bmhnaDBnSDBPN0ovZnc4cy9QU3VoNDBvMmYwYlpKUFI5SkRN?=
 =?utf-8?B?YXkyNEVvOFlVWXNyZTR2aTNFZHhFYWtaaWE0NXBGdlRsdzRMTXZKRVBNd2ts?=
 =?utf-8?B?ZnhqeWpyeEpFVGU3Wk9kYy9FM3gwWnRMcnZ4QXZRaGtVSStsbEk2M2ZGblBt?=
 =?utf-8?B?MjNxaFprWFJBNU9pQTg0ZHl1RGgrUnRzN0tKcUhVZ1lqcnA0aFQ0YWJzWjVH?=
 =?utf-8?B?Z3ZNSXg4Z3gzYkZCdmhXV3pwYStETjc3cmNrUlNtQjV1Si9qSlZxNWk3U3Fl?=
 =?utf-8?B?VG1IZUp0aHJiY2tvOTdaTWthRXc5R0ZMbkF3NFNkTExIZWhxVlpwTk82NkVs?=
 =?utf-8?B?UWlEaFd4M2VaWU0wa3ZjOUxoWGVBbVRxRHVwT21JU0V2ZnYzTWEyeVNZbjhF?=
 =?utf-8?B?YzlHM0hjVnZtbFU0dzZwRDhsemRzVlByamRWaUc1NldVUmp5V0tLM3E0VVVR?=
 =?utf-8?B?S0dpQ0ptOHA5d3V6QllPcmlOUVJNUFcrUFZTdHlXbVlVeWxxWEI0elVMdXNz?=
 =?utf-8?B?aTdYRDB3dlJFRk5pNXV6b05qV2pVQkZyZ1JVcWhLbzhXbXNKVUlSSVZtczAv?=
 =?utf-8?B?aDY2ejN6UVA3ZzQ5MlArbDVMSFUrN0U2SVBJWWQ0cnZFMWpiZEtZY3U3NUk2?=
 =?utf-8?B?U1VkSUZlY21CYWx0UUtsYktyZGFHRmNlQ0JRRGZaZnExSjNWU1YzOVNOOElP?=
 =?utf-8?B?TllBT000NnJhcjlWS1JKSmpMUWxYdmFMdGZ5ZGtVL2dYOElNanpHdGgwa3RY?=
 =?utf-8?B?TWNTUCsreGlHSVB2QkRra1I5MytUL3JPN3pQbFJWVzFVN0UybUh3TFl2L0FX?=
 =?utf-8?B?encrd1NmUC9xVjdpTm1xbjg4emR6bERuTG9meUZMcEQ5N3VXTjMwWDlDRDJp?=
 =?utf-8?B?NEFDQnVRb0cxNTJtYUJmT3ZnU1ZZSXQrbzBmc3BqTVZ3Y3JQZHZnTjhoRmpU?=
 =?utf-8?B?QmlBT1I2ZlducWFQeFpvTmdlclpsbFRQRDd2TG5HYlEybXJMRGRiUEZ3bmJx?=
 =?utf-8?B?WG1tR2ZIYUNVazB1VCtrWWFuUnhjbmlLM3dIZ0VxbTFWaEgyWFVLMXhzc0Uz?=
 =?utf-8?B?ekVQL2o3bk9hZUlEaTZJdTFqb2dwOWZMRHl0MDEySTRjQ1F4UVp2RTNkNG9j?=
 =?utf-8?B?RUxCQkU4OE5OT3FiWUJmYXN0WlBZNzRaL21EZ3lIYzJzd1dvdWpRUXlQdFhx?=
 =?utf-8?B?dGhtdjVITHN0VHBTR2FCRk1HT2VoN0U2eWMrSUN6OTVsSjl1M2VUOHdqMjNN?=
 =?utf-8?B?NG1hS2tpbGhKVnNZcjQxT0N2cHZ4ck9OeDRUc1EyYjhReWV2Q0hLQXdjZTcv?=
 =?utf-8?B?NEdTRnZNKzF6VWgzSzFadHRJOTh2dXRaQ1BPMVkwbDVQSzZxRkVwSFl4VHdx?=
 =?utf-8?B?OTJpaThmZ04zSmhtVFdLUVNpRHFtM2JNOFdpenpPb2hadlBqaXBFOUo0b1B1?=
 =?utf-8?B?d3N5bnIvOTZ1WVBlNDFUVm5hMFNGYzZOaCt2ZENWSWsyRCtieG5qb2o0K0ZC?=
 =?utf-8?B?NUo2RHhmZVIyTVo4b0NlWG1ZNWlZS091TmVsRDllRWk1SitkRENmZ21lWkJa?=
 =?utf-8?Q?f8XkP6TUQz8LgYdVvkKUmXKWg?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6778a8-53ba-4c79-75d9-08dc17f18ba5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 06:48:58.0569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNfWVNxTi1w+V1fLtK0TnvWUxHuq2wKc3hiflz2yq9odXqXoH3CFoYsoAxAc0A6sVab07D72NZwzEXNKJBmw/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5069
X-Proofpoint-GUID: 7BncQW0y2vlD-A04nhDnJ55oTGXCgJ0n
X-Proofpoint-ORIG-GUID: 7BncQW0y2vlD-A04nhDnJ55oTGXCgJ0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180046
Received-SPF: pass client-ip=205.220.166.238;
 envelope-from=prvs=17470a300f=kai.kang@windriver.com;
 helo=mx0a-0064b401.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.748,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/18/24 01:31, Peter Maydell wrote:
> (cc'd the people listed for this file in MAINTAINERS)
>
> On Tue, 9 Jan 2024 at 13:53, Kai Kang <kai.kang@windriver.com> wrote:
>> When this section of source codes were added via commit:
>>
>> * 02e2da45c4 Add common BusState
>>
>> it added devices to bus with LIST_INSERT_HEAD() which operated on the
>> single direction list. It didn't have something like LIST_INSERT_TAIL()
>> at that time and kept that way when turned to QTAILQ.
>>
>> Then it causes the fist device in qemu command line inserted at the end
>> of the bus child link list. And when realize them, the first device will
>> be the last one to be realized.
>>
>> Replace QTAILQ_INSERT_HEAD_RCU() with QTAILQ_INSERT_TAIL_RCU() to make
>> sure that devices are added to bus with the sequence in the command
>> line.
> What are the problems being caused by the the list items being added
> in reverse order? Your commit message doesn't say what specific
> bug or problem it's trying to fix.

The problem I met was just as I asked for for help in the maillist on 
Dec 18, 2023.

The indexes of serial isa devices changes with the commit dcdbfaafe90a 
since qemu 6.2.0.
Before the commit, it creates devices literally with "1" & "2":

@@ -1252,8 +1222,6 @@ static void build_isa_devices_aml(Aml *table)
          aml_append(scope, build_fdc_device_aml(fdc));
      }
      aml_append(scope, build_lpt_device_aml());
-    build_com_device_aml(scope, 1);
-    build_com_device_aml(scope, 2);

After apply the commit, it uses the 'aml builder' way and the devices 
are handled in reverse way.
Then the indexes are reversed. It affects guest os such as freebsd. When 
run `pstat -t` on freebsd
with qemu, the sequence of the output is not right.

root@freebsd:~ # pstat -t
       LINE   INQ  CAN  LIN  LOW  OUTQ  USE  LOW   COL  SESS  PGID STATE
      ttyu2     0    0    0    0     0    0    0     0     0     0 IC
      ttyu3     0    0    0    0     0    0    0     0     0     0 IC
      ttyu1     0    0    0    0     0    0    0     0     0     0 IC
      ttyu0  1920    0    0  192  1984    0  199     0   664   668 ICOi

It is expected with ascend order which keeps the same behavior with 
older version qemu.


Regards,
Kai

>
> In general this kind of patch is something I'm very cautious about,
> because it seems very likely that various bits of the code where
> order does matter will currently be expecting (and working around)
> the reverse-order behaviour, because that's what has been done by
> bus_add_child() for the last 20-plus years. (As one concrete example,
> see the big comment at the top of create_virtio_devices() in
> hw/arm/virt.c. There are probably others where we didn't comment
> on the ordering but just assume it.)
>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 43d863b0c5..5e2ff43715 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -89,7 +89,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>>       kid->child = child;
>>       object_ref(OBJECT(kid->child));
>>
>> -    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
>> +    QTAILQ_INSERT_TAIL_RCU(&bus->children, kid, sibling);
>>
>>       /* This transfers ownership of kid->child to the property.  */
>>       snprintf(name, sizeof(name), "child[%d]", kid->index);
> thanks
> -- PMM


-- 
Kai Kang
Wind River Linux


