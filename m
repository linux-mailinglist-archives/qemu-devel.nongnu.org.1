Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F9E73FCE9
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:35:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8qc-00028s-UD; Tue, 27 Jun 2023 09:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luis.Machado@arm.com>)
 id 1qE8qa-00028i-Q5
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:35:08 -0400
Received: from mail-he1eur01on2089.outbound.protection.outlook.com
 ([40.107.13.89] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luis.Machado@arm.com>)
 id 1qE8qX-0006bb-Mp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTJ9RHV0rm5VGEBIgnnIJk8GXnhn4l92r/LYDNwwWho=;
 b=kxBhZZQx1Lali425/90zqA+Fnr/55gWh189TYPI8WW3UkjiriPkScZn0kptUnyaBUlBtJTeVU63LUMurDFVWaCb/pMy9Qh9A48FwZfkgrwEqeU7mDONy+/yLg97Pt5ql+ap4Pc0BCcMYC7Qn0o9es1+VjQHSkOM0ZxRBnUKxMp8=
Received: from DB7PR02CA0030.eurprd02.prod.outlook.com (2603:10a6:10:52::43)
 by AS8PR08MB6231.eurprd08.prod.outlook.com (2603:10a6:20b:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 13:29:56 +0000
Received: from DBAEUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::56) by DB7PR02CA0030.outlook.office365.com
 (2603:10a6:10:52::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 13:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT033.mail.protection.outlook.com (100.127.142.251) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.16 via Frontend Transport; Tue, 27 Jun 2023 13:29:55 +0000
Received: ("Tessian outbound 546d04a74417:v142");
 Tue, 27 Jun 2023 13:29:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 306b164ae623a151
X-CR-MTA-TID: 64aa7808
Received: from da5bf6304d1c.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 A6C999CB-72DF-4082-A137-494407B61DE8.1; 
 Tue, 27 Jun 2023 13:29:48 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id da5bf6304d1c.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Tue, 27 Jun 2023 13:29:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BprSxV4jToHK/DvnPEjzHZzcjjPHp4HDL8NiWk8hEIML36Xl96ni9mlNtMYjKmT3hq4KBm+Wt7wODeizLSfYAyxP58V+YUiVfUB/3/e18Li5a2XWgxQDUJqNqY6DovEvjSFMzCAVZF/9/itoIs9AFFzKg7SmxFPjJ7INQyavD03NyFVZnIIJB2CbYXeIrhTcsuAk+nQ6udnRCAattkWoSx/v9EqlBEqGUcMCrlJQhCcse4SSGV+8o5WKIbh16qz5RDwBwVl+Ejen2WhPmNbY17peuDOMy9rvw/SYgj2bajYuPWptJ3KK+lJshc++6/9Mb8d2QioDjO2+dgXq0kCcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTJ9RHV0rm5VGEBIgnnIJk8GXnhn4l92r/LYDNwwWho=;
 b=TN6RbgExq2Gy3Qn3JkkF5+5+q4VEDjblkE9q58Hom0AbP8LU3qw0WBn+GmuxIaUaokPK/SYlbuqJSlFZ8sCqHCyt+qkhf0Qyf3B34qM8yJkHgsq1BmNbSWfImXp/aKC9ZHfUwGZe5bqJ34EZ6n22iUmRAut6n7oW8QPqoYCSH1xrmQd8SC9YBoP6U2EXNBwtvhU+wVRWQHPNa/uZdvl18AGUSRL3zoWmRF41tx1TIVshtxDH6YLjvCpni5yTBKj+kw6S7gb6p+IiMSciTMBrSgarC4XkicIDf1pWEDhmpb9qptAIct+8nmQ27if0VN9Bgb5VYfpJi9o4zdP2sgnRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTJ9RHV0rm5VGEBIgnnIJk8GXnhn4l92r/LYDNwwWho=;
 b=kxBhZZQx1Lali425/90zqA+Fnr/55gWh189TYPI8WW3UkjiriPkScZn0kptUnyaBUlBtJTeVU63LUMurDFVWaCb/pMy9Qh9A48FwZfkgrwEqeU7mDONy+/yLg97Pt5ql+ap4Pc0BCcMYC7Qn0o9es1+VjQHSkOM0ZxRBnUKxMp8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by DB9PR08MB8675.eurprd08.prod.outlook.com (2603:10a6:10:3d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 13:29:45 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::c6b8:4dc0:6f9:7f40]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::c6b8:4dc0:6f9:7f40%3]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 13:29:45 +0000
Message-ID: <231995b3-6ba1-7632-4677-5235f1488d8d@arm.com>
Date: Tue, 27 Jun 2023 14:29:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] target/arm: Support reading ZA[] from gdbstub
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230622151201.1578522-1-richard.henderson@linaro.org>
 <20230622151201.1578522-4-richard.henderson@linaro.org>
 <CAFEAcA973XpMRtbEQiz_jx9V6AEwmpZZi3jjEe9oRW5HR34tAw@mail.gmail.com>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <CAFEAcA973XpMRtbEQiz_jx9V6AEwmpZZi3jjEe9oRW5HR34tAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P123CA0027.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::15)
 To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI1PR08MB3919:EE_|DB9PR08MB8675:EE_|DBAEUR03FT033:EE_|AS8PR08MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: ebea42f1-c0e3-419d-711c-08db771298c8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: or4xkpys9VqFuG0KJZgKIOGlRTTaPs9eKQG2JkwrZdapMvhVm1QuxYdgHRKRwmUqwqiIpdg2FSkOuRyuWsh6yQ3aOLF2Pr9gcsacycZrQqGDDnYRAD4A9wQy25OkaoBZ97EAfKgUWU4H90nk1qzP5Rt5QduISIgDJKofnrh37Y3IH+rYKGRREsrBdMABrre7AaNhXb3qJjA8xeE+zyqpFaycrHI8931OdEuvyDsh9WK4t+h62nWhCCYkUtiKa/wlJs+wC/jkCspCMjdOK/e9SVvwxbkKdtpa3kFrRYFescucBTPugVntzN96ZPWVQCDdiAyzQaT74mNc8g5VmbTQZO6Dk4DFggxbzh/3YgYcox5MTiaQK/DgIA721tmZVx7NMrwqIaprS2izYt/EdY0MaATV4oblc6/fWdZOuCRwO2JeyQ8s/tQlhEFARU/eWU3ci1pwwRZF6vuJ4Qi6XgyQhqMt+aMd6GU0/kOtLFqBm0PcRpYojw1UMltD3uNpRAMYMoP7qkO/NDIz/aqftznktMzkGvb3wDkE54NBBczorxh+qPlqrWrfPAiqUqZfebzgDfs1iazHermm6NcW/T6APsQHHvxIy/KRreGw1RyIqrptX8B2mPhE0mixhrxXROv/xUOPz2U6Kc0aYsqkj8musQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI1PR08MB3919.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(31686004)(41300700001)(26005)(86362001)(36756003)(44832011)(5660300002)(66556008)(4326008)(8936002)(316002)(8676002)(38100700002)(66476007)(66946007)(53546011)(31696002)(966005)(6486002)(6512007)(186003)(6506007)(2906002)(478600001)(6666004)(2616005)(21480400003)(83380400001)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8675
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d78abced-7ec3-4c3a-3482-08db7712927b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJmkiRpaF9QWL/4E2BcNBCenoEbtjb6J6b2I0r1KoUhu31PxMFl3WkE9DipF1I5iaxN+AU+HF6piLT2TF1AJBniPgNFAEmLMAfamUUJJBPNgacMEIGI7lcfMhlQgL2in1Cys4KzMs8mLNptNDS8RW7Ra099qCbSTeiapXRrBl5mdF9UczWcooYjHSIbqu5cNCNytbSDqoXlBlYmqKgjWOwNn0Qepqno4oe11URtzPdTmdHkzYqJrwQjxtvEFtOERhTo4Ir/Xs3Pg8t5Aa8XT/+C8+TFNxzcDFBuc5+GvRu10M3cDS20i5M3YccbRZx6RS9ggtYmzfa2T+Vwn66Rqh0nj1e3doJlp9FkSxL5bEaZpYlXRmaXaJgv2dAk/9Q8TU3IloYIS/E2BvDXR9wccwEvENqvbWI89da7HrRTmK3pvbKTj320fGwY/NMYZsw8RE3fs+fGq10kKOMD7H/4iYGgehyaR+o9jlS4clU2qT7MIbxCols7EAa0uSy6uZhoYLoIOV3R0bFIZ4pRQQqzUusrZIeNSmbS5Kha4quu2/ys5Lah5c23Ea4oPAoqoCk+WC4fQtJoCfc6wu7yODsbLgS8A5FiDn/J+0MRC1khQrEBMDFDjUiqlH4ME7os4MZ4RFqLFewCjJjqkMCbeQ/HeN/GRLxNk4hvci4exWcc/qjOtZjC+mXLRESj6aei9KCmzdK8ROIGqNOEoPzDliDVnahjH09HeukJBZNFAn+6r2SOsG6Fv1ZfqaIXm7ebl04wD0kyTz6QD/X6zBPa1GVbYlw==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(8676002)(4326008)(8936002)(70206006)(70586007)(316002)(41300700001)(6512007)(6506007)(186003)(26005)(53546011)(336012)(21480400003)(966005)(110136005)(478600001)(6666004)(6486002)(2616005)(40460700003)(82310400005)(5660300002)(2906002)(40480700001)(44832011)(82740400003)(81166007)(356005)(36756003)(31696002)(31686004)(36860700001)(86362001)(47076005)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 13:29:55.9446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebea42f1-c0e3-419d-711c-08db771298c8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6231
Received-SPF: pass client-ip=40.107.13.89; envelope-from=Luis.Machado@arm.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On 6/27/23 14:07, Peter Maydell wrote:
> On Thu, 22 Jun 2023 at 16:12, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Mirror the existing support for SVE.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
>
>> @@ -247,6 +247,61 @@ int aarch64_gdb_set_pauth_reg(CPUARMState *env, uin=
t8_t *buf, int reg)
>>      return 0;
>>  }
>>
>> +static int max_svq(ARMCPU *cpu)
>> +{
>> +    return 32 - clz32(cpu->sme_vq.map);
>> +}
>> +
>> +int aarch64_gdb_get_za_reg(CPUARMState *env, GByteArray *buf, int reg)
>> +{
>> +    ARMCPU *cpu =3D env_archcpu(env);
>> +    int max_vq =3D max_svq(cpu);
>> +    int cur_vq =3D EX_TBFLAG_A64(env->hflags, SVL) + 1;
>> +    int i;
>> +
>> +    if (reg >=3D max_vq * 16) {
>> +        return 0;
>> +    }
>> +
>> +    /* If ZA is unset, or reg out of range, the contents are zero. */
>> +    if (FIELD_EX64(env->svcr, SVCR, ZA) && reg < cur_vq * 16) {
>> +        for (i =3D 0; i < cur_vq; i++) {
>> +            gdb_get_reg128(buf, env->zarray[reg].d[i * 2 + 1],
>> +                           env->zarray[reg].d[i * 2]);
>> +        }
>> +    } else {
>> +        cur_vq =3D 0;
>> +    }
>> +
>> +    for (i =3D cur_vq; i < max_vq; i++) {
>> +        gdb_get_reg128(buf, 0, 0);
>> +    }
>> +
>> +    return max_vq * 16;
>> +}
>> +
>> +int aarch64_gdb_set_za_reg(CPUARMState *env, uint8_t *buf, int reg)
>> +{
>> +    ARMCPU *cpu =3D env_archcpu(env);
>> +    uint64_t *p =3D (uint64_t *) buf;
>> +    int max_vq =3D max_svq(cpu);
>> +    int cur_vq =3D EX_TBFLAG_A64(env->hflags, SVL) + 1;
>> +    int i;
>> +
>> +    if (reg >=3D max_vq * 16) {
>> +        return 0;
>> +    }
>> +
>> +    /* If ZA is unset, or reg out of range, the contents are zero. */
>> +    if (FIELD_EX64(env->svcr, SVCR, ZA) && reg < cur_vq * 16) {
>> +        for (i =3D 0; i < cur_vq; i++) {
>> +            env->zarray[reg].d[i * 2 + 1] =3D *p++;
>> +            env->zarray[reg].d[i * 2 + 0] =3D *p++;
>
> This looks like it won't do the right thing on a big-endian
> system. (And the existing SVE code also looks wrong.)
> The gdb_get_reg*() functions handle endianness conversion
> from the gdb data buffer; there are no equivalent gdb_set_reg*()
> functions so you have to do the byte-swapping yourself.
> (This is pretty bug-prone so maybe we should design a better
> API here :-))
>
> Compare aarch64_gdb_get/set_fpu_reg() where a gdb_get_reg128()
> is matched with a pair of ldq_le_p() and so on.
>
>> +        }
>> +    }
>> +    return max_vq * 16;
>> +}
>> +
>>  static void output_vector_union_type(GString *s, int reg_width,
>>                                       const char *name)
>>  {
>> @@ -379,3 +434,36 @@ int arm_gen_dynamic_svereg_xml(CPUState *cs, int or=
ig_base_reg)
>>      info->num =3D base_reg - orig_base_reg;
>>      return info->num;
>>  }
>> +
>> +/*
>> + * Generate the xml for SME, with matrix size set to the maximum
>> + * for the cpu.  Returns the number of registers generated.
>> + */
>> +int arm_gen_dynamic_zareg_xml(CPUState *cs, int base_reg)
>> +{
>> +    ARMCPU *cpu =3D ARM_CPU(cs);
>> +    GString *s =3D g_string_new(NULL);
>> +    int vq =3D max_svq(cpu);
>> +    int row_count =3D vq * 16;
>> +    int row_width =3D vq * 128;
>> +    int i;
>> +
>> +    g_string_printf(s, "<?xml version=3D\"1.0\"?>");
>> +    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd=
\">");
>> +    g_string_append_printf(s, "<feature name=3D\"org.qemu.gdb.aarch64.z=
a\">");

Thanks for cc-ing me in the thread Peter.

>
> The patches on the GDB end are still under review, but they
> use the feature name org.gnu.gdb.aarch64.sme:
>
> https://inbox.sourceware.org/gdb-patches/20230519102508.14020-18-luis.mac=
hado@arm.com/
> We should follow that (and only commit our end when the GDB
> spec for the XML layout is finalized.
>
> Luis kindly gave me a dump of some example XML to save us
> from trying to parse it out of the patch:
>
>   <feature name=3D"org.gnu.gdb.aarch64.sme">
>     <flags id=3D"svcr_flags" size=3D"8">
>       <field name=3D"SM" start=3D"0" end=3D"0" type=3D"bool"/>
>       <field name=3D"ZA" start=3D"1" end=3D"1" type=3D"bool"/>
>     </flags>
>     <vector id=3D"sme_bv" type=3D"uint8" count=3D"32"/>
>     <vector id=3D"sme_bvv" type=3D"sme_bv" count=3D"32"/>

Just to clarify, for convenience I've defined ZA as a 2-dimensional array o=
f bytes. That way gdb can do things like:

(gdb) p $za
$1 =3D {{0 <repeats 32 times>} <repeats 32 times>}

Or you can access a particular row or col as needed.

Here SVL is 32 bytes. So the final size of ZA is 1024 (8192 bits).

GDB will also take care of providing the numerous pseudo-registers that rea=
d/write to portions of ZA.

>     <reg name=3D"svg" bitsize=3D"64" type=3D"int" regnum=3D"91"/>

SVG is just like VG in SVE, but for SME. It is SVL / 8.

>     <reg name=3D"svcr" bitsize=3D"64" type=3D"svcr_flags" regnum=3D"92"/>

SVCR tracks the SM and ZA bits, which QEMU must provide. I haven't decided =
if we want to make that read-only or read/write. I'm tempted to make it rea=
d-only.

I haven't done any testing of bare metal ZA support yet. Please let me know=
 what you see.

>     <reg name=3D"za" bitsize=3D"8192" type=3D"sme_bvv" regnum=3D"93"/>
>   </feature>
>
>> +
>> +    output_vector_union_type(s, row_width, "zav");
>> +
>> +    for (i =3D 0; i < row_count; i++) {
>> +        g_string_append_printf(s,
>> +                               "<reg name=3D\"za%d\" bitsize=3D\"%d\""
>> +                               " regnum=3D\"%d\" type=3D\"zav\"/>",
>> +                               i, row_width, base_reg + i);
>> +    }
>> +
>> +    g_string_append_printf(s, "</feature>");
>> +
>> +    cpu->dyn_zareg_xml.num =3D row_count;
>> +    cpu->dyn_zareg_xml.desc =3D g_string_free(s, false);
>> +    return row_count;
>> +}
>
> thanks
> -- PMM

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

