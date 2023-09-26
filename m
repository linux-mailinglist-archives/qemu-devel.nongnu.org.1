Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5367AEF28
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9bG-0003MK-DX; Tue, 26 Sep 2023 11:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql9bD-0003Ly-Ot
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql9bC-0002Ds-EI
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695740621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7N6RzPTSLUMjjqW0KDveQ/Ar72fYOTa3joNmeyE8C0=;
 b=Rfu6HTexaeF5Luo5hfvuHgxkgZ8XCRQlhr1l4E63wZfoQFH7ZsxxGjzgWZllBqs/WOMk+c
 q/tVV7I5pgNQ5Oa7pBCGfYnUwNEazn1qWyz7yLnz5LWLhkPob06qHyvX2dsgn8XcH6n1be
 2++KurCMSI+mpN8kW02LSQRK2Pk4nEM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-M7_sz3LdMA6pPPKlilobPQ-1; Tue, 26 Sep 2023 11:03:33 -0400
X-MC-Unique: M7_sz3LdMA6pPPKlilobPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 315EF858281;
 Tue, 26 Sep 2023 15:03:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EE481054FC2;
 Tue, 26 Sep 2023 15:03:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0398221E6900; Tue, 26 Sep 2023 17:03:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Brian Cain <bcain@quicinc.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Michael S. Tsirkin <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [v2] Help wanted for enabling -Wshadow=local
References: <87y1gtnggy.fsf@pond.sub.org>
Date: Tue, 26 Sep 2023 17:03:31 +0200
In-Reply-To: <87y1gtnggy.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 26 Sep 2023 16:42:37 +0200")
Message-ID: <87wmwdm0xo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Brian, Gerd, Jason, Marc-Andr=C3=A9, Michael, we need your help to enable
> -Wshadow=3Dlocal.
>
> Paolo, you already took care of several subsystems (thanks!), except you
> left a few warnings in target/i386/tcg/seg_helper.c.

Nope, I missed a patch; seg_helper.c is clean, too.

[...]


