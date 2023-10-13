Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678E7C8018
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:25:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDTM-0004j5-Cg; Fri, 13 Oct 2023 04:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDTJ-0004fR-Uc
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:24:37 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDTG-0005GE-Nb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697185474; x=1728721474;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VdM/aWbQFr5b5DsLVAXsLi58JVAfBd1V4BWvmfT8+XE=;
 b=Af1rF25LfYrR9368yoHIIl2gv8NreDG6nIoDA4QrAeYEuPhyHPyChKfZ
 AI0evXPDysWxCg5F7y4udLU74gDMG/C6p3orw8ZOL86VclIahVyKBGL5u
 M/ifcLICPRQ70TLh44+sIF6SCq79EYU0o7ZJaZ8oW58bksGv38kuIOdr8
 dQmC/KmD1qQYD9pbEh4AH8AinxTNN7BfxyUnYyIz+AR02m4TsrvKnQLaK
 I7Z6GTWUeIqHSkzhHjZ2LFzzyhfAQv8zseAmv1CXXRu3YffVhGdJMCE9F
 M0Q/LCYnEx6Z00N0WNezo+9QG7HBP9sCu16bDsyny91JjKiRIJUlHQqMc A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="99670378"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="99670378"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 17:24:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ61TB9clmdh7bJ9UocWELenZoenTzEpURIIFN5fvVLXhqqUJ0vTlqxHXH1aRLtoZLgmEzqImZkKM7JO4IBgWGDRbGDpzmPavBuZKIYdvzp5+lFDWF6mhUkRPsRtfqRsYCEw0/RVV2GL043+/I+JqA/wS6oinljrMZAvOKi5SwfaK7QPCLf1Uncd/jwxsBt76q6bqEAAZOk4U3lPkq2yScXQ6B/r16lMz8gf1WfORt15LhAXZ4y/SlOJbKFoSySiJ4qtYsFf/dzOmHqXOwz3K8mogG+YiAdNaZj7wB6YqphwoE07va9zT3jJs0ykB2+IiyIdNtlN+BKn1xVqnfQZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdM/aWbQFr5b5DsLVAXsLi58JVAfBd1V4BWvmfT8+XE=;
 b=CwVZb8VM139D+whkJT9ppvuUNPFlISQo6ZCAeryhTYkOXRqrEz/IYvIJ+wK5+otBobJXC58aPzSZUnAn4IZF/yNYo000WJghCMWAkoPdt+Pvnz04lxNr9wWF6ZKpgqP8ZjArAldjsZxJ07OXoFA14EaY8xBzSnnYFm/KPN3em4M+u941C++6HGdhpIHomj1KwgqjPUSHClKXiLDK7IGcLW7w7bies2ZUnoZm1+H7yTq0y62ljkmRI1aZdtx4ZYCdhJla+CwG6o7udFUYIN5pPPXis1VNe0lLldINIzDci7/e/LP10RA4nLkd/pqeW3blwKSsGg2jbGK5J/UdB7gSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OS3PR01MB9334.jpnprd01.prod.outlook.com (2603:1096:604:1ce::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:24:24 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:24:24 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 02/13] migration/rdma: Unfold
 ram_control_before_iterate()
Thread-Topic: [PATCH v3 02/13] migration/rdma: Unfold
 ram_control_before_iterate()
Thread-Index: AQHZ/IKEM66IJkjRSEG0YMZtcDnowLBHZFKA
Date: Fri, 13 Oct 2023 08:24:24 +0000
Message-ID: <7e541a8c-65e4-00c4-a8d9-c489db2da348@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-3-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-3-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OS3PR01MB9334:EE_
x-ms-office365-filtering-correlation-id: f9a56757-e63b-4775-f36b-08dbcbc5ced1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IiNR2YWniyedysSsZHSCxYFOoh3PwyrwcLjTJJwIIZAtY649hXnbRakN+RB8yT4nOL3DMaHWD5U+jjXuV0XkvLw0PQiczWIPuJNA3FfTUpRQSrZClhAsHs+FUhOe5jFIoqcMsNPcMYSX+g+gah0Tf6t+bNSuJRWoE2TjO4uO1thZR9rTyHWMPd+X/Fe1mKGA0wEEv0WwaRLS71aJe11QsjKCG1kz75V33Iyt3aL1cnDg7V126IENn/I7drmj16I+SXuyuBtG605KFXS7oEc1qVG5bl7D+6ZRn6pK+RnkaFNkY28g0++2KCm9d6xUPIUGVZ0zmFNYFLmq3EeENJyGzkJN2JN2mrNtD5oxZxJoJnh+c22IqbF2sROTEFU8rhLIwB66ORzVUeNZI3hSH8WtHsUR6006zAkG2/NNNEgjIchE3Y74cS+6jhXglFTPMtsGyc7hwBYYW9tKMu8pjNGgdkkh9+Xg1ExeyocqB8G636gfAHSalPiokAT3TC90/6SpYgQk9PLYY7q4pVz2wzoYwAbmweV6csU74W8VVsHA8su2BkVhzw0ioP5egAegef2f+k9OrMslxwcHiC/qGEVdInzxpE1lDQvod64o8y5X+F9/0Y+LS6Vpg7Sd13u+eY44A0Rh2n7H4cQN1Xn4nyZCCYkml5M93koz9ma+C0kUdySZnqGJK12DcO7SWuz9DVmUNYYrNyQYpgV/uSRA7uXNpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(1590799021)(1580799018)(6486002)(5660300002)(83380400001)(478600001)(41300700001)(71200400001)(66476007)(66946007)(64756008)(66446008)(54906003)(76116006)(85182001)(91956017)(36756003)(53546011)(6506007)(110136005)(66556008)(38100700002)(38070700005)(122000001)(82960400001)(86362001)(2616005)(31696002)(2906002)(6512007)(316002)(26005)(31686004)(8936002)(8676002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFpxSVYxQnMzT0FSVGpUeTZ6dmRuM2hGeFNpL0srbyttZnBLVUNpeitYVmp0?=
 =?utf-8?B?dTNPSlRzWnRRREpDTGVKR1BDQmE3OGZBaTNEMGF1WHhVd0J6VllTOFNrekVH?=
 =?utf-8?B?UzhySDdlSlNYRlFvSWhpTEhRMHNBY0dLNTk1ZXMyTzVtdmFreUhBY0t5Ylhx?=
 =?utf-8?B?OEZ0eks4MGFnRnJNYU83cWFSaCtwdnMxRCtnRHBldHRWaHVObnprbEVOZzgx?=
 =?utf-8?B?T1lhZWlBa2N6TWRUcUdTeVdxZmwvSllRbHBYU3pRb1lJRXc4RWpjWXF5NHNS?=
 =?utf-8?B?eTJPUXFHQ3JqcDE4eUtmOHVMeHlJck4yWmpzUzF4cjRxRFJuTEdrc3lBM29v?=
 =?utf-8?B?RjZTTWdDTENrR09vU0M5bVFjb0VpUWQzQ1dnUUxhYTNaM25FRVlsb0VpWklH?=
 =?utf-8?B?VXVJaHlHOGs2T2hFUER6cXhtVFM0UWpNUUUzOEdNN0NpZTNIK2MwUVlpN1BT?=
 =?utf-8?B?N3Q0djRNWWVtVmNObWxwbVV1QW92a3hwcEpCMmNYQW0yOWI1cHlWQlBXbkk1?=
 =?utf-8?B?WG95NkFPa2VVWHdheDRtYVhueld3eCsvaExrSHVYYi9VU0lHNGRCWFZNK3p1?=
 =?utf-8?B?L2NDbDIrL29EbE5jV3BGUzJOc2F6OUlEOTlTTXlpKzdWdnhOT3VwOHJTTmRx?=
 =?utf-8?B?S3Mwb1l0aFRJQnRHRGhVRHcvbGpEZnN6QU5VbFlTWlg4b3FoalQrMHdDaVRB?=
 =?utf-8?B?MithaVl1Y0FKbzdSQk5UemU0c2RQRnpqakxnKzA0NDZ3eCsvU2NNc1g4Sk5r?=
 =?utf-8?B?QURzRnorZGJiVGdOYW9Ba3VIWUJxY2pQTE9FUmhPTW5KRERibW9kRFAxdVZ1?=
 =?utf-8?B?TjdaQnZTZzBKWldvT2paN3R2c2lZSnlOU2hsNklZVjJCTEFCM1o2RUQrVDlt?=
 =?utf-8?B?L1F6cWNDaFI4WHhzK1p6SVZHMVBuMGFPU3JBYjhFS3JaM2k0REtCeURlRlpZ?=
 =?utf-8?B?L1Ixa3lCcjIvNVkwVmRaYWgvZUFaM1RScmp4NFlPWDdJbGc2ZG1LQzFwV0d2?=
 =?utf-8?B?QkE3UU1ETFh5UDhhc0dCeHJ2Tm5qWDBDSHptOUVhcDlPQnp3ZmRqNXU2OTdE?=
 =?utf-8?B?OVFOYWFQZDZGcWxSUHAzQW9LTU53RVRhVXJPdDlzdW9JRjJaMXlSdk1LbnpX?=
 =?utf-8?B?djRZSjRFZTBlNnd1NmdIWk9BS2UrRTJMNThzMFBhOEs3dnVpSlh1Y2RndGpR?=
 =?utf-8?B?Rm0xMEFqeXZlVmlIc0JJQVZiTENpZGdoc2JvYldObFJYZEE0b3N0bXkrU1Ev?=
 =?utf-8?B?WHZQYXBNMWIrVFM2SHVxWE9sdldJZmVtYXNzK3RUZHgyRDBaaXJSbGNjMjBv?=
 =?utf-8?B?NThzQkRqNGxEbDg4dHpXZGNreVB0WDhHMGM2ZnRES29NWkxaM1dMMVMwUE5k?=
 =?utf-8?B?bDdMYktTL2tJZEx6cndzN2k1Zk9TM055YUFZb0JwNEtWNk1wV0piaEFqQ1JX?=
 =?utf-8?B?VFFzaEVBbVdWcTFSV1pNR0hadGZpUGE2aUhVWU5aOGpiOG1oZm1VVisxcG5U?=
 =?utf-8?B?cHgvSHppak5qUmx3WTJYbUtzNkhqQzlWOW4wbEhBRUlkcXJ3c0tvVXdSRHIr?=
 =?utf-8?B?V3dmQ1ZYOG5VWXhyeXpWVVI1Q3hTMHFIT0xzZ0JPbmdUOGZqWU9nV2NQenlD?=
 =?utf-8?B?TGkyTkk1dExsTW1vTVRlQnhhK05nb0YxcitVZlpYa3FiK21jaHlndjBaWUdx?=
 =?utf-8?B?UFlZVXhSZkNNUkVKdFBxblFGMXd4T1A5QldyYXhTc2dVZzN4NUFLQkQvSnpI?=
 =?utf-8?B?MExTdlEwWTRodzdRZW5hdE9TSkVpZzR1T2FkM24va3JZNDU3V3ZkdkE3QUFV?=
 =?utf-8?B?OW5mL2hra3lsanRQWTVld3BCci8rV0VOTi9qT1NkMTlGQ3NuTi8wU3A4N1Z4?=
 =?utf-8?B?eW5wNzlOM2JqdzVnR2JKZ3dncGVYYUkycmFHcExqaWcvV29DRVZ6bWhzZWFi?=
 =?utf-8?B?QTZ4VEk5ZXE0cWpsKzVkTmNqYU03N0VVWE4xdG9Vdm9lTDU5UHZnT0tiK1kw?=
 =?utf-8?B?T3FCQWxiQ3BkNGVObmpOVE1WY0ZJRTVuems3WW1jbkIwUXBqMDJld0dxWWkx?=
 =?utf-8?B?THNrWWxTTklKbE1FNFgxSnE0SGlodTBNOVpQQWU1ZmJDWTdlcmRHbVBTVGU1?=
 =?utf-8?B?MFdEakRVTlJIdzBiYWRZNVRHcFFTb25hRVJhcU53WGJ4ZHltNit6RHZhL2VG?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D250F479A241104FA544A3218161D8B8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1dgxS/A5CeZMWPABxw7JbbNin+fnTrDEzE/X1af9SqijhBpWOStiF1mcuTfGoXpnB/7X4k1se5DY7y/S0XUATZyiuCkxbq7X6VkanZyMriglmPagP59IEND1K3BNyR8LbrHUl2wH8ZFjW/FzQNLKmiCdBm5XiGirGVBr9poY/O5SitOjUUExaYBQRZgNK9Gwbq+mki3aDJfx+F+J00gozO2VLqEqgByhfAKiKXw5/1+BUluBr+bwPjgVYIei7iY55zmP8yNcGbvF72XTq56ywsy5xTLRx9zsUTW0f9cmtiYijKMEe+gujucW2bNA4VuRIHLzypLMboqZGSbSBYzIWtwNZbnMUDWJEo3RQeoec+Nnsj5NCa3d6nJvQydq/YfS5a1iyEBaKvNTn90h5Lpzn81VHCmAXaXeGqTIt5wquMR7YYfao+3QvKryDLRxmxtEKn9ROczC/aXdzia9PuJ7VcMFII4Owuf/uKZEuO5iGEkGQ4UTLmStSl9Cns1t/LnyAyy7JpkcaQIT580DKHCkaZE1BeWBgoJ9hgufxNzYYugf6xe9l2albSsJhoTnp8S1h/WNHYVPzoaCFArd7kbR6lAtGFM0okjcpBA/kazQFyaVzJo6ERf/INfnHalBwad+Zayxn2MssMUXN9OjJpKcYCn4gYzAQBNK+k1YJz1LpOcemelefu0hv3swmUDlYy3UEP9dCSQeDZe31MECg3zI9wsSPJYb/jYqcITiyxnds2HTKWGLJkaCbl9E9Zez5Ho50Dz78jfNaV2842RJgR8lUipmmtHQbUSMrEdBccxNXJI+DhNaTfRp+HJCFOwb3IOb
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a56757-e63b-4775-f36b-08dbcbc5ced1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:24:24.1344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bQt9syDgklNwRwKWuawjgQWcsKRxgO+DOBX8AP9gHQCwLIXExN1yRB6S2kJpj31S9Lca0lzmEYNiZrTjaYwgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9334
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=lizhijian@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IE9uY2UgdGhl
cmU6DQo+IC0gUmVtb3ZlIHVudXNlZCBkYXRhIHBhcmFtZXRlcg0KPiAtIHVuZm9sZCBpdCBpbiBp
dHMgY2FsbGVycy4NCj4gLSBjaGFuZ2UgYWxsIGNhbGxlcnMgdG8gY2FsbCBxZW11X3JkbWFfcmVn
aXN0cmF0aW9uX3N0YXJ0KCkNCj4gLSBXZSBuZWVkIHRvIGNhbGwgUUlPX0NIQU5ORUxfUkRNQSgp
IGFmdGVyIHdlIGNoZWNrIGZvciBtaWdyYXRlX3JkbWEoKQ0KPiANCj4gUmV2aWV3ZWQtYnk6IFBl
dGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSnVhbiBRdWludGVs
YSA8cXVpbnRlbGFAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6
aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4gDQo+IC0tDQo+IA0KPiBpbml0aWxheml6ZSByaW9j
IGFmdGVyIGNoZWNrbmlnIHRoYXQgcmRtYSBpcyBlbmFibGVkLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSnVhbiBRdWludGVsYSA8cXVpbnRlbGFAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgbWlncmF0
aW9uL3FlbXUtZmlsZS5oIHwgIDIgLS0NCj4gICBtaWdyYXRpb24vcmRtYS5oICAgICAgfCAgNyAr
KysrKysrDQo+ICAgbWlncmF0aW9uL3FlbXUtZmlsZS5jIHwgMTMgKy0tLS0tLS0tLS0tLQ0KPiAg
IG1pZ3JhdGlvbi9yYW0uYyAgICAgICB8IDE2ICsrKysrKysrKysrKystLS0NCj4gICBtaWdyYXRp
b24vcmRtYS5jICAgICAgfCAxMiArKysrLS0tLS0tLS0NCj4gICA1IGZpbGVzIGNoYW5nZWQsIDI1
IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3Jh
dGlvbi9xZW11LWZpbGUuaCBiL21pZ3JhdGlvbi9xZW11LWZpbGUuaA0KPiBpbmRleCAwM2U3MThj
MjY0Li5kNmEzNzBjNTY5IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcWVtdS1maWxlLmgNCj4g
KysrIGIvbWlncmF0aW9uL3FlbXUtZmlsZS5oDQo+IEBAIC01NSw3ICs1NSw2IEBAIHR5cGVkZWYg
aW50IChRRU1VUmFtU2F2ZUZ1bmMpKFFFTVVGaWxlICpmLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVfdCBzaXplKTsNCj4gICANCj4gICB0eXBlZGVmIHN0cnVjdCBRRU1V
RmlsZUhvb2tzIHsNCj4gLSAgICBRRU1VUmFtSG9va0Z1bmMgKmJlZm9yZV9yYW1faXRlcmF0ZTsN
Cj4gICAgICAgUUVNVVJhbUhvb2tGdW5jICphZnRlcl9yYW1faXRlcmF0ZTsNCj4gICAgICAgUUVN
VVJhbUhvb2tGdW5jICpob29rX3JhbV9sb2FkOw0KPiAgICAgICBRRU1VUmFtU2F2ZUZ1bmMgKnNh
dmVfcGFnZTsNCj4gQEAgLTEyNyw3ICsxMjYsNiBAQCB2b2lkIHFlbXVfZmZsdXNoKFFFTVVGaWxl
ICpmKTsNCj4gICB2b2lkIHFlbXVfZmlsZV9zZXRfYmxvY2tpbmcoUUVNVUZpbGUgKmYsIGJvb2wg
YmxvY2spOw0KPiAgIGludCBxZW11X2ZpbGVfZ2V0X3RvX2ZkKFFFTVVGaWxlICpmLCBpbnQgZmQs
IHNpemVfdCBzaXplKTsNCj4gICANCj4gLXZvaWQgcmFtX2NvbnRyb2xfYmVmb3JlX2l0ZXJhdGUo
UUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZsYWdzKTsNCj4gICB2b2lkIHJhbV9jb250cm9sX2FmdGVy
X2l0ZXJhdGUoUUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZsYWdzKTsNCj4gICB2b2lkIHJhbV9jb250
cm9sX2xvYWRfaG9vayhRRU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MsIHZvaWQgKmRhdGEpOw0K
PiAgIA0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JkbWEuaCBiL21pZ3JhdGlvbi9yZG1hLmgN
Cj4gaW5kZXggZGUyYmEwOWRjNS4uNjcwYzY3YThjYiAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9u
L3JkbWEuaA0KPiArKysgYi9taWdyYXRpb24vcmRtYS5oDQo+IEBAIC0yMiw0ICsyMiwxMSBAQCB2
b2lkIHJkbWFfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKHZvaWQgKm9wYXF1ZSwgY29uc3QgY2hh
ciAqaG9zdF9wb3J0LA0KPiAgIA0KPiAgIHZvaWQgcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRp
b24oY29uc3QgY2hhciAqaG9zdF9wb3J0LCBFcnJvciAqKmVycnApOw0KPiAgIA0KPiArDQo+ICsj
aWZkZWYgQ09ORklHX1JETUENCj4gK2ludCBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX3N0YXJ0KFFF
TVVGaWxlICpmLCB1aW50NjRfdCBmbGFncyk7DQo+ICsjZWxzZQ0KPiArc3RhdGljIGlubGluZQ0K
PiAraW50IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25fc3RhcnQoUUVNVUZpbGUgKmYsIHVpbnQ2NF90
IGZsYWdzKSB7IHJldHVybiAwOyB9DQo+ICsjZW5kaWYNCj4gICAjZW5kaWYNCj4gZGlmZiAtLWdp
dCBhL21pZ3JhdGlvbi9xZW11LWZpbGUuYyBiL21pZ3JhdGlvbi9xZW11LWZpbGUuYw0KPiBpbmRl
eCA3ZmI2NTkyOTZmLi41ZTJkNzNmZDY4IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcWVtdS1m
aWxlLmMNCj4gKysrIGIvbWlncmF0aW9uL3FlbXUtZmlsZS5jDQo+IEBAIC0zMiw2ICszMiw3IEBA
DQo+ICAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ICAgI2luY2x1ZGUgIm9wdGlvbnMuaCINCj4gICAj
aW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiArI2luY2x1ZGUgInJkbWEuaCINCj4gICANCj4gICAj
ZGVmaW5lIElPX0JVRl9TSVpFIDMyNzY4DQo+ICAgI2RlZmluZSBNQVhfSU9WX1NJWkUgTUlOX0NP
TlNUKElPVl9NQVgsIDY0KQ0KPiBAQCAtMjk3LDE4ICsyOTgsNiBAQCB2b2lkIHFlbXVfZmZsdXNo
KFFFTVVGaWxlICpmKQ0KPiAgICAgICBmLT5pb3ZjbnQgPSAwOw0KPiAgIH0NCj4gICANCj4gLXZv
aWQgcmFtX2NvbnRyb2xfYmVmb3JlX2l0ZXJhdGUoUUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZsYWdz
KQ0KPiAtew0KPiAtICAgIGludCByZXQgPSAwOw0KPiAtDQo+IC0gICAgaWYgKGYtPmhvb2tzICYm
IGYtPmhvb2tzLT5iZWZvcmVfcmFtX2l0ZXJhdGUpIHsNCj4gLSAgICAgICAgcmV0ID0gZi0+aG9v
a3MtPmJlZm9yZV9yYW1faXRlcmF0ZShmLCBmbGFncywgTlVMTCk7DQo+IC0gICAgICAgIGlmIChy
ZXQgPCAwKSB7DQo+IC0gICAgICAgICAgICBxZW11X2ZpbGVfc2V0X2Vycm9yKGYsIHJldCk7DQo+
IC0gICAgICAgIH0NCj4gLSAgICB9DQo+IC19DQo+IC0NCj4gICB2b2lkIHJhbV9jb250cm9sX2Fm
dGVyX2l0ZXJhdGUoUUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZsYWdzKQ0KPiAgIHsNCj4gICAgICAg
aW50IHJldCA9IDA7DQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcmFtLmMgYi9taWdyYXRpb24v
cmFtLmMNCj4gaW5kZXggMmY1Y2U0ZDYwYi4uYWI1OTBhOTgzZiAxMDA2NDQNCj4gLS0tIGEvbWln
cmF0aW9uL3JhbS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9yYW0uYw0KPiBAQCAtNTksNiArNTksNyBA
QA0KPiAgICNpbmNsdWRlICJxZW11L2lvdi5oIg0KPiAgICNpbmNsdWRlICJtdWx0aWZkLmgiDQo+
ICAgI2luY2x1ZGUgInN5c2VtdS9ydW5zdGF0ZS5oIg0KPiArI2luY2x1ZGUgInJkbWEuaCINCj4g
ICAjaW5jbHVkZSAib3B0aW9ucy5oIg0KPiAgICNpbmNsdWRlICJzeXNlbXUvZGlydHlsaW1pdC5o
Ig0KPiAgICNpbmNsdWRlICJzeXNlbXUva3ZtLmgiDQo+IEBAIC0zMDYyLDcgKzMwNjMsMTAgQEAg
c3RhdGljIGludCByYW1fc2F2ZV9zZXR1cChRRU1VRmlsZSAqZiwgdm9pZCAqb3BhcXVlKQ0KPiAg
ICAgICAgICAgfQ0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgcmFtX2NvbnRyb2xfYmVmb3JlX2l0
ZXJhdGUoZiwgUkFNX0NPTlRST0xfU0VUVVApOw0KPiArICAgIHJldCA9IHFlbXVfcmRtYV9yZWdp
c3RyYXRpb25fc3RhcnQoZiwgUkFNX0NPTlRST0xfU0VUVVApOw0KPiArICAgIGlmIChyZXQgPCAw
KSB7DQo+ICsgICAgICAgIHFlbXVfZmlsZV9zZXRfZXJyb3IoZiwgcmV0KTsNCj4gKyAgICB9DQo+
ICAgICAgIHJhbV9jb250cm9sX2FmdGVyX2l0ZXJhdGUoZiwgUkFNX0NPTlRST0xfU0VUVVApOw0K
PiAgIA0KPiAgICAgICBtaWdyYXRpb25fb3BzID0gZ19tYWxsb2MwKHNpemVvZihNaWdyYXRpb25P
cHMpKTsNCj4gQEAgLTMxMjIsNyArMzEyNiwxMCBAQCBzdGF0aWMgaW50IHJhbV9zYXZlX2l0ZXJh
dGUoUUVNVUZpbGUgKmYsIHZvaWQgKm9wYXF1ZSkNCj4gICAgICAgICAgIC8qIFJlYWQgdmVyc2lv
biBiZWZvcmUgcmFtX2xpc3QuYmxvY2tzICovDQo+ICAgICAgICAgICBzbXBfcm1iKCk7DQo+ICAg
DQo+IC0gICAgICAgIHJhbV9jb250cm9sX2JlZm9yZV9pdGVyYXRlKGYsIFJBTV9DT05UUk9MX1JP
VU5EKTsNCj4gKyAgICAgICAgcmV0ID0gcWVtdV9yZG1hX3JlZ2lzdHJhdGlvbl9zdGFydChmLCBS
QU1fQ09OVFJPTF9ST1VORCk7DQo+ICsgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICsgICAgICAg
ICAgICBxZW11X2ZpbGVfc2V0X2Vycm9yKGYsIHJldCk7DQo+ICsgICAgICAgIH0NCj4gICANCj4g
ICAgICAgICAgIHQwID0gcWVtdV9jbG9ja19nZXRfbnMoUUVNVV9DTE9DS19SRUFMVElNRSk7DQo+
ICAgICAgICAgICBpID0gMDsNCj4gQEAgLTMyMjcsNyArMzIzNCwxMCBAQCBzdGF0aWMgaW50IHJh
bV9zYXZlX2NvbXBsZXRlKFFFTVVGaWxlICpmLCB2b2lkICpvcGFxdWUpDQo+ICAgICAgICAgICAg
ICAgbWlncmF0aW9uX2JpdG1hcF9zeW5jX3ByZWNvcHkocnMsIHRydWUpOw0KPiAgICAgICAgICAg
fQ0KPiAgIA0KPiAtICAgICAgICByYW1fY29udHJvbF9iZWZvcmVfaXRlcmF0ZShmLCBSQU1fQ09O
VFJPTF9GSU5JU0gpOw0KPiArICAgICAgICByZXQgPSBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX3N0
YXJ0KGYsIFJBTV9DT05UUk9MX0ZJTklTSCk7DQo+ICsgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+
ICsgICAgICAgICAgICBxZW11X2ZpbGVfc2V0X2Vycm9yKGYsIHJldCk7DQo+ICsgICAgICAgIH0N
Cj4gICANCj4gICAgICAgICAgIC8qIHRyeSB0cmFuc2ZlcnJpbmcgaXRlcmF0aXZlIGJsb2NrcyBv
ZiBtZW1vcnkgKi8NCj4gICANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdy
YXRpb24vcmRtYS5jDQo+IGluZGV4IGYxNTVmM2UxYzguLmE4YmZjMDUyYzQgMTAwNjQ0DQo+IC0t
LSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtMzg1
MCwxOCArMzg1MCwxNSBAQCBzdGF0aWMgaW50IHJkbWFfbG9hZF9ob29rKFFFTVVGaWxlICpmLCB1
aW50NjRfdCBmbGFncywgdm9pZCAqZGF0YSkNCj4gICAgICAgfQ0KPiAgIH0NCj4gICANCj4gLXN0
YXRpYyBpbnQgcWVtdV9yZG1hX3JlZ2lzdHJhdGlvbl9zdGFydChRRU1VRmlsZSAqZiwNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBmbGFncywgdm9p
ZCAqZGF0YSkNCj4gK2ludCBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX3N0YXJ0KFFFTVVGaWxlICpm
LCB1aW50NjRfdCBmbGFncykNCj4gICB7DQo+IC0gICAgUUlPQ2hhbm5lbFJETUEgKnJpb2MgPSBR
SU9fQ0hBTk5FTF9SRE1BKHFlbXVfZmlsZV9nZXRfaW9jKGYpKTsNCj4gLSAgICBSRE1BQ29udGV4
dCAqcmRtYTsNCj4gLQ0KPiAtICAgIGlmIChtaWdyYXRpb25faW5fcG9zdGNvcHkoKSkgew0KPiAr
ICAgIGlmICghbWlncmF0ZV9yZG1hICgpIHx8IG1pZ3JhdGlvbl9pbl9wb3N0Y29weSgpKSB7DQo+
ICAgICAgICAgICByZXR1cm4gMDsNCj4gICAgICAgfQ0KPiAgIA0KPiArICAgIFFJT0NoYW5uZWxS
RE1BICpyaW9jID0gUUlPX0NIQU5ORUxfUkRNQShxZW11X2ZpbGVfZ2V0X2lvYyhmKSk7DQo+ICAg
ICAgIFJDVV9SRUFEX0xPQ0tfR1VBUkQoKTsNCj4gLSAgICByZG1hID0gcWF0b21pY19yY3VfcmVh
ZCgmcmlvYy0+cmRtYW91dCk7DQo+ICsgICAgUkRNQUNvbnRleHQgKnJkbWEgPSBxYXRvbWljX3Jj
dV9yZWFkKCZyaW9jLT5yZG1hb3V0KTsNCj4gICAgICAgaWYgKCFyZG1hKSB7DQo+ICAgICAgICAg
ICByZXR1cm4gLTE7DQo+ICAgICAgIH0NCj4gQEAgLTQwMDIsNyArMzk5OSw2IEBAIHN0YXRpYyBj
b25zdCBRRU1VRmlsZUhvb2tzIHJkbWFfcmVhZF9ob29rcyA9IHsNCj4gICB9Ow0KPiAgIA0KPiAg
IHN0YXRpYyBjb25zdCBRRU1VRmlsZUhvb2tzIHJkbWFfd3JpdGVfaG9va3MgPSB7DQo+IC0gICAg
LmJlZm9yZV9yYW1faXRlcmF0ZSA9IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25fc3RhcnQsDQo+ICAg
ICAgIC5hZnRlcl9yYW1faXRlcmF0ZSAgPSBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX3N0b3AsDQo+
ICAgICAgIC5zYXZlX3BhZ2UgICAgICAgICAgPSBxZW11X3JkbWFfc2F2ZV9wYWdlLA0KPiAgIH07

