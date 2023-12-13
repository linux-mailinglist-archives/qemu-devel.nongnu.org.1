Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDC5811F18
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 20:41:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDV50-00022R-NH; Wed, 13 Dec 2023 14:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rDV4y-00021d-9b
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 14:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rDV4w-0000YE-NP
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 14:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702496373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pKJ2gmaWxKAK6Y/wvzA1srhiIXS0NochFPI0HVkNASs=;
 b=ExNXspjhzUkXxtfG8byjZC/KA8KG2duHqAoKMhRawhCvhwyPU9g9NaVOVwIbIqarVy822j
 Heh7W2nh+nIC3Fu6H6TcZ0RrHoSYbP5XnPcQp7HkA0Teisz1/S7OLp7RqMBgo71R7N3MPG
 2/v0HqGXzodqNSa+w8Z9Wpxtcs2OcIQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-HANLME-LOSCusGI_e2kGGg-1; Wed, 13 Dec 2023 14:39:29 -0500
X-MC-Unique: HANLME-LOSCusGI_e2kGGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E444488FC26;
 Wed, 13 Dec 2023 19:39:28 +0000 (UTC)
Received: from p1.localdomain.some.host.somewhere.org
 (ovpn-114-21.gru2.redhat.com [10.97.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 104BE1121306;
 Wed, 13 Dec 2023 19:39:20 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Radoslaw Biernacki
 <rad@semihalf.com>, Paul Durrant <paul@xen.org>, Leif Lindholm
 <quic_llindhol@quicinc.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Beraldo Leal <bleal@redhat.com>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 02/10] tests/avocado: mips: add hint for fetchasset plugin
In-Reply-To: <8717f71f-5350-45ef-9712-89c1240bc77c@daynix.com>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-3-crosa@redhat.com>
 <8717f71f-5350-45ef-9712-89c1240bc77c@daynix.com>
Date: Wed, 13 Dec 2023 14:39:05 -0500
Message-ID: <87zfydvqna.fsf@p1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2023/12/09 4:09, Cleber Rosa wrote:
>> Avocado's fetchasset plugin runs before the actual Avocado job (and
>> any test).  It analyses the test's code looking for occurrences of
>> "self.fetch_asset()" in the either the actual test or setUp() method.
>> It's not able to fully analyze all code, though.
>> 
>> The way these tests are written, make the fetchasset plugin blind to
>> the assets.  This adds redundant code, true, but one that doesn't hurt
>> the test and aids the fetchasset plugin to download or verify the
>> existence of these assets in advance.
>> 
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>
> Why not delete fetch_asset() in do_test_mips_malta32el_nanomips()?

I was trying to preserve do_test_mips_malta32el_nanomips() in such a way
that with the eventual migration to the "dependency" system in newer
Avocado, the lines added here could simply be reversed.

But, that's not a strong enough reason to justify the duplication.  I'll
follow your suggestion on v2.

Thanks!
- Cleber.


