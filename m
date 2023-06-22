Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5572F73984F
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:42:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCEwZ-0008Pm-LC; Thu, 22 Jun 2023 03:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qCEwL-0008PP-3A; Thu, 22 Jun 2023 03:41:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qCEwH-00032A-TE; Thu, 22 Jun 2023 03:41:12 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35M3DTnN000646; Thu, 22 Jun 2023 00:40:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=BEFQzrpUw53rA4GAl1T5OklPSF8y4mjms2lp1E+P9No=;
 b=pHljmPQDKoXwZmipl2bboxFB6HK+exLMMgAvCGzxfgRagF23dHIh0cvDEGjBRSgTC6Yk
 xDEQ/HtxNluBh0+U8jGKULGeGWziGBaGvjz+ErAMW6T9GyBMPS5IPH9H+E8pemUxsC0k
 lSd5VSDb9Udxq489SXWEvh+mGT4cJ6AocIm9iQYB9dJHE1L6gcCq3cqBYIuaQmO6iDIw
 cPKnYrbYGmhUzuVqpvZ5sOWoUWzHdKTzwcPoZOXL0HH6GU0+nVFpOv4QC7LB00m+qvH7
 08zMizDcq2oJmRBd01sKo80CPkPZQbB8SojMAQdf0EW26HCVYv9ch8DXSC4UT4qpLlQn sQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rc4y395va-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 00:40:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNznMFdV+LokDlsIMGl8U7qevVubRKHKDo8C5IaY7M0f4lGWrH8UqR+oopRbl8bcnb4cGJAZ/oiFNp+OKo5m/noT+1fDRkmO8XLEYXxFIYU4C2ovNfMy3MEB5N/Jo7w78hC+Hhp/HQo101uxCGMNW1bqPKmsyyQD3ucdHbEogax8Xr7ERUYQ50RcR0uAwHvBvfzseq9Ctn+0/dpDB4XAcA/znHE4cOyb7Opk340UkHOKVgseVuZp/M+1M6qKFhLgKBBZXGdzCAXqoXmkQ0P0t/Hcg6oEde9q0kcJMBHm6xM7bVyLx+Jr7uYApD+Ul4sibjugJwAgKkaad2bdPUV7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEFQzrpUw53rA4GAl1T5OklPSF8y4mjms2lp1E+P9No=;
 b=e34mzfrivRth6vwqthzrf/TdUzhxdzkp6S4/Xp950Iz5F4PqYnd32WoCL+y1Dm/ueSEflJ3YPHin9VbglAv9EK2G8Ka0FOKrXzPIcd30oHcPebpnzNhjQlphcIywWXWoeCS0Q6FJsL/20waOLBMNn1pALTxmnfT/r8LtiKkWU1ircUQoHjpuioETL68jXguli+KoxU2sBqoF/en8tQsRI8OZi2s7OOhNj6Vb2yViIPD0vEQSTA64FWmTSR/HmVYPppwfNzDNFvdUgz6sWiAUDv9slswEVEirtZZ7R/sW4Vx++smiR4JJIqN+W/fkQzazMlUt+WT8tjzzpervmPsCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEFQzrpUw53rA4GAl1T5OklPSF8y4mjms2lp1E+P9No=;
 b=dEFYAEBI7zxW5/Uh29g6UydyLzYkSz6zhd6/aXMcLDUdtI1MedF2VquhG3HKssF8Z/KooQ8PjUEa4VMXcpcknHn4zkdERKMqkzfW4OCF/TUeqj8lF5ejuib5LMlp+XY38BOyalNeZpRuUuZJxeI4mhMfF5hIBFpzmvivVQpGp/YyydcR1Cfn5ZVV13eOFWpjLkTPxjQFjso9LxoNU5x9YbZ+AxYIRvFnVT3Ck18nkreMf0q1YKlJEINte7xSvVaHiH2AzoiH9R2g65i3Ia/4aez2CHkRMdgZasWHiKNhHdLgflma8WkIXV9zScQI2bSd46XQDJInRaTCK0Bs40oCtA==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by SJ2PR02MB9895.namprd02.prod.outlook.com (2603:10b6:a03:546::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 07:40:56 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7%7]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 07:40:55 +0000
Message-ID: <ef89bbe6-694a-c3c8-3efa-23609cee39a7@nutanix.com>
Date: Thu, 22 Jun 2023 13:10:36 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PULL 20/30] migration: Update error description whenever
 migration fails
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
 <20230622021320.66124-21-quintela@redhat.com>
Content-Language: en-US
From: Tejus GK <tejus.gk@nutanix.com>
In-Reply-To: <20230622021320.66124-21-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::31) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|SJ2PR02MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3d0593-2dee-4559-e6a6-08db72f40331
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5NsaD/vQr2AxgAWst+fisRQuBqoclUFpliG5/DIJW3KJb053qIZearsb0bB4GY4/ftBQuniWRnicA6ZW6uiogyL80tszUoxQRfzJ/x2WMCY1fo4wpuOgUCgQ+GZghCMA99koNMI3yzb+mVF4KO+YSvPKS1pZ7rr6q0WotYbqWBNjUA48h58EqW74Iwk7LlOl0wX+EkAMxMB6c/bhwJB35qKoOKLbxABGg3pwAIN96/tTJIHCZGEvhvWfKtOhO+2DYuGsFYiW2e1lNH1ZFonn8LAjeqg3j1cp4jId+URy5QiuWeNywpKk+KxboNz771iLnw/K5hM12C7k7QqXdBCkI4c8ONd/ivY98DvNi6Q7JSyQst5u2r4Y/ptHp3XsfUFsPyw7smbdaa7Hi/ouci3XlFu+SxxuoX8hOKPZFkWAUtEKBC4EWqD10zSb7bZXGPCWsxX7jlUrnXPVXSKO0HJ3W44zDy4wzgWadBxvKE1XGsk/jTE43aZIazOtYldghj0VOg3VDCDKwEEh/NpWIlYqNOJiTKXgiFRCdWMSsR4F6feDl/0uOuuuCAnuPc/dHLkmf0g2xCfJc2AtIBfGPAoxZFZAIKXUQMX8y429YcdccOi9xDATK14m2XtediuW+K4YK3iNLCEqQ4hizrQnxRP8Ti6MBwGYnQKlMoSM1zcwxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(15650500001)(86362001)(83380400001)(4326008)(6506007)(26005)(41300700001)(478600001)(66946007)(53546011)(6512007)(31696002)(31686004)(38350700002)(2906002)(38100700002)(54906003)(7416002)(66556008)(66476007)(2616005)(6666004)(8936002)(6486002)(52116002)(8676002)(316002)(5660300002)(966005)(186003)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVhzdndEODJ0cG5Rd0RsbjNlNWdvYXVvcGIrZVVvT2JvRnBFSFVQWHFUTjZr?=
 =?utf-8?B?Z041cGdydTJYWUFLQUQ2T2RMQmppakdwQlRRbk55aUduWWJBZHBwVHNuUElF?=
 =?utf-8?B?SWw2M2lSYTdaVmZ5eFVKbjJub2xRSHpqTEY1NTJIRUdnN3BqZXlibm95VXR1?=
 =?utf-8?B?S0h1UldWY0h3cVI2N0pFOUY3RjRsd1RRQzZRNWorVzZuK01VenZnVXJ6dVNC?=
 =?utf-8?B?d2Q4WlJkaUdnS1p1NWQwOS9zQTNpc0lWSXNnYmVMNW5YbGx1TFJNblZpZEpt?=
 =?utf-8?B?d0g5S09iZ011TjlCQVl4eXZ6UEhqYTU2ZUMwY2VaNGsvNTFQUUFVcTBPV284?=
 =?utf-8?B?TFJqWE15RUVTVldhRStnN05KWVV6L3ZiZ1BlUUNvR1BuTXV0VmNZUVpWMU8x?=
 =?utf-8?B?dUlYTGFUck5DZnlqT2xLOW1KSFlhSVREWklsYjdOZGlDVUhsRU9sWFNUVENy?=
 =?utf-8?B?bHppK0FXbUVSc3M1ZzJva0ZyNlpkTVFBUTBnaFJhajB3VmcrQ0VDNktLNzNO?=
 =?utf-8?B?OEUzaGxYTlcrbkRjZUxlN0puOEN2NXRPMisxT213TFJEZWhVN2t1aGdGRXBp?=
 =?utf-8?B?M3RWZDhWSDJPcHpCSXl1U2lSQ1VNd3o0SnVQWGEwd2J1aGE4ZmRXaThmVVh0?=
 =?utf-8?B?S21mUE90Yi9pUHkyeThoUFBhUWZmK0Q2blhSRVVMcVNZODB0L3Z6ZmdMZmdr?=
 =?utf-8?B?bERySEpqN3ZBQzVYanAwNFllWkE5VzNLd1JJYURWMlFOM0dtOHJIRTF6eEFE?=
 =?utf-8?B?ZTZhRmk0ajhHUG4wRGFsSmJCa2piWVpsR1ZTc1djdjR4djJrbkk2VDhIMHhY?=
 =?utf-8?B?dFNQQjdNcDEyU2VCRTZucmhRUFRtRGs2WDN1U3FJK0hwSmRDN2Q5dEdYVE9H?=
 =?utf-8?B?M1VDNWkvUWdCcXM3SW9jQjBUazRjdGJPcEZ4NEI3YUo2WlJwZG1aSzFmK2JQ?=
 =?utf-8?B?ekwxaEZnYW80V01JRnJKamtxanNscWY1SENUQ05IYnEyUW5aTUNLeEhmbDFV?=
 =?utf-8?B?Ny9kR1gzNUhGWVV4K0JwK05lK2JuYVRUNWxsenN1ZGluUEUxR3pnWWJzSmUv?=
 =?utf-8?B?ZnAweFplNG03NWJUT2xMZUgyeHRwZ1dGY3VGRFpCbHhsaVc2dVdJM0FNeE9l?=
 =?utf-8?B?Y2JhT0pBSmJ5aDM1WlNyakJ0QUVLYUhqUFhMQldhMFd5MzgxRi9PczR3U1hj?=
 =?utf-8?B?Y2F5NFJmV3I3YUoweFZvekxZQkVXSGRrWUFMNnBKVEp0S0c5bXYrek5FL0dB?=
 =?utf-8?B?alg5RXpYd005N0plZ2N4ckcyOVMwaC9sRFpHcllEVHF1dG9BM2h2Si9TV1ha?=
 =?utf-8?B?UDZHNnN6N09ib0JsY0hvRFdEcjdNb2JDcWJ3RC9VSnl6MnY5R1ZuU1hGRnM5?=
 =?utf-8?B?bG9Db1ZFNi96Zk9wNEhzMC9XdmhLbjRqTU1JMytTbTk5VW44Wk53R0FCZEFQ?=
 =?utf-8?B?YkJ3ZFgxNmhxQVhCVTBTVEs3SHptditzWDRSSEZzcS9kaVJ2YlF5WWhWSzBC?=
 =?utf-8?B?UmlTRHY5RUVWWTRQU1A5Q1VvV3poRjRrMXFNZTBzZVM3TFpNbkYxUEY5THpF?=
 =?utf-8?B?T0JWTW05VXFPOHdIYUNERjV0VW1NQWtYSDFiTzJjNStPYmI5Q1dMeE1HKzdZ?=
 =?utf-8?B?K1kwOHc1T0lZOTk4OEY2K1dYL3MwWmYxTUtQcE5hVytFMm5mcVRzWFlrZXNm?=
 =?utf-8?B?RnF5WXBuUEFUanU0aldHMzRpNm90OW52dU1XL0xKQUhBRmpEWThHa1N4RDBY?=
 =?utf-8?B?TllNSmV2ZzdzaURYVTdIUm83SXUxdWl1UFhJalJBSGJDYlNTVWVhMm02N2Qx?=
 =?utf-8?B?Si9pRmMwL2RDaFpGUUpqZ2lTQzRJZWxqeUdTRVF1aDRiSE1Td01MQ25pWWRj?=
 =?utf-8?B?VklqN2hRbG9LWmxsSFFNSG9YdmxWTXRrK0M4SmEvWG9kN21GaXk5TXZBeTdw?=
 =?utf-8?B?MFUwc2phajU5ZDRHZ0VaaDJCUU5nTFFVVlFwRWwyT1lkTi9uNE5SS2NIOWtj?=
 =?utf-8?B?S1VlU1FYOHRwR3dqN2ZoRHl4OGJ1bmdnS1hoUjRvRHpMZHdTQlViWUJ4eUt3?=
 =?utf-8?B?MGpsaDBlNmE2Um9ueml4VUY0bFRsd0E0K25qQWxsRGI5V2NSZy9nSlUzdlNU?=
 =?utf-8?Q?GsK/f53Fh1H9HjSXEYaNUi3yX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3d0593-2dee-4559-e6a6-08db72f40331
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:40:55.5864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ojImUrJgL8V7WFzYraTwzEj9aziLOGj8KIw5bfGueRKfa0gdndx6PnjNyF8tdI9SdT+UoezLlfQ7QcVUX1xYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9895
X-Proofpoint-ORIG-GUID: Ugt8oCT-7ymZmiXgCe693l1afhBHmKfi
X-Proofpoint-GUID: Ugt8oCT-7ymZmiXgCe693l1afhBHmKfi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22/06/23 7:43 am, Juan Quintela wrote:
> From: Tejus GK <tejus.gk@nutanix.com>
> 
> There are places in migration.c where the migration is marked failed with
> MIGRATION_STATUS_FAILED, but the failure reason is never updated. Hence
> libvirt doesn't know why the migration failed when it queries for it.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
> Message-ID: <20230621130940.178659-2-tejus.gk@nutanix.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 719f91573f..e6bff2e848 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1679,7 +1679,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>          if (!(has_resume && resume)) {
>              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>          }
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
> +        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
>                     "a valid migration protocol");
>          migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                            MIGRATION_STATUS_FAILED);
> @@ -2066,7 +2066,7 @@ migration_wait_main_channel(MigrationState *ms)
>   * Switch from normal iteration to postcopy
>   * Returns non-0 on error
>   */
> -static int postcopy_start(MigrationState *ms)
> +static int postcopy_start(MigrationState *ms, Error **errp)
>  {
>      int ret;
>      QIOChannelBuffer *bioc;
> @@ -2176,7 +2176,7 @@ static int postcopy_start(MigrationState *ms)
>       */
>      ret = qemu_file_get_error(ms->to_dst_file);
>      if (ret) {
> -        error_report("postcopy_start: Migration stream errored (pre package)");
> +        error_setg(errp, "postcopy_start: Migration stream errored (pre package)");
>          goto fail_closefb;
>      }
>  
> @@ -2213,7 +2213,7 @@ static int postcopy_start(MigrationState *ms)
>  
>      ret = qemu_file_get_error(ms->to_dst_file);
>      if (ret) {
> -        error_report("postcopy_start: Migration stream errored");
> +        error_setg(errp, "postcopy_start: Migration stream errored");
>          migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                                MIGRATION_STATUS_FAILED);
>      }
> @@ -2720,6 +2720,7 @@ typedef enum {
>  static MigIterateState migration_iteration_run(MigrationState *s)
>  {
>      uint64_t must_precopy, can_postcopy;
> +    Error *local_err = NULL;
>      bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
>  
>      qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
> @@ -2742,8 +2743,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>      /* Still a significant amount to transfer */
>      if (!in_postcopy && must_precopy <= s->threshold_size &&
>          qatomic_read(&s->start_postcopy)) {
> -        if (postcopy_start(s)) {
> -            error_report("%s: postcopy failed to start", __func__);
> +        if (postcopy_start(s, &local_err)) {
> +            migrate_set_error(s, local_err);
> +            error_report_err(local_err);
>          }
>          return MIG_ITERATE_SKIP;
>      }
> @@ -3234,8 +3236,10 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>       */
>      if (migrate_postcopy_ram() || migrate_return_path()) {
>          if (open_return_path_on_source(s, !resume)) {
> -            error_report("Unable to open return-path for postcopy");
> +            error_setg(&local_err, "Unable to open return-path for postcopy");
>              migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +            migrate_set_error(s, local_err);
> +            error_report_err(local_err);
>              migrate_fd_cleanup(s);
>              return;
>          }
> @@ -3259,6 +3263,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      }
>  
>      if (multifd_save_setup(&local_err) != 0) {
> +        migrate_set_error(s, local_err);
>          error_report_err(local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                            MIGRATION_STATUS_FAILED);

Hi Juan,

I can see that the "Acked-by" by Peter has been added to this patch ( and the next one in queue ), however, Peter hadn't Acked this patchset, but had "Acked" a different but similar patchset which is still under review: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg04184.html

Regards,
Tejus

