Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC94F7B5CAB
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 23:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnQun-0000GJ-2z; Mon, 02 Oct 2023 17:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnQuh-0000Dy-69
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnQud-0000sc-Hp
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696283830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CI3IRRHXt0hZSAzfsCR7R9jGMDcV/T84wNny0Pdq1tI=;
 b=Qqw6507jccSYcz+2pfWPTNxFBD7SqlRVWH9oo7Hn6DTs5izjGeidsxsJN1dlkhWg5kvpvk
 2r31oHcbDJDUypkYDD2wovIwrAt8sJSXhEybSVSteeyjH3YpjIRWpG1Anghr+ydHZjSBA7
 B9I6HZsAICvuyZTPg3az8bf7/X7jHyU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-_o9Zt7E3O2qui7vLPT8HvA-1; Mon, 02 Oct 2023 17:56:57 -0400
X-MC-Unique: _o9Zt7E3O2qui7vLPT8HvA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 075ED101A53B;
 Mon,  2 Oct 2023 21:56:57 +0000 (UTC)
Received: from localhost (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D658493113;
 Mon,  2 Oct 2023 21:56:56 +0000 (UTC)
Date: Mon, 2 Oct 2023 17:56:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, kbastian@mail.uni-paderborn.de
Subject: Re: [PULL v3 00/16] tricore queue
Message-ID: <20231002215655.GA1077587@fedora>
References: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Cs2sZiiD3TwGh0ZO"
Content-Disposition: inline
In-Reply-To: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--Cs2sZiiD3TwGh0ZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--Cs2sZiiD3TwGh0ZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUbPKcACgkQnKSrs4Gr
c8jyxQf7BRgsn8cUm9+ThftzAJECjDG6FZl8cLP9XVofj1V71SQiX2UACfZD1DO7
Vey5c+yl5BtTpdcaMfXE+gU/f4I0vF4EJiJ9gyLSvqdn0oxQlstM4+qmNr8fM9/v
0lAV/VtMs/pO/AQrQFJgstik/gXxcm+FvXV9/XbjyhJW29nbLFHJsauYwbXsibjo
unKvchmGn5eOA4lxNteJ8FwzZ6P/wkc470O37jfcc79T/8UUISpBWhlx8j+M0o8x
CAjaAoSjuq/S75lQU5n5QH3nck8x/P+1Z5vDKME1OCbXAFNZxhxtUkDVG6sXRCyv
dC83m6MjiIViDZ6PqwdHAqB4istiSQ==
=b8EG
-----END PGP SIGNATURE-----

--Cs2sZiiD3TwGh0ZO--


