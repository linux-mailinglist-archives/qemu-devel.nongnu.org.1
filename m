Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0C072C5B3
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:19:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hSC-0002kR-PL; Mon, 12 Jun 2023 09:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q8hSA-0002eJ-9v; Mon, 12 Jun 2023 09:19:26 -0400
Received: from mail-bn7nam10on20723.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::723]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q8hS7-000233-So; Mon, 12 Jun 2023 09:19:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK4MmZ3bQnTd/pS17O7RK56mVAA7cLbB6p1TJyhhCuM12gNDz0i9DxkLjNkJY1+8dzWfJZk1slTPfH9TvV9c1xKEa6bvi8oqU+IottfCsxVpwBtF8zhFNxya02wrWoKK7ltePSzUFoSYCVZbB57xC+wlzHbn1vq4+2vdF1c3CF1aleyvwntfgjd7afch+eiCXjFYDDrQKSC9AzsHUF4cFEDJhLikuDuRnhgZw06F2B1cAsLXsoxB7USZEng09xlj9nlu85yPZf21qT2czmRMVVBMenBl3ahtYSTpsP0ACueW/zuv/egK9uY5kfLsgsi9Rnvm/LtUFg3PzYnl9zkizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HdAMvxn+JCluOClC99JQWOWSgSF5EfhUQWPkUPiIr8=;
 b=ApxNsvsYqcrq6JtW8SYe6Hcpz8gRsuQIX4ZUMWolbKw1qQX0ime17x8AkmXJ1a7RT/daXr9D1fN5esPdDws1oBJvYpPs8o/kp15tjOuGrWHvxD4LupOhJzO904eH8AzysPgSLtfyYZD2tJXZSXh4PVrJDLlDan1ZFrc6uzQ5KRdj3y9x3mNSZCVYVthAhM7GJaItKpXAcBpVTqaJyiz+4A/HP1C4PnmD79yyQVhc0ehgJ7avxYpEpCASRilONX4eVsJIlWm0EIPWOKQrXlCxB4lQ2aXvdhtYWonVEEVqQRWgGOED5p/uEhkOP+cJkxICX/W3Gz9+tJVxN1kUaJeZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HdAMvxn+JCluOClC99JQWOWSgSF5EfhUQWPkUPiIr8=;
 b=F4mPusd9wHRvNN7DeAtXVPPF9D7ceShzfldkRbfptx73BKudV/3UCvPSoWKt1oRCYlxA0N7gXR1JxFdFJh3tk7FTGIjIL0j276Z42q5oViq9u2M01RnnbkuZpo1kOorovM4b2FXmwsNvgo9fcJPl/XIAw+XXOmGGgaMOTNC1GjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB7124.prod.exchangelabs.com (2603:10b6:610:f3::20) by
 SA1PR01MB6560.prod.exchangelabs.com (2603:10b6:806:1aa::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Mon, 12 Jun 2023 13:19:19 +0000
Received: from CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed]) by CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed%6]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:19:19 +0000
Date: Mon, 12 Jun 2023 09:19:07 -0400
From: Aaron Lindsay <aaron@os.amperecomputing.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Vincent Dehors <vincent.dehors@smile.fr>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 2/8] target/arm: v8.3 PAC ID_AA64ISAR[12]
 feature-detection
Message-ID: <ZIcbS4__zh65Cilb@strawberry.localdomain>
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
 <20230609172324.982888-3-aaron@os.amperecomputing.com>
 <351b3a2a-6676-ea4a-d345-3ff3a5cf0d88@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <351b3a2a-6676-ea4a-d345-3ff3a5cf0d88@linaro.org>
X-ClientProxiedBy: CH0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:610:cd::6) To CH0PR01MB7124.prod.exchangelabs.com
 (2603:10b6:610:f3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7124:EE_|SA1PR01MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f68c7c-da64-4a0e-e48b-08db6b47a127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbrbY0W1KljHjsIKEpUlu8AInNn1vLwR84m8SUhWn+FwdTbxCKDsm9FhEbbuCmKa9cF386BjMafRJsOJiUjFyVdWfULVVOvT+rNcuKC5xC3QaUDxblka7132RPdnMR/KQjoiXZhxi0wOAKK4vtq9h8cZSaYANeobCSTbwM5OVrUwscppfFcmdFmt3pcN8zfk49LqAxYJiYqxsOhw+LZ5qeilfCaxyYjTk+uZhEJs1gD5fKJXMZrVs7Tdt93SRIKzkzlBY2QMc+1WH/YBvYHxIAOdhcqAPg/Ep3KTZ/23u/3dcwnw4pCbG/0gffeK904UcVWofFUb2H5N3yceFiWV7eUltAXYMOZ2heC/LfNtMO08Yp8lQA+FdMEFVpjWzi2CcLNwpbmUFz4VtsC3HLgeiOE7FB1Aj6JXRpDxd8Xvl7NXL4BPLwlPkdSLrmFhJBO74j9x3ijZ+70o9mX4yE8vgm0Xv8FsO96PfNNBIlTlbuKdS2feYd8y+DYFwjn6j8NdH34ZmvpClT6oMSVlxmIoybH26fmF3cWRNeZRtaQU8XMiS6Qyj7mklatLUn96HOQj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR01MB7124.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(366004)(376002)(346002)(136003)(396003)(451199021)(54906003)(5660300002)(4326008)(66946007)(66556008)(6916009)(8936002)(8676002)(41300700001)(316002)(4744005)(186003)(2906002)(478600001)(66476007)(6666004)(6486002)(6512007)(6506007)(53546011)(26005)(9686003)(86362001)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P55Du/yC05eIxBejSivkgnCehM+0Uu8a5CGSvLMh2Av3P3LMoaQOFcj0E4cH?=
 =?us-ascii?Q?NGnUktM5qf9hJ//ACFFOaYXVp/NG2aDXzbg3fnSUmqaAV5OEA+yrcrNSk042?=
 =?us-ascii?Q?m1FkpKXxJ6lGi9QVq59aYpUU8FN3KmkykGzBPjGvkqdye7j7quLDzrVQTqbB?=
 =?us-ascii?Q?ePuKxMwR0DXbp4yB8RZj3ILjXlziqU4kIEvg1Ht0qgBih2ZIwHl+W0cgLx3B?=
 =?us-ascii?Q?5YyVq04kwIHxy4JhQRy79KTQ85c27VbA/KML8+wRugun9qejRNvcBzrGYfq9?=
 =?us-ascii?Q?Xkrx+aRXTAStAJt/6CGfKZ7vO6TCwqT9PsG8huzhYadMDEpK8YC1jZ/lnEUg?=
 =?us-ascii?Q?bYPF6ms1HFDWbW4Na3MJFssnizuXCT7QbAWmOKjAPG8H8P8iDI51s8QI+8HH?=
 =?us-ascii?Q?3p81iJO4KRcTJWNgRaCJT0Pe21wHyuN/cDnn2H8KK77dxFpB+biojEH+TTDB?=
 =?us-ascii?Q?kQIxUIanqkHs0UtL/9f7zG1cVFAqxBoyBCHpMLgezlaADNFA9FJS5X1EROpT?=
 =?us-ascii?Q?dUPJqEDHyyPKKC0JBM1sya4ItFeok6jXrwRSsi2/Top7wNMLsL+GC2pl3rmf?=
 =?us-ascii?Q?RFbzZyc6OHnynzIDvKC+APJJFK0hBRxyWl00z1Aet8fAKZK5wwDY5ptByDN2?=
 =?us-ascii?Q?pNPzh25shvZU4p2b4oADo9bVm/5VZ+0saG1bbglJw5MgWEJxKc1Sn3r69hIH?=
 =?us-ascii?Q?usPXsEBqW32kEma/JIJSud7XYNzUqqLwRh4JXoPa2NDa0LxxEhmAhhMDAfMM?=
 =?us-ascii?Q?IC/j9X+iHDYQpbgUSxrQhyszuO9YJzLRmT2XwAg97+Pc+/VszQzk2pOHErRx?=
 =?us-ascii?Q?hhFUIC5tX6HArNlLLb71e+DF9X5Aa6QA2Gj+XFuD10X+Ggu+QBsNGKxn6GRy?=
 =?us-ascii?Q?h93l2DlmGs8WuRSkWIUWegfSBfSLyaE3degax0pfA1a+oKzQXd4GM4+gZvgY?=
 =?us-ascii?Q?W+WBNuAyKQ9Y+fg5CuFXGXoO82B5SwZBzLtAtK2Co3B+1KQpsxKgpw13vPjE?=
 =?us-ascii?Q?4GKjelN3gTDP27PHWEBRaCXFjLgqOhbUMO6PHELhSDpgQvMHljJ/BBLoA3D6?=
 =?us-ascii?Q?4AR1vOcbrqC6m81jhYQbEgTSHzG9KnJScYYYXTr2eL53cCIdIc65gg4qvyu0?=
 =?us-ascii?Q?89BUkoBf7FVre2gKQGulBvOPXwUCfqSRXW3MmNc5bUaAh/Ae4gcZ1WcVDQrF?=
 =?us-ascii?Q?p3zWBpMCSZNirGgmbr+X7qjsWNk4dy35Bb9K+M/1JLvceiDkVP4whNI/kHfn?=
 =?us-ascii?Q?sCT5u0wHyUL8EWyqEE4SDUDYpLryTehtnWoa59yzdeGKN/YJbSjWG1Wuxj+N?=
 =?us-ascii?Q?0jAiFP4ACmnMmTAO98bBODMm7clFLjTUuvjbn1X18Y4DjMvE0haC6mYApr4N?=
 =?us-ascii?Q?nmFqaanCkHsfmKAlM4YIFhUOEdW1aLeZjf1Cxlr2FWki1s3mbMEmkKDj24VX?=
 =?us-ascii?Q?kIvidOwYI8l5JrA+VG+0NDAPABKKiQ6h1eiRKEu9cM94msGD4YrtYLThRGab?=
 =?us-ascii?Q?IA7tseSPifKBkRE1aQCtTHwxepusoeer23uC43us+i5dfhJUgvVRqgbqTL4j?=
 =?us-ascii?Q?BACwrsW/+LGHNUbiKZ2ZA+r15+nD7zEEnwwuiHOqWMzCk2L3pp0GCyQE0IbP?=
 =?us-ascii?Q?pCtWlpFmGI7y9FbWxg+F8dU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f68c7c-da64-4a0e-e48b-08db6b47a127
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7124.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:19:19.4908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJl3fcfMJFobNSWEvbwaJFvOugg0ISURZoXZSid2A3a2I6NzuqFGwVmpgIdPNeu2p6GDbSc4n8/xLqPZuSfR085rlzP6BBFI8Xz28pQEMWVKE2QMUBXZ5B/68O9ezLZo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6560
Received-SPF: pass client-ip=2a01:111:f400:7e8a::723;
 envelope-from=aaron@os.amperecomputing.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Jun 09 13:51, Richard Henderson wrote:
> On 6/9/23 10:23, Aaron Lindsay wrote:
> > +static inline int isar_feature_pauth_get_features(const ARMISARegisters *id)
> > +{
> > +    if (isar_feature_aa64_pauth_arch_qarma5(id)) {
> > +        return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA);
> > +    } else if (isar_feature_aa64_pauth_arch_qarma3(id)) {
> > +        return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3);
> > +    } else {
> > +        return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, API);
> > +    }
> > +}
> 
> As I mentioned in previous review, exactly one of these fields will be
> non-zero, so you can just OR them all together without the conditionals.

Sorry I missed this last time around - I've queued this change for v4.

Thanks!

-Aaron

