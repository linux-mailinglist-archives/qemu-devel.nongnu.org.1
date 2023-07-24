Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C475F3FC
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNtEM-0007TL-PR; Mon, 24 Jul 2023 06:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qNtEK-0007Sx-7W
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qNtEI-0002Q8-OA
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690196153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HiqmcxvrRpxO4cA5WZfa6GlFaXa7LdVp6lQG0KozCBE=;
 b=VSFpavbfqaKjBM1NzHTa20GaBxGD9z133bdyDII5yfzLBxvpiu2BQrlBY+ixz29ooKs9tp
 sUAonuxlfmR4/aR6yxZXtarLYA/OznJhjJl8JKAi1AiLBagL2P8Xb6JWAbkGEw4nHKIsuP
 1+qB0gCiyBZkUSFZbjptmpTfX2qqYik=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-h1A9UL9zMU-4sNyywmtXXw-1; Mon, 24 Jul 2023 06:55:50 -0400
X-MC-Unique: h1A9UL9zMU-4sNyywmtXXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 621BC3806703;
 Mon, 24 Jul 2023 10:55:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41B7E200BA63;
 Mon, 24 Jul 2023 10:55:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27E7721E668C; Mon, 24 Jul 2023 12:55:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: richard.henderson@linaro.org,  qemu-devel@nongnu.org
Subject: Re: [PULL 0/2] QAPI patches patches for 2023-07-10
References: <20230710111959.637011-1-armbru@redhat.com>
 <87fs5h3m4s.fsf@pond.sub.org>
Date: Mon, 24 Jul 2023 12:55:49 +0200
In-Reply-To: <87fs5h3m4s.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 21 Jul 2023 06:48:51 +0200")
Message-ID: <87y1j5o9xm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Did this fall through the cracks?

Hmm, looks like Peter is taking care of merging right now.


