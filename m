Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD47B2D69
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm8QX-0004g4-Uq; Fri, 29 Sep 2023 04:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm8QS-0004fE-F5
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm8QP-000209-DP
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695974436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1ZmMq13e1tTfqJlhBanbwC7V9DQbOVpT7/4fHoXAm8=;
 b=JiKKsK8BnBVV7WuVuH8lg3DOOI+isrRDgJq6MIGJP5sNY016npoD7griyoa8WDtW7rsboq
 5DHBDIsWKaliV12TniHW5lupMhYtypu8nSXdlYgOL2reY8dY7ihoFiU4nzzX9EX668qUss
 ycdc2T65yAohL/7Ro0gkB4He2ELu1eE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-3ITqmRZWPx6Pana7AFe3YA-1; Fri, 29 Sep 2023 04:00:16 -0400
X-MC-Unique: 3ITqmRZWPx6Pana7AFe3YA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70F1F858F19;
 Fri, 29 Sep 2023 08:00:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D1C9100651E;
 Fri, 29 Sep 2023 08:00:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5FC2021E6904; Fri, 29 Sep 2023 10:00:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] target/ppc: Rename variables to avoid local variable
 shadowing in VUPKPX
References: <20230923071203.1209663-1-clg@kaod.org>
 <26ec2024-d022-eb3d-8d50-37f9219fc597@tls.msk.ru>
 <f74e6a0a-b78f-8924-6abf-42cbad6c69eb@kaod.org>
Date: Fri, 29 Sep 2023 10:00:15 +0200
In-Reply-To: <f74e6a0a-b78f-8924-6abf-42cbad6c69eb@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Sat, 23 Sep 2023 17:59:35 +0200")
Message-ID: <878r8pflyo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4gd3JpdGVzOg0KDQo+IE9uIDkvMjMvMjMg
MTA6MjUsIE1pY2hhZWwgVG9rYXJldiB3cm90ZToNCj4+IDIzLjA5LjIwMjMgMTA6MTIsIEPDqWRy
aWMgTGUgR29hdGVyOg0KPj4gDQo+Pj4gLS0tIGEvdGFyZ2V0L3BwYy9pbnRfaGVscGVyLmMNCj4+
PiArKysgYi90YXJnZXQvcHBjL2ludF9oZWxwZXIuYw0KPj4+IEBAIC0yMDIyLDExICsyMDIyLDEx
IEBAIHZvaWQgaGVscGVyX3ZzdW00dWJzKENQVVBQQ1N0YXRlICplbnYsIHBwY19hdnJfdCAqciwg
cHBjX2F2cl90ICphLCBwcGNfYXZyX3QgKmIpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAo
aSA9IDA7IGkgPCBBUlJBWV9TSVpFKHItPnUzMik7IGkrKykge8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dWludDE2X3QgZSA9IGItPnUxNltoaSA/IGkgOiBpICsgNF07wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdWludDhfdCBhID0gKGUgPj4gMTUpID8gMHhmZiA6IDA7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdWludDhfdCByID0gKGUgPj4gMTApICYgMHgxZjvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHVpbnQ4X3QgX3IgPSAoZSA+PiAxMCkgJiAweDFmO8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ4X3QgZyA9IChlID4+IDUpICYgMHgxZjvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBc
DQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDhfdCBiID0gZSAmIDB4MWY7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDhfdCBfYiA9
IGUgJiAweDFmO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+IEknZCBzdWdnZXN0IHRvIHJlbmFtZSBh
bGwgb2YgdGhlbSBoZXJlIHRvIGhhdmUgdGhlIHNhbWUgcGF0dGVybi7CoCBNYXliZS4uIDopDQo+
DQo+IG9yIG1heWJlIHVzZSB0aGUgZmllbGQgbmFtZXMgZnJvbSB0aGUgSVNBIDogVlJULFZSQSxW
UkIgPw0KDQpTaG91bGQgSSBleHBlY3QgYSByZXNwaW4/DQoNCklmIG5vdCwgYW55b25lIHJlYWR5
IHRvIGdpdmUgYW4gUi1ieSBhcyBpcz8NCg==


