Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A156738833
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:58:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBzHx-0007TM-L3; Wed, 21 Jun 2023 10:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qBzHt-0007Sz-UC
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:58:25 -0400
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qBzHp-0007uS-Dt
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:58:25 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.35])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id D53FE2B07B;
 Wed, 21 Jun 2023 14:58:03 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 21 Jun
 2023 16:58:03 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006dd416d25-b1da-47d6-8088-695861588f76,
 909E68869DE5F343E5F9AFAFEE281BFD2240853A) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Wed, 21 Jun 2023 16:58:02 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] 9pfs: deprecate 'proxy' backend
Message-ID: <20230621165802.724bae7b@bahia>
In-Reply-To: <1802263.gKGKeHe8zJ@silver>
References: <E1q7ytt-0005Fl-JX@lizzy.crudebyte.com>
 <10417219.URJpt1F07l@silver> <20230621154136.6e1f3f4b@bahia>
 <1802263.gKGKeHe8zJ@silver>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 0a578265-68f0-4ad0-bde1-414cc8b4af55
X-Ovh-Tracer-Id: 1151514133701564826
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefkedgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhhefhudegleffffegvdejleeludethffhteeiuedtfeetleekheettdevteeugeenucffohhmrghinhepphgrthgthhgvfidrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtiedpjeekrdduleejrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheehvddpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=188.165.59.253; envelope-from=groug@kaod.org;
 helo=7.mo552.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Wed, 21 Jun 2023 16:16:46 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Wednesday, June 21, 2023 3:41:36 PM CEST Greg Kurz wrote:
> > On Wed, 21 Jun 2023 15:32:39 +0200
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > 
> > > On Thursday, June 15, 2023 11:35:05 AM CEST Christian Schoenebeck wrote:
> > > > On Saturday, June 10, 2023 3:39:44 PM CEST Christian Schoenebeck wrote:
> > > > > As recent CVE-2023-2861 once again showed, the 9p 'proxy' fs driver is 
> in
> > > > > bad shape. Using the 'proxy' backend was already discouraged for 
> safety
> > > > > reasons before and we recommended to use the 'local' backend instead,
> > > > > but now it is time to officially deprecate the 'proxy' backend.
> > > > > 
> > > > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > 
> > > Ping
> > > 
> > 
> > It seems you missed the review I posted last week :
> > 
> > https://patchew.org/QEMU/E1q7ytt-0005Fl-JX@lizzy.crudebyte.com/
> #20230612165742.3333ea08@bahia
> 
> Oh, I never received your email. I'll check the logs what happened there.
> 
> I'll send a v4 with your suggestions, they make sense.
> 
> Do you want me to add your "for the records" comments as well in the
> deprecation notice?
> 

This was more targeting qemu-devel archives or git log, but feel
free to provide relevant details in the deprecation notice.

I agree with Daniel that virtiofsd should also be mentioned as
an alternative.

> Best regards,
> Christian Schoenebeck
> 
> 

Cheers,

-- 
Greg

