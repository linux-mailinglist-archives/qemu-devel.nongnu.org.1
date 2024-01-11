Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 049A882B045
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:05:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvgl-00051F-OL; Thu, 11 Jan 2024 09:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNvgj-00050i-Tn
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNvgi-0000Px-GF
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704981939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFr3HAoVYQpD3igtE2tqY/5mp+kMjNs6OZtaotocYTk=;
 b=Gu3Apcq1xc8p4LzejkBup4uv4nVenjdDG/ckqu53gBMUKcqOi6SI+BchO1Qxvj4Y9ImhnZ
 TrzRe+5mzDoUdndP0Tv2zf8HdXTrGiRD6JtejcKfVIR4s4Wm2Y6kQ3cJP18g08NNbrv4yP
 PuZAl9RCI0S2KwVON3S92ZBisQ6Bouc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-uxQYkkTyOqeHnEmczfWp6w-1; Thu, 11 Jan 2024 09:05:37 -0500
X-MC-Unique: uxQYkkTyOqeHnEmczfWp6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2DAA881C82;
 Thu, 11 Jan 2024 14:05:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC5CA3C25;
 Thu, 11 Jan 2024 14:05:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6EDC21E680D; Thu, 11 Jan 2024 15:05:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Kevin Wolf <kwolf@redhat.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RESEND v3 06/10] block: Support detached LUKS header
 creation using blockdev-create
In-Reply-To: <20ab47b728492cedb7ea671239f0397a141c3f5a.1703482349.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Mon, 25 Dec 2023 13:45:08 +0800")
References: <cover.1703482349.git.yong.huang@smartx.com>
 <20ab47b728492cedb7ea671239f0397a141c3f5a.1703482349.git.yong.huang@smartx.com>
Date: Thu, 11 Jan 2024 15:05:35 +0100
Message-ID: <87o7dsufrk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

Fails to compile for me:

../block/crypto.c: In function =E2=80=98block_crypto_co_create_luks=E2=80=
=99:
../block/crypto.c:784:1: error: control reaches end of non-void function [-=
Werror=3Dreturn-type]
  784 | }
      | ^


