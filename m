Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD577A77525
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Apr 2025 09:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzVyF-0006EF-Cj; Tue, 01 Apr 2025 03:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tzVy3-0006CV-W7; Tue, 01 Apr 2025 03:23:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tzVy0-0000Is-FG; Tue, 01 Apr 2025 03:23:27 -0400
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZRfWG2hSczvWqm;
 Tue,  1 Apr 2025 15:19:06 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id BA5E8180103;
 Tue,  1 Apr 2025 15:23:05 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Apr
 2025 15:23:04 +0800
To: <armbru@redhat.com>
CC: <alex.chen@huawei.com>, <chenjianfei3@huawei.com>,
 <eric.fangyi@huawei.com>, <fam@euphon.net>, <hreitz@redhat.com>,
 <kwolf@redhat.com>, <luolongmin@huawei.com>, <mujinsheng@huawei.com>,
 <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>,
 <renxuming@huawei.com>, <stefanha@redhat.com>, <suxiaodong1@huawei.com>,
 <wangjian161@huawei.com>, <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>,
 <zhuyangyang14@huawei.com>, <zoudongjie@huawei.com>
Subject: Re: [PATCH v3 2/2] qapi/throttle: add timeout parameter for
 qmp_block_set_io_throttle()
Date: Tue, 1 Apr 2025 15:21:25 +0800
Message-ID: <20250401072125.3779920-1-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <8734ey2924.fsf@pond.sub.org>
References: <8734ey2924.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zoudongjie@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  zoudongjie <zoudongjie@huawei.com>
From:  zoudongjie via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 27 Mar 2025 09:04:51 +0100, Markus wrote:
> zoudongjie <zoudongjie@huawei.com> writes:
> 
> > On Wed, Mar 26, 2025 at 10:53:20 +0100, Markus wrote:
> >> zoudongjie via <qemu-devel@nongnu.org> writes:
> >> 
> >> > From: Zhu Yangyang <zhuyangyang14@huawei.com>
> >> >
> >> > Calling qmp_block_set_io_throttle() will be blocked for a long time
> >> > when a network disk is configured and the network failure is just about
> >> > to occur.
> 
> What other commands could similarly block?

In theory, any command may be blocked if it calls bdrv_drained_begin().
I did a quick check, qmp_block_resize() could similarly block, since it called
bdrv_drained_begin(), I'm going to verify it later.

> 
> >> > Therefore, we add a timeout parameter for qmp_block_set_io_throttle to control
> >> > its execution duration.
> >> 
> >> What's the QMP reply when a block_set_io_throttle command times out?
> >
> > The reply is:
> > {"id":"libvirt-484","error":{"class":"GenericError","desc":"Blk io limits disable timeout"}}
> 
> I find the error message confusing.  Suggest "command timed out".

This message doesn't provide more details about the error, especially for developers.
How about using "command timed out: disable I/O limits"

> 
> >> >
> >> > The default value of timeout is 0, that is infinite wait, consistent with
> >> > previous behavior.
> >> >
> >> > Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> 
> [...]

