Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F93874A321
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 19:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHSpV-0005yF-JU; Thu, 06 Jul 2023 13:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHSpU-0005wW-44
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHSpS-0003nb-FC
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688664701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+Vxgu8Od9fJfBjd3MkLD0iEy4/a8x/KRk5OYwlhVDU=;
 b=EreOF9CHdWsThw6Hrx28ntsRanRLqL9Sq/H5JsOl2Do+Dy0/oJvBcZDb4c1/C4fZiaodyR
 6htwLZSJL6+E5JB8Rydwk8hEOHXygSyM7Xag8n4kE3ZmWabe3WFsHLIU3eyamwDVyr/UFf
 sB7ICkbkTH1DwAT3vQ9TWZFCM3MNjT0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-8XU9vvx9POihrt9QrjwerA-1; Thu, 06 Jul 2023 13:31:38 -0400
X-MC-Unique: 8XU9vvx9POihrt9QrjwerA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D1563C0E44B;
 Thu,  6 Jul 2023 17:31:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA4B840C2063;
 Thu,  6 Jul 2023 17:31:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A118421E6A1F; Thu,  6 Jul 2023 19:31:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  libvir-list@redhat.com,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Claudio Fontana <cfontana@suse.de>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH-for-8.1] accel: Remove HAX accelerator
References: <20230623230837.4194-1-philmd@linaro.org>
Date: Thu, 06 Jul 2023 19:31:35 +0200
In-Reply-To: <20230623230837.4194-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sat, 24 Jun 2023 01:08:37
 +0200")
Message-ID: <87bkgpndzc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> HAX is deprecated since commits 73741fda6c ("MAINTAINERS: Abort
> HAXM maintenance") and 90c167a1da ("docs/about/deprecated: Mark
> HAXM in QEMU as deprecated"), released in v8.0.0.
>
> Per the QEMU deprecation policy, we shouldn't remove it before
> QEMU release v8.2.0. However per the latest HAXM release (v7.8),
> the latest QEMU supported is v7.2:
>
>   Note: Up to this release, HAXM supports QEMU from 2.9.0 to 7.2.0.
>
> (https://github.com/intel/haxm/releases/tag/v7.8.0)
>
> The next commit (https://github.com/intel/haxm/commit/da1b8ec072)
> added:
>
>   HAXM v7.8.0 is our last release and we will not accept
>   pull requests or respond to issues after this.
>
> As of commit b455ce4c2f, it became very hard to build and test
> HAXM. Its previous maintainers made it clear they won't help.
> It doesn't seem to be a very good use of QEMU maintainers to
> spend their time in a dead project. Save our time by removing
> this orphan zombie code before the QEMU v8.2 release.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Your argument for short-cutting the grace period is compelling.

Acked-by: Markus Armbruster <armbru@redhat.com>


