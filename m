Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 146F394147D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jul 2024 16:35:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYnwk-0004XA-BJ; Tue, 30 Jul 2024 10:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYnwi-0004Oa-8Z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYnwd-0004pJ-Pd
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722350118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FoIl7pnZLKt8nid26W0BwwgLMAFf7a0+a91Pu4Hk4Y8=;
 b=TuHPAgciyysjZFqLY67utp9sAqd3dVALgvIomwk0MbmP/7uYsttBFBd2piad+cI90/DHd9
 bQRQuNbxt5BWEK6C8iWNeFfz62DezBLKFSUVY+UfXTBQV5MEpdSpo+XOQPf4SEMhUrnHhx
 sZxJ0BdZyveu1YNHl+xF7o8+EXrF/t8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-T4iU4Vj9N4-vkF_jdi51Rw-1; Tue,
 30 Jul 2024 08:26:59 -0400
X-MC-Unique: T4iU4Vj9N4-vkF_jdi51Rw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5B4D1955F0D; Tue, 30 Jul 2024 12:26:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B11A219560B2; Tue, 30 Jul 2024 12:26:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9991B21E668B; Tue, 30 Jul 2024 14:26:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  alex.williamson@redhat.com,
 andrew@codeconstruct.com.au,  andrew@daynix.com,
 arei.gonglei@huawei.com,  berto@igalia.com,  borntraeger@linux.ibm.com,
 clg@kaod.org,  david@redhat.com,  den@openvz.org,  eblake@redhat.com,
 eduardo@habkost.net,  farman@linux.ibm.com,  farosas@suse.de,
 hreitz@redhat.com,  idryomov@gmail.com,  iii@linux.ibm.com,
 jamin_lin@aspeedtech.com,  jasowang@redhat.com,  joel@jms.id.au,
 jsnow@redhat.com,  kwolf@redhat.com,  leetroy@gmail.com,
 marcandre.lureau@redhat.com,  marcel.apfelbaum@gmail.com,
 michael.roth@amd.com,  mst@redhat.com,  mtosatti@redhat.com,
 nsg@linux.ibm.com,  pasic@linux.ibm.com,  pbonzini@redhat.com,
 peter.maydell@linaro.org,  peterx@redhat.com,  philmd@linaro.org,
 pizhenwei@bytedance.com,  pl@dlhnet.de,  richard.henderson@linaro.org,
 stefanha@redhat.com,  steven_lee@aspeedtech.com,  thuth@redhat.com,
 vsementsov@yandex-team.ru,  wangyanan55@huawei.com,
 yuri.benditovich@daynix.com,  zhao1.liu@intel.com,
 qemu-block@nongnu.org,  qemu-arm@nongnu.org,  qemu-s390x@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 11/18] qapi/crypto: Rename QCryptoHashAlgorithm to
 *Algo, and drop prefix
In-Reply-To: <Zqir1y4qyp-lwyuz@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 30 Jul 2024 10:01:11 +0100")
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-12-armbru@redhat.com>
 <Zqir1y4qyp-lwyuz@redhat.com>
Date: Tue, 30 Jul 2024 14:26:49 +0200
Message-ID: <8734nrgj5i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jul 30, 2024 at 10:10:25AM +0200, Markus Armbruster wrote:
>> QAPI's 'prefix' feature can make the connection between enumeration
>> type and its constants less than obvious.  It's best used with
>> restraint.
>>=20
>> QCryptoHashAlgorithm has a 'prefix' that overrides the generated
>> enumeration constants' prefix to QCRYPTO_HASH_ALG.
>>=20
>> We could simply drop 'prefix', but then the prefix becomes
>> QCRYPTO_HASH_ALGORITHM, which is rather long.
>>=20
>> We could additionally rename the type to QCryptoHashAlg, but I think
>> the abbreviation "alg" is less than clear.
>
> I would have gone with this, but it is a bit of a bike shed colouring
> debate so I'm not fussed

Either solution seems okay, so I went with my personal preference.  Do
feel free to state yours and ask me to respin!

>> Rename the type to QCryptoHashAlgo instead.  The prefix becomes to
>> QCRYPTO_HASH_ALGO.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi/crypto.json                        | 17 +++++-----
>>  crypto/blockpriv.h                      |  2 +-
>>  crypto/hashpriv.h                       |  2 +-
>>  crypto/hmacpriv.h                       |  4 +--
>>  crypto/ivgenpriv.h                      |  2 +-
>>  include/crypto/afsplit.h                |  8 ++---
>>  include/crypto/block.h                  |  2 +-
>>  include/crypto/hash.h                   | 18 +++++-----
>>  include/crypto/hmac.h                   |  6 ++--
>>  include/crypto/ivgen.h                  |  6 ++--
>>  include/crypto/pbkdf.h                  | 10 +++---
>>  backends/cryptodev-builtin.c            |  8 ++---
>>  backends/cryptodev-lkcf.c               | 10 +++---
>>  block/parallels-ext.c                   |  2 +-
>>  block/quorum.c                          |  4 +--
>>  crypto/afsplit.c                        |  6 ++--
>>  crypto/block-luks.c                     | 16 ++++-----
>>  crypto/block.c                          |  2 +-
>>  crypto/hash-afalg.c                     | 26 +++++++--------
>>  crypto/hash-gcrypt.c                    | 20 +++++------
>>  crypto/hash-glib.c                      | 20 +++++------
>>  crypto/hash-gnutls.c                    | 20 +++++------
>>  crypto/hash-nettle.c                    | 18 +++++-----
>>  crypto/hash.c                           | 30 ++++++++---------
>>  crypto/hmac-gcrypt.c                    | 22 ++++++-------
>>  crypto/hmac-glib.c                      | 22 ++++++-------
>>  crypto/hmac-gnutls.c                    | 22 ++++++-------
>>  crypto/hmac-nettle.c                    | 22 ++++++-------
>>  crypto/hmac.c                           |  2 +-
>>  crypto/ivgen.c                          |  4 +--
>>  crypto/pbkdf-gcrypt.c                   | 36 ++++++++++----------
>>  crypto/pbkdf-gnutls.c                   | 36 ++++++++++----------
>>  crypto/pbkdf-nettle.c                   | 32 +++++++++---------
>>  crypto/pbkdf-stub.c                     |  4 +--
>>  crypto/pbkdf.c                          |  2 +-
>>  hw/misc/aspeed_hace.c                   | 16 ++++-----
>>  io/channel-websock.c                    |  2 +-
>>  target/i386/sev.c                       |  6 ++--
>>  tests/bench/benchmark-crypto-akcipher.c | 12 +++----
>>  tests/bench/benchmark-crypto-hash.c     | 10 +++---
>>  tests/bench/benchmark-crypto-hmac.c     |  6 ++--
>>  tests/unit/test-crypto-afsplit.c        | 10 +++---
>>  tests/unit/test-crypto-akcipher.c       |  6 ++--
>>  tests/unit/test-crypto-block.c          | 16 ++++-----
>>  tests/unit/test-crypto-hash.c           | 42 +++++++++++------------
>>  tests/unit/test-crypto-hmac.c           | 16 ++++-----
>>  tests/unit/test-crypto-ivgen.c          |  8 ++---
>>  tests/unit/test-crypto-pbkdf.c          | 44 ++++++++++++-------------
>>  ui/vnc.c                                |  2 +-
>>  util/hbitmap.c                          |  2 +-
>>  crypto/akcipher-gcrypt.c.inc            | 14 ++++----
>>  crypto/akcipher-nettle.c.inc            | 26 +++++++--------
>>  52 files changed, 350 insertions(+), 351 deletions(-)
>
> Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks!


