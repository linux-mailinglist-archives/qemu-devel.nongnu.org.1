Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 027F97B8384
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:26:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3lH-0005zi-T0; Wed, 04 Oct 2023 11:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo3lE-0005tU-HF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:26:04 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo3lC-0007VJ-Sb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:26:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64FCD1F38A;
 Wed,  4 Oct 2023 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696433161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEZjIdWyBVAMMtvfjcPQc8Ynq0fLuRGnxh0rjgkoz1s=;
 b=msp7aBCskpjcXa965C+iK2lBlcKxU3iiMbESgEI/vqcIleHnchzF+D53hzobNrgRRG1ouN
 /EWF2QgZdeeWehEWf0xH5s8DbmhRWLIiB+U3NuuiewrMlqWqjTcMnY+D6kqR4NzIHUUCNN
 VriRDPScDq8KeNQFl/UC275JIha7rws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696433161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEZjIdWyBVAMMtvfjcPQc8Ynq0fLuRGnxh0rjgkoz1s=;
 b=m11zqoL5ViAdvpkLRRAtG7S2ovxLk6Z0jt4PVWYBCIzGqAZ5z6fcmItcENJ3I92UwgsKkG
 VpHZgpfB9WRFpfCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E000E13A2E;
 Wed,  4 Oct 2023 15:26:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bpg8KgiEHWWYHAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 04 Oct 2023 15:26:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v11 10/10] migration: modify test_multifd_tcp_none() to
 use new QAPI syntax.
In-Reply-To: <20231004075851.219173-11-het.gala@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-11-het.gala@nutanix.com>
Date: Wed, 04 Oct 2023 12:25:58 -0300
Message-ID: <878r8ipfy1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Het Gala <het.gala@nutanix.com> writes:

> modify multifd tcp common test to incorporate the new QAPI
> syntax defined.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qtest/migration-test.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 46f1c275a2..246cab6451 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2205,7 +2205,12 @@ test_migrate_precopy_tcp_multifd_start_common(QTes=
tState *from,
>=20=20
>      /* Start incoming migration from the 1st socket */
>      qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
> -                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' =
}}");
> +                             "  'arguments': { "
> +                             "      'channels': [ { 'channeltype': 'main=
',"

channel-type

> +                             "      'addr': { 'transport': 'socket',"
> +                             "                'type': 'inet',"
> +                             "                'host': '127.0.0.1',"
> +                             "                'port': '0' } } ] } }");
>=20=20
>      return NULL;
>  }

