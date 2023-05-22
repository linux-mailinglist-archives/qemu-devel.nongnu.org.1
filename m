Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9449F70B799
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 10:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q10tM-0007yt-5z; Mon, 22 May 2023 04:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q10tG-0007yU-Oc
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q10tF-0004E7-0E
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684744055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d33NtvzaF3V7Bhefzz9exU87izf+jUazdx3bIrYiEE4=;
 b=Nph5eIEMkbmu/xAP58/WZrt2knJGykqCbye2UIS4dlWlp7pb5StstpbUl2I9wm4Altj0jp
 W5VKKmUSL8RLn6lM5+D4DIdxdjRVyMdu8/Adf2+QO/UdksyGlVHky6fZDa4o55gOyrnm3P
 /aeRygrC7hwIbKN1zODxbf0pnJ9J864=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-H4XN24oAN5mg8qWF0IaLoA-1; Mon, 22 May 2023 04:27:34 -0400
X-MC-Unique: H4XN24oAN5mg8qWF0IaLoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3D09185A78E
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:27:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B435B140E95D
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:27:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F3B621E692E; Mon, 22 May 2023 10:27:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/68] i386, build system, KVM changes for 2023-05-18
References: <20230518114025.1006732-1-pbonzini@redhat.com>
Date: Mon, 22 May 2023 10:27:32 +0200
In-Reply-To: <20230518114025.1006732-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 18 May 2023 13:40:24 +0200")
Message-ID: <87o7mcojnv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> The following changes since commit d27e7c359330ba7020bdbed7ed2316cb4cf6ffc1:
>
>   qapi/parser: Drop two bad type hints for now (2023-05-17 10:18:33 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to fe3ab4eb2de46076cbafcbc86b22e71ad24894c6:
>
>   docs/devel: update build system docs (2023-05-18 13:35:28 +0200)
>
> ----------------------------------------------------------------
> * kvm: enable dirty ring for arm64
> * target/i386: new features
> * target/i386: AVX fixes
> * configure: create a python venv unconditionally
> * meson: bump to 0.63.0 and move tests from configure
> * meson: Pass -j option to sphinx
> * drop support for Python 3.6

Halleluja!  Thank you both.

> * fix check-python-tox
> * fix "make clean" in the source directory


