Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 565967BD880
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:27:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpnTy-0002pg-Pb; Mon, 09 Oct 2023 06:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpnTX-0002kx-3X
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpnTR-0004xB-2D
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696847211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RZUQNkHU0bawLwcUs5NMVoQx/eoygF1TS/VGrR/BH8=;
 b=Pd4CXIomuHAb4YHKwinOP4ZNSsy1S76ck3/MR46HogKT5HD5FoEIEdsdJPAq813ER9D721
 fVqcV3zyQUtNbJwZQgbLcJNP0Ax+wsYk/0K39IBU5WWchQ+j3xrFQ+7JZk7YhXmGLq6pWn
 /uiSwr7CTcCtEYprapQgUqxhjE/s1Uk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-X28nbePSMx-6M29KJg4Hpg-1; Mon, 09 Oct 2023 06:26:43 -0400
X-MC-Unique: X28nbePSMx-6M29KJg4Hpg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 475A829ABA02;
 Mon,  9 Oct 2023 10:26:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25CEB492B16;
 Mon,  9 Oct 2023 10:26:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A06921E6904; Mon,  9 Oct 2023 12:26:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] system/vl: Use global &bdo_queue in configure_blockdev()
References: <20231009093152.51270-1-philmd@linaro.org>
Date: Mon, 09 Oct 2023 12:26:42 +0200
In-Reply-To: <20231009093152.51270-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 9 Oct 2023 11:31:52
 +0200")
Message-ID: <87sf6k2isd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Commit d11bf9bf0f ("vl: Factor configure_blockdev() out of main()")
> passed &bdo_queue as argument, but this isn't really necessary since
> there is only one call, so we still use the global variable.
>
> Dropping the &bdo_queue argument allows to silence this global shadow
> warning:
>
>   softmmu/vl.c:678:54: error: declaration shadows a variable in the globa=
l scope [-Werror,-Wshadow]
>   static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
>                                                        ^
>   softmmu/vl.c:172:29: note: previous declaration is here
>   static BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(bdo=
_queue);

Not sure this is an improvement.  Up to Paolo, I guess.

> Remove a spurious empty line.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>


