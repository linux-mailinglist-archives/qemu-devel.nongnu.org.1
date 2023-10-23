Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AA27D2C42
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 10:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quq0I-000379-20; Mon, 23 Oct 2023 04:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amit@infradead.org>)
 id 1qupzw-00034Y-Lj
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:09:18 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amit@infradead.org>)
 id 1qupzs-0006bz-P4
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=WwcqNabniOcxw22jhCXQVj9Rfu7zBNy6e5iElUp4UP0=; b=I6boOcA8Sfl0CVBAEfrf/pvczx
 I+MgDRH3PLTTACi2BILPX68NnX+G5kJT4Pu3H1C7TZcicWh0Z+GDD7nUW+cNxpAb5OTeeDOkdK+ig
 UemtqqzyJqkfc7Jw33sNn0MQudOcEecbkABt2c1/krJOU3b1ugvdfJIkuCJ3L0io5OiZj9qGshaas
 1V32mQ+gccvQiwxzB94htQ2kJvGyp6fObyCurSRNC2tzUlRIrIzvJdm0lpiylyk7IEuVRwor+GAy9
 11EgVOrqGyIbEb0rzPavb5TBcOYV/AhMfHvqSm1/HaPP8rNmNpuu9x7D/0Tr8GPgH81DE2CZZQkxu
 rlXVGU3A==;
Received: from [45.88.97.211] (helo=[172.31.28.226])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qupzj-00CbiO-7t; Mon, 23 Oct 2023 08:09:03 +0000
Message-ID: <d0acd0d9e6dc1e73477126348816a23e18b9e931.camel@infradead.org>
Subject: Re: [PATCH v3 0/9] virtio-console: notify about the terminal size
From: Amit Shah <amit@infradead.org>
To: Filip Hejsek <filip.hejsek@gmail.com>, Szymon Lukasz
 <noh4hss@gmail.com>,  qemu-devel@nongnu.org
Cc: lvivier@redhat.com, berrange@redhat.com, amit@kernel.org,
 mst@redhat.com,  marcandre.lureau@redhat.com, pbonzini@redhat.com
Date: Mon, 23 Oct 2023 10:09:01 +0200
In-Reply-To: <3913e8227c343a5d9bfcc2ac1f01d9bd8eceac7a.camel@gmail.com>
References: <20200629164041.472528-1-noh4hss@gmail.com>
 <3913e8227c343a5d9bfcc2ac1f01d9bd8eceac7a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=amit@infradead.org; helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, 2023-10-23 at 05:12 +0200, Filip Hejsek wrote:
> I have found this 3 year old patch adding virtio console resize
> support, which seems to have been forgotten at that time. I would like
> to see this feature merged.
>=20
> Szymon, you have originally submitted this patch, would you be willing
> to update it for the latest development tree and resubmit it?
>=20
> If it turns out that Szymon doesn't want to work on this anymore for
> any reason (or doesn't respond), could I resubmit the patch myself?
> The contributing guidelines don't say anything about this. I'm
> especially unsure how to deal with Signed-off-by, as in such case I
> would be (re)submitting sombody else's work, but potentially with my
> modifications. I'm willing to update and test the patch, and if
> necessary, address any review feedback.

You should keep Szymon's SOB, mention your changes in the commit
message below that SOB and put in your own after.

	Amit

