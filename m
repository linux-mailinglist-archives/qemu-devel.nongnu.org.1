Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292959377D4
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jul 2024 14:39:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmtA-0004E6-I7; Fri, 19 Jul 2024 08:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUmt8-0004DE-Du
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUmt6-000106-8C
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721392742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fynezr0oBjwdqqWXwFLtbOYYnv3b9ayM7aMZSeGR7BM=;
 b=UnLTcNovCFuFNSiIsqtc/gzFJop/pIFRLtWEpixMkgia4nbHXXU3OrpcAWo/81UeG2l6an
 FGNwcYlwKXmKuWzXFH2h7/gpRxOo4/dfK2a/6EHazd5rfILEQpDQ76AXquU5y7Ci9dR49t
 xVksm8FtZ9B1NXzI2QM0x3aPjGoHkSI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-4G_AH8c0Oxiish_k4G-IBg-1; Fri,
 19 Jul 2024 08:38:59 -0400
X-MC-Unique: 4G_AH8c0Oxiish_k4G-IBg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E6771955D47; Fri, 19 Jul 2024 12:38:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13B15195605A; Fri, 19 Jul 2024 12:38:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C51A821E6757; Fri, 19 Jul 2024 14:38:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kashyap Chamarthy <kchamart@redhat.com>,
 qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Hanna Czenczek
 <hreitz@redhat.com>
Subject: Re: [PATCH v6 4/4] docs: add test for firmware.json QAPI
In-Reply-To: <20240719-qapi-firmware-json-v6-4-c2e3de390b58@linutronix.de>
 ("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Fri, 19 Jul 2024
 09:37:25 +0200")
References: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
 <20240719-qapi-firmware-json-v6-4-c2e3de390b58@linutronix.de>
Date: Fri, 19 Jul 2024 14:38:54 +0200
Message-ID: <87cyn9tv35.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:

> To make sure that the QAPI description stays valid, add a testcase.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b=
81d7@linaro.org/
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  docs/meson.build | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/docs/meson.build b/docs/meson.build
> index 9040f860ae1a..bcca45a342a3 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -99,3 +99,8 @@ if build_docs
>    alias_target('html', sphinxdocs)
>    alias_target('man', sphinxmans)
>  endif
> +
> +test('QAPI firmware.json regression tests', python,
> +     args: [qapi_gen.full_path(), '-o', meson.current_build_dir() / 'qap=
i',
> +            meson.current_source_dir() / 'interop/firmware.json'],
> +     env: test_env, suite: ['qapi-schema', 'qapi-interop'])

Acked-by: Markus Armbruster <armbru@redhat.com>


