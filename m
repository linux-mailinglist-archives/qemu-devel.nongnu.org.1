Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 118F4896409
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Apr 2024 07:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrtCc-0004le-Hm; Wed, 03 Apr 2024 01:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rrtCZ-0004lE-SN
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 01:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rrtCY-0000xX-4X
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 01:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712122220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnO/wuA7ko2Q3gtmSQg+DCQrTVPMgoicAjUoIMS0cSs=;
 b=gZ1BvWtgD4Uunm9sF9wFQrLLpvH2vNzE1SZHvn5RXAYy9B2hvR1Zi5N0HoFB0Qu5o0eIe9
 krIg8k+hG94km8jeKkZxSvWLDvMvkp/Jk+GPEMZAz93zgK1eqzFPOoHKrDrjJj8X6HCrIy
 2ZlBi2/EZK0jy707Q8p4/V6/SoLrmMw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-F0Aqs7TyMIm-iKFKs0EMFg-1; Wed,
 03 Apr 2024 01:30:16 -0400
X-MC-Unique: F0Aqs7TyMIm-iKFKs0EMFg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F900282D3C9;
 Wed,  3 Apr 2024 05:30:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A24E492BC8;
 Wed,  3 Apr 2024 05:30:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 141D221D49CE; Wed,  3 Apr 2024 07:30:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Justinien Bouron <justinien.bouron@gmail.com>
Cc: berrange@redhat.com,  eblake@redhat.com,  eduardo@habkost.net,
 kraxel@redhat.com,  marcandre.lureau@redhat.com,  pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] input-linux: Add option to not grab a device upon
 guest startup
In-Reply-To: <20240402161804.547255-1-justinien.bouron@gmail.com> (Justinien
 Bouron's message of "Tue, 2 Apr 2024 09:18:04 -0700")
References: <20240322034311.2980970-1-justinien.bouron@gmail.com>
 <20240402161804.547255-1-justinien.bouron@gmail.com>
Date: Wed, 03 Apr 2024 07:30:11 +0200
Message-ID: <87cyr7nhcs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Justinien Bouron <justinien.bouron@gmail.com> writes:

> Just a ping to make sure this patch hasn't been lost in the noise.
> The relevant patchew page is
> https://patchew.org/QEMU/20240322034311.2980970-1-justinien.bouron@gmail.com/.
>
> Any chance to get this merged before the next release?

Since it was posted after the soft freeze, none.

https://wiki.qemu.org/Planning/9.0

You need to target 9.1, a bit over approximately four months from now.


