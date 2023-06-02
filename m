Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB6720284
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 15:03:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q54QB-0004BS-Jr; Fri, 02 Jun 2023 09:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q54Q2-00049i-3q
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 09:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q54Q0-000782-9Q
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 09:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685710931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UV68Zj2OwgSA6mx28PrU5G2xuSOfhdzwpWacfL1CTa4=;
 b=NXAesyI/vjKPQ42hJJkx7Px+v9CAO3AueKfCDTl2Xl2YAfFYMJWqXS20wyf6ikCkZi4c2t
 55gZ6KpMrzJurLQ+BQ8MB9Rcit2T36ADZtoNOLa7yZuKHbLEkI6G6AgHDzm0G1Bz6BLWVS
 7fHDxcceFu1H+0kXJdWspe/+vABR4hg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-wmtFgGX0NmiZOsU9woOLNg-1; Fri, 02 Jun 2023 09:02:09 -0400
X-MC-Unique: wmtFgGX0NmiZOsU9woOLNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A22713C0ED48
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 13:02:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8284C40C6EC4
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 13:02:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 918C721E692E; Fri,  2 Jun 2023 15:02:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Conclusion of yet another expensive UI folly
References: <20230601220305.2130121-1-eblake@redhat.com>
 <87sfbaxtkt.fsf@pond.sub.org>
 <7526ut6q6gc6ptqjsp4rctxqohvw7w6cge55jl3afzxnlmbtvx@4piwuqm5uggh>
Date: Fri, 02 Jun 2023 15:02:07 +0200
In-Reply-To: <7526ut6q6gc6ptqjsp4rctxqohvw7w6cge55jl3afzxnlmbtvx@4piwuqm5uggh>
 (Eric Blake's message of "Fri, 2 Jun 2023 07:29:38 -0500")
Message-ID: <87sfbat3u8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Eric Blake <eblake@redhat.com> writes:

> The scary part was that I found several other bugs completely
> unrelated to the read-out-of-bounds, merely by increasing unit test
> coverage.  When Hanna first pointed me to the problem asking if a
> 5-line patch would work, I was not expecting it to blow up into a
> series touching more than 1000 lines (true, most of those lines were
> in the unit tests).

You spot vermin hiding under a rock.  What will you likely see when you
lift the rock?

Thanks again for lifting the rock :)


