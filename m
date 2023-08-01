Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C0676B65D
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:54:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQpoe-0006Ka-0Z; Tue, 01 Aug 2023 09:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qQpoX-0006KB-QD
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qQpoW-0001y1-8t
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690898007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZJgNTT3Ocx2oi6B+4sKuE59EOczSusu72+5vZ1ngHk=;
 b=JyGCFa3s7onouuWkjnJP3HA6IE1TsKCyOn68aDopTMAzxLe4b2U1UCA06uGnPZSrw18K5S
 ARJlydPHIVJtzv0Uem35oJ10RccY1O57WD4oCjhAq2pSJpiSwlFs1sG9ZPd0PU4/tNHoaI
 DhCbVY+Crhd+I19pXaszNQOJd0+pTXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-yJlGQX21NNmy0_QhBdxkLg-1; Tue, 01 Aug 2023 09:53:24 -0400
X-MC-Unique: yJlGQX21NNmy0_QhBdxkLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E3D6185A794;
 Tue,  1 Aug 2023 13:53:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F08AF2166B25;
 Tue,  1 Aug 2023 13:53:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA06821E692A; Tue,  1 Aug 2023 15:53:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Yonggang Luo
 <luoyonggang@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/8] gitlab: speed up msys windows jobs with GCC
References: <20230801130403.164060-1-berrange@redhat.com>
Date: Tue, 01 Aug 2023 15:53:22 +0200
In-Reply-To: <20230801130403.164060-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 1 Aug 2023 14:03:55
 +0100")
Message-ID: <87bkfqyilp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This is an alternative and/or complementary to Thomas' proposal
> to use CLang with msys:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05402.html
>
> First of all, the current msys installer we're using is over 12
> months out of date. Thus after running the install, pacman then
> replaces most of what we've just installed with new downloaded
> content. Using the most update installer cuts 3+1/2 minutes off
> the msys install time - 7 minutes becomes 3+1/2.
>
> Secondly, QEMU defaults to compiling with -O2 and this is more
> computationally expensive for GCC. Switching to -O0 drops the
> build time from 60 minutes down to 45 minutes.

From the fine manual[*]: "The effectiveness of some warnings depends on
optimizations also being enabled.  For example '-Wsuggest-final-types'
is more effective with link-time optimization and some instances of
other warnings may not be issued at all unless optimization is enabled.
While optimization in general improves the efficacy of control and data
flow sensitive warnings, in some cases it may also cause false
positives."  Do we care?

[...]


[*] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Warning-Options.html


