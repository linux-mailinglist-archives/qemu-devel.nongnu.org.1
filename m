Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE57B9C22
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 11:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoKdP-0006Ge-V5; Thu, 05 Oct 2023 05:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoKd3-0006Dh-Up
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoKd2-0003Jb-9s
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696498003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjBNot0+8vYQbXKOjY+vi1BdXsZlhFrgjpMphQ+jBaU=;
 b=RiM9iBXAk8MU2nk2Nj7NpdKprDlDrd3MFXUaXwGSDG9+yEx14weZy+nlSItcJKYJTxeLDl
 Ievd9gyXuGHpf5cCV4Yb7DUbhreJTPgKAjKE7va1ZkR4gVSpAdWxKnyjJjy3FX7dHXWxHO
 mA9BHkHJagqVvNY4b443d0XP3dEqzaw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-6H3cPfiXNvmSO7FJgNFTyQ-1; Thu, 05 Oct 2023 05:26:34 -0400
X-MC-Unique: 6H3cPfiXNvmSO7FJgNFTyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC2B985A5BA;
 Thu,  5 Oct 2023 09:26:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9FA6215670B;
 Thu,  5 Oct 2023 09:26:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE18E21E6904; Thu,  5 Oct 2023 11:26:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 00/22] qapi: Kill 'qapi/qmp/qerror.h' for good
References: <20231005045041.52649-1-philmd@linaro.org>
Date: Thu, 05 Oct 2023 11:26:32 +0200
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:17
 +0200")
Message-ID: <87pm1t773r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Since v1:
> - Fixed checkpatch warnings (Juan)
> - Added R-b tags
> - New patch for 'vcpu_dirty_limit'
>
> Hi,
>
> This is kind of a selfish series. I'm really tired to grep
> and read this comment from 2015 in qapi/qmp/qerror.h:
>       /*
>        * These macros will go away, please don't use
>        * in new code, and do not add new ones!
>        */
>
> Besides, these definitions are still added in recent code
> (see for example commit 09f9ec9913 from June 2023). So
> let's finish with this 8 years old technical debt.

Gee, a late birthday present for me!  Thank you!

> Overall it took me 3h: 1h to find the correct Coccinelle
> doc about Python use and read it again [*], then 1h to
> adapt the script for each patch, rest is testing and
> writing comments, so the scripts used could be used as
> reference later.

By the time you're done, it'll likely be 6h or more...


