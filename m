Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7BAAF8DB
	for <lists+qemu-devel@lfdr.de>; Thu,  8 May 2025 13:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzZz-0004nb-Ut; Thu, 08 May 2025 07:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCzZw-0004nM-CM
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCzZp-0005bu-8m
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746704287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUaYsnsVMywgMF92UWJHF+/MOCGKuZ7G7P8DPqzv680=;
 b=epfM5j0hlOvhDtmuxOfrGKsYRz/S2Ksc8dqc6MM+qekePwHeL53x/3PVWe36I/Y5knYoe1
 3A1Xcj4K6qerBW6BN/C5e8Ww/xQSo1SV4onVJPMG6reUkNGiDZWalFyNAoYzKcIqcQR+jo
 +Fot0hqq3Vu4IQDokvS9ZvWyr2Wjwqg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-_e7IRLMRPm2LlavCEKoz6g-1; Thu,
 08 May 2025 07:38:04 -0400
X-MC-Unique: _e7IRLMRPm2LlavCEKoz6g-1
X-Mimecast-MFC-AGG-ID: _e7IRLMRPm2LlavCEKoz6g_1746704283
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 849281955BF1; Thu,  8 May 2025 11:38:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C15D618001D8; Thu,  8 May 2025 11:38:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2320A21E6768; Thu, 08 May 2025 13:37:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: qemu-devel@nongnu.org,  alex.bennee@linaro.org,  philmd@linaro.org,
 armbru@redhat.com,  christian.boenig@lauterbach.com
Subject: Re: [PATCH v2 00/20] Add Multi-Core Debug (MCD) API support
In-Reply-To: <20250430052741.21145-1-mario.fleischmann@lauterbach.com> (Mario
 Fleischmann's message of "Wed, 30 Apr 2025 07:27:21 +0200")
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
Date: Thu, 08 May 2025 13:37:59 +0200
Message-ID: <87tt5ve3jc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:

> This patch series introduces support for the Multi-Core Debug (MCD) API, a
> commonly used debug interface by emulators. The MCD API, defined through a
> header file, consists of 54 functions for implementing debug and trace.
> However, since it is a header-file-only interface, MCD does not specify a
> communication protocol.
>
> To keep the overhead of a communication protocol on top of MCD minimal,
> we follow a remote procedure call approach by using QAPI as an interface
> definition and transport infrastructure. This way, we can use qapi-gen to
> take care of generating the infrastructure to dispatch MCD functions and
> to (un)marshal their arguments and results. Furthermore, qapi-doc and qtest
> provide good integration into QEMU's documentation and test frameworks.
>
> In v1 of this patch series, the MCD protocol was directly integrated in QMP
> and the QMP monitor was responsible for dispatching MCD's server stub. This
> introduced a dependency between QEMU's machine protocol and the MCD debug
> protocol which is not to be expected. For this reason, v2 introduces a MCD
> monitor which uses as much of the QMP monitor's framework as possible but
> keeps the two protocols separate from each other.
> Similarly, MCD's test suite uses as much of the qtest framework as is useful
> for sending JSON commands to the QEMU under test but adds new code where
> required to prevent dependencies to QMP.
>
> To enable MCD, configure QEMU with `--enable-mcd`.
>
> To start the MCD monitor, run QEMU with the `-mcd` option:
> qemu-system-<arch> [options] -qmp tcp::1235,server=on,wait=off

-mcd, I presume.

> To run the MCD test suite independently, start `mcd-test`:
> V=1 QTEST_QEMU_BINARY="./qemu-system-<arch> [options]" tests/qtest/mcd-test
>
> To connect from a MCD client, a client stub corresponding to this
> patch series can be found at https://gitlab.com/lauterbach/mcdrefsrv


