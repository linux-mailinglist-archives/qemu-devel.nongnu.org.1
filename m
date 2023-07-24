Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4919175F92D
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 16:01:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNw6j-0000sW-A5; Mon, 24 Jul 2023 10:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qNqFd-0004YE-BD; Mon, 24 Jul 2023 03:45:05 -0400
Received: from [2406:e500:4420:2::628]
 (helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qNqFb-000142-3P; Mon, 24 Jul 2023 03:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7feiMpnNjPZEOZHxZW+8jEvy5mWL9ntiACBI4j2dVjTqnhZpyt2EQsvZihx5YmWLzfJ3DJdsrnDQJRiH2XW+ZD5yHTEuPxiEzW5Vh3YGVYAAwAZNnfaTh1EKdXl1gqyuLPmOCg0/XPC2Hjqj9J6V+HN4Swb/G58Z4zOg1ldzK/TupzoMlMoMRev4jTRvv+ZvYdYh9njGjGqEsMMsNBim+uhaUhQPySGPRtzHas1sIYlTHiwuMCodmeRvwWMtLvH0bYeGpSXXEXJB4JfN4M5hkG3pD8LkWha/SsKO2stPAAad6z/RjQcl67fqIkz2CaFo8G4CSMw7gKJLibsnhlhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9ZZQRMUeC79aHgfGvFtpCD5ZgKxoVGKx59zP4Bm+sg=;
 b=gE77kBGNV3dXat3vZBi0+q2sCa4jWCwtzmS7qIkzGAJUenlhZjKIBRWnkhUTkLlu77uucZWLt3tAtqUg9A3q+dngbcb+eRYpYmzdsAmYFsyRkXwAeQ8OC97kmw5t9Wp4krbZIiPwcT9RWll+5WbNMNHSUTSzm0ME3+MrvnjCrElXUSC40tjRJUBqpwMZ3ARh0aJqHyF7FEjealLI25RPcjxO+fbrh8wtuH1CmH8a9EszfsdDQcGARaaUW7LYRiIzcRf9eUFiq1O0t2BuraofxQdEIguljEvst5DXCsXeZTNCuTnc6VAXXFMZ6nU6cQRVFKH2CwdqjYXCw4injWuXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=archeros.com; dmarc=pass action=none header.from=archeros.com;
 dkim=pass header.d=archeros.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=archeros.com;
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13) by ZQ0PR01MB1110.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:30:18 +0000
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 ([fe80::801d:e216:d86d:2c4d]) by
 ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn ([fe80::801d:e216:d86d:2c4d%4])
 with mapi id 15.20.6609.026; Mon, 24 Jul 2023 07:30:18 +0000
From: Evanzhang <Evanzhang@archeros.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com, Evanzhang <Evanzhang@archeros.com>
Subject: [PATCH v1] block/stream:add flush l2_table_cache,
 ensure data integrity
Date: Mon, 24 Jul 2023 15:30:03 +0800
Message-Id: <cover.1690166344.git.Evanzhang@archeros.com>
X-Mailer: git-send-email 2.9.5
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::20) To ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1015:EE_|ZQ0PR01MB1110:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6df802-0ab5-4ed8-02c0-08db8c17d473
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMTHMsxni2M6h/rBJQHWobPvdskeRVR2qn9D4VHUfERFuotoBEXrag3kC/AqfB2nzLQ5I/UXC2mopk1Zxd4t3z2ZBWTVRBx8hc6zzjvY645Zeuuocx3NGNc0vQ8mr4F1AfrFXJks9efjBF0gIFNvXT6lGdj5vrhZ5w82yTPiMIL1+KSwVJRN/Pss3SmMps7iwazfWoBSqvAnb8dPfYNVXHgaYeXLvqXhZlbw9c+4uJzUzf4sdsmx8lZ5K/bf31aybs/q274tsEtXbi9zQlbYVdR3tcDVxfpg16fahAyv9EYW/19/wCJjyYWQoKc6fodE867ruVoJpNXMsw0fXcC69X0nlNQF0JnrV8thHS+tCIrxE0o6mDAK3+qOpF3mGi5FIzGMY612PvSnbxVp3NYqum8f6OUE41ZYu+s46C93wgWc7TYF9xdc788J8CVEmrsymWv+CYwt1Lh4yIM8QiSzVx9xe905hNjGhOjnFeIzycSNC9uEz/IFw9aceCtNk9W78QJWDyFPHAcaHtjbckjmUaVnrEOiovfDQuitdjjfTwCB8TCr4MkKuEcFXD2hG/rY3JAmxbC5rS+UzXQi2u6tEWXlP04xSHqrAGg2sZ7M3IQ4nic7qIasJL9v5lTKS64cztskNW9oyVKHhRJLWHnp2RxoMBL/hRRac30PVlCiDW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(39830400003)(366004)(451199021)(83380400001)(2616005)(41300700001)(8676002)(8936002)(5660300002)(6666004)(52116002)(508600001)(107886003)(66476007)(66946007)(66556008)(4326008)(41320700001)(186003)(40180700001)(4744005)(86362001)(38100700002)(38350700002)(26005)(2906002)(40160700002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AN716clqdMLs8aAxnoCQSvf7pVJr7sHznV9Al6eF2Xy996g3W4DT1e0Trg/F?=
 =?us-ascii?Q?IaVsHkhMAHf4D5kqlzd9gWUXjfiIN9wNd+T06qDffiKIWfevj7lDdr1hZIx6?=
 =?us-ascii?Q?ByD5U5zqAYdzGzoXjkK9ae0ZRTl9ZgS07jbpVKmoLwLvoNAYCe0hLWLAzZko?=
 =?us-ascii?Q?7F2/CpnSN/e4cDvx9ZREQ5Rg5XPgl8g5qMZ++6IuCpS+JxzRKAvKdVd+h47H?=
 =?us-ascii?Q?O9rJ2LT2Hl8KVdNpB5wBFMnQ3Q7fx/Nzic4OSRv522PlW3+Nm0eTerAuSd9e?=
 =?us-ascii?Q?AZQ9WkPwYkq6Ohx4062KqeIyprS6Pj5IN+t2jNCn6q5CWaEBBKUtE5RGzmT+?=
 =?us-ascii?Q?a3jrVoXTHsjsvny1/3QVjc8C2nxraJQxMyJyUqc+z9kmYbpn7hm2UgEezW+C?=
 =?us-ascii?Q?9BjkkD0GfNPSxDxI9kvG31wrMvRlJzdHNCLwgVAnFeiswbKBzhjl0HEXjPkP?=
 =?us-ascii?Q?WM6y5Qs9KX14komkK/Ag52cnTT7+dp9QxOlrVwuYiQ2g735ZFhZ8BdZnEhYw?=
 =?us-ascii?Q?54s5/WZwFVQxDb6chO4RpQLBA0DWDvzWhF97cL/iSOl79tcLY912RuZgEQ3C?=
 =?us-ascii?Q?BznQtlsGFvlJABU16H07/77wakwvY3awf+ACzPAZ1KBmWRM1E2yJTD+Hg5fi?=
 =?us-ascii?Q?8rXS54plVb4Z5QYZRwiE7LkRxizQtQv4/hVr/Dc3iIbhNCAU+o7rU79FyD/J?=
 =?us-ascii?Q?rVeW9178mPFBUj3I2T1JM8Gjh+j8Wx814hdNFowMRdlm3ApFkdFB8okFt79A?=
 =?us-ascii?Q?koH+1JXxc9+3SdqnlL992rwm3N3HAQp+1qQMu+tNveUCTLaa3PMh3OX826yk?=
 =?us-ascii?Q?+JEX/dTIGO4O8fpDKGMCfe491uedXeQ+56KE5qYB0A5bJCLczjkM511aB5nf?=
 =?us-ascii?Q?9Bmtd9WOUDPgJHY/Dy155PDVVc+G+nL2KxyOLf91mkr6Wc/yBZDBx0R9VI1H?=
 =?us-ascii?Q?NSdZMk3bhQn5LSZoKYt8W0MPKQb8YGm4fi9qyIKrdRlyikyWSi8jZQT77pgG?=
 =?us-ascii?Q?cZ3s9QBUkJjHyCJgVon6yJoV06o4WAp2Mf2Wr3p79735LolDuKCwIZ68qKmm?=
 =?us-ascii?Q?hZj3Xw/LXMve/zbxYTwTspUCN08FuFvX1EaVayZMbz047GgXzfsmLYQ16IR3?=
 =?us-ascii?Q?dGLU/9+zNTFOeZ1Pptw6zvo31n9NQMLW3wd3LXhxXSQB9eeybhPSNrmAodIi?=
 =?us-ascii?Q?FWZfpCP/TZXwe57haKZ/NM9mfm4FFMv9s/Gbh+lY3pDE4uTFjbQwJ1A9gPof?=
 =?us-ascii?Q?E/Ql+Z/N8I+dye3JH4Ie/3huZb9mTGBXoHPMSWJKYSPoUTociay3kvMNv/OO?=
 =?us-ascii?Q?PoGtR8VO/0ciQUZRZuJgxNEmn9YS48LGmdK0kN1umH4pL3Lh6fsfDddu28dm?=
 =?us-ascii?Q?gKSL5xHzYefVYse0sBv9O0Zp1qTy1rC1jMw9Y1XUoTnaLNpKfd5SAlOIsm9N?=
 =?us-ascii?Q?EOIyCC08f4nRY0dlcerW7IcJKtGrshfa/kTRciSj10myO/SwxjofevFunzLD?=
 =?us-ascii?Q?w8KhLz8PrSjz0Zdq35HaT/BSrqMSlsh6PKK1tFj1z85egVz9hQ8TokudQGBq?=
 =?us-ascii?Q?rYHN2dea+Bi/6hktzBqlNdYf2FRFfS0XKKJ7rAoZEPTX4yB7g5CEkyanR+Tf?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: archeros.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6df802-0ab5-4ed8-02c0-08db8c17d473
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:30:18.0712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8387253c-f44a-4a28-8058-3e5c20af6b4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51gU0TIecY8pAZjdoz/e8zWYLrgqRo1URFixp7noD8PnquIxbuE7vlvJFzCqYHCJtR0E1rSea1qHddHky4BF0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1110
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2406:e500:4420:2::628
 (failed)
Received-SPF: pass client-ip=2406:e500:4420:2::628;
 envelope-from=Evanzhang@archeros.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, PDS_HP_HELO_NORDNS=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Jul 2023 10:00:13 -0400
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

Verification steps:
1.qemu-img  create -f  qcow2 data1.img 10M
  qemu-img  create -f  qcow2 -b data1.img data1.qcow2

2.write 1M data to data1.img

3.create vm  use data1.qcow2 as the data disk
  /usr/libexec/qemu-kvm -M pc,accel=kvm -smp 4 -cpu host -m 4g -drive
  file=./centos_7.5_64_20200603.qcow2,if=none,id=drive-virtio0,cache=none,
  aio=native -device virtio-blk-pci,drive=drive-virtio0,id=virtio0 -drive
  file=./data1.qcow2,if=none,id=drive-virtio1,cache=none,l2-cache-size=
  1048576,aio=native -device virtio-blk-pci,drive=drive-virtio1,id=virtio1
  -vnc :101 -qmp stdio

4.{"execute": "block-stream", "arguments":{"device":"drive-virtio1"}}

5.kill -9 $(pidof qemu-kvm)

6.md5sum data1.img data1.qcow2,check if it is the same


Evanzhang (1):
  block/stream:add flush l2_table_cache,ensure data integrity

 block/stream.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.9.5


