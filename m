Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C35227B0D11
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 22:00:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlage-0002HM-Hr; Wed, 27 Sep 2023 15:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlagc-0002H6-Vc
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:59:06 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlagb-0006jC-HX
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:59:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C3E0521845;
 Wed, 27 Sep 2023 19:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695844741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7W4vfTy0uAoAAh1WKUHGV6Dm0z5j1KY9e9zbKWBbKg=;
 b=fYUGYz9ll5/BOb7P8sOmtf8cBu4oVTQi3qYCyQPWLWhfWfEl0pAEQIUR7mVvB1CxBQHyLG
 HA4yjhfgNvDtW4RkoEbyRT+c71aIVp1vDl2jTnfRwFbFPCUHlru0fEG8UtQoEmZdU0TFNq
 CQHI9Rq/+YuR/CIBQWFgSuv4jZaQmm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695844741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7W4vfTy0uAoAAh1WKUHGV6Dm0z5j1KY9e9zbKWBbKg=;
 b=KPzMVT+bI2c3Ou57fsX6u2YHVSBOe2G36RVRYzNw5qdvTg36He9nKNsnbx1fkhMUa59x7Y
 Zg7JP6zSTFbtMdBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 581D213479;
 Wed, 27 Sep 2023 19:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xJQLCYWJFGXPcAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 27 Sep 2023 19:59:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, John Snow
 <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH] analyze-migration: ignore RAM_SAVE_FLAG_MULTIFD_FLUSH
In-Reply-To: <20230926081819.433631-1-marcandre.lureau@redhat.com>
References: <20230926081819.433631-1-marcandre.lureau@redhat.com>
Date: Wed, 27 Sep 2023 16:58:58 -0300
Message-ID: <87ttrfqtfh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Traceback (most recent call last):
>   File "scripts/analyze-migration.py", line 605, in <module>
>     dump.read(dump_memory =3D args.memory)
>   File "scripts/analyze-migration.py", line 542, in read
>     section.read()
>   File "scripts/analyze-migration.py", line 214, in read
>     raise Exception("Unknown RAM flags: %x" % flags)
> Exception: Unknown RAM flags: 200
>
> See commit 77c259a4cb ("multifd: Create property multifd-flush-after-each=
-section")
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

This is the second time this FLUSH flag has caused issues. If I figure
out how to make meson copy the script to the build dir I could add a
test for this to migration-test.c.

