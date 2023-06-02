Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E908A720213
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53uc-0005C3-M5; Fri, 02 Jun 2023 08:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q53ub-000597-47
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q53uZ-0006TZ-KN
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685708983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZSbYVZhZBGJWn8du4uDZaVDP4X/4yTzJvCGoybYrfss=;
 b=PpzRQDrlxbZV7slnRI1yGEcdPS4XZ2jIREKCGsEXJZruW6ZXiE4U1zZsxfZeftdocIV1Fj
 bCQyHnoG/ayTyVW+spWvhYaUjwpDIgiI2u1XxI6Dor5xiWCH4kzAmoNz8RiZusBll6Yygs
 5EOTPV7mLsAAIauos2/mmLHc4ykkEqA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-HIvKcUusPBqcqfmKfAQcTQ-1; Fri, 02 Jun 2023 08:29:41 -0400
X-MC-Unique: HIvKcUusPBqcqfmKfAQcTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F6C6801182
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 12:29:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 828E32026D49;
 Fri,  2 Jun 2023 12:29:40 +0000 (UTC)
Date: Fri, 2 Jun 2023 07:29:38 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Conclusion of yet another expensive UI folly (was: [PULL 00/21]
 NBD and miscellaneous patches for 2023-06-01)
Message-ID: <7526ut6q6gc6ptqjsp4rctxqohvw7w6cge55jl3afzxnlmbtvx@4piwuqm5uggh>
References: <20230601220305.2130121-1-eblake@redhat.com>
 <87sfbaxtkt.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfbaxtkt.fsf@pond.sub.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jun 02, 2023 at 08:32:34AM +0200, Markus Armbruster wrote:
> Pattern:
> 
> First, one of us gets a bright idea on user-friendly interface (here:
> fractional sizes like 1.5M).  Objections, if any, get brushed aside.
> 
> Then the thing sprouts warts, tentacles, sores, and starts to give off
> that sickly-sweet smell of bugs feasting on misguided ideas.
> 
> Until one of us spends a lot more time on containing and reducing the
> damage than the thing could ever be worth.
> 
> Cobbler, stick to your last.
> 
> Thanks, Eric!

The scary part was that I found several other bugs completely
unrelated to the read-out-of-bounds, merely by increasing unit test
coverage.  When Hanna first pointed me to the problem asking if a
5-line patch would work, I was not expecting it to blow up into a
series touching more than 1000 lines (true, most of those lines were
in the unit tests).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


