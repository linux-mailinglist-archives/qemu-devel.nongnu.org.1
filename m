Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6A7BEC48
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 23:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpxR0-0002fu-7W; Mon, 09 Oct 2023 17:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpxQx-0002fg-ER
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 17:05:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpxQv-0003fb-PY
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 17:04:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45E4C21861;
 Mon,  9 Oct 2023 21:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696885496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pP9On0eEbe4UCCiW3SmPcI4luSe8zysiphXuL/j2bH8=;
 b=QK6V0AFf7Y37krdMeM6FP6lfnnQ/n1Wppr+2UH14ShJ4cciSz9Sq9Xow8saDTdVe0TV06l
 IVJ6VAOofU8nlc7MV8+jRRQoA5EN93uuBJTAMtKifg9lSiJ8/laGINlYDKNIvkcqt35goj
 6d7oULXYhOSLMTrBJJ9ZeDfgqM1/n78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696885496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pP9On0eEbe4UCCiW3SmPcI4luSe8zysiphXuL/j2bH8=;
 b=4VTe4VLEX8g4AABEyu+yd7LKlE1RwHtgK/17+95qJn8OijsUQb+hPisyd/i8gleV9XAje4
 bn7+G9xNPWnz15Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA92E13905;
 Mon,  9 Oct 2023 21:04:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0QLuJPdqJGXxTQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 21:04:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v12 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
In-Reply-To: <20231009143615.86825-1-het.gala@nutanix.com>
References: <20231009143615.86825-1-het.gala@nutanix.com>
Date: Mon, 09 Oct 2023 18:04:53 -0300
Message-ID: <87wmvvjymi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Het Gala <het.gala@nutanix.com> writes:

> This is v12 patchset of modified 'migrate' and 'migrate-incoming' QAPI de=
sign
> for upstream review.
>
> Would like to thank all the maintainers that actively participated in the=
 v11
> patchset discussion and gave insightful suggestions to improve the patche=
s.
>
> Link to previous upstream community patchset links:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
> v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html
> v5: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04845.html
> v6: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01251.html
> v7: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02027.html
> v8: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02770.html
> v9: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04216.html
> v10: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05022.html
> v11: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg00740.html
>
> v11 -> v12 changelog:
> -------------------
> - Resolved double-freeing when using g_autoptr in structures that are
>   nested into another.
> - Overwriting of pointers to an existing allocated memory is solved at
>   various places.
> - Use of g_autoptr caused make check errors in non-error path while going
>   out of scope inside function. Added g_steal_pointer() in the non-error
>   paths wherever required.

Please run make check before sending:
=E2=96=B6 242/355 qcow2 181  FAIL

You can also push your code to your gitlab and run a pipeline with the
branch.

