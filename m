Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8AB719B7B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:06:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4h3H-0007WW-G4; Thu, 01 Jun 2023 08:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4h36-0007VR-2h
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4h33-0004Q1-RW
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685621095;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YEqquOZ8Kc3JPPOx+wBhld6+OLfWGmy0iNB1gM7UAA=;
 b=BUiHVo3GcHqfk6nxymiXnYg5OAg8ayphXY6qp/ASNFVkMAQLge5Pldm19OEnfyqycwnZ4S
 fWnFoQq4ZIPjFwGDy9FaWTZFvSTZKClgwUBc5z1u7eKqsa1E8Itzo8wvoC4fiEft5jqNs/
 IlfRHMIFm5jlLzM2Nh6gO0pQdiiLS1o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-szdN_1BcOCW1UhlUV1foHg-1; Thu, 01 Jun 2023 08:04:54 -0400
X-MC-Unique: szdN_1BcOCW1UhlUV1foHg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3078b9943d6so402291f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685621093; x=1688213093;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0YEqquOZ8Kc3JPPOx+wBhld6+OLfWGmy0iNB1gM7UAA=;
 b=SrNCcsNQDRuiHPv9BD8Vfc3736kO53/mgsu1ns3XjcB5lzW0u677r0KYwO5zbfTsAC
 /ddQMQASWOWJENop6ywLROiMUSEPLq5haEjw00+u9GVw8HeQW+F94hxeBHi7leuyXnnX
 eJ5mObazz1M7A//Fwkf7WBWoWdnOWLgkiQ/jS5V9FklXcI36gzvVDUOeTZQAeJTRHgea
 ntJsgZG9v5DRRU6d4jXR2ZEOUmzfTi1OTZmSrPSUbr1V/VRHCOSmCuONMegw98CINAku
 sQLqxzrdemQqt7xK9A292Nc/wrUo4HD2NC/wLTxpercWp5QEHRQmSKLzAhYJeZeFKBRD
 SkIQ==
X-Gm-Message-State: AC+VfDwvUHa9DmlVQrdS8oUnog9ZMk/MYij+wgdsKRWVushqlipqa3NF
 mcaRrE8GLmwpelhCT7oACdsyLCxhJDSHhDTyTlL3Pv+JK3I6IfdsWHgz7S8HrwhgqW0c7sPbib3
 WsnC7y0c0WDEU6G8=
X-Received: by 2002:a5d:6a08:0:b0:30a:eac6:9d29 with SMTP id
 m8-20020a5d6a08000000b0030aeac69d29mr1896208wru.49.1685621093056; 
 Thu, 01 Jun 2023 05:04:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SxuCugHW2JOdjHk0CCy2CInQzFx5SPQPKZ+UGk6/VnGZV0rlNvyCIoTEKGNEPQjHXURU6vQ==
X-Received: by 2002:a5d:6a08:0:b0:30a:eac6:9d29 with SMTP id
 m8-20020a5d6a08000000b0030aeac69d29mr1896179wru.49.1685621092741; 
 Thu, 01 Jun 2023 05:04:52 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5d4f12000000b0030c4d8930b1sm485236wru.91.2023.06.01.05.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:04:52 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/9] tests/qtest: add various
 qtest_qmp_assert_success() variants
In-Reply-To: <20230531132400.1129576-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 31 May 2023 14:23:52
 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-2-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 14:04:51 +0200
Message-ID: <87a5xjtml8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> Add several counterparts of qtest_qmp_assert_success() that can
>
>  * Use va_list instead of ...
>  * Accept a list of FDs to send
>  * Return the response data
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qtest/libqtest.c |  99 +++++++++++++++++++++++++++++++++--
>  tests/qtest/libqtest.h | 115 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 209 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index c3a0ef5bb4..603c26d955 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1229,14 +1229,23 @@ void qtest_memset(QTestState *s, uint64_t addr, u=
int8_t pattern, size_t size)
>      qtest_rsp(s);
>  }
>=20=20
> -void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
> +void qtest_vqmp_assert_success(QTestState *qts,
> +                               const char *fmt, va_list args)
>  {
> -    va_list ap;
>      QDict *response;
>=20=20
> -    va_start(ap, fmt);
> -    response =3D qtest_vqmp(qts, fmt, ap);
> -    va_end(ap);
> +    response =3D qtest_vqmp_assert_success_ref(qts, fmt, args);
> +
> +    qobject_unref(response);
> +}
> +
> +QDict *qtest_vqmp_assert_success_ref(QTestState *qts,
> +                                     const char *fmt, va_list args)
> +{

I was about to chime in that this two functions should be declared in
reverse and see that Thomas had the same ide.

Later, Juan


