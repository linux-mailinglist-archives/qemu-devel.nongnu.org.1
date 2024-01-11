Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E785E82B023
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:02:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvce-0007NI-S2; Thu, 11 Jan 2024 09:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rNvcb-0007MB-Mn
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rNvcZ-0006gI-PE
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704981681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zPTOd+26AWjSGzpNiAhcwxCvBEmSs9Fjd1XVUtc13Ts=;
 b=aChqZoYIA54iaYEezMlRdCBzwTuC3zWdsr9anJ4Q6ZGbzmZfxKr64PCygbE8ERRbeL5RIw
 v1yPs3igxu53IUb6ARzuXuPV/7iiYFVrCHI1HAF4QeNyHJvzQspVwJVaQDVK3mxwA3j1dO
 hhrNBZSY4gipQe1ZIrnGq8xPRTAV0jA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-w_SM3I-NPJ6KFj3ST8kbRw-1; Thu, 11 Jan 2024 09:01:20 -0500
X-MC-Unique: w_SM3I-NPJ6KFj3ST8kbRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73230185A787;
 Thu, 11 Jan 2024 14:01:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46D002166B31;
 Thu, 11 Jan 2024 14:01:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4D8D4180079A; Thu, 11 Jan 2024 15:01:17 +0100 (CET)
Date: Thu, 11 Jan 2024 15:01:17 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, edk2-stable@nongnu.org
Subject: Re: [PULL 0/6] Firmware/edk2 20231213 patches
Message-ID: <y2kuootd3k2tqe2245zggbuusg2kaaqrxlvxfwy2wrcbdxg3cn@zgj6tl7gd4lp>
References: <20231213105026.1944656-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213105026.1944656-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Dec 13, 2023 at 11:50:12AM +0100, Gerd Hoffmann wrote:
> The following changes since commit 9c74490bff6c8886a922008d0c9ce6cae70dd17e:
> 
>   Update version for v8.2.0-rc3 release (2023-12-06 14:34:20 -0500)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/kraxel/qemu.git tags/firmware/edk2-20231213-pull-request
> 
> for you to fetch changes up to 704f7cad5105246822686f65765ab92045f71a3b:
> 
>   tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp changes (2023-12-13 11:23:11 +0100)
> 
> ----------------------------------------------------------------
> edk2: update to git snapshot (maybe for-8.2)
> 
> This updates edk2 to git master as of today.  This picks up a patch
> (merged only yesterday, that's why this last-minute PR) which allows to
> work around a bug in shim, and enables that workaround in the qemu
> firmware builds.
> 
> This solves a real-world problem on arm hardware, walk over to
> https://gitlab.com/qemu-project/qemu/-/issues/1990 to see the details.
> 
> Merging this firmware update that close to the 8.2 release clearly is
> not without risks.  If I get a 'no', I'm not going to complain.
> 
> That said I'm not aware of any bugs, and landing this in 8.2.0 would
> make a bunch of folks hanging around in issue 1990 very happy.
> 
> Alternative plan would be to merge this after the release, give it some
> time for testing, and assuming everything goes well schedule a backport
> for 8.2.1

Ping.

As expected this missed the 8.2 boat.  Now the devel tree is open again
and people are back from xmas + new year vacations, can this be picked
up for master and eventually 8.2-stable?

thanks,
  Gerd


