Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D577E54BD
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 12:13:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0gUG-0000Tl-6V; Wed, 08 Nov 2023 06:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r0gUB-0000Ta-PK
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r0gU7-0007Jd-UI
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699441952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y323cqyH+Ks9o2lMmvmtx+b9aMhN91xBoWsIJaW6gYc=;
 b=VUrATxWqoM3RV6p1FxKnMPuwRQdPPuvYlIa9sE++4TcHt7wdYCcWTp6A0PNegVWawAIBLB
 cDlzpxZ2NlPSoHKMoPRvRNne49DQ+B/StiY+wkW6I8l4Hu7jfrlD1Qo7b2dbI/BRAxkV7W
 Yo/C/NOXZrqt7dNlwHFZIhj+/gjuFGc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-Z-LG6PnnPqSslmen2r3b7A-1; Wed,
 08 Nov 2023 06:12:27 -0500
X-MC-Unique: Z-LG6PnnPqSslmen2r3b7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D45D63804511;
 Wed,  8 Nov 2023 11:12:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB988502B;
 Wed,  8 Nov 2023 11:12:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5FCA61800DE8; Wed,  8 Nov 2023 12:12:25 +0100 (CET)
Date: Wed, 8 Nov 2023 12:12:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Christopher Lentocha <christopherericlentocha@gmail.com>, 
 qemu-devel@nongnu.org, Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH] Fix Windows 2000 and XP HDAudio Support
Message-ID: <lfrzsbncmlbxoelzt4asbctne5wq7mnjtv6yo3kc6nroocxsdc@45urch4n6pi4>
References: <737e8de1-9c14-453e-35eb-bff1e6b34a4a@gmail.com>
 <1b3f57dd-7a3f-4630-b1e1-298578bbc5b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b3f57dd-7a3f-4630-b1e1-298578bbc5b7@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

On Wed, Nov 08, 2023 at 11:02:06AM +0100, Philippe Mathieu-Daudé wrote:
> Thanks Christopher for your patch,
> 
> I'm Cc'ing Volker and Gerd who know better this hardware model.
> 
> On 7/11/23 20:27, Christopher Lentocha wrote:
> > 
> > Change the ID to be a Realtek ALC885 so that both

No.  Rewriting the existing codecs is clearly a non-starter.

You can add a 'hda-realtek-alc885' variant which tries to
mimic the realtek coded close enough to make old guests
without generic hda driver happy.

> > +#define QEMU_HDA_ID 0x10EC0885

Nope.  Somemething like 'REALTEK_ALC885_ID' please.

[ remaining bits of the patch snipped, needs major rework ]

take care,
  Gerd


