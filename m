Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7448E794445
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 22:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdyoM-0001yP-4Y; Wed, 06 Sep 2023 16:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qdxDq-0002zW-CZ
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 14:25:50 -0400
Received: from mail-bn8nam04on2086.outbound.protection.outlook.com
 ([40.107.100.86] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qdxDn-0000SF-Ic
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 14:25:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdxxgV4c6umtoO1y/EbcKDYtXwcmKrAYSMijIe++jgrDwF2Az+1MkSkFzGnYCZFchX+Gg2ECplzY1XWQYPU85SPIvaMbGBcgV9afI3ccluchjQ5iK1gNBzQW5jINvOWYBrtC3sB1Fs8wGWuDfe3I0nDzH6wk6t2JBETBGL0Jbs5lGJFuXkj6aIm4MdLdr/wsqY+t0/7N7yGCuR5UUVIem/mx6OVQGWKXcjxyUOwSLlMAJpcUjUXM0Fq0RlxREBQbErLU4qPM04jiHKQr6tfeuklkQjF9FoCRHrLhakKbenAc+8o60rmhhAhqog4E5RH3LDh6PPlTACbhCsdaX7HdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=undZgtM5ZOKJDujRoIRvVWG5CcyCBXzlyN5NXyEmCes=;
 b=ngdnpqSdtH+Bir8ycb1t6d7fVjUv8LMHy/a/QcjBqovr8u456FjD7sl+/PWxfRYe+xI7iqK9uV4HSca60HNEy7jbx40PV2709Svgxa7su3ec8RGTu+ToNIhwT3AXheTegsTBu88QQmVcKUWDkmQvYUmcbe7lLsyc//1v/aCEc83fku7uGmwdkCVTzdqm5WPgNzC3RaZbPpVi7A7BB8CbgzH+v+UYR4GA0rU55zJQBr1hr3xCOYL63h9Gij3xSYZa2lQfuvX1x+8koCSHp1HsKMUyUilc9E/p3HZTgKMfLZdvXSEYex9N0RNzU0uwSj8wt0id2dUs8Sz2ja97vFVmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=undZgtM5ZOKJDujRoIRvVWG5CcyCBXzlyN5NXyEmCes=;
 b=Ssr3S2VxWUJQtRihaJbm76hTFskxM4cGEW43KYNK1IK7dgJsRPI+sq2bynoG4F8Qr48dxYUUjLM5Ie/kgZqEmK8bxY8nwjnfO1hwS3M1+Nk7hcrNbQgtOxnVt+8m60vRjzauVU6hVnULh0lWi2CfzoLV3ngeWKGCNMYX4mWZ2ZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 18:20:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 18:20:35 +0000
Content-Type: multipart/alternative;
 boundary="------------q8mFJ927XWye5TSWd0sod6Mn"
Message-ID: <6b1d0762-10a9-b31b-279a-9cdcfd884d06@amd.com>
Date: Wed, 6 Sep 2023 13:20:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] i386: Add support for SUCCOR feature
Content-Language: en-US
To: John Allen <john.allen@amd.com>, Joao Martins
 <joao.m.martins@oracle.com>, babu.moger@amd.com
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, william.roche@oracle.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org
References: <20230726204157.3604531-1-john.allen@amd.com>
 <20230726204157.3604531-2-john.allen@amd.com>
 <3856285a-a612-382b-905e-77ac1627de29@oracle.com>
 <ZPdCtajSXBxzbovL@johallen-workstation>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <ZPdCtajSXBxzbovL@johallen-workstation>
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f21f8d-cb1c-4320-6d40-08dbaf05f675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFCG/UvBP1VOOku1880KDHW4rUIaL1iiRxlRpcJX0FoAsYCfk0Y3MldPP2MbTZ3tZA/XGN0pk6UskVKytsJk3rl9eFQ32zxZLegJQUzrsKu5ejxuimb+NCaigJjD8PMI04PHWSIHu26t9VJHBhVZbtnCpcd1HhzGd+Z4i2jBOMK7sjSDpF/Zbpgw7L6neDM/gERSsjLsp7gYLVbHdEwGH3SF0KQaHxuyXV5qMpBuPIi/hKzqLOjBaqfyDeOxGABeNKJ3PSjbMZswRLO107EY7RM1dS1mjj9SiLl4Dv5Mx+ReMOwu0iKdMRap3c7nSfpqacfPDKDUbu3tZlBaE6eIOnpK/m894nzxs546yLzcF3tJIzEo1kDsPJiGTtgzXHa9xkoxQu4smnKhLpAeCS9rG0abopW8QxLI/ZYcAW7757dEAqLiF4HgdlYxQ1cp0ouAp0a4NMqalKA9Lowg6+ND6EGh/ZSSqmsTGsEddS7P6WTrIIiTwseeggexl72XwnpOVEcqsWkJxco3slzUEEWawGxv5eCkbHNXEniZ6ftjA0Po8FTudTHE8OITzWjh+xr7SJD4PprEib0XxpfqCWs6whT2KPPvwf2YpGeHVIaPw4aYJaBaY/+q+5YTRrtsNk5rfdp6QGlMgfuivBvz1D6nsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199024)(186009)(1800799009)(53546011)(6486002)(33964004)(6506007)(6666004)(6512007)(478600001)(83380400001)(2616005)(2906002)(26005)(316002)(66556008)(66946007)(6636002)(66476007)(41300700001)(110136005)(5660300002)(8676002)(4326008)(8936002)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1QwK1NJc20vR2V6a2tsMWtLcTBzN1ZaLzNUT0F4RGpHbUVERjYxTGtLNVhh?=
 =?utf-8?B?U0VFN3ZGdkVUTi8ySmhqVUs5TEprZUg3VkhiUE9GN3IzNFRyYkNkVnNpdGcz?=
 =?utf-8?B?M2xab2QyVWcya01rbFBZYzZKV1NKajMvUHE0T09yVGN0TFRVWDZiOXBYRFNC?=
 =?utf-8?B?eDJJTVY2ejZuMzhwWVFKWHNLblJHS3dvSjRRV2NlZHZtbFB3QjZqR3RpM1Yr?=
 =?utf-8?B?empWTHQ1WEdpQXpUalE4VU9tcmowZ2Q4c3N1bG9YdE02b3ljT2ZLTkVTV05q?=
 =?utf-8?B?WW1XVDRveUR5WVhjRG55YVhyVmpCcG1jdEVIL2xVWnlUOUlRb3J5K1p6azNI?=
 =?utf-8?B?SUR0aEFsVTB4OUM1Y2JuYW1QTE1CNW1EalkwVG5Vbmxtd25GM2I1cmVpM0ds?=
 =?utf-8?B?VTQxclNJOEVUbU1hSXZVM3FNeWtUd3diSG5hMnlrUU5IbHFmY2tWdlZaWkpP?=
 =?utf-8?B?ZnRWODZYekR1bmZpSkRuMjY4ZWFBSk1MWTNXVk9PSUlGa094N3I1eHN0ZjVv?=
 =?utf-8?B?dmgzMEo2OUVHZGJJVUVKTzE0NUFEL2dTMGFoZDFsWUNUWGJ0U1BSNDJHRlFD?=
 =?utf-8?B?VndmVkl4alJodVlIK0svOEc4TnNyb3drUmFZSzRweHV0QTl1cnNUeHJvdElh?=
 =?utf-8?B?eFliK2p1SWtTYkNUbFZwV09zRG5mdHBsQUJzN0x6L0xKMUFjcE8zaXJ0STZM?=
 =?utf-8?B?TzFkcTdWKzFYN3lKaFBaUlZFUzBPZ3R4Q1JZTW5sZlQ0YkFUbDY3cS9SUzcr?=
 =?utf-8?B?bFEzYkJYR2ljRHUvRncxMUYzTGZId1VZL1FUbjU1VmtuWU1NejhNQW1YL0FH?=
 =?utf-8?B?N2VVZTJVZUdKT0UyK0JIZW92dkhmaVpWS3Q4N1YwYmdrMWhpeURuSFFkSDYz?=
 =?utf-8?B?dkNjTWlaYTlYWlBwYitBcjhuKzBROHNMVHJDZzF4L2xKMUpsNW5uNTdsYUZ2?=
 =?utf-8?B?QjB1RGEra2FlM1RoOW5PVDhZTytiWmRMUERLUVEyS1ZsdlZ2Zi9PQm5LN2ZS?=
 =?utf-8?B?cmcyamF4dkFlSW8vdzFWRXZNRDE5MGU4TTVSMlFwK2E5RWgwNDdPVXIwVHNq?=
 =?utf-8?B?R2NhVFM0UHhqZkFGR2RYYmhiNmhRV0paOEwzOUhLbEhhWFRRQzR0SHIrRHhZ?=
 =?utf-8?B?am44YlVTMGxpSEF6R1lRaDZkZGpvanYyc1NRdGI5RFhvNkFkcDI4QVcvRjlP?=
 =?utf-8?B?QkhCVG1CZmFOL2FJMndFQVNMYktNT014enVGT1Q4VTM5YXhlM1JseVVaaWp1?=
 =?utf-8?B?d1hoVm9YTVNoeU85K1dRY0RaTUphV1kzVTZpZlZqRUtBT1NFYmlxdVd3Z29P?=
 =?utf-8?B?K3BRK0RlY0dLaVVPQmFHLzBla3J4Z0V6b2NUQlAxVHBzMlI3WjY4bjJsa0dR?=
 =?utf-8?B?dUs3K2tZT1kyd2tKanRuRG1hYVhSclh4TkZ2QzJ3cVpDVUI3SVFQcmI2cHpk?=
 =?utf-8?B?WXUxRFNBYTNLQUxESWhDR2hoOVFnc3pkNXMwb3FDYUR2NzdCQmRUVTNJd1BB?=
 =?utf-8?B?eldaSXo0cFlGWHlpb1RwRE1ialhwY0dOYWV5dzNkUUUrQVRBam50dzUxaWk0?=
 =?utf-8?B?a2wyeWNVZVFtRmpaNTNNbTNxV2dtdHlqdGVVMnI2c2g2MFBkTW5FdTB6VHh5?=
 =?utf-8?B?QTljSVU4eE9MZmpISjZ6V3RxSHlIczdqdUdPbGJYZGlPb2tHWFY1U2czcVlm?=
 =?utf-8?B?bHYvMmoreEN5aHZJSWN3cVVHVTZZMjQvRkdGL1lzTFNtTDhkMmk5MEUwWTA5?=
 =?utf-8?B?SHNmZGExbkF6ZWw3a2RxWVJLT2NmcTVqcEdXdzhtN0piL0R6NjZsaUo3MTFG?=
 =?utf-8?B?WjlSUUEyOVMzc0JsRllmMWtyUTZ5dXJ5SXpJNnRpamVBaUFrSzFIY0RlRjhK?=
 =?utf-8?B?d2dqN2dROVhpaEl2L1VuNDlWclZLUWdhY1p5d21tNHRSMlFmZWdrT1JtaGQ0?=
 =?utf-8?B?SnFkbThiQ1VXQlozUHhxdW9tdmZOb1JjWFFzNmRtUytBWmt6MGtMK05nMTJx?=
 =?utf-8?B?RWJQYUM1bkFNakN2Vm9IY2RkSnFEVFFBcnQ5SFBkU08xQmlXSG5HUGFwRENE?=
 =?utf-8?B?S1BLalBvM1RJVHRwSER1VHovZUV1TTQyR1VhOGJLeWo0TXArajdhbnZ1ZXkw?=
 =?utf-8?Q?GfzC1WWXQPU19sXVV2iaszRJW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f21f8d-cb1c-4320-6d40-08dbaf05f675
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 18:20:34.9255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6Y/sPMWbIlvNrtLYsblIvwbHxKLUU7jMyhtLp/5gksHdPoCp+2UucKbEH7ci6oA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
Received-SPF: softfail client-ip=40.107.100.86;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Sep 2023 16:07:33 -0400
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--------------q8mFJ927XWye5TSWd0sod6Mn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 9/5/2023 10:01 AM, John Allen wrote:
> On Fri, Sep 01, 2023 at 11:30:53AM +0100, Joao Martins wrote:
>> On 26/07/2023 21:41, John Allen wrote:
>>> Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
>>> be exposed to guests to allow them to handle machine check exceptions on AMD
>>> hosts.
>>>
>>> Reported-by: William Roche<william.roche@oracle.com>
>>> Signed-off-by: John Allen<john.allen@amd.com>
>> I think this is matching the last discussion:
>>
>> 	Reviewed-by: Joao Martins<joao.m.martins@oracle.com>
>>
>> The patch ordering doesn't look correct though. Perhaps we should expose succor
>> only after MCE is fixed so this patch would be the second, not the first?
> Yes, that makes sense. I will address this and send another version of
> the series with the correct ordering.
>
>> Also, this should in generally be OK for -cpu host, but might be missing a third
>> patch that adds "succor" to the AMD models e.g.
> Babu,
>
> I think we previously discussed adding this to the models later in a
> separate series. Is this your preferred course of action or can we add
> it with this series?


Yes. We can add it later as a separate series. We just added EPYC-Genoa. 
We don't want to add EPYC-Genoa-v2 at this point. We have few more 
features pending as well.

Thanks

Babu

--------------q8mFJ927XWye5TSWd0sod6Mn
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi John,<br>
    </p>
    <div class="moz-cite-prefix">On 9/5/2023 10:01 AM, John Allen wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZPdCtajSXBxzbovL@johallen-workstation">
      <pre class="moz-quote-pre" wrap="">On Fri, Sep 01, 2023 at 11:30:53AM +0100, Joao Martins wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 26/07/2023 21:41, John Allen wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
be exposed to guests to allow them to handle machine check exceptions on AMD
hosts.

Reported-by: William Roche <a class="moz-txt-link-rfc2396E" href="mailto:william.roche@oracle.com">&lt;william.roche@oracle.com&gt;</a>
Signed-off-by: John Allen <a class="moz-txt-link-rfc2396E" href="mailto:john.allen@amd.com">&lt;john.allen@amd.com&gt;</a>
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I think this is matching the last discussion:

	Reviewed-by: Joao Martins <a class="moz-txt-link-rfc2396E" href="mailto:joao.m.martins@oracle.com">&lt;joao.m.martins@oracle.com&gt;</a>

The patch ordering doesn't look correct though. Perhaps we should expose succor
only after MCE is fixed so this patch would be the second, not the first?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yes, that makes sense. I will address this and send another version of
the series with the correct ordering.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Also, this should in generally be OK for -cpu host, but might be missing a third
patch that adds &quot;succor&quot; to the AMD models e.g.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Babu,

I think we previously discussed adding this to the models later in a
separate series. Is this your preferred course of action or can we add
it with this series?
</pre>
    </blockquote>
    <p><br>
    </p>
    <p><span><span class="ui-provider eo bib bec bzs bzt bzu bzv bzw bzx
          bzy bzz caa cab cac cae caf cag cah cai caj cak cal cam can
          cao cap caq car cas cat cau cav caw cax cay" dir="ltr">Yes. We
          can add it later as a separate series. We just added
          EPYC-Genoa. We don't want to add EPYC-Genoa-v2 at this point.
          We have few more features pending as well.</span></span></p>
    <p><span><span class="ui-provider eo bib bec bzs bzt bzu bzv bzw bzx
          bzy bzz caa cab cac cae caf cag cah cai caj cak cal cam can
          cao cap caq car cas cat cau cav caw cax cay" dir="ltr">Thanks</span></span></p>
    <p><span><span class="ui-provider eo bib bec bzs bzt bzu bzv bzw bzx
          bzy bzz caa cab cac cae caf cag cah cai caj cak cal cam can
          cao cap caq car cas cat cau cav caw cax cay" dir="ltr">Babu</span></span></p>
  </body>
</html>

--------------q8mFJ927XWye5TSWd0sod6Mn--

